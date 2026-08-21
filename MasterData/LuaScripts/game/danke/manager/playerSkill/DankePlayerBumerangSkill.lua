-- @FileName:   DankePlayerBumerangSkill.lua
-- @Description:   玩家回旋镖技能类
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.playerSkill.DankePlayerBumerangSkill', Class.impl(danke.DankePlayerInitiativeSkill))

function resetData(self)
    super.resetData(self)

end

function refreshParam(self)
    super.refreshParam(self)

    self.m_minHorizontalSpeed = self.m_skillParam[1] --横向最小速度
    self.m_maxHorizontalSpeed = self.m_skillParam[2] --横向最大速度
    self.m_lifeTime = self.m_skillParam[3] * 0.001 --持续时间
    self.m_flyTime = self.m_skillParam[4] --飞行时间
    self.m_scale = self.m_skillParam[5] * 0.01 --基础倍数
end

function onExecute(self)
    super.onExecute(self)

    local playThing_attr = self.m_playerThing:getAttr()
    local horizontalSpeed = math.random(self.m_minHorizontalSpeed, self.m_maxHorizontalSpeed) * (1 + playThing_attr.add_bullet_flyspeed) --子弹飞行速度
    local fly_dir = self.m_playerThing:getMoveDir()
    local playerThing_pos = self.m_playerThing:getPosition()
    local born_pos = gs.Vector3(playerThing_pos.x, playerThing_pos.y, 0)


    local data =
    {
        path = self.m_skillVo:getRes(),
        params = self.m_skillLevel,
        add_scale = playThing_attr.attact_range,
        speed = horizontalSpeed,
        damage = self.m_bulletDamage,

        lifeTime = self.m_lifeTime,
        fly_Time = self.m_flyTime,
        scale = self.m_scale,
        fly_dir = fly_dir,
        born_pos = born_pos,
    }
    danke.DanKeSceneController:createPlayerBullet(self.m_skillVo.type, self.m_skillVo.subtype, data)
end

function onRecover(self)
    super.onRecover(self)

    self.m_lifeTime = nil
    self.m_flyTime = nil
    self.m_scale = nil
end

return _M
