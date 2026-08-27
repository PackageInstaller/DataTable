local bs_30066 = class("bs_30066", LuaSkillBase)
local base = LuaSkillBase
bs_30066.config = {buffId_Giant = 1507}

function bs_30066:ctor()
end

function bs_30066:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_30066_1", 1, self.OnRoleDie, nil, nil, nil, eBattleRoleBelong.player, nil, nil, nil)
  self.deadSummonerNum = 0
end

function bs_30066:OnRoleDie(killer, role)
  if role.roleType ~= eBattleRoleType.realSummoner then
    return
  end
  self.deadSummonerNum = self.deadSummonerNum + 1
  if self.deadSummonerNum >= self.arglist[3] then
    self.deadSummonerNum = 0
    LuaSkillCtrl:StartTimer(nil, 7, BindCallback(self, self.eventFunc))
  end
end

function bs_30066:eventFunc()
  local target = self:findMaxMagic()
  if target == nil then
    return
  end
  LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buffId_Giant, self.arglist[1], nil, false)
end

function bs_30066:findMaxMagic()
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 80, 10)
  if targetList == nil or targetList.Count < 1 then
    return
  end
  return targetList[0]
end

function bs_30066:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30066
