local MonsterADHFormulaType = {
  ByLeaderLevel = 1,
  Maze = 2,
  N4AttackAndDefense = 3,
  N4HP = 4,
  N25MiniMaze = 5
}
_enum("MonsterADHFormulaType", MonsterADHFormulaType)
_class("MonsterConfigData", Object)
MonsterConfigData = MonsterConfigData

function MonsterConfigData:Constructor(world)
  self._world = world
  self._affixSvc = self._world:GetService("Affix")
end

function MonsterConfigData:GetMonsterObject(monsterID)
  if not Cfg.cfg_monster[monsterID] then
    Log.fatal("MonsterConfigData:GetMonsterObject monsterID:", monsterID)
  end
  return Cfg.cfg_monster[monsterID]
end

function MonsterConfigData:GetMonsterClass(monsterID)
  local monsterConfig = self:GetMonsterObject(monsterID)
  return self:GetMonsterClassByMonsterConfig(monsterConfig)
end

function MonsterConfigData:GetMonsterClassList()
  local listConfig = Cfg.cfg_monster_class()
  local listReturn = {}
  for key, value in pairs(listConfig) do
    table.insert(listReturn, key)
  end
  return listReturn
end

function MonsterConfigData:GetMonsterListByClassID(nClassID)
  local listConfig = Cfg.cfg_monster()
  local listReturn = {}
  for key, value in pairs(listConfig) do
    if nClassID == value.ClassID then
      table.insert(listReturn, value)
    end
  end
  return listReturn
end

function MonsterConfigData:GetMonsterListByGroupID(nGroupID)
  local listConfig = Cfg.cfg_monster()
  local listReturn = {}
  for key, value in pairs(listConfig) do
    if nGroupID == value.GroupID then
      table.insert(listReturn, value)
    end
  end
  return listReturn
end

function MonsterConfigData:GetMonsterClassByMonsterConfig(monsterConfig)
  if nil == monsterConfig then
    return nil
  end
  local monsterClassID = monsterConfig.ClassID
  if not Cfg.cfg_monster_class[monsterClassID] then
    Log.exception("MonsterConfigData:GetMonsterClassByMonsterConfig is nil monsterClassID:", monsterConfig.ClassID, " MonsterID:", monsterConfig.ID)
  end
  return Cfg.cfg_monster_class[monsterClassID]
end

function MonsterConfigData:GetCacheSkillIds(monsterID)
  local ret = {}
  local nAppearSkillID = self:GetAppearSkillID(monsterID)
  if nAppearSkillID and 0 < nAppearSkillID then
    table.insert(ret, nAppearSkillID)
  end
  local idss = self:GetMonsterSkillIDs(monsterID)
  for _, t in ipairs(idss) do
    table.appendArray(ret, t)
  end
  local nDieSkillID = self:GetMonsterDeathSkillID(monsterID)
  if monsterID and 0 < monsterID then
    table.insert(ret, nDieSkillID)
  end
  return ret
end

function MonsterConfigData:_GetMonsterProp(configData)
  local nData = 0
  if configData.formula then
    if 1 == configData.formula then
      local x = self._world.BW_WorldInfo:GetPlayerLevel()
      nData = x * x * configData.a + x * configData.b + configData.c
    elseif 2 == configData.formula then
      local mz = self._world:GetService("Maze")
      local x = mz:GetAvgPetLevel()
      local y, z = mz:GetMazeLayerFactor()
      nData = (x * configData.a + y * configData.b + configData.c) * z
    else
      local configService = self._world:GetService("Config")
      local y, z = configService:GetAffixHardParam(configData.formula)
      nData = (configData.b * y + configData.c) * z
    end
  else
    nData = configData[1]
  end
  return math.ceil(nData)
end

function MonsterConfigData:GetMonsterAttack(monsterID)
  local monsterConfig = self:GetMonsterObject(monsterID)
  return self:_GetMonsterProp(monsterConfig.Attack)
end

function MonsterConfigData:GetMonsterDefense(monsterID)
  local monsterConfig = self:GetMonsterObject(monsterID)
  return self:_GetMonsterProp(monsterConfig.Defense)
end

function MonsterConfigData:GetMonsterEvade(monsterID)
  local monsterConfig = self:GetMonsterObject(monsterID)
  return monsterConfig.Evade
end

function MonsterConfigData:GetMonsterHealth(monsterID)
  local monsterConfig = self:GetMonsterObject(monsterID)
  return self:_GetMonsterProp(monsterConfig.Health)
end

function MonsterConfigData:GetMonsterMultiHealth(monsterID)
  local monsterConfig = self:GetMonsterObject(monsterID)
  return monsterConfig.MultiHealth
