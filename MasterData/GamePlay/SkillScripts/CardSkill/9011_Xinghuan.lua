local bs_9011 = class("bs_9011", LuaSkillBase)
local base = LuaSkillBase
bs_9011.config = {}

function bs_9011:ctor()
end

function bs_9011:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_9011_1", 1, self.OnAfterBattleStart)
end

function bs_9011:OnAfterBattleStart()
  local Start_tag, target_Role
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetlist ~= nil then
    for i = 0, targetlist.Count - 1 do
      if targetlist[i].roleDataId == 1072 then
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
    target_Role:AddRoleProperty(eHeroAttr.spell_life_steal, self.arglist[2], eHeroAttrType.Origin)
  end
end

function bs_9011:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_9011
