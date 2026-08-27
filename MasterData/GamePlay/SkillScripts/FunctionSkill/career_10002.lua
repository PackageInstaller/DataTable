local career_10002 = class("career_10002", LuaSkillBase)
local base = LuaSkillBase
career_10002.config = {
  hurt_config = {returndamage_formula = 1053}
}

function career_10002:ctor()
end

function career_10002:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTriggerForTable("career_10002_10", 997, self.OnSetHurt, {
    targetBelongNum = eBattleRoleBelong.player,
    targetRoleType = eBattleRoleType.character
  })
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "career_10002_2", 1, self.OnAfterBattleStart)
end

function career_10002:OnAfterBattleStart()
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetlist ~= nil then
    for i = 0, targetlist.Count - 1 do
      targetlist[i]:AddRoleProperty(eHeroAttr.maxHp, self.arglist[2], eHeroAttrType.Origin)
      local num = self.arglist[2]
      LuaSkillCtrl:CallHeal(num + 999, self, targetlist[i], true, nil, nil, true)
    end
  end
end

function career_10002:OnSetHurt(context)
  if self.arglist[1] == 3 and context.target.belongNum == eBattleRoleBelong.player and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[3] and (context.target.career == 1 or context.target.recordTable.transfCareer == 1) and context.target.roleType == eBattleRoleType.character then
    LuaSkillCtrl:RemoveLife(self.arglist[4], self, context.sender, true, nil, true, true, eHurtType.RealDmg)
    LuaSkillCtrl:RemoveLife(self.arglist[4], self, context.sender, true, nil, true, true, eHurtType.RealDmg)
  end
end

function career_10002:OnCasterDie()
  base.OnCasterDie(self)
end

return career_10002
