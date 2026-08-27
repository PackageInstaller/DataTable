local bs_107502 = class("bs_107502", LuaSkillBase)
local base = LuaSkillBase
bs_107502.config = {
  heal_config = {baseheal_formula = 3021},
  shieldFormula = 3021,
  selectId = 2,
  selectRange = 10,
  buff_test = 107502,
  test_effect = 105909,
  buff_test_big = 107504,
  test_big_effect = 107501,
  buffId_atkUp = 107505,
  skill_time = 15,
  start_time = 7,
  actionId = 1002,
  act_speed = 1,
  banList = {271, 3004},
  effectId_cast = 107509,
  effectId_taunt = 107511
}

function bs_107502:ctor()
end

function bs_107502:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("107402_KimieSkill_4", 1, self.OnAfterAddBuff, nil, nil, nil, nil, self.config.buff_test_big)
end

function bs_107502:PlaySkill(data)
  local testRole = self.caster.recordTable["107501_testRole"]
  if testRole ~= nil and testRole:GetBuffTier(self.config.buff_test) > 0 then
    self.caster:LookAtTarget(testRole)
    self:CallCasterWait(self.config.skill_time)
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_cast, self)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, testRole, data)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.act_speed, self.config.start_time, attackTrigger)
  end
end

function bs_107502:OnAttackTrigger(role, target, data)
  LuaSkillCtrl:CallBuff(self, role, self.config.buff_test_big, 1, self.arglist[6])
  LuaSkillCtrl:CallEffect(role, self.config.effectId_taunt, self)
end

function bs_107502:OnAfterAddBuff(buff, target)
  local shieldValue = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.shieldFormula, self.caster, nil, self, self.arglist[3])
  LuaSkillCtrl:AddRoleShield(target, eShieldType.Normal, shieldValue)
end

function bs_107502:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_107502
