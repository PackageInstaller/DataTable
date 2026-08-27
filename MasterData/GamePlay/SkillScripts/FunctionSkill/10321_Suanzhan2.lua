local bs_10321 = class("bs_10321", LuaSkillBase)
local base = LuaSkillBase
bs_10321.config = {
  buffWKId = 1248,
  buffSL = 1249,
  buffEWSL = 1250
}

function bs_10321:ctor()
end

function bs_10321:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10321_1", 1, self.OnAfterBattleStart)
  self:AddAfterAddBuffTrigger("bs_10321_7", 1, self.OnAfterAddBuff, nil, self.caster, nil, nil, self.config.buffWKId)
  self:AddBeforeBuffDispelTrigger("bs_10321_1", 1, self.BeforeBuffDispel, self.caster, nil, self.config.buffWKId)
  self:AddBuffDieTrigger("bs_10321_2", 1, self.OnBuffDie, self.caster, nil, self.config.buffWKId)
end

function bs_10321:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffSL, 1, nil, true)
end

function bs_10321:OnAfterAddBuff(buff, target)
  if buff.dataId == self.config.buffWKId then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffEWSL, 1, nil, true)
  end
end

function bs_10321:BeforeBuffDispel(targetRole, context)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffEWSL, 0)
end

function bs_10321:OnBuffDie(buff, target, removeType)
  if buff.dataId == self.config.buffWKId then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffEWSL, 0)
  end
end

function bs_10321:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10321
