local career_101 = class("career_101", LuaSkillBase)
local base = LuaSkillBase
career_101.config = {
  buffId = 1283,
  buffTier = 1,
  buffId1 = 1051012
}

function career_101:ctor()
end

function career_101:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddBeforeAddBuffTrigger("bs_22016_2", 1, self.OnBeforeAddBuff, nil, nil, nil, nil, 1051012, eBuffType.Debeneficial)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "career_101_1", 1, self.OnAfterBattleStart)
end

function career_101:OnAfterBattleStart()
  local allFriendRoles = LuaSkillCtrl:CallTargetSelect(self, 5, 20)
  local count = allFriendRoles.Count
  if count <= 0 then
    return
  end
  for i = 0, count - 1 do
    LuaSkillCtrl:CallBuff(self, allFriendRoles[i].targetRole, self.config.buffId, self.config.buffTier, nil, true)
  end
end

function career_101:OnBeforeAddBuff(target, context)
  if context.buff.buffType == 2 and target.belongNum == eBattleRoleBelong.enemy and context.buff.dataId == self.config.buffId1 then
    context.buff.tier = 0
    self:PlayChipEffect()
  end
end

function career_101:OnCasterDie()
  base.OnCasterDie(self)
end

return career_101
