local bs_9015 = class("bs_9015", LuaSkillBase)
local base = LuaSkillBase
bs_9015.config = {}

function bs_9015:ctor()
end

function bs_9015:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_9015_1", 1, self.OnAfterBattleStart)
end

function bs_9015:OnAfterBattleStart()
  local Start_tag, target_Role
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetlist ~= nil then
    for i = 0, targetlist.Count - 1 do
      if targetlist[i].roleDataId == 1058 then
        target_Role = targetlist[i]
        Start_tag = true
        break
      end
    end
  end
  if Start_tag and targetlist ~= nil and target_Role ~= nil then
    for i = 0, targetlist.Count - 1 do
      targetlist[i]:AddRoleProperty(eHeroAttr.critDamage, self.arglist[1], eHeroAttrType.Origin)
    end
    local num = target_Role.magic_pen * self.arglist[2] // 1000
    target_Role:AddRoleProperty(eHeroAttr.magic_pen, num, eHeroAttrType.Origin)
  end
end

function bs_9015:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_9015
