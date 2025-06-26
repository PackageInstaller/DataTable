-- @FileName:   DankeMonsterShootSkill_Dash2.lua
-- @Description:  怪物冲刺技能类
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.monsterSkill.DankeMonsterShootSkill_Dash', Class.impl(danke.DankeMonsterShootSkill_Dash1))

function resetData(self)
    super.resetData(self)

    self.m_dashDistance = self.m_skillVo.param[3] --冲撞距离
end

function onExecute(self)
    local playerThing = danke.DanKeSceneController:getPlayerThing()
    local playPos = playerThing:getPosition()
    local shootPos = self.m_executeThing:getPosition()
    local targetPos = playPos - shootPos
    self.m_dashForward = targetPos.normalized

    local executeThingConfig = self.m_executeThing:getData().config
    local size = executeThingConfig.agent_radius
    local scale = executeThingConfig:getScale()
    local data =
    {
        config = self.m_skillVo,
        size = size,
        scale = scale,
    }

    danke.DanKeSceneController:createMonterBullet(self.m_executeThing, self.m_skillVo.type, data)

    self:onUpdateSkillTips(self.m_dashForward, self.m_dashDistance, size, scale)

    self.m_executeThing:setCanAttack(false)
    self.m_executeThing:playAction("atk03")
end

return _M
