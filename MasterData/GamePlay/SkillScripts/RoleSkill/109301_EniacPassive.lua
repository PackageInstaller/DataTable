local bs_109301 = class("bs_109301", LuaSkillBase)
local base = LuaSkillBase
bs_109301.config = {
  buffID = 109301,
  effectId_cast = 109303,
  HurtConfig = 14
}

function bs_109301:ctor()
end

function bs_109301:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_109301_1", 1, self.OnAfterBattleStart)
  self:AddHurtResultStartTrigger("bs_109301_2", 1, self.OnHurtResultStart, nil, nil, eBattleRoleBelong.player, nil, nil, nil, nil, nil, false)
  self:AddLuaTrigger(eSkillLuaTrigger.OnAddShield, self.OnAddShield, self)
  self:AddTrigger(eSkillTriggerType.OnBreakShield, "bs_109301_3", 3, self.OnBreakShield)
  self:AddBeforePlaySkillTrigger("bs_109301_4", 1, self.OnBeforePlaySkill, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
  self.atkNum = 0
  self.caster.recordTable["arglist[1]"] = self.arglist[5]
end

function bs_109301:OnAfterBattleStart()
  local role_list = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  local shieldValue = self.caster.pow * self.arglist[1] // 1000
  if 0 < shieldValue and (role_list ~= nil or 0 < role_list.Count) then
    for i = 0, role_list.Count - 1 do
      local role = role_list[i]
      if role ~= nil and 0 < role.hp and role.roleType == eBattleRoleType.character then
        shieldValue = self.caster.pow * self.arglist[1] // 1000
        local rate = 1 + (self.caster.heal + role.treatment) / 1000
        if rate < 0.1 then
          rate = 0.1
        end
        shieldValue = shieldValue * rate * 1000 // 1000
        LuaSkillCtrl:AddRoleShield(role, eShieldType.Normal, shieldValue)
        LuaSkillCtrl:CallEffect(role, self.config.effectId_cast, self)
        role.recordTable.passiveCd = 0
      end
    end
  end
end

function bs_109301:OnBeforePlaySkill(role, context)
  self.atkNum = self.atkNum + 1
  if self.atkNum >= self.arglist[7] then
    local role_list = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
    local shieldValue = self.caster.pow * self.arglist[6] // 1000
    if 0 < shieldValue and (role_list ~= nil or 0 < role_list.Count) then
      for i = 0, role_list.Count - 1 do
        local role = role_list[i]
        if role ~= nil and 0 < role.hp and role.roleType == eBattleRoleType.character then
          shieldValue = self.caster.pow * self.arglist[6] // 1000
          local rate = 1 + (self.caster.heal + role.treatment) / 1000
          if rate < 0.1 then
            rate = 0.1
          end
          shieldValue = shieldValue * rate * 1000 // 1000
          LuaSkillCtrl:AddRoleShield(role, eShieldType.Normal, shieldValue)
        end
      end
    end
    self.atkNum = 0
  end
end

function bs_109301:OnHurtResultStart(skill, context)
  if skill.skillType == eBattleSkillLogicType.Original and context.sender.roleType == eBattleRoleType.character and not context.isTriggerSet and context.extraArg ~= ConfigData.buildinConfig.HurtIgnoreKey and context.hurt_type ~= 2 then
    local battleCtrl = LuaSkillCtrl.battleCtrl
    local curFrame = battleCtrl.frame
    if curFrame < context.sender.recordTable.passiveCd then
      return
    end
    local num = LuaSkillCtrl:GetRoleAllShield(context.sender)
    local Hurt = num * self.arglist[2] // 1000
    if Hurt > self.caster.pow * self.arglist[3] then
      Hurt = self.caster.pow * self.arglist[3]
    end
    if Hurt == 0 then
      return
    end
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, context.target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfig, {Hurt}, true, nil)
    skillResult:EndResult()
    context.sender.recordTable.passiveCd = curFrame + self.arglist[8]
  end
end

function bs_109301:OnAddShield(role, shieldType)
  if shieldType == 0 and role.belongNum == eBattleRoleBelong.player and role.roleType == eBattleRoleType.character then
    LuaSkillCtrl:CallBuff(self, role, self.config.buffID, 1)
  end
end

function bs_109301:OnBreakShield(shieldType, sender, target)
  if shieldType == 0 and 0 < target:GetBuffTier(self.config.buffID) then
    LuaSkillCtrl:DispelBuff(target, self.config.buffID, 0)
  end
end

function bs_109301:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_109301:LuaDispose()
  base.LuaDispose(self)
end

return bs_109301
