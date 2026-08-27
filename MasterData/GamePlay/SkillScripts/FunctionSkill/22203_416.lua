local bs_22203 = class("bs_22203", LuaSkillBase)
local base = LuaSkillBase
bs_22203.config = {
  effectId1 = 12046,
  effectId2 = 12047,
  effectId3 = 12048
}

function bs_22203:ctor()
end

function bs_22203:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_22203_1", 1, self.OnAfterBattleStart)
end

function bs_22203:OnAfterBattleStart()
  if self.caster.roleDataId ~= 1058 then
    return
  end
  local lv = self.caster.rank
  if lv < 8 and 0 <= lv then
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId1, self)
  elseif lv < 10 and 8 <= lv then
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId2, self)
  elseif 10 <= lv then
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId3, self)
  end
end

function bs_22203:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_22203
