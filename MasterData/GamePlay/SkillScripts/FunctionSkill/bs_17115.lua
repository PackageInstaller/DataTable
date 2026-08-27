local bs_17115 = class("bs_17115", LuaSkillBase)
local base = LuaSkillBase
bs_17115.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 10127,
    crit_formula = 0
  },
  effectId = 10967,
  buffId = 1513
}

function bs_17115:ctor()
end

function bs_17115:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_17115_1", 1, self.OnSetHurt, self.caster)
end

function bs_17115:OnSetHurt(context)
  local last_target = self.caster.recordTable.lastAttackRole
  if context.target ~= last_target and LuaSkillCtrl:CallRange(1, 1000) < self.arglist[1] and last_target ~= nil and context.hurt ~= 0 and context.skill.skillType == eBattleSkillLogicType.Original then
    local hurt = context.hurt * self.arglist[2] // 1000
    LuaSkillCtrl:RemoveLife(hurt, self, last_target, true, nil, true, true, eHurtType.RealDmg)
    self:PlayChipEffect()
  end
end

function bs_17115:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17115
