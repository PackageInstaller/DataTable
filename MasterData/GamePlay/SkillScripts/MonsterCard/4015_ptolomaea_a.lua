local bs_4015 = class("bs_4015", LuaSkillBase)
local base = LuaSkillBase
bs_4015.config = {heal_resultId = 3}

function bs_4015:ctor()
end

function bs_4015:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_4015_2", 1, self.OnAfterPlaySkill)
end

function bs_4015:OnAfterPlaySkill(skill, role)
  if role == self.caster and skill.isNormalSkill then
    self:heal()
  end
end

function bs_4015:heal()
  local targetList = LuaSkillCtrl:FindAllRolesWithinRange(self.caster, 1, true)
  if targetList ~= nil and targetList.Count > 0 then
    for i = targetList.Count - 1, 0, -1 do
      local role = targetList[i]
      if role ~= nil and 0 < role.hp and role.belongNum == self.caster.belongNum then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
        LuaSkillCtrl:HealResultWithConfig(self, skillResult, self.config.heal_resultId, {
          self.arglist[1]
        }, true)
        skillResult:EndResult()
      end
    end
  end
end

function bs_4015:LuaDispose()
  base.LuaDispose(self)
end

function bs_4015:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4015
