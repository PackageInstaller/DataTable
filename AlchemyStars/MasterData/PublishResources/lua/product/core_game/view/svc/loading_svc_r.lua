_class("LoadingServiceRender", BaseService)
LoadingServiceRender = LoadingServiceRender

function LoadingServiceRender:Constructor(world)
  self._world = world
  self._configService = self._world:GetService("Config")
  self._LoadProcessValue = 0
  self._cachedSoundMonsterIdList = {}
  self._cachedSoundTrapIdList = {}
  self._cachedVoiceMonsterIdList = {}
  self._cachedMonsterIdList = {}
  self._cachedTrapIdList = {}
  self._cachedBuffIdList = {}
  self._cachedSkillIdList = {}
  self._loadAfterLoading = {}
  self._loadingTimeTable = {}
  self._afterLoadingTime = {}
  self._transformMonsterIDDic = {
    [2900141] = 2900142,
    [2900181] = 2900182
  }
  self._brillantGridMaterial = "brillant_gezi_main.mat"
end

function LoadingServiceRender:MockLoading(TT)
  if LocalDB.GetInt(GameGlobal.GetHighFrameKey(), 0) == 1 then
    BattleConst.RealFrameTime = 0.016666666666666666
  end
  local collector = GameGlobal:GetInstance():GetCollector("CoreGameLoading")
  local loadBegin = os.clock()
  Log.prof("[loading] start load")
  local levelConfigData = self._configService:GetLevelConfigData()
  local levelResPath = levelConfigData:GetLevelResPath()
  local tik = os.clock()
  local battleSvcR = self._world:GetService("RenderBattle")
  battleSvcR:DefaultEnvColor()
  GameGlobal:GetInstance().gameLogic:LoadScene(TT, levelResPath)
  YIELD(TT)
  local newBake = UnityEngine.GameObject.Find("NewBake")
  if newBake then
    UnityEngine.Shader.EnableKeyword("H3D_SPE_BAKE_NEW")
  else
    UnityEngine.Shader.DisableKeyword("H3D_SPE_BAKE_NEW")
  end
  self:_UpdateLoadingProcess(30)
  YIELD(TT)
  local tok = os.clock()
  table.insert(self._loadingTimeTable, {
    name = "LoadScene",
    time = (tok - tik) * 1000
  })
  self:_CacheGlobalAssetFile()
  self:_CacheGridMaterial()
  self:_CacheObject(TT, 60)
  YIELD(TT)
  tik = tok
  tok = os.clock()
  table.insert(self._loadingTimeTable, {
    name = "CacheObject",
    time = (tok - tik) * 1000
  })
  self:_LoadingSystemCacheAudio(TT)
  tik = tok
  tok = os.clock()
  table.insert(self._loadingTimeTable, {
    name = "CacheAudio",
    time = (tok - tik) * 1000
  })
  self:_SetUpSceneCamera()
  tik = tok
  tok = os.clock()
  table.insert(self._loadingTimeTable, {
    name = "_SetUpSceneCamera",
    time = (tok - tik) * 1000
  })
  YIELD(TT)
  self:_CacheAllEntity(TT)
  tik = tok
  tok = os.clock()
  table.insert(self._loadingTimeTable, {
    name = "_CacheAllEntity",
    time = (tok - tik) * 1000
  })
  YIELD(TT)
  self:_UpdateLoadingProcess(90)
  self:_InitializeLoadingEntity(TT)
  YIELD(TT)
  self:_UpdateLoadingProcess(100)
  local allTime = os.clock() - loadBegin
  Log.prof("[loading] end load use time=", allTime * 1000)
  for i, v in ipairs(self._loadingTimeTable) do
    Log.prof("[loading] process,", v.name, ",time,", v.time)
  end
  collector:Sample("LoadingServiceRender:MockLoading()")
  GameGlobal.LoadingManager():CoreGameLoadingFinish()
  if EDITOR then
    self._world:GetAIDebugModule():StartCoreGame()
  end
end

function LoadingServiceRender:LoadAfterLoading(TT)
  local respool = self._world.BW_Services.ResourcesPool
  local tik = os.clock()
  local restable = self._loadAfterLoading
  for k, v in pairs(restable) do
    local resname = v[1]
    local count = v[2]
    if string.endwith(resname, ".mat") then
      respool:CacheMaterial(resname, count)
    else
      respool:Cache(resname, count)
    end
    YIELD(TT)
  end
  local tok = os.clock()
  Log.prof("[loading] load after loading finished, use time=", (tok - tik) * 1000)
end

function LoadingServiceRender:_UpdateLoadingProcess(value)
  self._LoadProcessValue = value
  GameGlobal.EventDispatcher():Dispatch(GameEventType.LoadingProgressChanged, value)
end

function LoadingServiceRender:_CacheObject(TT, maxProcess)
  local respool = self._world.BW_Services.ResourcesPool
  local cachetable = self:_GetCacheTable()
  local count = table.count(cachetable)
  local oneProcess = (maxProcess - self._LoadProcessValue) / count
  for keystr, t in pairs(cachetable) do
    local tik = os.clock()
    local restable = t
    for k, v in pairs(restable) do
      local resname = v[1]
      local count = v[2]
      if string.endwith(resname, ".mat") then
        respool:CacheMaterial(resname, count)
      else
        respool:Cache(resname, count)
      end
    end
    self:_UpdateLoadingProcess(self._LoadProcessValue + oneProcess)
    YIELD(TT)
    local tok = os.clock()
    table.insert(self._loadingTimeTable, {
      name = "CacheObject/" .. keystr,
      time = (tok - tik) * 1000
    })
  end
  self:_UpdateLoadingProcess(maxProcess)
