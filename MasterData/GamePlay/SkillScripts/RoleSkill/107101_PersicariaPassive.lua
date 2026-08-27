local bs_107101 = class("bs_107101", LuaSkillBase)
local base = LuaSkillBase
bs_107101.config = {
  HurtConfigID = 17,
  HurtTagConfig1 = 38,
  HurtTagConfig2 = 39,
  buffId = 107101,
  buffId_addDamage = 107102,
  effectId_cast = 107103,
  effectId_casthit = 107104,
  effectId_boomhit = 107106,
  heal_resultId = {
    baseheal_formula = 3021,
    heal_number = 0,
    crit_formula = 9992,
    crithur_ratio = 9995,
    correct_formula = 9990
  },
  weaponLv = 0,
  effect_trail_1 = 107114,
  effect_heal = 107115
}

function bs_107101:ctor()
end

function bs_107101:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_107101_1", 1, self.OnAfterBattleStart)
  self:AddAfterAddBuffTrigger("bs_107101_2", 1, self.OnAfterAddBuff, nil, nil, nil, nil, self.config.buffId)
end

function bs_107101:OnAfterBattleStart()
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_cast, self)
  LuaSkillCtrl:StartTimer(nil, 5, function()
    local enemyList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
    if enemyList.Count > 0 then
      for i = 0, enemyList.Count - 1 do
        local role = enemyList[i].targetRole
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
        LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
          self.arglist[1]
        })
        skillResult:EndResult()
        LuaSkillCtrl:CallBuff(self, role, self.config.buffId, self.arglist[2], 120)
        LuaSkillCtrl:CallEffect(role, self.config.effectId_casthit, self)
      end
    end
  end, nil, 0, 0)
  if self.config.weaponLv >= 3 then
    local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
    if 0 < targetList.Count then
      for i = 0, targetList.Count - 1 do
        local role = targetList[i]
        if role ~= nil and 0 < role.hp then
          LuaSkillCtrl:CallBuff(self, targetList[i], self.config.buffId_addDamage, 1)
        end
      end
    end
  end
end

function bs_107101:OnAfterAddBuff(buff, target)
  local num = target:GetBuffTier(self.config.buffId)
  if num >= self.arglist[3] then
    if self.config.weaponLv > 0 then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtTagConfig2, {
        self.arglist[4]
      }, false, false, nil, 102)
      skillResult:EndResult()
    else
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtTagConfig1, {
        self.arglist[4]
      }, false, false, nil, 102)
      skillResult:EndResult()
    end
    LuaSkillCtrl:DispelBuff(target, self.config.buffId, self.arglist[3])
    LuaSkillCtrl:CallEffect(target, self.config.effectId_boomhit, self)
    if self.config.weaponLv > 0 then
      local healtarget
      local targetList = LuaSkillCtrl:CallTargetSelect(self, 47, 10)
      if 0 < targetList.Count then
        for i = 0, targetList.Count - 1 do
          if targetList[i].targetRole.belongNum == self.caster.belongNum and targetList[i].targetRole.roleType == self.caster.roleType then
            healtarget = targetList[i].targetRole
            break
          end
        end
      end
      if healtarget ~= nil then
        LuaSkillCtrl:CallEffectWithArgOverride(healtarget, self.config.effect_trail_1, self, self.caster, nil, nil, self.SkillEventFunc_1)
      end
    end
  end
end

function bs_107101:SkillEventFunc_1(effect, eventId, target)
  if effect.dataId == self.config.effect_trail_1 and eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HealResult(skillResult, self.config.heal_resultId, {
      self.arglist[5]
    })
    skillResult:EndResult()
    LuaSkillCtrl:CallEffect(target.targetRole, self.config.effect_heal, self)
  end
end

function bs_107101:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_107101
