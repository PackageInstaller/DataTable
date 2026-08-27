local career_10001 = class("career_10001", LuaSkillBase)
local base = LuaSkillBase
career_10001.config = {
  buffId = 1283,
  buffId1 = 1801,
  hurt_config = {returndamage_formula = 1053}
}

function career_10001:ctor()
end

function career_10001:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("career_10001_10", 1, self.OnSetHurt, nil, nil)
  self:AddSetHealTrigger("career_10001_10", 1, self.OnSetHeal, nil, nil)
  self:AddTrigger(eSkillTriggerType.HurtResultStart, "career_10001_1", 2, self.OnHurtResultStart)
  self:AddLuaTrigger(eSkillLuaTrigger.OnBeforeAddShield, self.OnBeforeAddShield, nil)
end

function career_10001:OnSetHurt(context)
  if context.sender.belongNum == context.target.belongNum and context.target.roleType ~= 1 then
    return
  end
  if context.isMiss then
    return
  end
  if not context.isCrit then
    local buffTier1 = context.sender:GetBuffTier(self.config.buffId1)
    if buffTier1 ~= 0 then
      context.hurt = 0
    elseif buffTier1 == 0 then
      context.hurt = self.arglist[1]
    end
  elseif context.isCrit then
    context.hurt = self.arglist[2]
  end
end

function career_10001:OnSetHeal(context)
  local buffTier = context.target:GetBuffTier(self.config.buffId)
  if buffTier ~= 0 then
    return
  end
  context.heal = 0
  if not context.isTriggerSet then
    LuaSkillCtrl:AddRoleShield(context.target, eShieldType.Normal, 1, nil)
  end
end

function career_10001:OnBeforeAddShield(config)
  local role = config.role
  if LuaSkillCtrl:GetShield(role, eShieldType.Normal) > 1 then
    config.shieldValue = 0
  else
    config.shieldValue = 1
  end
end

function career_10001:OnHurtResultStart(skill, context)
  if context.target.return_damage > 0 then
    context.new_config = self.config.hurt_config
    setmetatable(context.new_config, {
      __index = context.config
    })
  end
end

function career_10001:OnCasterDie()
  base.OnCasterDie(self)
end

return career_10001
