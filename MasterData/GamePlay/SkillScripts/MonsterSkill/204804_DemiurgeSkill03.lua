local bs_204804 = class("bs_204804", LuaSkillBase)
local base = LuaSkillBase
bs_204804.config = {
  buffId_165 = 165,
  actionId = 1105,
  action_speed = 1,
  start_time = 15,
  findGridRange = 3,
  buffId_63 = 63,
  SummonerId = 31,
  effect_jifei = 204813,
  hurt_config = {
    hit_formula = 10201,
    basehurt_formula = 10076,
    crit_formula = 0
  },
  nextSkillId = 204803
}

function bs_204804:ctor()
end

function bs_204804:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_204804:PlaySkill(data)
  self:AbandonSkillCdAutoReset(true)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  local attackTrigger = BindCallback(self, self.Summon, targetList)
  self:CallCasterWait(self.config.start_time + 1)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
end

function bs_204804:Summon(targetList)
  if targetList.Count <= 0 then
    return
  end
  local index = 0
  LuaSkillCtrl:StartTimer(nil, 1, function()
    local targetRole = targetList[index].targetRole
    self:CallSummoner(targetRole)
    index = index + 1
  end, nil, targetList.Count - 1, 1)
  self:CancleCasterWait()
  self:CallNextBossSkill()
end

function bs_204804:CallSummoner(targetRole)
  if targetRole.hp > 0 and 0 < targetRole.intensity then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, nil, false)
    skillResult:EndResult()
    local x = targetRole.x
    local y = targetRole.y
    local isOverlap = false
    local tempRole = LuaSkillCtrl:GetRoleWithPos(x, y)
    if tempRole ~= targetRole then
      isOverlap = true
    end
    LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId_165, 1, self.arglist[2])
    LuaSkillCtrl:CallEffect(targetRole, self.config.effect_jifei, self)
    local maxRange = self.config.findGridRange
    local grid
    for tempRange = 1, maxRange do
      grid = LuaSkillCtrl:FindEmptyGridWithinRange(targetRole, tempRange)
      if grid ~= nil then
        if isOverlap then
          x = grid.x
          y = grid.y
          isOverlap = false
        else
          LuaSkillCtrl:CallPhaseMove(self, targetRole, grid.x, grid.y, 5, self.config.buffId_63, 1, true)
          break
        end
      end
    end
    if grid == nil then
      grid = LuaSkillCtrl:FindEmptyGrid()
      if grid == nil then
        self:CancleCasterWait()
        self:CallNextBossSkill()
        return
      end
      if isOverlap then
        x = grid.x
        y = grid.y
        isOverlap = false
        grid = nil
      end
      if grid == nil then
        grid = LuaSkillCtrl:FindEmptyGrid()
      end
      LuaSkillCtrl:CallPhaseMove(self, targetRole, grid.x, grid.y, 5, self.config.buffId_63, 1, true)
    end
    local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.SummonerId, x, y)
    summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.arglist[3] // 1000)
    summoner:SetAttr(eHeroAttr.pow, self.caster.pow * self.arglist[4] // 1000)
    summoner:SetAttr(eHeroAttr.intensity, self.caster.intensity * self.arglist[4] // 1000)
    summoner:SetAttr(eHeroAttr.speed, self.caster.speed)
    summoner:SetAsRealEntity(1)
    local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
    LuaSkillCtrl:CallRoleAction(summonerEntity, 1002, 1)
  end
end

function bs_204804:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_204804:LuaDispose()
  base.LuaDispose(self)
end

return bs_204804
