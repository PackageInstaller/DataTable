local CardSetCtrl = class("CardSetCtrl")
local CS_MessageCommon = CS.MessageCommon
local CardSetEnum = require("Game.CardSet.Data.CardSetEnum")
local CardSetData = require("Game.CardSet.Data.CardSetData")
local FmtEnum = require("Game.Formation.FmtEnum")
local DungeonInterfaceData = require("Game.BattleDungeon.IData.DungeonInterfaceData")
local DungeonCenterUtil = require("Game.DungeonCenter.Util.DungeonCenterUtil")
local util = require("XLua.Common.xlua_util")

function CardSetCtrl:OnInit()
  self.__cardSetActData = nil
  self.__rewardItemId = nil
  self.__scoreItemId = nil
  self.__curSetType = nil
  self.__resloader = nil
  self.cardSetNetWorkCtrl = nil
  self.__OnCardSetDayPass = BindCallback(self, self.OnCardSetDayPass)
  MsgCenter:AddListener(eMsgEventId.OnCardSetRefresh, self.__OnCardSetDayPass)
end

function CardSetCtrl:InitCardSetPlayMode(cardSetActData)
  self.__cardSetActData = cardSetActData
  self.__resloader = CS.ResLoader.Create()
  self.cardSetNetWorkCtrl = NetworkManager:GetNetwork(NetworkTypeID.CardSet)
  self._cardSetDataDic = {}
  for k, setType in pairs(CardSetEnum.eSetType) do
    self._cardSetDataDic[setType] = CardSetData.CreatCardDataSetByAct(self.__cardSetActData, setType)
  end
end

function CardSetCtrl:OnCardSetDayPass()
  for setType, cardSetData in pairs(self._cardSetDataDic) do
    cardSetData:RefreshCardSetData(setType)
  end
  local cardSetWin = UIManager:GetWindow(UIWindowTypeID.CardSet)
  if cardSetWin ~= nil then
    cardSetWin:ResetCardSet()
  end
  local entranceWin = UIManager:GetWindow(UIWindowTypeID.CardSetEntrance)
  if entranceWin ~= nil then
    entranceWin:UpdCardSetEntrance()
  end
end

function CardSetCtrl:OpenCardEntranceUI(isReturn, formActData, closeFunc, battleReturnFunc)
  self._formActData = formActData
  self._battleReturnFunc = battleReturnFunc
  UIManager:ShowWindowAsync(UIWindowTypeID.CardSetEntrance, function(win)
    if win == nil then
      return
    end
    win:InitCardSetEntrance(self, isReturn, closeFunc)
    local guideId = self.__cardSetActData:GetActCardSetMainGuideId()
    GuideManager:StartNewTriggerGuide(guideId)
  end)
end

function CardSetCtrl:OpenCardSetUI(setType, closeCallback)
  self.__curSetType = setType
  UIManager:ShowWindowAsync(UIWindowTypeID.CardSet, function(win)
    if win == nil then
      return
    end
    win:InitCardSet(self, closeCallback)
  end)
end

function CardSetCtrl:TryShowCardSetNewDiffUnlcok(setType)
  local diffList
  if setType == CardSetEnum.eSetType.normal then
    diffList = self.__cardSetActData:GetCardSetNormalModeDiffList()
  elseif setType == CardSetEnum.eSetType.rank then
    diffList = self.__cardSetActData:GetCardSetRankModeDiffList()
  else
    return
  end
  local actId = self.__cardSetActData:GetActId()
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local unlockNewDiffId
  for i = #diffList, 1, -1 do
    local diffId = diffList[i]
    local cfg = ConfigData.activity_card_diff[actId][diffId]
    local isUnlock = CheckCondition.CheckLua(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2, cfg.pre_para3)
    if isUnlock then
      if not saveUserData:GetCardSetDifficultRead(actId, diffId) then
        unlockNewDiffId = diffId
        saveUserData:SetCardSetDifficultRead(actId, diffId)
      end
      break
    end
  end
  if unlockNewDiffId == nil then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CardSetDiffUnlock, function(win)
    if win == nil then
      return
    end
    win:InitCardSetDiffUnlock(diffList, unlockNewDiffId, actId)
  end)
end

