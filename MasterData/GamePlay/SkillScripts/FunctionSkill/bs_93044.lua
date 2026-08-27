local bs_93044 = class("bs_93044", LuaSkillBase)
local base = LuaSkillBase
bs_93044.config = {buffId = 2073}

function bs_93044:ctor()
end

function bs_93044:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetDeadHurtTrigger("bs_93044_1", 900, self.OnSetDeadHurt, self.caster)
end

function bs_93044:OnSetDeadHurt(context)
  if context.sender ~= self.caster then
    return
  end
  if context.skill.skillTag ~= eSkillTag.ultSkill then
    return
  end
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1], nil, false)
  LuaSkillCtrl:CallAddPlayerHmp(ConfigData.game_config.ultMpCost * self.arglist[2] // 1000)
end

function bs_93044:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_93044
