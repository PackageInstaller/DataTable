local base = ControllerBase
local ActivityBrotatoLobbyCtrl = class("ActivityBrotatoLobbyCtrl", base)
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local PeridicFmtBuffSelectData = require("Game.PeriodicChallenge.PeridicFmtBuffSelectData")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local SpecificHeroDataRuler = require("Game.PlayerData.Hero.SpecificHeroDataRuler")
local FmtEnum = require("Game.Formation.FmtEnum")
local TinyGameUtil = require("Game.TinyGames.TinyGameUtil")
local CS_GameObject = CS.UnityEngine.GameObject
local BrotatoEnum = require("Game.ActivityBrotatoLobby.BrotatoEnum")
local BrotatoData = require("Game.ActivityBrotatoLobby.Data.BrotatoData")

function ActivityBrotatoLobbyCtrl:OnInit()
  ConfigData:LoadDynCfg(eDynConfigData.tiny_game_brotato)
  ConfigData:LoadDynCfg(eDynConfigData.tiny_game_brotato_difficulty)
  self.__camMain = UIManager:GetMainCamera()
  self.__lightMain = CS_GameObject.FindWithTag(TagConsts.MainLight)
  self.__OnTinyGameDataChange = BindCallback(self, self.OnTinyGameDataChange)
  MsgCenter:AddListener(eMsgEventId.TinyGameDataChange, self.__OnTinyGameDataChange)
  self.brotatoDataDic = {}
  self.__OnExitUIBrotatoLobby = BindCallback(self, self.OnExitUIBrotatoLobby)
end

function ActivityBrotatoLobbyCtrl:InitBrotatoLobbyCtrl(endTime, miniGameConfigId, closeCallback, startGameCallback)
  self.__endTime = endTime
  self.miniGameConfigId = miniGameConfigId
  self.tinyGameCfg = ConfigData.tiny_game_brotato[self.miniGameConfigId]
  self.tinyGameDifficultyCfg = ConfigData.tiny_game_brotato_difficulty[self.miniGameConfigId]
  self.closeCallBack = closeCallback
  self.startGameCallback = startGameCallback
  self:__InitBrotatoRankInfo(miniGameConfigId)
end

function ActivityBrotatoLobbyCtrl:CreateBrotatoData(brotatoId, activityFrameId)
  local brotatoData = BrotatoData.CreateBrotatoData(brotatoId, activityFrameId)
  self.brotatoDataDic[brotatoId] = brotatoData
  return brotatoData
end

function ActivityBrotatoLobbyCtrl:__InitBrotatoRankInfo(brotatoId)
  local brotatoData = self:GetBrotatoData(brotatoId)
  if brotatoData == nil then
    return
  end
  local allFriendRanks, mineGrade = brotatoData:GetTinyGameRankInfo()
  self._mineGrade = mineGrade
  self._allFriendRanks = allFriendRanks
  self._rankIndex = TinyGameUtil.SortTinyGameRankDatas(self._allFriendRanks, self._mineGrade)
end

function ActivityBrotatoLobbyCtrl:SetBrotatoActivityFrameId(activityFrameId)
  self.activityFrameId = activityFrameId
end

function ActivityBrotatoLobbyCtrl:GetBrotatoData(brotatoId)
  return self.brotatoDataDic[brotatoId]
end

function ActivityBrotatoLobbyCtrl:GetTinyGameStageId()
  if self.tinyGameCfg ~= nil then
    return self.tinyGameCfg.stage_id
  end
  return 0
end

function ActivityBrotatoLobbyCtrl:GetBrotatoTinyGameCfg()
  return self.tinyGameCfg
end

function ActivityBrotatoLobbyCtrl:GetBrotatoTinyGameDifficultyCfg()
  return self.tinyGameDifficultyCfg
end

function ActivityBrotatoLobbyCtrl:GetIsBrotatoActOver()
  return PlayerDataCenter.timestamp >= (self.__endTime or 0)
end

function ActivityBrotatoLobbyCtrl:GetIsBrotatoActAcvive()
  return self.tinyGameCfg ~= nil
end

function ActivityBrotatoLobbyCtrl:GetBrotatoAchievementDatas(brotatoId)
  local brotatoData = self:GetBrotatoData(brotatoId)
  if brotatoData == nil then
    return table.emptytable
  end
  return brotatoData:GetBrotatoAchieveData()
end

