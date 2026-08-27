local FormationUtil = {}
local FmtEnum = require("Game.Formation.FmtEnum")
local FixedFmtHeroData = require("Game.PlayerData.Hero.FixedFmtHeroData")
local DungeonTypeFmtIdOffset = {
  [proto_csmsg_DungeonType.DungeonType_Daily] = 100,
  [proto_csmsg_DungeonType.DungeonType_WinterHard] = 200,
  [proto_csmsg_DungeonType.DungeonType_ActivityCard] = 900,
  [proto_csmsg_DungeonType.DungeonType_HeroLite] = 1100,
  [proto_csmsg_DungeonType.DungeonType_HeroLiteFree] = 1100
}
local FmtFromModuleFmtIdOffset = {
  [FmtEnum.eFmtFromModule.DailyDungeon] = 100,
  [FmtEnum.eFmtFromModule.DailyDungeonLevel] = 100,
  [FmtEnum.eFmtFromModule.SctIIDunChallenge] = 200,
  [FmtEnum.eFmtFromModule.DungeonTwinTower] = 300,
  [FmtEnum.eFmtFromModule.CarnivalEp] = 400,
  [FmtEnum.eFmtFromModule.WarChess] = 500,
  [FmtEnum.eFmtFromModule.SpringEp] = 600,
  [FmtEnum.eFmtFromModule.Brotato] = 800,
  [FmtEnum.eFmtFromModule.CardSet] = 900,
  [FmtEnum.eFmtFromModule.HGV3Normal] = 1100,
  [FmtEnum.eFmtFromModule.HGV3NormalFree] = 1100,
  [FmtEnum.eFmtFromModule.BondDun] = 1200,
  [FmtEnum.eFmtFromModule.SixHeroTower] = 1300,
  [FmtEnum.eFmtFromModule.Infinity4Act24] = 1400
}
local FmtSpecialStageOffset = {Guard = 700}
FormationUtil.fixedFmtIdList = {1000, 1001}

function FormationUtil.GetFmtIdByDungeonType(dungeonType, fmtId)
  local offset = FormationUtil.GetFmtIdOffsetByDungeonType(dungeonType)
  local id = fmtId + offset
  return id
end

function FormationUtil.GetFmtIdOffsetByDungeonType(dungeonType)
  local offset = DungeonTypeFmtIdOffset[dungeonType] or 0
  return offset
end

function FormationUtil.GetFmtIdOffsetByFmtFromModule(fmtFromModule, stageId)
  local offset = FmtFromModuleFmtIdOffset[fmtFromModule] or 0
  if stageId and offset == 0 then
    offset = FormationUtil.GetFmtIdOffsetBySpecialStage(stageId)
  end
  if ConfigData.special_team_stage[stageId] ~= nil then
    offset = ConfigData.special_team_stage[stageId].fmt_id_offset
  end
  if ConfigData.sector_stage[stageId] ~= nil and ConfigData.sector_stage[stageId].team_config_offset ~= 0 then
    offset = ConfigData.sector_stage[stageId].team_config_offset
  end
  return offset
end

function FormationUtil.GetFmtIdOffsetBySpecialStage(stageId)
  local stageCfg = ConfigData.sector_stage[stageId]
  if stageCfg then
    local explorationId = stageCfg.exploration_list[1]
    local explorationCfg = ConfigData.exploration[explorationId]
    if explorationCfg then
      return ExplorationManager:CheckGuardModeByMapLogic(explorationCfg.map_logic) and FmtSpecialStageOffset.Guard or 0
    end
  end
  return 0
end

local _GetModuleIdByFmtFromModuleFunc = {
  [FmtEnum.eFmtFromModule.DailyDungeon] = proto_csmsg_DungeonType.DungeonType_Daily,
  [FmtEnum.eFmtFromModule.DailyDungeonLevel] = proto_csmsg_DungeonType.DungeonType_Daily,
  [FmtEnum.eFmtFromModule.SctIIDunChallenge] = proto_csmsg_DungeonType.DungeonType_WinterHard,
  [FmtEnum.eFmtFromModule.HGV3Normal] = proto_csmsg_DungeonType.DungeonType_HeroLite,
  [FmtEnum.eFmtFromModule.HGV3NormalFree] = proto_csmsg_DungeonType.DungeonType_HeroLiteFree,
  [FmtEnum.eFmtFromModule.BondDun] = proto_csmsg_DungeonType.DungeonType_Bond
}

function FormationUtil.GetModuleIdByFmtFromModule(fmtFromModule)
  local id = _GetModuleIdByFmtFromModuleFunc[fmtFromModule]
  if id == nil then
    error("Unsupported fmtFromModule, fmtFromModule:" .. tostring(fmtFromModule))
    return
  end
  return id
