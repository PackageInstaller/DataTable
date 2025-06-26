-- @FileName:   ShootBrickTower.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.shootBrick.manager.ShootBrickTower', Class.impl(SimpleInsItem))

function setArgs(self, args)
    super.setArgs(self, args)

    self:clearTimeOutSn()
    self.m_timerSn = LoopManager:addTimer(args.interval, -1, self, self.onShoot)
end

function onShoot(self)
    if gs.Time.timeScale == 0 or shootBrick.ShootBrickManager:getOpenSettlementPanel() then
        return
    end

    local anchoredPosition_x = self:getTrans():GetComponent(ty.RectTransform).anchoredPosition.x
    if anchoredPosition_x < 0 then
        anchoredPosition_x = anchoredPosition_x - 66
    else
        anchoredPosition_x = anchoredPosition_x + 66
    end

    local bullet_pos = {x = self.m_args.imgBoard_rect.anchoredPosition.x + anchoredPosition_x, y = self.m_args.imgBoard_rect.anchoredPosition.y + 10}
    local args =
    {
        speed = self.m_args.speed,
        damage = self.m_args.damage,
        bullet_pos = bullet_pos
    }
    self.m_args.shoot_fun(self.m_args.shoot_class, args)
end

function clearTimeOutSn(self)
    if self.m_timerSn then
        LoopManager:removeTimerByIndex(self.m_timerSn)
        self.m_timerSn = nil
    end
end

function recover(self)
    super.recover(self)

    self:clearTimeOutSn()

end

return _M
