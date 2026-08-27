local UIDungeonBase = class("UIDungeonBase", UIBaseWindow)
local base = UIBaseWindow
local UIDungeonChapterList = require("Game.CommonUI.DungeonPanelWidgets.UIDungeonChapterList")
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
local UINDungeonMultRateBase = require("Game.CommonUI.DungeonPanelWidgets.UINDungeonMultRateBase")
local DungeonInterfaceData = require("Game.BattleDungeon.IData.DungeonInterfaceData")
local FmtEnum = require("Game.Formation.FmtEnum")
local cs_MessageCommon = CS.MessageCommon
local cs_ResLoader = CS.ResLoader
local CS_GSceneManager_Ins = CS.GSceneManager.Instance
local util = require("XLua.Common.xlua_util")
local JumpManager = require("Game.Jump.JumpManager")

function UIDungeonBase:OnInit()
  self.resLoader = cs_ResLoader.Create()
  UIUtil.SetTopStatus(self, self.OnBack, table.emptytable)
  self.__onBattleStart = BindCallback(self, self.OnBattleStart)
  self.__onItemClick = BindCallback(self, self.OnSelectItemEvent)
  self.__onDailyLimitUpdate = BindCallback(self, self.OnDailyLimitUpdate)
  MsgCenter:AddListener(eMsgEventId.OnBattleDungeonLimitChange, self.__onDailyLimitUpdate)
  MsgCenter:AddListener(eMsgEventId.MonthCardRefresh, self.__onDailyLimitUpdate)
  MsgCenter:AddListener(eMsgEventId.DungeonQuickBatteEnd, self.__onDailyLimitUpdate)
  if self.ui.btn_isDoubleInfo ~= nil then
    UIUtil.AddButtonListener(self.ui.btn_isDoubleInfo, self, self.OnClickDungeonDoubleInfo)
  end
  self.dungeonItemDic = {}
  self.selectDungeonData = nil
  self.selectDungeonItem = nil
  self.dungeonTypeUIEnum = nil
  self.__DungeonTimerId = TimerManager:StartTimer(1, self.OnTimerUpdate, self, false, nil, nil)
  self._UpdStageRedDotFunc = BindCallback(self, self._UpdStageRedDot)
  RedDotController:AddListener(RedDotDynPath.SctDgStagePath, self._UpdStageRedDotFunc)
end

function UIDungeonBase:OnShow()
  base.OnShow(self)
  AudioManager:PlayAudioById(1088)
  if self.chaptersUI then
    self.chaptersUI:OnShow()
  end
end

function UIDungeonBase:InitDungeonType(dungeonTypeData, selectdungeonId, onBackCallback)
  self.dungeonTypeData = dungeonTypeData
  self.dungeonDataList = dungeonTypeData:GetDungeonDataList()
  if onBackCallback ~= nil then
    self.onBackCallback = onBackCallback
  end
  self:InitDungeonList()
  if selectdungeonId ~= nil then
    for _, dungeonData in ipairs(self.dungeonDataList) do
      if dungeonData:GetIsUnlock() and dungeonData:GetDungeonId() == selectdungeonId then
        self.selectDungeonData = dungeonData
        break
      end
    end
  end
  if self.selectDungeonData == nil then
    for _, dungeonData in ipairs(self.dungeonDataList) do
      if dungeonData:GetIsUnlock() then
        self.selectDungeonData = dungeonData
        break
      end
    end
  end
  self.selectDungeonItem = self.dungeonItemDic[self.selectDungeonData]
  self:ShowDungeonDetail(self.selectDungeonItem)
end

function UIDungeonBase:OnDailyLimitUpdate()
  for dungeonData, dungeonItem in pairs(self.dungeonItemDic) do
    if dungeonItem ~= nil then
      dungeonData:CleanCacheData()
      dungeonItem:UpdateDailyLimit()
    end
  end
  self:ShowDungeonDetail(self.selectDungeonItem)
end

