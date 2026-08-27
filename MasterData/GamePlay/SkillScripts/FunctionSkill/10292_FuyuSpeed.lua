local bs_10292 = class("bs_10292", LuaSkillBase)
local base = LuaSkillBase
bs_10292.config = {buffId_fuyu = 1088, buff_jisu = 1202}

function bs_10292:ctor()
end

function bs_10292:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_10292_7", 1, self.OnAfterAddBuff, nil, nil, nil, nil, self.config.buffId_fuyu)
  self:AddBeforeBuffDispelTrigger("bs_10292_1", 1, self.BeforeBuffDispel, nil, nil, self.config.buffId_fuyu)
  self:AddBuffDieTrigger("bs_10292_2", 1, self.OnBuffDie, nil, nil, self.config.buffId_fuyu)
end

function bs_10292:OnAfterAddBuff(buff, target)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_jisu, buff.tier, nil, true)
end

function bs_10292:BeforeBuffDispel(targetRole, context)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buff_jisu, context.tier)
end

function bs_10292:OnBuffDie(buff, target, removeType)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buff_jisu, buff.tier, true)
end

function bs_10292:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10292
