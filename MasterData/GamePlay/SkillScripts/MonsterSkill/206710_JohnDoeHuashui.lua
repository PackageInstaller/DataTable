local bs_206710 = class("bs_206710", LuaSkillBase)
local base = LuaSkillBase
bs_206710.config = {
  monsterId = 1017,
  buffId = 1033,
  effectId = 10264,
  effectId1 = 10263,
  startAnimID = 1002,
  buffId_196 = 196,
  buffId_1033 = 1033,
  skill_time = 18,
  maxHpPer = 150,
  powPer = 700
}

function bs_206710:ctor()
end

function bs_206710:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_206710_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_206710_10", 1, self.OnRoleDie)
end

function bs_206710:OnAfterBattleStart()
  self.damTimer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.CallBack, self, -1, self.arglist[1])
  self.canSummon = true
end

function bs_206710:CallBack()
  if self.damTimer ~= nil and self.damTimer:IsOver() then
    self.damTimer = nil
  end
  if self.canSummon == true then
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId1, self)
    local cback = BindCallback(self, self.CallBack1)
    self.damTimer2 = LuaSkillCtrl:StartTimer(nil, 2, cback, nil, 0, 0)
  end
end

function bs_206710:CallBack1()
  if self.damTimer2 ~= nil and self.damTimer2:IsOver() then
    self.damTimer2 = nil
  end
  local gridData = LuaSkillCtrl:CallFindEmptyGridNearest(self.caster)
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetlist.Count < 1 then
    return
  end
  for i = 0, targetlist.Count - 1 do
    local gridDataTemp = LuaSkillCtrl:FindEmptyGridWithinRange(targetlist[i].targetRole, 1)
    if gridDataTemp ~= nil then
      gridData = gridDataTemp
    end
  end
  local x = gridData.x
  local y = gridData.y
  local target = LuaSkillCtrl:GetTargetWithGrid(gridData.x, gridData.y)
  LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
  local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.monsterId, x, y)
  summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.config.maxHpPer // 1000)
  summoner:SetAttr(eHeroAttr.pow, self.caster.pow * self.config.powPer // 1000)
  summoner:SetAttr(eHeroAttr.intensity, self.caster.intensity * self.config.powPer // 1000)
  summoner:SetAttr(eHeroAttr.speed, self.caster.speed)
  summoner:SetAsRealEntity(1)
  local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
  self.summoner = summonerEntity
  self.canSummon = false
end

function bs_206710:OnRoleDie(killer, role)
  if role == self.summoner then
    self.canSummon = true
  end
end

function bs_206710:OnCasterDie()
  base.OnCasterDie(self)
  if self.damTimer then
    self.damTimer:Stop()
    self.damTimer = nil
  end
  if self.damTimer2 then
    self.damTimer2:Stop()
    self.damTimer2 = nil
  end
end

return bs_206710