function UIDungeonBase:InitDungeonList(UIDungeonItemClass)
  self.dungeonItemPool = UIItemPool.New(UIDungeonItemClass, self.ui.tog_DungeonItem)
  self.ui.tog_DungeonItem:SetActive(false)
  for _, dungeonData in ipairs(self.dungeonDataList) do
    if dungeonData ~= nil then
      local item = self.dungeonItemPool:GetOne()
      item:InitDungeonItem(dungeonData, self.resLoader, self.__onItemClick)
      self.dungeonItemDic[dungeonData] = item
    end
  end
end

function UIDungeonBase:OnSelectItemEvent(item)
  self.selectDungeonItem:OnSelectDisplay(false)
  self.selectDungeonData = item.dungeonData
  self.selectDungeonItem = self.dungeonItemDic[self.selectDungeonData]
  local auId = item.dungeonData:GetDungeonCfg().click_audio
  if auId ~= 0 then
    AudioManager:PlayAudioById(auId)
  end
  self:ShowDungeonDetail(item)
end

function UIDungeonBase:ShowDungeonDetail(item)
  if item.dungeonData:GetIsHaveMultReward() then
    if self.multRateBase == nil then
      self.multRateBase = UINDungeonMultRateBase.New()
      self.multRateBase:Init(self.ui.isDoubleOrDropUp)
    end
    self.multRateBase:Show()
    self.multRateBase:InitMultRate(item.dungeonData)
    self:__SetDoubleInfoActive(false)
  else
    if self.multRateBase ~= nil then
      self.multRateBase:Hide()
    else
      self.ui.isDoubleOrDropUp:SetActive(false)
    end
    self:__SetDoubleInfoActive(item.dungeonData:IsDungeonHasDoubleReward())
  end
  self:InitDungeonStages(item.dungeonData)
  item:OnSelectDisplay(true)
end

function UIDungeonBase:__SetDoubleInfoActive(active)
  if self.ui.btn_isDoubleInfo ~= nil then
    self.ui.btn_isDoubleInfo.gameObject:SetActive(active)
  end
end

function UIDungeonBase:OnClickDungeonDoubleInfo()
  if self.selectDungeonData == nil then
    return
  end
  local dungeonCfg = self.selectDungeonData:GetDungeonCfg()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
    if window == nil then
      return
    end
    window:InitDungeonDropInfo(dungeonCfg.ui_type)
  end)
end

