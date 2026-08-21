_class("ChessPetConfigData", Object)
ChessPetConfigData = ChessPetConfigData

function ChessPetConfigData:Constructor(world)
  self._world = world
  self._affixSvc = self._world:GetService("Affix")
end

function ChessPetConfigData:GetChessPetObject(chessPetID)
  return Cfg.cfg_chesspet[chessPetID]
end

function ChessPetConfigData:GetChessPetClass(chessPetID)
  local chessPetConfig = self:GetChessPetObject(chessPetID)
  return self:GetChessPetClassByChessPetConfig(chessPetConfig)
end

function ChessPetConfigData:GetChessPetClassList()
  local listConfig = Cfg.cfg_chesspet_class()
  local listReturn = {}
  for key, value in pairs(listConfig) do
    table.insert(listReturn, key)
  end
  return listReturn
end

function ChessPetConfigData:GetChessPetClassByChessPetConfig(chessPetConfig)
  if nil == chessPetConfig then
    return nil
  end
  local chessPetClassID = chessPetConfig.ClassID
  return Cfg.cfg_chesspet_class[chessPetClassID]
end

function ChessPetConfigData:GetChessPetCacheSkillIds(chessPetID)
  local ret = {}
  return ret
end

function ChessPetConfigData:_GetChessPetProp(configData)
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
    elseif 3 == configData.formula then
      local configService = self._world:GetService("Config")
      local y, z = configService:GetAffixHardParam(configData.formula)
      nData = (configData.b * y + configData.c) * z
    elseif 4 == configData.formula then
      local configService = self._world:GetService("Config")
      local y, z = configService:GetAffixHardParam(configData.formula)
      nData = (configData.b * y + configData.c) * z
    end
  else
    nData = configData[1]
  end
  return math.ceil(nData)
end

function ChessPetConfigData:GetChessPetAttack(chessPetID)
  local chessPetConfig = self:GetChessPetObject(chessPetID)
  return self:_GetChessPetProp(chessPetConfig.Attack)
end

function ChessPetConfigData:GetChessPetDefense(chessPetID)
  local chessPetConfig = self:GetChessPetObject(chessPetID)
  return self:_GetChessPetProp(chessPetConfig.Defense)
end

function ChessPetConfigData:GetChessPetEvade(chessPetID)
  local chessPetConfig = self:GetChessPetObject(chessPetID)
  return chessPetConfig.Evade
end

function ChessPetConfigData:GetChessPetHealth(chessPetID)
  local chessPetConfig = self:GetChessPetObject(chessPetID)
  return self:_GetChessPetProp(chessPetConfig.Health)
end

function ChessPetConfigData:GetChessPetElementType(chessPetID)
  local chessPetConfig = self:GetChessPetObject(chessPetID)
  return chessPetConfig.ElementType
end

function ChessPetConfigData:GetAbsorbNormal(chessPetID)
  local chessPetConfig = self:GetChessPetObject(chessPetID)
  return chessPetConfig.AbsorbNormal or 1
end

function ChessPetConfigData:GetAbsorbChain(chessPetID)
  local chessPetConfig = self:GetChessPetObject(chessPetID)
  return chessPetConfig.AbsorbChain or 1
end

function ChessPetConfigData:GetAbsorbActive(chessPetID)
  local chessPetConfig = self:GetChessPetObject(chessPetID)
  return chessPetConfig.AbsorbActive or 1
end

function ChessPetConfigData:GetChessPetEliteIDArray(chessPetID)
  local chessPetConfig = self:GetChessPetObject(chessPetID)
  local tmpEliteID = {}
  if chessPetConfig.EliteID then
    for i, buffID in ipairs(chessPetConfig.EliteID) do
      table.insert(tmpEliteID, buffID)
    end
  end
  local retEliteID = self._affixSvc:ReplaceChessPetEliteBuff(chessPetID, tmpEliteID)
  retEliteID = self._affixSvc:AddChessPetEliteBuff(chessPetID, retEliteID)
  return retEliteID or {}
