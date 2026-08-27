local bs_22016 = class("bs_22016", LuaSkillBase)
local base = LuaSkillBase
bs_22016.config = {
  buffId = 1283,
  buffTier = 1,
  buffId1 = 1051012
}

function bs_22016:ctor()
end

function bs_22016:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddBeforeAddBuffTrigger("bs_22016_2", 1, self.OnBeforeAddBuff, nil, nil, nil, nil, 1051012, eBuffType.Debeneficial)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_22016_1", 1, self.OnAfterBattleStart)
end

function bs_22016:OnAfterBattleStart()
  local allFriendRoles = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  local count = allFriendRoles.Count
  if count <= 0 then
    return
  end
  for i = 0, count - 1 do
    LuaSkillCtrl:CallBuff(self, allFriendRoles[i], self.config.buffId, self.config.buffTier, nil, true)
  end
end

function bs_22016:OnBeforeAddBuff(target, context)
  if context.buff.buffType == 2 and target.belongNum == eBattleRoleBelong.enemy and context.buff.dataId == self.config.buffId1 then
    context.buff.tier = 0
    self:PlayChipEffect()
  end
end

function bs_22016:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_22016