function ActivityBrotatoLobbyCtrl:ShowBrotatoLobbyUIMain(brotatoId, bIsOpenByBattleResult, openCallback)
  if not self:GetIsBrotatoActAcvive() then
    return
  end
  local broatoData = self:GetBrotatoData(brotatoId)
  if broatoData == nil then
    return
  end
  if self:GetIsBrotatoActOver() then
    CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(6033))
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.UIBrotatoLobbyMain, function(window)
    if window ~= nil then
      self:EnableMainCamAndLight(false)
      window:InitBrotatoMain(self, self.tinyGameCfg, self.__endTime, broatoData:GetBrotatoGameHistoryScore(), self.__OnExitUIBrotatoLobby)
      if bIsOpenByBattleResult then
        self:OnOpenByBattleResult(window)
      end
      if openCallback ~= nil then
        openCallback()
      end
      local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
      local reddot = broatoData:GetBrotatoRedDot()
      if reddot ~= nil then
        local flag = saveUserData:GetIsSReddotClose(reddot.nodePath)
        if flag == nil or flag == false then
          saveUserData:SetSReddotClose(reddot.nodePath, true)
          reddot:SetRedDotCount(0)
          broatoData:RefreshRedBrotato()
        end
      end
    end
  end)
end

function ActivityBrotatoLobbyCtrl:EnableMainCamAndLight(enable)
  if not IsNull(self.__camMain) then
    self.__camMain.gameObject:SetActive(enable)
  end
  if not IsNull(self.__lightMain) then
    self.__lightMain:SetActive(enable)
  end
end

function ActivityBrotatoLobbyCtrl:OnOpenByBattleResult(window)
  window:OnClickRankBtn()
end

function ActivityBrotatoLobbyCtrl:ReqGetRankPageData(callback)
  if PlayerDataCenter.friendDataCenter:IsExpireFriendData() then
    local friendNetCtrl = NetworkManager:GetNetwork(NetworkTypeID.Friend)
    friendNetCtrl:CS_FRIEND_RefreshFriend(function()
      self:__InitBrotatoRankInfo()
      if callback ~= nil then
        callback(self._allFriendRanks, self._mineGrade, self._rankIndex)
      end
    end)
  elseif callback ~= nil then
    callback(self._allFriendRanks, self._mineGrade, self._rankIndex)
  end
end

function ActivityBrotatoLobbyCtrl:GetIsNeedSelectDifficulty()
  return self.tinyGameDifficultyCfg ~= nil and self.tinyGameCfg.type_difficulty == BrotatoEnum.EGameStartType.SelectDifficulty
end

function ActivityBrotatoLobbyCtrl:GetIsBrotatoCanContinue()
  local curStageSector = ConfigData.sector_stage[self:GetBrotatoTinyGameCfg().stage_id].sector
  local playMoudle = SectorStageDetailHelper.SectorPlayMoudle(curStageSector)
  local unComplete, unStageId = SectorStageDetailHelper.HasUnCompleteStage(playMoudle)
  local lastStageCfg = ConfigData.sector_stage[unStageId]
  if unComplete and lastStageCfg.sector == curStageSector then
    return true, unStageId
  end
  return false
end

