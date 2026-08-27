local bs_17206 = class("bs_17206", LuaSkillBase)
local base = LuaSkillBase
bs_17206.config = {
  summontagId = 3,
  effectId1 = 60634,
  effectId2 = 60635,
  HurtConfig = 50,
  summonerId = 79
}

function bs_17206:ctor()
end

function bs_17206:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_17206_1", 1, self.OnAfterBattleStart)
end

function bs_17206:OnAfterBattleStart()
  self.damTimer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.CallBack, self, -1)
end

function bs_17206:CallBack()
  if self.damTimer ~= nil and self.damTimer:IsOver() then
    self.damTimer = nil
  end
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetlist == nil or targetlist.Count == 0 then
    return
  end
  local target = LuaSkillCtrl:GetTargetWithGrid(10, 7)
  LuaSkillCtrl:CallEffect(target, self.config.effectId1, self)
  local hurtnum = 0
  local Summonerlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if Summonerlist.Count > 0 then
    for i = 0, Summonerlist.Count - 1 do
      if Summonerlist[i].roleDataId == self.config.summonerId then
        hurtnum = hurtnum + Summonerlist[i].pow
      end
    end
  end
  hurtnum = self.arglist[2] * hurtnum // 1000
  self.timer = LuaSkillCtrl:StartTimer(self, 5, function()
  end)
  if targetlist.Count > 0 then
    for i = 0, targetlist.Count - 1 do
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetlist[i])
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfig, {hurtnum}, false)
      skillResult:EndResult()
      LuaSkillCtrl:CallEffect(targetlist[i], self.config.effectId2, self)
    end
  end
end

function bs_17206:OnCasterDie()
  base.OnCasterDie(self)
  if self.damTimer then
    self.damTimer:Stop()
    self.damTimer = nil
  end
end

return bs_17206