function UIDungeonBase:InitDungeonStages(dungeonData, UIDungeonStageClass)
  local resource_top = {}
  for k, v in pairs(dungeonData:GetDungeonCfg().resource_top) do
    resource_top[k] = v
  end
  table.insert(resource_top, ConstGlobalItem.SKey)
  if not self.active then
    return
  end
  UIUtil.RefreshTopResId(resource_top)
  if self.chaptersUI == nil then
    self.chaptersUI = UIDungeonChapterList.New()
    self.chaptersUI:Init(self.ui.levelRewardNode)
  end
  if self.dungeonStageItemPool == nil or self.fstRewardItemPool == nil or self.mbRewardItemPool == nil then
    self.dungeonStageItemPool, self.fstRewardItemPool, self.mbRewardItemPool = self.chaptersUI:CreatePool(UIDungeonStageClass, UINBaseItem, UINBaseItem)
  end
  self.dungeonStageItemPool:HideAll()
  self.fstRewardItemPool:HideAll()
  self.mbRewardItemPool:HideAll()
  self._stageItemDic = {}
  for index, dungeonStageData in ipairs(dungeonData:GetDungeonStageList()) do
    local item = self.dungeonStageItemPool:GetOne()
    item:InitWithStageData(dungeonStageData, index, self.fstRewardItemPool, self.mbRewardItemPool)
    local dungeonType = dungeonData.dungeonTypeData.dungeonType
    local dungeonId = dungeonData.dungeonId
    local dungeonStageId = dungeonStageData:GetDungeonStageId()
    local ok, dgStageNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.SectorEntrance, RedDotStaticTypeId.SectorEntranceSrcDun, dungeonType, dungeonId, dungeonStageId)
    item:ShowDungeonStageItemBlueDot(ok and dgStageNode:GetBlueDotCount() > 0)
    self._stageItemDic[dungeonStageId] = item
  end
  self:RegularDungeonStageSpace(#self.dungeonStageItemPool.listItem)
  self.chaptersUI:UpdateWithChapterList(self.dungeonStageItemPool.listItem, dungeonData, self.__onBattleStart)
end

local spacingDic = {
  [6] = 84.5,
  [8] = 15.5
}

function UIDungeonBase:RegularDungeonStageSpace(num)
  local space = spacingDic[num]
  if space == nil then
    local a = spacingDic[8] - spacingDic[6] / 2
    local b = spacingDic[6] - a * 6
    space = a * num + b
  end
  self.chaptersUI.ui.layout_Level.spacing = space
end

function UIDungeonBase:OnBattleStart(autoBattleCount, stgChallengeData)
  self.dungeonStageItem = self.chaptersUI.selectChapterItem
  local dungeonData = self.selectDungeonData
  local dungeonStageData = self.dungeonStageItem.dungeonStageData
  if dungeonStageData:IsHaveATHReward() and #PlayerDataCenter.allAthData:GetAllAthList() >= ConfigData.game_config.athMaxNum then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Ath_MaxCount))
    return
  end
  if dungeonData:GetDungeonPlayLeftLimitNum() == 0 then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.BattleDungeon_DailyLimit))
    return
  end
  if dungeonStageData:GetIsReach2Limit() then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.BattleDungeon_DailyLimit))
    return
  end
  for id, count in pairs(dungeonStageData:GetNormalCostItemDic()) do
    if id ~= ConstGlobalItem.SKey and count ~= nil and 0 < count then
      local itemNum = PlayerDataCenter:GetItemCount(id)
      if count > itemNum then
        cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.Item_NotReach))
        return
      end
    end
  end
  
  local function enterFormationFunc()
    UIManager:HideWindow(self.dungeonTypeUIEnum)
    UIManager:HideWindow(UIWindowTypeID.SectorEntrance)
  end
  
  local function exitFormationFunc()
    UIManager:ShowWindowOnly(self.dungeonTypeUIEnum)
    UIManager:ShowWindowOnly(UIWindowTypeID.SectorEntrance)
    if BattleDungeonManager.autoCtrl:IsEnbaleDungeonAutoMode() then
      BattleDungeonManager.autoCtrl:ExitDungeonAutoModel()
      BattleDungeonManager.autoCtrl:DungeonAutoReset()
    end
  end
  
  local startBattleFunc
  
  function startBattleFunc(curSelectFormationData, callBack)
    if dungeonStageData:IsHaveATHReward() and #PlayerDataCenter.allAthData:GetAllAthList() >= ConfigData.game_config.athMaxNum then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Ath_MaxCount))
      return
    end
    if PlayerDataCenter.stamina:GetCurrentStamina() < dungeonStageData:GetStaminaCost() then
      JumpManager:Jump(JumpManager.eJumpTarget.BuyStamina)
      return
    end
    local curSelectFormationId = curSelectFormationData.id
    local formationData = PlayerDataCenter.formationDic[curSelectFormationId]
    if formationData == nil then
      return
    end
    BattleDungeonManager:SaveFormation(formationData)
    local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    saveUserData:SetLastFormationId(dungeonData:GetDungeonId(), curSelectFormationId)
    saveUserData:SetLastDungeonStageId(dungeonData:GetDungeonId(), dungeonStageData:GetDungeonStageId())
    PersistentManager:SaveModelData(PersistentConfig.ePackage.UserData)
    local afterBattleWinEvent = BindCallback(self, self.AfterBattleWin, self.dungeonStageItem, self.selectDungeonItem)
    BattleDungeonManager:InjectBattleWinEvent(afterBattleWinEvent)
    self.__startDungeonBattleTS = PlayerDataCenter.timestamp
    BattleDungeonManager:InjectBattleExitEvent(BindCallback(self, function(isWin)
      local LastPlayData = require("Game.Sector.Data.LastPlayData")
      local lastPlayData = LastPlayData.New():SetLPDDngeonType(self.dungeonTypeData.dungeonType):SetLPDExtraData({
        lastSelectMatDungeonId4LPDExtra = dungeonData:GetDungeonId()
      }):SetLPDIsWin(isWin == true):SetLPDActSceneLoadoverCallback(function()
        local aftertTeatmentCtrl = ControllerManager:GetController(ControllerTypeId.BattleResultAftertTeatment)
        if aftertTeatmentCtrl ~= nil then
          aftertTeatmentCtrl:TeatmentBengin()
        end
      end)
      UIManager:GetWindow(UIWindowTypeID.Loading):SetLoadingTipsSystemId(2)
      PlayerDataCenter.sectorEntranceHandler:DealLeftPlayMode2Sector(lastPlayData, nil, nil)
    end, self.selectItemId))
    local interfaceData = DungeonInterfaceData.CreateDefaultBattleInterface()
    interfaceData:BindDungeonStageData(dungeonStageData, startBattleFunc)
    interfaceData:SetDIDExtraDrop(self:GetDgDropBuffActive())
    interfaceData:SetAutoDecompose(self:GetDecomposeActive())
    interfaceData:SetDgInterfaceStgChallengeData(stgChallengeData)
    local firstPower, benchPower
    local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, false)
    if fmtCtrl ~= nil then
      firstPower, benchPower = fmtCtrl:CalculatePower(formationData)
    end
    BattleDungeonManager:RequestEnterDungeon(self.dungeonStageItem.cfg.id, formationData, interfaceData, function()
      ControllerManager:DeleteController(ControllerTypeId.SectorController)
      if callBack ~= nil then
        callBack()
      end
    end, firstPower, benchPower)
  end
  
  local function firstEnterStartBattleFunc(curSelectFormationData, callBack)
    if dungeonStageData:IsHaveATHReward() and #PlayerDataCenter.allAthData:GetAllAthList() >= ConfigData.game_config.athMaxNum - ConfigData.game_config.athSpaceNotEnoughNum then
      cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(145), function()
        startBattleFunc(curSelectFormationData, callBack)
      end, nil)
    else
      startBattleFunc(curSelectFormationData, callBack)
    end
  end
  
  self:EnterFormation(dungeonData, enterFormationFunc, exitFormationFunc, firstEnterStartBattleFunc, autoBattleCount, stgChallengeData)
  if stgChallengeData ~= nil then
    stgChallengeData:TrySaveStgChallengeTask()
  end
