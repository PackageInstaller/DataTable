local bs_9034 = class("bs_9034", LuaSkillBase)
local base = LuaSkillBase
bs_9034.config = {}

function bs_9034:ctor()
end

function bs_9034:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_9034", 1, self.OnAfterBattleStart)
end

function bs_9034:OnAfterBattleStart()
  local Start_tag, target_Role
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetlist ~= nil then
    for i = 0, targetlist.Count - 1 do
      if targetlist[i].roleDataId == 1085 then
        target_Role = targetlist[i]
        Start_tag = true
        break
      end
    end
  end
  if Start_tag and targetlist ~= nil and target_Role ~= nil then
    for i = 0, targetlist.Count - 1 do
      targetlist[i]:AddRoleProperty(eHeroAttr.pow, self.arglist[1], eHeroAttrType.Origin)
      targetlist[i]:AddRoleProperty(eHeroAttr.skill_intensity, self.arglist[1], eHeroAttrType.Origin)
    end
    target_Role:AddRoleProperty(eHeroAttr.skill_intensity, self.arglist[2], eHeroAttrType.Origin)
  end
end

function bs_9034:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_9034
