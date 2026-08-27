local Feature_1018 = class("Feature_1018", LuaSkillBase)
local base = LuaSkillBase
Feature_1018.config = {effectId = 12098, effectId2 = 505}

function Feature_1018:ctor()
end

function Feature_1018:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "Feature_1018_1", 1, self.OnAfterBattleStart)
  self:AddSetDeadHurtTrigger("Feature_1018", 950, self.OnSetDeadHurt, nil, self.caster)
  self.effect = nil
end

function Feature_1018:OnAfterBattleStart()
  self.caster.recordTable.Feature_1018 = true
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId2, self)
  local timer = LuaSkillCtrl:StartTimer(self, self.arglist[1], function()
    self.caster.recordTable.Feature_1018 = false
    if self.effect ~= nil then
      self.effect:Die()
      self.effect = nil
    end
  end, 0)
end

function Feature_1018:OnSetDeadHurt(context)
  if self.caster.recordTable.Feature_1018 == true and context.target == self.caster then
    LuaSkillCtrl:AddCacheGold(self.arglist[2])
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
    LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnAddMoneyInBattle)
  end
end

function Feature_1018:OnCasterDie()
  base.OnCasterDie(self)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
end

return Feature_1018
