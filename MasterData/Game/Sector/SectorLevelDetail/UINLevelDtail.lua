local UINLevelDtail = class("UINLevelDtail", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
local cs_UIMnager = CS.UIManager
local cs_Screen = CS.UnityEngine.Screen
local UINLevelInfgoTypeTog = require("Game.Sector.SectorLevelDetail.UINLevelInfgoTypeTog")
local UINLevelNormalNode = require("Game.Sector.SectorLevelDetail.Nodes.UINLevelNormalNode")
local UINLevelChipNode = require("Game.Sector.SectorLevelDetail.Nodes.UINLevelChipNode")
local UINLevelEnemyNode = require("Game.Sector.SectorLevelDetail.Nodes.UINLevelEnemyNode")
local ChipData = require("Game.PlayerData.Item.ChipData")
local UINStOUnlockConditionItem = require("Game.StrategyOverview.UI.Side.UINStOUnlockConditionItem")
local StageChallengeData = require("Game.StageChallenge.Data.StageChallengeData")
local SectorEnum = require("Game.Sector.SectorEnum")
local FmtEnum = require("Game.Formation.FmtEnum")
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")
local eDetailType = SectorLevelDetailEnum.eDetailType
local eInfoNodeType = SectorLevelDetailEnum.eInfoNodeType
local eTogType = SectorLevelDetailEnum.eTogType
local SpecificHeroDataRuler = require("Game.PlayerData.Hero.SpecificHeroDataRuler")
local util = require("XLua.Common.xlua_util")
local JumpManager = require("Game.Jump.JumpManager")
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local PeridicChallengeEnum = require("Game.PeriodicChallenge.PeridicChallengeEnum")
local UINWeeklyChallengeScoreIntro = require("Game.WeeklyChallenge.UINWeeklyChallengeScoreIntro")
local UINCommonSwitchToggle = require("Game.CommonUI.CommonSwitchToggle.UINCommonSwitchToggle")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local PeridicFmtBuffSelectData = require("Game.PeriodicChallenge.PeridicFmtBuffSelectData")

function UINLevelDtail:OnInit()
  self.detailType = eDetailType.None
  self.__couldNotStatrBattle = false
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Battle, self, self.OnClickBattle)
  UIUtil.AddButtonListener(self.ui.btn_GiveUP, self, self.OnCliCkGiveUpLastEp)
  UIUtil.AddButtonListener(self.ui.btn_ViewAvg, self, self.OnCliCkViewAvg)
  UIUtil.AddButtonListener(self.ui.btn_Blitz, self, self.OnBtnBlitz)
  UIUtil.AddButtonListener(self.ui.btn_Recomme, self, self.OnClickRecomme)
  UIUtil.AddButtonListener(self.ui.Btn_Review, self, self.OnClickStoryReview)
  UIUtil.AddButtonListener(self.ui.btn_Challenge, self, self._OnClickChallenge)
  if not IsNull(self.ui.btn_QuickBattle) then
    UIUtil.AddButtonListener(self.ui.btn_QuickBattle, self, self._OnClickQuickBattle)
    self._colorQuickBattle = self.ui.img_QuickBattle.color
  end
  self.weeklyChallengeScoreIntro = UINWeeklyChallengeScoreIntro.New()
  self.weeklyChallengeScoreIntro:Init(self.ui.logicPreviewNode)
  self._switchChallengeTog = UINCommonSwitchToggle.New()
  self._switchChallengeTog:Init(self.ui.tog_SwitchChallenge)
  self._switchChallengeTog:CommonSwitchTogAutoSetValue(false)
  self._changeChallengeFunc = BindCallback(self, self._OnClickChallengeModeTog)
  self.typeTogPool = UIItemPool.New(UINLevelInfgoTypeTog, self.ui.obj_tog_Type)
  self.ui.obj_tog_Type:SetActive(false)
  self:_ResetInit()
  local NormalInfoNode = UINLevelNormalNode.New()
  NormalInfoNode:Init(self.ui.obj_normalNode)
  local ChipInfoNode = UINLevelChipNode.New()
  ChipInfoNode:Init(self.ui.obj_chipNode)
  local EnemyInfoNode = UINLevelEnemyNode.New()
  EnemyInfoNode:Init(self.ui.obj_enemyNode)
  self.NodeDic = {
    [eInfoNodeType.LevelNormalInfo] = NormalInfoNode,
    [eInfoNodeType.LevelChips] = ChipInfoNode,
    [eInfoNodeType.LevelEnemies] = EnemyInfoNode
  }
  self.SelectedNode = nil
  self:GenTypeTogs()
  self.__onHasUncompletedEp = BindCallback(self, self.UpdateUncompletedEp)
  self.ui.conditionItem:SetActive(false)
  self.conditionItemPool = UIItemPool.New(UINStOUnlockConditionItem, self.ui.conditionItem)
  self.ui.moveTween.onComplete:AddListener(BindCallback(self, self.__OnMoveTweenComplete))
  self.ui.moveTween.onRewind:AddListener(BindCallback(self, self.__OnMoveTweenRewind))
  local position = Vector2.zero
  position.x = self.ui.moveTween.transform.sizeDelta.x + cs_UIMnager.Instance.CurNotchValue / 100 * cs_Screen.width
  self.ui.moveTween.transform.anchoredPosition = position
  self.__isShow = false
  self.__OnChipSetUpdate = BindCallback(self, self.OnChipSetUpdate)
  self:SetLevelDetailActIsFinishUI(false)
end

function UINLevelDtail:InitLevelDtail(resloader)
  self.__resloader = resloader
end

function UINLevelDtail:SetLevelDetailExtrData2Node(levelDetailExtrData)
  self.__levelDetailExtrData = levelDetailExtrData
end

function UINLevelDtail:_ResetInit()
  self.ui.obj_ChallengeNode:SetActive(false)
  if not IsNull(self.ui.btn_QuickBattle) then
    self.ui.btn_QuickBattle.gameObject:SetActive(false)
  end
end

function UINLevelDtail:InitLevelDetailNode(sectorStageCfg, sectorId, isLocked)
  self.detailType = eDetailType.Stage
  self:__InitLevelDetailNode(sectorStageCfg, sectorId, isLocked)
  local recommeCtrl = ControllerManager:GetController(ControllerTypeId.RecommeFormation, true)
  self.ui.btn_Recomme.gameObject:SetActive(recommeCtrl:IsCanReqRecomme(self.stageCfg.id, false))
end

