local bs_92082 = class("bs_92082", LuaSkillBase)
local base = LuaSkillBase
bs_92082.config = {
  buffId = 195,
  buffDuration = 75,
  buffId1 = 2094
}

function bs_92082:ctor()
end

function bs_92082:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_92082_1", 1, self.OnAfterHurt, nil, nil, eBattleRoleBelong.player, eBattleRoleBelong.enemy, nil, nil, nil, nil, false)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_92082_2", 1, self.OnBattleStart)
  self.isCalledBuff = false
end

function bs_92082:OnBattleStart()
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

function bs_92082:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if hurtType == eHurtType.PhysicsDmg and not isMiss and sender.belongNum == eBattleRoleBelong.player and not isTriggerSet then
    if target.recordTable.bs_92082 == nil then
      target.recordTable.bs_92082 = 0
    end
    target.recordTable.bs_92082 = target.recordTable.bs_92082 + 1
    if target.recordTable.bs_92082 >= self.arglist[2] and self:IsReadyToTake() then
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId, 1, self.config.buffDuration, false)
      target.recordTable.bs_92082 = 0
      self:OnSkillTake()
    end
  end
end

function bs_92082:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_92082
