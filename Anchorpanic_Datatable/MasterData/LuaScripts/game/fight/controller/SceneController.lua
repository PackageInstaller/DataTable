module("fight.SceneController", Class.impl(map.MapBaseController))

--游戏开始的回调
function gameStartCallBack(self)

end

--模块间事件监听
function listNotification(self)
    super.listNotification(self)
    fight.SceneManager:addEventListener(fight.SceneManager.EVENT_BUILD_COMPLETE, self.onBuildCompleteHandler, self);

    GameDispatcher:addEventListener(EventName.PLAY_RATE_CHANGE, self.onPlayRateChangeHandler, self)
    GameDispatcher:addEventListener(EventName.EXIT_FIGHT_SCENE, self.onExitSceneHandler, self)
    GameDispatcher:addEventListener(EventName.EXIT_FIGHT_END_RESET, self.onFightEndReset, self)
    GameDispatcher:addEventListener(EventName.NORMAL_FRAME_STOP, self.onNormalFrameChange, self)

    GameDispatcher:addEventListener(EventName.ATTACKER_MOVE_START, self.onAttackerMoveStart, self)
    GameDispatcher:addEventListener(EventName.ATTACKER_MOVE_END, self.onAttackerMoveEnd, self)

    GameDispatcher:addEventListener(EventName.REQ_EXIT_GAME, self.onReqExitGameHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
end

function onBuildCompleteHandler(self)
    RateLooper:removeFrameByIndex(self.m_checkSn)
    self.m_checkSn = RateLooper:addFrame(1, 0, self, self.onStep)
    -- print("onBuildCompleteHandler ========")
    GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, self:getMapType())
    -- GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, {mapType = self:getMapType()})
end

function onReqExitGameHandler(self)
    if fight.FightManager:getIsFighting() then
        self:onFightEndReset()
    end
end

function onStep(self, deltaTime)
    if fight.LiveLooper:isNorFrameStop() then
        STravelHandle:manualUpdate(deltaTime)
        -- BuffHandler:manualUpdate(deltaTime)
    else
        STravelHandle:updateTravel(deltaTime)
        -- BuffHandler:updateBuff(deltaTime)
    end
end

-- 开始加载前
function beforeLoad(self)
    super.beforeLoad(self)
    fight.SceneManager:onStartLoad()
end

-- 加载场景
function enterMap(self)
    super.enterMap(self)
    fight.SceneManager:enterMap()
end

function playSceneMusic(self)
    -- 战斗场景音乐自己管理
end

function onPlayRateChangeHandler(self)
    fight.TweenManager:setTimeScale(RateLooper:getPlayRate())
    fight.SceneItemManager:upateThingRate()
    fight.SceneGrid:setCameraAniSpeed(RateLooper:getPlayRate())
    STravelHandle:setNormalSpeed(RateLooper:getPlayRate())
    STravelHandle:setManualSpeed(RateLooper:getPlayRate())
end

-- 战斗结束重置地图相关
function onFightEndReset(self)
    self:clearMap()
    -- 退出战斗逻辑
    fight.FightManager:exitBattleLogic()
    RateLooper:removeFrameByIndex(self.m_checkSn)
    self.m_checkSn = nil
end

-- 战斗结束，返回旧场景
function onExitSceneHandler(self)
    UIFactory:startForcibly()
    self:onFightEndReset()

    -- 通知打开战斗前的功能Scene
    GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_SHOW_BEFORE_SCENE)
end

function onNormalFrameChange(self)
    fight.SceneItemManager:upateThingRate()
    if fight.LiveLooper:isNorFrameStop() then
        STravelHandle:setNormalSpeed(0)
    else
        STravelHandle:setNormalSpeed(RateLooper:getPlayRate())
    end
end

-- 关闭当前地图
function clearMap(self)
    PostHandler:resetChromatic()
    fight.SceneItemManager:reset()
    fight.SceneManager:clearMap()
    super.clearMap(self)
end

-- 地图类型
function getMapType(self)
    return MAP_TYPE.FIGHT_MAP
end

-- 地图资源名
function getMapID(self)
    return fight.SceneManager:getMapID()
    -- return "501"
end

-- 攻击者开始移动
function onAttackerMoveStart(self, arg)
    local thingDic = fight.SceneManager:getAllThing()
    for id, thing in pairs(thingDic) do
        thing:setVisibleByCamera(true, self)
    end

    local thingDic = fight.SceneManager:getAllThing()
    for id, thing in pairs(thingDic) do
        if thing:isAttacker() ~= arg.attacker:isAttacker() and thing ~= arg.target then
            local pos = thing:getCurPos()
            local dis = gs.TransQuick:PosDist(arg.targetPos, pos)
            if dis < 0.5 then
                local nowDis = gs.TransQuick:PosDist(pos, arg.pos)
                local v = arg.aniLenght / nowDis
                local t = v * (nowDis - 1)
                RateLooper:addTimer(t, 1, self,
                function()
                    thing:setVisibleByCamera(false, self)
                end)
                return
            end
        end
    end
end

-- 攻击者移动结束
function onAttackerMoveEnd(self, arg)

end
return _M

--[[ 替换语言包自动生成，请勿修改！
]]