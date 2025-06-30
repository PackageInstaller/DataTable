-- @FileName:   SandPlaySceneController.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-24 20:37:52
-- @Copyright:   (LY) 2023 雷焰网络

module('game.sandPlay.controller.SandPlaySceneController', Class.impl(map.MapBaseController))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
    self.mDupTime = 0

end

--析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
    self:clearMap()
end

--游戏开始的回调
function gameStartCallBack(self)

end

--模块间事件监听
function listNotification(self)
    -- GameDispatcher:addEventListener(EventName.ENTER_NEW_MAP, self.onEnterMapHandler, self)

end

--注册server发来的数据
function registerMsgHandler(self)
    return {

    }
end

-- 开始加载前
function beforeLoad(self)
    local sceneConfig = self:getLoadSceneConfigVo()
    local loadId = 513
    if sceneConfig then
        loadId = sceneConfig.map_load_res
    end
    UIFactory:startForcibly(loadId)

end

-- function onEnterMapHandler(self, mapType)
-- if mapType ~= self:getMapType() then
--     sandPlay.SandPlayManager:setMapId(nil)
-- end
-- end

function addEventListener(self)
    GameDispatcher:addEventListener(EventName.READY_EXIT_GAME, self.clearData, self)

    GameDispatcher:addEventListener(EventName.SANDPLAY_PLAYERTHING_FINDPOINT, self.onPlayerFindPath, self)
    GameDispatcher:addEventListener(EventName.SANDPLAY_PLAYERTHING_ROTAPOINT, self.onPlayerLookPoint, self)
    GameDispatcher:addEventListener(EventName.SANDPLAY_PLAYERSTATE_MOVE, self.savePlayerScenePosOnPrefab, self)

    GameDispatcher:addEventListener(EventName.SANDPLAY_OPEN_FISHING, self.openFishing, self)
    GameDispatcher:addEventListener(EventName.SANDPLAY_EXIT_FISHING, self.exitFishing, self)
    GameDispatcher:addEventListener(EventName.SANDPLAY_CHECK_NPCTHING, self.checkNPC, self)
    GameDispatcher:addEventListener(EventName.SANDPLAY_RECEIVE_MAPEVENT_TRIGGER, self.onResponseEvent, self)
    GameDispatcher:addEventListener(EventName.SANDPLAY_OVER_MAPEVENT_TRIGGER, self.onOverEvent, self)

    mainActivity.ActiveDupManager:addEventListener(mainActivity.ActiveDupManager.EVENT_DUP_UPDATE, self.checkNPC, self)
end

function removeEventListener(self)
    GameDispatcher:removeEventListener(EventName.READY_EXIT_GAME, self.clearData, self)

    GameDispatcher:removeEventListener(EventName.SANDPLAY_PLAYERTHING_FINDPOINT, self.onPlayerFindPath, self)
    GameDispatcher:removeEventListener(EventName.SANDPLAY_PLAYERTHING_ROTAPOINT, self.onPlayerLookPoint, self)
    GameDispatcher:removeEventListener(EventName.SANDPLAY_PLAYERSTATE_MOVE, self.savePlayerScenePosOnPrefab, self)

    GameDispatcher:removeEventListener(EventName.SANDPLAY_OPEN_FISHING, self.openFishing, self)
    GameDispatcher:removeEventListener(EventName.SANDPLAY_EXIT_FISHING, self.exitFishing, self)
    GameDispatcher:removeEventListener(EventName.SANDPLAY_CHECK_NPCTHING, self.checkNPC, self)
    GameDispatcher:removeEventListener(EventName.SANDPLAY_RECEIVE_MAPEVENT_TRIGGER, self.onResponseEvent, self)
    GameDispatcher:removeEventListener(EventName.SANDPLAY_OVER_MAPEVENT_TRIGGER, self.onOverEvent, self)

    mainActivity.ActiveDupManager:removeEventListener(mainActivity.ActiveDupManager.EVENT_DUP_UPDATE, self.checkNPC, self)
