local bs_104609 = class("bs_104609", LuaSkillBase)
local base = LuaSkillBase
bs_104609.config = {
  buffId_inspire = 1046021,
  hurt_config = {crit_formula = 9992, crithur_ratio = 9995},
  buffId_1 = 104602
}

function bs_104609:ctor()
end

function bs_104609:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddHurtResultStartTrigger("bs_104609_15", 40, self.OnHurtResultStart, self.caster, nil, eBattleRoleBelong.player)
end

function bs_104609:OnHurtResultStart(skill, context)
  if skill.skillType == eBattleSkillLogicType.Original and not skill.isCommonAttack and context.sender:GetBuffTier(self.config.buffId_inspire) > 0 and context.sender == self.caster and context.extraArg ~= ConfigData.buildinConfig.HurtIgnoreKey and context.hurt_type ~= 2 then
    local critFurmula = context.config.crit_formula
    if critFurmula == nil or critFurmula == 0 then
      context.new_config = self.config.hurt_config
      setmetatable(context.new_config, {
        __index = context.config
      })
      return
    end
    local hazeWeaponLv = self.caster.recordTable.haze_weaponLv
    if hazeWeaponLv ~= nil and 0 < hazeWeaponLv and (critFurmula ~= 0 or critFurmula ~= nil) then
      local number = hazeWeaponLv
      if 0 >= self.caster:GetBuffTier(self.config.buffId_1) then
        LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_1, number, 1, true)
      end
    end
  end
end

function bs_104609:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_104609
