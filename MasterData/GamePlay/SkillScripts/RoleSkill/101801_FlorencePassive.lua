local bs_101801 = class("bs_101801", LuaSkillBase)
local base = LuaSkillBase
bs_101801.config = {
  buffId_love = 101802,
  buffId_s = 101805,
  buffId_passive = 101806,
  buffId_Taunt = 3002,
  buffId_wd = 101807,
  effectId_pass = 101805,
  heal_config = {baseheal_formula = 3021},
  weaponLv = 0
}

function bs_101801:ctor()
end

function bs_101801:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  if LuaSkillCtrl.IsInTDBattle and LuaSkillCtrl.cluaSkillCtrl ~= nil then
    return
  end
  self:AddAfterHurtTrigger("bs_101801_3", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
  self:AddBuffDieTrigger("bs_101801_2", 1, self.OnBuffDie, nil, nil, self.config.buffId_love)
  self.time = 0
end

function bs_101801:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack then
    self.time = self.time + 1
  end
  if self.time >= self.arglist[1] and LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, self.caster.attackRange) then
    self.time = 0
    LuaSkillCtrl:CallEffect(target, self.config.effectId_pass, self)
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_love, 1, self.arglist[2])
  end
end

function bs_101801:OnBuffDie(buff, target, removeType)
  if buff.dataId == self.config.buffId_love and target:GetBuffTier(self.config.buffId_wd) > 0 then
    LuaSkillCtrl:DispelBuff(target, self.config.buffId_wd, 0)
  end
end

function bs_101801:LuaDispose()
  base.LuaDispose(self)
end

return bs_101801
