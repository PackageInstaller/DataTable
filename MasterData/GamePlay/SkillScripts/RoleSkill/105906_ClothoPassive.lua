local bs_105904 = require("GamePlay.SkillScripts.RoleSkill.105904_ClothoPassive")
local bs_105906 = class("bs_105906", bs_105904)
local base = bs_105904
bs_105906.config = {
  effectId_cast = 105911,
  effectId_trail = 105912,
  effectId_trail1 = 105913,
  HurtConfigID = 19,
  heal_resultId = 6,
  weaponLv = 3
}
local blindList = {
  108006,
  108008,
  115,
  3012,
  450000115,
  450003012,
  301201,
  1009032,
  208401
}
bs_105906.config = setmetatable(bs_105906.config, {
  __index = base.config
})

function bs_105906:ctor()
end

function bs_105906:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterPlaySkillTrigger("bs_105906", 1, self.OnAfterPlaySkill, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
  self:AddHurtResultEndTrigger("bs_105906", 2, self.OnHurtResultEnd, self.caster, nil, eBattleRoleBelong.player)
  self:AddSetHurtTrigger("bs_105906_1", 3, self.OnSetHurt, self.caster, nil, nil, eBattleRoleBelong.enemy)
end

function bs_105906:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and skill.dataId == 105900 then
    self.skillState = true
    local soulNum = self.caster.recordTable.Soul_Num
    if 1 <= soulNum then
      self.Remove = LuaSkillCtrl:StartTimer(nil, 3, function()
        self:Shoot()
      end, self, soulNum - 1, 3)
    end
  end
end

function bs_105906:Shoot()
  local last_target = self.caster.recordTable.lastAttackRole
  local target
  if last_target ~= nil and last_target.hp > 0 and last_target.belongNum ~= eBattleRoleBelong.neutral and LuaSkillCtrl:IsAbleAttackTarget(self.caster, last_target, 1) then
    target = last_target
  else
    local tempTarget = LuaSkillCtrl:CallTargetSelect(self, 89, 10)
    if 0 < tempTarget.Count then
      target = tempTarget[0].targetRole
    end
  end
  LuaSkillCtrl:CallEffectWithArgOverride(target, self.config.effectId_trail, self, self.caster, nil, nil, self.SoulAttack)
end

function bs_105906:SoulAttack(effect, eventId, target)
  if effect.dataId == self.config.effectId_trail and eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
      self.arglist[9]
    }, true)
    skillResult:EndResult()
  end
end

function bs_105906:OnHurtResultEnd(skill, targetRole, hurtValue)
  if skill.maker == self.caster and skill.dataId == 105906 then
    LuaSkillCtrl:CallEffectWithArgOverride(skill.maker, self.config.effectId_trail1, self, targetRole, false, false, self.SoulHeal, hurtValue)
  end
end

function bs_105906:SoulHeal(hurtValue, effect, eventId, target)
  if effect.dataId == self.config.effectId_trail1 and eventId == eBattleEffectEvent.Trigger and 0 < hurtValue then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
    LuaSkillCtrl:HealResultWithConfig(self, skillResult, self.config.heal_resultId, {
      self.arglist[10] * hurtValue // 1000
    })
    skillResult:EndResult()
  end
end

function bs_105906:OnSetHurt(context)
  if context.skill.dataId == 105906 then
    local isblind = false
    for k, v in pairs(blindList) do
      if context.target:GetBuffTier(v) > 0 then
        isblind = true
        break
      end
    end
    if isblind then
      context.hurt = context.hurt * (1000 + self.arglist[11]) // 1000
    end
  end
end

function bs_105906:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_105906
