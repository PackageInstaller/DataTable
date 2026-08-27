local bs_9022 = class("bs_9022", LuaSkillBase)
local base = LuaSkillBase
bs_9022.config = {}

function bs_9022:ctor()
end

function bs_9022:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_9022", 1, self.OnAfterBattleStart)
end

function bs_9022:OnAfterBattleStart()
  local Start_tag, target_Role
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetlist ~= nil then
    for i = 0, targetlist.Count - 1 do
      if targetlist[i].roleDataId == 1065 then
        target_Role = targetlist[i]
        Start_tag = true
        break
      end
    end
  end
  if Start_tag and targetlist ~= nil and target_Role ~= nil then
    for i = 0, targetlist.Count - 1 do
      targetlist[i]:AddRoleProperty(eHeroAttr.maxHp, self.arglist[1], eHeroAttrType.Origin)
      local num = self.arglist[1]
      LuaSkillCtrl:CallHeal(num, self, targetlist[i], true)
    end
    local num = target_Role.sunder * self.arglist[2] // 1000
    target_Role:AddRoleProperty(eHeroAttr.sunder, num, eHeroAttrType.Origin)
  end
end

function bs_9022:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_9022