function ActivityBrotatoLobbyCtrl:StartBrotatoGame(stageId)
  if self.startGameCallback ~= nil then
    self.startGameCallback(stageId)
  end
  local curStageCfg = ConfigData.sector_stage[stageId]
  local playMoudle = SectorStageDetailHelper.SectorPlayMoudle(curStageCfg.sector)
  local unComplete, unStageId = SectorStageDetailHelper.HasUnCompleteStage(playMoudle)
  if unComplete then
    if unStageId ~= curStageCfg.id then
      SectorStageDetailHelper.TryToShowCurrentLevelTips(playMoudle)
    else
      ExplorationManager:ContinueLastExploration()
      UIManager:DeleteWindow(UIWindowTypeID.UIBrotatoLobbyMain, true)
      ControllerManager:DeleteController(ControllerTypeId.ActivityLobbyCtrl)
    end
    return
  end
  
  local function enterFunc()
    UIManager:HideWindow(UIWindowTypeID.UIBrotatoLobbyMain)
  end
  
  local function exitFunc(fmtId)
    local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    saveUserData:SetLastFromModuleFmtId(FmtEnum.eFmtFromModule.Brotato, fmtId)
    UIManager:ShowWindowOnly(UIWindowTypeID.UIBrotatoLobbyMain, true)
  end
  
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, true)
  local commonBattleFunc
  
  local function startBattleFunc(curSelectFormationData, callBack, dinterfaceData)
    local curSelectFormationId = curSelectFormationData.id
    local formationData = PlayerDataCenter.formationDic[curSelectFormationId]
    if formationData == nil then
      return
    end
    local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    saveUserData:SetLastFromModuleFmtId(FmtEnum.eFmtFromModule.Brotato, curSelectFormationId)
    PersistentManager:SaveModelData(PersistentConfig.ePackage.UserData)
    local selectBuffIds
    local enterFmtData = fmtCtrl:GetCurEnterFmtData()
    if enterFmtData ~= nil then
      local buffSelectData = enterFmtData:GetPeridicFmtBuffSelect()
      if buffSelectData ~= nil then
        selectBuffIds = buffSelectData:GetFmtBuffSelect()
      end
    end
    ControllerManager:DeleteController(ControllerTypeId.ActivityLobbyCtrl)
    BattleDungeonManager:SaveFormation(formationData)
    local totalFtPower, totalBenchPower = fmtCtrl:CalculatePower(curSelectFormationData)
    ExplorationManager:ReqEnterExploration(stageId, curSelectFormationId, proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration, false, function()
      UIManager:DeleteWindow(UIWindowTypeID.UIBrotatoLobbyMain, true)
      if callBack ~= nil then
        callBack()
      end
    end, curSelectFormationData:GetSupportHeroData(), nil, nil, totalFtPower, totalBenchPower, selectBuffIds)
  end
  
  local lastFmtId = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetLastFromModuleFmtId(FmtEnum.eFmtFromModule.Brotato)
  local fmtBuffSelectData = PeridicFmtBuffSelectData.CreateFmtBuffByBrotato(stageId)
  local chaggengeCfg = ConfigData.brotato_challenge[stageId]
  local fmtRuleCfg
  local ruleId = chaggengeCfg.formation_rule_id
  if 0 < ruleId then
    fmtRuleCfg = ConfigData.formation_rule[ruleId]
  end
  local isSelectDifficulty = self.tinyGameCfg.type_difficulty == BrotatoEnum.EGameStartType.SelectDifficulty
  fmtCtrl:ResetFmtCtrlState()
  local fmtData = fmtCtrl:GetNewEnterFmtData():SetFmtCtrlBaseInfo(FmtEnum.eFmtFromModule.Brotato, stageId, lastFmtId):SetFmtCtrlCallback(enterFunc, exitFunc, startBattleFunc):SetIsOpenBuffSelect(true):SetPeridicFmtBuffSelect(fmtBuffSelectData):SetIsShowNotEditNormalObj(false):SetFmtIsBrotatoDeploy(true):SetFormationRuleCfg(fmtRuleCfg):SetIsOpenChangeFmt(false):SetNeedCheckFormationData(true)
  if curStageCfg.official_assist == 0 then
    local specificHeroDataRuler = SpecificHeroDataRuler.ctorWithBrotatoChallenge(stageId)
    fmtData:SetSpecificHeroDataRuler(specificHeroDataRuler):SetFmtBrotatoNeedBanNotSelf(true)
  else
    fmtData:SetOfficialSupportCfgId(curStageCfg.official_assist)
  end
  fmtCtrl:EnterFormation()
end

function ActivityBrotatoLobbyCtrl:GetParentActivityData(stageId)
  local brotatoId = ConfigData.tiny_game_brotato_difficulty.stageBrotatoDic[stageId]
  local brotatoData = self:GetBrotatoData(brotatoId)
  if brotatoData ~= nil then
    local parentActFrameData = brotatoData:GetParentActivityFrameData()
    return parentActFrameData:GetActivityFrameCat(), parentActFrameData:GetActId(), parentActFrameData
  end
  return nil, nil
end

function ActivityBrotatoLobbyCtrl:OnExitUIBrotatoLobby()
  self:EnableMainCamAndLight(true)
  if self.closeCallBack ~= nil then
    self.closeCallBack()
  end
  if not IsNull(self.bgm) then
    AudioManager:StopAudioByBack(self.bgm)
    self.bgm = nil
  end
  if not IsNull(self.dragAudio) then
    AudioManager:StopAudioByBack(self.dragAudio)
    self.dragAudio = nil
  end
end

function ActivityBrotatoLobbyCtrl:UpdataBrotatoData(msg, id, activityFrameId)
  local brotatoData = self.brotatoDataDic[id]
  if brotatoData == nil then
    brotatoData = self:CreateBrotatoData(id, activityFrameId)
  end
  brotatoData:SetBrotatoRewardPickedLevel(msg.gameReceivedLevel)
  brotatoData:SetGameBrotatoItemNum(msg.gameBrotatoItemNum)
  brotatoData:BroadCastBrotatoChange()
end

function ActivityBrotatoLobbyCtrl:OnTinyGameDataChange(tinyGameData)
  if tinyGameData:IsBrotatoGame() then
    local id = tinyGameData:GetTinyGameId()
    local brotatoData = self.brotatoDataDic[id]
    if brotatoData ~= nil then
      if not brotatoData.isInit then
        brotatoData:InitTinyGame(tinyGameData:GetTinyGameActFrameId())
      end
      brotatoData:SetBrotatoDirty()
      brotatoData:BroadCastBrotatoChange()
    end
  end
end

return ActivityBrotatoLobbyCtrl
