-- @FileName:   SandPlayPoultryThing.lua
-- @Description:   家禽实体基础类
-- @Author: ZDH
-- @Date:   2023-07-25 12:00:06
-- @Copyright:   (LY) 2023 雷焰网络
module('game.sandPlay.thing.SandPlayPoultryThing', Class.impl(sandPlay.SandPlayOtherNPCThing))

function create(self)
    local item = self:poolGet()

    item:resetData()

    return item
end

function resetData(self)
    super.resetData(self)

    self.mStopDistance = 0.05
    self.mAvoidancePriority = 50 --寻路优先级
end

function setData(self, data, manageThing)
    self.mData = data
    self.mManageThing = manageThing

    self:setupModel()
end

--重构函数
function setupModel(self)
    local prefabPath = self:getPrefabPath()
    if string.NullOrEmpty(prefabPath) then
        return
    end

    -- if self.mModel then
    --     self:addEffectToScene("arts/fx/3d/sceneModule/dx_101/fx_farm_jinhua.prefab")
    -- end

    -- self:clearFindPathFrameSn()
    self:recoverModel()

    self.mModel = self:getModel()
    self.mModel:setupPrefab(prefabPath, false, function ()
        self:onModelLoadFinish()
    end)
end

function onModelLoadFinish(self)
    if self.mAIPoint == nil then
        self.mAIPoint = self.mManageThing:getAIFindPoint(self.mData.configVo.subtype)
        self:setPosition(self.mAIPoint.pos)
    else
        self:setPosition(self.mCurPos)
    end

    self:setAIMoveSpeed()
    self:setAIRadius()

    self:addNavmeshAgent()
    self:addCollider()

    self:startAI()
end

function addCollider(self)
    if not self.mColliderCall or gs.GoUtil.IsCompNull(self.mColliderCall) then
        self.mColliderCall = self.mModel.m_rootGo:GetComponent(ty.ColliderCall)
        if not self.mColliderCall or gs.GoUtil.IsCompNull(self.mColliderCall) then
            self.mColliderCall = self.mModel.m_rootGo:AddComponent(ty.ColliderCall)
        end
    end

    self.mColliderCall:InitCapsuleCollider(self:getAIRadius(), 1)
    self.mModel.m_rootGo:GetComponent(ty.CapsuleCollider).center = gs.Vector3(0, 0.5, 0)
end

function addNavmeshAgent(self)
    self.m_NavMeshAgent = self.mModel.m_rootGo:GetComponent(ty.NavMeshAgent)
    if self.m_NavMeshAgent == nil or gs.GoUtil.IsCompNull(self.m_NavMeshAgent) then
        self.m_NavMeshAgent = self.mModel.m_rootGo:AddComponent(ty.NavMeshAgent)

        -- 允许NavMesh旋转角色
        self.m_NavMeshAgent.updateRotation = false
        -- 允许NavMesh移动角色
        self.m_NavMeshAgent.updatePosition = false

        -- 根据配置来设定速度
        self.m_NavMeshAgent.speed = self:getAIMoveSpeed()
        -- 转弯角速度
        self.m_NavMeshAgent.angularSpeed = 120
        -- 加速度
        self.m_NavMeshAgent.acceleration = 100
        -- 距离目标位置的停止距离
        self.m_NavMeshAgent.stoppingDistance = self.mStopDistance
        -- 自动刹车，不开启可能会在目标点附近来回晃动
        self.m_NavMeshAgent.autoBraking = false

        -- agent半径
        self.m_NavMeshAgent.radius = self:getAIRadius()
        -- agent高度
        self.m_NavMeshAgent.height = 1
        -- 规避的质量水平，设定越高，权衡规避障碍的精度越高
        self.m_NavMeshAgent.obstacleAvoidanceType = gs.ObstacleAvoidanceType.LowQualityObstacleAvoidance
        -- 优先权
        self.m_NavMeshAgent.avoidancePriority = self.mAvoidancePriority

        -- 自动跳跃链接
        self.m_NavMeshAgent.autoTraverseOffMeshLink = false
        -- 如果当前路径无效，尝试获得一个新的路径
        self.m_NavMeshAgent.autoRepath = true
    end