end

local _GetDyncDgDataByFmtFromModuleFunc = {
  [FmtEnum.eFmtFromModule.DailyDungeon] = function()
    return PlayerDataCenter.dungeonDyncData:GetDailyDungeonDyncData()
  end,
  [FmtEnum.eFmtFromModule.DailyDungeonLevel] = function()
    return PlayerDataCenter.dungeonDyncData:GetDailyDungeonDyncData()
  end,
  [FmtEnum.eFmtFromModule.SctIIDunChallenge] = function()
    return PlayerDataCenter.dungeonDyncData:GetWinterChallengeDgDyncData()
  end,
  [FmtEnum.eFmtFromModule.HGV3Normal] = function()
    return PlayerDataCenter.dungeonDyncData:GetDungeonDyncData(proto_csmsg_SystemFunctionID.SystemFunctionID_herolite_normal)
  end,
  [FmtEnum.eFmtFromModule.HGV3NormalFree] = function()
    return PlayerDataCenter.dungeonDyncData:GetDungeonDyncData(proto_csmsg_SystemFunctionID.SystemFunctionID_herolite_normal_free)
  end,
  [FmtEnum.eFmtFromModule.BondDun] = function()
    return PlayerDataCenter.dungeonDyncData:GetDungeonDyncData(proto_csmsg_SystemFunctionID.SystemFunctionID_activity_bond)
  end
}

function FormationUtil.GetDyncDgDataByFmtFromModule(fmtFromModule)
  local func = _GetDyncDgDataByFmtFromModuleFunc[fmtFromModule]
  if func == nil then
    error("Unsupported fmtFromModule, fmtFromModule:" .. tostring(fmtFromModule))
    return
  end
  return func()
end

function FormationUtil.GetDgDyncDefaultFmtId(dungeonType)
  return FormationUtil.GetFmtIdByDungeonType(dungeonType, 1)
end

function FormationUtil.GetFmtIdByFixedTeamId(fixedTeamId)
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local fixedTeamId2FmtIdDic, fixedTeamIdListSaved = saveUserData:GetFmtFixedSaved()
  local fmtId
  if table.contain(fixedTeamIdListSaved, fixedTeamId) then
    local index = table.indexof(fixedTeamIdListSaved, fixedTeamId)
    table.remove(fixedTeamIdListSaved, index)
    table.insert(fixedTeamIdListSaved, fixedTeamId)
    fmtId = fixedTeamId2FmtIdDic[fixedTeamId]
    local formationData = PlayerDataCenter.formationDic[fmtId]
    if formationData == nil then
      formationData = PlayerDataCenter:CreateFormation(fmtId)
      NetworkManager:GetNetwork(NetworkTypeID.Hero):SendFormationFresh(fmtId, formationData.data, formationData:GetFmtFairyUID())
    else
      local assistTeamCfg = ConfigData.assist_team[fixedTeamId]
      local idxError = false
      local maxNum = assistTeamCfg.extra_add + #assistTeamCfg.param1
      for idx, heroId in pairs(formationData.data) do
        if idx <= #assistTeamCfg.param1 or idx > maxNum then
          idxError = true
          break
        end
      end
      if assistTeamCfg.extra_add < table.count(formationData.data) or idxError then
        formationData:CleanFormation()
        NetworkManager:GetNetwork(NetworkTypeID.Hero):SendFormationFresh(fmtId, formationData.data, formationData:GetFmtFairyUID())
      end
    end
  else
    if #fixedTeamIdListSaved >= #FormationUtil.fixedFmtIdList then
      local removeFixedTeamId = table.remove(fixedTeamIdListSaved, 1)
      fmtId = fixedTeamId2FmtIdDic[removeFixedTeamId]
      fixedTeamId2FmtIdDic[removeFixedTeamId] = nil
    else
      local newFmtIdIdx = #fixedTeamIdListSaved + 1
      fmtId = FormationUtil.fixedFmtIdList[newFmtIdIdx]
    end
    table.insert(fixedTeamIdListSaved, fixedTeamId)
    fixedTeamId2FmtIdDic[fixedTeamId] = fmtId
    local formationData = PlayerDataCenter.formationDic[fmtId]
    if formationData == nil then
      formationData = PlayerDataCenter:CreateFormation(fmtId)
    else
      formationData:CleanFormation()
    end
    NetworkManager:GetNetwork(NetworkTypeID.Hero):SendFormationFresh(fmtId, formationData.data, formationData:GetFmtFairyUID())
  end
  saveUserData:SetFmtFixedSaved(fixedTeamId2FmtIdDic, fixedTeamIdListSaved)
  print(string.format([[
fmtId:%s
fixedTeamId2FmtIdDic:%s
fixedTeamIdListSaved:%s]], tostring(fmtId), serpent.block(fixedTeamId2FmtIdDic), serpent.block(fixedTeamIdListSaved)))
  return fmtId
