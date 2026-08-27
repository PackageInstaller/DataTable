local bs_101908 = class("bs_101908", LuaSkillBase)
local base = LuaSkillBase
bs_101908.config = {
  effectId_boom = 101910,
  effectId_boom_skill = 101911,
  Aoe = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 1
  },
  hurt_configId = 3
}

function bs_101908:ctor()
end

function bs_101908:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.weaponLv3 = true
  self:AddLuaTrigger(eSkillLuaTrigger.FernDragonHurt, self.DragonHurt)
end

function bs_101908:DragonHurt(target, skill)
  if skill == false then
    LuaSkillCtrl:CallEffect(target, self.config.effectId_boom, self)
  else
    LuaSkillCtrl:CallEffect(target, self.config.effectId_boom_skill, self)
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target.targetRole, self.config.Aoe)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurt_configId, {
    self.arglist[1]
  }, true)
  skillResult:EndResult()
end

function bs_101908:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_101908
