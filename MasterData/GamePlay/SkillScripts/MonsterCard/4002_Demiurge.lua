local bs_4002 = class("bs_4002", LuaSkillBase)
local base = LuaSkillBase
bs_4002.config = {
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
  HurtConfigID = 3,
  nextSkillId = 204803
}

function bs_4002:ctor()
end

function bs_4002:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_104402_1", 1, self.OnAfterBattleStart)
  self.interval = self.arglist[5]
  self.bufftime = self.arglist[2]
end

function bs_4002:OnAfterBattleStart()
  local attackTrigger = BindCallback(self, self.Summon)
  LuaSkillCtrl:StartTimer(nil, self.interval, function()
    self:Summon()
  end, nil, -1)
end

function bs_4002:Summon()
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 42, 10)
  if targetList.Count > 0 then
    for i = targetList.Count - 1, 0, -1 do
      if targetList[i].targetRole ~= nil and targetList[i].targetRole.belongNum == eBattleRoleBelong.enemy then
        self:CallSummoner(targetList[i].targetRole)
        break
      end
    end
  end
end

function bs_4002:CallSummoner(targetRole)
  if targetRole.hp > 0 then
    local skill_intensity = 0
    local targetlist1 = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
    if 0 < targetlist1.Count then
      for i = 0, targetlist1.Count - 1 do
        if skill_intensity <= targetlist1[i].skill_intensity then
          skill_intensity = targetlist1[i].skill_intensity
        end
      end
    end
    local damage = self.arglist[1] * skill_intensity // 1000
    LuaSkillCtrl:RemoveLife(damage, self, targetRole, true, nil, true, false, eHurtType.RealDmg)
    local x = targetRole.x
    local y = targetRole.y
    local isOverlap = false
    local tempRole = LuaSkillCtrl:GetRoleWithPos(x, y)
    if tempRole ~= targetRole then
      isOverlap = true
    end
    LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId_165, 1, self.bufftime)
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
    local highAttRole = LuaSkillCtrl:CallTargetSelect(self, 51, 20)
    if highAttRole ~= nil and 0 < highAttRole.Count and highAttRole[0] ~= nil then
      local skill_intensity = highAttRole[0].targetRole.skill_intensity
      local maxHp = highAttRole[0].targetRole.maxHp
      local pow = highAttRole[0].targetRole.pow
      summoner:SetAttr(eHeroAttr.maxHp, maxHp * self.arglist[3] // 1000)
      summoner:SetAttr(eHeroAttr.skill_intensity, skill_intensity * self.arglist[4] // 1000)
      summoner:SetAttr(eHeroAttr.pow, pow * self.arglist[4] // 1000)
      summoner:SetAttr(eHeroAttr.speed, highAttRole[0].speed)
    end
    summoner:SetAsRealEntity(1)
    local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
    LuaSkillCtrl:CallRoleAction(summonerEntity, 1002, 1)
  end
end

function bs_4002:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_4002:LuaDispose()
  base.LuaDispose(self)
end

return bs_4002
