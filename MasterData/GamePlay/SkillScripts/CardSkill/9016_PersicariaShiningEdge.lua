local bs_9016 = class("bs_9016", LuaSkillBase)
local base = LuaSkillBase
bs_9016.config = {}

function bs_9016:ctor()
end

function bs_9016:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  local battleroom = LuaSkillCtrl:GetBattleRoomId()
  if 4000040 <= battleroom and battleroom <= 4000043 then
    self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_9016_bugfix", 1, self.OnAfterBattleStart_bugfix)
  else
    self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_9016_1", 1, self.OnAfterBattleStart)
  end
end

function bs_9016:OnAfterBattleStart()
  local Start_tag, target_Role
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetlist ~= nil then
    for i = 0, targetlist.Count - 1 do
      if targetlist[i].roleDataId == 1071 then
        target_Role = targetlist[i]
        Start_tag = true
        break
      end
    end
  end
  if Start_tag and targetlist ~= nil and target_Role ~= nil then
    for i = 0, targetlist.Count - 1 do
      targetlist[i]:AddRoleProperty(eHeroAttr.injury_reduce, self.arglist[1], eHeroAttrType.Origin)
    end
    target_Role:AddRoleProperty(eHeroAttr.damage_increase, self.arglist[2], eHeroAttrType.Origin)
  end
end

function bs_9016:OnAfterBattleStart_bugfix()
  local Start_tag, target_Role
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetlist ~= nil then
    for i = 0, targetlist.Count - 1 do
      if targetlist[i].roleDataId == 1074 then
        target_Role = targetlist[i]
        Start_tag = true
        break
      end
    end
  end
  if Start_tag and targetlist ~= nil and target_Role ~= nil then
    for i = 0, targetlist.Count - 1 do
      targetlist[i]:AddRoleProperty(eHeroAttr.skill_intensity, 300, eHeroAttrType.Origin)
    end
    target_Role:AddRoleProperty(eHeroAttr.critDamage, 500, eHeroAttrType.Origin)
  end
end

function bs_9016:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_9016