end

function LoadingServiceRender:_SetUpSceneCamera()
  local cameraService = self._world:GetService("Camera")
  cameraService:InitializeSceneCamera()
end

function LoadingServiceRender:_CacheAllEntity(TT)
  local tik = os.clock()
  local entityPoolService = self._world:GetService("EntityPool")
  entityPoolService:CacheEntities()
  YIELD(TT)
  entityPoolService:HideCacheEntities()
  YIELD(TT)
  local tok = os.clock()
  table.insert(self._loadingTimeTable, {
    name = "_CacheAllEntity/CacheEntities",
    time = (tok - tik) * 1000
  })
  self:_PreCreatePreviewEntity()
  self:_PreCreateBoard()
  YIELD(TT)
  tik = tok
  tok = os.clock()
  table.insert(self._loadingTimeTable, {
    name = "_CacheAllEntity/_PreCreateBoard",
    time = (tok - tik) * 1000
  })
  self:_PreWarmAnim()
  YIELD(TT)
  self:_PrePlayAnim()
  YIELD(TT)
  tik = tok
  tok = os.clock()
  table.insert(self._loadingTimeTable, {
    name = "_CacheAllEntity/_PreWarmAnim_PrePlayAnim",
    time = (tok - tik) * 1000
  })
  self:_PreCreateTeam()
  YIELD(TT)
  tik = tok
  tok = os.clock()
  table.insert(self._loadingTimeTable, {
    name = "_CacheAllEntity/_PreCreateTeam",
    time = (tok - tik) * 1000
  })
  self:_PreCreateFirstWaveMonsterAndTrap(TT)
  YIELD(TT)
  tik = tok
  tok = os.clock()
  table.insert(self._loadingTimeTable, {
    name = "_CacheAllEntity/_PreCreateFirstWave",
    time = (tok - tik) * 1000
  })
  self:_MoveUpAllGrid()
  YIELD(TT)
  tik = tok
  tok = os.clock()
  table.insert(self._loadingTimeTable, {
    name = "_CacheAllEntity/_MoveUpAllGrid",
    time = (tok - tik) * 1000
  })
  ResourceManager:GetInstance():WarmUpCoreGameShader()
  tik = tok
  tok = os.clock()
  table.insert(self._loadingTimeTable, {
    name = "_CacheAllEntity/WarmUpCoreGameShader",
    time = (tok - tik) * 1000
  })
end

function LoadingServiceRender:_PreCreatePreviewEntity()
  local entityService = self._world:GetService("RenderEntity")
  local ePreview = entityService:CreateRenderEntity(EntityConfigIDRender.Preview)
  self._world:SetPreviewEntity(ePreview)
  return ePreview
end

function LoadingServiceRender:_PreCreateBoard()
  local boardServiceRender = self._world:GetService("BoardRender")
  boardServiceRender:InitBaseGridRenderPos()
  local spawnPieceServiceRender = self._world:GetService("SpawnPieceRender")
  spawnPieceServiceRender:InitializeCellRender()
  local renderEntityService = self._world:GetService("RenderEntity")
  renderEntityService:CreateBoardGridEntity()
  local configService = self._world:GetService("Config")
  local levelConfigData = configService:GetLevelConfigData()
  local isMultiBoardLevel = levelConfigData:IsMultiBoardLevel()
  if isMultiBoardLevel then
    renderEntityService:CreateBoardMultiGridEntity()
  end
  renderEntityService:CreateBoardSpliceGridEntity()
  renderEntityService:CreateBoardPushGridEntity()
end

function LoadingServiceRender:_PreWarmAnim(cacheGridList)
  local pieceService = self._world:GetService("Piece")
  local pieceGroup = self._world:GetGroup(self._world.BW_WEMatchers.Piece)
  for _, e in ipairs(pieceGroup:GetEntities()) do
    local pieceEntity = e
    local viewCmpt = pieceEntity:View()
    local gameObj = viewCmpt:GetGameObject()
    gameObj:SetActive(true)
  end
end

function LoadingServiceRender:_MoveUpAllGrid()
  local configService = self._world:GetService("Config")
  local levelConfigData = configService:GetLevelConfigData()
  local isMultiBoardLevel = levelConfigData:IsMultiBoardLevel()
  local isSpliceBoardLevel = levelConfigData:IsSpliceBoardLevel()
  local isPushBoardLevel = levelConfigData:IsPushBoardLevel()
  if isMultiBoardLevel or isSpliceBoardLevel or isPushBoardLevel then
    return
  end
  local pieceService = self._world:GetService("Piece")
  local pieceGroup = self._world:GetGroup(self._world.BW_WEMatchers.Piece)
  for _, e in ipairs(pieceGroup:GetEntities()) do
    local pieceEntity = e
    local viewCmpt = pieceEntity:View()
    local gameObj = viewCmpt:GetGameObject()
    local curPos = gameObj.transform.position
    gameObj.transform.position = Vector3(curPos.x, BattleConst.CacheHeight, curPos.z)
  end
end

function LoadingServiceRender:_PrePlayAnim()
  local pieceService = self._world:GetService("Piece")
  local pieceGroup = self._world:GetGroup(self._world.BW_WEMatchers.Piece)
  for _, e in ipairs(pieceGroup:GetEntities()) do
    pieceService:SetPieceEntityAnimNormal(e)
  end
