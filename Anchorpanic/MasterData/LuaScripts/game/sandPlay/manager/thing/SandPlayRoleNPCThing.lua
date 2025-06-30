-- @FileName:   SandPlayRoleNPCThing.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 12:00:06
-- @Copyright:   (LY) 2023 雷焰网络
module('game.sandPlay.thing.SandPlayRoleNPCThing', Class.impl(sandPlay.SandPlayNPCThing))

function resetData(self)
    super.resetData(self)

    self.mStopDistance = 0.1
end

function onModelLoadFinish(self)
    super.onModelLoadFinish(self)
    if self.mData.config.base_config.type == SandPlayConst.NPC_TYPE.MONSTER then
        self:addEffect("arts/fx/3d/scene/dx_101/fx_scene_dx_101_biaoji.prefab", -1)
    end

    self:playAction(SandPlayConst.NAME_STAND)

    self:move()
end

--移动
function move(self)
    if table.empty(self.mData.config.patrol_config) then
        return
    end

    if self.mData.config.base_config.collision_type ~= SandPlayConst.Collider_Type.CapsuleCollider then
        return
    end

    self:addNavmeshAgent()

    if self.mData.config.patrol_config.type == 1 then--来回顺着寻路
        self.mPatrolPath = {}
        local path = self.mData.config.patrol_config.path
        for i = 1, #path do
            table.insert(self.mPatrolPath, path[i])
        end

        table.insert(self.mPatrolPath, path[#path])

    elseif self.mData.config.patrol_config.type == 2 then --来回往返寻路
        self.mPatrolPath = {}
        local path = self.mData.config.patrol_config.path
        for i = 1, #path do
            table.insert(self.mPatrolPath, path[i])
        end

        for i = #path, 1, -1 do
            table.insert(self.mPatrolPath, path[i])
        end
    end

    if not table.empty(self.mPatrolPath) then
        if self:checkNextPatrolPos() then
            self:clearPatrolFrameSn()
            if self.mPatrolFrameSn == nil then
                self.mPatrolFrameSn = LoopManager:addFrame(1, 0, self, self.refreshPatrol)
            end
        end
    end
end

function refreshPatrol(self)
    local position = self:getPosition()
    if gs.Vector2.Distance(gs.Vector2(position.x, position.z), gs.Vector2(self.mPatrolPos.x, self.mPatrolPos.z)) <= self.mStopDistance then
        if not self:checkNextPatrolPos() then
            self:clearPatrolFrameSn()

            self:playAction(SandPlayConst.NAME_STAND)
        end
    else
        --是否正在准备计算路径
        if self.m_NavMeshAgent.pathPending then
            return
        end

        self:turnDirByVector(self.m_NavMeshAgent.nextPosition - position, 30)
        self:setPosition(self.m_NavMeshAgent.nextPosition)

        self:playAction(SandPlayConst.NAME_MOVE)
    end
end

function checkNextPatrolPos(self)
    if not self.mPatrolIndex then
        self.mPatrolIndex = 1
    elseif self.mPatrolIndex >= #self.mPatrolPath then
        self.mPatrolIndex = 1
    else
        self.mPatrolIndex = self.mPatrolIndex + 1
    end

    self.mPatrolPos = self.mPatrolPath[self.mPatrolIndex]

    self.m_NavMeshAgent:ResetPath()
    return self.m_NavMeshAgent:SetDestination(self.mPatrolPos)
end

function clearPatrolFrameSn(self)
    if self.mPatrolFrameSn ~= nil then
        self.mPatrolFrameSn = LoopManager:removeFrameByIndex(self.mPatrolFrameSn)
    end
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
        self.m_NavMeshAgent.speed = self.mData.config.patrol_config.speed
        -- 转弯角速度
        self.m_NavMeshAgent.angularSpeed = 120
        -- 加速度
        self.m_NavMeshAgent.acceleration = 100
        -- 距离目标位置的停止距离
        self.m_NavMeshAgent.stoppingDistance = self.mStopDistance
        -- 自动刹车，不开启可能会在目标点附近来回晃动
        self.m_NavMeshAgent.autoBraking = true

        -- agent半径
        self.m_NavMeshAgent.radius = self.mData.config.base_config.collision_range[1] * 0.01
        -- agent高度
        self.m_NavMeshAgent.height = 1
        -- 规避的质量水平，设定越高，权衡规避障碍的精度越高
        self.m_NavMeshAgent.obstacleAvoidanceType = gs.ObstacleAvoidanceType.LowQualityObstacleAvoidance
        -- 优先权
        self.m_NavMeshAgent.avoidancePriority = 0

        -- 自动跳跃链接
        self.m_NavMeshAgent.autoTraverseOffMeshLink = false
        -- 如果当前路径无效，尝试获得一个新的路径
        self.m_NavMeshAgent.autoRepath = true
    end
end

function getModel(self)
    return sandPlay.SandPlayPlayerModel.new()
end

function recover(self)
    super.recover(self)

    if self.m_NavMeshAgent == nil or gs.GoUtil.IsCompNull(self.m_NavMeshAgent) then
        gs.GameObject.Destroy(self.m_NavMeshAgent)
        self.m_NavMeshAgent = nil
    end
    
    self:clearPatrolFrameSn()
end

return _M
