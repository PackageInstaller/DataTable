local bs_9027 = class("bs_9027", LuaSkillBase)
local base = LuaSkillBase
bs_9027.config = {}

function bs_9027:ctor()
end

function bs_9027:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_9027", 1, self.OnAfterBattleStart)
end

function bs_9027:OnAfterBattleStart()
  local Start_tag, target_Role
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetlist ~= nil then
    for i = 0, targetlist.Count - 1 do
      if targetlist[i].roleDataId == 1076 then
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
    target_Role:AddRoleProperty(eHeroAttr.heal, self.arglist[2], eHeroAttrType.Origin)
  end
end

function bs_9027:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_9027
