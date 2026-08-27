local bs_25258 = class("bs_25258", LuaSkillBase)
local base = LuaSkillBase
bs_25258.config = {buffId = 2121}

function bs_25258:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterPlaySkillTrigger("bs_25258_1", 1, self.OnAfterPlaySkill, nil, nil, nil, nil, nil, nil, nil, eSkillTag.ultSkill)
end

function bs_25258:OnAfterPlaySkill(skill, role)
  if skill.skillTag ~= eSkillTag.ultSkill then
    return
  end
  if skill.skillType ~= eBattleSkillLogicType.Original then
    return
  end
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetList == nil then
    return
  end
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      local targetRole = targetList[i]
      LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId, 1, nil, true)
    end
  end
end

function bs_25258:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25258