end

function LoadingServiceRender:_GetSceneCacheTable()
  local sceneRes = Cfg.cfg_regular_resource({})
  local t = {}
  for i, v in ipairs(sceneRes) do
    if v.LoadType == "GameObject" and v.Tag == "scene" then
      t[#t + 1] = {
        v.ResName,
        v.CacheCount
      }
    end
  end
  self:_CacheCurrentGrid(t)
  return t
end

function LoadingServiceRender:_CacheCurrentGrid(tableName)
  local loadGridConfig = {
    {
      PieceType.Blue,
      20
    },
    {
      PieceType.Red,
      20
    },
    {
      PieceType.Green,
      20
    },
    {
      PieceType.Yellow,
      20
    },
    {
      PieceType.Any,
      1
    },
    {
      PieceType.None,
      1
    }
  }
  local pieceServiceRender = self._world:GetService("Piece")
  for i = 1, #loadGridConfig do
    local gridPath = pieceServiceRender:GetGridPrefabPath(loadGridConfig[i][1])
    table.insert(tableName, {
      gridPath,
      loadGridConfig[i][2]
    })
  end
end

function LoadingServiceRender:_GetPetCacheTable()
  local ret = {}
  local petModule = GameGlobal.GameLogic():GetModule(PetModule)
  local joinedPlayerInfoArray = self._world.BW_WorldInfo.players
  for i, joinedPlayerInfo in pairs(joinedPlayerInfoArray) do
    for petIndex, matchPetInfo in ipairs(joinedPlayerInfo.pet_list) do
      local petPstID = matchPetInfo.pet_pstid
      local petData
      if self._world:MatchType() == MatchType.MT_PopStar then
        petData = PopStarMatchPet:New(matchPetInfo)
      else
        petData = MatchPet:New(matchPetInfo)
      end
      local retCache = self:_GetCacheTable_ByPetData({petData})
      table.appendArray(ret, retCache)
    end
  end
  if self._world:MatchType() == MatchType.MT_BlackFist then
    for petIndex, matchPetInfo in ipairs(self._world:BattleWorldEnterData():GetRemoteTeamInfo()) do
      local petPstID = matchPetInfo.pet_pstid
      local petData = MatchPet:New(matchPetInfo)
      local retCache = self:_GetCacheTable_ByPetData({petData})
      table.appendArray(ret, retCache)
    end
  end
  return ret
end

function LoadingServiceRender:_GetTrapCacheTable()
  local ret = {}
  local levelConfigData = self._configService:GetLevelConfigData()
  local waveNum = levelConfigData:GetWaveCount()
  local traps = levelConfigData:GetLevelAllWaveTraps()
  local trapArray = {}
  if #traps == 0 then
    return ret
  end
  for _, trapTransformParam in ipairs(traps) do
    local t = self:_GetOneTrapCacheTable(trapTransformParam)
    table.appendArray(ret, t)
  end
  return ret
end

function LoadingServiceRender:_GetOneTrapCacheTable(trapTransformParam)
  local ret = {}
  local trapConfigData = self._configService:GetTrapConfigData()
  local trapId = trapTransformParam:GetTrapID()
  if table.icontains(self._cachedTrapIdList, trapId) then
    return ret
  end
  table.insert(self._cachedTrapIdList, trapId)
  local resPathList = trapConfigData:GetTrapResPath(trapId)
  for i, resPath in ipairs(resPathList) do
    table.insert(ret, {resPath, 1})
  end
  local skillIds = trapConfigData:GetSkillIDs(trapId)
  if skillIds then
    local t = self:_GetSkillCacheTable(skillIds)
    table.appendArray(ret, t)
  end
  local shaderEffect = trapConfigData:GetTrapShaderEffect(trapId)
  if shaderEffect then
    self:_CacheEachShaderEffectsAssetFile(shaderEffect)
  end
  return ret
end

function LoadingServiceRender:_GetMonsterCacheTable()
  local ret = {}
  local levelConfigData = self._configService:GetLevelConfigData()
  local monsterIds = levelConfigData:GetLoadingMonsterID()
  for _, monsterID in ipairs(monsterIds) do
    local t = self:_GetOneMonsterCacheTable(monsterID)
    table.appendArray(ret, t)
  end
  monsterIds = levelConfigData:GetRunningMonsterID()
  for _, monsterID in ipairs(monsterIds) do
    local t = self:_GetOneMonsterCacheTable(monsterID)
    table.appendArray(ret, t)
  end
  return ret
end

