local bs_9007 = class("bs_9007", LuaSkillBase)
local base = LuaSkillBase
bs_9007.config = {}

function bs_9007:ctor()
end

function bs_9007:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_9007", 1, self.OnAfterBattleStart)
end

function bs_9007:OnAfterBattleStart()
  local Start_tag, target_Role
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetlist ~= nil then
    for i = 0, targetlist.Count - 1 do
      if targetlist[i].roleDataId == 1036 then
        target_Role = targetlist[i]
        Start_tag = true
        break
      end
    end
  end
  if Start_tag and targetlist ~= nil and target_Role ~= nil then
    for i = 0, targetlist.Count - 1 do
      targetlist[i]:AddRoleProperty(eHeroAttr.crit, self.arglist[1], eHeroAttrType.Origin)
    end
    target_Role:AddRoleProperty(eHeroAttr.critDamage, self.arglist[2], eHeroAttrType.Origin)
  end
end

function bs_9007:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_9007
