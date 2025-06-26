-- @FileName:   ShootBrickTowerBullet.lua
-- @Description:   炮台
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.shootBrick.manager.ShootBrickTowerBullet', Class.impl(SimpleInsItem))

function setArgs(self, args)
    super.setArgs(self, args)

    self:clearFrame()
    self.m_frameSn = LoopManager:addFrame(1, 0, self, self.onFrame)
end

function setCheckCollision(self, checkClasee, checkFun)
    self.onCheckCollisionFun = checkFun
    self.onCheckCollisionClass = checkClasee
end

function onFrame(self)
   if gs.Time.timeScale == 0 or shootBrick.ShootBrickManager:getOpenSettlementPanel() then
        return
    end

    local trans = self:getTrans()
    trans:Translate(gs.Vector3.up * gs.Time.deltaTime * self.m_args.speed, gs.Space.World)

    local anchoredPosition = self:getTrans():GetComponent(ty.RectTransform).anchoredPosition
    if self.onCheckCollisionFun then
        if self.onCheckCollisionFun(self.onCheckCollisionClass, self, {x = anchoredPosition.x, y = anchoredPosition.y}) then
            return
        end
    end
    if trans:GetComponent(ty.RectTransform).anchoredPosition.y > self.m_args.height * 0.5 + 20 then
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

function recover(self)
    super.recover(self)

    self:clearFrame()

    self.onCheckCollisionFun = nil
    self.onCheckCollisionClass = nil
end

return _M
