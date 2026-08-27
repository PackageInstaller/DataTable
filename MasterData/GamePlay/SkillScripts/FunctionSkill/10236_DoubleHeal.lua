local bs_10236 = class("bs_10236", LuaSkillBase)
local base = LuaSkillBase
bs_10236.config = {buffId = 1089, buffTier = 1}

function bs_10236:ctor()
end

function bs_10236:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHealTrigger("bs_10236_4", 1, self.OnSetHeal, self.caster)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10236_1", 1, self.OnAfterBattleStart)
end

function bs_10236:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
end

function bs_10236:OnSetHeal(context)
  if context.sender == self.caster and self:IsReadyToTake() and not context.isTriggerSet then
    self:OnSkillTake()
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 26, 10)
    if targetlist.Count < 1 then
      return
    end
    LuaSkillCtrl:CallHeal(context.heal, self, targetlist[0].targetRole, true)
  end
end

function bs_10236:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10236