function CardSetCtrl:GetCardSetData(setType)
  setType = setType or self.__curSetType
  local carSetData = self._cardSetDataDic[setType]
  return carSetData
end

function CardSetCtrl:GetCdStActData()
  return self.__cardSetActData
end

function CardSetCtrl:SetCardSetPlayType(setType)
  self.__curSetType = setType
end

function CardSetCtrl:GetCardSetPlayType()
  return self.__curSetType
end

function CardSetCtrl:GetCardSetResloader()
  return self.__resloader
end

function CardSetCtrl:SaveCardSetDiffId(cardSetData)
  local actId = self.__cardSetActData:GetActId()
  local playType = cardSetData:GetCardSetCurPlayType()
  local diffId = cardSetData:GetCardSetCurDiffId()
  local rankRoundId = cardSetData:GetCsRankRoundId()
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  saveUserData:SetCardSetLastDiffId(actId, playType, diffId, rankRoundId)
end

function CardSetCtrl:CheckCouldStartBattle(cardSetData)
  for _, eCardType in ipairs(CardSetEnum.showOrder) do
    local needNum = cardSetData:GetCardSetCardUseLeast4Type(eCardType)
    local list = cardSetData:GetSelectedCardListByType(eCardType)
    if needNum > #list then
      return false
    end
  end
  return true
end

function CardSetCtrl:SendCardSelectInfo(cardSetData, callback)
  local actFrameId = self.__cardSetActData:GetActFrameId()
  local data = {}
  local selectedCardListDic = cardSetData:GetSelectedCardListDic()
  for type, list in pairs(selectedCardListDic) do
    for index, cardData in pairs(list) do
      table.insert(data, {
        cardUid = cardData:GetCardSetCardUid(),
        param = cardData:GetCardEffectId()
      })
    end
  end
  local selectCardMsg = {
    data = data,
    difficultyId = cardSetData:GetCardSetCurDiffId()
  }
  local cardCat = cardSetData:GetCardSetCurPlayType()
  local isRankMode = cardCat == CardSetEnum.eSetType.rank
  local roundId
  if isRankMode then
    roundId = cardSetData:GetCsRankRoundId()
  end
  self.cardSetNetWorkCtrl:CS_BATTLE_Card_Select(actFrameId, selectCardMsg, cardCat, roundId, function()
    if callback ~= nil then
      callback()
    end
  end)
end

