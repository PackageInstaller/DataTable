local bs_61701 = class("bs_61701", LuaSkillBase)
local base = LuaSkillBase
bs_61701.config = {
  heal_config = {baseheal_formula = 3022},
  skilltime = 37,
  actionId = 1002,
  action_speed = 1,
  actionId_start_time = 20,
  actionId_start = 1022,
  actionId_loop = 1023,
  actionId_end = 1024,
  effectId2 = 210907,
  firstsummontime = 30,
  monsterId = 67
}

function bs_61701:ctor()
end

function bs_61701:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_61701_1", 1, self.OnAfterBattleStart)
  self:AddOnRoleDieTrigger("bs_61701_2", 1, self.OnRoleDie, nil, nil, nil, self.caster.belongNum)
  self.maxCount = 3
  self.table = {}
  self.caster.recordTable.Count = 0
  self.caster.recordTable.changeCount = 3
  self.caster.recordTable.onskill = false
  self.caster.recordTable.ptolomaea = true
end

function bs_61701:OnAfterBattleStart()
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[4], BindCallback(self, self.doskill), nil, -1, self.arglist[4] - self.config.firstsummontime)
end

function bs_61701:doSummon()
  if self.caster.recordTable.Count < self.maxCount then
    local num = self.maxCount - self.caster.recordTable.Count
    for i = 1, num do
      self:Summon()
    end
  else
    for i = 1, self.maxCount do
      if self.table[i] ~= nil then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.table[i])
        LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {10000})
        skillResult:EndResult()
      end
    end
  end
end

function bs_61701:doskill()
  LuaSkillCtrl:StartTimer(nil, self.config.actionId_start_time, BindCallback(self, self.doSummon), nil)
end

function bs_61701:Summon()
  local Grid = LuaSkillCtrl:CallFindEmptyGridNearest(self.caster)
  if Grid == nil then
    Grid = LuaSkillCtrl:FindRoleRightEmptyGrid(self.caster, 10)
  end
  local summonerEntity
  if Grid ~= nil then
    local target = LuaSkillCtrl:GetTargetWithGrid(Grid.x, Grid.y)
    LuaSkillCtrl:CallEffect(target, self.config.effectId2, self)
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end, self.config.action_speed)
    local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.monsterId, Grid.x, Grid.y)
    summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.arglist[1] // 1000)
    summoner:SetAttr(eHeroAttr.skill_intensity, self.caster.skill_intensity * self.arglist[2] // 1000)
    summoner:SetAttr(eHeroAttr.pow, self.caster.pow * self.arglist[2] // 1000)
    summoner:SetAttr(eHeroAttr.speed, self.caster.speed)
    summoner:SetAttr(eHeroAttr.moveSpeed, self.caster.moveSpeed)
    summoner:SetAttr(eHeroAttr.def, self.caster.def * self.arglist[3] // 1000)
    summoner:SetAttr(eHeroAttr.magic_res, self.caster.magic_res * self.arglist[3] // 1000)
    summoner:SetAttr(eHeroAttr.lucky, self.lucky)
    summoner:SetAsRealEntity(1)
    summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
    table.insert(self.table, summonerEntity)
    self.caster.recordTable.Count = self.caster.recordTable.Count + 1
  end
end

function bs_61701:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
end

function bs_61701:OnRoleDie(killer, role)
  for i, v in ipairs(self.table) do
    if role == v then
      table.remove(self.table, i)
      self.caster.recordTable.Count = self.caster.recordTable.Count - 1
      break
    end
  end
end

function bs_61701:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function bs_61701:LuaDispose()
  self.table = nil
  base.LuaDispose(self)
end

return bs_61701
