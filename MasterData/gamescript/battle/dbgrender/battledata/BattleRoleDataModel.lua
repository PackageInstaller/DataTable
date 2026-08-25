local BP = bc.BattleProperty
local DamageType = {Normal = 0, Puncture = 1}

local function createBattleRoleDataModelState()
  local data = {}
  data.properties = {}
  data.schoolSpecialArgs = {}
  return data
end

local function createBattleRoleDataModelViews(_)
  local views = {}
  local DT = bg.DT
  
  function views:GetProperty(property)
    if not property then
      return 0
    end
    if self.properties[property] then
      return self.properties[property]
    end
    if "TeamAtk" == property then
      do return self.GetTeamAtk end
      return self.GetTeamAtk, self, nil, nil, nil
    end
    if "AvgPhysique" == property then
      do return self.GetAvgAttr, self end
      return self.GetAvgAttr, self, BP.physique, nil, nil
    end
    if "AvgDefence" == property then
      do return self.GetAvgAttr, self end
      return self.GetAvgAttr, self, BP.def, nil, nil
    end
    if "AvgCrit" == property then
      do return self.GetAvgAttr, self end
      return self.GetAvgAttr, self, BP.crit, nil, nil
    end
    if "AvgCritDamage" == property then
      do return self.GetAvgAttr, self end
      return self.GetAvgAttr, self, BP.crit_damage, nil, nil
    end
    local firstAwakerUid = self.firstAwakerUid
    if firstAwakerUid then
      local awakerData = bg.battleDataCenter:GetAwakerDataModel(firstAwakerUid)
      do return awakerData.GetProperty, awakerData end
      return awakerData.GetProperty, awakerData, property
    end
    return 0
  end
  
  function views:GetSkinId()
    return self.curSkin
  end
  
  function views:GetTeamAtk()
    local awakerList = bg.battleScene:GetPlayerAwakerList()
    local totalAtk = 0
    for _, awaker in ipairs(awakerList) do
      local atk = awaker:GetProperty(BP.atk)
      local atk_per = awaker:GetProperty(BP.atk_per)
      local final_atk = math.ceil(atk * (1 + atk_per / 100))
      totalAtk = final_atk + totalAtk
    end
    if #awakerList > 0 then
      totalAtk = math.ceil(totalAtk / #awakerList)
    end
    return totalAtk
  end
  
  function views:GetAvgAttr(attrName)
    local awakerList = bg.battleScene:GetPlayerAwakerList()
    local totalValue = 0
    for _, awaker in ipairs(awakerList) do
      local value = awaker:GetProperty(attrName)
      totalValue = value + totalValue
    end
    if #awakerList > 0 then
      totalValue = math.ceil(totalValue / #awakerList)
    end
    return totalValue
  end
  
  function views:GetUid()
    return self.uid
  end
  
  function views:IsDead()
    return 0 == self:GetHp()
  end
  
  local phase2state = {
    [1] = DT.GetConstant("Set_State_D_LV1"),
    [2] = DT.GetConstant("Set_State_D_LV2"),
    [3] = DT.GetConstant("Set_State_D_LV3"),
    [4] = DT.GetConstant("Set_State_D_LV4"),
    [5] = DT.GetConstant("Set_State_D_LV5"),
    [6] = DT.GetConstant("Set_State_D_LV6"),
    [7] = DT.GetConstant("Set_State_D_LV7"),
    [8] = DT.GetConstant("Set_State_D_LV8"),
    [9] = DT.GetConstant("Set_State_D_LV9"),
    [10] = DT.GetConstant("Set_State_D_LV10")
  }
  
  function views:GetBossPhaseIndex()
    for phase = 10, 1, -1 do
      local stateId = phase2state[phase]
      if stateId and table.next(bg.battleDataCenter.stateData:GetStateListByOwnerAndStateId(self.uid, stateId) or {}) then
        return phase
      end
    end
  end
  
  function views:GetHp()
    do return self.GetProperty, self end
    return self.GetProperty, self, bc.RoleProperty.hp
  end
  
  function views:GetMaxHp()
    do return self.GetProperty, self end
    return self.GetProperty, self, bc.RoleProperty.max_hp
  end
  
  function views:GetMonsterLifeNum()
    return self.monsterLiftNum or 1
  end
  
  function views:GetHpNum()
    return self.hpNum or 1
  end
  
  function views:GetRoleName(withLevel)
    if self.showName then
      do return LT.Text end
      return LT.Text, self.showName, nil, nil, nil, nil, nil, nil, nil, nil
    end
    if self.roleType == bc.RoleType.Monster then
      local configData = self.configData
      local roleName = LT.Text(configData.Name or configData.MonsterName)
      local affixList = self.affixList or {}
      local affixStr = bg.battleDataCenter:GetAffixStr(affixList)
      if withLevel then
        do return string.format, "%s%s Lv.%d", affixStr, roleName, self:GetTeamAverageLevel() end
        return string.format, "%s%s Lv.%d", affixStr, roleName, self:GetTeamAverageLevel()
      end
      return affixStr .. roleName
    else
      do return LT.Text end
      return LT.Text, self.configData.Name, {}, bg.battleDataCenter:GetAffixStr(affixList), affixStr .. roleName, roleName, affixStr, roleName, self:GetTeamAverageLevel()
    end
  end
  
  function views:GetBlock()
    do return self.GetProperty, self end
    return self.GetProperty, self, bc.RoleProperty.block
  end
  
  function views:GetDamageStr(damageInfo)
    damageInfo = damageInfo or {}
    local dmg, times = damageInfo[1], damageInfo[2]
    local str = bc.NumberToK(tostring(dmg or ""))
    if times and 1 ~= times then
      str = str .. "x" .. times
    end
    return str
  end
  
  function views:GetIntentionIcon(intention)
    if not intention then
      return
    end
    local skillCfg = DT.Skill[intention]
    if not skillCfg then
      return
    end
    local skillTypes = BattleSkillUtils.GetSkillType(skillCfg, 0, 0)
    local skillType = skillTypes[1]
    return DT.MonsterIntent[skillType].IconPath
  end
  
  function views:GetTeamAverageLevel()
    if self.level then
      return self.level
    end
    local level = 0
    for _, awaker in ipairs(self.awakerDataList) do
      level = level + (awaker.level or 0)
    end
    return level
  end
  
  function views:GetAwakerLevel(awakerTid)
    if self.level then
      return self.level
    end
    local awaker = self:GetAwaker(awakerTid)
    if awaker then
      return awaker.level
    end
    return 0
  end
  
  function views:GetDimensionFixPer()
    local value = 0
    if self.camp == bc.BattleCamp.Camp1 then
      local player = bg.battleDataCenter:GetPlayerRoleDataModel(self.camp)
      value = player and player:GetProperty(bc.BattleProperty.dimension_fix_per) or 0
    end
    return value
  end
  
  function views:GetOceanModeGrayCd()
    local cmdParser = bg.battleRender:GetCmdParser()
    return cmdParser:GetValueByCmd("OceanModel2CD") or 0
  end
  
  function views:GetOceanModeRedCd()
    local cmdParser = bg.battleRender:GetCmdParser()
    return cmdParser:GetValueByCmd("OceanModel3CD") or 0
  end
  
  function views:GetBloodAbilityCd()
    local cmdParser = bg.battleRender:GetCmdParser()
    return cmdParser:GetValueByCmd("BloodAbilityCD") or 0
  end
  
  function views:GetDimensionAbilityCd()
    local cmdParser = bg.battleRender:GetCmdParser()
    return cmdParser:GetValueByCmd("DimensionAbilityCD") or 0
  end
  
  function views:GetTentacleDmgShow()
    if self.schoolSpecialArgs[bc.BattleProperty.tentacle_dmg_show] then
      return self.schoolSpecialArgs[bc.BattleProperty.tentacle_dmg_show]
    end
    do return self.GetTentacleDmg end
    return self.GetTentacleDmg, self
  end
  
  function views:GetTentacleDmg()
    if self.schoolSpecialArgs[bc.BattleProperty.tentacle_dmg] then
      return self.schoolSpecialArgs[bc.BattleProperty.tentacle_dmg]
    end
    local v = self:GetProperty(bc.BattleProperty.tentacle_dmg)
    if bg.isPVE then
      local curDmg = self:GetProperty(BP.tentacle_dmg) or 0
      local baseDamage = self:GetProperty(BP.tentacle_base_dmg) or 0
      local basic_damage_per = self:GetProperty(BP.basic_damage_per) or 0
      local weakPer = self:GetProperty(BP.weak_per) or 0
      local tentacleDmgPer = self:GetProperty(BP.tentacle_dmg_per) or 0
      local insideBasicDmgPer, insideDmgPer, insideDmgPer1, insideDmgPer2, insideDmgPer3, awakerNum = 0, 0, 0, 0, 0, 0
      local dimension_fix_per = self:GetDimensionFixPer()
      local awakerList = bg.battleDataCenter:GetAwakerListByCamp(self.camp)
      for _, awaker in ipairs(awakerList) do
        insideBasicDmgPer = insideBasicDmgPer + (awaker:GetProperty(BP.i_basic_damage_per) or 0)
        insideDmgPer = insideDmgPer + (awaker:GetProperty(BP.i_damage_per) or 0)
        insideDmgPer1 = insideDmgPer1 + (awaker:GetProperty(BP.i_damage_per1) or 0)
        insideDmgPer2 = insideDmgPer2 + (awaker:GetProperty(BP.i_damage_per2) or 0)
        insideDmgPer3 = insideDmgPer3 + (awaker:GetProperty(BP.i_damage_per3) or 0)
        awakerNum = awakerNum + 1
      end
      if awakerNum > 0 then
        insideBasicDmgPer = insideBasicDmgPer / awakerNum
        insideDmgPer = insideDmgPer / awakerNum
        insideDmgPer1 = insideDmgPer1 / awakerNum
        insideDmgPer2 = insideDmgPer2 / awakerNum
        insideDmgPer3 = insideDmgPer3 / awakerNum
      end
      v = math.max(1, math.ceil((baseDamage * (1 + basic_damage_per / 100) * (1 + insideBasicDmgPer / 100) + curDmg) * (1 - weakPer / 100) * (1 + insideDmgPer / 100) * (1 + insideDmgPer1 / 100) * (1 + insideDmgPer2 / 100) * (1 + insideDmgPer3 / 100) * (1 + dimension_fix_per / 100) * (1 + tentacleDmgPer / 100)))
    end
    if bg.isPVP then
      local awakerList = bg.battleDataCenter:GetAwakerListByCamp(self.camp)
      for _, awaker in ipairs(awakerList) do
        v = v + (awaker:GetProperty(bc.BattleProperty.tentacle_dmg) or 0)
      end
    end
    if v <= 0 then
      v = 1
    end
    do return math.ceil end
    return math.ceil, v, ipairs(awakerList)
  end
  
  function views:GetBossTentacleDmg()
    local v = self:GetProperty(bc.BattleProperty.tentacle_dmg)
    if bg.isPVE then
      local insideDmgPer = self:GetProperty(bc.BattleProperty.i_damage_per) or 0
      local weakPer = self:GetProperty(bc.BattleProperty.weak_per) or 0
      local tentacleDmgPer = self:GetProperty(bc.BattleProperty.tentacle_dmg_per) or 0
      local insideDmgPer1 = self:GetProperty(bc.BattleProperty.i_damage_per1) or 0
      local insideDmgPer2 = self:GetProperty(bc.BattleProperty.i_damage_per2) or 0
      local insideDmgPer3 = self:GetProperty(bc.BattleProperty.i_damage_per3) or 0
      local player = bg.battleScene:GetPlayerRole()
      local targetVulnPer = player and player:GetProperty(bc.BattleProperty.vulnerable_per) or 0
      v = v * (1 - weakPer / 100) * (1 + targetVulnPer / 100) * (1 + insideDmgPer / 100) * (1 + insideDmgPer1 / 100) * (1 + insideDmgPer2 / 100) * (1 + insideDmgPer3 / 100) * (1 + tentacleDmgPer / 100)
    end
    if v <= 0 then
      v = 1
    end
    do return math.ceil end
    return math.ceil, v, 0, 0, 0, 0, bg.battleScene:GetPlayerRole(), 0, v * (1 - weakPer / 100) * (1 + targetVulnPer / 100) * (1 + insideDmgPer / 100) * (1 + insideDmgPer1 / 100) * (1 + insideDmgPer2 / 100) * (1 + insideDmgPer3 / 100), 1 + tentacleDmgPer / 100
  end
  
  function views:GetTentacleFixedCount()
    local battle = self:GetProperty(bc.BattleProperty.battle_tentacle_count) or 0
    local permanent = self:GetProperty(bc.BattleProperty.permanent_tentacle_count) or 0
    return battle + permanent
  end
  
  function views:GetTentacleBattleSlotLimit()
    local battle = self:GetProperty(bc.BattleProperty.battle_max_tentacle_count) or 0
    local permanent = self:GetProperty(bc.BattleProperty.permanent_max_tentacle_count) or 0
    local limit = battle + permanent
    if limit <= 0 then
      do return self.GetTentacleFixedCount end
      return self.GetTentacleFixedCount, self
    end
    return limit
  end
  
  function views:GetTentacleMaxCount()
    local bout = self:GetProperty(bc.BattleProperty.bout_max_tentacle_count) or 0
    local battle = self:GetProperty(bc.BattleProperty.battle_max_tentacle_count) or 0
    local permanent = self:GetProperty(bc.BattleProperty.permanent_max_tentacle_count) or 0
    return bout + battle + permanent
  end
  
  function views:GetAwaker(awakerTid)
    if not awakerTid then
      return nil
    end
    for _, awaker in ipairs(self.awakerDataList) do
      if awaker.tid == awakerTid then
        return awaker
      end
    end
  end
  
  function views:IsMonster()
    return self.roleType == bc.RoleType.Monster
  end
  
  function views:IsPVEPlayerCamp()
    return self.camp == bc.BattleCamp.Camp1
  end
  
  function views:IsSchool(schoolId)
    do return bg.battleDataCenter.IsSchool, bg.battleDataCenter end
    return bg.battleDataCenter.IsSchool, bg.battleDataCenter, schoolId
  end
  
  function views:GetSchoolConfigId()
    return self.schoolConfigId
  end
  
  function views:IsShowBloodDrop()
    return self:IsPVEPlayerCamp() and self:IsSchool(bc.SchoolCnID.BLOOD)
  end
  
  function views:GetUltiSkill()
    return self.ultiSkillId, self.ultiSkillLevel, self.ultiSkillArgs
  end
  
  function views:IsUltiEnergyEnough()
    local ultiEnergy = self:GetProperty(bc.BattleProperty.ulti_energy)
    local params = {
      ulti_energy_max = self:GetProperty(BP.ulti_energy_max) or 0,
      ulti_energy_cost_per = self:GetProperty("ulti_energy_cost_per") or 0,
      ulti_energy_cost_flat = self:GetProperty("ulti_energy_cost_flat") or 0,
      ulti_energy_max_per = self:GetProperty(BP.ulti_energy_max_per) or 0
    }
    local needEnergy = select(1, BattleSkillUtils.CalcSkillManiacMax(params))
    return ultiEnergy >= needEnergy
  end
  
  function views:IsUltiSkillSeal()
    local seal_ulti = self:GetProperty(bc.BattleProperty.seal_ulti) or 0
    local immue_seal_ulti = self:GetProperty(bc.BattleProperty.immue_seal_ulti) or 0
    if seal_ulti > 0 and immue_seal_ulti <= 0 then
      return true
    end
  end
  
  function views:GetMotion()
    return self.motion
  end
  
  function views:IsRoleType(roleType, orRoleType)
    return self.roleType == roleType or self.roleType == orRoleType
  end
  
  function views:GetThreat(beHitInfoList)
    local damageOrder = bg.battleDataCenter.damageOrder.value
    local hp = self:GetHp()
    local maxHp = self:GetMaxHp()
    local shield = self:GetBlock()
    if not damageOrder then
      return {
        maxHp = maxHp or 0,
        hp = hp or 0,
        shield = shield or 0,
        finHp = hp or 0,
        finShield = shield or 0
      }
    end
    local behitedDamage
    for _, beHitInfo in ipairs(beHitInfoList) do
      if beHitInfo.curHp == hp then
        behitedDamage = beHitInfo.realDamage
      end
    end
    local thrHp = 0
    local thrShield = 0
    local damageInfos = {}
    for dmgUid, dmgInfo in pairs(damageOrder or {}) do
      table.insert(damageInfos, {uid = dmgUid, info = dmgInfo})
    end
    table.sort(damageInfos, function(a, b)
      return a.uid < b.uid
    end)
    for _, damageData in pairs(damageInfos or {}) do
      local damageInfo = damageData.info
      local dmgValue = "table" == type(damageInfo) and (damageInfo[1] or 0) or damageInfo
      if behitedDamage and behitedDamage == dmgValue then
        behitedDamage = nil
      elseif "table" == type(damageInfo) and damageInfo[3] == DamageType.Puncture then
        thrShield = math.min(thrShield + dmgValue, shield)
        thrHp = thrHp + dmgValue
      elseif shield >= thrShield + dmgValue then
        thrShield = thrShield + dmgValue
      else
        thrHp = thrHp + (dmgValue + thrShield - shield)
        thrShield = shield
      end
    end
    return {
      maxHp = maxHp or 0,
      hp = hp or 0,
      shield = shield or 0,
      finHp = math.min(hp - thrHp, hp),
      finShield = math.min(shield - thrShield, shield)
    }
  end
  
  return views
end

local function createBattleRoleDataModelActions(data)
  local actions = {}
  local DT = bg.DT
  
  function actions:InitData(roleData)
    for k, v in pairs(roleData) do
      data[k] = v
    end
    self.awakerDataList = self.awakerDataList or {}
    self.curSkin = roleData.curSkin
    self.firstAwakerUid = self.awakerDataList[1] and self.awakerDataList[1].uid
    self.properties = self.properties or {}
    self:SetIntention(roleData.intention, roleData.damageInfo, roleData.descArgs)
    self.boutSkillTimes = roleData.boutSkillTimes or 0
    self.silverKeyAwakeTimes = roleData.silverKeyAwakeTimes or 0
    self.chaosType2SkillTimes = roleData.chaosType2SkillTimes or 0
    self.chaosType2Skill2Times = roleData.chaosType2Skill2Times or 0
    self.teamAveragyLevel = self:GetTeamAverageLevel()
    self.silverKeyAwakeDescArgs = roleData.silverKeyAwakeDescArgs
    if roleData.schoolSpecialArgs then
      self:UpdateSchoolSpecialArgs(roleData.schoolSpecialArgs)
    end
    local roleType = self.roleType
    local configData = DT.AwakerConfig[self.tid]
    if roleType == bc.RoleType.Monster then
      configData = DT.MonsterConfig[self.tid]
    end
    self.configData = configData
    self.motion = roleData.motion
    self.boutTentacleSwitched = roleData.boutTentacleSwitched
    self:UpdateHpNum(roleData.hpNum)
  end
  
  function actions:UpdateSchoolSpecialArgs(schoolSpecialArgs)
    for k, v in pairs(schoolSpecialArgs) do
      self.schoolSpecialArgs[k] = v
    end
  end
  
  function actions:UpdateSchoolSpecialArgs(schoolSpecialArgs)
    for k, v in pairs(schoolSpecialArgs) do
      self.schoolSpecialArgs[k] = v
    end
  end
  
  function actions:GetTentacleCountFromBuff(oriTentacleNum)
    local buffTentacleCount = oriTentacleNum
    if bg and bg.battleDataCenter and bg.battleDataCenter.stateData then
      local stateData = bg.battleDataCenter.stateData:GetRoleState(data.uid, 2626)
      if stateData and stateData.stateId and stateData.stateId == 2626 then
        buffTentacleCount = buffTentacleCount * 2
      end
      local stateData2 = bg.battleDataCenter.stateData:GetRoleState(data.uid, 22067)
      if stateData2 and stateData2.stateId and stateData2.stateId == 22067 then
        buffTentacleCount = buffTentacleCount + (stateData2.layer or 0)
      end
    end
    return buffTentacleCount
  end
  
  function actions:GetTentacleCount()
    local bout = self:GetProperty(bc.BattleProperty.bout_tentacle_count) or 0
    local battle = self:GetProperty(bc.BattleProperty.battle_tentacle_count) or 0
    local permanent = self:GetProperty(bc.BattleProperty.permanent_tentacle_count) or 0
    return bout + battle + permanent
  end
  
  function actions:GetTentacleAttackCount()
    local tentacleCount = self:GetTentacleCount()
    local buffTentacleCount = self:GetTentacleCountFromBuff(tentacleCount)
    return buffTentacleCount
  end
  
  function actions:SetMotionInfo(oldAnim, newAnim)
    self.motion = self.motion or {}
    self.motion[oldAnim] = newAnim
  end
  
  function actions:SetMotion(motion)
    self.motion = motion
  end
  
  function actions:ResetMotion()
    self.motion = {}
  end
  
  function actions:ClearIntention()
    self.intentionInfo = {}
  end
  
  function actions:SetKeeperSkill(keeperSkill)
    self.keeperSkill = keeperSkill
  end
  
  function actions:SetPlayerKeeperSkillArgs(skillArgs)
    self.keeperSkillArgs = skillArgs
  end
  
  function actions:SetIntention(intention, damageInfo, descArgs)
    if not intention then
      self.intentionInfo = {}
      return
    end
    local totalDamage = (damageInfo[1] or 0) * (damageInfo[2] or 1)
    self.intentionInfo = {
      totalDamage = totalDamage,
      intention = intention,
      damageStr = self:GetDamageStr(damageInfo),
      intentionIcon = self:GetIntentionIcon(intention),
      descArgs = descArgs
    }
    self.damageInfo = damageInfo
  end
  
  function actions:SetSilverKeyAwakeDescArgs(args)
    self.silverKeyAwakeDescArgs = args
  end
  
  function actions:SetSchoolArgs(schoolArgs)
    self.schoolArgs = schoolArgs
  end
  
  function actions:SetIntentionDescArgs(descArgs)
    self.descArgs = descArgs
  end
  
  function actions:SetMoney(money)
    self.money = money
  end
  
  function actions:SetSkillTimes(uid, times)
    if uid == self.uid then
      self.boutSkillTimes = times
    else
      local awakerData = bg.battleDataCenter:GetAwakerDataModel(uid)
      awakerData.boutSkillTimes = times
    end
  end
  
  function actions:SetSilverKeyAwakeTimes(uid, times)
    if uid == self.uid then
      self.silverKeyAwakeTimes = times
    else
      local awakerData = bg.battleDataCenter:GetAwakerDataModel(uid)
      awakerData.silverKeyAwakeTimes = times
    end
  end
  
  function actions:SetChaosType2SkillTimes(uid, times)
    if uid == self.uid then
      self.chaosType2SkillTimes = times
    else
      local awakerData = bg.battleDataCenter:GetAwakerDataModel(uid)
      awakerData.chaosType2SkillTimes = times
    end
  end
  
  function actions:SetChaosType2Skill2Times(uid, times)
    if uid == self.uid then
      self.chaosType2Skill2Times = times
    else
      local awakerData = bg.battleDataCenter:GetAwakerDataModel(uid)
      awakerData.chaosType2Skill2Times = times
    end
  end
  
  function actions:SetIsMultiHurt(isMultiHurt)
    self.isMultiHurt = isMultiHurt
  end
  
  function actions:SetIsMultiBlock(isMultiBlock)
    self.isMultiBlock = isMultiBlock
  end
  
  function actions:SetProperty(property, value)
    self.properties[property] = value
  end
  
  function actions:UpdateSkillArgs(args, descArgs)
    self.descArgs = descArgs
    self.skillArgs = args
  end
  
  function actions:SetAwaked(awaked)
    self.awaked = awaked
  end
  
  function actions:SetBoutTentacleSwitched(value)
    self.boutTentacleSwitched = value
  end
  
  function actions:UpdateHpNum(canRevivieNum)
    self.hpNum = canRevivieNum
    local cfgHpNum = self.configData and self.configData.MonsterHpNum or 1
    self.monsterLiftNum = math.max(self.monsterLiftNum or 1, cfgHpNum, canRevivieNum + 1)
  end
  
  function actions:SetShowName(showName)
    self.showName = showName
  end
  
  return actions
end

local function BindBlockToState(binder, model)
  binder:BindToRaw(function(_, newValue)
    if not model.uid then
      return
    end
    local blockStateId = bg.DT.Constant.PVPShieldValueDisplayState.Data[1]
    local stateUid = blockStateId * -1 + model.uid * -1
    local state = {
      stateId = blockStateId,
      stateUid = stateUid,
      ownerUid = model.uid,
      layer = newValue,
      newLayer = newValue
    }
    if not newValue or 0 == newValue then
      bg.battleDataCenter.stateData:RemoveState(state)
    else
      local haveState = bg.battleDataCenter.stateData:GetRoleState(model.uid, blockStateId)
      if not haveState then
        bg.battleDataCenter.stateData:AddState(state)
      else
        bg.battleDataCenter.stateData:ChangeState(state)
      end
    end
  end, function()
    do return model.GetBlock end
    return model.GetBlock, model
  end)
end

local function onSetup(binder, model)
  if bg.isPVP then
    BindBlockToState(binder, model)
  end
end

local BattleRoleDataModel = Vue.model("BattleRoleDataModel", createBattleRoleDataModelState):views(createBattleRoleDataModelViews):actions(createBattleRoleDataModelActions):setup(onSetup)
return BattleRoleDataModel