function CardSetCtrl:CardSetEnterFormation(cardSetData)
  local fmtModule = FmtEnum.eFmtFromModule.CardSet
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, true)
  local lastFmtId = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetLastFromModuleFmtId(fmtModule)
  
  local function enterFunc()
    DungeonCenterUtil.EnterDungeonFormationDeal()
    UIManager:HideWindow(UIWindowTypeID.CardSet)
  end
  
  local function exitFunc(fmtId)
    DungeonCenterUtil.ExitDungeonFormationDeal()
    UIManager:ShowWindowOnly(UIWindowTypeID.CardSet)
  end
  
  local commonBattleFunc
  
  local function startBattleFunc(curSelectFormationData, callBack)
    commonBattleFunc(curSelectFormationData, callBack, cardSetData)
  end
  
  function commonBattleFunc(curSelectFormationData, callBack, cardSetData)
    local curSelectFormationId = curSelectFormationData.id
    local formationData = PlayerDataCenter.formationDic[curSelectFormationId]
    if formationData == nil then
      return
    end
    BattleDungeonManager:SaveFormation(formationData)
    local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    saveUserData:SetLastFromModuleFmtId(fmtModule, curSelectFormationId)
    PersistentManager:SaveModelData(PersistentConfig.ePackage.UserData)
    BattleDungeonManager:InjectBattleExitEvent(function(isWin)
      local LastPlayData = require("Game.Sector.Data.LastPlayData")
      local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")
      local actId = self._formActData and self._formActData:GetActId() or self.__cardSetActData:GetActId()
      local lastPlayData = LastPlayData.New():SetLPDDngeonLevelType(DungeonLevelEnum.DunLevelType.CardSet):SetLPDActId(actId):SetLPDActData(self._formActData or self.__cardSetActData):SetLPDIsWin(isWin == true):SetLPDActSceneLoadoverCallback(self._battleReturnFunc)
      UIManager:GetWindow(UIWindowTypeID.Loading):SetLoadingTipsSystemId(2)
      PlayerDataCenter.sectorEntranceHandler:DealLeftPlayMode2Sector(lastPlayData, nil, nil)
    end)
    local interfaceData = DungeonInterfaceData.CreateCardSetDungeonInterface(cardSetData)
    local actFrameId = self.__cardSetActData:GetActFrameId()
    local dungeonId = self.__cardSetActData:GetCardSetDungeonId()
    local difficulty = cardSetData:GetCardSetCurDiffId()
    local playType = cardSetData:GetCardSetCurPlayType()
    local roundId
    if playType == CardSetEnum.eSetType.rank then
      roundId = cardSetData:GetCsRankRoundId()
      interfaceData:SetDgIAbleFailRestart()
      interfaceData:SetDungeonReplayInfo(startBattleFunc, 0, nil)
    end
    self.cardSetNetWorkCtrl:CS_BATTLE_Card_Enter(actFrameId, dungeonId, difficulty, formationData, playType, roundId, function(dataList)
      if dataList.Count == 0 then
        return
      end
      if callBack ~= nil then
        callBack()
      end
      ControllerManager:DeleteController(ControllerTypeId.ActivityLobbyCtrl)
      ControllerManager:DeleteController(ControllerTypeId.SectorController)
      local NtfEnterMsgData = dataList[0]
      local EnterMsgData
      BattleDungeonManager:RealEnterDungeon(NtfEnterMsgData, EnterMsgData, interfaceData)
      NetworkManager:HandleDiff(NtfEnterMsgData.syncUpdateDiff)
      self.__cardSetActData:SetActCdStLastPlayMode(self.__curSetType)
    end)
  end
  
  local friendSupportOpen = cardSetData:IsCurCardSetDiffFriendSupportOpen()
  local bannedHeroDic = cardSetData:GetCardSetBannedHeroDic()
  local bannedFairyDic = cardSetData:GetCardSetBannedFairyDic()
  local dungeonId = self.__cardSetActData:GetCardSetDungeonId()
  local addReate, point, recommendPow = cardSetData:GenCardSetNum()
  local diffData = cardSetData:GetCardSetCurDiffData()
  local officialSupportId = diffData:GetCardSetOfficialSupportId()
  fmtCtrl:ResetFmtCtrlState()
  fmtCtrl:GetNewEnterFmtData():SetFmtCtrlBaseInfo(fmtModule, dungeonId, lastFmtId):SetFmtCtrlCallback(enterFunc, exitFunc, startBattleFunc):SetCardSetTempBannedHeroDic(bannedHeroDic):SetCardSetTempBannedFairyDic(bannedFairyDic):SetCardSetRecBattlePow(recommendPow):SetCardSetFriendSupportOpen(friendSupportOpen):SetOfficialSupportCfgId(officialSupportId):AddStartBattleCustomCheckFunc("checkCardSet", function(enterFmtData, fmtData)
    local heroIdDic = fmtData:GetFormationHeroDic()
    local bannedHeroDic = enterFmtData:GetCardSetTempBannedHeroDic()
    local supportHeroData = fmtData:GetSupportHeroData()
    for _, heroId in pairs(heroIdDic) do
      if bannedHeroDic ~= nil and bannedHeroDic[heroId] ~= nil and (supportHeroData == nil or supportHeroData.heroId ~= heroId) then
        CS_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(2208))
        return false
      end
    end
    local bannedFairyDic = enterFmtData:GetCardSetTempBannedFairyDic()
    local fairyUid = fmtData:GetFmtFairyUID()
    if bannedFairyDic ~= nil and bannedFairyDic[fairyUid] and fairyUid ~= 0 then
      CS_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(2208))
      return false
    end
    return true
  end)
  fmtCtrl:EnterFormation()
end