function LoadingServiceRender:_GetOneMonsterCacheTable(monsterID)
  local ret = {}
  if table.icontains(self._cachedMonsterIdList, monsterID) then
    return ret
  end
  table.insert(self._cachedMonsterIdList, monsterID)
  local monsterConfigData = self._configService:GetMonsterConfigData()
  table.insert(ret, {
    monsterConfigData:GetMonsterResPath(monsterID),
    1
  })
  local permanentEffectArray = monsterConfigData:GetMonsterPermanentEffectID(monsterID)
  local idleEffectArray = monsterConfigData:GetMonsterIdleEffectID(monsterID)
  if permanentEffectArray then
    for _, effectID in ipairs(permanentEffectArray) do
      table.insert(ret, {
        Cfg.cfg_effect[effectID].ResPath,
        1
      })
    end
  end
  if idleEffectArray then
    for _, effectID in ipairs(idleEffectArray) do
      table.insert(ret, {
        Cfg.cfg_effect[effectID].ResPath,
        1
      })
    end
  end
  local deathEffectID = monsterConfigData:GetDeathShowEffectID(monsterID)
  if deathEffectID ~= nil then
    if type(deathEffectID) == "number" then
      table.insert(ret, {
        Cfg.cfg_effect[deathEffectID].ResPath,
        1
      })
    else
      for i, effID in ipairs(deathEffectID) do
        table.insert(ret, {
          Cfg.cfg_effect[effID].ResPath,
          1
        })
      end
    end
  end
  local skillIds = monsterConfigData:GetCacheSkillIds(monsterID)
  local t = self:_GetSkillCacheTable(skillIds)
  table.appendArray(ret, t)
  local buffList = monsterConfigData:GetBornBuffList(monsterID)
  if buffList then
    local t = self:_GetBuffCacheTable(buffList)
    table.appendArray(ret, t)
  end
  local shaderEffect = monsterConfigData:GetMonsterShaderEffect(monsterID)
  if shaderEffect then
    self:_CacheEachShaderEffectsAssetFile(shaderEffect)
  end
  local aiidAndOrders = monsterConfigData:GetMonsterAIID(monsterID)
  for i = 1, #aiidAndOrders do
    local aiid = aiidAndOrders[i][1]
    if aiid then
      local aiConfig = AILogicConfig[aiid]
      if aiConfig then
        for _, action in pairs(aiConfig.Action) do
          if type(action) == "table" and action.Type == "ActionCrazyMode" then
            local transformMonsterID = action.Data[1]
            local t = self:_GetOneMonsterCacheTable(transformMonsterID)
            table.appendArray(ret, t)
          end
        end
      end
    end
  end
  return ret
end

function LoadingServiceRender:_GetSkillCacheTable(skillIds, skinId)
  local ret = {}
  for _, skillid in ipairs(skillIds) do
    local t = self:_GetOneSkillCacheTable(skillid, skinId)
    table.appendArray(ret, t)
  end
  return ret
end

function LoadingServiceRender:_GetOneSkillCacheTable(skillId, skinId)
  local ret = {}
  if table.icontains(self._cachedSkillIdList, skillId) then
    return ret
  end
  table.insert(self._cachedSkillIdList, skillId)
  local skillConfig = self._configService:GetSkillConfigData(skillId)
  local skillPhaseArray = skillConfig:GetSkillPhaseArray(skinId)
  if not skillPhaseArray then
    local levelID = self._world.BW_WorldInfo.level_id
    Log.exception("找不到技能 skillID=" .. skillId .. "   levelID=" .. levelID)
  end
  for _, phase in ipairs(skillPhaseArray) do
    local skillPhaseParam = phase:GetPhaseParam()
    local t = skillPhaseParam:GetCacheTable(skillConfig, skinId)
    table.appendArray(ret, t)
  end
  local skillEffectArray = skillConfig:GetSkillEffect()
  for _, effect in ipairs(skillEffectArray) do
    if effect.GetEffectType then
      if effect:GetEffectType() == SkillEffectType.AddBuff then
        local t = self:_GetOneBuffCacheTable(effect:GetBuffID())
        table.appendArray(ret, t)
      elseif effect:GetEffectType() == SkillEffectType.SummonEverything then
        local t = self:_GetSummonCacheTable(effect)
        table.appendArray(ret, t)
      elseif effect:GetEffectType() == SkillEffectType.MakePhantom then
        local eft = effect
        local t = self:_GetOneMonsterCacheTable(eft:GetTargetID())
        table.appendArray(ret, t)
      elseif effect:GetEffectType() == SkillEffectType.Transformation then
        local eft = effect
        local t = self:_GetOneMonsterCacheTable(eft:GetTargetMonsterID())
        table.appendArray(ret, t)
      elseif effect:GetEffectType() == SkillEffectType.SummonMultipleTrap then
        local t = self:_GetOneTrapCacheTable(effect)
        table.appendArray(ret, t)
      end
    end
  end
  return ret
end

function LoadingServiceRender:_GetBuffCacheTable(buffList)
  local ret = {}
  for _, buffID in ipairs(buffList) do
    local t = self:_GetOneBuffCacheTable(buffID)
    table.appendArray(ret, t)
  end
  return ret
end

function LoadingServiceRender:_GetOneBuffCacheTable(buffID)
  local ret = {}
  if table.icontains(self._cachedBuffIdList, buffID) then
    return ret
  end
  table.insert(self._cachedBuffIdList, buffID)
  if not Cfg.cfg_buff[buffID] then
    return ret
  end
  local buffConfig = self._configService:GetBuffConfigData(buffID)
  local t = buffConfig:GetCacheTable()
  table.appendArray(ret, t)
  local skillIds = buffConfig:GetCacheSkillIds()
  local t = self:_GetSkillCacheTable(skillIds)
  table.appendArray(ret, t)
  local buffIds = buffConfig:GetCacheBuffIds()
  local t = self:_GetBuffCacheTable(buffIds)
  table.appendArray(ret, t)
  return ret
end