end

function UIDungeonBase:SetDgDropBuffActive(dungeonType, active)
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  saveUserData:SetDungeonDropBuffActive(dungeonType, active)
end

function UIDungeonBase:GetDgDropBuffActive()
  local dungeonCfg = self.selectDungeonData:GetDungeonCfg()
  local dungeonType = dungeonCfg.dungeon_type
  local dropId = ConfigData.battle_dungeon_period_drop.dgTypeDic[dungeonCfg.dungeon_type]
  if dropId == nil then
    return false
  end
  local dropCfg = ConfigData.battle_dungeon_period_drop[dropId]
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local counterElem = ControllerManager:GetController(ControllerTypeId.TimePass):getCounterElemData(proto_object_CounterModule.CounterModuleGlobalDailyFlush, 0)
  if counterElem ~= nil then
    local nextExpiredTm = counterElem.nextExpiredTm
    local lastResetTm = saveUserData:GetDungeonDropBuffLastResetTm()
    if nextExpiredTm > lastResetTm then
      saveUserData:SetDungeonDropBuffLastResetTm(nextExpiredTm)
      saveUserData:SetDungeonDropBuffActive(dungeonType, false)
    end
  end
  local useNum = ControllerManager:GetController(ControllerTypeId.TimePass):GetDungeonPeriodDropTimes(dropCfg.save_id)
  local numAdd = PlayerDataCenter.playerBonus:GetDungeonDropNumAdd(dropId)
  local remainNum = dropCfg.drop_times + numAdd - useNum
  if remainNum <= 0 then
    return false
  end
  return saveUserData:GetDungeonDropBuffActive(dungeonType)
end