function UINLevelDtail:__InitLevelDetailNode(sectorStageCfg, sectorId, isLocked)
  self.sectorId = sectorId
  self.isLocked = isLocked
  self.stageCfg = sectorStageCfg
  self.challengeId = self.stageCfg.id
  self.ui.tex_Point:SetIndex(0, tostring(self.stageCfg.cost_strength_num))
  self.ui.tex_Power.text = tostring(self.stageCfg.combat)
  if not isLocked then
    local costId = sectorStageCfg.cost_strength_id
    self.ui.img_Ticket.sprite = CRH:GetSpriteByItemId(costId, true)
  end
  self.ui.btn_Blitz.gameObject:SetActive(false)
  self.ui.btn_Battle.gameObject:SetActive(not isLocked)
  self.ui.unlockCondition:SetActive(isLocked)
  self.ui.btn_ViewAvg.gameObject:SetActive(false)
  self.ui.obj_togGroup:SetActive(true)
  self.ui.obj_Power:SetActive(true)
  self:_ResetInit()
  self:PlayMoveTween(true)
  self:UpdateUncompletedEp()
  self:SelectDefaultTog(eInfoNodeType.LevelNormalInfo)
  self:InitChipDataQualityDic(self.detailType)
  self:SendChipSet()
  self.ui.logicPreviewNode.gameObject:SetActive(false)
  if isLocked then
    self:_UpdUnlockCondition(sectorStageCfg.pre_condition, sectorStageCfg.pre_para1, sectorStageCfg.pre_para2)
  end
  self:_InitChallengeMode()
  self:_InitQuickBattle()
end

function UINLevelDtail:InitAvgDetail(avgCfg, playAvgCompleteFunc, sectorId, isLocked)
  self.detailType = eDetailType.Avg
  self.avgCfg = avgCfg
  self.sectorId = sectorId
  self.playAvgCompleteFunc = playAvgCompleteFunc
  self.ui.btn_Blitz.gameObject:SetActive(false)
  self.ui.btn_Battle.gameObject:SetActive(false)
  self.ui.unlockCondition:SetActive(false)
  self.ui.btn_GiveUP.gameObject:SetActive(false)
  self.ui.btn_ViewAvg.gameObject:SetActive(not isLocked)
  self.ui.obj_togGroup:SetActive(false)
  self.ui.obj_Power:SetActive(false)
  self:_ResetInit()
  self:PlayMoveTween(true)
  self:ShowNode(eInfoNodeType.LevelNormalInfo)
  self.ui.btn_Recomme.gameObject:SetActive(false)
  self.ui.logicPreviewNode.gameObject:SetActive(false)
end

function UINLevelDtail:InitInfinityLevelDetailNode(levelData, sectorId)
  self.detailType = eDetailType.Infinity
  self.levelData = levelData
  self.challengeId = levelData.cfg.id
  self.sectorId = sectorId
  self.ui.tex_Point:SetIndex(0, tostring(levelData.cfg.cost_strength_itemNums[1]))
  self.ui.tex_Power.text = tostring(levelData.cfg.combat)
  self.ui.img_Ticket.sprite = CRH:GetDefaultKeySprite()
  self.ui.btn_Blitz.gameObject:SetActive(false)
  self.ui.btn_Battle.gameObject:SetActive(true)
  self.ui.unlockCondition:SetActive(false)
  self.ui.btn_ViewAvg.gameObject:SetActive(false)
  self.ui.obj_togGroup:SetActive(true)
  self.ui.obj_Power:SetActive(true)
  self:_ResetInit()
  self:PlayMoveTween(true)
  self:UpdateUncompletedEp()
  self:SelectDefaultTog(eInfoNodeType.LevelNormalInfo)
  self:InitChipDataQualityDic(self.detailType)
  self:SendChipSet()
  local recommeCtrl = ControllerManager:GetController(ControllerTypeId.RecommeFormation, true)
  self.ui.btn_Recomme.gameObject:SetActive(recommeCtrl:IsCanReqRecomme(self.levelData.cfg.id, false))
  self.ui.logicPreviewNode.gameObject:SetActive(false)
end

function UINLevelDtail:InitPeriodicChallengeDetailNode(challengeId, eChallengeType)
  self.detailType = eDetailType.PeriodicChallenge
  self.sectorId = challengeId
  self.challengeId = challengeId
  self.eChallengeType = eChallengeType
  self:PlayMoveTween(true)
  self:UpdateUncompletedEp()
  self:SelectDefaultTog(eInfoNodeType.LevelNormalInfo)
  self:InitChipDataQualityDic(self.detailType)
  self:SendChipSet()
  self.ui.tex_Point:SetIndex(0, "0")
  self.ui.obj_RecommendPower:SetActive(false)
  self.ui.btn_Recomme.gameObject:SetActive(false)
  self.ui.logicPreviewNode.gameObject:SetActive(false)
end

function UINLevelDtail:InitWeeklyChallengeDetailNode(challengeId, isLocked)
  self.detailType = eDetailType.WeeklyChallenge
  self.sectorId = challengeId
  self.challengeId = challengeId
  self:PlayMoveTween(true)
  if isLocked then
    self.ui.btn_Blitz.gameObject:SetActive(false)
    self.ui.btn_Battle.gameObject:SetActive(false)
    self.ui.unlockCondition:SetActive(false)
    self.ui.btn_ViewAvg.gameObject:SetActive(false)
    self.ui.btn_GiveUP.gameObject:SetActive(false)
  else
    self.ui.img_Ticket.sprite = CRH:GetDefaultKeySprite()
    self.ui.btn_Blitz.gameObject:SetActive(false)
    self.ui.btn_Battle.gameObject:SetActive(true)
    self.ui.btn_ViewAvg.gameObject:SetActive(false)
    self.ui.btn_GiveUP.gameObject:SetActive(false)
    self:UpdateUncompletedEp()
  end
  self:SelectDefaultTog(eInfoNodeType.LevelNormalInfo)
  self:InitChipDataQualityDic(self.detailType)
  self:SendChipSet()
  self.ui.tex_Point:SetIndex(0, "0")
  self.ui.obj_RecommendPower:SetActive(false)
  self.ui.btn_Recomme.gameObject:SetActive(false)
  self.ui.logicPreviewNode.gameObject:SetActive(false)
end

function UINLevelDtail:InitWarchessDetailNode(sectorId, sectroCfg, isLock)
  self.detailType = eDetailType.Warchess
  self:__InitLevelDetailNode(sectroCfg, sectorId, isLock)
  self.ui.btn_Recomme.gameObject:SetActive(false)
end

function UINLevelDtail:InitBrotatoDetailNode(sectroCfg, sectorId, isLock)
  self.detailType = eDetailType.Brotato
  self:__InitLevelDetailNode(sectroCfg, sectorId, isLock)
  self.ui.btn_Recomme.gameObject:SetActive(false)
  self.ui.tex_Point:SetIndex(0, "0")
