local bs_9005 = class("bs_9005", LuaSkillBase)
local base = LuaSkillBase
bs_9005.config = {}

function bs_9005:ctor()
end

function bs_9005:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_9005", 1, self.OnAfterBattleStart)
end

function bs_9005:OnAfterBattleStart()
  local Start_tag, target_Role
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetlist ~= nil then
    for i = 0, targetlist.Count - 1 do
      if targetlist[i].roleDataId == 1053 then
        target_Role = targetlist[i]
        Start_tag = true
        break
      end
    end
  end
  if Start_tag and targetlist ~= nil and target_Role ~= nil then
    for i = 0, targetlist.Count - 1 do
      local num = targetlist[i].speed * self.arglist[1] // 1000
      targetlist[i]:AddRoleProperty(eHeroAttr.speed, num, eHeroAttrType.Origin)
    end
    target_Role:AddRoleProperty(eHeroAttr.skill_intensity, self.arglist[2], eHeroAttrType.Origin)
  end
end

function bs_9005:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_9005
