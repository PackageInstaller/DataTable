local career_10004 = class("career_10004", LuaSkillBase)
local base = LuaSkillBase
career_10004.config = {}

function career_10004:ctor()
end

function career_10004:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTriggerForTable("career_10004_5", 1, self.OnAfterHurt, {
    senderBelongNum = eBattleRoleBelong.player,
    targetBelongNum = eBattleRoleBelong.enemy,
    targetRoleType = eBattleRoleType.character
  })
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "career_10004_2", 1, self.OnAfterBattleStart)
end

function career_10004:OnAfterBattleStart()
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetlist ~= nil then
    for i = 0, targetlist.Count - 1 do
      targetlist[i]:AddRoleProperty(eHeroAttr.crit, self.arglist[2], eHeroAttrType.Origin)
    end
  end
end

function career_10004:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target.belongNum == eBattleRoleBelong.enemy and sender.belongNum == eBattleRoleBelong.player and (sender.career == 3 or sender.recordTable.transfCareer == 3) and self.arglist[1] == 3 and isCrit then
    LuaSkillCtrl:RemoveLife(self.arglist[3], self, target, true, nil, true, true, eHurtType.RealDmg)
    self:PlayChipEffect()
  end
end

function career_10004:OnCasterDie()
  base.OnCasterDie(self)
end

return career_10004
