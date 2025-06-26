-- @FileName:   ShootBrickBall.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.shootBrick.manager.ShootBrickBall', Class.impl(SimpleInsItem))

function setArgs(self, args)
    super.setArgs(self, args)
    self.id = self.m_args.id

    self:setDamage(self.m_args.config.damage)
    self:setSpeed(self.m_args.config.speed)
    self:setScale(self.m_args.config.scale)

    self.mRectTrans = self:getGo():GetComponent(ty.RectTransform)
end

function refreshImg(self)
    local img = self:getGo():GetComponent(ty.AutoRefImage)
    img:SetImg(string.format("arts/ui/pack/shootBrick/shootBrick_ball_%s.png", self.damage), false)
end

function shoot(self, angle)
    angle = angle * gs.Mathf.Deg2Rad

    self.m_shootDir = gs.Vector3(0, 0, 0)
    self.m_shootDir.x = gs.Mathf.Cos(angle)
    self.m_shootDir.y = gs.Mathf.Sin(angle)

    self:clearFrame()
    self.m_frameSn = LoopManager:addFrame(1, 0, self, self.onFrame)
end

function onFrame(self)
    if gs.Time.timeScale == 0 or shootBrick.ShootBrickManager:getOpenSettlementPanel() then
        return
    end

    if self.onCheckCollisionFun then
        local dir = self.onCheckCollisionFun(self.onCheckCollisionClass, self, self.m_shootDir, self.mRectTrans.anchoredPosition, ShootBrickConst.BallRadius * self.scale)
        if dir == nil then
            return
        end

        self.m_shootDir.x = dir.x
        self.m_shootDir.y = dir.y
    end

    self:getTrans():Translate(self.m_shootDir.normalized * self.speed, gs.Space.World)
end

function clearFrame(self)
    if self.m_frameSn then
        LoopManager:removeFrameByIndex(self.m_frameSn)
        self.m_frameSn = nil
    end
end

--添加横向发射偏移角度
function addHorizontalOffset(self, offset)
    self.m_shootDir.x = self.m_shootDir.x + offset
end

--添加移动速度
function addSpeed(self, val, max)
    if self.speed >= max then
        return
    end
    self.speed = self.speed * (1 + val)

    if self.speed >= max then
        self.speed = max
    end
end

function getSpeed(self)
    return self.speed
end

function setSpeed(self, value)
    self.speed = value
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

function setCheckCollision(self, checkClasee, checkFun)
    self.onCheckCollisionFun = checkFun
    self.onCheckCollisionClass = checkClasee
end

-- 添加到父节点
function addOnParent01(self, parentTrans)
    self.m_trans:SetParent(parentTrans)
end

function recover(self)
    super.recover(self)

    self:clearFrame()

    self.onCheckCollisionFun = nil
    self.onCheckCollisionClass = nil

    self.mRectTrans = nil

    self.id = nil
    self.m_args = nil

    self.damage = nil
    self.speed = nil
    self.scale = nil

    self.m_shootDir = nil

end

return _M
