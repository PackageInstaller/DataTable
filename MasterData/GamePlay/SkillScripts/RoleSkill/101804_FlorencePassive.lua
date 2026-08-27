local bs_101801 = require("GamePlay.SkillScripts.RoleSkill.101801_FlorencePassive")
local bs_101804 = class("bs_101804", bs_101801)
local base = bs_101801
bs_101804.config = {weaponLv = 1}
bs_101804.config = setmetatable(bs_101804.config, {
  __index = base.config
})

function bs_101804:ctor()
end

function bs_101804:InitSkill(isMidwaySkill)
  LuaSkillBase.InitSkill(self, isMidwaySkill)
  if LuaSkillCtrl.IsInTDBattle and LuaSkillCtrl.cluaSkillCtrl ~= nil then
    return
  end
  self:AddAfterHurtTrigger("bs_101804_3", 1, self.OnAfterHurt, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
  self:AddBuffDieTrigger("bs_101804_2", 1, self.OnBuffDie, nil, nil, self.config.buffId_love)
  self.time = 0
end

function bs_101804:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack then
    self.time = self.time + 1
    if self.time >= self.arglist[1] and LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, self.caster.attackRange) then
      self.time = 0
      local time = self.arglist[2] + self.arglist[4]
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId_love, 1, time)
      if target:GetBuffTier(self.config.buffId_love) == 0 then
        LuaSkillCtrl:CallBuff(self, target, self.config.buffId_s, 1, self.arglist[7])
      end
    end
  end
  if 0 < sender:GetBuffTier(self.config.buffId_love) and skill.isCommonAttack and not isMiss and target ~= nil and 0 < target.hp then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_Taunt, 1, self.arglist[5], nil, sender)
  end
end

function bs_101804:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_101804