function LoadingServiceRender:_GetSummonCacheTable(skillEffectParam)
  local ret = {}
  local summonType = skillEffectParam:GetSummonType()
  local summonIDS = skillEffectParam:GetSummonList()
  for _key, summonID in pairs(summonIDS) do
    if summonType == SkillEffectEnum_SummonType.Monster then
      local t = self:_GetOneMonsterCacheTable(summonID)
      table.appendArray(ret, t)
    elseif summonType == SkillEffectEnum_SummonType.Trap then
      local trapData = Cfg.cfg_trap[summonID]
      for i, resPath in ipairs(trapData.ResPath) do
        table.insert(ret, {resPath, 1})
      end
    end
  end
  return ret
end

function LoadingServiceRender:_GetCacheTable()
  local t = {}
  t.scene = self:_GetSceneCacheTable()
  t.monster = self:_GetMonsterCacheTable()
  t.trap = self:_GetTrapCacheTable()
  t.pet = self:_GetPetCacheTable()
  t.common = self:_GetGameCacheResGroup()
  return t
end

function LoadingServiceRender:_LoadingSystemCacheAudio(TT)
  local cachetable = self:_GetSoundCacheTable()
  local l_acbMap = {}
  for k, v in ipairs(cachetable) do
    if USEADX2AUDIO then
      local l_strAcbName, l_strCueName = AudioHelperController.GetCueSheetAndCue(v)
      if l_strAcbName and l_acbMap[l_strAcbName] == nil then
        l_acbMap[l_strAcbName] = true
        AudioHelperController.RequestInnerGameSoundByResName(l_strAcbName)
      end
    else
      AudioHelperController.RequestInnerGameSound(v)
    end
  end
  local cachetable = self:_GetVoiceCacheTable()
  local l_res_map = {}
  for k, v in ipairs(cachetable) do
    local voiceResName = AudioHelperController.GetResNameByAudioId(v)
    if voiceResName ~= nil and not l_res_map[voiceResName] then
      l_res_map[voiceResName] = true
      AudioHelperController.RequestInnerGameVoiceByResName(voiceResName)
    end
  end
end

function LoadingServiceRender:_GetSoundCacheTable()
  local t = {}
  table.appendArray(t, self:_GetSceneSoundCacheTable())
  table.appendArray(t, self:_GetPetSoundCacheTable())
  table.appendArray(t, self:_GetTrapSoundCacheTable())
  table.appendArray(t, self:_GetMonsterSoundCacheTable())
  return t
end

