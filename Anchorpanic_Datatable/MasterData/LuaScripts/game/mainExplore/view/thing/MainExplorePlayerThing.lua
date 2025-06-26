--[[
-----------------------------------------------------
@filename       : MainExplorePlayerThing
@Description    : 主线探索主角
@date           : 2022-2-11
@Author         : Zzz
@copyright      : (LY) 2018 雷焰网络
-----------------------------------------------------
]]
module("mainExplore.MainExplorePlayerThing", Class.impl(mainExplore.MainExploreBaseThing))

--构造函数
function ctor(self)
    super.ctor(self)
end

function onAwake(self)
    super.onAwake(self)
end

function onRecover(self)
    super.onRecover(self)
end

function initData(self)
    super.initData(self)
    self.mThingVo = nil
end

-- 主线探索：回收时父类会调用dtor，已经回收到对象池了定时销毁也会触发，所以要确保该方法逻辑做好无数据的判断
function destroy(self)
    self:removeNavMeshAgent()
    super.destroy(self)
end

function setData(self, thingVo, aiCtrl, loadFinish)
    self.mThingVo = thingVo
    self:setAiCtrl(aiCtrl)
    self:setEnableUpdate(true)
    local _loadFinish = function()
        self:initTrans()
        if(loadFinish)then
            loadFinish()
        end
    end
    local heroTid = self.mThingVo:getPlayerConfigVo().heroTid
    if(self.mThingVo:getType() == mainExplore.ThingType.PLAYER)then
        local heroId = hero.HeroManager:getHeroIdByTid(heroTid)
        local heorVo = hero.HeroManager:getHeroVo(heroId)
        if heorVo then
            self:setModelID(heorVo:getHeroModel(), 0, _loadFinish)
            return
        end
    end
    self:setTID(heroTid, 0, _loadFinish)
end

function initTrans(self)
    -- 添加代理（代理和实体分开）
    self:addNavMeshAgent()
    -- 代理位置初始化
    self:setAgentPosition(self.mThingVo:getPosition())
    self:setRotation(self.mThingVo:getRotation())
    self:setScale(self.mThingVo:getScale())
    self:getTrans().name = "event_thing_player"
end

function getThingVo(self)
    return self.mThingVo
end

function getPlayerConfigVo(self)
    return self.mThingVo:getPlayerConfigVo()
end

function addNavMeshAgent(self)
    self.mNavMeshAgent = gs.GoUtil.AddComponent(self:getRootGO(), ty.NavMeshAgent)
    -- 允许NavMesh旋转角色
    self.mNavMeshAgent.updateRotation = false
    -- 允许NavMesh移动角色
    self.mNavMeshAgent.updatePosition = false
    -- 允许NavMesh开启
    self.mNavMeshAgent.enabled = true
    
    -- 根据配置来设定速度
    self.mNavMeshAgent.speed = 3.5
    -- 转弯角速度
    self.mNavMeshAgent.angularSpeed = 120
    -- 加速度
    self.mNavMeshAgent.acceleration = 8
    -- 距离目标位置的停止距离
    self.mNavMeshAgent.stoppingDistance = 0
    -- 自动刹车，不开启可能会在目标点附近来回晃动
    self.mNavMeshAgent.autoBraking = true
    
    -- agent半径
    self.mNavMeshAgent.radius = self:getPlayerConfigVo().agentRadius
    -- agent高度
    self.mNavMeshAgent.height = self:getPlayerConfigVo().agentHeight
    -- 规避的质量水平，设定越高，权衡规避障碍的精度越高
    self.mNavMeshAgent.obstacleAvoidanceType = gs.ObstacleAvoidanceType.NoObstacleAvoidance
    -- 优先权
    self.mNavMeshAgent.avoidancePriority = 50

    -- 自动跳跃链接
    self.mNavMeshAgent.autoTraverseOffMeshLink = true
    -- 如果当前路径无效，尝试获得一个新的路径
    self.mNavMeshAgent.autoRepath = true
end