end

function UINLevelDtail:SetLevelDetailActIsFinishUI(active)
  self.ui.obj_btnGroup:SetActive(not active)
  self.ui.obj_isActFinished:SetActive(active)
end

function UINLevelDtail:GenTypeTogs()
  self.typeTogPool:HideAll()
  for index, infoNodeTypeId in ipairs(eTogType) do
    local togItem = self.typeTogPool:GetOne()
    local isLast = index == #eTogType
    togItem:InitTog(infoNodeTypeId, isLast, function()
      self:ShowNode(infoNodeTypeId)
      if isLast then
        self.ui.img_lastTog.color = self.ui.color_white
      else
        self.ui.img_lastTog.color = self.ui.color_black
      end
      if self.ui.img_ToggleSelected ~= nil then
        self.ui.img_ToggleSelected:SetActive(isLast)
      end
    end)
  end
end

function UINLevelDtail:SelectDefaultTog(infoNodeTypeId)
  for _, item in ipairs(self.typeTogPool.listItem) do
    if item.infoNodeTypeId == infoNodeTypeId then
      if item.ui.tog_Type.isOn then
        self:ShowNode(infoNodeTypeId)
        break
      end
      item.ui.tog_Type.isOn = true
      break
    end
  end
end

function UINLevelDtail:ShowNode(infoNodeTypeId)
  for typeId, NodeItem in pairs(self.NodeDic) do
    if infoNodeTypeId == typeId then
      NodeItem:Show()
      NodeItem:InitInfoNode(self, self.chipDataQualityDic, self.__resloader)
      self.SelectedNode = NodeItem
    else
      NodeItem:Hide()
    end
  end
end

function UINLevelDtail:RefreshDtailNormalNode()
  local node = self.NodeDic[eInfoNodeType.LevelNormalInfo]
  if node ~= nil and node.active then
    node:InitInfoNode(self, self.chipDataQualityDic, self.__resloader)
  end
end

function UINLevelDtail:ShowWeeklyScoreIntro()
  self.weeklyChallengeScoreIntro:Show()
  self.weeklyChallengeScoreIntro:InitWeeklyScoreIntro(self.challengeId)
end

function UINLevelDtail:InitChipDataQualityDic(detailType)
  local moduleId
  if detailType == SectorLevelDetailEnum.eDetailType.Stage then
    moduleId = proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration
  elseif detailType == SectorLevelDetailEnum.eDetailType.Infinity then
    moduleId = proto_csmsg_SystemFunctionID.SystemFunctionID_Endless
  elseif detailType == SectorLevelDetailEnum.eDetailType.PeriodicChallenge then
    moduleId = proto_csmsg_SystemFunctionID.SystemFunctionID_DailyChallenge
  elseif detailType == SectorLevelDetailEnum.eDetailType.WeeklyChallenge then
    moduleId = proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge
  elseif detailType == SectorLevelDetailEnum.eDetailType.Warchess then
    moduleId = proto_csmsg_SystemFunctionID.SystemFunctionID_WarChess
  end
  local chip_dic = SectorStageDetailHelper.GetChipPreviewByEpModuleId(moduleId, self.challengeId, self.eChallengeType)
  self.chipDataQualityDic = {}
  local chipData
  for itemId, v in pairs(chip_dic) do
    local level
    if type(v) == "number" then
      level = v
    end
    chipData = ChipData.NewChipForLocal(itemId, level)
    if detailType == SectorLevelDetailEnum.eDetailType.WeeklyChallenge then
      chipData.isLock = false
    else
      chipData.isLock = true
    end
    if self.chipDataQualityDic[chipData:GetQuality()] == nil then
      self.chipDataQualityDic[chipData:GetQuality()] = {}
      table.insert(self.chipDataQualityDic[chipData:GetQuality()], chipData)
    else
      table.insert(self.chipDataQualityDic[chipData:GetQuality()], chipData)
    end
  end
end

function UINLevelDtail:OnChipSetUpdate(chipSetTab)
  for _, list in pairs(self.chipDataQualityDic) do
    for index, chipData in ipairs(list) do
      if chipSetTab[chipData.dataId] ~= nil then
        chipData.isLock = false
      end
    end
  end
end

function UINLevelDtail:SendChipSet()
  self.networkContrl = NetworkManager:GetNetwork(NetworkTypeID.Sector)
  self.networkContrl:SendChipSet()
end

function UINLevelDtail:UpdateUncompletedEp()
  if self.detailType ~= eDetailType.Stage and self.detailType ~= eDetailType.Infinity and self.detailType ~= eDetailType.PeriodicChallenge and self.detailType ~= eDetailType.WeeklyChallenge and self.detailType ~= eDetailType.Warchess and self.detailType ~= eDetailType.Brotato then
    return
  end
  self._playMoudle = 0
  if self.detailType == eDetailType.PeriodicChallenge or self.detailType == eDetailType.WeeklyChallenge then
    self._playMoudle = SectorStageDetailHelper.PlayMoudleType.Ep
  else
    self._playMoudle = SectorStageDetailHelper.SectorPlayMoudle(self.sectorId)
  end
  if self._playMoudle == 0 then
    if isGameDev then
      error("playMoudle not find")
    end
    return
  end
  self.__lastEpStateCfg = SectorStageDetailHelper.TryGetUncompletedStateCfg(self._playMoudle)
  self:RefreshBattleButton()
  self:ShowNode(eInfoNodeType.LevelNormalInfo)
  if self.detailType == eDetailType.Stage or self.detailType == eDetailType.Warchess then
    self:_InitChallengeMode()
  end
end

function UINLevelDtail:RefreshEpBattleButton()
  self.ui.obj_point:SetActive(false)
  if ExplorationManager:WaitGetLastRoomEpRewardBag() then
    self.ui.btn_GiveUP.gameObject:SetActive(false)
    self.ui.tex_Battle:SetIndex(3)
  else
    local isUnlockBattleExit = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_BattleExit)
    local _, _, _, canFloorOver = SectorStageDetailHelper.HasUnCompleteStage(self._playMoudle)
    self.ui.btn_GiveUP.gameObject:SetActive(isUnlockBattleExit and not canFloorOver)
    self.ui.tex_Battle:SetIndex(1)
  end
end

