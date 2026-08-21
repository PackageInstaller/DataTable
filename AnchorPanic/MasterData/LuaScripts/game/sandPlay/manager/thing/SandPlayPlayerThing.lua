-- @FileName:   SandPlayPlayerThing.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.sandPlay.thing.SandPlayPlayerThing', Class.impl(sandPlay.SandPlayBaseThing))

function resetData(self)
    super.resetData(self)
    self.m_rotateSpeed = 30 --旋转 速度
    self.m_initStopDistance = 0.1
    self.m_stopDistance = self.m_initStopDistance --停止的距离

    self.isFindPathing = false
end

function createModel(self)
    super.createModel(self)
    self:addEventListener()
end

function onModelLoadFinish(self)
    super.onModelLoadFinish(self)

    -- --添加刚体/角色控制器
    self.m_CharacterController = self.mModel.m_rootGo:AddComponent(ty.CharacterController)
    gs.UnityEngineUtil.InitCharacterController(self.m_CharacterController, 30, 0.1, self.mData.config.agent_radius, self.mData.config.agent_height, gs.Vector3(0, self.mData.config.agent_height * 0.5, 0))

    if not self.mCollider or gs.GoUtil.IsCompNull(self.mCollider) then
        self.mColliderCall = self.mModel.m_rootGo:GetComponent(ty.ColliderCall)
        if not self.mColliderCall or gs.GoUtil.IsCompNull(self.mColliderCall) then
            self.mColliderCall = self.mModel.m_rootGo:AddComponent(ty.ColliderCall)
        end

        self.mColliderCall:InitSelfCollider()
        self.mColliderCall.SelfColliderTag = SandPlayConst.ColliderTag.Player
        self.mColliderCall.ColliderTagID = self.mData.id
    end

    --给自动恢复状态的动作添加最后一帧的帧事件，方便自动恢复状态
    for source_state, revert_State in pairs(SandPlayConst.AllowRevertState) do
        if revert_State.isAuto then
            local aniName = SandPlayConst.HERO_ACTIONSTATE_ACTHASH[source_state]
            local frameCount = self:GetTotalFrameCount(aniName)
            if frameCount > 0 then
                self:addFrameCallEvent(aniName, function ()
                    self:revertState()
                end, frameCount)
            end
        end
    end

    self:setActionState(SandPlayConst.HERO_ACTION_STATE.STAND)
    self:addNavmeshAgent()

    self.mSceneCameraTrans = gs.CameraMgr:GetSceneCameraTrans()
end

---添加寻路组件
function addNavmeshAgent(self)
    if not self.mModel then
        return
    end

    local m_rootGo = self.mModel.m_rootGo
    if m_rootGo then
        self.m_NavMeshAgent = gs.GoUtil.AddComponent(m_rootGo, ty.NavMeshAgent)

        -- 允许NavMesh旋转角色
        self.m_NavMeshAgent.updateRotation = false
        -- 允许NavMesh移动角色
        self.m_NavMeshAgent.updatePosition = false

        -- 根据配置来设定速度
        self.m_NavMeshAgent.speed = self.mData.config.normal_speed
        -- 转弯角速度
        self.m_NavMeshAgent.angularSpeed = 120
        -- 加速度
        self.m_NavMeshAgent.acceleration = 100
        -- 距离目标位置的停止距离
        self.m_NavMeshAgent.stoppingDistance = self.m_stopDistance
        -- 自动刹车，不开启可能会在目标点附近来回晃动
        self.m_NavMeshAgent.autoBraking = true

        -- agent半径
        self.m_NavMeshAgent.radius = self.mData.config.agent_radius
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

function addEventListener(self)
    GameDispatcher:addEventListener(EventName.FIELDEXPLORATION_JOYSTICK_UPDATE, self.onControlMove, self)

end

function removeEventListener(self)
    GameDispatcher:removeEventListener(EventName.FIELDEXPLORATION_JOYSTICK_UPDATE, self.onControlMove, self)
end

