--[[ 
-----------------------------------------------------
@filename       : MainExploreSceneController
@Description    : 主线探索场景控制器
@date           : 2022-2-18 13:44:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("mainExplore.MainExploreSceneController", Class.impl(map.MapBaseController))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

--析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
    if self.mMgr then
        for i = 1, #self.mMgr do
            if(self.mMgr[i] and self.mMgr[i].resetData)then
                self.mMgr[i]:resetData()
            end
        end
    end
    self:clearMap()
end

--游戏开始的回调
function gameStartCallBack(self)
end

--模块间事件监听
function listNotification(self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {}
end

-- 地图类型
function getMapType(self)
    return MAP_TYPE.MAIN_EXPLORE
end

-- 地图资源名
function getMapID(self)
    if fight.FightManager.m_gmScene then
        return tonumber(fight.FightManager.m_gmScene)
    else
        local sceneId = 1000
        local mapId = mainExplore.MainExploreManager:getTriggerDupData().mapId
        if(mapId)then
            local mapConfigVo = mainExplore.MainExploreSceneManager:getMapConfigVo(mapId)
            if(mapConfigVo)then
                sceneId = mapConfigVo.sceneId
            end
        end
        return sceneId
    end
end

-- 开始加载前
function beforeLoad(self)
    UIFactory:startForcibly()
end

-- 加载场景完的调用
function enterMap(self)
    super.enterMap(self)
    self:__addEvent()
    self:__onResCompleteHandler()
end

-- 清理当前地图
function clearMap(self)
    UIFactory:startForcibly()
    self:__removeEvent()
    AudioManager:stopAudioSound(self.m_loopAudio)
    self.m_loopAudio = nil
    self:closeMainExploreScenePanel()
    self:closeMainExploreScene()
    mainExplore.MainExploreEffectExecutor:resetEffect()
    mainExplore.MainExploreManager:resetExploreData()
    mainExplore.MainExploreSceneManager:resetExploreData(true)
    super.clearMap(self)
end

function __addEvent(self)
    GameDispatcher:addEventListener(EventName.MAIN_EXPLORE_ADD_EVENT_TRIGGER, self.onAddEventTriggerHandler, self)
    GameDispatcher:addEventListener(EventName.MAIN_EXPLORE_REMOVE_EVENT_TRIGGER, self.onRemoveEventTriggerHandler, self)
    GameDispatcher:addEventListener(EventName.CLOSE_MAIN_EXPLORE_SCENE, self.onCloseMainExploreSceneHandler, self)
    GameDispatcher:addEventListener(EventName.MAIN_EXPLORE_PLAYER_UPDATE, self.onUpdatePlayerModelHandler, self)
end

function __removeEvent(self)
    GameDispatcher:removeEventListener(EventName.MAIN_EXPLORE_ADD_EVENT_TRIGGER, self.onAddEventTriggerHandler, self)
    GameDispatcher:removeEventListener(EventName.MAIN_EXPLORE_REMOVE_EVENT_TRIGGER, self.onRemoveEventTriggerHandler, self)
    GameDispatcher:removeEventListener(EventName.CLOSE_MAIN_EXPLORE_SCENE, self.onCloseMainExploreSceneHandler, self)
    GameDispatcher:removeEventListener(EventName.MAIN_EXPLORE_PLAYER_UPDATE, self.onUpdatePlayerModelHandler, self)
end

---------------------------------------------------------------------------监听事件-----------------------------------------------------------------------------
--- 添加触碰事件触发器
function onAddEventTriggerHandler(self, args)
    mainExplore.MainExploreSceneThingManager:setEventTrigger(args.eventTrigger)
    self.mMainExploreScene:addEventTrigger()
end

--- 移除触碰事件触发器
function onRemoveEventTriggerHandler(self, args)
    self.mMainExploreScene:removeEventTrigger()
    mainExplore.MainExploreSceneThingManager:setEventTrigger(args.eventTrigger)
end

-- 触发退出主线探索
function onCloseMainExploreSceneHandler(self)
    mainExplore.MainExploreManager:setTriggerDupData(nil)
    -- 通知后端退出
    GameDispatcher:dispatchEvent(EventName.REQ_EXIT_MAIN_EXPLORE_MAP)
    -- 回到主界面
    GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.MAIN_CITY)
    -- GameDispatcher:dispatchEvent(EventName.SHOW_MAIN_UI)
end

-- 玩家模型更新
function onUpdatePlayerModelHandler(self, heroTid)
    local playerThingVo = mainExplore.MainExplorePlayerProxy:getThingVo()
    local playerConfigVo = playerThingVo:getPlayerConfigVo()
    if(playerConfigVo.heroTid ~= heroTid)then
        if(mainExplore.MainExplorePlayerProxy:getThing())then
            mainExplore.MainExploreCamera:setFollow(nil)
            mainExplore.MainExploreSceneThingManager:dispatchEvent(mainExplore.MainExploreSceneThingManager.REMOVE_THING, mainExplore.MainExplorePlayerProxy:getThing())
            mainExplore.MainExplorePlayerProxy:resetThing()
        end
        
        local function _loadFinish(playerThing)
            if(mainExplore.MainExplorePlayerProxy:getThing())then
                mainExplore.MainExploreCamera:setFollow(nil)
                mainExplore.MainExploreSceneThingManager:dispatchEvent(mainExplore.MainExploreSceneThingManager.REMOVE_THING, mainExplore.MainExplorePlayerProxy:getThing())
                mainExplore.MainExplorePlayerProxy:resetThing()
            end
            local aiCtrl = mainExplore.MainExplorePlayerAiCtrl:poolGet()
            aiCtrl:create(playerThing)
            playerThing:setAiCtrl(aiCtrl)
            mainExplore.MainExploreCamera:setFollow(playerThing)
            mainExplore.MainExplorePlayerProxy:active(playerThing, playerThingVo)
            mainExplore.MainExploreSceneThingManager:dispatchEvent(mainExplore.MainExploreSceneThingManager.ADD_THING, playerThing)
        end
        playerThingVo:setPlayerConfigVo(mainExplore.MainExploreSceneManager:getPlayerConfigVo(heroTid))
        mainExplore.MainExploreSceneManager:addPlayerThingVo(playerThingVo, nil, _loadFinish)
    end
end

---------------------------------------------------------------------------监听事件-----------------------------------------------------------------------------
-- 资源加载完毕
function __onResCompleteHandler(self)
    self:openMainExploreScene()
    self:openMainExploreScenePanel()
    self:initThing()
end

-- 打开场景内容
function openMainExploreScene(self)
    if(not self.mMainExploreScene)then
        self.mMainExploreScene = mainExplore.MainExploreScene.new()
    end
    self.mMainExploreScene:open()
end
-- 关闭场景内容
function closeMainExploreScene(self)
    if(self.mMainExploreScene)then
        self.mMainExploreScene:close()
        self.mMainExploreScene = nil
    end
end

-- 打开主线探索场景面板
function openMainExploreScenePanel(self, args)
    if(not self.mMainExploreScenePanel)then
        self.mMainExploreScenePanel = mainExplore.MainExploreScenePanel.new()
        local function destroyPanel()
            self.mMainExploreScenePanel:removeEventListener(View.EVENT_VIEW_DESTROY, destroyPanel, self)
            self.mMainExploreScenePanel = nil
        end
        self.mMainExploreScenePanel:addEventListener(View.EVENT_VIEW_DESTROY, destroyPanel, self)
    end
    self.mMainExploreScenePanel:open(args)
end
-- 关闭主线探索场景面板
function closeMainExploreScenePanel(self)
    if(self.mMainExploreScenePanel and self.mMainExploreScenePanel.isPop)then
        self.mMainExploreScenePanel:close()
    end
end

function initThing(self)
    local eventDic = mainExplore.MainExploreManager:getEventDic(false)
    for eventId, eventVo in pairs(eventDic) do
        mainExplore.MainExploreSceneManager:addThingVo(eventId, nil, nil)
    end
    self:initPlayer()
end

function initPlayer(self)
    local initPos = mainExplore.MainExploreManager:getControlHeroPos()
    local playerConfigVo = mainExplore.MainExploreSceneManager:getPlayerConfigVo(mainExplore.MainExploreManager:getControlHeroTid())
    local playerThingVo = mainExplore.getThingVo(mainExplore.ThingType.PLAYER)
    playerThingVo:setPlayerConfigVo(playerConfigVo)
    playerThingVo:setPosition(initPos)
    playerThingVo:setRotationXYZ(0, 0, 0)
    local function _loadFinish(playerThing)
        if(not playerThing:isOnNavMesh())then
            initPos.x = 0
            initPos.y = 0
            initPos.z = 0
            playerThingVo:setPositionNow(initPos)
            mainExplore.MainExploreManager:setControlHeroPos(initPos)
            -- -- 校正坐标给后端
            -- GameDispatcher:dispatchEvent(EventName.REQ_SYNC_MAIN_EXPLORE_POS, {playerPos = initPos})
        end
        mainExplore.MainExploreCamera:setFollow(playerThing)
        mainExplore.MainExplorePlayerProxy:active(playerThing, playerThingVo)
        mainExplore.MainExploreSceneThingManager:dispatchEvent(mainExplore.MainExploreSceneThingManager.ADD_THING, playerThing)
        
        self:initProtect()
        self:checkCloseLoading()
    end
    mainExplore.MainExploreSceneManager:addPlayerThingVo(playerThingVo, mainExplore.MainExplorePlayerAiCtrl:poolGet(), _loadFinish)
end

-- 初始保护事件
function initProtect(self)
    if(self.mProtectTimerSn)then
        LoopManager:removeTimerByIndex(self.mProtectTimerSn)
    end
    -- 启动后的保护时间,不能攻击玩家,也不能被玩家攻击
    mainExplore.MainExploreManager:setIsInProtecting(true)
    
    local protectTime = sysParam.SysParamManager:getValue(SysParamType.MAIN_EXPLORE_PROTECT_TIME, 0)
    local function _protectFinish()
        mainExplore.MainExploreManager:setIsInProtecting(false)
    end
    self.mProtectTimerSn = LoopManager:addTimer(protectTime, 1, self, _protectFinish)
end

function checkCloseLoading(self)
    local isCloseLoading = true
    local thingDic = mainExplore.MainExploreSceneThingManager:getThingDic()
    if(thingDic)then
        local playerPos = mainExplore.MainExploreManager:getControlHeroPos()
        for eventType, thingList in pairs(thingDic) do
            for i = 1, #thingList do
                local targetThing = thingList[i]
                local targetEventConfigVo = targetThing:getEventConfigVo()
                if(targetEventConfigVo.totalType == mainExplore.TotalType.NORMAL)then
                    if(eventType ~= mainExplore.EventType.DUP_MONSTER and eventType ~= mainExplore.EventType.DUP_BOSS)then
                        if(targetEventConfigVo.eventType == mainExplore.EventType.HIDE_TALK and targetEventConfigVo.isAutoTrigger)then
                            -- 处于目标物交互范围
                            if(math.v3Distance(playerPos, targetThing:getThingVo():getPosition()) <= targetEventConfigVo.interactRange)then
                                isCloseLoading = false
                                break
                            end
                        end
                    end
                end
            end
        end
    end
    if(isCloseLoading)then
        -- 刚开始进入触发剧情时，loading由剧情触发后关闭，否则在一切都ok后就立刻把加载界面关闭
        UIFactory:closeForcibly()
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
