local bs_107501 = class("bs_107501", LuaSkillBase)
local base = LuaSkillBase
bs_107501.config = {
  buff_fu = 107501,
  heal_config = {baseheal_formula = 3021},
  selectTargetId = 77,
  selectTargetId2 = 86,
  selectRange = 10,
  buff_test = 107502,
  buff_dodge = 107503,
  buff_skill = 107506,
  effect_trail = 107507,
  effect_test = 107505,
  effect_test_newyear = 107519,
  effect_heal = 107506,
  effect_heal2 = 107510,
  buff_test_big = 107504,
  buffCd = 107511,
  buffId_live = 3009,
  nanaka_buffId = 102603
}

function bs_107501:ctor()
end

function bs_107501:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_107501_4", 1, self.OnAfterHurt, nil, nil, nil, eBattleRoleBelong.player)
  self:AddAfterPlaySkillTrigger("bs_107501_8", 1, self.OnAfterPlaySkill, self.caster, nil, nil, nil, nil, nil, 107503)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_107501_1", 1, self.OnAfterBattleStart)
  self:AddOnRoleDieTrigger("bs_107501_5", 1, self.OnRoleDie, nil, nil, nil, eBattleRoleBelong.player)
  self:AddAfterAddBuffTrigger("107504_9", 1, self.OnAfterAddBuff, nil, nil, nil, eBattleRoleBelong.player, self.config.buff_test_big)
  self:AddBuffDieTrigger("bs_107501_6", 1, self.OnBuffDie, nil, nil, self.config.buff_test_big)
  self:AddSetDeadHurtTrigger("bs_107501_6_1", 950, self.OnSetDeadHurt, nil, nil, nil, self.caster.belongNum, nil, 1)
  self.testRole = nil
  self.effect = nil
  self.helpList = {}
end

function bs_107501:OnAfterBattleStart()
  local role = LuaSkillCtrl:CallTargetSelect(self, self.config.selectTargetId, self.config.selectRange)
  local targetRole
  local pf = LuaSkillCtrl:GetGuardProfession()
  if role.Count ~= 0 then
    for i = 0, role.Count - 1 do
      if role[i].targetRole ~= pf then
        targetRole = role[i].targetRole
        break
      end
    end
    if targetRole ~= nil then
      LuaSkillCtrl:CallBuff(self, targetRole, self.config.buff_test, 1, nil, true)
      targetRole.recordTable.kimieSkinId = LuaSkillCtrl:GetCasterSkinId(self.caster)
      LuaSkillCtrl:CallBuff(self, targetRole, self.config.buff_skill, 1, nil, true)
      if LuaSkillCtrl:GetCasterSkinId(self.caster) == 307503 then
        self.effect = LuaSkillCtrl:CallEffect(targetRole, self.config.effect_test_newyear, self)
      else
        self.effect = LuaSkillCtrl:CallEffect(targetRole, self.config.effect_test, self)
      end
      self:SetTestRole(targetRole)
    end
  end
end

function bs_107501:SetTestRole(targetRole)
  self.testRole = targetRole
  self.caster.recordTable["107501_testRole"] = targetRole
end

function bs_107501:OnAfterPlaySkill(skill, role)
  LuaSkillCtrl:CallBuff(self, role, self.config.buff_fu, self.arglist[2], nil, true)
end

function bs_107501:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local cost = self.caster:GetBuffTier(self.config.buff_fu)
    local num = self.arglist[4] + cost * self.arglist[5]
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target.targetRole)
    LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {num}, true, false)
    skillResult:EndResult()
    LuaSkillCtrl:CallEffect(target.targetRole, self.config.effect_heal2, self)
    LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buff_dodge, 1, self.arglist[7], true)
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buff_fu, cost, true)
  end
end

function bs_107501:SkillEventFunc2(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target.targetRole)
    local num = self.arglist[8] + self.caster:GetBuffTier(self.config.buff_fu) * self.arglist[9]
    LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {num}, true, false)
    LuaSkillCtrl:CallEffect(target.targetRole, self.config.effect_heal, self)
    skillResult:EndResult()
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buff_fu, self.arglist[11], true)
  end
end