end

function FormationUtil.SetFiexdFmt(fmtId, fixedHeroTeamId, fmtName)
  local assistTeamCfg = ConfigData.assist_team[fixedHeroTeamId]
  if #assistTeamCfg.param1 + assistTeamCfg.extra_add > ConfigData.game_config.max_formation_hero then
    error("assist_team.extra_add error, id = " .. tostring(fixedHeroTeamId))
  end
  local fixedHeroDataList = {}
  local fixedHeroIdList = {}
  for k, heroId in ipairs(assistTeamCfg.param1) do
    local assistLv = assistTeamCfg.assist_lvs[k]
    local assistLvCfg = ConfigData.assist_level[assistLv]
    local skinId = assistTeamCfg.override_skin[k]
    local heroName = LanguageUtil.GetLocaleText(assistTeamCfg.override_name[k])
    local heroData = FixedFmtHeroData.FixedFmtHeroData(heroId, assistLvCfg, skinId, heroName)
    table.insert(fixedHeroDataList, heroData)
    table.insert(fixedHeroIdList, heroId)
  end
  local formationData = PlayerDataCenter.formationDic[fmtId]
  formationData:SetFmtFixedHeroList(fixedHeroDataList, fixedHeroIdList)
  if not string.IsNullOrEmpty(fmtName) then
    formationData.name = fmtName
  end
  return assistTeamCfg
end

function FormationUtil.ClearFiexdFmt(fmtId)
  local formationData = PlayerDataCenter.formationDic[fmtId]
  if formationData ~= nil then
    formationData:ClearFmtFixedHero()
  end
end

function FormationUtil.CheckFmtBenchUnlock(fmtIndex, getUnlockDesc)
  local unlock, lockStr
  local benchId = fmtIndex - ConfigData.game_config.max_stage_hero
  if benchId <= 0 then
    unlock = true
  else
    unlock, lockStr = FunctionUnlockMgr.BenchUnlock(benchId, getUnlockDesc)
  end
  return unlock, lockStr
end

function FormationUtil.WarChessTeamsCheck(fmtDatas, officialSupportCfgId)
  local usedHeroDic = {}
  local needRefreshFmtDataDic = {}
  local isNeedRefresh = false
  for _, fmtData in ipairs(fmtDatas) do
    local heroDic = fmtData:GetFormationHeroDic()
    for heroIndex, heroId in pairs(heroDic) do
      if usedHeroDic[heroId] then
        print("<color=yellow>has repeat hero</color>")
        fmtData:SetHero2Formation(heroIndex, nil)
        isNeedRefresh = true
        needRefreshFmtDataDic[fmtData] = true
      end
      usedHeroDic[heroId] = true
    end
    local isNeedClean = FormationUtil.TryCleanIllegalOfficialSupportData(officialSupportCfgId, fmtData)
    isNeedRefresh = isNeedRefresh or isNeedClean
  end
  for fmtData, _ in pairs(needRefreshFmtDataDic) do
    NetworkManager:GetNetwork(NetworkTypeID.Hero):SendFormationFresh(fmtData.id, fmtData.data, fmtData:GetFmtFairyUID())
  end
  return isNeedRefresh
end

function FormationUtil.TryCleanIllegalOfficialSupportData(officialSupportCfgId, fmtData)
  local isNeedClean = false
  if officialSupportCfgId == nil or officialSupportCfgId == 0 then
    isNeedClean = true
  else
    local oshDic = fmtData:GetIsHaveOfficialSupportDic()
    if oshDic ~= nil then
      for _, officialSuppotData in pairs(oshDic) do
        if officialSuppotData.cfgId ~= officialSupportCfgId then
          isNeedClean = true
          break
        end
      end
    end
  end
  if isNeedClean then
    fmtData:CleanOfficialSupportData()
  end
  return isNeedClean
end

local needResendCSTInfoModList = {
  FmtEnum.eFmtFromModule.WarChess,
  FmtEnum.eFmtFromModule.DailyDungeon,
  FmtEnum.eFmtFromModule.HGV3Normal,
  FmtEnum.eFmtFromModule.HGV3NormalFree
}

function FormationUtil.IsNeedResendCSTInfoFmtId(fmtId)
  for _, type in ipairs(needResendCSTInfoModList) do
    if fmtId > FmtFromModuleFmtIdOffset[type] and fmtId < FmtFromModuleFmtIdOffset[type] + 100 then
      return true
    end
  end
end

return FormationUtil