end

function ChessPetConfigData:GetChessPetClassID(chessPetID)
  local chessPetConfig = self:GetChessPetObject(chessPetID)
  return chessPetConfig.ClassID
end

function ChessPetConfigData:GetChessPetPermanentEffectID(chessPetID)
  local chessPetConfig = self:GetChessPetClass(chessPetID)
  local effectArray = chessPetConfig.PermanentEffect
  return effectArray
end

function ChessPetConfigData:GetChessPetIdleEffectID(chessPetID)
  local chessPetConfig = self:GetChessPetClass(chessPetID)
  local effectArray = chessPetConfig.IdleEffect
  return effectArray
end

function ChessPetConfigData:GetChessPetSkillIDs(chessPetID)
  local monsterObject = self:GetChessPetClass(chessPetID)
  local affixService = self._world:GetService("Affix")
  return affixService:ChangeMonsterSkillID(monsterID, monsterObject.SkillID)
end

function ChessPetConfigData:GetChessPetDropIDs(chessPetID)
  local monsterObject = self:GetChessPetObject(chessPetID)
  return monsterObject.DropArray
end

function ChessPetConfigData:CanMove(chessPetID)
  local monsterObject = self:GetChessPetClass(chessPetID)
  return monsterObject.CanMove
end

function ChessPetConfigData:CanTurn(chessPetID)
  local monsterObject = self:GetChessPetClass(chessPetID)
  return monsterObject.CanTurn
end

function ChessPetConfigData:GetStoryTips(chessPetID)
  local monsterObject = self:GetChessPetClass(chessPetID)
  return monsterObject.StoryTips
end

function ChessPetConfigData:GetDeathShowType(chessPetID)
  local monsterObject = self:GetChessPetClass(chessPetID)
  return monsterObject.DeathShowType
end

function ChessPetConfigData:GetDeathShowEffectID(chessPetID)
  local deathShowParam = self:GetChessPetClass(chessPetID).DeathShowParam
  if deathShowParam ~= nil then
    return deathShowParam.deathEffectID
  end
end

function ChessPetConfigData:GetDeathAudioID(chessPetID)
  local deathShowParam = self:GetChessPetClass(chessPetID).DeathAudioParam
  if deathShowParam ~= nil then
    return deathShowParam.deathAudioID
  end
end

function ChessPetConfigData:DeathAudioSyncAnimation(chessPetID)
  local deathShowParam = self:GetChessPetClass(chessPetID).DeathAudioParam
  if deathShowParam ~= nil then
    return deathShowParam.syncAnimation
  end
end

function ChessPetConfigData:GetSkillIDs(chessPetID)
  local monsterObject = self:GetChessPetClass(chessPetID)
  return monsterObject.SkillIDs or {}
end

function ChessPetConfigData:GetChessPetAITargetType(chessPetID)
  local chessPetConfig = self:GetChessPetClass(chessPetID)
  return chessPetConfig.AITargetType
end

