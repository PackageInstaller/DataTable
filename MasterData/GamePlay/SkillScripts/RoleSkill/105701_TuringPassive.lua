local bs_105701 = class("bs_105701", LuaSkillBase)
local base = LuaSkillBase
bs_105701.config = {monsterId = 58, buffId_speed = 105701}

function bs_105701:ctor()
end

function bs_105701:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_105701_1", 1, self.OnAfterBattleStart)
  self:AddOnRoleDieTrigger("bs_105701_2", 1, self.OnRoleDie, nil, nil, nil, self.caster.belongNum)
  self.maxCount = 3
  self.table = {}
  self.Count = 0
end

function bs_105701:OnAfterBattleStart()
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], BindCallback(self, self.doSummon), nil, -1, 0)
end

function bs_105701:doSummon()
  if self.Count < self.maxCount then
    self:Summon()
  else
    for i = 1, self.maxCount do
      if self.table[i] ~= nil then
        LuaSkillCtrl:CallBuff(self, self.table[i], self.config.buffId_speed, 1, self.arglist[2])
      end
    end
  end
end

function bs_105701:Summon()
  local Grid = LuaSkillCtrl:CallFindEmptyGridNearest(self.caster)
  if Grid == nil then
    Grid = LuaSkillCtrl:FindRoleRightEmptyGrid(self.caster, 10)
  end
  local summonerEntity
  if Grid ~= nil then
    local target = LuaSkillCtrl:GetTargetWithGrid(Grid.x, Grid.y)
    local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.monsterId, Grid.x, Grid.y)
    summoner:SetAttr(eHeroAttr.maxHp, self.caster.maxHp * self.arglist[3] // 1000)
    summoner:SetAttr(eHeroAttr.skill_intensity, self.caster.skill_intensity * self.arglist[4] // 1000)
    summoner:SetAttr(eHeroAttr.pow, self.caster.pow * self.arglist[4] // 1000)
    summoner:SetAttr(eHeroAttr.speed, self.caster.speed)
    summoner:SetAttr(eHeroAttr.moveSpeed, self.caster.moveSpeed)
    summoner:SetAttr(eHeroAttr.def, self.caster.def * self.arglist[5] // 1000)
    summoner:SetAttr(eHeroAttr.magic_res, self.caster.magic_res * self.arglist[5] // 1000)
    summoner:SetAttr(eHeroAttr.lucky, self.lucky)
    summoner:SetAsRealEntity(1)
    local arg1
    local arg2 = self.arglist[6]
    if self.table[1] == nil then
      arg1 = 1
    elseif self.table[2] == nil then
      arg1 = 2
    else
      arg1 = 3
    end
    local tab = {arg_1 = arg1, arg_2 = arg2}
    summoner:SetRecordTable(tab)
    summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
    if arg1 == 1 then
      self.table[1] = summonerEntity
      self.Count = self.Count + 1
    elseif arg1 == 2 then
      self.table[2] = summonerEntity
      self.Count = self.Count + 1
    elseif arg1 == 3 then
      self.table[3] = summonerEntity
      self.Count = self.Count + 1
    end
  end
end

function bs_105701:OnRoleDie(killer, role)
  if role == self.table[1] then
    self.table[1] = nil
    self.Count = self.Count - 1
  elseif role == self.table[2] then
    self.table[2] = nil
    self.Count = self.Count - 1
  elseif role == self.table[3] then
    self.table[3] = nil
    self.Count = self.Count - 1
  end
end

function bs_105701:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function bs_105701:LuaDispose()
  self.table = nil
  base.LuaDispose(self)
end

return bs_105701