--控制移动
function onControlMove(self, args)
    if not self.mModel then
        return
    end

    self.mJoystickDir = args

    --开始移动
    if self.mJoystickDir.deltaRatioX == 0 and self.mJoystickDir.deltaRatioY == 0 then
        if not self.isFindPathing then
            -- self:revertState(SandPlayConst.HERO_ACTION_STATE.MOVE)
            self:revertState()

        end
    else
        if self.m_PauseCall then
            self.m_PauseCall()
            self.m_PauseCall = nil
        end
        self:resetFindPath()
        self:setActionState(SandPlayConst.HERO_ACTION_STATE.MOVE)
    end
end

--状态恢复(状态来源)
function revertState(self, stateSource)
    -- --如果当前状态还是与输入的状态一样，再判断是不是可以允许恢复的状态
    -- if stateSource ~= self.mCurActionState then
    --     return
    -- end

    stateSource = stateSource or self.mCurActionState

    local stateConst = SandPlayConst.AllowRevertState[stateSource]
    if stateConst then
        self:forceActionState(stateConst.reverState)
    end
end

--设置战员当前的动作状态
function setActionState(self, actionState)
    if actionState ~= SandPlayConst.HERO_ACTION_STATE.MOVE then
        if self.mCurActionState == actionState then
            return false
        end
    end

    if not self:canForceActionState() then
        return false
    end

    return self:forceActionState(actionState)
end

--当前状态是否允许打断
function canForceActionState(self)
    for _, state in pairs(SandPlayConst.NoAllowForceActionState) do
        if self.mCurActionState == state then
            return false
        end
    end

    return true
end

--强切状态
function forceActionState(self, actionState)
    self.mCurActionState = actionState

    if self.mCurActionState == SandPlayConst.HERO_ACTION_STATE.MOVE then
        if self.mSceneCameraTrans and not gs.GoUtil.IsTransNull(self.mSceneCameraTrans) then
            local dir = self.mSceneCameraTrans:TransformDirection(gs.Vector3(self.mJoystickDir.deltaRatioX, 0, self.mJoystickDir.deltaRatioY))
            self:turnDirByVector(dir, self.m_rotateSpeed)
            self:setTranForward(self.mData.config.normal_speed)
        end
    end

    local aniHash = SandPlayConst.HERO_ACTIONSTATE_ACTHASH[self.mCurActionState]
    if aniHash then
        self.mModel:playAction(aniHash)
    end

    return true
end

-------------------------------------------AI寻路
--停止寻路移动
function resetFindPath(self)
    if not self.isFindPathing then return end

    self.m_NavMeshAgent:ResetPath()
    self.m_CurFindPoint = nil
    self.m_MoveFinishCall = nil
    self.isFindPathing = false
    self.m_PauseCall = nil
    self.m_stopDistance = self.m_initStopDistance
    -- 距离目标位置的停止距离
    self.m_NavMeshAgent.stoppingDistance = self.m_stopDistance

    self:revertState()

    self:clearMoveFrameSn()
end

--设置寻路到某个点
function onFindPath(self, point, finishCall, actionState, pauseCall)
    if point == self.m_CurFindPoint then
        return
    end

    if not self.m_NavMeshAgent or gs.GoUtil.IsCompNull(self.m_NavMeshAgent) then
        return
    end

    if not self.m_NavMeshAgent.isOnNavMesh then
        gs.Message.Show("当前不在网格上，请重新换个位置试试")
        return
    end

    local position = self:getPosition()
    if gs.Vector2.Distance(gs.Vector2(position.x, position.z), gs.Vector2(point.x, point.z)) <= self.m_stopDistance then
        if finishCall then
            finishCall()
        end
        return
    end

    local isCanFind = self.m_NavMeshAgent:SetDestination(point)
    if isCanFind then
        self.isFindPathing = true
        self.m_CurFindPoint = point
        self.m_MoveFinishCall = finishCall
        self.m_PauseCall = pauseCall

        actionState = actionState or SandPlayConst.HERO_ACTION_STATE.AI_FIND
        self:setActionState(actionState)

        self:clearMoveFrameSn()
        if self.m_MoveFrameSn == nil then
            self.m_MoveFrameSn = LoopManager:addFrame(1, 0, self, self.updateMove)
        end
    end
end

