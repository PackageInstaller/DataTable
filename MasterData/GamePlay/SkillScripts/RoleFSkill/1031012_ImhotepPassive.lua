local base = require("GamePlay.SkillScripts.RoleFSkill.FakeCommonPassive")
local bs_1031012 = class("bs_1031012", base)
bs_1031012.config = {
  selectId = 33,
  hurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3010,
    crit_formula = 0,
    returndamage_formula = 0
  },
  heal_config = {baseheal_formula = 501},
  effectId_heal = 103105,
  audioId1 = 103101,
  audioId2 = 103102
}

function bs_1031012:ctor()
end

function bs_1031012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_1031012_3", 1, self.OnAfterHurt, self.caster)
end

function bs_1031012:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurtConfig, {
      self.arglist[1]
    })
    skillResult:EndResult()
  end
  if hurtType == 1 and sender == self.caster and skill.dataId == 103101 then
    local target_heal
    local hp = 0
    local long = 0
    local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId, 10, target)
    if 0 < targetList.Count then
      for i = 0, targetList.Count - 1 do
        local role = targetList[i].targetRole
        if role.belongNum == self.caster.belongNum then
          local num = role.hp * 100 // role.maxHp
          local long_role = LuaSkillCtrl:GetRoleGridsDistance(target, role)
          if i == 0 then
            target_heal = role
            hp = num
            long = long_role
          else
            if long_role > long then
              break
            end
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
  end
end

function bs_1031012:SkillEventFunc(hurt, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger and target ~= nil and target.targetRole.hp > 0 then
    local heal = hurt * self.arglist[2] // 1000
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target.targetRole)
    LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {heal})
    skillResult:EndResult()
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId2)
  end
end

function bs_1031012:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1031012