function LoadingServiceRender:_GetSceneSoundCacheTable()
  local t = {}
  for i = CriAudioIDConst.SoundCoreGameLinkLineStart, CriAudioIDConst.SoundCoreGameLinkLineEnd do
    t[#t + 1] = i
  end
  t[#t + 1] = CriAudioIDConst.SouncCoreGameMonsterDeath
  t[#t + 1] = CriAudioIDConst.SoundPetCommonShow
  for i, v in ipairs(BattleConst.MonsterBornAudioList) do
    t[#t + 1] = v
  end
  return t
end

function LoadingServiceRender:_GetPetSoundCacheTable()
  local ret = {}
  local petModule = GameGlobal.GameLogic():GetModule(PetModule)
  local joinedPlayerInfoArray = self._world.BW_WorldInfo.players
  for i, joinedPlayerInfo in pairs(joinedPlayerInfoArray) do
    for petIndex, matchPetInfo in ipairs(joinedPlayerInfo.pet_list) do
      local petPstID = matchPetInfo.pet_pstid
      local petData
      if self._world:MatchType() == MatchType.MT_PopStar then
        petData = PopStarMatchPet:New(matchPetInfo)
      else
        petData = MatchPet:New(matchPetInfo)
      end
      local normalSkillID = petData:GetNormalSkill()
      local chainSkill = petData:GetChainSkillInfo()
      local activeSkill = petData:GetPetActiveSkill()
      local skillIds = {
        normalSkillID,
        table.unpack(table.select(chainSkill, "Skill")),
        activeSkill
      }
      local t = self:_GetSkillCacheSound(skillIds)
      table.appendArray(ret, t)
    end
  end
  return ret
end

function LoadingServiceRender:_GetTrapSoundCacheTable()
  local ret = {}
  local levelConfigData = self._configService:GetLevelConfigData()
  local traps = levelConfigData:GetLevelAllWaveTraps()
  local trapArray = {}
  if #traps == 0 then
    return ret
  end
  for _, trapTransformParam in ipairs(traps) do
    local t = self:_CacheTrapSound(trapTransformParam:GetTrapID())
    table.appendArray(ret, t)
  end
  return ret
end

function LoadingServiceRender:_GetMonsterSoundCacheTable()
  local ret = {}
  local levelConfigData = self._configService:GetLevelConfigData()
  local monsterIds = levelConfigData:GetAllMonsterID()
  for _, monsterID in ipairs(monsterIds) do
    local t = self:_CacheMonsterSound(monsterID)
    table.appendArray(ret, t)
  end
  return ret
end

function LoadingServiceRender:_CacheMonsterSound(monsterID)
  if table.ikey(self._cachedSoundMonsterIdList, monsterID) then
    return
  end
  table.insert(self._cachedSoundMonsterIdList, monsterID)
  local ret = {}
  local monsterConfigData = self._configService:GetMonsterConfigData()
  local deathAudioID = monsterConfigData:GetDeathAudioID(monsterID)
  if deathAudioID then
    table.insert(ret, deathAudioID)
  end
  local skillIds = monsterConfigData:GetCacheSkillIds(monsterID)
  local t = self:_GetSkillCacheSound(skillIds)
  table.appendArray(ret, t)
  local transformID = self._transformMonsterIDDic[monsterID]
  if transformID then
    local t = self:_CacheMonsterSound(transformID)
    table.appendArray(ret, t)
  end
  local aiidAndOrders = monsterConfigData:GetMonsterAIID(monsterID)
  for i = 1, #aiidAndOrders do
    local aiid = aiidAndOrders[i][1]
    if aiid then
      local aiConfig = AILogicConfig[aiid]
      if aiConfig then
        for _, action in pairs(aiConfig.Action) do
          if type(action) == "table" and action.Type == "ActionCrazyMode" then
            local transformMonsterID = action.Data[1]
            local t = self:_CacheMonsterSound(transformMonsterID)
            table.appendArray(ret, t)
          end
        end
      end
    end
  end
  return ret
end

function LoadingServiceRender:_CacheTrapSound(trapId)
  local ret = {}
  local trapConfigData = self._configService:GetTrapConfigData()
  local skillIds = trapConfigData:GetSkillIDs(trapId)
  if skillIds then
    local t = self:_GetSkillCacheSound(skillIds)
    table.appendArray(ret, t)
  end
  local trapConfig = trapConfigData:GetTrapData(trapId)
  if trapConfig.AIID then
    for i = 1, #trapConfig.AIID do
      local nConfigAiID = trapConfig.AIID[i]
      local aiConfigData = Cfg.cfg_ai[nConfigAiID]
      if aiConfigData then
        local t = self:_GetSkillCacheSound(aiConfigData.SkillList)
        table.appendArray(ret, t)
      end
    end
  end
  return ret
end

function LoadingServiceRender:_GetSkillCacheSound(skillIds)
  if not skillIds then
    return
  end
  local ret = {}
  for _, skillid in ipairs(skillIds) do
    local skillConfig = self._configService:GetSkillConfigData(skillid)
    local skillPhaseArray = skillConfig:GetSkillPhaseArray()
    for _, phase in ipairs(skillPhaseArray) do
      local ct = phase:GetPhaseParam():GetSoundCacheTable()
      if ct and 0 < #ct then
        table.appendArray(ret, ct)
      end
    end
    local effectArray = skillConfig:GetSkillEffect()
    for key, effectValue in pairs(effectArray) do
      if effectValue:GetEffectType() == SkillEffectType.SummonEverything then
        local summonType = effectValue:GetSummonType()
        local summonIDS = effectValue:GetSummonList()
        for _key, summonID in pairs(summonIDS) do
          if summonType == SkillEffectEnum_SummonType.Monster then
            local t = self:_CacheMonsterSound(summonID)
            table.appendArray(ret, t)
          elseif summonType == SkillEffectEnum_SummonType.Trap then
            local t = self:_CacheSummonTrapSound(summonID)
            table.appendArray(ret, t)
          end
        end
      elseif effectValue:GetEffectType() == SkillEffectType.AddBuff then
        local t = self:_CacheBuffSound(effectValue:GetBuffID())
        table.appendArray(ret, t)
      elseif effectValue:GetEffectType() == SkillEffectType.Transformation then
        local t = self:_CacheMonsterSound(effectValue:GetTargetMonsterID())
        table.appendArray(ret, t)
      elseif effectValue:GetEffectType() == SkillEffectType.MakePhantom then
        local t = self:_CacheMonsterSound(effectValue:GetTargetID())
        table.appendArray(ret, t)
      elseif effectValue:GetEffectType() == SkillEffectType.SummonMultipleTrap then
        local t = self:_CacheSummonTrapSound(effectValue:GetTrapID())
        table.appendArray(ret, t)
      end
    end
  end
  return ret
end

function LoadingServiceRender:_CacheBuffSound(buffID)
  local ret = {}
  if not Cfg.cfg_buff[buffID] then
    return ret
  end
  local buffConfig = self._configService:GetBuffConfigData(buffID)
  local ct = buffConfig:GetSoundCacheTable()
  if ct and 0 < #ct then
    table.appendArray(ret, ct)
  end
  return ret
end

function LoadingServiceRender:_CacheSummonTrapSound(trapID)
  if table.ikey(self._cachedSoundTrapIdList, trapID) then
    return
  end
  table.insert(self._cachedSoundTrapIdList, trapID)
  local ret = self:_CacheTrapSound(trapID)
  local trapConfigData = self._configService:GetTrapConfigData()
  local trapData = trapConfigData:GetTrapData(trapID)
  local logicParam = trapData.LogicParam
  if logicParam then
    local trapSummonMonsterID = logicParam.MonsterId
    if trapSummonMonsterID then
      local t = self:_CacheMonsterSound(trapSummonMonsterID)
      table.appendArray(ret, t)
    end
  end
  return ret
end

function LoadingServiceRender:_GetVoiceCacheTable()
  local ret = {}
  table.appendArray(ret, self:_GetPetVoiceCacheTable())
  table.appendArray(ret, self:_GetMonsterVoiceCacheTable())
  return ret
end

function LoadingServiceRender:_GetPetVoiceCacheTable()
  local ret = {}
  local petModule = GameGlobal.GameLogic():GetModule(PetModule)
  local joinedPlayerInfoArray = self._world.BW_WorldInfo.players
  for i, joinedPlayerInfo in pairs(joinedPlayerInfoArray) do
    for petIndex, matchPetInfo in ipairs(joinedPlayerInfo.pet_list) do
      local petPstID = matchPetInfo.pet_pstid
      local petData
      if self._world:MatchType() == MatchType.MT_PopStar then
        petData = PopStarMatchPet:New(matchPetInfo)
      else
        petData = MatchPet:New(matchPetInfo)
      end
      local normalSkillID = petData:GetNormalSkill()
      local chainSkill = petData:GetChainSkillInfo()
      local activeSkill = petData:GetPetActiveSkill()
      local skillIds = {
        normalSkillID,
        table.unpack(table.select(chainSkill, "Skill")),
        activeSkill
      }
      for _, skillid in ipairs(skillIds) do
        local skillConfig = self._configService:GetSkillConfigData(skillid)
        local skillPhaseArray = skillConfig:GetSkillPhaseArray(petData:GetSkinId())
        for _, phase in ipairs(skillPhaseArray) do
          local t = phase:GetPhaseParam():GetVoiceCacheTable()
          if t and 0 < #t then
            table.appendArray(ret, t)
          end
        end
      end
    end
  end
  return ret
end

function LoadingServiceRender:_GetMonsterVoiceCacheTable()
  local ret = {}
  local levelConfigData = self._configService:GetLevelConfigData()
  local monsterIds = levelConfigData:GetAllMonsterID()
  for _, monsterID in ipairs(monsterIds) do
  end
  return ret
end

function LoadingServiceRender:_CacheMonsterVoice(monsterID)
  if table.ikey(self._cachedVoiceMonsterIdList, monsterID) then
    return
  end
  table.insert(self._cachedVoiceMonsterIdList, monsterID)
  local ret = {}
  local monsterConfigData = self._configService:GetMonsterConfigData()
  local skillIdsList = monsterConfigData:GetCacheSkillIds(monsterID)
  for _, skillIds in pairs(skillIdsList) do
    for _, skillid in ipairs(skillIds) do
      local skillConfig = self._configService:GetSkillConfigData(skillid)
      local skillPhaseArray = skillConfig:GetSkillPhaseArray()
      for _, phase in ipairs(skillPhaseArray) do
        local ct = phase:GetPhaseParam():GetVoiceCacheTable()
        if ct and 0 < #ct then
          table.appendArray(ret, ct)
        end
      end
      local effectArray = skillConfig:GetSkillEffect()
      for key, effectValue in pairs(effectArray) do
        if effectValue:GetEffectType() == SkillEffectType.SummonEverything then
          local summonType = effectValue:GetSummonType()
          local summonIDS = effectValue:GetSummonList()
          for _key, summonID in pairs(summonIDS) do
            if summonType == SkillEffectEnum_SummonType.Monster then
              local t = self:_CacheMonsterVoice(ret, summonID)
              table.appendArray(ret, t)
            elseif summonType == SkillEffectEnum_SummonType.Trap then
            end
          end
        end
      end
    end
  end
  return ret
end

function LoadingServiceRender:_GetGameCacheResGroup()
  local ret = {}
  local resGroup = GameCacheResGroup:New()
  local effectcache = resGroup.EffectTable
  for k, v in pairs(effectcache) do
    local effectinfo = Cfg.cfg_effect[k]
    if effectinfo ~= nil then
      table.insert(ret, {
        effectinfo.ResPath,
        v
      })
    end
  end
  return ret
end

function LoadingServiceRender:_CacheGlobalAssetFile()
  local file_name = "globalShaderEffects.asset"
  local respool = self._world.BW_Services.ResourcesPool
  respool:CacheAsset(file_name, 1)
end

function LoadingServiceRender:_CacheEachShaderEffectsAssetFile(file_name)
  local respool = self._world.BW_Services.ResourcesPool
  respool:CacheAsset(file_name, 1)
end

function LoadingServiceRender:_CacheGridMaterial(cacheTable)
  local pieceService = self._world:GetService("Piece")
  local hasGridLine = pieceService:GetPieceHasGridLine()
  if hasGridLine ~= 1 then
    return
  end
  local levelID = self._world.BW_WorldInfo.level_id
  local levelConfig = Cfg.cfg_level[levelID]
  local themeID = levelConfig.Theme
  local cfgThemeData = Cfg.cfg_theme[themeID]
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderBoardCmpt = renderBoardEntity:RenderBoard()
  renderBoardCmpt:SetBrillantGridLineExtendParam(cfgThemeData.BrillantGridLineExtendParam)
  local lineParam = cfgThemeData.BrillantWhiteLineParam
  local levelGridCellScale = lineParam and lineParam.GridCellScale or BattleConst.GridCellScale
  UnityEngine.Shader.SetGlobalFloat("_h3d_GeziCellScale", levelGridCellScale)
  local req = ResourceManager:GetInstance():SyncLoadAsset(GameResourceConst.BrillantLine, LoadType.GameObject)
  renderBoardCmpt:SetBrillantGridRequest(req)
end

function LoadingServiceRender:_PreCreateFirstWaveMonsterAndTrap(TT)
  local eMonsters = {}
  local utilDataSvc = self._world:GetService("UtilData")
  local monsterIDList = utilDataSvc:GetFirstWaveMonsterIDList()
  for _, id in ipairs(monsterIDList) do
    local entity = self._world:GetEntityByID(id)
    table.insert(eMonsters, entity)
  end
  local sMonsterShowRender = self._world:GetService("MonsterShowRender")
  sMonsterShowRender:CreateMonsterHPEntities(eMonsters)
  local utilDataSvc = self._world:GetService("UtilData")
  local isArchived = utilDataSvc:IsArchivedBattle()
  if isArchived then
    for _, v in pairs(eMonsters) do
      local hpCmpt = v:HP()
      local curhp = utilDataSvc:GetCurrentLogicHP(v)
      v:ReplaceRedHPAndWhitHP(curhp)
    end
  end
  YIELD(TT)
  for _, v in pairs(eMonsters) do
    local monsterEntity = v
    monsterEntity:SetViewVisible(true)
    monsterEntity:SetLocation(monsterEntity:GetGridPosition() + monsterEntity:GetGridOffset(), monsterEntity:GetGridDirection())
    monsterEntity:SetLocationHeight(BattleConst.CacheHeight)
    local hpCmpt = monsterEntity:HP()
    local hpSliderEntityID = hpCmpt:GetHPSliderEntityID()
    local hpEntity = self._world:GetEntityByID(hpSliderEntityID)
    if hpEntity then
      local go = hpEntity:View().ViewWrapper.GameObject
      local uiview = go:GetComponent("UIView")
      local buffRootPath = uiview:GetUIComponent("UISelectObjectPath", "buffRoot")
      if buffRootPath then
        local buffRoot = UICustomWidgetPool:New(self, buffRootPath)
        buffRoot:SpawnObjects("UIHPBuffInfo", 1)
        local uiHPBuffInfo = buffRoot:GetAllSpawnList()[1]
        uiHPBuffInfo:SetData(monsterEntity:GetID())
        hpCmpt:SetUIHpBuffInfoWidget(buffRoot)
      end
    end
  end
end

function LoadingServiceRender:_PreCreateTeam()
  local entityServiceRender = self._world:GetService("RenderEntity")
  if self._world:MatchType() ~= MatchType.MT_Chess then
    entityServiceRender:CreateBattleTeamMemberRender()
    entityServiceRender:CreateBattleTeamRender()
  elseif self._world:MatchType() == MatchType.MT_Chess then
    entityServiceRender:CreateChessPet()
  end
end

function LoadingServiceRender:_GetCacheTable_ByPetData(listPetData)
  local ret = {}
  for petIndex, petData in ipairs(listPetData) do
    local heroPrefab = petData:GetPetPrefab(PetSkinEffectPath.MODEL_INGAME)
    local heroAncName = HelperProxy:GetInstance():GetPetAnimatorControllerName(heroPrefab, PetAnimatorControllerType.Battle)
    table.appendArray(ret, {
      {heroAncName, 1}
    })
    local normalSkillID = petData:GetNormalSkill()
    local chainSkill = petData:GetChainSkillInfo()
    local activeSkill = petData:GetPetActiveSkill()
    local skinId = petData:GetSkinId()
    local skillIds = {
      normalSkillID,
      table.unpack(table.select(chainSkill, "Skill")),
      activeSkill
    }
    local t = self:_GetSkillCacheTable(skillIds, skinId)
    table.appendArray(ret, t)
    local passiveSkillID = petData:GetPetPassiveSkill()
    if passiveSkillID and 0 < passiveSkillID then
      local cfg = Cfg.cfg_passive_skill[passiveSkillID]
      local t = self:_GetBuffCacheTable(cfg.BuffID)
      table.appendArray(ret, t)
    end
    local shaderEffect = petData:GetPetShaderEffect()
    if shaderEffect then
      self:_CacheEachShaderEffectsAssetFile(shaderEffect)
    end
    local templateID = petData:GetTemplateID()
    local permanentEffectArray = Cfg.cfg_pet[templateID].BattlePermanentEffect
    if permanentEffectArray and #permanentEffectArray then
      for _, effectID in ipairs(permanentEffectArray) do
        local cfgEffect = Cfg.cfg_effect[effectID]
        if cfgEffect then
          table.insert(ret, {
            cfgEffect.ResPath,
            1
          })
        end
      end
    end
  end
  return ret
end

function LoadingServiceRender:CacheObject_MatchPet(TT, listMatchPet)
  local respool = self._world.BW_Services.ResourcesPool
  local listRes = self:_GetCacheTable_ByPetData(listMatchPet)
  local tmClockLoad = os.clock()
  for keystr, v in pairs(listRes) do
    local resname = v[1]
    local count = v[2]
    if string.endwith(resname, ".mat") then
      respool:CacheMaterial(resname, count)
    else
      respool:Cache(resname, count)
    end
    local tmClockNow = os.clock()
    if 4 <= tmClockNow - tmClockLoad then
      YIELD(TT)
      tmClockLoad = tmClockNow
    end
  end
end

function LoadingServiceRender:_InitializeLoadingEntity(TT)
  local sEntity = self._world:GetService("RenderEntity")
  local effectEntity = sEntity:CreateRenderEntity(EntityConfigIDRender.FinalAttackEffect)
  local resPath = "eff_finalatk.prefab"
  effectEntity:ReplaceAsset(NativeUnityPrefabAsset:New(resPath, false))
  local sEntity = self._world:GetService("RenderEntity")
  sEntity:CreateRenderEntity(EntityConfigIDRender.GuideFinger)
  local sEntity = self._world:GetService("RenderEntity")
  sEntity:CreateRenderEntity(EntityConfigIDRender.LinkageInfo)
  local canMoveArrowService = self._world:GetService("CanMoveArrow")
  canMoveArrowService:InitArrows()
  canMoveArrowService:InitArrows()
end
