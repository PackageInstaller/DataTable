module('lib.component.SceneGyro', Class.impl())

-- 构造函数
function ctor(self)
    self.m_sn = SnMgr:getSn()
end

-- 连接对象
function attach(self, roleView, sceneGo)
    local roleNode = gs.GameObject.Find("Role_node")
    if roleView == nil or roleNode == nil then
        return
    end

    roleNode.transform:SetParent(sceneGo.transform, true)

    self.mRoleView = roleView
    self.mSceneTrans = sceneGo.transform
    self.mSceneCameraTrans = gs.CameraMgr:GetSceneCameraTrans()
    self.spineNode = self.mRoleView:getPointTrans(fight.FightDef.POINT_SPINE)
    if not self.spineNode then
        return
    end
    self.spineNodePos = self.mSceneTrans.parent:InverseTransformPoint(self.spineNode.position) -- 胸部挂点位置转换为相机挂点的位置

    self.spineNodePos = math.Vector3(self.spineNodePos.x, self.spineNodePos.y, self.spineNodePos.z - 8)
    self.initialRotation = self.mSceneCameraTrans.rotation -- 保存初始旋转

    -- 添加新的成员变量
    self.roleTransform = gs.GameObject.Find("Role_node").transform

    -- 在attach函数中初始化角色的初始位置和旋转
    self.initialRolePos = self.roleTransform.position
    self.initialRoleRot = self.roleTransform.rotation

    -- 限制陀螺仪旋转加速度
    self.clampAngle = gs.Mathf.PI

    -- 累加X值
    self.allX = 0
    -- 累加Y值
    self.allY = 0
    self.velocity = self.velocity or gs.Vector3.zero

    -- 是否正在运行
    self.run = false
    -- 是否在进行移动操作
    self.moveMode = false
    self.angleLimit = 2.5 -- 角度限制
    self.lerpSpeed = 3    -- 插值速度，用于控制回正速度

    if self.mLoop then
        LoopManager:removeFrameByIndex(self.mLoop)
        self.mLoop = nil
    end
    self.mLoop = LoopManager:addFrame(1, 0, self, self.update)
end

-- 设置模型移动
function setMoveModel(self, bo)
    self.moveMode = bo
end

-- 设置是否运行
function setRun(self, bo)
    self.run = bo
end

-- 重置位置
function resetTran(self)
    if self.mSceneTrans and self.allY then
        self.mSceneTrans:RotateAround(self.spineNodePos, gs.Vector3.up, -self.allY)
    end
    self.allY = 0
end

function update(self)
    if gs.Input.gyro.enabled == false or self.run == false or self.moveMode == true then
        return
    end

    local gyroRotationRate = gs.UnityEngineUtil.GetGyroRotationRateUnbiased()
    local xRotationRate = gyroRotationRate[0] * self.angleLimit
    local yRotationRate = gyroRotationRate[1] * self.angleLimit

    -- 通过四元数创建目标旋转
    local targetRotation = gs.Quaternion.Euler(xRotationRate, yRotationRate, 0)
    self.mSceneCameraTrans.rotation = gs.Quaternion.Slerp(self.mSceneCameraTrans.rotation,
        self.initialRotation * targetRotation, gs.Time.deltaTime * self.lerpSpeed)

    -- 基于陀螺仪旋转的角色位置偏移
    local positionOffset = self.mSceneCameraTrans.right * yRotationRate * 0.08
    local roleTargetPos = self.initialRolePos + positionOffset
    self.roleTransform.position = gs.Vector3.Lerp(self.roleTransform.position, roleTargetPos,
        gs.Time.deltaTime * self.lerpSpeed)
end

-- 限制旋转角度的函数
function clampRotation(self, rotation)
    rotation.x = math.max(math.min(rotation.x, self.angleLimit), -self.angleLimit)
    rotation.y = math.max(math.min(rotation.y, self.angleLimit), -self.angleLimit)
    return rotation
end

function easeInExpo(self, sPos, count)
    if count == 0 then
        return sPos
    else
        return sPos * gs.Mathf.Pow(2, -8 * (1 - count))
    end
end

function removeSelf(self)
    SnMgr:disposeSn(self.m_sn)
    self:resetTran(false)
    self.m_sn = nil
    self.m_go = nil
    if self.mLoop then
        LoopManager:removeFrameByIndex(self.mLoop)
        self.mLoop = nil
    end
    self.mSceneCameraTrans = nil
end

-- 移除
function removeGyro(self)
    self:removeSelf()
end

return _M