local bs_30015 = class("bs_30015", LuaSkillBase)
local base = LuaSkillBase
bs_30015.config = {
  buffId2 = 1136,
  buffTier = 1,
  buffId_fuyu = 1088
}

function bs_30015:ctor()
end

function bs_30015:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_30015_7", 1, self.OnAfterAddBuff, nil, nil, nil, nil, self.config.buffId_fuyu)
  self:AddBeforeBuffDispelTrigger("bs_30015_1", 1, self.BeforeBuffDispel, nil, nil, self.config.buffId_fuyu)
  self:AddBuffDieTrigger("bs_30015_2", 1, self.OnBuffDie, nil, nil, self.config.buffId_fuyu)
end

function bs_30015:OnAfterAddBuff(buff, target)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, buff.tier, nil, true)
end

function bs_30015:BeforeBuffDispel(targetRole, context)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId2, context.tier)
end

function bs_30015:OnBuffDie(buff, target, removeType)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId2, buff.tier, true)
end

function bs_30015:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30015
