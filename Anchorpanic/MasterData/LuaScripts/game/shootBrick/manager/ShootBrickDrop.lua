-- @FileName:   ShootBrickDrop.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.shootBrick.manager.ShootBrickDrop', Class.impl(SimpleInsItem))

function setArgs(self, args)
    super.setArgs(self, args)

    self:setPos(self.m_args.pos.x, self.m_args.pos.y)

    self:refreshImg()
    self.speed = 1

    self:clearFrame()
    self.m_frameSn = LoopManager:addFrame(1, 0, self, self.onFrame)
end

function refreshImg(self)
    local config = shootBrick.ShootBrickManager:getPropConfigVo(self.m_args.config_id)

    local img = self:getGo():GetComponent(ty.AutoRefImage)
    img:SetImg(config:getIconPath())
end

function onFrame(self)
    if gs.Time.timeScale == 0 or shootBrick.ShootBrickManager:getOpenSettlementPanel() then
        return
    end

    local trans = self:getTrans()
    trans:Translate(gs.Vector3.down * gs.Time.deltaTime * self.speed, gs.Space.World)

    if self.onCheckCollisionFun then
        if self.onCheckCollisionFun(self.onCheckCollisionClass, self) then
            return
        end
    end

    if trans:GetComponent(ty.RectTransform).anchoredPosition.y <= (self.m_args.screen_height + 50) *- 1 then
        if self.m_args.recoverFun then
            self.m_args.recoverFun(self.m_args.recoverFunClass, self.m_args.id)
        end
    end
end

function clearFrame(self)
    if self.m_frameSn then
        LoopManager:removeFrameByIndex(self.m_frameSn)
        self.m_frameSn = nil
    end
end

function setCheckCollision(self, checkClasee, checkFun)
    self.onCheckCollisionFun = checkFun
    self.onCheckCollisionClass = checkClasee
end

function recover(self)
    super.recover(self)

    self:clearFrame()

    self.onCheckCollisionFun = nil
    self.onCheckCollisionClass = nil
end

return _M
