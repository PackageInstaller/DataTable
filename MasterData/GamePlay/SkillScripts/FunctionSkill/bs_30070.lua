local bs_30070 = class("bs_30070", LuaSkillBase)
local base = LuaSkillBase
bs_30070.config = {
  buffId = 1514,
  buffId2 = 1515,
  effectId = 10974,
  effectId1 = 10993
}

function bs_30070:ctor()
end

function bs_30070:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTriggerForTable("bs_30070_1", 1, self.OnSetHurt, {
    sender = self.caster,
    targetBelongNum = eBattleRoleBelong.enemy
  })
end

function bs_30070:OnSetHurt(context)
  if context.skill.isCommonAttack and context.hurt > 0 and context.target.belongNum == eBattleRoleBelong.enemy and 0 >= context.target:GetBuffTier(self.config.buffId) then
    LuaSkillCtrl:CallBuff(self, context.target, self.config.buffId, 1, nil, true)
  end
  if context.skill.isNormalSkill and context.hurt > 0 and context.target.belongNum == eBattleRoleBelong.enemy then
    local damg = self.caster.pow * self.arglist[1] // 1000
    local buffTier = context.target:GetBuffTier(self.config.buffId)
    if 0 < buffTier then
      LuaSkillCtrl:RemoveLife(damg, self, context.target, true, nil, true)
      LuaSkillCtrl:DispelBuff(context.target, self.config.buffId, true)
      LuaSkillCtrl:CallEffect(context.target, self.config.effectId1, self)
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, 1, nil)
    end
  end
end

function bs_30070:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30070
