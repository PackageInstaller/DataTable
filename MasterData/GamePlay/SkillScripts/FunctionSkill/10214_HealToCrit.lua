local bs_10214 = class("bs_10214", LuaSkillBase)
local base = LuaSkillBase
bs_10214.config = {buffId1 = 1041, buffId2 = 1057}

function bs_10214:ctor()
end

function bs_10214:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10214_1", 1, self.OnAfterBattleStart)
  self:AddSetHealTrigger("bs_10214_4", 1, self.OnSetHeal, nil, nil, nil, self.caster.belongNum)
end

function bs_10214:OnAfterBattleStart()
  self:PlayChipEffect()
end

function bs_10214:OnSetHeal(context)
  if context.target.belongNum == self.caster.belongNum and self:IsReadyToTake() and not context.isTriggerSet then
    self:OnSkillTake()
    LuaSkillCtrl:CallBuff(self, context.target, self.config.buffId2, 1, self.arglist[3], true)
  end
end

function bs_10214:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10214
