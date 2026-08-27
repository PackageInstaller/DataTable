local bs_9002 = class("bs_9002", LuaSkillBase)
local base = LuaSkillBase
bs_9002.config = {}

function bs_9002:ctor()
end

function bs_9002:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_9002", 1, self.OnAfterBattleStart)
end

function bs_9002:OnAfterBattleStart()
  local Start_tag, target_Role
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetlist ~= nil then
    for i = 0, targetlist.Count - 1 do
      if targetlist[i].roleDataId == 1060 then
        target_Role = targetlist[i]
        Start_tag = true
        break
      end
    end
  end
  if Start_tag and targetlist ~= nil and target_Role ~= nil then
    for i = 0, targetlist.Count - 1 do
      targetlist[i]:AddRoleProperty(eHeroAttr.dodge, self.arglist[1], eHeroAttrType.Origin)
    end
    target_Role:AddRoleProperty(eHeroAttr.dodge, self.arglist[2], eHeroAttrType.Origin)
  end
end

function bs_9002:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_9002