end

function MonsterConfigData:GetMonsterElementType(monsterID)
  local monsterConfig = self:GetMonsterObject(monsterID)
  return monsterConfig.ElementType
end

function MonsterConfigData:GetAbsorbNormal(nMonsterID)
  local monsterConfig = self:GetMonsterObject(nMonsterID)
  return monsterConfig.AbsorbNormal or 1
end

function MonsterConfigData:GetAbsorbChain(nMonsterID)
  local monsterConfig = self:GetMonsterObject(nMonsterID)
  return monsterConfig.AbsorbChain or 1
end

function MonsterConfigData:GetAbsorbActive(nMonsterID)
  local monsterConfig = self:GetMonsterObject(nMonsterID)
  return monsterConfig.AbsorbActive or 1
end

function MonsterConfigData:GetEliteIDArray(nMonsterID)
  local monsterConfig = self:GetMonsterObject(nMonsterID)
  local tmpEliteID = {}
  if monsterConfig.EliteID then
    for i, buffID in ipairs(monsterConfig.EliteID) do
      table.insert(tmpEliteID, buffID)
    end
  end
  return tmpEliteID
end

function MonsterConfigData:GetEliteIDGroupArray(nMonsterID)
  local monsterConfig = self:GetMonsterObject(nMonsterID)
  local eliteIDGroup = table.cloneconf(monsterConfig.EliteIDGroup)
  return eliteIDGroup
end

function MonsterConfigData:GetEliteIDRandomParam(nMonsterID)
  local monsterConfig = self:GetMonsterObject(nMonsterID)
  local randomParam = table.cloneconf(monsterConfig.EliteIDRandom)
  return randomParam
end

function MonsterConfigData:GetMonsterClassID(monsterID)
  local monsterConfig = self:GetMonsterObject(monsterID)
  return monsterConfig.ClassID
end

function MonsterConfigData:GetMonsterSpeed(monsterID)
  local monsterConfig = self:GetMonsterClass(monsterID)
  return monsterConfig.MoveSpeed
end

function MonsterConfigData:GetMonsterStep(monsterID)
  local monsterConfig = self:GetMonsterClass(monsterID)
  return monsterConfig.Step
end

function MonsterConfigData:GetMonsterAIID(monsterID)
  local monsterConfig = self:GetMonsterClass(monsterID)
  return monsterConfig.AIID
end

function MonsterConfigData:GetMonsterPreMoveAIID(monsterID)
  local monsterConfig = self:GetMonsterClass(monsterID)
  return monsterConfig.PreMoveAIID
end

function MonsterConfigData:GetMonsterAntiAttackAIID(monsterID)
  local monsterConfig = self:GetMonsterClass(monsterID)
  return monsterConfig.AntiAttackAIID
end

function MonsterConfigData:GetMonsterAntiAttackParam(monsterID)
  local monsterConfig = self:GetMonsterClass(monsterID)
  return monsterConfig.AntiAttackParam
end

function MonsterConfigData:GetMonsterPreviewAIOrder(monsterID)
  local monsterConfig = self:GetMonsterClass(monsterID)
  return monsterConfig.PreviewAIOrder
end

function MonsterConfigData:GetMonsterPermanentEffectID(monsterID)
  local monsterConfig = self:GetMonsterClass(monsterID)
  local effectArray = monsterConfig.PermanentEffect
  return effectArray
end

function MonsterConfigData:GetMonsterIdleEffectID(monsterID)
  local monsterConfig = self:GetMonsterClass(monsterID)
  local effectArray = monsterConfig.IdleEffect
  return effectArray
end

function MonsterConfigData:GetMonsterSkillIDs(monsterID)
  local monsterObject = self:GetMonsterClass(monsterID)
  local affixService = self._world:GetService("Affix")
  return affixService:ChangeMonsterSkillID(monsterID, monsterObject.SkillID)
end

function MonsterConfigData:GetMonsterDropIDs(monsterID)
  local monsterObject = self:GetMonsterObject(monsterID)
  return monsterObject.DropArray
end

function MonsterConfigData:CanMove(monsterID)
  local monsterObject = self:GetMonsterClass(monsterID)
  return monsterObject.CanMove
end

function MonsterConfigData:CanTurn(monsterID)
  local monsterObject = self:GetMonsterClass(monsterID)
  return monsterObject.CanTurn
end

function MonsterConfigData:GetStoryTips(monsterID)
  local monsterObject = self:GetMonsterClass(monsterID)
  return monsterObject.StoryTips
end

