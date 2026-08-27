local Feature_1021 = class("Feature_1021", LuaSkillBase)
local base = LuaSkillBase
Feature_1021.config = {effectId = 12063, effectId2 = 505}

function Feature_1021:ctor()
end

function Feature_1021:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "Feature_1021_1", 1, self.OnAfterBattleStart)
  self:AddSetDeadHurtTrigger("Feature_1021", 950, self.OnSetDeadHurt, nil, self.caster)
  self.effect = nil
end

function Feature_1021:OnAfterBattleStart()
  self.caster.recordTable.Feature_1021 = true
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId2, self)
  local timer = LuaSkillCtrl:StartTimer(self, self.arglist[1], function()
    self.caster.recordTable.Feature_1021 = false
    if self.effect ~= nil then
      self.effect:Die()
      self.effect = nil
    end
  end, 0)
end

function Feature_1021:OnSetDeadHurt(context)
  if self.caster.recordTable.Feature_1021 == true and context.target == self.caster then
    LuaSkillCtrl:CallAddPlayerHmp(ConfigData.game_config.ultMpCost * self.arglist[2] // 1000)
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
  end
end

function Feature_1021:OnCasterDie()
  base.OnCasterDie(self)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
end

return Feature_1021
