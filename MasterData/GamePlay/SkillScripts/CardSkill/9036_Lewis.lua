local bs_9036 = class("bs_9036", LuaSkillBase)
local base = LuaSkillBase
bs_9036.config = {}

function bs_9036:ctor()
end

function bs_9036:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_9036_1", 1, self.OnAfterBattleStart)
end

function bs_9036:OnAfterBattleStart()
  local Start_tag, target_Role
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetlist ~= nil then
    for i = 0, targetlist.Count - 1 do
      if targetlist[i].roleDataId == 1086 then
        target_Role = targetlist[i]
        Start_tag = true
        break
      end
    end
  end
  if Start_tag and targetlist ~= nil and target_Role ~= nil then
    for i = 0, targetlist.Count - 1 do
      targetlist[i]:AddRoleProperty(eHeroAttr.skill_intensity, self.arglist[1], eHeroAttrType.Origin)
    end
    target_Role:AddRoleProperty(eHeroAttr.injury_reduce, self.arglist[2], eHeroAttrType.Origin)
  end
end

function bs_9036:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_9036
