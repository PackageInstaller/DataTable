local bs_4007 = class("bs_4007", LuaSkillBase)
local base = LuaSkillBase
bs_4007.config = {
  hurtConfig = {basehurt_formula = 3000, crit_formula = 9992},
  ShieldType = 4
}

function bs_4007:ctor()
end

function bs_4007:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTriggerForTable("bs_4007_01", 1, self.OnSetHurt, {
    extraArg1 = eSkillTag.commonAttack,
    sender = self.caster,
    targetBelongNum = eBattleRoleBelong.enemy
  })
end

function bs_4007:OnSetHurt(context)
  if context.target.isDead == false and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[1] then
    local role = context.target
    local hasShield = false
    local shieldNum = LuaSkillCtrl:GetRoleAllShield(role)
    if 0 < shieldNum then
      hasShield = true
    end
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
    if hasShield == false then
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurtConfig, {
        self.arglist[2]
      })
    else
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurtConfig, {
        self.arglist[2] * 2
      })
    end
    skillResult:EndResult()
  end
end

function bs_4007:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4007