end

-- 加载场景完的调用
function enterMap(self)
    super.enterMap(self)

    local nextMapId = sandPlay.SandPlayManager:getNextMapId()
    if nextMapId then
        sandPlay.SandPlayManager:setMapId(nextMapId)
        sandPlay.SandPlayManager:setNextMapId(nil)
    end

    if not self:getSceneConfigVo() then
        logError("拿不到场景配置")
        return
    end

    self:addEventListener()
    self:initScene()
end

function initScene(self)
    local heroVo = self:getSceneConfigVo():getHeroVo()

    if self.mPlayerThing then
        self.mPlayerThing:recover()
        self.mPlayerThing = nil
    end

    if gs.Application.isEditor then
        sandPlay.SandPlayPlayerThing = require("game/sandPlay/manager/thing/SandPlayPlayerThing")
    end

    self.mPlayerThing = sandPlay.SandPlayPlayerThing:create(heroVo, function (thing)
        self:initNpc()
        self.mCheckTimer = LoopManager:addTimer(30, -1, self, self.checkNPC)

        sandPlay.SandPlayManager:setPlayerThingScenePos(nil)
    end)
end

function initNpc(self)
    if not self:getSceneConfigVo() then
        return
    end

    self.mNPCThingList = {}
    local npc_configlist = {}

    local clientTime = GameManager:getClientTime()
    for npc_id, npcConfig in pairs(self:getSceneConfigVo().npcList) do
        if npc_id ~= SandPlayConst.UINPC_ID then
            local isShow = true
            if npcConfig.show_Dt ~= 0 then
                isShow = clientTime >= npcConfig.show_Dt
            end

            if isShow and npcConfig.hide_Dt ~= 0 then
                isShow = clientTime < npcConfig.hide_Dt
            end

            if isShow and not table.empty(npcConfig.show_condition) then
                isShow = SandPlayConst.NPCConditionPass(npcConfig.show_condition)
            end

            if isShow and not table.empty(npcConfig.hide_condition) then
                isShow = not SandPlayConst.NPCConditionPass(npcConfig.hide_condition)
            end

            if isShow then
                table.insert(npc_configlist, npcConfig)
            end
        end
    end

    local create_count = 0
    for _, npcConfig in pairs(npc_configlist) do
        local thinClase = self:getNPCThingClass(npcConfig.base_config.type)
        thing = thinClase:create({bornPos = npcConfig.pos, bornAngle = npcConfig.angle, config = npcConfig, id = npcConfig.id}, function (_thing)
            GameDispatcher:dispatchEvent(EventName.SANDPLAY_NPC_ADD, _thing)

            create_count = create_count + 1
            if create_count >= table.nums(npc_configlist) then
                self:initCamera()

                --打开主界面UI
                GameDispatcher:dispatchEvent(EventName.OPEN_SANDPLAY_SCENEUI)

                -- 通知打开战斗前的功能UI
                GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_SHOW_BEFORE_UI)
                local linkCode = sandPlay.SandPlayManager:getLinkCode()
                if linkCode then
                    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = linkCode})
                    sandPlay.SandPlayManager:setLinkCode(nil)
                end

                UIFactory:closeForcibly()
            end
        end)

        self.mNPCThingList[npcConfig.id] = thing
    end
end

