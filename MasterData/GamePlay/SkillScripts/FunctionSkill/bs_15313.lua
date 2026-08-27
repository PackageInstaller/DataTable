local bs_15313 = class("bs_15313", LuaSkillBase)
local base = LuaSkillBase
bs_15313.config = {buffId = 2073}

function bs_15313:ctor()
end

function bs_15313:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_15313_1", 1, self.OnAfterPlaySkill)
end

function bs_15313:OnAfterPlaySkill(skill, role)
  if skill.skillTag ~= eSkillTag.ultSkill or skill.skillType ~= eBattleSkillLogicType.Original then
    return
  end
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetlist.Count < 1 then
    return
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = targetlist[i]
    local skills = targetRole:GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if 0 < skillCount then
        for j = 0, skillCount - 1 do
          local curTotalCd = skills[j].totalCDTime
          LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
        end
      end
    end
  end
  local duration = 60
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  if self.timer == nil then
    self.timer = LuaSkillCtrl:StartTimer(nil, duration, arriveCallBack, nil, 0, 0)
  end
end

function bs_15313:OnArriveAction()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetlist.Count < 1 then
    return
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = targetlist[i]
    local skills = targetRole:GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if 0 < skillCount then
        for j = 0, skillCount - 1 do
          local curTotalCd = skills[j].totalCDTime
          LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
        end
      end
    end
  end
end

function bs_15313:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15313