function UINLevelDtail:RefreshBattleButton()
  if self.__lastEpStateCfg == nil then
    self.ui.btn_GiveUP.gameObject:SetActive(false)
    self.ui.obj_point:SetActive(true)
    if self.detailType == eDetailType.Infinity then
      local infinittLevelId = self.levelData.cfg.id
      if PlayerDataCenter.infinityData:IsInfinityDungeonCompleted(infinittLevelId) then
        self.ui.tex_Battle:SetIndex(2)
        if FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_EndlessAuto) then
          self.ui.btn_Blitz.gameObject:SetActive(true)
        end
      elseif PlayerDataCenter.infinityData:GetInfinityDungeonProcess(infinittLevelId) ~= nil then
        self.ui.tex_Battle:SetIndex(2)
      else
        self.ui.tex_Battle:SetIndex(0)
      end
    else
      self.ui.tex_Battle:SetIndex(0)
    end
  elseif self._playMoudle == SectorStageDetailHelper.PlayMoudleType.Ep then
    self:RefreshEpBattleButton()
  elseif self._playMoudle == SectorStageDetailHelper.PlayMoudleType.EpMixWarchess then
    local _, _, mouldId, canFloorOver = SectorStageDetailHelper.HasUnCompleteStage(self._playMoudle)
    if mouldId == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration then
      self:RefreshEpBattleButton()
    else
      self.ui.btn_GiveUP.gameObject:SetActive(false)
      self.ui.tex_Battle:SetIndex(1)
    end
  else
    self.ui.btn_GiveUP.gameObject:SetActive(false)
    self.ui.tex_Battle:SetIndex(1)
  end
end

function UINLevelDtail:SetCouldReviewStoryList(storyIdList, storySubTitleList)
  local isOpne = storyIdList ~= nil and 0 < #storyIdList
  self.ui.Btn_Review.gameObject:SetActive(isOpne)
  self.__storyIdList = storyIdList
  self.__storySubTitleList = storySubTitleList
end

function UINLevelDtail:OnClickBattle()
  if self.__couldNotStatrBattle then
    return
  end
  if self.__lastEpStateCfg ~= nil then
    if ExplorationManager:WaitGetLastRoomEpRewardBag() then
      ExplorationManager:GiveUpLastExploration()
      MsgCenter:Broadcast(eMsgEventId.StageOutPickReward)
    else
      if self.__customEnterFmtCallback ~= nil then
        self.__customEnterFmtCallback(nil)
      end
      if self.__customBattleStartCallback then
        self.__customBattleStartCallback()
      end
      SectorStageDetailHelper.ContinueUncompleteStage(self._playMoudle)
    end
    return
  end
  self._enterFmtCo = GR.StartCoroutine(util.cs_generator(BindCallback(self, self.__EnterFormationCo)))
end

function UINLevelDtail:__EnterFormationCo()
  local waitMsgBox = false
  local staminaOk = true
  local hasShopDrop = false
  if self.detailType == eDetailType.Stage then
    hasShopDrop = self.stageCfg.hasShopDrop
  elseif self.detailType == eDetailType.Infinity then
    hasShopDrop = self.levelData.cfg.hasShopDrop
  end
  if hasShopDrop then
    local curStamina = PlayerDataCenter.stamina:GetCurrentStamina()
    if curStamina < ConfigData.game_config.staminaWarnNum then
      waitMsgBox = true
      staminaOk = false
      local staminaCeiling = PlayerDataCenter.stamina:GetStaminaCeiling()
      local msg = string.format(ConfigData:GetTipContent(751), curStamina, staminaCeiling)
      local msgWindow = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
      msgWindow:ShowTextBoxWithYesAndNo(msg, function()
        waitMsgBox = false
        staminaOk = true
      end, function()
        waitMsgBox = false
      end)
    end
  end
  while waitMsgBox do
    coroutine.yield(nil)
  end
  if not staminaOk then
    self._enterFmtCo = nil
    return
  end
  local infinity50Ok = true
  if self.detailType == eDetailType.Infinity then
    local levelData = self.levelData
    if levelData.isUnlock and not levelData.isComplete and levelData.cfg.index % SectorEnum.InfinityGroup ~= 0 and PlayerDataCenter.cacheSaveData:GetEnableConfirmInfinityNot50() then
      infinity50Ok = false
      waitMsgBox = true
      local msgWindow = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
      msgWindow:ShowTextBoxWithYesAndNo(ConfigData:GetTipContent(375), function()
        infinity50Ok = true
        waitMsgBox = false
      end, function()
        waitMsgBox = false
      end)
      msgWindow:ShowDontRemindTog(function(isOn)
        PlayerDataCenter.cacheSaveData:SetEnableConfirmInfinityNot50(not isOn)
      end)
    end
  end
  while waitMsgBox do
    coroutine.yield(nil)
  end
  if not infinity50Ok then
    self._enterFmtCo = nil
    return
  end
  self:__EnterBattleFormation()
  self._enterFmtCo = nil
end

function UINLevelDtail:IsRunningEnterFmtCo()
  return self._enterFmtCo ~= nil
end

function UINLevelDtail:SetDetailNodeCustomEnterFmtCallback(callback)
  self.__customEnterFmtCallback = callback
end

function UINLevelDtail:SetDetailNodeExBattleStartCallback(callback)
  self.__customBattleStartCallback = callback
end

function UINLevelDtail:SetDetailNodeSelectCanEnterCallback(callback)
  self.__selectCanEnterCallback = callback
end

function UINLevelDtail:SetDetailCloseCallUICallback(callBack)
  self.__CloseCallUICallback = callBack
end

function UINLevelDtail:SetDetailReopenCallUICallback(callBack)
  self.__ReopenCallUICallback = callBack
end

