local bs_25257 = class("bs_25257", LuaSkillBase)
local base = LuaSkillBase
bs_25257.config = {}

function bs_25257:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterPlaySkillTrigger("bs_25257_1", 1, self.OnAfterPlaySkill, nil, nil, nil, nil, nil, nil, nil, eSkillTag.ultSkill)
end

function bs_25257:OnAfterPlaySkill(skill, role)
  if skill.skillTag ~= eSkillTag.ultSkill then
    return
  end
  if skill.skillType ~= eBattleSkillLogicType.Original then
    return
  end
  local roleslist = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  for i = 0, roleslist.Count - 1 do
    local targetRole = roleslist[i].targetRole
    local skills = targetRole:GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if 0 < skillCount then
        for j = 0, skillCount - 1 do
          local curTotalCd = -skills[j].totalCDTime * self.arglist[1] // 1000
          LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
          self:OnSkillTake()
        end
      end
    end
  end
end

function bs_25257:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25257
