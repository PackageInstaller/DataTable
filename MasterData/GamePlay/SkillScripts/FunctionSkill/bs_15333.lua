local bs_15333 = class("bs_15333", LuaSkillBase)
local base = LuaSkillBase
bs_15333.config = {
  freezeBuff = 1178,
  silenceBuff = 26,
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 10127,
    crit_formula = 9992
  },
  effectId = 10875,
  effectId2 = 10883
}

function bs_15333:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_15333_1", 1, self.OnAfterPlaySkill)
end

function bs_15333:OnAfterPlaySkill(skill, role)
  if skill.skillTag ~= eSkillTag.ultSkill or skill.skillType ~= eBattleSkillLogicType.Original then
    return
  end
  local roleslist = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  for i = 0, roleslist.Count - 1 do
    local targetRole = roleslist[i].targetRole
    LuaSkillCtrl:CallEffect(targetRole, self.config.effectId2, self)
    LuaSkillCtrl:CallBuff(self, targetRole, self.config.freezeBuff, self.arglist[1], 75)
  end
end

function bs_15333:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15333
