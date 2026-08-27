local bs_9019 = class("bs_9019", LuaSkillBase)
local base = LuaSkillBase
bs_9019.config = {}

function bs_9019:ctor()
end

function bs_9019:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_9019_1", 1, self.OnAfterBattleStart)
end

function bs_9019:OnAfterBattleStart()
  local Start_tag, target_Role
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetlist ~= nil then
    for i = 0, targetlist.Count - 1 do
      if targetlist[i].roleDataId == 1048 then
        target_Role = targetlist[i]
        Start_tag = true
        break
      end
    end
  end
  if Start_tag and targetlist ~= nil and target_Role ~= nil then
    for i = 0, targetlist.Count - 1 do
      targetlist[i]:AddRoleProperty(eHeroAttr.pow, self.arglist[1], eHeroAttrType.Origin)
    end
    target_Role:AddRoleProperty(eHeroAttr.pow, self.arglist[2], eHeroAttrType.Origin)
  end
end

function bs_9019:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_9019
