local bs_820301 = class("bs_820301", LuaSkillBase)
local base = LuaSkillBase
bs_820301.config = {
  buffId_id = 605,
  hurt_config = {hit_formula = 10201}
}

function bs_820301:ctor()
end

function bs_820301:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddHurtResultStartTrigger("bs_820301_15", 40, self.OnHurtResultStart, self.caster, nil, eBattleRoleBelong.enemy)
end

function bs_820301:OnHurtResultStart(skill, context)
  if skill.skillType == eBattleSkillLogicType.Original and not skill.isCommonAttack and context.sender:GetBuffTier(self.config.buffId_id) > 0 and context.sender == self.caster then
    local HitFurmula = context.config.hit_formula
    context.new_config = self.config.hurt_config
    setmetatable(context.new_config, {
      __index = context.config
    })
    LuaSkillCtrl:StartTimer(nil, 10, function()
      if context.sender:GetBuffTier(self.config.buffId_id) > 0 then
        LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_id, 0, true)
      end
    end)
  end
end

function bs_820301:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_820301
