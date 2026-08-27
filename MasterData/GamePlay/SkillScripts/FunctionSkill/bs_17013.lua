local bs_17013 = class("bs_17013", LuaSkillBase)
local base = LuaSkillBase
bs_17013.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3010,
    crit_formula = 0
  },
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 1
  },
  buffId = 2097,
  effectId = 60607,
  effectIdAttack = 60607,
  buffTier = 1
}

function bs_17013:ctor()
end

function bs_17013:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_17013_1", 1, self.OnAfterBattleStart)
  self.typenum = 2
end

function bs_17013:OnAfterBattleStart()
  self.damTimer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.CallBack, self, -1, self.arglist[1])
end

function bs_17013:CallBack()
  if self.damTimer ~= nil and self.damTimer:IsOver() then
    self.damTimer = nil
  end
  local roleslist = LuaSkillCtrl:CallTargetSelect(self, 1002, 10)
  if roleslist.Count > 1 then
    for i = 0, self.arglist[2] - 1 do
      LuaSkillCtrl:CallEffect(roleslist[0], self.config.effectIdAttack, self, self.SkillEventFunc)
    end
  end
  if roleslist.Count <= 1 then
    for i = 0, roleslist.Count - 1 do
      LuaSkillCtrl:CallEffect(roleslist[i], self.config.effectIdAttack, self, self.SkillEventFunc)
    end
  end
end

function bs_17013:SkillEventFunc(effect, eventId, target)
  local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
    self.arglist[3]
  }, true)
  LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buffId, self.config.buffTier, nil)
  skillResult:EndResult()
end

function bs_17013:OnCasterDie()
  base.OnCasterDie(self)
  if self.damTimer ~= nil then
    self.damTimer:Stop()
    self.damTimer = nil
  end
end

return bs_17013