function MonsterConfigData:GetDeathShowType(monsterID)
  local monsterObject = self:GetMonsterClass(monsterID)
  return monsterObject.DeathShowType
end

function MonsterConfigData:GetDeathShowEffectID(monsterID)
  local deathShowParam = self:GetMonsterClass(monsterID).DeathShowParam
  if deathShowParam ~= nil then
    return deathShowParam.deathEffectID
  end
end

function MonsterConfigData:GetDeathAudioID(monsterID)
  local deathShowParam = self:GetMonsterClass(monsterID).DeathAudioParam
  if deathShowParam ~= nil then
    return deathShowParam.deathAudioID
  end
end

function MonsterConfigData:DeathAudioSyncAnimation(monsterID)
  local deathShowParam = self:GetMonsterClass(monsterID).DeathAudioParam
  if deathShowParam ~= nil then
    return deathShowParam.syncAnimation
  end
end

function MonsterConfigData:GetSkillIDs(monsterID)
  local monsterObject = self:GetMonsterClass(monsterID)
  return monsterObject.SkillIDs or {}
end

function MonsterConfigData:GetAppearSkillID(monsterID)
  local skillIds = self:GetSkillIDs(monsterID)
  return self._affixSvc:ReplaceMonsterSpSkill(monsterID, skillIds.Appear, ReplaceMonsterSpSkillType.Appear)
end

function MonsterConfigData:GetDropSkillID(monsterID)
  local skillIds = self:GetSkillIDs(monsterID)
  return self._affixSvc:ReplaceMonsterSpSkill(monsterID, skillIds.Drop, ReplaceMonsterSpSkillType.Drop)
end

function MonsterConfigData:GetBackSkillID(monsterID)
  local skillIds = self:GetSkillIDs(monsterID)
  if skillIds then
    return skillIds.Back
  end
end

function MonsterConfigData:GetMonsterAITargetType(monsterID)
  local monsterConfig = self:GetMonsterObject(monsterID)
  if monsterConfig.AITargetType then
    return monsterConfig.AITargetType
  else
    local monsterClassConfig = self:GetMonsterClass(monsterID)
    return monsterClassConfig.AITargetType
  end
end

