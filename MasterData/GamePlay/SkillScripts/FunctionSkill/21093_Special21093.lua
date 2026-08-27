local bs_21093 = class("bs_21093", LuaSkillBase)
local base = LuaSkillBase
bs_21093.config = {}

function bs_21093:ctor()
end

function bs_21093:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRoleSplash, self.OnAfterMove)
end

function bs_21093:OnAfterMove(role, grid)
  local value = self.arglist[1] * 100 // 1
  local skills = role:GetBattleSkillList()
  if skills ~= nil then
    local skillCount = skills.Count
    if 0 < skillCount then
      for j = 0, skillCount - 1 do
        local curTotalCd = skills[j].totalCDTime * self.arglist[1] // 1000
        if not skills[j].isCommonAttack then
          LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
        end
      end
    end
  end
end

function bs_21093:OnAfterPlaySkill(skill, role)
  local value = self.arglist[1] // 10
  if skill.dataId == 5011 or not 5012 then
  end
  LuaSkillCtrl:CallResetCDRatioForRole(role, value)
end

function bs_21093:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21093