function removeNavMeshAgent(self)
    self:agentStopMove()
    if (self:getRootGO() and not gs.GoUtil.IsGoNull(self:getRootGO())) then
        gs.GoUtil.RemoveComponent(self:getRootGO(), ty.NavMeshAgent)
    end
    self.mNavMeshAgent = nil
end

function getNavMeshAgent(self)
    return self.mNavMeshAgent
end

function setAgentPosition(self, targetPos)
    if(self.mNavMeshAgent)then
        self.mNavMeshAgent:Warp(targetPos)
    end
end

function agentMove(self, offsetVector3)
    if(self.mNavMeshAgent)then
        self.mNavMeshAgent:Move(offsetVector3)
    end
end

function agentMoveTo(self, targetPos, stopDistance)
    if(self.mNavMeshAgent)then
        self.mNavMeshAgent.destination = targetPos
        self.mNavMeshAgent.stoppingDistance = stopDistance or 0
    end
end

function agentStopMove(self)
    if(self.mNavMeshAgent)then
        self.mNavMeshAgent:ResetPath()
        self.mNavMeshAgent.isStopped = true
    end
end

-- 是否在网格上
function isOnNavMesh(self)
    if(self.mNavMeshAgent)then
        return self.mNavMeshAgent.isOnNavMesh
    end
end

function addEvents(self)
    super.addEvents(self)
    if(self.mThingVo)then
        self.mThingVo:addEventListener(self.mThingVo.MOVE_CHANGE_NOW, self.onMoveChangeNowHandler, self)
    end
end

function removeEvents(self)
    super.removeEvents(self)
    if(self.mThingVo)then
        self.mThingVo:removeEventListener(self.mThingVo.MOVE_CHANGE_NOW, self.onMoveChangeNowHandler, self)
    end
end

-- 强制改变坐标同时强制同步Agent
function onMoveChangeNowHandler(self)
    self:setPosition(self.mThingVo:getPosition())
    self:setAgentPosition(self.mThingVo:getPosition())
end

function onMoveChangeHandler(self, args)
    self:setPosition(self.mThingVo:getPosition())
end

function onDirChangeHandler(self, args)
    self:setRotation(self.mThingVo:getRotation())
end

function onScaleChangeHandler(self, args)
    self:setScale(self.mThingVo:getScale())
end

-- 帧更新
function onUpdateFrameHandler(self, deltaTime)
    if(not self:getEnableUpdate())then
        self:setBehaviorState(mainExplore.BehaviorState.IDLE, nil, nil)
    end
    super.onUpdateFrameHandler(self, deltaTime)
    if(self.mNavMeshAgent)then
        local nextPosition = self.mNavMeshAgent.nextPosition
        if(nextPosition)then
            self.mThingVo:setPosition(nextPosition)
        end
    end
end

-- 目标点移动
function moveStpe(self, deltaTime, nextPos, range, moveSpeed, gravity)
    local dir = (nextPos - self:getPosition()):normalize()
    if(not mainExplore.isZeroVector3(dir))then
        local targetRotation = gs.Quaternion.LookRotation(dir)
        if (gs.Quaternion.Angle(self:getRotation(), targetRotation) > 1) then
            self.mThingVo:setRotation(gs.Quaternion.Slerp(self:getRotation(), targetRotation, 10 * deltaTime))
        end
    end
    local offsetVector3 = math.Vector3(dir.x, gravity or 0, dir.z) * moveSpeed * deltaTime
    self:agentMove(offsetVector3)

    if (math.v3Distance(nextPos, self.mThingVo:getPosition()) < (range or 0) + 0.1) then
        if(not self:isPlayingState(mainExplore.BehaviorState.IDLE))then
            self:setBehaviorState(mainExplore.BehaviorState.IDLE)
        end
        self:agentStopMove()
    else
        if(not self:isPlayingState(mainExplore.BehaviorState.PLAYER_TARGET_POS_RUN))then
            self:setBehaviorState(mainExplore.BehaviorState.PLAYER_TARGET_POS_RUN)
        end
    end
end

function setVisible(self, visible)
    local isRecoverAction = self.mCurVisible ~= visible and visible == true
    super.setVisible(self, visible)
    if(isRecoverAction)then
        super.recoverBehaviorState(self, nil, nil)
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