function MonsterConfigData:ExplainMonsterArea(areaStrArray)
  local areaPosArray = {}
  for index = 1, #areaStrArray do
    local posStr = areaStrArray[index]
    local numStr = string.split(posStr, ",")
    local vec2 = Vector2(tonumber(numStr[1]), tonumber(numStr[2]))
    areaPosArray[#areaPosArray + 1] = vec2
  end
  return areaPosArray
end

function MonsterConfigData:GetMonsterArea(monsterID)
  local monsterClass = self:GetMonsterClass(monsterID)
  if not monsterClass then
    Log.fatal("No Find Monster ID:", monsterID)
    local areaPosArray = {}
    return areaPosArray
  end
  return self:ExplainMonsterArea(monsterClass.Area)
end

function MonsterConfigData:GetMonsterType(monsterID)
  local monsterConfig = self:GetMonsterClass(monsterID)
  return monsterConfig.MonsterType
end

function MonsterConfigData:GetMonsterGroupID(monsterID)
  local monsterConfig = self:GetMonsterObject(monsterID)
  return monsterConfig.GroupID
end

function MonsterConfigData:GetMonsterResPath(monsterID)
  local monsterConfig = self:GetMonsterClass(monsterID)
  if not monsterConfig then
    Log.fatal("No Find Monster ID:", monsterID)
  end
  return monsterConfig.ResPath
end

function MonsterConfigData:GetMonsterCardResPath(monsterID)
  local monsterConfig = self:GetMonsterClass(monsterID)
  return monsterConfig.CardResPath
end

function MonsterConfigData:GetMonsterOffset(monsterID)
  local monsterConfig = self:GetMonsterClass(monsterID)
  local offsetStr = monsterConfig.PositionOffset
  local strArray = string.split(offsetStr, ",")
  local offset = Vector2(tonumber(strArray[1]), tonumber(strArray[2]))
  return offset
end

function MonsterConfigData:GetMonsterDamageOffset(monsterID)
  local monsterConfig = self:GetMonsterClass(monsterID)
  local offsetStr = monsterConfig.DamageOffset
  local strArray = string.split(offsetStr, ",")
  local offset = Vector2(strArray[1], strArray[2])
  return offset
end

function MonsterConfigData:GetMonsterHPHeightOffset(monsterID)
  local monsterConfig = self:GetMonsterClass(monsterID)
  return monsterConfig.HeightOffset
end

function MonsterConfigData:IsBoss(monsterID)
  local monsterConfig = self:GetMonsterClass(monsterID)
  local monsterType = monsterConfig.MonsterType
  if monsterType == MonsterType.Boss or monsterType == MonsterType.WorldBoss then
    return true
  end
  return false
end

function MonsterConfigData:IsWorldBoss(monsterID)
  local monsterConfig = self:GetMonsterClass(monsterID)
  local monsterType = monsterConfig.MonsterType
  if monsterType == MonsterType.WorldBoss then
    return true
  end
  return false
end

function MonsterConfigData:GetMonsterName(monsterID)
  local monsterClass = self:GetMonsterClass(monsterID)
  if not monsterClass then
    Log.fatal("### [boss warning]", monsterID, "not in cfg_monster.")
  end
  return monsterClass.Name
end

function MonsterConfigData:GetStoryTipsOffset(monsterID)
  local monsterClass = self:GetMonsterClass(monsterID)
  return monsterClass.TipsOffset
end

function MonsterConfigData:GetMonsterOffSetWithBindPos(monsterID)
  local configData = self:GetMonsterClass(monsterID)
  if nil == configData then
    return
  end
  return configData.AreaWithHitBindPos
end

function MonsterConfigData:GetMonsterBindPos(monsterID, monsterGridPos, gridPos, bodyArea)
  local OffsetWithBindPos = self:GetMonsterOffSetWithBindPos(monsterID)
  if OffsetWithBindPos then
    local deltaPos
    for _, v in pairs(bodyArea) do
      local bodyGridPos = Vector2(v.x + monsterGridPos.x, v.y + monsterGridPos.y)
      if bodyGridPos == gridPos then
        deltaPos = v
        break
      end
    end
    if deltaPos then
      for k, v in pairs(OffsetWithBindPos) do
        if k[1] == deltaPos.x and k[2] == deltaPos.y then
          return v
        end
      end
    end
    Log.fatal("Get OffsetWithBindPos Failed MonsterID:", monsterID, "GridPos:", gridPos, "MonsterGridPos:", monsterGridPos)
    return nil
  else
    Log.fatal("Get OffsetWithBindPos Failed MonsterID:", monsterID)
    return nil
  end
end

function MonsterConfigData:GetMonsterBornType(monsterID)
  local configData = self:GetMonsterClass(monsterID)
  return configData.BornType
end

function MonsterConfigData:GetMonsterHPSep(monsterID)
  local config = self:GetMonsterClass(monsterID)
  if config then
    return config.HealthSep
  end
  return nil
end

local MonsterRaceType = {Land = 1, Fly = 2}
_enum("MonsterRaceType", MonsterRaceType)

function MonsterConfigData:GetMonsterRaceType(monsterID)
  local monsterConfig = self:GetMonsterClass(monsterID)
  if monsterConfig == nil then
    Log.error("monsterID error ", monsterID)
  end
  if monsterConfig.RaceType then
    return monsterConfig.RaceType
  else
    return nil
  end
end

function MonsterConfigData:GetMonsterDeathSkillID(monsterID)
  local skills = self:GetSkillIDs(monsterID)
  return self._affixSvc:ReplaceMonsterSpSkill(monsterID, skills.Die, ReplaceMonsterSpSkillType.Die)
end

function MonsterConfigData:IsRegularShape(monsterID)
  local monsterConfig = self:GetMonsterClass(monsterID)
  if monsterConfig then
    return not monsterConfig.IsIrregular
  else
    Log.fatal("[MonsterConfig] monster not found: ", monsterID)
  end
end

function MonsterConfigData:GetBornBuffList(monsterID)
  local buffList = {}
  local monsterConfig = self:GetMonsterClass(monsterID)
  if not monsterConfig then
    Log.fatal("[MonsterConfig] monster class not found: ", monsterID)
  elseif monsterConfig.BornBuffs then
    table.appendArray(buffList, monsterConfig.BornBuffs)
  end
  local objectConfig = self:GetMonsterObject(monsterID)
  local tmpBuffList = {}
  if objectConfig.BuffList then
    for i, buffID in ipairs(objectConfig.BuffList) do
      table.insert(tmpBuffList, buffID)
    end
  end
  local objectBuffList = self._affixSvc:ReplaceMonsterBuff(monsterID, tmpBuffList)
  objectBuffList = self._affixSvc:AddMonsterBuff(monsterID, objectBuffList)
  if not objectConfig then
    Log.fatal("[MonsterConfig] monster object not found: ", monsterID)
  elseif objectBuffList then
    table.appendArray(buffList, objectBuffList)
  end
  return buffList
end

function MonsterConfigData:GetMonsterShaderEffect(monsterID)
  local configData = self:GetMonsterClass(monsterID)
  return configData.ShaderEffect
end

function MonsterConfigData:Block(monsterID)
  local configData = self:GetMonsterClass(monsterID)
  return configData.Block or 1
end

function MonsterConfigData:GetHybridSkillPreviewMode(monsterID)
  local configData = self:GetMonsterClass(monsterID)
  return configData.HybridSkillPreviewMode or 0, configData.HybridSkillPreviewParam
end

function MonsterConfigData:GetWorldBossConfig(monsterID)
  local cfg = Cfg.cfg_world_boss_hp[monsterID]
  if not cfg then
    Log.fatal("cfg_world_boss_hp no ID:", monsterID)
  end
  return cfg.Stage, cfg.HPImage
end

function MonsterConfigData:IsEliteMonster(monsterID)
  return #self:GetEliteIDArray(monsterID) > 0
end

function MonsterConfigData:IsDisableEliteEffect(monsterID)
  local configData = self:GetMonsterClass(monsterID)
  if configData.ExtraParams then
    return configData.ExtraParams.DisableEliteEffect
  end
  return false
end

function MonsterConfigData:IsHasPassiveSkillInfo(monsterID)
  local infos = self:GetMonsterPassiveInfo(monsterID)
  if not infos or #infos == 0 then
    return false
  end
  return true
end

function MonsterConfigData:GetMonsterPassiveInfo(monsterID)
  local configData = self:GetMonsterClass(monsterID)
  if configData then
    return configData.PassiveSkillInfos
  else
    return nil
  end
end

function MonsterConfigData:GetMonsterHUDHPWidthScale(monsterID)
  local objConfigData = self:GetMonsterObject(monsterID)
  if objConfigData.HPSliderWidthScale then
    return objConfigData.HPSliderWidthScale
  end
  local classConfigData = self:GetMonsterClass(monsterID)
  if classConfigData.HPSliderWidthScale then
    return classConfigData.HPSliderWidthScale
  end
  return 1
end

local MonsterPassiveInfoType = {Base = 1, AntiSkill = 2}
_enum("MonsterPassiveInfoType", MonsterPassiveInfoType)

function MonsterConfigData:GetMonsterSnakeBodyEffectID(monsterID)
  local configData = self:GetMonsterClass(monsterID)
  if configData then
    return configData.SnakeBodyEffect
  else
    return nil
  end
end

function MonsterConfigData:GetMonsterDamageSyncMonsterID(monsterID)
  local objConfigData = self:GetMonsterObject(monsterID)
  if objConfigData.DamageSyncMonsterID then
    return objConfigData.DamageSyncMonsterID, MonsterSyncFindType.MonsterID
  end
  local configData = self:GetMonsterClass(monsterID)
  if configData then
    return configData.DamageSyncMonsterID, MonsterSyncFindType.MonsterClassID
  else
    return nil
  end
end

function MonsterConfigData:GetMonsterDamageSyncEffect(monsterID)
  local objConfigData = self:GetMonsterObject(monsterID)
  if objConfigData.DamageSyncMonsterID then
    return objConfigData.DamageSyncEffect
  end
  local configData = self:GetMonsterClass(monsterID)
  if configData then
    return configData.DamageSyncEffect
  else
    return nil
  end
end

function MonsterConfigData:GetMonsterHUDHPBarType(monsterID)
  local objectConfig = self:GetMonsterObject(monsterID)
  if objectConfig.HPSliderColor then
    return objectConfig.HPSliderColor
  end
  local monsterConfig = self:GetMonsterClass(monsterID)
  return monsterConfig.HPSliderColor or MonsterHUDHPBarType.Red
end

local BossUIHPType = {Normal = 0, Gold = 1}
_enum("BossUIHPType", BossUIHPType)

function MonsterConfigData:GetBossUIHPType(monsterID)
  local objectConfig = self:GetMonsterObject(monsterID)
  return objectConfig.UIBossHPType
end

local MonsterCampType = {
  AnGui = 1,
  BaiYeCheng = 2,
  QiGuang = 3,
  YingZhen = 4
}
_enum("MonsterCampType", MonsterCampType)

function MonsterConfigData:GetMonsterCampType(monsterID)
  local monsterConfig = self:GetMonsterClass(monsterID)
  return monsterConfig.CampType or MonsterCampType.AnGui
end

function MonsterConfigData:GetMonsterAuraRangeData(monsterID)
  local objectConfig = self:GetMonsterObject(monsterID)
  return objectConfig.Aura
end
