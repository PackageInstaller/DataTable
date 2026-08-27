local bs_80003 = class("bs_80003", LuaSkillBase)
local base = LuaSkillBase
bs_80003.config = {buffId = 1240, buffId2 = 278}

function bs_80003:ctor()
end

function bs_80003:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_80003_3", 1, self.OnAfterHurt, self.caster)
  self:AddSelfTrigger(eSkillTriggerType.HurtResultStart, "bs_80002_1", 1, self.OnHurtResultStart)
end

function bs_80003:OnHurtResultStart(skill, context)
  if context.sender == self.caster then
    local buffTier = context.target:GetBuffTier(self.config.buffId2)
    if 0 < buffTier or LuaSkillCtrl:RoleContainsCtrlBuff(context.target) then
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
    end
  end
end

function bs_80003:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and not isMiss and sender == self.caster and not LuaSkillCtrl:RoleContainsCtrlBuff(target) then
    local buffTier = self.caster:GetBuffTier(self.config.buffId)
    if buffTier <= 0 then
      return
    end
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true)
  end
end

function bs_80003:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_80003