function checkNPC(self)
    if not self:getSceneConfigVo() then
        return
    end

    if self.mNPCThingList == nil then
        self.mNPCThingList = {}
    end

    local clientTime = GameManager:getClientTime()
    for npc_id, npcConfig in pairs(self:getSceneConfigVo().npcList) do
        if npc_id ~= SandPlayConst.UINPC_ID then
            local isShow = true
            if npcConfig.show_Dt ~= 0 then
                isShow = clientTime >= npcConfig.show_Dt
            end

            if isShow and npcConfig.hide_Dt ~= 0 then
                isShow = clientTime < npcConfig.hide_Dt
            end

            if isShow and not table.empty(npcConfig.show_condition) then
                isShow = SandPlayConst.NPCConditionPass(npcConfig.show_condition)
            end

            if isShow and not table.empty(npcConfig.hide_condition) then
                isShow = not SandPlayConst.NPCConditionPass(npcConfig.hide_condition)
            end

            local thing = self.mNPCThingList[npcConfig.id]
            if thing == nil then
                if isShow then
                    local thinClase = self:getNPCThingClass(npcConfig.base_config.type)
                    thing = thinClase:create({bornPos = npcConfig.pos, bornAngle = npcConfig.angle, config = npcConfig, id = npcConfig.id}, function (_thing)
                        GameDispatcher:dispatchEvent(EventName.SANDPLAY_NPC_ADD, _thing)
                    end)

                    self.mNPCThingList[npcConfig.id] = thing
                end
            else
                if not isShow then
                    self:deleteNPC(sandPlay.SandPlayManager:getMapId(), npcConfig.id)
                end
            end
        end
    end
end

function getNPCThingClass(self, npc_type)
    if npc_type == SandPlayConst.NPC_TYPE.ROLE or npc_type == SandPlayConst.NPC_TYPE.MONSTER then
        return sandPlay.SandPlayRoleNPCThing
    elseif npc_type == SandPlayConst.NPC_TYPE.TREASURE_BOX then
        return sandPlay.SandPlayTreasureBoxThing
    elseif npc_type == SandPlayConst.NPC_TYPE.DOOR then
        return sandPlay.SandPlayDoorThing
    elseif npc_type == SandPlayConst.NPC_TYPE.FIELD then
        return sandPlay.SandPlayFieldThing
    elseif npc_type == SandPlayConst.NPC_TYPE.BREED then
        return sandPlay.SandPlayBreedThing
    elseif npc_type == SandPlayConst.NPC_TYPE.POULTRYREAP then
        return sandPlay.SandPlayPoultryReapThing
    else
        return sandPlay.SandPlayOtherNPCThing
    end
end

--清除场景事件
function deleteNPC(self, map_id, npc_id)
    if map_id ~= sandPlay.SandPlayManager:getMapId() then
        return
    end
    local NPCThing = self.mNPCThingList[npc_id]
    if NPCThing then
        NPCThing:recover()
        self.mNPCThingList[npc_id] = nil

        GameDispatcher:dispatchEvent(EventName.SANDPLAY_NPC_REMOVE, npc_id)
    end
end

--事件执行完毕回调
function onResponseEvent(self, args)
    if not self:getSceneConfigVo() then
        return
    end

    for npc_id, npcConfig in pairs(self:getSceneConfigVo().npcList) do
        if npc_id ~= SandPlayConst.UINPC_ID then
            if not table.empty(npcConfig.pre_event) then
                for _, eventInfo in pairs(npcConfig.pre_event) do
                    local _npc_id = eventInfo[1]
                    local _event_id = eventInfo[2]
                    if sandPlay.SandPlayManager:getMapEventIsPass(nil, _npc_id, _event_id) then
                        for k, eventConfig in pairs(npcConfig.base_config.event_ConfigVoList) do
                            if eventConfig.trigger_type == SandPlayConst.Event_trigger_Type.Auto then
                                SandPlayConst.ExecuteEvent(eventConfig, npc_id)
                            end
                        end
                    end
                end
            end
        end
    end

    SandPlayConst.ResponseEvent(args.map_id, args.npc_id, args.event_id)
end
--事件结束回调
function onOverEvent(self, args)
    SandPlayConst.OverEvent(args.event_id)
end

--进入钓鱼
function openFishing(self, eventConfig)
    if gs.Application.isEditor then
        sandPlay.SandPlayFishingUtil = require("game/sandPlay/manager/SandPlayFishingUtil")
    end
    self.mFishUtil = sandPlay.SandPlayFishingUtil.new()
    self.mFishUtil:active()
    self.mFishUtil:onStartFish(self.mPlayerThing, self.mCamera, eventConfig)