function UINLevelDtail:__EnterBattleFormation()
  local function enterFunc()
    if self.detailType == eDetailType.Warchess then
      local costId = self.stageCfg.cost_strength_id
      
      if PlayerDataCenter:GetItemCount(costId) < self.stageCfg.cost_strength_num then
        cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(165))
        return
      end
      if self.__customEnterFmtCallback ~= nil then
        self.__customEnterFmtCallback(nil)
      end
      if self.__customBattleStartCallback then
        self.__customBattleStartCallback()
      end
      WarChessManager:EnterWarChessBySectorStageId(self.stageCfg.id, self._stgChallengeData)
      if self._stgChallengeData ~= nil then
        self._stgChallengeData:TrySaveStgChallengeTask()
      end
      return
    end
    local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, true)
    fmtCtrl:ResetFmtCtrlState()
    local enterFmtData = fmtCtrl:GetNewEnterFmtData()
    if self.__customEnterFmtCallback ~= nil then
      self.__customEnterFmtCallback(enterFmtData)
    end
    
    local function enterFunc()
      UIManager:HideWindow(UIWindowTypeID.SectorEntrance)
      UIManager:HideWindow(UIWindowTypeID.SectorLevel)
      UIManager:HideWindow(UIWindowTypeID.SectorLevelDetail)
      UIManager:HideWindow(UIWindowTypeID.DailyChallenge)
      UIManager:HideWindow(UIWindowTypeID.ActivityWinterMainMap)
      if self.__CloseCallUICallback ~= nil then
        self.__CloseCallUICallback()
      end
    end
    
    local function exitFunc()
      UIManager:ShowWindowOnly(UIWindowTypeID.SectorEntrance)
      UIManager:ShowWindowOnly(UIWindowTypeID.SectorLevel)
      UIManager:ShowWindowOnly(UIWindowTypeID.SectorLevelDetail)
      UIManager:ShowWindowOnly(UIWindowTypeID.DailyChallenge)
      UIManager:ShowWindowOnly(UIWindowTypeID.ActivityWinterMainMap)
      if self.__ReopenCallUICallback ~= nil then
        self.__ReopenCallUICallback()
      end
      if self._stgChallengeData ~= nil then
        self._switchChallengeTog:SetCommonSwitchToggleValue(self._stgChallengeData:IsStageChallengeOpen())
        self:_UpdClgRewardNumPrewview()
      end
    end
    
    local function startBattleFunc(curSelectFormationData, callBack)
      local curSelectFormationId = curSelectFormationData.id
      if self.detailType == eDetailType.Stage and PlayerDataCenter.stamina:GetCurrentStamina() < self.stageCfg.cost_strength_num then
        JumpManager:Jump(JumpManager.eJumpTarget.BuyStamina)
        return
      elseif self.detailType == eDetailType.Infinity and PlayerDataCenter.stamina:GetCurrentStamina() < self.levelData.cfg.cost_strength_itemNums[1] then
        JumpManager:Jump(JumpManager.eJumpTarget.BuyStamina)
        return
      elseif self.detailType == eDetailType.PeriodicChallenge then
      elseif self.detailType == eDetailType.PeriodicChallenge then
      end
      if self.__customBattleStartCallback then
        self.__customBattleStartCallback()
      end
      local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
      local isFixedFmt = enterFmtData:IsFmtCtrlFiexd()
      if self.detailType == eDetailType.Stage then
        local stgChallengeData = enterFmtData:GetFmtChallengeModeData()
        local isChallengeMode = stgChallengeData ~= nil and stgChallengeData:IsStageChallengeOpen()
        local challengeTaskIdList = isChallengeMode and stgChallengeData:GetStgClgOptionalTaskOpenList() or nil
        local isEzModel = #self.stageCfg.assist_buff > 0 and not isChallengeMode
        if isEzModel then
          local timePassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass, true)
          local failEpCounter = timePassCtrl:getCounterElemData(proto_object_CounterModule.CounterModuleEplFailTimes, self.stageCfg.id)
          isEzModel = failEpCounter ~= nil and failEpCounter.times >= ConfigData.game_config.ezModeTarget
        end
        if isEzModel then
          local totalFtPower, totalBenchPower = fmtCtrl:CalculatePower(curSelectFormationData)
          cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(391), function()
            ExplorationManager:ReqEnterExploration(self.stageCfg.id, curSelectFormationId, proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration, true, callBack, curSelectFormationData:GetSupportHeroData(), nil, nil, totalFtPower, totalBenchPower)
          end, function()
            ExplorationManager:ReqEnterExploration(self.stageCfg.id, curSelectFormationId, proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration, false, callBack, curSelectFormationData:GetSupportHeroData(), nil, nil, totalFtPower, totalBenchPower)
          end)
        else
          local totalFtPower, totalBenchPower = fmtCtrl:CalculatePower(curSelectFormationData)
          ExplorationManager:ReqEnterExploration(self.stageCfg.id, curSelectFormationId, proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration, false, callBack, curSelectFormationData:GetSupportHeroData(), isChallengeMode, challengeTaskIdList, totalFtPower, totalBenchPower)
        end
        if stgChallengeData ~= nil then
          stgChallengeData:TrySaveStgChallengeTask()
        end
      elseif self.detailType == eDetailType.Infinity then
        local totalFtPower, totalBenchPower = fmtCtrl:CalculatePower(curSelectFormationData)
        ExplorationManager:ReqEnterExploration(self.levelData.cfg.id, curSelectFormationId, proto_csmsg_SystemFunctionID.SystemFunctionID_Endless, false, callBack, curSelectFormationData:GetSupportHeroData(), nil, nil, totalFtPower, totalBenchPower)
      elseif self.detailType == eDetailType.PeriodicChallenge then
        ExplorationManager:ReqEnterChallengeExploration(curSelectFormationId, callBack)
      elseif self.detailType == eDetailType.WeeklyChallenge then
        local totalFtPower, totalBenchPower = fmtCtrl:CalculatePower(enterFmtData:GetFmtCtrlVirtualFmtData().formation)
        ExplorationManager:ReqEnterWeeklyExploration(self.challengeId, enterFmtData:GetFmtCtrlVirtualFmtData(), callBack, totalFtPower, totalBenchPower)
      elseif self.detailType == eDetailType.Brotato then
        local selectBuffIds
        local enterFmtData = fmtCtrl:GetCurEnterFmtData()
        if enterFmtData ~= nil then
          local buffSelectData = enterFmtData:GetPeridicFmtBuffSelect()
          if buffSelectData ~= nil then
            selectBuffIds = buffSelectData:GetFmtBuffSelect()
          end
        end
        local totalFtPower, totalBenchPower = fmtCtrl:CalculatePower(curSelectFormationData)
        ExplorationManager:ReqEnterExploration(self.stageCfg.id, curSelectFormationId, proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration, false, callBack, curSelectFormationData:GetSupportHeroData(), nil, nil, totalFtPower, totalBenchPower, selectBuffIds)
      end
      if self.detailType == eDetailType.WeeklyChallenge then
        local _, wcType = enterFmtData:IsWCFormation()
        saveUserData:SetLastWeeklyChallengeFmt(wcType, enterFmtData:GetFmtCtrlVirtualFmtData().formation.data)
      elseif self.detailType == eDetailType.Brotato then
        saveUserData:SetLastFromModuleFmtId(FmtEnum.eFmtFromModule.Brotato, curSelectFormationId)
      elseif not isFixedFmt then
        saveUserData:SetLastFormationId(self.sectorId, curSelectFormationId, self.stageCfg and self.stageCfg.id)
      end
      PersistentManager:SaveModelData(PersistentConfig.ePackage.UserData)
    end
    
    local lastFmtId = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetLastFormationId(self.sectorId, self.stageCfg and self.stageCfg.id)
    local chipDataList
    if self.chipDataQualityDic ~= nil and table.count(self.chipDataQualityDic) > 0 then
      chipDataList = {}
      for k, v in pairs(self.chipDataQualityDic) do
        for i, chipData in ipairs(v) do
          table.insert(chipDataList, chipData)
        end
      end
    end
    if self.detailType == eDetailType.Stage then
      enterFmtData:SetFmtCtrlBaseInfo(FmtEnum.eFmtFromModule.SectorLevel, self.stageCfg.id, lastFmtId):SetFmtCtrlCallback(enterFunc, exitFunc, startBattleFunc):SetEnterBattleCostTicketNum(self.stageCfg.cost_strength_num):SetFmtCtrlChipDataList(chipDataList):SetOfficialSupportCfgId(self.stageCfg.official_assist):SetFmtRecommendCfg(self.stageCfg.recommend_hero, self.stageCfg.recommend_team, self.stageCfg.recommend_skill)
      if PlayerDataCenter.sectorAchievementDatas:HasStageChallengeTask(self.stageCfg.id) then
        self._SetChallengeModeFunc = self._SetChallengeModeFunc or BindCallback(self, self._SetChallengeModeOpen)
        enterFmtData:SetFmtCtrlChallengeData(true, self._SetChallengeModeFunc, self._stgChallengeData)
      end
      fmtCtrl:EnterFormation()
    elseif self.detailType == eDetailType.Infinity then
      local staminaCost = self.levelData.cfg.cost_strength_itemNums[1]
      enterFmtData:SetFmtCtrlBaseInfo(FmtEnum.eFmtFromModule.Infinity, self.levelData.cfg.id, lastFmtId):SetFmtCtrlCallback(enterFunc, exitFunc, startBattleFunc):SetEnterBattleCostTicketNum(staminaCost):SetFmtCtrlChipDataList(chipDataList)
      fmtCtrl:EnterFormation()
    elseif self.detailType == eDetailType.PeriodicChallenge then
      local challengeCfg = ConfigData.daily_challenge[self.challengeId]
      local specificHeroDataRuler = SpecificHeroDataRuler.ctorWithChallengeCfg(challengeCfg)
      enterFmtData:SetFmtCtrlBaseInfo(FmtEnum.eFmtFromModule.PeriodicChallenge, nil, lastFmtId):SetSpecificHeroDataRuler(specificHeroDataRuler):SetFmtCtrlCallback(enterFunc, exitFunc, startBattleFunc):SetEnterBattleCostTicketNum(0):SetFmtCtrlChipDataList(chipDataList):SetIsOpenChangeFmt(false)
      fmtCtrl:EnterFormation()
    elseif self.detailType == eDetailType.WeeklyChallenge then
      local weeklyData = PlayerDataCenter.allWeeklyChallengeData.dataDic[self.challengeId]
      local challengeCfg = weeklyData.cfg
      local specificHeroDataRuler = SpecificHeroDataRuler.ctorWithWeeklyChallengeCfg(challengeCfg, weeklyData)
      local fmtBuffSelectData = weeklyData:GetFmtBuffSelectData()
      enterFmtData:SetFmtCtrlBaseInfo(FmtEnum.eFmtFromModule.WeeklyChallenge, weeklyData.id, lastFmtId):SetSpecificHeroDataRuler(specificHeroDataRuler):SetFmtCtrlCallback(enterFunc, exitFunc, startBattleFunc):SetEnterBattleCostTicketNum(0):SetFmtCtrlChipDataList(chipDataList):SetIsOpenChangeFmt(false):SetIsOpenBuffSelect(true):SetPeridicFmtBuffSelect(fmtBuffSelectData):SetIsShowTotalPow(false)
      fmtCtrl:EnterFormation()
    elseif self.detailType == eDetailType.Brotato then
      lastFmtId = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetLastFromModuleFmtId(FmtEnum.eFmtFromModule.Brotato)
      local fmtBuffSelectData = PeridicFmtBuffSelectData.CreateFmtBuffByBrotato(self.stageCfg.id)
      local chaggengeCfg = ConfigData.brotato_challenge[self.stageCfg.id]
      local fmtRuleCfg
      local ruleId = chaggengeCfg.formation_rule_id
      if 0 < ruleId then
        fmtRuleCfg = ConfigData.formation_rule[ruleId]
      end
      local isNeedSpcificHero = chaggengeCfg.hero_list ~= nil and 0 < #chaggengeCfg.hero_list
      fmtCtrl:ResetFmtCtrlState()
      local fmtData = fmtCtrl:GetNewEnterFmtData():SetFmtCtrlBaseInfo(FmtEnum.eFmtFromModule.Brotato, self.stageCfg.id, lastFmtId):SetFmtCtrlCallback(enterFunc, exitFunc, startBattleFunc):SetIsOpenBuffSelect(true):SetPeridicFmtBuffSelect(fmtBuffSelectData):SetIsShowNotEditNormalObj(false):SetFmtIsBrotatoDeploy(true):SetFormationRuleCfg(fmtRuleCfg):SetIsOpenChangeFmt(false):SetOfficialSupportCfgId(self.stageCfg.official_assist):SetNeedCheckFormationData(true):SetFmtBrotatoNeedBanNotSelf(isNeedSpcificHero):SetFmtBrotatoCanUseOfficialData(not isNeedSpcificHero)
      if isNeedSpcificHero then
        local specificHeroDataRuler = SpecificHeroDataRuler.ctorWithBrotatoChallenge(self.stageCfg.id)
        fmtData:SetSpecificHeroDataRuler(specificHeroDataRuler)
      end
      fmtCtrl:EnterFormation()
    end
  end
  
  if self.__selectCanEnterCallback then
    self.__selectCanEnterCallback(self.stageCfg.id, enterFunc)
    return
  end
  enterFunc()
