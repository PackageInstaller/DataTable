local bs_10278 = class("bs_10278", LuaSkillBase)
local base = LuaSkillBase
bs_10278.config = {shieldFormula = 10087}

function bs_10278:ctor()
end

function bs_10278:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10278_2", 2, self.OnAfterPlaySkill)
end

function bs_10278:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and not skill.isCommonAttack then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 28, 10)
    if targetlist.Count < 1 then
      return
    end
    local shieldValue = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.shieldFormula, self.caster, nil, self)
    local targetRole = targetlist[0].targetRole
    if targetRole.recordTable.WillowPic == true then
      if targetlist[1].targetRole == nil then
        return
      else
        targetRole = targetlist[1].targetRole
      end
    end
    if targetRole ~= nil and 0 < targetRole.hp then
      LuaSkillCtrl:AddRoleShield(targetRole, eShieldType.Normal, shieldValue)
    end
  end
end

function bs_10278:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10278