----更新移动
function updateMove(self)
    local position = self:getPosition()
    if self.isFindPathing then
        if gs.Vector2.Distance(gs.Vector2(position.x, position.z), gs.Vector2(self.m_CurFindPoint.x, self.m_CurFindPoint.z)) <= self.m_stopDistance then
            if self.m_MoveFinishCall then
                self.m_MoveFinishCall()
            end
            self:resetFindPath()
        else
            --是否正在准备计算路径
            if self.m_NavMeshAgent.pathPending then
                return
            end

            self:turnDirByVector(self.m_NavMeshAgent.nextPosition - position, self.m_rotateSpeed, 10)
            self:setPosition(self.m_NavMeshAgent.nextPosition)
        end
    end
end

--清理计时器
function clearMoveFrameSn(self)
    if self.m_MoveFrameSn ~= nil then
        self.m_MoveFrameSn = LoopManager:removeFrameByIndex(self.m_MoveFrameSn)
    end
end

--------------------------------------------------其他公共

--获取帧数
function GetTotalFrameCount(self, clipName)
    if not self.mModel then
        return 0
    end
    return self.mModel:GetTotalFrameCount(clipName)
end

function addFrameCallEvent(self, acitonName, callback, frameCount)
    if self.mModel then
        self.mModel:addFrameCallEvent(acitonName, callback, frameCount)
    end
end

function addAssembly(self, prefabPath, beAlwayEft, finishCall)
    if self.mModel then
        return self.mModel:addAssembly(prefabPath, beAlwayEft, finishCall)
    end
end

function removeAssembly(self, prefabPath)
    if self.mModel then
        self.mModel:removeAssembly(prefabPath)
    end
end

function clearAssembly(self)
    if self.mModel then
        self.mModel:clearAssembly()
    end
end

function addWeapon(self, weaponPath, weaponType, beAlwayEft, finishCall)
    if self.mModel then
        return self.mModel:addWeapon(weaponPath, weaponType, beAlwayEft, finishCall)
    end
end

function removeWeapon(self)
    if self.mModel then
        return self.mModel:removeWeapon()
    end
end

--当前跟哪个NPC交互
function setCurFuncNPC(self, npc_id)
    self.mCurFuncNPC_id = npc_id
end

function getCurFuncNPC(self, npc_id)
    return self.mCurFuncNPC_id
end

function setField_Id(self, field_id)
    self.mField_id = field_id
end

function getField_Id(self, field_id)
    return self.mField_id
end

---寻路
function findPath(self, params)
    if not self:canForceActionState() then
        return false
    end

    if params.stopDistance then
        self.m_stopDistance = params.stopDistance
        -- 距离目标位置的停止距离
        self.m_NavMeshAgent.stoppingDistance = self.m_stopDistance
    end

    self:onFindPath(params.param, params.finishCall, params.actionState, params.pauseCall)
end

function setPosition(self, lpos)
    self.mModel:setPosition(lpos)
    GameDispatcher:dispatchEvent(EventName.SANDPLAY_PLAYERSTATE_MOVE, {isForthwith = true})
end

--前进
function setTranForward(self, speed, forward)
    forward = forward or self:getTrans().forward
    gs.UnityEngineUtil.CharacterControllerSimpleMove(self.m_CharacterController, forward * speed)

    self.m_NavMeshAgent:Warp(self:getPosition())

    GameDispatcher:dispatchEvent(EventName.SANDPLAY_PLAYERSTATE_MOVE, {isForthwith = true})
end

-- function getAllSkill(self)
--     return self.mSkillDic
-- end

-- function getSkill(self, skillTid)
--     if self.mSkillDic then
--         return self.mSkillDic[skillTid]
--     end
-- end

function getPrefabPath(self)
    return self.mData.config.hero_res
end

-- function clearTimeOutSn(self)
--     if self.mTimeOutSn then
--         LoopManager:clearTimeout(self.mTimeOutSn)
--         self.mTimeOutSn = nil
--     end
-- end

function clearData(self)
    self.mCurFuncNPC_id = nil
    self.m_CurFindPoint = nil
    self.m_MoveFinishCall = nil

    self.mData = nil
end

function getModel(self)
    return sandPlay.SandPlayPlayerModel.new()
end

function recover(self)
    super.recover(self)

    -- for _, skill in pairs(self.mSkillDic) do
    --     skill:recover()
    -- end

    self:removeEventListener()
    self:clearMoveFrameSn()
    self:clearData()

    -- self:clearTimeOutSn()
end

return _M
