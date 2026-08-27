local bs_10173 = class("bs_10173", LuaSkillBase)
local base = LuaSkillBase
bs_10173.config = {
  buffId = 1037,
  heal_formula = 1047,
  effectId = 10634
}

function bs_10173:ctor()
end

function bs_10173:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_10173_4", 1, self.OnKillNeutral)
  self.flag = true
end

function bs_10173:OnKillNeutral(killer, role)
  if role.intensity == 0 and role.belongNum == eBattleRoleBelong.neutral and self.flag then
    self.flag = false
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 14, 10)
    if targetlist.Count < 1 then
      return
    end
    local healNum = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.heal_formula, targetlist[0].targetRole, targetlist[0].targetRole, self)
    LuaSkillCtrl:CallHeal(healNum, self, targetlist[0].targetRole, true)
    LuaSkillCtrl:CallEffect(targetlist[0].targetRole, self.config.effectId, self)
  end
end

function bs_10173:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10173
