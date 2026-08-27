local bs_9038 = class("bs_9038", LuaSkillBase)
local base = LuaSkillBase
bs_9038.config = {}

function bs_9038:ctor()
end

function bs_9038:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_9038", 1, self.OnAfterBattleStart)
end

function bs_9038:OnAfterBattleStart()
  self:ApplyBattleStartBuffs()
end

function bs_9038:ApplyBattleStartBuffs()
  local Start_tag, target_Role
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetlist ~= nil then
    for i = 0, targetlist.Count - 1 do
      if targetlist[i].roleDataId == 1051 then
        target_Role = targetlist[i]
        Start_tag = 1
        break
      end
    end
  end
  if Start_tag and targetlist ~= nil and target_Role ~= nil then
    for i = 0, targetlist.Count - 1 do
      targetlist[i]:AddRoleProperty(eHeroAttr.spell_life_steal, self.arglist[1], eHeroAttrType.Ratio)
      targetlist[i]:AddRoleProperty(eHeroAttr.life_steal, self.arglist[1], eHeroAttrType.Ratio)
    end
    target_Role:AddRoleProperty(eHeroAttr.speed, self.arglist[2], eHeroAttrType.Ratio)
  end
end

function bs_9038:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_9038