end

function UINLevelDtail:OnCliCkGiveUpLastEp()
  SectorStageDetailHelper.GiveupStageLevel(self._playMoudle)
end

function UINLevelDtail:OnCliCkViewAvg()
  if self.__couldNotStatrBattle then
    return
  end
  UIUtil.ForceOnClickBack()
  
  local function playFunc()
    ControllerManager:GetController(ControllerTypeId.Avg, true):StartAvg(self.avgCfg.script_id, self.avgCfg.id, function()
      AvgUtil.ShowMainCamera(true)
      if IsNull(self.transform) then
        return
      end
      self.playAvgCompleteFunc()
      self:ShowNode(eInfoNodeType.LevelNormalInfo)
    end)
    AvgUtil.ShowMainCamera(false)
  end
  
  local popTipId = self:TryGetAvgTip()
  if 0 < (popTipId or 0) then
    CS.MessageCommon.ShowMessageBox(ConfigData:GetTipContent(popTipId), function()
      playFunc()
    end, nil)
  else
    playFunc()
  end
end

function UINLevelDtail:TryGetAvgTip()
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  if self.avgCfg.type == eAvgTriggerType.AvgSector then
    local isHaveUnread = avgPlayCtrl:IsPlayedAllMainAvg4AllAvgSector(self.avgCfg.set_place, self.avgCfg.id, true) ~= 0
    if isHaveUnread then
      return TipContent.NormalAVG_Tip
    end
    return
  end
  local stageId = self.avgCfg.set_place
  local popTipId
  if stageId == nil then
    return nil
  end
  local stageCfg = ConfigData.sector_stage[stageId]
  if stageCfg == nil then
    return nil
  end
  if stageCfg.difficulty == ExplorationEnum.eDifficultType.Hard and avgPlayCtrl:IsAvgUnlock(self.avgCfg.id) and not avgPlayCtrl:IsAvgPlayed(self.avgCfg.id) then
    if avgPlayCtrl:IsPlayedAllMainAvg(stageCfg.sector, ExplorationEnum.eDifficultType.Normal, self.avgCfg.id) ~= 0 then
      return TipContent.HardAVG_Tip
    elseif avgPlayCtrl:IsPlayedAllMainAvg(stageCfg.sector, stageCfg.difficulty, self.avgCfg.id) ~= 0 then
      return TipContent.NormalAVG_Tip
    end
  end
  if stageCfg.difficulty == ExplorationEnum.eDifficultType.Normal and avgPlayCtrl:IsAvgUnlock(self.avgCfg.id) and not avgPlayCtrl:IsAvgPlayed(self.avgCfg.id) and avgPlayCtrl:IsPlayedAllMainAvg(stageCfg.sector, stageCfg.difficulty, self.avgCfg.id, true) ~= 0 then
    return TipContent.NormalAVG_Tip
  end
  return nil