end

function clearFishUtil(self)
    if self.mFishUtil then
        self.mFishUtil:deActive()
        self.mFishUtil = nil
    end
end

--退出钓鱼
function exitFishing(self)
    if self.mFishUtil then
        self.mFishUtil:onExitFish()
    end

    self:clearFishUtil()
end

----------------------------------------相机
function initCamera(self)
    if gs.Application.isEditor then
        sandPlay.SandPlayCamera = require("game/sandPlay/manager/SandPlayCamera")
    end
    self.mCamera = sandPlay.SandPlayCamera.new()
    local sceneConfig = self:getSceneConfigVo()
    self.mCamera:initCamera(sceneConfig.camera_distance[1], sceneConfig.camera_distance[2], sceneConfig.camera_distance[3], sceneConfig.camera_rotation[1], sceneConfig.camera_rotation[2])
    -- self.mCamera:onStartTween()
end

function clearCamera(self)
    if self.mCamera then
        self.mCamera:destroy()
    end
end

function getCamera(self)
    return self.mCamera
end

function onPlayerFindPath(self, params)
    if self.mPlayerThing then
        self.mPlayerThing:findPath(params)
    end
end

function onPlayerLookPoint(self, pos)
    if self.mPlayerThing then
        self.mPlayerThing:turnDirByVector(pos - self.mPlayerThing:getPosition(), true)
    end
end

function getAllNPCList(self)
    return self.mNPCThingList
end

function getNPCThing(self, npc_id)
    if not self.mNPCThingList then
        return nil
    end
    return self.mNPCThingList[npc_id]
end

function getPlayerThing(self)
    return self.mPlayerThing
end

function savePlayerScenePosOnPrefab(self)
    if not self.mPlayerThing then
        return
    end

    local pos = self.mPlayerThing:getPosition()
    local angle = self.mPlayerThing:getAngle()
    local pos = {x = pos.x, y = pos.y, z = pos.z}

    self:getSceneConfigVo():savePlayerScenePosOnPrefab(pos, angle)
end

function clearTimeSn(self)
    if self.mCheckTimer then
        LoopManager:removeTimerByIndex(self.mCheckTimer)
        self.mCheckTimer = nil
    end
end

function getSceneConfigVo(self)
    if not self.mSceneConfigVo then
        local map_id = sandPlay.SandPlayManager:getMapId()
        self.mSceneConfigVo = sandPlay.SandPlayManager:getSceneConfigVo(map_id)
    end
    return self.mSceneConfigVo
end

function getLoadSceneConfigVo(self)
    local nextMapId = sandPlay.SandPlayManager:getNextMapId()
    local loadSceneConfigVo = sandPlay.SandPlayManager:getSceneConfigVo(nextMapId)
    return loadSceneConfigVo
end

-- 关闭当前地图
function clearMap(self)
    super.clearMap(self)

    self:removeEventListener()
    self:clearData()
    UIFactory:startForcibly()
end

function clearData(self)
    self:clearCamera()

    self:clearTimeSn()
    self:clearFishUtil()

    if self.mPlayerThing then
        self.mPlayerThing:recover()
        self.mPlayerThing = nil
    end

    if self.mNPCThingList then
        for _, eventThing in pairs(self.mNPCThingList) do
            eventThing:recover()
        end
        self.mNPCThingList = nil
    end

    -- sandPlay.SandPlayManager:setMapId(nil)

    self.mSceneConfigVo = nil

    GameDispatcher:dispatchEvent(EventName.CLOSE_FIELDEXPLORATIONSCENEUI)
end

-- 地图类型
function getMapType(self)
    return MAP_TYPE.SANDPLAY_GAME
end

-- 地图资源名
function getMapID(self)
    return self:getLoadSceneConfigVo().scene_id
end

return _M
