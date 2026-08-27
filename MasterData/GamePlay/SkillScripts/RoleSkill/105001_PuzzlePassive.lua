local bs_105001 = class("bs_105001", LuaSkillBase)
local base = LuaSkillBase
bs_105001.config = {
  summonerId = 47,
  newSummonerId = 88,
  effectId = 105004,
  effectId_tip = 105013,
  configId = 52,
  selectId = 21,
  effectId_fly = 105022,
  effectSummon = 105020,
  effectSummonDie = 105021,
  buffId = 105003,
  born_time = 20,
  weaponLv = 0,
  buffFly = 106509,
  buffStun = 106507
}
local SyncAttrList = {
  eHeroAttr.pow,
  eHeroAttr.skill_intensity,
  eHeroAttr.moveSpeed,
  eHeroAttr.dodge,
  eHeroAttr.speed,
  eHeroAttr.crit,
  eHeroAttr.critDamage,
  eHeroAttr.sunder,
  eHeroAttr.damage_increase,
  eHeroAttr.injury_reduce,
  eHeroAttr.heal,
  eHeroAttr.treatment,
  eHeroAttr.magic_pen,
  eHeroAttr.return_damage,
  eHeroAttr.life_steal,
  eHeroAttr.spell_life_steal,
  eHeroAttr.resistance
}

function bs_105001:ctor()
end

function bs_105001:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_105001_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_105001_11", 1, self.OnRoleDie)
  self.__callSummoner = BindCallback(self, self.CallSummoner)
  self:AddLuaTrigger(eSkillLuaTrigger.PuzzleSummonerTimerAcc, self.AccTimer)
  self:AddLuaTrigger(eSkillLuaTrigger.OnPuzzleNewSummoner, self.OnPuzzleNewSummoner)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_105001_2", 1, self.BeforeBattleEnd)
  self.timer = 0
  self.caster.recordTable.ult_tip = false
end

function bs_105001:OnAfterBattleStart()
  self.startTime = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.__callSummoner)
  self.effect_tip = true
end

function bs_105001:BeforeBattleEnd()
  if not LuaSkillCtrl.IsInVerify then
    LuaSkillCtrl:SetCountingColor(self.caster, 255, 255, 255, 255)
  end
  LuaSkillCtrl:HideCounting(self.caster)
end

function bs_105001:CallSummoner()
  local grid = LuaSkillCtrl:CallFindEmptyGridMostRolesArounded(2)
  if grid == nil then
    self.startTime = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.__callSummoner)
    return
  end
  local targetList = LuaSkillCtrl:FindRolesAroundGrid(grid, 2)
  if targetList == nil or targetList.Count == 0 then
    grid = LuaSkillCtrl:CallFindEmptyGridNearest(self.caster)
  end
  if grid == nil then
    self.startTime = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.__callSummoner)
    return
  end
  if self.effect_tip == true then
    self.effect_tip = false
    local target = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
    LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
  end
  local summoner = LuaSkillCtrl:CreateSummoner(self, self.config.summonerId, grid.x, grid.y)
  local ownerSkillIntensity = self.caster.skill_intensity
  local defAndMagicRes
  if self.config.weaponLv >= 3 then
    defAndMagicRes = ownerSkillIntensity * (self.arglist[2] + self.arglist[10]) // 1000
  else
    defAndMagicRes = ownerSkillIntensity * self.arglist[2] // 1000
  end
  summoner:SetAttr(eHeroAttr.magic_res, defAndMagicRes)
  summoner:SetAttr(eHeroAttr.def, defAndMagicRes)
  local hpAndMaxhp
  if self.config.weaponLv >= 3 then
    hpAndMaxhp = ownerSkillIntensity * (self.arglist[3] + self.arglist[11]) // 1000
  else
    hpAndMaxhp = ownerSkillIntensity * self.arglist[3] // 1000
  end
  summoner:SetAttr(eHeroAttr.maxHp, hpAndMaxhp)
  local hostEntity = self.caster
  if hostEntity == nil or 0 >= hostEntity.hp then
    return over
  end
  for i, v in ipairs(SyncAttrList) do
    local curValue = self.caster:GetRealProperty(v)
    summoner:SetAttr(v, curValue)
  end
  summoner:SetAsRealEntity(1)
  local arg1 = self.arglist[4]
  local arg2 = self.arglist[5]
  local arg3, arg4
  if 1 <= self.config.weaponLv then
    arg3 = self.arglist[6]
    arg4 = self.arglist[7]
  end
  local tab = {
    arg_1 = arg1,
    arg_2 = arg2,
    arg_3 = arg3,
    arg_4 = arg4
  }
  summoner:SetRecordTable(tab)
  local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
  self.caster.recordTable["105001_summoner"] = summonerEntity
  self.caster.recordTable["105001_summoner_alive"] = true
  LuaSkillCtrl:CallBuff(self, summonerEntity, self.config.buffId, 1, self.config.born_time)
end

