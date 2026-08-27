local bs_9004 = class("bs_9004", LuaSkillBase)
local base = LuaSkillBase
bs_9004.config = {}

function bs_9004:ctor()
end

function bs_9004:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_9004", 1, self.OnAfterBattleStart)
end

function bs_9004:OnAfterBattleStart()
  local Start_tag, target_Role
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetlist ~= nil then
    for i = 0, targetlist.Count - 1 do
      if targetlist[i].roleDataId == 1016 then
        target_Role = targetlist[i]
        Start_tag = true
        break
      end
    end
  end
  if Start_tag and targetlist ~= nil and target_Role ~= nil then
    for i = 0, targetlist.Count - 1 do
      targetlist[i]:AddRoleProperty(eHeroAttr.cd_reduce, self.arglist[1], eHeroAttrType.Origin)
    end
    local num = target_Role.speed * self.arglist[2] // 1000
    target_Role:AddRoleProperty(eHeroAttr.speed, num, eHeroAttrType.Origin)
  end
end

function bs_9004:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_9004
