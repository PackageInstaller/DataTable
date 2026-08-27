local base = require("GamePlay.SkillScripts.RoleFSkill.FakeCommonPassive")
local bs_1027012 = class("bs_1027012", base)
bs_1027012.config = {
  effectId_ShieldSj = 10382,
  buffId_defense = 265,
  audioId1 = 263,
  audio_loop = 262
}

function bs_1027012:ctor()
end

function bs_1027012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_1027012_2", 1, self.OnSetHurt, nil, self.caster)
  self:AddAfterHurtTrigger("bs_1027012_3", 1, self.OnAfterHurt, nil, self.caster)
  self.hurt = 0
  self.num = self.caster.maxHp * self.arglist[1] // 1000
  self.maxnum = self.caster.maxHp
end

function bs_1027012:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if self.maxnum ~= self.caster.maxHp then
    self.num = self.caster.maxHp * self.arglist[1] // 1000
  end
  if self.caster.hp < self.num and self.caster:GetBuffTier(self.config.buffId_defense) <= 0 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_defense, 1)
    LuaSkillCtrl:SetRoleHitAudioHint(self.caster, eHitAuRoleType.Shield)
  end
  if self.caster.hp >= self.num and self.caster:GetBuffTier(self.config.buffId_defense) > 0 then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_defense, 0, true)
  end
  if target == self.caster and self.caster:GetBuffTier(self.config.buffId_defense) > 0 then
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_ShieldSj, self)
  end
end

function bs_1027012:OnSetHurt(context)
  if context.target == self.caster and self.caster:GetBuffTier(self.config.buffId_defense) > 0 then
    local des = self.caster.skill_intensity * self.arglist[2] // 1000
    local real_hurt = context.hurt - des
    if context.hurt > self.arglist[3] and real_hurt < self.arglist[3] then
      real_hurt = self.arglist[3]
    end
    if context.hurt < self.arglist[3] then
      real_hurt = context.hurt
    end
    context.hurt = real_hurt
  end
end

function bs_1027012:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1027012