function bs_105001:OnSyncAttrFromHost()
  local summonerEntity = self.caster.recordTable["105001_summoner"]
  if summonerEntity == nil then
    return
  end
  local ownerSkillIntensity = self.caster.skill_intensity
  for i, v in ipairs(SyncAttrList) do
    local attrValue = summonerEntity:GetRealProperty(v)
    local curValue = self.caster:GetRealProperty(v)
    summonerEntity:AddRoleProperty(v, curValue - attrValue, eHeroAttrType.Origin)
  end
  local attrValue_def = summonerEntity:GetRealProperty(eHeroAttr.def)
  local attrValue_ma_def = summonerEntity:GetRealProperty(eHeroAttr.magic_res)
  local curValue
  if self.config.weaponLv >= 3 then
    curValue = ownerSkillIntensity * (self.arglist[2] + self.arglist[10]) // 1000
  else
    curValue = ownerSkillIntensity * self.arglist[2] // 1000
  end
  summonerEntity:AddRoleProperty(eHeroAttr.def, curValue - attrValue_def, eHeroAttrType.Origin)
  summonerEntity:AddRoleProperty(eHeroAttr.magic_res, curValue - attrValue_ma_def, eHeroAttrType.Origin)
  local hp_per = summonerEntity.hp * 1000 // summonerEntity.maxHp
  local curValue_hp
  if self.config.weaponLv >= 3 then
    curValue_hp = ownerSkillIntensity * (self.arglist[3] + self.arglist[11]) // 1000
  else
    curValue_hp = ownerSkillIntensity * self.arglist[3] // 1000
  end
  local attrValue_hp = summonerEntity:GetRealProperty(eHeroAttr.maxHp)
  summonerEntity:AddRoleProperty(eHeroAttr.maxHp, curValue_hp - attrValue_hp, eHeroAttrType.Origin)
  local hp_now = curValue_hp * hp_per // 1000
  if hp_now > summonerEntity.hp then
    local num = hp_now - summonerEntity.hp
    LuaSkillCtrl:CallHeal(num, self, summonerEntity, true)
  else
    local num = summonerEntity.hp - hp_now
    LuaSkillCtrl:RemoveLife(num, self, summonerEntity, true, nil, false, true, 2, true)
  end
end

function bs_105001:OnRoleDie(killer, role, killSkill)
  if role.roleDataId == self.config.summonerId and role.roleType == eBattleRoleType.realSummoner then
    LuaSkillCtrl:CallEffect(role, self.config.effectId_tip, self)
    self.caster.recordTable["105001_summoner_alive"] = false
    self.timer = 0
    self.caster.recordTable.ult_tip = true
    if self.config.weaponLv >= 1 then
      local targetGrid = LuaSkillCtrl:GetTargetWithGrid(role.x, role.y)
      LuaSkillCtrl:CallEffect(targetGrid, self.config.effectSummon, self)
      LuaSkillCtrl:CallEffect(targetGrid, self.config.effectSummonDie, self)
    end
    if self.config.weaponLv >= 3 then
      local targetGrid = LuaSkillCtrl:GetTargetWithGrid(role.x, role.y)
      LuaSkillCtrl:CallEffect(targetGrid, self.config.effectId_fly, self)
      local targetList = LuaSkillCtrl:FindAllRolesWithinRange(role, 1, false)
      for i = targetList.Count - 1, 0, -1 do
        local target = targetList[i]
        if target == nil or target.belongNum == eBattleRoleBelong.player then
          targetList:RemoveAt(i)
        end
      end
      for i = targetList.Count - 1, 0, -1 do
        LuaSkillCtrl:CallBuff(self, targetList[i], self.config.buffStun, 1, self.arglist[9], nil, nil, true)
        LuaSkillCtrl:CallBuff(self, targetList[i], self.config.buffFly, 1, 7, nil, nil, true)
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetList[i])
        local num = role.maxHp * self.arglist[8] // 1000
        LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {num})
        skillResult:EndResult()
      end
    end
  end
  if role.roleDataId == self.config.newSummonerId and 0 < self.config.weaponLv then
    self.caster.recordTable.newSummoner_alive = false
  end
end

function bs_105001:OnPuzzleNewSummoner(role)
  self.caster.recordTable.newSummoner_alive = true
  self.caster.recordTable.new_summoner = role
end

function bs_105001:AccTimer(arg)
  local arg4 = self.caster.recordTable.arg4
  if arg == -1 then
    local grid = LuaSkillCtrl:CallFindEmptyGridMostRolesArounded(2)
    if grid == nil then
      LuaSkillCtrl:ShowCounting(self.caster, arg4, arg4)
      self.timer = arg4 - 1
      return
    end
    self.caster.recordTable.ult_tip = false
    self:__callSummoner()
    LuaSkillCtrl:HideCounting(self.caster)
    self.timer = 0
    return
  end
  if arg == -2 then
    self:OnSyncAttrFromHost()
    return
  end
  self.timer = self.timer + 1
  if self.timer == arg then
    local grid = LuaSkillCtrl:CallFindEmptyGridMostRolesArounded(2)
    if grid == nil then
      LuaSkillCtrl:ShowCounting(self.caster, self.timer, arg)
      self.timer = self.timer - 1
      return
    end
    self.effect_tip = true
    self:__callSummoner()
    LuaSkillCtrl:HideCounting(self.caster)
    self.timer = 0
  else
    LuaSkillCtrl:ShowCounting(self.caster, self.timer, arg)
  end
end

function bs_105001:OnCasterDie()
  base.OnCasterDie(self)
  LuaSkillCtrl:HideCounting(self.caster)
  if self.startTime ~= nil then
    self.startTime:Stop()
    self.startTime = nil
  end
end

function bs_105001:LuaDispose()
  base.LuaDispose(self)
  if self.startTime ~= nil then
    self.startTime:Stop()
    self.startTime = nil
  end
end

return bs_105001
