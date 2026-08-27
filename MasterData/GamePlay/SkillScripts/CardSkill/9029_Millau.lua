local bs_9029 = class("bs_9029", LuaSkillBase)
local base = LuaSkillBase
bs_9029.config = {}

function bs_9029:ctor()
end

function bs_9029:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_9029", 1, self.OnAfterBattleStart)
end

function bs_9029:OnAfterBattleStart()
  local Start_tag, target_Role
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetlist ~= nil then
    for i = 0, targetlist.Count - 1 do
      if targetlist[i].roleDataId == 1054 then
        target_Role = targetlist[i]
        Start_tag = true
        break
      end
    end
  end
  if Start_tag and targetlist ~= nil and target_Role ~= nil then
    for i = 0, targetlist.Count - 1 do
      targetlist[i]:AddRoleProperty(eHeroAttr.def, self.arglist[1], eHeroAttrType.Origin)
      targetlist[i]:AddRoleProperty(eHeroAttr.magic_res, self.arglist[1], eHeroAttrType.Origin)
    end
    target_Role:AddRoleProperty(eHeroAttr.maxHp, self.arglist[2], eHeroAttrType.Origin)
    local num = self.arglist[2]
    LuaSkillCtrl:CallHeal(num, self, target_Role, true)
  end
end

function bs_9029:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_9029
