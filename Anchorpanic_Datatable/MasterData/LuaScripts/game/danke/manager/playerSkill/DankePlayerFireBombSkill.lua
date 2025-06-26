-- @FileName:   DankePlayerFireBombSkill.lua
-- @Description:   玩家燃烧瓶技能类
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.playerSkill.DankePlayerFireBombSkill', Class.impl(danke.DankePlayerInitiativeSkill))

function resetData(self)
    super.resetData(self)
end

function refreshParam(self)
    super.refreshParam(self)
    self.m_fireScale = self.m_skillParam[1] * 0.01 --火焰大小
    self.m_bulletDistance = self.m_skillParam[4] --子弹飞行距离
    self.m_fireResPath = "arts/fx/3d/sceneModule/danke/" .. self.m_skillParam[5]
end

function onExecute(self)
    super.onExecute(self)

    local skillType = self.m_skillVo.type
    local skillSubType = self.m_skillVo.subtype

    local playThing_attr = self.m_playerThing:getAttr()

    local fly_dir = self.m_playerThing:getMoveDir()
    local playerThing_pos = self.m_playerThing:getPosition()
    local born_pos = gs.Vector3(playerThing_pos.x, playerThing_pos.y, 0)

    local data =
    {
        path = self.m_skillVo:getRes(),
        damage = self.m_bulletDamage,
        add_scale = playThing_attr.attact_range,
        params = self.m_skillLevel,
        speed = self.m_bulletSpeed,

        bullet_distance = self.m_bulletDistance,
        fire_resPath = self.m_fireResPath,
        scale =  self.m_fireScale,

        fly_dir = fly_dir,
        born_pos = born_pos,

        skill_type = skillType,
        skill_subType = skillSubType,
        is_bullet = true,
    }
    danke.DanKeSceneController:createPlayerBullet(skillType, skillSubType, data)
end

function onRecover(self)
    super.onRecover(self)

    self.m_bulletDistance = nil
    self.m_fireResPath = nil
end

return _M