function CardSetCtrl:ReqCardSetRoundNext(cardSetData, callback)
  local actFrameId = self.__cardSetActData:GetActFrameId()
  local cardCat = cardSetData:GetCardSetCurPlayType()
  self.cardSetNetWorkCtrl:CS_BATTLE_Card_Round_Next(actFrameId, cardCat, function(objList)
    if callback then
      callback()
    end
    local cardSetWin = UIManager:GetWindow(UIWindowTypeID.CardSet)
    if cardSetWin ~= nil then
      cardSetWin:RefreshAllCard()
    end
    if self.__enterNextRoundCO ~= nil then
      GR.StopCoroutine(self.__enterNextRoundCO)
      self.__enterNextRoundCO = nil
    end
    self.__enterNextRoundCO = GR.StartCoroutine(util.cs_generator(function()
      local isWaiting = false
      if objList.Count ~= 1 then
        error("objList.Count error:" .. tostring(objList.Count))
        return
      end
      local msg = objList[0]
      if not table.IsEmptyTable(msg.reward) then
        isWaiting = true
        local CommonRewardData = require("Game.CommonUI.CommonRewardData")
        local CRData = CommonRewardData.CreateCRDataUseDic(msg.reward):SetCRShowOverFunc(function()
          isWaiting = false
        end)
        UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
          if window == nil then
            return
          end
          window:AddAndTryShowReward(CRData)
        end)
      end
      while isWaiting do
        coroutine.yield(nil)
      end
      if cardSetData:GetCardSetRoundInfo() ~= nil then
        UIManager:ShowWindowAsync(UIWindowTypeID.CardSetRestWithAni, function(win)
          if win == nil then
            return
          end
          isWaiting = true
          win:InitCardRestAni(cardSetData, function()
            isWaiting = false
          end)
        end)
      end
      while isWaiting do
        coroutine.yield(nil)
      end
      self:TryShowCardSetNewDiffUnlcok(cardCat)
      self.__enterNextRoundCO = nil
    end))
  end)
end

function CardSetCtrl:ReqCardSetRewindRoundSelect(round, callback)
  local actFrameId = self.__cardSetActData:GetActFrameId()
  self.cardSetNetWorkCtrl:CS_BATTLE_Card_Round_Select(actFrameId, round, function()
    if callback then
      callback()
    end
  end)
end

function CardSetCtrl:ReqCardSetRewindRoundReset(cardSetData, callback)
  local actFrameId = self.__cardSetActData:GetActFrameId()
  local cardCat = cardSetData:GetCardSetCurPlayType()
  local roundId
  if cardCat == CardSetEnum.eSetType.rank then
    roundId = cardSetData:GetCsRankRoundId()
  end
  self.cardSetNetWorkCtrl:CS_BATTLE_Card_Round_Reset(actFrameId, cardCat, roundId, function()
    if callback then
      callback()
    end
  end)
end

function CardSetCtrl:ReqCardSetRewindRoundOver(callback)
  local actFrameId = self.__cardSetActData:GetActFrameId()
  self.cardSetNetWorkCtrl:CS_BATTLE_Card_Round_Over(actFrameId, function(objList)
    if callback then
      callback()
    end
    UIUtil.ReturnUntil2Marker(UIWindowTypeID.CardSetEntrance, false)
    if objList.Count ~= 1 then
      error("objList.Count error:" .. tostring(objList.Count))
      return
    end
    local msg = objList[0]
    if not table.IsEmptyTable(msg.reward) then
      local CommonRewardData = require("Game.CommonUI.CommonRewardData")
      local CRData = CommonRewardData.CreateCRDataUseDic(msg.reward)
      UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
        if window == nil then
          return
        end
        window:AddAndTryShowReward(CRData)
      end)
    end
  end)
end

function CardSetCtrl:ReqCardSetGetReward(callback)
  if not self.__cardSetActData:IsCsBpCanPickReward() then
    return
  end
  local actFrameId = self.__cardSetActData:GetActFrameId()
  local networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
  networkCtrl:CS_Activity_General_Bp_Reward(actFrameId, nil, callback)
end

function CardSetCtrl:Delete()
  if self.__enterNextRoundCO ~= nil then
    GR.StopCoroutine(self.__enterNextRoundCO)
    self.__enterNextRoundCO = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.OnCardSetRefresh, self.__OnCardSetDayPass)
  if self.__resloader ~= nil then
    self.__resloader:Put2Pool()
    self.__resloader = nil
  end
end

return CardSetCtrl