function UIDungeonBase:SetDecomposeActive(active)
  if self:GetDecomposeActive() ~= active then
    PlayerDataCenter.gameSettingData:SetGSSetting(GameSettingConsts.autoDecoAth, active)
  end
end

function UIDungeonBase:GetDecomposeActive()
  local setting = PlayerDataCenter.gameSettingData:GetSetting()
  if setting == nil then
    return false
  end
  return setting[GameSettingConsts.autoDecoAth] or false
end

function UIDungeonBase:EnterFormation(dungeonData, enterFormationFunc, exitFormationFunc, startBattleFunc, autoBattleCount, stgChallengeData)
  local forbidSupport = 0 < (autoBattleCount or 0)
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, true)
  local lastFmtId = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetLastFormationId(dungeonData:GetDungeonId())
  if 0 < (autoBattleCount or 0) then
    BattleDungeonManager.autoCtrl:EnterDungeonAutoModel(autoBattleCount)
  end
  fmtCtrl:ResetFmtCtrlState()
  local enterFmtData = fmtCtrl:GetNewEnterFmtData():SetFmtCtrlBaseInfo(FmtEnum.eFmtFromModule.MaterialDungeon, self.dungeonStageItem.cfg.id, lastFmtId):SetFmtCtrlCallback(enterFormationFunc, exitFormationFunc, startBattleFunc):SetEnterBattleCostTicketNum(self.dungeonStageItem.costStrengthNum):SetFmtForbidSupport(forbidSupport)
  if stgChallengeData then
    enterFmtData:SetFmtCtrlChallengeData(true, nil, stgChallengeData)
  end
  fmtCtrl:EnterFormation()
end

function UIDungeonBase:AfterBattleWin(dungeonStageItem, selectDungeonItem, hasSupport)
  PlayerDataCenter:LocallyAddDungeonLimit(selectDungeonItem.dungeonData:GetDungeonId(), dungeonStageItem.chapterId, hasSupport, self.__startDungeonBattleTS)
  self.dungeonTypeData:UpdateDungeonAndStageUnlock()
end

function UIDungeonBase:OnTimerUpdate()
  if self.multRateBase ~= nil and self.multRateBase.active then
    self.multRateBase:UpdateLeftTime()
  end
end

function UIDungeonBase:_UpdStageRedDot(node)
  local nodeDgStageId = node.nodeId
  local item = self._stageItemDic[nodeDgStageId]
  if item then
    item:ShowDungeonStageItemBlueDot(node:GetBlueDotCount() > 0)
  end
end

function UIDungeonBase:OnBack(toHome)
  if self.onBackCallback ~= nil then
    self.onBackCallback(toHome)
  end
  base.Delete(self)
end

function UIDungeonBase:OnDelete()
  RedDotController:RemoveListener(RedDotDynPath.SctDgStagePath, self._UpdStageRedDotFunc)
  MsgCenter:RemoveListener(eMsgEventId.OnBattleDungeonLimitChange, self.__onDailyLimitUpdate)
  MsgCenter:RemoveListener(eMsgEventId.MonthCardRefresh, self.__onDailyLimitUpdate)
  MsgCenter:RemoveListener(eMsgEventId.DungeonQuickBatteEnd, self.__onDailyLimitUpdate)
  if self.__DungeonTimerId ~= nil then
    TimerManager:StopTimer(self.__DungeonTimerId)
    self.__DungeonTimerId = nil
  end
  if self.__loadDungeonCoroutine ~= nil and self.StartLoadDungeon then
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    GR.StopCoroutine(self.__loadDungeonCoroutine)
    self.StartLoadDungeon = false
    self.__loadDungeonCoroutine = nil
  end
  if self.resLoader ~= nil then
    self.resLoader:Put2Pool()
  end
  if self.chaptersUI ~= nil then
    self.chaptersUI:Delete()
  end
  PersistentManager:SaveModelData(PersistentConfig.ePackage.UserData)
  local saveDataController = ControllerManager:GetController(ControllerTypeId.Setting, true)
  saveDataController:TryReqSaveGameSettingData()
  base.OnDelete(self)
end

return UIDungeonBase
