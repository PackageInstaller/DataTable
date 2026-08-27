local bs_103101 = class("bs_103101", LuaSkillBase)
local base = LuaSkillBase
bs_103101.config = {
  selectId = 33,
  selectId_weapon = 14,
  hurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3010,
    crit_formula = 0,
    returndamage_formula = 0
  },
  hurtConfig2 = {
    hit_formula = 0,
    basehurt_formula = 3010,
    def_formula = 103102,
    crit_formula = 9992,
    returndamage_formula = 0
  },
  heal_config = {baseheal_formula = 501},
  effectId_heal = 103105,
  audioId1 = 103101,
  audioId2 = 103102,
  weaponLv = 0,
  buffId_willowpic = 102901
}

function bs_103101:ctor()
end

function bs_103101:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_103101_3", 1, self.OnAfterHurt, self.caster)
  self.caster.recordTable["103101_arg"] = self.arglist[3]
end

function bs_103101:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack then
    local num = self.arglist[1]
    if self.config.weaponLv >= 2 then
      num = self.arglist[1] + self.arglist[3]
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurtConfig2, {num})
      skillResult:EndResult()
    else
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurtConfig, {num})
      skillResult:EndResult()
    end
  end
  if hurtType == 1 and sender == self.caster and (skill.dataId == 103101 or skill.dataId == 103105) then
    local target_heal
    local hp = 0
    local long = 0
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
    if 0 < targetList.Count then
      for i = 0, targetList.Count - 1 do
        local role = targetList[i].targetRole
        if role.belongNum == self.caster.belongNum and not LuaSkillCtrl:GetRoleBuffById(role, self.config.buffId_willowpic) then
          local num = role.hp * 100 // role.maxHp
          local long_role = LuaSkillCtrl:GetRoleGridsDistance(target, role)
          if i == 0 then
            target_heal = role
            hp = num
            long = long_role
          else
            if long_role >= long then
              break
            end
            long = LuaSkillCtrl:GetRoleGridsDistance(target, role)
            hp = num
            target_heal = role
            if num < hp then
              target_heal = role
              hp = num
            end
          end
        end
      end
    end
    if target_heal ~= nil and 0 < target_heal.hp then
      LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
      LuaSkillCtrl:CallEffectWithArgOverride(target_heal, self.config.effectId_heal, self, target, nil, nil, self.SkillEventFunc, hurt)
    end
    if self.config.weaponLv >= 2 then
      local targetList_weapon = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId_weapon, 10)
      if 0 < targetList_weapon.Count then
        for i = 0, targetList_weapon.Count - 1 do
          local role = targetList_weapon[i].targetRole
          if role ~= nil and role:GetBuffTier(self.config.buffId_willowpic) == 0 then
            LuaSkillCtrl:CallEffectWithArgOverride(role, self.config.effectId_heal, self, target, nil, nil, self.SkillEventFunc, hurt)
          end
        end
      end
    end
  end
end

function bs_103101:SkillEventFunc(hurt, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger and target ~= nil and target.targetRole.hp > 0 then
    local heal = hurt * self.arglist[2] // 1000
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target.targetRole)
    LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {heal})
    skillResult:EndResult()
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId2)
  end
end

function bs_103101:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_103101
