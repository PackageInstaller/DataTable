local bs_212106 = class("bs_212106", LuaSkillBase)
local base = LuaSkillBase
bs_212106.config = {
  buffId_pow = 212101,
  buffId_skill_intensity = 212106,
  monsterId = 65,
  actionId_start = 1028,
  actionId_loop = 1029,
  actionId_end = 1030,
  action_speed = 1,
  actionId_start_time = 20,
  actionId_end_time = 14,
  heal_config = {baseheal_formula = 3022},
  buff_wudi = 212103,
  debuff_def = 212104,
  buff_grow = 212106,
  effectId_line = 212108,
  effectId_lineStart = 212109,
  effectId_lineEnd = 212110,
  effectId_Summon = 212111,
  effectId_die = 212112
}

function bs_212106:ctor()
end

function bs_212106:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_212106_2", 1, self.OnRoleDie, nil, nil, nil, self.caster.belongNum)
  self.table = {}
  self.effectTable = {}
  self.skilltime = self.arglist[2]
  self.lineEndeffectTable = {}
  self.Count = 0
  self.onCastSkill = false
end

function bs_212106:PlaySkill(data)
  self.onCastSkill = true
  if self.caster.recordTable.P4 == true then
    self:doSummon()
    self:doSummon()
  else
    self:doSummon()
  end
  local time = self.skilltime
  self:CallCasterWait(time)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_start, self.config.action_speed)
  LuaSkillCtrl:StartTimer(nil, self.config.actionId_start_time, BindCallback(self, self.OnAttackTrigger), nil)
  self.loopAttack = LuaSkillCtrl:StartTimer(self, self.config.actionId_start_time, function()
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_loop, self.config.action_speed)
  end, nil)
  self.finishAttack = LuaSkillCtrl:StartTimer(self, self.skilltime - self.config.actionId_end_time, function()
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end, self.config.action_speed)
  end, nil)
  LuaSkillCtrl:CallBuff(self, self.caster, 170, 1, time, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_wudi, 1, time, true)
  local callnextskill = BindCallback(self, self.EndSkillAndCallNext)
  LuaSkillCtrl:StartTimer(self, time, callnextskill)
end

function bs_212106:OnAttackTrigger()
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.skilltime - self.config.actionId_start_time)
  for i = 1, #self.table do
    self.effectTable[self.table[i]] = LuaSkillCtrl:CallEffect(self.table[i], self.config.effectId_line, self)
    LuaSkillCtrl:StartTimer(self, 2, function()
      self.lineEndeffectTable[self.table[i]] = LuaSkillCtrl:CallEffect(self.table[i], self.config.effectId_lineEnd, self)
    end)
  end
  self.grow = LuaSkillCtrl:StartTimer(nil, self.skilltime - self.config.actionId_start_time, BindCallback(self, self.growup), nil)
  self.lineStart = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_lineStart, self)
end

function bs_212106:growup()
  for i = 1, #self.table do
    local role = self.table[i]
    if role ~= nil and role.hp > 0 then
      if self.effectTable[role] ~= nil then
        self.effectTable[role]:Die()
        self.effectTable[role] = nil
        self.lineEndeffectTable[role]:Die()
        self.lineEndeffectTable[role] = nil
      end
      LuaSkillCtrl:CallEffect(role, self.config.effectId_die, self)
      LuaSkillCtrl:RemoveLife(role.hp, self, role, true, nil, false, true, eHurtType.RealDmg, true)
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_grow, 1, nil, true)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
      LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {
        self.arglist[5]
      })
      skillResult:EndResult()
    end
  end
  self.table = {}
  if self.lineStart ~= nil then
    self.lineStart:Die()
    self.lineStart = nil
  end
end

function bs_212106:doSummon()
  local Grid = LuaSkillCtrl:FindRandomEmptyGridsWithinRange(1, 1, 10, true)
  local summonerEntity
  if Grid ~= nil then
    local target = LuaSkillCtrl:GetTargetWithGrid(Grid.x, Grid.y)
    LuaSkillCtrl:CallEffect(target, self.config.effectId_Summon, self)
    local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.monsterId, Grid.x, Grid.y)
    summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.arglist[9] // 1000)
    summoner:SetAttr(eHeroAttr.dodge, self.caster.dodge * self.arglist[10] // 1000)
    summoner:SetAttr(eHeroAttr.injury_reduce, self.caster.injury_reduce * self.arglist[10] // 1000)
    summoner:SetAttr(eHeroAttr.def, self.caster.def * self.arglist[10] // 1000)
    summoner:SetAttr(eHeroAttr.magic_res, self.caster.magic_res * self.arglist[10] // 1000)
    summoner:SetAsRealEntity(1)
    summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
    table.insert(self.table, summonerEntity)
    LuaSkillCtrl:CallBuff(self, summonerEntity, self.config.buff_wudi, 1, self.config.actionId_start_time, true)
  end
end

function bs_212106:OnRoleDie(killer, role)
  if killer == self.caster then
    return
  end
  if self.effectTable[role] ~= nil then
    self.effectTable[role]:Die()
    self.effectTable[role] = nil
  else
    return
  end
  if self.lineEndeffectTable[role] ~= nil then
    self.lineEndeffectTable[role]:Die()
    self.lineEndeffectTable[role] = nil
  end
  if role == self.table[1] then
    self.table[1] = nil
    self.Count = self.Count - 1
  elseif role == self.table[2] then
    self.table[2] = nil
    self.Count = self.Count - 1
  end
  if #self.table == 0 then
    if self.lineStart ~= nil then
      self.lineStart:Die()
      self.lineStart = nil
    end
    self.table = {}
    if self.caster.recordTable.def == true then
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_pow, 1)
      self.caster.recordTable.def = false
    elseif self.caster.recordTable.def_intensity == true then
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_skill_intensity, 1)
      self.caster.recordTable.def_intensity = false
    end
    if self.grow ~= nil then
      self.grow:Stop()
      self.grow = nil
    end
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buff_wudi, 0)
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.debuff_def, 1, self.arglist[8], true)
    self:EndSkillAndCallNext()
  end
end

function bs_212106:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
  for i = 1, #self.table do
    local target = self.table[i]
    if target ~= nil and target.hp > 0 and self.effectTable[target] ~= nil then
      self.effectTable[target]:Die()
      self.effectTable[target] = nil
      self.lineEndeffectTable[target]:Die()
      self.lineEndeffectTable[target] = nil
    end
  end
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buff_wudi, 0)
  self.table = {}
  if self.lineStart ~= nil then
    self.lineStart:Die()
    self.lineStart = nil
  end
  if self.onCastSkill == true then
    self:EndSkillAndCallNext()
  end
end

function bs_212106:EndSkillAndCallNext()
  self.onCastSkill = false
  LuaSkillCtrl:DispelBuff(self.caster, 170, 0)
  if self.caster == nil then
    return
  end
  self:CancleCasterWait()
  local skillMgr = self.caster:GetSkillComponent()
  if skillMgr == nil then
    return
  end
  skillMgr.lastSkill = self.cskill
  self.caster:CallUnFreezeNextSkill()
  LuaSkillCtrl:StopShowSkillDurationTime(self)
end

function bs_212106:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_212106
