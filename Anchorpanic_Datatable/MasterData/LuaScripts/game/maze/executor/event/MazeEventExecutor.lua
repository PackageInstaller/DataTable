module("maze.MazeEventExecutor", Class.impl())

function initRequireList(self)
    self.mIsLog = false
    maze.MazeEventExecuter_1 = require('game/maze/executor/event/MazeEventExecuter_1')
    maze.MazeEventExecuter_2 = require('game/maze/executor/event/MazeEventExecuter_2')
end

function __print(self, str)
    if(self.mIsLog)then
        logAll(str)
    end
end

function __getTileEventKey(self, eventId, tileId)
    if(eventId and tileId)then
        return eventId * 100000 + tileId
    end
end

function setNowTileEventId(self, eventId, tileId, params)
    self.mNowEventId = self:__getTileEventKey(eventId, tileId)
    self.mNowEventParams = params
end

function getNowTileEventId(self)
    return self.mNowEventId, self.mNowEventParams
end

function resetExecutor(self)
    self:setNowTileEventId(nil, nil, nil)
    self.mFunCheckMoveFinish = nil
end

------------------------------------------------------------------------点击检查--------------------------------------------------------------------------------
-- 点击检测事件
function clickCheckEvent(self, mazeId, clickRow, clickCol)
    if(not mazeId or not clickRow or clickRow <= 0 or not clickCol or clickCol <= 0)then
        return
    end

    local playerVo = maze.MazeSceneManager:getPlayerThingVo(mazeId)
    if(clickRow == playerVo:getRow() and clickCol == playerVo:getCol())then
        playerVo:resetMovePos()
    else
        local mazeConfigVo = maze.MazeSceneManager:getMazeConfigVo(mazeId)
        if(clickRow <= mazeConfigVo:getRowNum() and clickCol <= mazeConfigVo:getColNum())then
            -- 是否在已探索区域内
            if(not maze.MazeSceneManager:isTileInPassArea(mazeId, clickRow, clickCol))then
                -- gs.Message.Show(_TT(46809))
                return
            end
            local tileConfigVo = maze.MazeSceneManager:getTileConfigVo(mazeId, clickRow, clickCol)
            if(tileConfigVo)then
                local eventVo = maze.MazeSceneManager:getMazeEventVo(tileConfigVo:getTileId())
                if(eventVo)then
                    local eventConfigVo = maze.MazeSceneManager:getEventConfigVo(eventVo:getEventId())
                    local isAuto = eventConfigVo:isAuto()
                    local range = eventConfigVo:triggerRange()
                    local eventType = eventConfigVo:getEventType()

                    local function callFun(params)
                        if(eventType == maze.THING_TYPE_HOSPITAL)then
                            local hasDied = false
                            local mazeHeroList = maze.MazeManager:getMazeHeroVoList(mazeId)
                            for i = 1, #mazeHeroList do
                                if(mazeHeroList[i].nowHp <= 0 and mazeHeroList[i].sourceType ~= maze.HERO_SOURCE_TYPE.ENEMY)then
                                    hasDied = true
                                end
                            end
                            if(not hasDied)then
                                gs.Message.Show2("没有战员死亡")
                                return
                            end
                        end

                        if(isAuto)then
                            self:setNowTileEventId(nil, nil, nil)
                        else
                            self:setNowTileEventId(eventVo:getEventId(), eventVo:getTileId(), params)
                        end
                        local pathList = playerVo:getPathList(clickRow, clickCol, range)
                        if(pathList)then
                            -- if(isAuto)then
                            --     playerVo:moveByPathList(pathList)
                            -- else
                            if(#pathList == 2 and maze.MazeAStar:equals(pathList[1], pathList[2]))then
                                self:checkTriggerEvent(mazeId, eventVo, params)
                            else
                                playerVo:moveByPathListOne(pathList)
                            end
                            -- end
                        else
                            gs.Message.Show2(_TT(46810, tileConfigVo:getTileId(), clickRow, clickCol))
                        end
                    end

                    local showPanel = true
                    local noticeStr = nil
                    local isNotice = eventConfigVo:getIsNotice()
                    if isNotice then
                        noticeStr = "MazeEventToDayNoticeTime_" .. eventType

                        local lastNoticeTime = gs.StorageUtil.GetInt(noticeStr)
                        showPanel = not TimeUtil.isToDay(lastNoticeTime, GameManager:getClientTime())
                    end

                    if not showPanel then
                        callFun()
                        return
                    end

                    self:__print(string.format("click - 点击第%s行%s列，%s%s，触发范围为%s", clickRow, clickCol, isAuto and "自动触发" or "手动触发", maze.getEventName(eventType), range))
                    if(eventType == maze.EVENT_TYPE_FLOOR)then -- 地板
                        callFun()
                    elseif(eventType == maze.EVENT_TYPE_FLOOR_TALK)then -- 对话地板
                        callFun()
                    elseif(eventType == maze.EVENT_TYPE_FLOOR_TALK_DEL)then -- 塌陷地板
                        callFun()
                    elseif(eventType == maze.EVENT_TYPE_FLOOR_TALK_ADD)then -- 镜像地板
                        callFun()
                    elseif(eventType == maze.EVENT_TYPE_FLOOR_MONSTER_ADD)then -- 怪物地板
                        callFun()
                    elseif(eventType == maze.THING_TYPE_OBSTACLE)then -- 障碍物
                        callFun()
                    elseif(eventType == maze.THING_TYPE_OBSTACLE_STEEL)then -- 钢铁障碍物
                        callFun()
                    elseif(eventType == maze.THING_TYPE_OBSTACLE_BONFIRE)then -- 篝火障碍物
                        callFun()
                    elseif(eventType == maze.THING_TYPE_OBSTACLE_ICE)then -- 坚冰障碍物
                        GameDispatcher:dispatchEvent(EventName.OPEN_MAZE_TRIGGER_INFO_PANEL, {mazeId = mazeId, eventVo = eventVo, callFun = callFun, noticeStr = noticeStr})
                    elseif(eventType == maze.THING_TYPE_OBSTACLE_FIRE)then -- 高温障碍物
                        GameDispatcher:dispatchEvent(EventName.OPEN_MAZE_TRIGGER_INFO_PANEL, {mazeId = mazeId, eventVo = eventVo, callFun = callFun, noticeStr = noticeStr})
                    elseif(eventType == maze.THING_TYPE_OBSTACLE_BARREL)then -- 木桶障碍物
                        callFun()
                    elseif(eventType == maze.THING_TYPE_NORMAL_DUP or eventType == maze.THING_TYPE_BOSS_DUP)then -- 普通怪物 / 首领怪物
                        GameDispatcher:dispatchEvent(EventName.OPEN_MAZE_DUP_INFO_PANEL, {mazeId = mazeId, eventVo = eventVo, callFun = callFun, noticeStr = noticeStr})
                    elseif(eventType == maze.THING_TYPE_ADD_SOLDIER)then -- 雇佣兵
                        callFun()
                    elseif(eventType == maze.THING_TYPE_SEND_DOOR)then -- 传送门
                        GameDispatcher:dispatchEvent(EventName.OPEN_MAZE_EVENT_INFO_PANEL, {mazeId = mazeId, eventVo = eventVo, callFun = callFun, noticeStr = noticeStr})
                    elseif(eventType == maze.THING_TYPE_HISTORY_BOOK)then -- 历史文献
                        callFun()
                    elseif(eventType == maze.THING_TYPE_REMOVE_OBSTACLE)then -- 障碍物消除机关
                        GameDispatcher:dispatchEvent(EventName.OPEN_MAZE_EVENT_INFO_PANEL, {mazeId = mazeId, eventVo = eventVo, callFun = callFun, noticeStr = noticeStr})
                    elseif(eventType == maze.THING_TYPE_CAMP)then -- 营地
                        GameDispatcher:dispatchEvent(EventName.OPEN_MAZE_EVENT_INFO_PANEL, {mazeId = mazeId, eventVo = eventVo, callFun = callFun, noticeStr = noticeStr})
                    elseif(eventType == maze.THING_TYPE_HOSPITAL)then -- 急救所
                        GameDispatcher:dispatchEvent(EventName.OPEN_MAZE_EVENT_INFO_PANEL, {mazeId = mazeId, eventVo = eventVo, callFun = callFun, noticeStr = noticeStr})
                    elseif(eventType == maze.THING_TYPE_DROP_GOIN)then -- 掉落的金币
                        callFun()
                    elseif(eventType == maze.THING_TYPE_GOODS_BOX)then -- 物资箱
                        callFun()
                    elseif(eventType == maze.THING_TYPE_TRAP_DEL_HP)then -- 陷阱：职业 扣血 百分比
                        callFun()
                    elseif(eventType == maze.THING_TYPE_TRAP_REMOVE)then -- 陷阱移除
                        GameDispatcher:dispatchEvent(EventName.OPEN_MAZE_EVENT_INFO_PANEL, {mazeId = mazeId, eventVo = eventVo, callFun = callFun, noticeStr = noticeStr})
                    elseif(eventType == maze.THING_TYPE_OBSTACLE_SPECIAL)then -- 特殊障碍物
                        callFun()
                    elseif(eventType == maze.THING_TYPE_OBSTACLE_OPEN)then -- （开）障碍物
                        callFun()
                    elseif(eventType == maze.THING_TYPE_OBSTACLE_CLOSE)then -- （关）障碍物
                        callFun()
                    elseif(eventType == maze.THING_TYPE_OBSTACLE_SWITCHER)then -- 开关状态障碍物的触发机关
                        GameDispatcher:dispatchEvent(EventName.OPEN_MAZE_EVENT_INFO_PANEL, {mazeId = mazeId, eventVo = eventVo, callFun = callFun, noticeStr = noticeStr})
                    elseif(eventType == maze.THING_TYPE_NPC)then -- NPC
                        GameDispatcher:dispatchEvent(EventName.OPEN_MAZE_TRIGGER_INFO_PANEL, {mazeId = mazeId, eventVo = eventVo, callFun = callFun, noticeStr = noticeStr})
                    elseif(eventType == maze.THING_TYPE_ENERGY)then -- 能量传输台
                        GameDispatcher:dispatchEvent(EventName.OPEN_MAZE_EVENT_INFO_PANEL, {mazeId = mazeId, eventVo = eventVo, callFun = callFun, noticeStr = noticeStr})
                    elseif(eventType == maze.THING_TYPE_SWITCHER_FLOOR)then -- 机关地板
                        callFun()
                    elseif(eventType == maze.THING_TYPE_TALK_AWARD)then -- 对话事件
                        callFun()
                    elseif(eventType == maze.THING_TYPE_DEVICE_FIRE)then -- 火焰装置
                        GameDispatcher:dispatchEvent(EventName.OPEN_MAZE_EVENT_INFO_PANEL, {mazeId = mazeId, eventVo = eventVo, callFun = callFun, noticeStr = noticeStr})
                    elseif(eventType == maze.THING_TYPE_DEVICE_OUTFIRE)then -- 灭火装置
                        GameDispatcher:dispatchEvent(EventName.OPEN_MAZE_EVENT_INFO_PANEL, {mazeId = mazeId, eventVo = eventVo, callFun = callFun, noticeStr = noticeStr})
                    elseif(eventType == maze.THING_TYPE_FRIENDLY)then -- 友军工程师
                        GameDispatcher:dispatchEvent(EventName.OPEN_MAZE_EVENT_INFO_PANEL, {mazeId = mazeId, eventVo = eventVo, callFun = callFun, noticeStr = noticeStr})
                    elseif(eventType == maze.THING_TYPE_BOMB_ICE)then -- 寒冰炸弹
                        GameDispatcher:dispatchEvent(EventName.OPEN_MAZE_EVENT_INFO_PANEL, {mazeId = mazeId, eventVo = eventVo, callFun = callFun, noticeStr = noticeStr})
                    elseif(eventType == maze.THING_TYPE_BOMB_FIRE)then -- 火焰炸弹
                        GameDispatcher:dispatchEvent(EventName.OPEN_MAZE_EVENT_INFO_PANEL, {mazeId = mazeId, eventVo = eventVo, callFun = callFun, noticeStr = noticeStr})
                    elseif(eventType == maze.THING_TYPE_DEVICE_JUMP)then -- 跃迁器
                        GameDispatcher:dispatchEvent(EventName.OPEN_MAZE_EVENT_INFO_PANEL, {mazeId = mazeId, eventVo = eventVo, callFun = callFun, noticeStr = noticeStr})
                    elseif(eventType == maze.THING_TYPE_DEVICE_JUMP_CREATE)then -- 跃迁器生成配置
                        GameDispatcher:dispatchEvent(EventName.OPEN_MAZE_EVENT_INFO_PANEL, {mazeId = mazeId, eventVo = eventVo, callFun = callFun, noticeStr = noticeStr})
                    elseif(eventType == maze.THING_TYPE_CANNON)then -- 大炮
                        GameDispatcher:dispatchEvent(EventName.OPEN_MAZE_CANNON_INFO_PANEL, {mazeId = mazeId, eventVo = eventVo, callFun = callFun, noticeStr = noticeStr})
                    elseif(eventType == maze.THING_TYPE_CANNON_UNABLE)then -- 大炮（未激活）
                        GameDispatcher:dispatchEvent(EventName.OPEN_MAZE_TRIGGER_INFO_PANEL, {mazeId = mazeId, eventVo = eventVo, callFun = callFun, noticeStr = noticeStr})
                    elseif(eventType == maze.THING_TYPE_DEVICE_TRANSMIT)then -- 传输装置
                        GameDispatcher:dispatchEvent(EventName.OPEN_MAZE_EVENT_INFO_PANEL, {mazeId = mazeId, eventVo = eventVo, callFun = callFun, noticeStr = noticeStr})
                    elseif(eventType == maze.THING_TYPE_NORMAL_BOX or eventType == maze.THING_TYPE_GORGEOUS_BOX)then -- 普通宝箱 / 华丽宝箱
                        GameDispatcher:dispatchEvent(EventName.OPEN_MAZE_AWARD_INFO_PANEL, {mazeId = mazeId, eventVo = eventVo, callFun = callFun, noticeStr = noticeStr})
                    elseif(eventType == maze.THING_TYPE_ROTARY_SWITCH)then -- 旋转阀门
                        GameDispatcher:dispatchEvent(EventName.OPEN_MAZE_ROTARY_SWITCH_INFO_PANEL, {mazeId = mazeId, eventVo = eventVo, callFun = callFun, noticeStr = noticeStr})
                    elseif(eventType == maze.THING_TYPE_FINISH_POINT)then -- 电路终点
                        callFun()
                    elseif(eventType == maze.THING_TYPE_ROTARY_CABLE_ONE)then -- 旋转一线电缆
                        callFun()
                    elseif(eventType == maze.THING_TYPE_ROTARY_CABLE_TWO)then -- 旋转二线电缆
                        callFun()
                    elseif(eventType == maze.THING_TYPE_ROTARY_CABLE_THREE)then -- 旋转三线电缆
                        callFun()
                    elseif(eventType == maze.THING_TYPE_NOT_ROTARY_CABLE_ONE)then -- 不可旋转一线电缆
                        callFun()
                    elseif(eventType == maze.THING_TYPE_NOT_ROTARY_CABLE_TWO)then -- 不可旋转二线电缆
                        callFun()
                    elseif(eventType == maze.THING_TYPE_NOT_ROTARY_CABLE_THREE)then -- 不可旋转三线电缆
                        callFun()
                    elseif(eventType == maze.EVENT_TYPE_ICE or eventType == maze.EVENT_TYPE_ICE_AND_ONECALL)then -- 冰面事件/一笔画冰面
                        callFun()
                    elseif(eventType == maze.EVENT_TYPE_ONECALL_TILE)then -- 一笔画事件地板
                        callFun()
                    elseif(eventType == maze.EVENT_TYPE_ONECALL_DOOR)then -- 一笔画目标机关
                        callFun()
                    elseif(eventType == maze.EVENT_TYPE_SEND_DOOR_ONECALL)then -- 一笔画传送门
                        callFun()
                    elseif(eventType == maze.EVENT_TYPE_ROTARY_SEND_DOOR_ONECALL)then -- 旋转一笔画门事件
                        GameDispatcher:dispatchEvent(EventName.OPEN_MAZE_ROTARY_SWITCH_INFO_PANEL, {mazeId = mazeId, eventVo = eventVo, callFun = callFun, noticeStr = noticeStr})
                    elseif(eventType == maze.EVENT_TYPE_SEND_DOOR_DIR)then -- 矢量方向传送门
                        callFun()
                    else
                        self:__print(string.format("click - 点击第%s行%s列，找不到事件类型%s", clickRow, clickCol, eventType))
                    end
                else
                    self:setNowTileEventId(nil, nil, nil)
                    local pathList = playerVo:getPathList(clickRow, clickCol, 0)
                    if(pathList)then
                        self:__print(string.format("click - 点击第%s行%s列，普通移动", clickRow, clickCol))
                        playerVo:moveByPathListOne(pathList)
                        -- 播放特效
                        local effect = maze.MazeEffectExecutor:createParticleEffect(mazeId, tileConfigVo:getTileId(), maze.getEffectUrl("MazeTileEffect.prefab"), nil, nil, nil)
                        local function _playerMoveEndHandler()
                            playerVo:removeEventListener(playerVo.PLAYER_FINAL_POS_UPDATE, _playerMoveEndHandler, self)
                            playerVo:removeEventListener(playerVo.PLAYER_MOVE_END, _playerMoveEndHandler, self)
                            maze.MazeEffectExecutor:removeEffect(effect)
                        end
                        playerVo:removeEventListener(playerVo.PLAYER_FINAL_POS_UPDATE, _playerMoveEndHandler, self)
                        playerVo:removeEventListener(playerVo.PLAYER_MOVE_END, _playerMoveEndHandler, self)
                        playerVo:addEventListener(playerVo.PLAYER_FINAL_POS_UPDATE, _playerMoveEndHandler, self)
                        playerVo:addEventListener(playerVo.PLAYER_MOVE_END, _playerMoveEndHandler, self)
                    else
                        if(tileConfigVo:getBaseEventId() ~= 0)then
                            -- gs.Message.Show2(string.format("无法抵达格子%s，第%s行%s列", tileConfigVo:getTileId(), clickRow, clickCol))
                            gs.Message.Show2(_TT(46807)) -- 暂时不可到达
                        end
                    end
                end
            else
                -- print("配置有问题了")
            end
        else
            -- print("点击到区域外了")
        end
    end
end

------------------------------------------------------------------------确定预览移动可行性--------------------------------------------------------------------------------
-- 检查移动预览结果（预览确定移动）
function checkMovePreResult(self, mazeId)
    local playerVo = maze.MazeSceneManager:getPlayerThingVo(mazeId)
    if(self.mFunCheckMoveFinish)then
        if(playerVo:hasEventListener(playerVo.PLAYER_MOVE_FINISH, self.mFunCheckMoveFinish, self))then
            playerVo:removeEventListener(playerVo.PLAYER_MOVE_FINISH, self.mFunCheckMoveFinish, self)
        end
    end
    self.mFunCheckMoveFinish = function()
        playerVo:removeEventListener(playerVo.PLAYER_MOVE_FINISH, self.mFunCheckMoveFinish, self)
        self:__print(string.format("check - 移动动画播放完毕，通知后端移动"))
        GameDispatcher:dispatchEvent(EventName.REQ_MAZE_PLAYER_MOVE, {mazeId = playerVo:getMazeId(), tileId = playerVo:getTileId()})
    end
    playerVo:addEventListener(playerVo.PLAYER_MOVE_FINISH, self.mFunCheckMoveFinish, self)
    self:__print(string.format("check - 检查允许移动，开始播放移动动画"))
    playerVo:updateMovePos()
end

------------------------------------------------------------------------本地将主动触发或自动触发--------------------------------------------------------------------------------
-- 检查触发事件列表（移动返回）
function checkTriggerEventList(self, mazeId, autoEventList, activeEventList)
    local playerVo = maze.MazeSceneManager:getPlayerThingVo(mazeId)
    self:__print(string.format("check - 后端位置更新已达，检查事件"))
    if(#autoEventList <= 0 and #activeEventList <= 0)then -- 无触发事件列表，照常移动
        self:__print(string.format("check - 无触发事件列表，尝试移动"))
        -- playerVo:tryRequestMove()
    else
        if(#autoEventList > 0)then
            local _checkTriggerEvent = function ()
                self:__print(string.format("check - 触发自动事件列表，重置移动，检查触发"))
                self:setNowTileEventId(nil, nil, nil)
                playerVo:resetMovePos()
                for i = 1, #autoEventList do
                    self:checkTriggerEvent(mazeId, autoEventList[i], nil)
                end
            end

            local eventConfigVo = maze.MazeSceneManager:getEventConfigVo(autoEventList[1]:getEventId())
            if eventConfigVo then
                local eventType = eventConfigVo:getEventType()
                if eventType == maze.EVENT_TYPE_ICE or eventType == maze.EVENT_TYPE_ICE_AND_ONECALL then return end

                if eventType ~= maze.EVENT_TYPE_ONECALL_TILE then
                    -- and eventConfigVo:getEventType() ~= maze.EVENT_TYPE_ICE_AND_ONECALL then
                    _checkTriggerEvent()
                else
                    local isOpen = false

                    local tileId = autoEventList[1]:getEffecctList()[1]
                    local tileVo = maze.MazeSceneManager:getMazeEventVo(tileId)
                    if tileVo then
                        if tileVo:getActState() == 1 then
                            self:__print(string.format("check - 一笔画事件解密成功，尝试移动"))
                            -- playerVo:tryRequestMove()
                            isOpen = true
                        end
                    end

                    --如果没有打开过机关的话
                    if not isOpen then
                        ---代表之前没走过这个格子
                        if autoEventList[1]:getActState() == 0 then
                            self:__print(string.format("check - 触发一笔画事件，尝试移动"))
                            -- playerVo:tryRequestMove()
                        else
                            self:setNowTileEventId(nil, nil, nil)
                            playerVo:resetMovePos()
                        end
                    end
                end
            else
                _checkTriggerEvent()
            end
        end
        if(#activeEventList > 0)then
            local nowTileEventId, params = self:getNowTileEventId()
            local findNowEventVo = nil
            for i = 1, #activeEventList do
                if(nowTileEventId == self:__getTileEventKey(activeEventList[i]:getEventId(), activeEventList[i]:getTileId()))then
                    findNowEventVo = activeEventList[i]
                    break
                end
            end
            -- 是否触发了目标的主动事件
            if(findNowEventVo)then
                self:__print(string.format("check - 触发已选手动事件，重置移动，检查触发"))
                self:setNowTileEventId(nil, nil, nil)
                playerVo:resetMovePos()
                self:checkTriggerEvent(mazeId, findNowEventVo, params)
            else
                self:__print(string.format("check - 没有手动事件可触发，尝试移动"))
                -- playerVo:tryRequestMove()
            end
        end
    end
end

-- 检查触发事件(移动触发)
function checkTriggerEvent(self, mazeId, eventVo, params)
    local playerVo = maze.MazeSceneManager:getPlayerThingVo(mazeId)
    if(eventVo)then
        local eventConfigVo = maze.MazeSceneManager:getEventConfigVo(eventVo:getEventId())
        local isAuto = eventConfigVo:isAuto()
        local range = eventConfigVo:triggerRange()
        local eventType = eventConfigVo:getEventType()
        local tileConfigVo = maze.MazeSceneManager:getTileConfigVoById(mazeId, eventVo:getTileId())
        local function callFun(cusParamList)
            if(not isAuto)then
                GameDispatcher:dispatchEvent(EventName.REQ_MAZE_CONFIRM_TRIGGER, {mazeId = mazeId, tileId = eventVo:getTileId(), eventId = eventVo:getEventId(), paramList = cusParamList or {}})
            end
        end
        self:__print(string.format("before - 第%s行%s列的范围为%s的%s%s触发后", tileConfigVo:getRow(), tileConfigVo:getCol(), range, maze.getEventName(eventType), isAuto and "自动触发" or "手动触发"))

        if(eventType == maze.EVENT_TYPE_FLOOR)then -- 地板
        elseif(eventType == maze.EVENT_TYPE_FLOOR_TALK)then -- 对话地板
        elseif(eventType == maze.EVENT_TYPE_FLOOR_TALK_DEL)then -- 塌陷地板
        elseif(eventType == maze.EVENT_TYPE_FLOOR_TALK_ADD)then -- 镜像地板
        elseif(eventType == maze.EVENT_TYPE_FLOOR_MONSTER_ADD)then -- 怪物地板
        elseif(eventType == maze.THING_TYPE_OBSTACLE)then -- 障碍物
        elseif(eventType == maze.THING_TYPE_OBSTACLE_STEEL)then -- 钢铁障碍物
        elseif(eventType == maze.THING_TYPE_OBSTACLE_BONFIRE)then -- 篝火障碍物
        elseif(eventType == maze.THING_TYPE_OBSTACLE_ICE)then -- 坚冰障碍物
            callFun()
        elseif(eventType == maze.THING_TYPE_OBSTACLE_FIRE)then -- 高温障碍物
            callFun()
        elseif(eventType == maze.THING_TYPE_OBSTACLE_BARREL)then -- 木桶障碍物
        elseif(eventType == maze.THING_TYPE_NORMAL_DUP or eventType == maze.THING_TYPE_BOSS_DUP)then -- 普通怪物 / 首领怪物
            if(table.indexof(maze.MazeSceneManager:getPassMonsterTileIdList(), eventVo:getTileId()) == false)then
                local formatoinCallFun = function(callReason)
                    maze.MazeCamera:removePhysicsRaycaster()
                end
                maze.MazeCamera:addPhysicsRaycaster()
                GameDispatcher:dispatchEvent(EventName.CLOSE_MAZE_ALL_INFO_PANEL)
                formation.checkFormationFight(PreFightBattleType.DupMaze, nil, eventVo:getTileId(), nil, mazeId, {mazeId = mazeId, uniqueTidList = maze.MazeManager:getMazeHeroList(mazeId, maze.HERO_SOURCE_TYPE.SUPPORT, true)}, formatoinCallFun)
            else
                UIFactory:alertMessge(
                    _TT(46806), --"此前已挑战过，是否直接跳过？"
                    true,
                    function()
                        GameDispatcher:dispatchEvent(EventName.REQ_MAZE_SKIP_MONSTER, {mazeId = mazeId, tileId = eventVo:getTileId()})
                    end,
                    _TT(46805), --"跳过"
                    nil,
                    true,
                    function()
                        local formatoinCallFun = function(callReason)
                            maze.MazeCamera:removePhysicsRaycaster()
                        end
                        maze.MazeCamera:addPhysicsRaycaster()
                        GameDispatcher:dispatchEvent(EventName.CLOSE_MAZE_ALL_INFO_PANEL)
                        formation.checkFormationFight(PreFightBattleType.DupMaze, nil, eventVo:getTileId(), nil, mazeId, {mazeId = mazeId, uniqueTidList = maze.MazeManager:getMazeHeroList(mazeId, maze.HERO_SOURCE_TYPE.SUPPORT, true)}, formatoinCallFun)

                    end,
                    _TT(2),
                    --"取消"
                    _TT(3020), --"跳过战斗"
                    nil,
                RemindConst.XXX)
            end
        elseif(eventType == maze.THING_TYPE_ADD_SOLDIER)then -- 雇佣兵
            GameDispatcher:dispatchEvent(EventName.OPEN_MAZE_MERCENARY_INFO_PANEL, {mazeId = mazeId, eventVo = eventVo, callFun = callFun})
        elseif(eventType == maze.THING_TYPE_SEND_DOOR)then -- 传送门
            callFun()
        elseif(eventType == maze.THING_TYPE_HISTORY_BOOK)then -- 历史文献
            GameDispatcher:dispatchEvent(EventName.OPEN_MAZE_EVENT_INFO_PANEL, {mazeId = mazeId, eventVo = eventVo, callFun = nil})
        elseif(eventType == maze.THING_TYPE_REMOVE_OBSTACLE)then -- 障碍物消除机关
            callFun()
        elseif(eventType == maze.THING_TYPE_CAMP)then -- 营地
            callFun()
        elseif(eventType == maze.THING_TYPE_HOSPITAL)then -- 急救所
            callFun()
        elseif(eventType == maze.THING_TYPE_DROP_GOIN)then -- 掉落的金币
            callFun()
        elseif(eventType == maze.THING_TYPE_GOODS_BOX)then -- 物资箱
            GameDispatcher:dispatchEvent(EventName.OPEN_MAZE_GOODS_INFO_PANEL, {mazeId = mazeId, eventVo = eventVo, callFun = callFun})
        elseif(eventType == maze.THING_TYPE_TRAP_DEL_HP)then -- 陷阱：职业 扣血 百分比
            callFun()
        elseif(eventType == maze.THING_TYPE_TRAP_REMOVE)then -- 陷阱移除
            callFun()
        elseif(eventType == maze.THING_TYPE_OBSTACLE_SPECIAL)then -- 特殊障碍物
        elseif(eventType == maze.THING_TYPE_OBSTACLE_OPEN)then -- （开）障碍物
        elseif(eventType == maze.THING_TYPE_OBSTACLE_CLOSE)then -- （关）障碍物
        elseif(eventType == maze.THING_TYPE_OBSTACLE_SWITCHER)then -- 开关状态障碍物的触发机关                                                              -- 火焰炸弹
            callFun()
        elseif(eventType == maze.THING_TYPE_NPC)then -- NPC
            callFun()
        elseif(eventType == maze.THING_TYPE_ENERGY)then -- 能量传输台
            callFun()
        elseif(eventType == maze.THING_TYPE_SWITCHER_FLOOR)then -- 机关地板
        elseif(eventType == maze.THING_TYPE_TALK_AWARD)then -- 对话事件
            callFun()
        elseif(eventType == maze.THING_TYPE_DEVICE_FIRE)then -- 火焰装置
            callFun()
        elseif(eventType == maze.THING_TYPE_DEVICE_OUTFIRE)then -- 灭火装置
            callFun()
        elseif(eventType == maze.THING_TYPE_FRIENDLY)then -- 友军工程师
            callFun()
        elseif(eventType == maze.THING_TYPE_BOMB_ICE)then -- 寒冰炸弹
            callFun()
        elseif(eventType == maze.THING_TYPE_BOMB_FIRE)then -- 火焰炸弹
            callFun()
        elseif(eventType == maze.THING_TYPE_DEVICE_JUMP)then -- 跃迁器
            callFun()
        elseif(eventType == maze.THING_TYPE_DEVICE_JUMP_CREATE)then -- 跃迁器生成配置
            callFun()
        elseif(eventType == maze.THING_TYPE_CANNON)then -- 大炮
            local direction = eventVo:getEffecctList()[1]
            -- 此处策划要把距离控制在地图范围内，且范围内必须能找到对应格子
            local distance = eventVo:getEffecctList()[2]
            local eventTypeList = eventVo:getEffecctList(3)
            local mazeConfigVo = maze.MazeSceneManager:getMazeConfigVo(mazeId)
            local tileConfigVo = maze.MazeSceneManager:getTileConfigVoById(mazeId, eventVo:getTileId())
            local tempList = maze.getDirDisList(mazeConfigVo:getLayoutType(), mazeConfigVo:getRowNum(), mazeConfigVo:getColNum(), tileConfigVo:getRow(), tileConfigVo:getCol(), direction, distance, false)
            local tileIdList = {}
            -- -- 方便查看
            -- local targetIndex = 0
            for i = 1, #tempList do
                local data = tempList[i]
                local tileId = maze.MazeSceneManager:getTileIdByRowCol(mazeId, data.row, data.col)
                table.insert(tileIdList, maze.MazeSceneManager:getTileIdByRowCol(mazeId, data.row, data.col))
                local eventVo = maze.MazeSceneManager:getMazeEventVo(tileId)
                if(eventVo)then
                    local eventConfigVo = maze.MazeSceneManager:getEventConfigVo(eventVo:getEventId())
                    if(eventConfigVo)then
                        if(table.indexof(eventTypeList, eventConfigVo:getEventType()) ~= false)then
                            -- targetIndex = i
                            break
                        end
                    end
                end
            end
            -- for i = #tempList, 1, -1 do
            --     if(i > targetIndex)then
            --         table.remove(tempList, i)
            --     end
            -- end
            -- 把大炮本身格子id作为起始点放在开头
            table.insert(tileIdList, 1, eventVo:getTileId())
            callFun(tileIdList)
        elseif(eventType == maze.THING_TYPE_CANNON_UNABLE)then -- 大炮（未激活）
            callFun()
        elseif(eventType == maze.THING_TYPE_DEVICE_TRANSMIT)then -- 传输装置
            callFun()
        elseif(eventType == maze.THING_TYPE_NORMAL_BOX or eventType == maze.THING_TYPE_GORGEOUS_BOX)then -- 普通宝箱 / 华丽宝箱
            callFun()
        elseif(eventType == maze.THING_TYPE_ROTARY_SWITCH)then -- 旋转阀门
            callFun(params)
        elseif(eventType == maze.THING_TYPE_FINISH_POINT)then -- 电路终点
            callFun()
        elseif(eventType == maze.THING_TYPE_ROTARY_CABLE_ONE)then -- 旋转一线电缆
            callFun()
        elseif(eventType == maze.THING_TYPE_ROTARY_CABLE_TWO)then -- 旋转二线电缆
            callFun()
        elseif(eventType == maze.THING_TYPE_ROTARY_CABLE_THREE)then -- 旋转三线电缆
            callFun()
        elseif(eventType == maze.THING_TYPE_NOT_ROTARY_CABLE_ONE)then -- 不可旋转一线电缆
            callFun()
        elseif(eventType == maze.THING_TYPE_NOT_ROTARY_CABLE_TWO)then -- 不可旋转二线电缆
            callFun()
        elseif(eventType == maze.THING_TYPE_NOT_ROTARY_CABLE_THREE)then -- 不可旋转三线电缆
            callFun()
        elseif(eventType == maze.EVENT_TYPE_ICE or eventType == maze.EVENT_TYPE_ICE_AND_ONECALL)then -- 冰面事件/一笔画冰面
        elseif(eventType == maze.EVENT_TYPE_ONECALL_TILE)then -- 一笔画事件地板
        elseif(eventType == maze.EVENT_TYPE_ONECALL_DOOR)then -- 一笔画目标机关
        elseif(eventType == maze.EVENT_TYPE_SEND_DOOR_ONECALL)then -- 一笔画传送门
        elseif(eventType == maze.EVENT_TYPE_ROTARY_SEND_DOOR_ONECALL)then -- 旋转一笔画门事件
            callFun(params)
        elseif (eventType == maze.EVENT_TYPE_SEND_DOOR_DIR) then -- 矢量方向传送门
        else
            self:__print(string.format("before - 触发第%s行%s列，找不到事件类型%s", tileConfigVo:getRow(), tileConfigVo:getCol(), eventType))
        end
    end
end

------------------------------------------------------------------------主动或自动触发效果--------------------------------------------------------------------------------
-- 触发之后，检测触发事件效果(服务器通用触发)
function checkTriggerEventEffect(self, mazeId, tileId, eventId, dataList, delEventList, addEventList, updateEventList, updateTileList, finishCall)
    local dic = maze.MazeSceneManager.mCurEventDic
    local playerVo = maze.MazeSceneManager:getPlayerThingVo(mazeId)
    local row, col = maze.MazeSceneManager:getRowColByTileId(mazeId, tileId)
    local tileConfigVo = maze.MazeSceneManager:getTileConfigVo(mazeId, row, col)
    local eventVo = maze.MazeSceneManager:getMazeEventVo(tileConfigVo:getTileId())
    local eventConfigVo = maze.MazeSceneManager:getEventConfigVo(eventId)
    local isAuto = eventConfigVo:isAuto()
    local range = eventConfigVo:triggerRange()
    local eventType = eventConfigVo:getEventType()

    local function _checkEffect(effectCallFun)
        local _checkEffectCall = function(...)
            if(eventConfigVo:getAfterTriggerTip() ~= 0)then
                if(... == nil)then
                    GameDispatcher:dispatchEvent(EventName.SHOW_MAZE_MESSAGE, {message = _TT(eventConfigVo:getAfterTriggerTip())})
                else
                    GameDispatcher:dispatchEvent(EventName.SHOW_MAZE_MESSAGE, {message = _TT(eventConfigVo:getAfterTriggerTip(), ...)})
                end
            end
            effectCallFun()
        end
        self:__print(string.format("after - 第%s行%s列的范围为%s的%s%s触发后", tileConfigVo:getRow(), tileConfigVo:getCol(), range, maze.getEventName(eventType), isAuto and "自动触发" or "手动触发"))
        if(eventType == maze.EVENT_TYPE_FLOOR)then -- 地板
        elseif(eventType == maze.EVENT_TYPE_FLOOR_TALK)then -- 对话地板
        elseif(eventType == maze.EVENT_TYPE_FLOOR_TALK_DEL)then -- 塌陷地板
        elseif(eventType == maze.EVENT_TYPE_FLOOR_TALK_ADD)then -- 镜像地板
        elseif(eventType == maze.EVENT_TYPE_FLOOR_MONSTER_ADD)then -- 怪物地板
        elseif(eventType == maze.THING_TYPE_OBSTACLE)then -- 障碍物
        elseif(eventType == maze.THING_TYPE_OBSTACLE_STEEL)then -- 钢铁障碍物
        elseif(eventType == maze.THING_TYPE_OBSTACLE_BONFIRE)then -- 篝火障碍物
        elseif(eventType == maze.THING_TYPE_OBSTACLE_ICE)then -- 坚冰障碍物
        elseif(eventType == maze.THING_TYPE_OBSTACLE_FIRE)then -- 高温障碍物
        elseif(eventType == maze.THING_TYPE_OBSTACLE_BARREL)then -- 木桶障碍物
        elseif(eventType == maze.THING_TYPE_NORMAL_DUP or eventType == maze.THING_TYPE_BOSS_DUP)then -- 普通怪物 / 首领怪物
        elseif(eventType == maze.THING_TYPE_ADD_SOLDIER)then -- 雇佣兵
            local monsterTidVo = monster.MonsterManager:getMonsterVo(dataList[1])
            local monsterConfigVo = monster.MonsterManager:getMonsterVo01(monsterTidVo.tid)
            -- GameDispatcher:dispatchEvent(EventName.SHOW_MAZE_MESSAGE, {message = _TT(46811, monsterConfigVo.name)})
            _checkEffectCall(monsterConfigVo.name)
            return
        elseif(eventType == maze.THING_TYPE_SEND_DOOR)then -- 传送门
            local effectNameList = eventConfigVo.triggerEffectDic[1]
            if(effectNameList and #effectNameList > 0)then
                for _, effectName in pairs(effectNameList) do
                    maze.MazeEffectExecutor:createParticleEffect(mazeId, tileId, maze.getEffectUrl(effectName), 5)
                end
            end

            LoopManager:setTimeout(0.5, self, function ()
                GameDispatcher:dispatchEvent(EventName.UPDATE_MAZE_TOUCH_ABILITY, true)
                maze.MazeSceneManager:setPlayerTileId(dataList[1])
                playerVo:setTileId(dataList[1])
                playerVo:refreshPos()
                maze.MazeEffectExecutor:createParticleEffect(mazeId, dataList[1], maze.getEffectUrl("fx_maze_704_chuansong_01.prefab"), 5, callFun)

                maze.MazeCamera:setRowCol(playerVo:getRow(), playerVo:getCol(), true, function() GameDispatcher:dispatchEvent(EventName.UPDATE_MAZE_TOUCH_ABILITY, false) end)
            end)
        elseif (eventType == maze.EVENT_TYPE_SEND_DOOR) then -- 特殊传送门
            playerVo:resetMovePos()

            if dataList[2] == 1 then
                gs.Message.Show(_TT(46836))
            elseif dataList[2] == 2 then
                gs.Message.Show(_TT(46837))
            end
            GameDispatcher:dispatchEvent(EventName.UPDATE_MAZE_TOUCH_ABILITY, true)
            maze.MazeSceneManager:setPlayerTileId(dataList[1])
            playerVo:setTileId(dataList[1])
            playerVo:refreshPos()
            maze.MazeEffectExecutor:createParticleEffect(mazeId, dataList[1], maze.getEffectUrl("fx_maze_704_chuansong_01.prefab"), 5, callFun)
            maze.MazeCamera:setRowCol(playerVo:getRow(), playerVo:getCol(), true, function() GameDispatcher:dispatchEvent(EventName.UPDATE_MAZE_TOUCH_ABILITY, false) end)
        elseif (eventType == maze.EVENT_TYPE_SEND_DOOR_ONECALL) then -- 一笔画传送门
            if dataList[1] then
                playerVo:resetMovePos()

                GameDispatcher:dispatchEvent(EventName.UPDATE_MAZE_TOUCH_ABILITY, true)
                maze.MazeSceneManager:setPlayerTileId(dataList[1])
                playerVo:setTileId(dataList[1])
                playerVo:refreshPos()
                maze.MazeEffectExecutor:createParticleEffect(mazeId, dataList[1], maze.getEffectUrl("fx_maze_704_chuansong_01.prefab"), 5, callFun)
                maze.MazeCamera:setRowCol(playerVo:getRow(), playerVo:getCol(), true, function() GameDispatcher:dispatchEvent(EventName.UPDATE_MAZE_TOUCH_ABILITY, false) end)
            end
        elseif (eventType == maze.EVENT_TYPE_SEND_DOOR_DIR) then -- 矢量方向传送门
            playerVo:resetMovePos()
            local tileId = dataList[1]

            GameDispatcher:dispatchEvent(EventName.UPDATE_MAZE_TOUCH_ABILITY, true)
            maze.MazeSceneManager:setPlayerTileId(tileId)
            playerVo:setTileId(tileId)
            playerVo:refreshPos()
            maze.MazeEffectExecutor:createParticleEffect(mazeId, tileId, maze.getEffectUrl("fx_maze_704_chuansong_01.prefab"), 5, callFun)
            maze.MazeCamera:setRowCol(playerVo:getRow(), playerVo:getCol(), true, function() GameDispatcher:dispatchEvent(EventName.UPDATE_MAZE_TOUCH_ABILITY, false) end)

            local direction = dataList[2]
            local angle = ((direction - 1) * 60) + 30
            playerVo:setAngle(angle, true)

            --判断是不是冰面
            local tileConfigVo = maze.MazeSceneManager:getTileConfigVoById(mazeId, tileId)
            self:moveFinishCheckEvent(mazeId, tileConfigVo:getRow(), tileConfigVo:getCol())

            return
        elseif(eventType == maze.THING_TYPE_HISTORY_BOOK)then -- 历史文献
        elseif(eventType == maze.THING_TYPE_REMOVE_OBSTACLE)then -- 障碍物消除机关
            -- GameDispatcher:dispatchEvent(EventName.SHOW_MAZE_MESSAGE, {message = _TT(46812)})
        elseif(eventType == maze.THING_TYPE_CAMP)then -- 营地
            -- GameDispatcher:dispatchEvent(EventName.SHOW_MAZE_MESSAGE, {message = _TT(46813, dataList[1])})
            _checkEffectCall(dataList[1])
            return
        elseif(eventType == maze.THING_TYPE_HOSPITAL)then -- 急救所
            if(dataList[1] > 0)then
                -- GameDispatcher:dispatchEvent(EventName.SHOW_MAZE_MESSAGE, {message = _TT(46814, dataList[1])})
                _checkEffectCall(dataList[1])
            else
                _checkEffectCall()
            end
            return
        elseif(eventType == maze.THING_TYPE_DROP_GOIN)then -- 掉落的金币
            ShowAwardPanel:showPropsAwardMsg(dataList, _checkEffectCall)
            return
        elseif(eventType == maze.THING_TYPE_GOODS_BOX)then -- 物资箱
            local effectCall = function()
                maze.MazeManager:addGoods(mazeId, dataList[1])
                -- 屏蔽物资箱子的奖励提示
                -- local goodsConfigVo = maze.MazeManager:getGoodsConfigVo(dataList[1])
                -- GameDispatcher:dispatchEvent(EventName.SHOW_MAZE_MESSAGE, {message = _TT(46815, goodsConfigVo:getName())})
                self:checkExtraGoods(mazeId, nilCallFun)
                _checkEffectCall()
            end
            maze.MazeEffectExecutor:createEffect(mazeId, dataList, eventConfigVo, delEventList, addEventList, updateEventList, updateTileList, effectCall)
            return
        elseif(eventType == maze.THING_TYPE_TRAP_DEL_HP)then -- 陷阱：职业 扣血 百分比
            local effectCall = function()
                -- GameDispatcher:dispatchEvent(EventName.SHOW_MAZE_MESSAGE, {message = _TT(46816, hero.getProfessionName(dataList[1]), dataList[2])})
                _checkEffectCall(hero.getProfessionName(dataList[1]), dataList[2])
            end
            maze.MazeEffectExecutor:createEffect(mazeId, dataList, eventConfigVo, delEventList, addEventList, updateEventList, updateTileList, effectCall)
            return
        elseif(eventType == maze.THING_TYPE_TRAP_REMOVE)then -- 陷阱移除
            -- GameDispatcher:dispatchEvent(EventName.SHOW_MAZE_MESSAGE, {message = "场景内陷阱清除成功"})
        elseif(eventType == maze.THING_TYPE_OBSTACLE_SPECIAL)then -- 特殊障碍物
        elseif(eventType == maze.THING_TYPE_OBSTACLE_OPEN)then -- （开）障碍物
        elseif(eventType == maze.THING_TYPE_OBSTACLE_CLOSE)then -- （关）障碍物
        elseif(eventType == maze.THING_TYPE_OBSTACLE_SWITCHER)then -- 开关状态障碍物的触发机关
            if dataList[1] == 0 then
                gs.Message.Show(_TT(46838))
            end
            maze.MazeEffectExecutor:createEffect(mazeId, dataList, eventConfigVo, delEventList, addEventList, updateEventList, updateTileList, _checkEffectCall)
            return
        elseif(eventType == maze.THING_TYPE_NPC)then -- NPC
        elseif(eventType == maze.THING_TYPE_ENERGY)then -- 能量传输台
            local effectList = eventVo:getEffecctList(1)
            for i = 1, #effectList do
                if(i ~= 1 and i % 2 == 0)then
                    effectList[i] = AttConst.getName(effectList[i])
                end
            end
            -- GameDispatcher:dispatchEvent(EventName.SHOW_MAZE_MESSAGE, {message = "所有怪物扣除"..dataList[1].."%的生命值以及"..data[2].."%的攻击力......"})
            _checkEffectCall(effectList)
            return
        elseif(eventType == maze.THING_TYPE_SWITCHER_FLOOR)then -- 机关地板
        elseif(eventType == maze.THING_TYPE_TALK_AWARD)then -- 对话事件
            ShowAwardPanel:showPropsAwardMsg(dataList, _checkEffectCall)
            return
        elseif(eventType == maze.THING_TYPE_DEVICE_FIRE)then -- 火焰装置
            -- GameDispatcher:dispatchEvent(EventName.SHOW_MAZE_MESSAGE, {message = "生成火焰装置成功"})
        elseif(eventType == maze.THING_TYPE_DEVICE_OUTFIRE)then -- 灭火装置
            -- GameDispatcher:dispatchEvent(EventName.SHOW_MAZE_MESSAGE, {message = "全部火焰装置消灭成功"})
        elseif(eventType == maze.THING_TYPE_FRIENDLY)then -- 友军工程师
        elseif(eventType == maze.THING_TYPE_BOMB_ICE)then -- 寒冰炸弹
            -- GameDispatcher:dispatchEvent(EventName.SHOW_MAZE_MESSAGE, {message = "获得寒冰炸弹"})
        elseif(eventType == maze.THING_TYPE_BOMB_FIRE)then -- 火焰炸弹
            -- GameDispatcher:dispatchEvent(EventName.SHOW_MAZE_MESSAGE, {message = "获得火焰炸弹"})
        elseif(eventType == maze.THING_TYPE_DEVICE_JUMP)then -- 跃迁器
        elseif(eventType == maze.THING_TYPE_DEVICE_JUMP_CREATE)then -- 跃迁器生成配置
        elseif(eventType == maze.THING_TYPE_CANNON)then -- 大炮
            if(#dataList > 1)then
                maze.MazeEffectExecutor:createEffect(mazeId, dataList, eventConfigVo, delEventList, addEventList, updateEventList, updateTileList, _checkEffectCall)
                return
            end
        elseif(eventType == maze.THING_TYPE_CANNON_UNABLE)then -- 大炮（未激活）
            -- GameDispatcher:dispatchEvent(EventName.SHOW_MAZE_MESSAGE, {message = "大炮激活"})
        elseif(eventType == maze.THING_TYPE_DEVICE_TRANSMIT)then -- 传输装置
        elseif(eventType == maze.THING_TYPE_NORMAL_BOX or eventType == maze.THING_TYPE_GORGEOUS_BOX)then -- 普通宝箱 / 华丽宝箱
            ShowAwardPanel:showPropsAwardMsg(dataList, function ()
                _checkEffectCall()
                local mazeVo = maze.MazeManager:getMazeVo(mazeId)
                if mazeVo:getBoxPro() == 1 then
                    UIFactory:alertMessge(_TT(46839), true, nil, nil, nil, nil, nil, nil, _TT(46840))
                end
            end)
            return
        elseif(eventType == maze.THING_TYPE_ROTARY_SWITCH)then -- 旋转阀门
            maze.MazeEffectExecutor:createEffect(mazeId, dataList, eventConfigVo, delEventList, addEventList, updateEventList, updateTileList, _checkEffectCall)
            return
        elseif(eventType == maze.EVENT_TYPE_ROTARY_SEND_DOOR_ONECALL)then -- 旋转一笔画门事件
            maze.MazeEffectExecutor:createEffect(mazeId, dataList, eventConfigVo, delEventList, addEventList, updateEventList, updateTileList, _checkEffectCall)
            return
        elseif(eventType == maze.THING_TYPE_FINISH_POINT)then -- 电路终点
        elseif(eventType == maze.THING_TYPE_ROTARY_CABLE_ONE)then -- 旋转一线电缆
        elseif(eventType == maze.THING_TYPE_ROTARY_CABLE_TWO)then -- 旋转二线电缆
        elseif(eventType == maze.THING_TYPE_ROTARY_CABLE_THREE)then -- 旋转三线电缆
        elseif(eventType == maze.THING_TYPE_NOT_ROTARY_CABLE_ONE)then -- 不可旋转一线电缆
        elseif(eventType == maze.THING_TYPE_NOT_ROTARY_CABLE_TWO)then -- 不可旋转二线电缆
        elseif(eventType == maze.THING_TYPE_NOT_ROTARY_CABLE_THREE)then -- 不可旋转三线电缆
        elseif(eventType == maze.EVENT_TYPE_ICE or eventType == maze.EVENT_TYPE_ICE_AND_ONECALL)then -- 冰面事件/一笔画冰面
        elseif(eventType == maze.EVENT_TYPE_ONECALL_TILE)then -- 一笔画事件地板
        elseif(eventType == maze.EVENT_TYPE_ONECALL_DOOR)then -- 一笔画目标机关
            maze.MazeEffectExecutor:createEffect(mazeId, dataList, eventConfigVo, delEventList, addEventList, updateEventList, updateTileList, _checkEffectCall)
            return
        elseif(eventType == maze.EVENT_TYPE_ROTARY_SEND_DOOR_ONECALL)then -- 旋转一笔画门事件
            maze.MazeEffectExecutor:createEffect(mazeId, dataList, eventConfigVo, delEventList, addEventList, updateEventList, updateTileList, _checkEffectCall)
            return
        else
            self:__print(string.format("after - 第%s行%s列触发后，找不到事件类型%s", row, col, eventType))
        end

        _checkEffectCall()
    end

    local _finishCall = finishCall
    local function finishCall()
        self:__afterUpdateTileList(mazeId, updateTileList)
        self:__afterUpdateEventList(mazeId, delEventList, addEventList, updateEventList)
        -- 更新触发状态：恢复
        self:updateTriggerStateList(eventConfigVo.triggerStateList, true)
        if(_finishCall)then
            _finishCall()
        end
    end

    -- 更新触发状态：设置
    self:updateTriggerStateList(eventConfigVo.triggerStateList, false)

    local isPlayBefore, talkId = tileConfigVo:getEventTalkData()
    if(isPlayBefore ~= nil and talkId ~= nil)then
        if(isPlayBefore)then
            local function _storyFinishCall(successFlag, storyRo)
                _checkEffect(finishCall)
            end
            if not storyTalk.StoryTalkCondition:condition10(_storyFinishCall, storyTalk.Module.TYPE_MAZE, mazeId, eventId, nil) then
                _checkEffect(finishCall)
            end
        else
            local function _callFun()
                local function _storyFinishCall(successFlag, storyRo)
                    if(finishCall)then
                        finishCall()
                    end
                end
                if not storyTalk.StoryTalkCondition:condition10(_storyFinishCall, storyTalk.Module.TYPE_MAZE, mazeId, eventId, nil) then
                    if(finishCall)then
                        finishCall()
                    end
                end
            end
            _checkEffect(_callFun)
        end
    else
        _checkEffect(finishCall)
    end
end
------------------------------------------------------------------------移动完毕客户端自我检查事件--------------------------------------------------------------------------------
-- 移动完毕检查客户端事件（冰面）
function moveFinishCheckEvent(self)
    local mazeId = maze.MazeSceneManager:getMazeId()
    local mazeConfigVo = maze.MazeSceneManager:getMazeConfigVo(mazeId)

    local playerVo = maze.MazeSceneManager:getPlayerThingVo(mazeId)
    local tileId = playerVo:getTileId()

    local eventVo = maze.MazeSceneManager:getMazeEventVo(tileId)
    if(eventVo)then
        local eventConfigVo = maze.MazeSceneManager:getEventConfigVo(eventVo:getEventId())
        local eventType = eventConfigVo:getEventType()

        -- self:__print(string.format("移动完毕检测事件 - 第%s行%s列，%s%s，tileId = %s", row, col, isAuto and "自动触发" or "手动触发", maze.getEventName(eventType), tileId))
        if(eventType == maze.EVENT_TYPE_ICE or eventType == maze.EVENT_TYPE_ICE_AND_ONECALL)then -- 冰面事件/一笔画冰面
            -- playerVo:resetMovePos()
            local playerThing = maze.MazeSceneThingManager:getThing(maze.THING_TYPE_PLAYER, playerVo:getRow(), playerVo:getCol())
            if not playerThing.mTempAngle then return end

            local direction = maze.getDirTypeByAng(mazeConfigVo:getLayoutType(), playerThing.mTempAngle.y)
            local distance = 1

            local tileConfigVo = playerVo:getTileConfigVo()
            local tempList = maze.getDirDisList(mazeConfigVo:getLayoutType(), mazeConfigVo:getRowNum(), mazeConfigVo:getColNum(), tileConfigVo:getRow(), tileConfigVo:getCol(), direction, distance, false)

            local range = eventConfigVo:triggerRange()
            local tileData = tempList[1]
            local pathList = playerVo:getPathList(tileData.row, tileData.col, range)
            if(pathList)then
                playerVo:moveByPathList(pathList)
                return true
            end

            playerVo:dispatchEvent(playerVo.PLAYER_MOVE_FINISH)
            playerVo:resetMovePos()
        end
    end
end

-- 通用触发之后更新格子列表（只增不减，策划规避）
function __afterUpdateTileList(self, mazeId, updateTileList)
    if(updateTileList)then
        for i = 1, #updateTileList do
            local tileVo = maze.MazeSceneManager:addMazeTileVo(updateTileList[i])
            local tileConfigVo = maze.MazeSceneManager:getTileConfigVoById(mazeId, tileVo:getTileId())
            local row, col = tileConfigVo:getRow(), tileConfigVo:getCol()
            if(tileVo:isDel())then
                maze.MazeSceneManager:removeThingVo(maze.THING_TYPE_TILE, row, col, true)
            elseif(tileVo:isAdd())then
                maze.MazeSceneManager:removeThingVo(maze.THING_TYPE_TILE, row, col, true)
                local thingVo = maze.getEventThingVo(maze.THING_TYPE_TILE)
                thingVo:setData(mazeId, tileVo:getTileId())
                maze.MazeSceneManager:addThingVo(thingVo, true)
            end
        end
    end
end

-- 通用触发之后更新事件列表
function __afterUpdateEventList(self, mazeId, delEventList, addEventList, updateEventList)
    local tempEventVo = LuaPoolMgr:poolGet(maze.MazeEventVo)
    for i = 1, #delEventList do
        tempEventVo:setData(delEventList[i])
        local eventVo = maze.MazeSceneManager:getMazeEventVo(tempEventVo:getTileId())
        if(eventVo)then
            local tileConfigVo = maze.MazeSceneManager:getTileConfigVoById(mazeId, eventVo:getTileId())
            maze.MazeSceneManager:removeThingVo(maze.THING_TYPE_EVENT, tileConfigVo:getRow(), tileConfigVo:getCol(), true)
            maze.MazeSceneManager:delMazeEventVo(eventVo:getTileId())
        end
    end

    for i = 1, #addEventList do
        local eventVo = maze.MazeSceneManager:addMazeEventVo(addEventList[i])
        if(eventVo)then
            local tileConfigVo = maze.MazeSceneManager:getTileConfigVoById(mazeId, eventVo:getTileId())
            local row, col = tileConfigVo:getRow(), tileConfigVo:getCol()
            maze.MazeSceneManager:removeThingVo(maze.THING_TYPE_EVENT, row, col, true)
            local thingVo = maze.getEventThingVo(maze.THING_TYPE_EVENT)
            thingVo:setData(mazeId, tileConfigVo:getTileId())
            maze.MazeSceneManager:addThingVo(thingVo, true)
        end
    end

    if(updateEventList)then
        for i = 1, #updateEventList do
            tempEventVo:setData(updateEventList[i])
            local delEventVo = maze.MazeSceneManager:getMazeEventVo(tempEventVo:getTileId())
            if(delEventVo)then
                local tileConfigVo = maze.MazeSceneManager:getTileConfigVoById(mazeId, delEventVo:getTileId())
                maze.MazeSceneManager:removeThingVo(maze.THING_TYPE_EVENT, tileConfigVo:getRow(), tileConfigVo:getCol(), true)
                maze.MazeSceneManager:delMazeEventVo(delEventVo:getTileId())

                local addEventVo = maze.MazeSceneManager:addMazeEventVo(updateEventList[i])
                if(addEventVo)then
                    local tileConfigVo = maze.MazeSceneManager:getTileConfigVoById(mazeId, addEventVo:getTileId())
                    local row, col = tileConfigVo:getRow(), tileConfigVo:getCol()
                    maze.MazeSceneManager:removeThingVo(maze.THING_TYPE_EVENT, row, col, true)

                    local thingVo = maze.getEventThingVo(maze.THING_TYPE_EVENT)
                    thingVo:setData(mazeId, tileConfigVo:getTileId())
                    maze.MazeSceneManager:addThingVo(thingVo, true)
                end
            end
        end
    end
    LuaPoolMgr:poolRecover(tempEventVo)
end

-- 获得额外物资
function addExtraGoods(self, buffId)
    if(not self.mWaitingGoodsList)then
        self.mWaitingGoodsList = {}
    end
    if(table.indexof(self.mWaitingGoodsList, buffId) == false)then
        table.insert(self.mWaitingGoodsList, buffId)
    end
end

-- 移除额外物资
function removeExtraGoods(self)
    if(self.mWaitingGoodsList)then
        return table.remove(self.mWaitingGoodsList, 1)
    end
    return nil
end

-- 检测额外物资
function checkExtraGoods(self, mazeId, finishCall)
    local function _updateExtraGoods(self, data)
        GameDispatcher:removeEventListener(EventName.UPDATE_MAZE_EXTRA_GOODS, _updateExtraGoods, self)
        maze.MazeManager:addGoods(mazeId, data.buffId)
        self:addExtraGoods(data.buffId)
        local buffId = self:removeExtraGoods()
        if(buffId and buffId > 0)then
            local goodsConfigVo = maze.MazeManager:getGoodsConfigVo(data.buffId)
            gs.Message.Show(_TT(46817, goodsConfigVo:getName()))
            -- GameDispatcher:dispatchEvent(EventName.SHOW_MAZE_MESSAGE, {message = "额外获得:" .. goodsConfigVo:getName()})
            if(finishCall)then
                finishCall()
            end
        end
    end
    GameDispatcher:addEventListener(EventName.UPDATE_MAZE_EXTRA_GOODS, _updateExtraGoods, self)
    GameDispatcher:dispatchEvent(EventName.REQ_MAZE_EXTRA_GOODS, {mazeId = mazeId})
end

-- 更新触发状态列表
function updateTriggerStateList(self, stateList, isRecovery)
    for i = 1, #stateList do
        self:updateTriggerState(stateList[i], isRecovery)
    end
end

-- 更新触发状态
function updateTriggerState(self, state, isRecovery)
    if(state == maze.TriggerState.NONE)then -- 无
    elseif(state == maze.TriggerState.UI_VISIBLE_ENABLE)then-- 界面UI显示能力
        GameDispatcher:dispatchEvent(EventName.UPDATE_MAZE_UI_VISIBLE, isRecovery)
    else
        Debug:log_error("MazeEventExecutor", "未设置对应触发状态" .. state)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
语言包: _TT(46812):"消除障碍物"
语言包: _TT(46809):"未知探索领域"
]]