function ChessPetConfigData:ParseChessPetArea(areaStrArray)
  local areaPosArray = {}
  for index = 1, #areaStrArray do
    local posStr = areaStrArray[index]
    local numStr = string.split(posStr, ",")
    local vec2 = Vector2(tonumber(numStr[1]), tonumber(numStr[2]))
    areaPosArray[#areaPosArray + 1] = vec2
  end
  return areaPosArray
end

function ChessPetConfigData:GetChessPetArea(chessPetID)
  local chessPetClass = self:GetChessPetClass(chessPetID)
  if not chessPetClass then
    Log.fatal("No Find Monster ID:", chessPetID)
    local areaPosArray = {}
    return areaPosArray
  end
  return self:ParseChessPetArea(chessPetClass.Area)
end

function ChessPetConfigData:GetChessPetResPath(chessPetID)
  local chessPetConfig = self:GetChessPetClass(chessPetID)
  return chessPetConfig.ResPath
end

function ChessPetConfigData:GetChessPetCardResPath(chessPetID)
  local chessPetConfig = self:GetChessPetClass(chessPetID)
  return chessPetConfig.CardResPath
end

function ChessPetConfigData:GetChessPetWalkStep(chessPetID)
  local chessPetConfig = self:GetChessPetClass(chessPetID)
  return chessPetConfig.Step
end

function ChessPetConfigData:GetChessPetMoveSpeed(chessPetID)
  local chessPetConfig = self:GetChessPetClass(chessPetID)
  return chessPetConfig.MoveSpeed
end

function ChessPetConfigData:GetChessPetOffset(chessPetID)
  local chessPetConfig = self:GetChessPetClass(chessPetID)
  local offsetStr = chessPetConfig.PositionOffset
  local strArray = string.split(offsetStr, ",")
  local offset = Vector2(tonumber(strArray[1]), tonumber(strArray[2]))
  return offset
end

function ChessPetConfigData:GetChessPetDamageOffset(chessPetID)
  local chessPetConfig = self:GetChessPetClass(chessPetID)
  local offsetStr = chessPetConfig.DamageOffset
  local strArray = string.split(offsetStr, ",")
  local offset = Vector2(tonumber(strArray[1]), tonumber(strArray[2]))
  return offset
end

function ChessPetConfigData:GetChessPetHPHeightOffset(chessPetID)
  local chessPetConfig = self:GetChessPetClass(chessPetID)
  return chessPetConfig.HeightOffset
end

function ChessPetConfigData:GetChessPetName(chessPetID)
  local chessPetClass = self:GetChessPetClass(chessPetID)
  if not chessPetClass then
    Log.fatal("### [boss warning]", chessPetID, "not in cfg_monster.")
  end
  return chessPetClass.Name
end

local ChessPetRaceType = {Land = 1, Fly = 2}
_enum("ChessPetRaceType", ChessPetRaceType)

function ChessPetConfigData:GetChessPetRaceType(chessPetID)
  local chessPetConfig = self:GetChessPetClass(chessPetID)
  if chessPetConfig == nil then
    Log.error("monsterID error ", chessPetID)
  end
  if chessPetConfig.RaceType then
    return chessPetConfig.RaceType
  else
    return nil
  end
end

function ChessPetConfigData:GetChessPetDeathSkillID(chessPetID)
  local skills = self:GetSkillIDs(chessPetID)
  return self._affixSvc:ReplaceMonsterSpSkill(chessPetID, skills.Die, ReplaceMonsterSpSkillType.Die)
end

function ChessPetConfigData:GetBornBuffList(chessPetID)
  local buffList = {}
  local chessPetConfig = self:GetChessPetClass(chessPetID)
  if not chessPetConfig then
    Log.fatal("[ChessPetConfig] chess pet class not found: ", chessPetID)
  elseif chessPetConfig.BornBuffs then
    table.appendArray(buffList, chessPetConfig.BornBuffs)
  end
  local objectConfig = self:GetChessPetObject(chessPetID)
  local tmpBuffList = {}
  if objectConfig.BuffList then
    for i, buffID in ipairs(objectConfig.BuffList) do
      table.insert(buffList, buffID)
    end
  end
  return buffList
end

function ChessPetConfigData:GetChessPetShaderEffect(chessPetID)
  local configData = self:GetChessPetClass(chessPetID)
  return configData.ShaderEffect
end

function ChessPetConfigData:Block(chessPetID)
  local configData = self:GetChessPetClass(chessPetID)
  return configData.Block or 1
end

function ChessPetConfigData:GetHybridSkillPreviewMode(chessPetID)
  local configData = self:GetChessPetClass(chessPetID)
  return configData.HybridSkillPreviewMode or 0, configData.HybridSkillPreviewParam
end

function ChessPetConfigData:IsEliteMonster(chessPetID)
  return #self:GetChessPetEliteIDArray(chessPetID) > 0
end

function ChessPetConfigData:GetTipsOffset(chessPetID)
  local configData = self:GetChessPetClass(chessPetID)
  return configData.TipsOffset or 0
end
