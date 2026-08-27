local bs_9018 = class("bs_9018", LuaSkillBase)
local base = LuaSkillBase
bs_9018.config = {}

function bs_9018:ctor()
end

function bs_9018:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_9018_1", 1, self.OnAfterBattleStart)
end

function bs_9018:OnAfterBattleStart()
  local Start_tag, target_Role
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetlist ~= nil then
    for i = 0, targetlist.Count - 1 do
      if targetlist[i].roleDataId == 1006 then
        target_Role = targetlist[i]
        Start_tag = true
        break
      end
    end
  end
  if Start_tag and targetlist ~= nil and target_Role ~= nil then
    for i = 0, targetlist.Count - 1 do
      targetlist[i]:AddRoleProperty(eHeroAttr.damage_increase, self.arglist[1], eHeroAttrType.Origin)
    end
    target_Role:AddRoleProperty(eHeroAttr.critDamage, self.arglist[2], eHeroAttrType.Origin)
  end
end

function bs_9018:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_9018
