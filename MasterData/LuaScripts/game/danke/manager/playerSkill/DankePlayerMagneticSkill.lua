-- @FileName:   DankePlayerMagneticSkill.lua
-- @Description:   玩家AT磁场技能类
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.playerSkill.DankePlayerMagneticSkill', Class.impl(danke.DankePlayerInitiativeSkill))

function resetData(self)
    super.resetData(self)

end

function refreshParam(self)
    super.refreshParam(self)
    self.m_radius = self.m_skillParam[1] * 0.01 --半径
end

function onExecute(self)
    super.onExecute(self)
    self:clearBullet()

    local playThing_attr = self.m_playerThing:getAttr()
    local data =
    {
        path = self.m_skillVo:getRes(),
        damage = self.m_bulletDamage,
        add_scale = playThing_attr.attact_range,
        params = self.m_skillLevel,

        radius = self.m_radius,
        born_pos = gs.Vector3(10000, 10000, 0),
    }
    self.m_bullet = danke.DanKeSceneController:createPlayerBullet(self.m_skillVo.type, self.m_skillVo.subtype, data)
end

function clearBullet(self)
    if self.m_bullet then
        self.m_bullet:poolRecover()
    end
end

function onRecover(self)
    super.onRecover(self)

    self.m_radius = nil
end

return _M
