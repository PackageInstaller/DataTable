local bs_9014 = class("bs_9014", LuaSkillBase)
local base = LuaSkillBase
bs_9014.config = {}

function bs_9014:ctor()
end

function bs_9014:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_9014_1", 1, self.OnAfterBattleStart)
end

function bs_9014:OnAfterBattleStart()
  local Start_tag, target_Role
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetlist ~= nil then
    for i = 0, targetlist.Count - 1 do
      if targetlist[i].roleDataId == 1061 then
        target_Role = targetlist[i]
        Start_tag = true
        break
      end
    end
  end
  if Start_tag and targetlist ~= nil and target_Role ~= nil then
    for i = 0, targetlist.Count - 1 do
      local num = targetlist[i].magic_pen * self.arglist[1] // 1000
      targetlist[i]:AddRoleProperty(eHeroAttr.magic_pen, num, eHeroAttrType.Origin)
    end
    target_Role:AddRoleProperty(eHeroAttr.cd_reduce, self.arglist[2], eHeroAttrType.Origin)
  end
end

function bs_9014:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_9014