end

function UINLevelDtail:OnBtnBlitz()
  local costId1 = self.levelData.cfg.cost_strength_itemIds[1]
  local costNum1 = self.levelData.cfg.cost_strength_itemNums[1]
  local costId2, costNum2
  local extraCondition = true
  if self.levelData.cfg.blitz_cost_id ~= nil then
    costId2 = self.levelData.cfg.blitz_cost_id
    costNum2 = self.levelData.cfg.blitz_cost_num
    extraCondition = costNum2 <= PlayerDataCenter:GetItemCount(costId2)
  end
  if costNum1 <= PlayerDataCenter.stamina:GetCurrentStamina() and extraCondition then
    local window = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
    if costId2 ~= nil then
      local msg = string.format(ConfigData:GetTipContent(290), ConfigData:GetItemName(costId1) .. "," .. ConfigData:GetItemName(costId2))
      window:ShowItemCost2(msg, costId1, costNum1, costId2, costNum2, function()
        NetworkManager:GetNetwork(NetworkTypeID.Object):CS_BLITZ_Blitz(self.levelData.cfg.id)
      end)
    else
      local msg = string.format(ConfigData:GetTipContent(290), ConfigData:GetItemName(costId1))
      window:ShowItemCost(msg, costId1, costNum1, function()
        NetworkManager:GetNetwork(NetworkTypeID.Object):CS_BLITZ_Blitz(self.levelData.cfg.id)
      end)
    end
  else
    local msg = string.format(ConfigData:GetTipContent(252))
    local window = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
    if costId2 ~= nil then
      window:ShowItemCost2Confirm(msg, costId1, costNum1, costId2, costNum2)
    else
      window:ShowItemCostConfirm(msg, costId1, costNum1)
    end
  end
end

function UINLevelDtail:OnClickRecomme()
  local recommeCtrl = ControllerManager:GetController(ControllerTypeId.RecommeFormation, true)
  if self.detailType == eDetailType.Stage then
    recommeCtrl:ReqRecommeFormationNew(self.stageCfg.id, false)
  else
    recommeCtrl:ReqRecommeFormationNew(self.levelData.cfg.id, false)
  end
  recommeCtrl:SetTopStatusHide(false)
end

function UINLevelDtail:OnClickStoryReview()
  local win = UIManager:ShowWindow(UIWindowTypeID.SectorStoryReview)
  win:InitSectorStoryReview(self.__storyIdList, self.__storySubTitleList)
end

function UINLevelDtail:GetNLevelDetailWidthAndDuration()
  return self.transform.sizeDelta.x, self.ui.moveTween.duration
end

function UINLevelDtail:CloseLvDetailNodeShowAudio()
  self._closeShowAudio = true
end

function UINLevelDtail:PlayMoveTween(isShow)
  if isShow then
    if self.__isHiding then
      self.ui.moveTween:DORewind()
    end
    if self.__isShow then
      return
    end
    UIManager:ShowWindow(UIWindowTypeID.SectorLevelDetail)
    self.__isShow = true
    self.ui.moveTween:DOPlayForward()
    if not self._closeShowAudio then
      if self.detailType == eDetailType.Stage then
        AudioManager:PlayAudioById(1033)
      elseif self.detailType == eDetailType.Avg then
        AudioManager:PlayAudioById(1035)
      end
    end
  else
    self.ui.moveTween:DOPlayBackwards()
    self.__isHiding = true
    if self.detailType == eDetailType.Stage then
      AudioManager:PlayAudioById(1034)
    elseif self.detailType == eDetailType.Avg then
      AudioManager:PlayAudioById(1036)
    end
  end
  UIUtil.AddOneCover("LevelDetailTween")
end

function UINLevelDtail:__OnMoveTweenComplete()
  UIUtil.CloseOneCover("LevelDetailTween")
  if self.SelectedNode.ForceRefresh ~= nil then
    self.SelectedNode:ForceRefresh()
  end
end

function UINLevelDtail:__OnMoveTweenRewind()
  UIUtil.CloseOneCover("LevelDetailTween")
  self.__isHiding = false
  UIManager:HideWindow(UIWindowTypeID.SectorLevelDetail)
  self.__isShow = false
end

function UINLevelDtail:_UpdUnlockCondition(...)
  local unlockInfoList = CheckCondition.GetUnlockAndInfoList(...)
  self.conditionItemPool:HideAll()
  for k, condition in ipairs(unlockInfoList) do
    local conditionItem = self.conditionItemPool:GetOne()
    conditionItem:InitStOUnlockConditionItem(condition.unlock, condition.lockReason)
  end
end

