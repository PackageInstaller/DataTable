local bs_1031082 = class("bs_1031082", LuaSkillBase)
local base = LuaSkillBase
bs_1031082.config = {
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 10152,
    crit_formula = 0,
    crithur_ratio = 0
  }
}

function bs_1031082:ctor()
end

function bs_1031082:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_1031082_4", 1, self.OnAfterHurt, self.caster)
end

function bs_1031082:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack == true then
    local cskill = self.caster.recordTable["2_caster_cskill"]
    local heal_num = self.caster.recordTable["2_skill_int"] * self.caster.recordTable["2_Atk_arg_ex"] // 1000
    if heal_num ~= nil then
      LuaSkillCtrl:CallHealWithCSkill(heal_num, cskill, self.caster, true)
    end
  end
end

function bs_1031082:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1031082
