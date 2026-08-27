local bs_109101 = class("bs_109101", LuaSkillBase)
local base = LuaSkillBase
bs_109101.config = {
  effect_1 = 109104,
  buff_1 = 109101,
  buff_2 = 109105
}

function bs_109101:ctor()
end

function bs_109101:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_109101_01", 1, self.OnAfterBattleStart)
  self:AddAfterAddBuffTrigger("bs_109101_02", 2, self.OnAfterAddBuff, nil, nil, self.caster.belongNum, eBattleRoleBelong.enemy)
  self:AddSelfTrigger(eSkillTriggerType.OnBtRoleBreakStateEnter, "bs_109101_03", 3, self._OnEnterBreak)
  self.caster.recordTable.press_energy = 0
  self.press_energy = 0
end

function bs_109101:OnAfterBattleStart()
  self.caster.recordTable.press_energy = self.arglist[1]
  self.press_energy = self.arglist[1]
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_2, self.arglist[1])
  self.timerPowerCount = LuaSkillCtrl:StartTimer(nil, self.arglist[2], function()
    if self.caster.recordTable.press_energy < self.arglist[8] then
      self.caster.recordTable.press_energy = self.caster.recordTable.press_energy + 1
      self.press_energy = self.press_energy + 1
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_2, 1)
      if self.press_energy >= self.arglist[4] then
        self:OnEnergyBoom()
        self.press_energy = self.press_energy - self.arglist[4]
      end
      local shieldValue = self.caster.pow * self.arglist[9] // 1000
      LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, shieldValue)
    end
  end, nil, -1)
end

function bs_109101:OnAfterAddBuff(buff, target)
  if target ~= nil and target.hp > 0 and buff.buffCfg.IsControl and self.timerPowerCount ~= nil then
    local num = self.timerPowerCount.left - self.arglist[3]
    if 0 <= num then
      self.timerPowerCount.left = num
    else
      self.timerPowerCount.left = 0
    end
  end
end

function bs_109101:OnEnergyBoom()
  LuaSkillCtrl:CallEffect(self.caster, self.config.effect_1, self)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_1, 1, self.arglist[7])
  LuaSkillCtrl:CallReFillMainSkillCdForRole(self.caster)
end

function bs_109101:_OnEnterBreak(role)
  if role.belongNum == eBattleRoleBelong.enemy and role.hp > 0 then
    self:OnEnergyBoom()
  end
end

function bs_109101:OnCasterDie()
  base.OnCasterDie(self)
  if self.timerPowerCount ~= nil then
    self.timerPowerCount:Stop()
    self.timerPowerCount = nil
  end
end

function bs_109101:LuaDispose()
  base.LuaDispose(self)
  if self.timerPowerCount ~= nil then
    self.timerPowerCount:Stop()
    self.timerPowerCount = nil
  end
end

return bs_109101