function bs_107501:OnSetDeadHurt(context)
  local NoDeath = LuaSkillCtrl:RoleContainsBuffFeature(context.target, eBuffFeatureType.NoDeath)
  if self:IsReadyToTake() and context.target.belongNum == self.caster.belongNum and context.target.roleType == 1 and context.target ~= context.sender and context.target:GetBuffTier(self.config.nanaka_buffId) <= 0 and NoDeath == false then
    local id = context.target.uid
    local Table = self.helpList
    local mark = 0
    if Table ~= nil then
      for i = 0, #Table do
        if Table[i] == context.target.uid then
          mark = 1
        end
      end
    end
    if mark ~= 1 then
      LuaSkillCtrl:CallBuff(self, context.target, self.config.buffId_live, 1, 1, true)
    end
  end
end

function bs_107501:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  if skill.isCommonAttack and isMiss == true and target.belongNum == self.caster.belongNum and self.caster:GetBuffTier(self.config.buff_fu) < self.arglist[2] then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_fu, 1, nil, true)
  end
  if target == self.testRole and self.caster:GetBuffTier(self.config.buffCd) == 0 then
    local role = LuaSkillCtrl:CallTargetSelect(self, self.config.selectTargetId2, self.config.selectRange)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffCd, 1, self.arglist[10], true)
    LuaSkillCtrl:CallEffectWithArg(role, self.config.effect_trail, self, nil, nil, self.SkillEventFunc2)
  end
  if target.belongNum == self.caster.belongNum and target.hp * 1000 // target.maxHp <= self.arglist[3] then
    local id = target.uid
    local Table = self.helpList
    local mark = 0
    if Table ~= nil then
      for i = 0, #Table do
        if Table[i] == target.uid then
          mark = 1
        end
      end
    end
    if mark ~= 1 and target.roleType == eBattleRoleType.character then
      table.insert(self.helpList, id)
      LuaSkillCtrl:CallEffectWithArg(target, self.config.effect_trail, self, nil, nil, self.SkillEventFunc)
    end
  end
end

function bs_107501:OnAfterAddBuff(buff, target)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
end

function bs_107501:OnBuffDie(buff, target, removeType)
  if target.isDead == false and target == self.testRole and removeType == eBuffRemoveType.Timeout and self.effect == nil then
    if LuaSkillCtrl:GetCasterSkinId(self.caster) == 307503 then
      self.effect = LuaSkillCtrl:CallEffect(target, self.config.effect_test_newyear, self)
    else
      self.effect = LuaSkillCtrl:CallEffect(target, self.config.effect_test, self)
    end
  end
end

function bs_107501:OnRoleDie(killer, role)
  if role == self.testRole then
    if self.effect ~= nil then
      self.effect:Die()
      self.effect = nil
    end
    local role = LuaSkillCtrl:CallTargetSelect(self, self.config.selectTargetId, self.config.selectRange)
    local pf = LuaSkillCtrl:GetGuardProfession()
    local targetRole
    if role.Count ~= 0 then
      for i = 0, role.Count - 1 do
        if role[i].targetRole ~= pf then
          targetRole = role[i].targetRole
          break
        end
      end
      if targetRole ~= nil then
        LuaSkillCtrl:CallBuff(self, targetRole, self.config.buff_test, 1, nil, true)
        targetRole.recordTable.kimieSkinId = LuaSkillCtrl:GetCasterSkinId(self.caster)
        LuaSkillCtrl:CallBuff(self, targetRole, self.config.buff_skill, 1, nil, true)
        if LuaSkillCtrl:GetCasterSkinId(self.caster) == 307503 then
          self.effect = LuaSkillCtrl:CallEffect(targetRole, self.config.effect_test_newyear, self)
        else
          self.effect = LuaSkillCtrl:CallEffect(targetRole, self.config.effect_test, self)
        end
        self:SetTestRole(targetRole)
      end
    end
  end
end

function bs_107501:OnCasterDie()
  base.OnCasterDie(self)
  self:SetTestRole(nil)
  self.helpList = {}
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
end

function bs_107501:LuaDispose()
  base.LuaDispose(self)
  self.effect = nil
  self.testRole = nil
end

return bs_107501
