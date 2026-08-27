local bs_94117 = class("bs_94117", LuaSkillBase)
local base = LuaSkillBase
bs_94117.config = {}

function bs_94117:ctor()
end

function bs_94117:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_94117_11", 1, self.OnRoleDie)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_94117_2", 1, self.OnAfterBattleStart)
end

function bs_94117:OnAfterBattleStart()
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 0)
  if targetlist == nil then
    return
  end
  if targetlist[0].targetRole.roleDataId == 20071 then
    LuaSkillCtrl:StartAvgWithPauseGame("22summer_s14_2", nil, nil)
  elseif targetlist[0].targetRole.roleDataId == 20069 then
    LuaSkillCtrl:StartAvgWithPauseGame("22summer_s15_4", nil, nil)
  end
end

function bs_94117:OnRoleDie(killer, role, killSkill)
  if role.roleDataId == 20068 then
    LuaSkillCtrl:StartAvgWithPauseGame("22summer_s14_4", nil, nil)
  elseif role.roleDataId == 20069 then
    LuaSkillCtrl:StartAvgWithPauseGame("22summer_s15_5", nil, nil)
  end
end

function bs_94117:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_94117