function UINLevelDtail:_InitChallengeMode()
  self._stgChallengeData = nil
  if self.__lastEpStateCfg ~= nil or self.isLocked then
    return
  end
  if not PlayerDataCenter.sectorAchievementDatas:HasStageChallengeTask(self.stageCfg.id) then
    return
  end
  self.ui.img_LockChallenge.enabled = not PlayerDataCenter.sectorAchievementDatas:IsStageChallengeTaskOpen(self.stageCfg.id)
  local sectorCfg = ConfigData.sector[self.stageCfg.sector]
  self.ui.obj_ChallengeNode:SetActive(true)
  self._stgChallengeData = StageChallengeData.Create(self.stageCfg.id)
  local isChallengeMode = false
  if PlayerDataCenter.sectorAchievementDatas:IsStageChallengeTaskOpen(self.stageCfg.id) then
    local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    isChallengeMode = saveUserData:GetChallengeStageSwitch(self.stageCfg.id)
  else
  end
  self._stgChallengeData:SetStageChallengeOpen(isChallengeMode)
  self._switchChallengeTog:InitCommonSwitchToggle(isChallengeMode, self._changeChallengeFunc)
  self:_ShowChallengeTask(isChallengeMode, self.stageCfg)
  self:RefreshBattleButton()
  self:_UpdClgRewardNumPrewview()
end

function UINLevelDtail:_OnClickChallenge()
  if self:_CheckChallegeIsNotOpen() then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.FmtChallengeInfo, function(win)
    if win == nil then
      return
    end
    win:InitFmtChallengeInfo(self._stgChallengeData, function()
      if self._stgChallengeData:IsStageChallengeOpen() then
        self:_UpdClgRewardNumPrewview()
        return
      end
      self:_SetChallengeModeOpen(true)
    end)
  end)
end

function UINLevelDtail:_CheckChallegeIsNotOpen()
  if not PlayerDataCenter.sectorAchievementDatas:IsStageChallengeTaskOpen(self.stageCfg.id) then
    UIManager:ShowWindowAsync(UIWindowTypeID.MessageCommon, function(win)
      if win == nil then
        return
      end
      local msg = PlayerDataCenter.sectorAchievementDatas:GetStageChallengeTaskOpenDes(self.stageCfg.id)
      win:ShowTextBoxWithConfirm(msg, nil)
    end)
    return true
  end
  return false
end

function UINLevelDtail:_OnClickChallengeModeTog(isChallengeMode)
  if self:_CheckChallegeIsNotOpen() then
    return
  end
  self:_SetChallengeModeOpen(isChallengeMode)
  if isChallengeMode then
    UIManager:ShowWindowAsync(UIWindowTypeID.FmtChallengeInfo, function(win)
      if win == nil then
        return
      end
      win:InitFmtChallengeInfo(self._stgChallengeData, function()
        self:_UpdClgRewardNumPrewview()
      end)
    end)
  end
end

function UINLevelDtail:_SetChallengeModeOpen(isChallengeMode)
  if self._stgChallengeData:IsStageChallengeOpen() == isChallengeMode then
    return
  end
  self._stgChallengeData:SetStageChallengeOpen(isChallengeMode)
  self._switchChallengeTog:SetCommonSwitchToggleValue(isChallengeMode)
  self:_ShowChallengeTask(isChallengeMode, self.stageCfg)
  self:RefreshBattleButton()
  self:_UpdClgRewardNumPrewview()
end

function UINLevelDtail:LvDetailIsChallengeMode()
  return self._stgChallengeData and self._stgChallengeData:IsStageChallengeOpen()
end

function UINLevelDtail:_ShowChallengeTask(isChallengeMode, stageCfg)
  local node = self.NodeDic[eInfoNodeType.LevelNormalInfo]
  if node ~= nil then
    node:ShowLvNormalChallengeTask(isChallengeMode, stageCfg)
  end
end

function UINLevelDtail:SetShowAdditionBuffList(buffList)
  self.__additionalBuffList = buffList
end

function UINLevelDtail:GetShowAdditionBuffList()
  return self.__additionalBuffList
end

function UINLevelDtail:_UpdClgRewardNumPrewview()
  if self._stgChallengeData == nil then
    return
  end
  local rewardNum = self._stgChallengeData:GetStgChallengeTaskRewardNum()
  if 0 < rewardNum then
    self.ui.obj_ClgReward:SetActive(true)
    self.ui.tex_ClgRewardNum:SetIndex(0, tostring(rewardNum))
  else
    self.ui.obj_ClgReward:SetActive(false)
  end
end

function UINLevelDtail:_InitQuickBattle()
  if self.isLocked then
    return
  end
  if IsNull(self.ui.btn_QuickBattle) then
    return
  end
  if not self.stageCfg.quick_battle then
    return
  end
  self.ui.btn_QuickBattle.gameObject:SetActive(true)
  local unlock = self:_IsQuickBattleUnlock()
  self.ui.img_QuickBattle.color = unlock and self._colorQuickBattle or self.ui.color_lockQuickBattle
end

function UINLevelDtail:_IsQuickBattleUnlock()
  return self._stgChallengeData and self._stgChallengeData:IsStgAllChallengeTaskComplete()
end

function UINLevelDtail:_OnClickQuickBattle()
  if not self:_IsQuickBattleUnlock() then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(2906))
    return
  end
  local needKey = self.stageCfg.cost_strength_num
  if needKey > PlayerDataCenter.stamina:GetCurrentStamina() then
    JumpManager:Jump(JumpManager.eJumpTarget.BuyStamina)
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.Sector_LackOfStamina))
    return
  end
  ExplorationManager:ReqEnterExplorationQuickBattle(self.stageCfg.id, nil, proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration, false, nil, nil, false, nil, self.stageCfg)
end

function UINLevelDtail:OnShow()
  base.OnShow(self)
  if self.__addListener then
    return
  end
  MsgCenter:AddListener(eMsgEventId.OnHasUncompletedEp, self.__onHasUncompletedEp)
  MsgCenter:AddListener(eMsgEventId.SectorChipSet, self.__OnChipSetUpdate)
  self.__addListener = true
end

function UINLevelDtail:OnHide()
  UIUtil.CloseOneCover("LevelDetailTween")
  if not self.__addListener then
    return
  end
  MsgCenter:RemoveListener(eMsgEventId.OnHasUncompletedEp, self.__onHasUncompletedEp)
  MsgCenter:RemoveListener(eMsgEventId.SectorChipSet, self.__OnChipSetUpdate)
  self.__addListener = false
end

function UINLevelDtail:OnDelete()
  for _, NodeItem in pairs(self.NodeDic) do
    NodeItem:Delete()
  end
  if self._enterFmtCo ~= nil then
    GR.StopCoroutine(self._enterFmtCo)
    self._enterFmtCo = nil
  end
  self._switchChallengeTog:Delete()
  self.conditionItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINLevelDtail
