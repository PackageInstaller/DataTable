local bs_15165 = class("bs_15165", LuaSkillBase)
local base = LuaSkillBase
bs_15165.config = {
  effect = 12095,
  effectId_1 = 12096,
  effectId_2 = 12097,
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 1
  },
  HurtConfig = 14
}

function bs_15165:ctor()
end

function bs_15165:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15165", 1, self.AfterBattleStart)
  self.grid = nil
  self.timer = nil
  self.timer_buff = nil
  self.buff_effect = nil
end

function bs_15165:AfterBattleStart()
  local gridCheck = BindCallback(self, self.checkLocation)
  self.grid = LuaSkillCtrl:GetGridWithRole(self.caster)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], gridCheck, nil, -1)
end

function bs_15165:checkLocation()
  local grid_old = self.grid
  local grid_new = LuaSkillCtrl:GetGridWithRole(self.caster)
  if grid_old ~= grid_new then
    if self.timer_buff ~= nil then
      self.timer_buff:Stop()
      self.timer_buff = nil
    end
    if self.buff_effect ~= nil then
      self.buff_effect = nil
    end
    self.grid = grid_new
    return
  end
  if self.timer_buff ~= nil then
    return
  end
  LuaSkillCtrl:CallEffect(self.caster, self.config.effect, self)
  self.buff_effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_1, self)
  self.timer_buff = LuaSkillCtrl:StartTimer(nil, self.arglist[2], BindCallback(self, self.CircleHit), nil, -1)
  self.grid = grid_new
end

function bs_15165:CircleHit()
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_2, self)
  local hp = self.caster.maxHp
  local sheild = LuaSkillCtrl:GetRoleAllShield(self.caster)
  local hurt = (hp + sheild) * self.arglist[3] // 1000
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster, self.config.aoe_config)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfig, {hurt})
  skillResult:EndResult()
end

function bs_15165:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  if self.timer_buff ~= nil then
    self.timer_buff:Stop()
    self.timer_buff = nil
  end
  if self.buff_effect ~= nil then
    self.buff_effect:Stop()
    self.buff_effect = nil
  end
end

return bs_15165
