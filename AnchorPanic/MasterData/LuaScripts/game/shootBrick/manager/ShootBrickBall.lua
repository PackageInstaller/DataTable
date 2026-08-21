-- @FileName:   ShootBrickBall.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.shootBrick.manager.ShootBrickBall', Class.impl(SimpleInsItem))

function setArgs(self, args)
    super.setArgs(self, args)
    self.id = self.m_args.id

    self.mSpeedScale = 0.3

    self:setDamage(self.m_args.config.damage)
    self:setSpeed(self.m_args.config.speed)
    self:setScale(self.m_args.config.scale)

    self.mRectTrans = self:getGo():GetComponent(ty.RectTransform)

    self.mPhysicsFrame = self:getGo():GetComponent(ty.PhysicsFrame)
    if self.mPhysicsFrame == nil or gs.GoUtil.IsCompNull(self.mPhysicsFrame) then
        self.mPhysicsFrame = self:getGo():AddComponent(ty.PhysicsFrame)
    end

    self.mPhysicsCollision2D = self:getGo():GetComponent(ty.PhysicsCollision2D)
    if self.mPhysicsCollision2D == nil or gs.GoUtil.IsCompNull(self.mPhysicsCollision2D) then
        self.mPhysicsCollision2D = self:getGo():AddComponent(ty.PhysicsCollision2D)
    end

    self:getGo().layer = gs.LayerMask.NameToLayer("Physics_Move")

    self.mRigidBody2d = self:getGo():GetComponent(ty.Rigidbody2D)
end

function getCollider(self)
    return self:getGo():GetComponent(ty.Collider2D)
end

function refreshImg(self)
    local img = self:getGo():GetComponent(ty.AutoRefImage)
    img:SetImg(string.format("arts/ui/pack/shootBrick/shootBrick_ball_%s.png", self.damage), false)
end

function shoot(self, angle)
    angle = angle * gs.Mathf.Deg2Rad

    self.m_shootDir = gs.Vector2(0, 0)
    self.m_shootDir.x = gs.Mathf.Cos(angle)
    self.m_shootDir.y = gs.Mathf.Sin(angle)

    self.mPhysicsFrame:SetUpdateCall(self, self.onFixFrame)
    self.mPhysicsCollision2D:SetCollisionCallFun(self, self.onCollisionEnter, nil, nil)

    self.m_force = 0
    self.mRigidBody2d:AddForce(self.m_shootDir.normalized * self.speed)
end

function onCollisionEnter(self, collision2D)
    if self.onCollisionCallBack then
        self.onCollisionCallBack(self.onCheckCollisionClass, self, collision2D)
    end

    if self.mRigidBody2d then
        local addOffset = gs.Vector2(0, 0)
        if math.abs(self:getVelocity().x) < 0.05 then
            if math.random(1, 100) <= 50 then
                addOffset.x = 0.5
            else
                addOffset.x = -0.5
            end
        end

        if math.abs(self:getVelocity().y) < 0.05 then
            if math.random(1, 100) <= 50 then
                addOffset.y = 0.5
            else
                addOffset.y = -0.5
            end
        end

        if addOffset ~= gs.VEC2_ZERO then
            self:setVelocity(self:getVelocity() + addOffset)
        end
    end
end

function onFixFrame(self, fixedDeltaTime)
    if gs.Time.timeScale == 0 or shootBrick.ShootBrickManager:getOpenSettlementPanel() and(self:getVelocity() ~= gs.VEC2_ZERO) then
        self:setVelocity(gs.VEC2_ZERO)
        return
    end

    if self.onFixFrameCallBack then
        local state = self.onFixFrameCallBack(self.onCheckCollisionClass, self, self:getVelocity(), self.mRectTrans.anchoredPosition, ShootBrickConst.BallRadius * self.scale)
        if state then
            self:setVelocity(self:getVelocity() * gs.Vector2(1, -1))
        end
    end
end

--添加横向发射偏移角度
function addHorizontalOffset(self, offset)
    self:setVelocity(self:getVelocity() + gs.Vector2(offset, 0))
end

--添加移动速度
function addSpeed(self, val, max)
    if self.speed >= max then
        return
    end

    val = val * self.mSpeedScale
    max = max * self.mSpeedScale

    local addSpeed = val
    local speed = self.speed + val
    if speed >= max then
        addSpeed = max - self.speed
        speed = max
    end

    self.speed = speed

    self:setVelocity(self:getVelocity() + gs.Vector2(addSpeed, addSpeed))
end

function setVelocity(self, velocity)
    self.mRigidBody2d.velocity = velocity
end

function getVelocity(self)
    if self.mRigidBody2d then
        return self.mRigidBody2d.velocity
    end
end

function getSpeed(self)
    return self.speed
end

function setSpeed(self, value)
    self.speed = value * self.mSpeedScale
end

function setScale(self, val)
    self.scale = val

    gs.TransQuick:SizeDelta(self:getTrans():GetComponent(ty.RectTransform), self.m_args.size.width * self.scale, self.m_args.size.height * self.scale)
end

function getScale(self)
    return self.scale
end

function getDamage(self)
    return self.damage
end

function addDamage(self, val)
    self.damage = self.damage + val
    self:getChildGO("mTextDamage"):GetComponent(ty.Text).text = self.damage

    self:refreshImg()
end

function setDamage(self, value)
    self.damage = value

    self:getChildGO("mTextDamage"):GetComponent(ty.Text).text = self.damage

    self:refreshImg()
end

function setCheckCollision(self, checkClasee, fixFrameCallBack, collisionCallBack)
    self.onFixFrameCallBack = fixFrameCallBack
    self.onCollisionCallBack = collisionCallBack

    self.onCheckCollisionClass = checkClasee
end

-- 添加到父节点
function addOnParent01(self, parentTrans)
    self.m_trans:SetParent(parentTrans)
end

function recover(self)
    super.recover(self)

    self.mRigidBody2d = nil

    self.onFixFrameCallBack = nil
    self.onCollisionCallBack = nil
    self.onCheckCollisionClass = nil

    self.mRectTrans = nil

    self.id = nil
    self.m_args = nil

    self.damage = nil
    self.speed = nil
    self.scale = nil

    self.m_shootDir = nil

    self.mPhysicsFrame:SetUpdateCall(nil, nil)
    self.mPhysicsCollision2D:SetCollisionCallFun(nil, nil, nil, nil)

    gs.GameObject.Destroy(self.mPhysicsFrame)
    gs.GameObject.Destroy(self.mPhysicsCollision2D)

    self.mPhysicsFrame = nil
    self.mPhysicsCollision2D = nil
    self.mRigidBody2d = nil
end

return _M