end

function startAI(self)
    self:stopAI()

    local random = math.random(1, 20)
    if random <= 10 then
        local findPoint = self.mManageThing:getAIFindPoint(self.mData.configVo.subtype)
        if not findPoint then
            return
        end

        self.mManageThing:revertAIFindPoint(self.mAIPoint)
        self.mAIPoint = findPoint

        self.m_NavMeshAgent:ResetPath()
        if self.m_NavMeshAgent:SetDestination(self.mAIPoint.pos) then
            self.mFindPathFrameSn = LoopManager:addFrame(1, 0, self, self.refreshAI)
        else
            logError("错误AI寻路点，请找曹哥～　birth_range　＝　" .. self.mAIPoint.pos.x .. "," .. self.mAIPoint.pos.y .. "," .. self.mAIPoint.pos.z)
        end
    else

        local rand_AIStandTime = self.mData.configVo:getStandTime()
        self.mStandTimeSn = self:setTimeOut(rand_AIStandTime, function ()
            self:startAI()
        end)
    end
end

function stopAI(self)
    self:clearFindPathFrameSn()
    self:clearStandTimeSn()

    if self.m_NavMeshAgent ~= nil and not gs.GoUtil.IsCompNull(self.m_NavMeshAgent) then
        self.m_NavMeshAgent:ResetPath()
    end
    self:playAction("Qstand")
end

function refreshAI(self)
    if self.m_NavMeshAgent == nil or gs.GoUtil.IsCompNull(self.m_NavMeshAgent) then
        self:stopAI()
        return
    end

    local position = self:getPosition()
    if gs.Vector2.Distance(gs.Vector2(position.x, position.z), gs.Vector2(self.mAIPoint.pos.x, self.mAIPoint.pos.z)) <= self.mStopDistance then
        self:startAI()
    else
        --是否正在准备计算路径
        if self.m_NavMeshAgent.pathPending then
            return
        end

        self:playAction("Qwalk")

        self:turnDirByVector(self.m_NavMeshAgent.nextPosition - position, 10)
        self:setPosition(self.m_NavMeshAgent.nextPosition)
    end
end

function clearStandTimeSn(self)
    if self.mStandTimeSn then
        self:clearTimeOutSn(self.mStandTimeSn)
        self.mStandTimeSn = nil
    end
end

function clearFindPathFrameSn(self)
    if self.mFindPathFrameSn ~= nil then
        self.mFindPathFrameSn = LoopManager:removeFrameByIndex(self.mFindPathFrameSn)
        self.mFindPathFrameSn = nil
    end
end

function setAIMoveSpeed(self)
    local stageMoveSpeedList = self.mData.configVo.ai_params[3]
    self.mAIMoveSpeed = stageMoveSpeedList[self.mStage]
end

function getAIMoveSpeed(self)
    return self.mAIMoveSpeed or 1
end

function setAIRadius(self)
    local radiusList = {0.1, 0.2}
    self.mAIRadius = radiusList[self.mStage]
end

function getAIRadius(self)
    return self.mAIRadius or 1
end

function setPosition(self, lpos)
    super.setPosition(self, lpos)
    self.mCurPos = lpos
end

function recoverModel(self)
    if self.mModel then
        self.mModel:onRecover()
        self.mModel = nil
    end

    if self.m_NavMeshAgent == nil or gs.GoUtil.IsCompNull(self.m_NavMeshAgent) then
        gs.GameObject.Destroy(self.m_NavMeshAgent)
        self.m_NavMeshAgent = nil
    end

    if self.mColliderCall and not gs.GoUtil.IsCompNull(self.mColliderCall) then
        self.mColliderCall.onTriggerEnterCall = nil
        self.mColliderCall.onCollisionEnterCall = nil
        gs.GameObject.Destroy(self.mColliderCall)
        self.mColliderCall = nil
    end
end

function recover(self)
    super.recover(self)

    self:recoverModel()

    self:clearFindPathFrameSn()
end

return _M
