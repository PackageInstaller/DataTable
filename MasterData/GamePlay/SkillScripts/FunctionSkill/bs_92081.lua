local bs_92081 = class("bs_92081", LuaSkillBase)
local base = LuaSkillBase
bs_92081.config = {
  buffId = 1227,
  buffDuration = 90,
  buffId1 = 2093
}

function bs_92081:ctor()
end

function bs_92081:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_92081_1", 1, self.OnAfterHurt, nil, nil, eBattleRoleBelong.player, eBattleRoleBelong.enemy, nil, nil, nil, nil, false)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_92081_2", 1, self.OnBattleStart)
  self.breakTier = self.arglist[2]
  self.isCalledBuff = false
end

function bs_92081:OnBattleStart()
  if self.isCalledBuff ~= false then
    return
  end
  local targetRoleList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetRoleList == nil or targetRoleList.Count < 1 then
    return
  end
  for i = 0, targetRoleList.Count - 1 do
    LuaSkillCtrl:CallBuff(self, targetRoleList[i], self.config.buffId1, 1, nil, true)
  end
  self.isCalledBuff = true
end

function bs_92081:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender.belongNum == eBattleRoleBelong.player and hurtType == eHurtType.MagicDmg and not isMiss and not isTriggerSet then
    if target.recordTable.bs_92081 == nil then
      target.recordTable.bs_92081 = 0
    end
    target.recordTable.bs_92081 = target.recordTable.bs_92081 + 1
    if target.recordTable.bs_92081 >= self.breakTier and self:IsReadyToTake() then
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId, 1, self.config.buffDuration, false)
      target.recordTable.bs_92081 = 0
      self:OnSkillTake()
    end
  end
end

function bs_92081:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_92081
