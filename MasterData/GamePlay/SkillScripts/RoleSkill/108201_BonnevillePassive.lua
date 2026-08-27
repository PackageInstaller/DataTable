local bs_108201 = class("bs_108201", LuaSkillBase)
local base = LuaSkillBase
bs_108201.config = {
  BuffProtect = 108201,
  effectHD = 108204,
  buffMark = 108203,
  effectLine = 108206,
  effectN2 = 108214,
  shieldFormula = 3020,
  realDamage = {
    basehurt_formula = 502,
    lifesteal_formula = 0,
    spell_lifesteal_formula = 0,
    returndamage_formula = 0
  }
}

function bs_108201:ctor()
end

function bs_108201:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_108202_01", 1, self.OnAfterBattleStart)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRolePhaseMoveStart, self.OnRolePhaseMoveStart)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRoleSplash, self.OnRoleSplash)
  self:AddSetHurtTriggerForTable("bs_108201_01", 1, self.OnSetHurt, {
    targetBelongNum = eBattleRoleBelong.player,
    targetRoleType = eBattleRoleType.character,
    extraArg3 = false
  })
  self:AddAfterHurtTriggerForTable("bs_108201_01", 1, self.OnAfterHurt, {
    targetBelongNum = eBattleRoleBelong.player,
    targetRoleType = eBattleRoleType.character,
    extraArg3 = false
  })
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_108202_03", 1, self.BeforeBattleEnd)
  self.caster.recordTable.N2 = 0
  self.caster.recordTable.MaxN2 = self.arglist[6]
end

function bs_108201:OnAfterBattleStart()
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetList ~= nil and targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      if targetList[i].roleType == eBattleRoleType.character and targetList[i] ~= self.caster then
        LuaSkillCtrl:CallBuff(self, targetList[i], self.config.BuffProtect, 1, self.arglist[8])
      end
    end
  end
end

function bs_108201:OnRoleSplash(role)
  self:OnSplashOrPhaseMove(role)
end

function bs_108201:OnRolePhaseMoveStart(role, luaskill)
  self:OnSplashOrPhaseMove(role)
end

function bs_108201:OnSplashOrPhaseMove(role)
  if role.isDead == false and role.roleType ~= eBattleRoleType.realSummoner and role.belongNum == self.caster.belongNum then
    local N2 = self.caster.recordTable.N2
    if N2 < self.arglist[6] then
      N2 = N2 + 1
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectN2, self)
      self.caster.recordTable.N2 = N2
      LuaSkillCtrl:ShowCounting(self.caster, N2, self.arglist[6])
    end
    if 1 > role:GetBuffTier(self.config.buffMark) then
      local shieldValue = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.shieldFormula, self.caster, nil, self, self.arglist[4])
      LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, shieldValue)
      LuaSkillCtrl:CallBuff(self, role, self.config.buffMark, 1, self.arglist[5])
    end
  end
end

function bs_108201:OnSetHurt(context)
  if context.hurt ~= 0 and 0 < context.target:GetBuffTier(self.config.BuffProtect) then
    context.hurt = context.hurt * (1000 - self.arglist[1]) // 1000
  end
end

function bs_108201:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if hurt ~= 0 and target ~= self.caster then
    local frame
    if target.recordTable.effectFrame ~= nil then
      frame = target.recordTable.effectFrame
    end
    local battleFrame = LuaSkillCtrl.battleCtrl.frame
    if frame == nil or battleFrame > frame + 30 then
      target.recordTable.effectFrame = LuaSkillCtrl.battleCtrl.frame
      LuaSkillCtrl:CallEffect(target, self.config.effectHD, self)
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectLine, self, nil, target)
    end
    local hurtnum = hurt * 1000 // (1000 - self.arglist[1])
    local realHurt = hurtnum * self.arglist[1] * self.arglist[2] // 1000000
    if realHurt > self.caster.maxHp * self.arglist[3] // 1000 then
      realHurt = self.caster.maxHp * self.arglist[3] // 1000
    end
    LuaSkillCtrl:CallRealDamage(self, self.caster, nil, self.config.realDamage, {realHurt}, true)
  end
end

function bs_108201:BeforeBattleEnd()
  LuaSkillCtrl:HideCounting(self.caster)
end

function bs_108201:OnCasterDie()
  self.caster.recordTable.N2 = 0
  LuaSkillCtrl:HideCounting(self.caster)
  base.OnCasterDie(self)
end

function bs_108201:LuaDispose()
  self.caster.recordTable.N2 = 0
  LuaSkillCtrl:HideCounting(self.caster)
  base.LuaDispose(self)
end

return bs_108201
