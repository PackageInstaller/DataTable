local bs_10196 = class("bs_10196", LuaSkillBase)
local base = LuaSkillBase
bs_10196.config = {buffId = 1065}

function bs_10196:ctor()
end

function bs_10196:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10196_2", 1, self.OnSetHurt, self.caster)
end

function bs_10196:OnSetHurt(context)
  if context.sender == self.caster and not context.isTriggerSet then
    if LuaSkillCtrl:GetRoleEfcGrid(context.target) ~= 10 then
      local tier = context.target:GetBuffTier(self.config.buffId)
      if tier <= 0 then
        return
      end
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, tier, true)
    else
      self:PlayChipEffect()
      local tier = 1
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, tier, nil, true)
    end
  end
end

function bs_10196:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10196
