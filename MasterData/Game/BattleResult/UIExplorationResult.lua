local UIExplorationResult = class("UIExplorationResult", UIBaseWindow)
local base = UIBaseWindow
local JumpManager = require("Game.Jump.JumpManager")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local UICommonRewardItem = require("Game.CommonUI.Item.UICommonRewardItem")
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local EpCommonUtil = require("Game.Exploration.Util.EpCommonUtil")
local cs_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
local cs_DoTween = CS.DG.Tweening.DOTween
local HeroData = require("Game.PlayerData.Hero.HeroData")
local SectorEnum = require("Game.Sector.SectorEnum")
local SkinEnum = require("Game.Skin.SkinEnum")
UIExplorationResult.EpResultType = {
  None = 0,
  CompleteEp = 1,
  CompleteEpFloor = 2,
  Fail = 3
}

function UIExplorationResult:OnInit()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.BackAction):PushTopStatusDataToBackStack(true)
  self.sectorNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Sector)
  self.isWin = false
  self.rewardsRecord = {}
  self.rewardList = {}
  self.resloader = cs_ResLoader.Create()
  UIUtil.AddButtonListener(self.ui.btn_Return, self, self.OnReturnClicked)
  UIUtil.AddButtonListener(self.ui.btn_Again, self, self.OnRestartClicked)
  UIUtil.AddButtonListener(self.ui.btn_Detail, self, self.ShowAllChips)
  UIUtil.AddButtonListener(self.ui.btn_ViewAllReward, self, self.ShowAllItems)
  UIUtil.AddButtonListener(self.ui.btn_GoNext, self, self.OnGoNextBtnClicked)
  UIUtil.AddButtonListener(self.ui.btn_Exit, self, self.OnExitBtnClicked)
  UIUtil.AddButtonListener(self.ui.btn_FailGetReward, self, self.OnBtnFailGetReward)
  UIUtil.AddButtonListener(self.ui.btn_GiveUp, self, self.OnBtnFailGiveUp)
  UIUtil.AddButtonListener(self.ui.btn_SuccessSettle, self, self.OnBtnSuccessSettle)
  UIUtil.AddButtonListenerWithArg(self.ui.btn_GotoItem1, self, self.OnClickJump2DefeatAdvise, 1)
  UIUtil.AddButtonListenerWithArg(self.ui.btn_GotoItem2, self, self.OnClickJump2DefeatAdvise, 2)
  UIUtil.AddButtonListener(self.ui.btn_Recomme, self, self.OnClickRecomme)
  UIUtil.AddButtonListener(self.ui.btn_AutoModule, self, self.__OnClickRestartAuto)
  self.ui.btn_Again.gameObject:SetActive(false)
  self.rewardItemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.rewardItem, false)
  self.transRewardItemPool = UIItemPool.New(UICommonRewardItem, self.ui.uINBaseItemWithTrans, false)
  self.ui.rewardItem.gameObject:SetActive(false)
  local recommeCtrl = ControllerManager:GetController(ControllerTypeId.RecommeFormation, true)
  local stageId = self:GetDungeonId()
  if stageId then
    self.ui.btn_Recomme.gameObject:SetActive(recommeCtrl:IsCanReqRecomme(self:GetDungeonId(), false))
  else
    self.ui.btn_Recomme.gameObject:SetActive(false)
  end
  self.__epResultType = UIExplorationResult.EpResultType.None
  self.ui.tex_noReward:SetIndex(0)
end

function UIExplorationResult:IsEpResultType(resultType)
  return self.__epResultType == resultType
end

function UIExplorationResult:SetReturnCallback(callback)
  self.returnCallback = callback
end

function UIExplorationResult:EpResultOverFlowInfo(overflowRewardTurnInfo)
  self.__overflowRewardTurnInfo = overflowRewardTurnInfo
end

function UIExplorationResult:CompleteExploration(rewards, firstClearRewards, needFirsPassReward, resultSettlementData, rewardDic, fixRewardDic)
  AudioManager:PlayAudioById(3009)
  self.rewardsRecord = rewardDic or {}
  local weekExtrReward = ExplorationManager:GetDynPlayer():GetWeekExtrReward() or table.emptytable
  table.merge(self.rewardsRecord, weekExtrReward)
  self.__isWCDouble = ExplorationManager:GetDynPlayer().weekExtrIsDouble
  self.__epResultType = UIExplorationResult.EpResultType.CompleteEp
  self.__enableAutoMode = false
  self.backRewards = rewards or {}
  self.firstClearRewards = firstClearRewards
  self.fixRewardDic = fixRewardDic
  self.isWin = true
  self.resultSettlementData = resultSettlementData
  self:UpdataResultsUI(self.isWin, false, needFirsPassReward)
  self:__PopAddFriend()
end

function UIExplorationResult:CompleteExplorationFloor()
  if ExplorationManager:HasEpRewardBag() then
    self.rewardsRecord = ExplorationManager:GetDynPlayer().dynRewardBag:GetEpRewardBagDataDic()
  else
    self.rewardsRecord = ExplorationManager:GetDynPlayer():GetEpRewardItemDic()
  end
  self.__epResultType = UIExplorationResult.EpResultType.CompleteEpFloor
  self.backRewards = {
    eplGold = ExplorationManager:GetDynPlayer():GetMoneyCount()
  }
  self.isWin = true
  self:UpdataResultsUI(self.isWin, true)
end

function UIExplorationResult:FailExploration(rewards, rewardDic, returnStamina)
  AudioManager:PlayAudioById(3010)
  self.rewardsRecord = rewardDic or {}
  local weekExtrReward = ExplorationManager:GetDynPlayer():GetWeekExtrReward() or table.emptytable
  table.merge(self.rewardsRecord, weekExtrReward)
  self.__epResultType = UIExplorationResult.EpResultType.Fail
  self.backRewards = rewards or {}
  self.isWin = false
  self._returnStamina = returnStamina
  self:UpdataResultsUI(self.isWin)
  local returnStamina, remainLevelCount, costStamina = ExplorationManager:GetReturnStamina()
  self.ui.tex_RePoint:SetIndex(0, tostring(returnStamina))
  self.ui.tex_AgainPoint.text = tostring(costStamina)
  GuideManager:TryTriggerGuide(eGuideCondition.InEpResultFail)
  self:__PopAddFriend()
  self:__RefreshDefeatJump()
end

function UIExplorationResult:__PopAddFriend()
  if ExplorationManager.astAv ~= nil and PlayerDataCenter.friendDataCenter:TryGetFriendData(ExplorationManager.astAv.uid) == nil and not PlayerDataCenter.friendDataCenter:GetIsFriendFull() then
    UIManager:ShowWindowAsync(UIWindowTypeID.MessageSideAddFriend, function(window)
      if window == nil then
        return
      end
      window:InitAddHeroSide(ExplorationManager.astAv.uid, self.resloader)
    end)
  end
end

function UIExplorationResult:BackAction()
  if self.ui.btn_Return.isActiveAndEnabled then
    if self.isWin then
      self:__AfterSettleWin()
    elseif self.returnCallback ~= nil then
      self.returnCallback()
    end
    return
  elseif self.ui.btn_SuccessSettle.isActiveAndEnabled then
    self:OnBtnSuccessSettle()
    return
  elseif self.ui.btn_GoNext.isActiveAndEnabled then
    self:OnGoNextBtnClicked()
    return
  end
  return false
end

function UIExplorationResult:OnReturnClicked()
  UIUtil.OnClickBackByUiTab(self)
end

function UIExplorationResult:OnRestartClicked()
  local moduleId = ExplorationManager:GetEpModuleId()
  local stageCfg = ExplorationManager:GetSectorStageCfg()
  local againCostStamina = stageCfg.cost_strength_num
  if not PlayerDataCenter.sectorEntranceHandler:CheckSectorValid(ExplorationManager:GetEpSectorId()) then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(6033))
    return
  end
  if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration and againCostStamina > PlayerDataCenter.stamina:GetCurrentStamina() then
    JumpManager:Jump(JumpManager.eJumpTarget.BuyStamina)
    return
  elseif moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless and PlayerDataCenter.infinityData:IsInfinityDungeonCompleted(stageCfg.dungeonId) and againCostStamina > PlayerDataCenter.stamina:GetCurrentStamina() then
    JumpManager:Jump(JumpManager.eJumpTarget.BuyStamina)
    return
  end
  ExplorationManager.resultCtrl:ExecuteBattleEndClear()
  ExplorationManager:RestartExploratcion(self.__enableAutoMode)
end

function UIExplorationResult:OnGoNextBtnClicked()
  ExplorationManager:EnterNextSectionExploration()
end

function UIExplorationResult:OnExitBtnClicked()
end

function UIExplorationResult:EpFailNoReward()
end

function UIExplorationResult:OnBtnFailGetReward()
  if self.returnCallback ~= nil then
    self.returnCallback()
  end
end

function UIExplorationResult:OnBtnFailGiveUp()
  local returnStamina, _, costStamina = ExplorationManager:GetReturnStamina()
  if costStamina == 0 then
    if self.returnCallback ~= nil then
      self.returnCallback()
    end
    return
  end
  local msg
  if returnStamina == 0 then
    msg = ConfigData:GetTipContent(TipContent.exploration_Player_ExitExpo)
  else
    msg = string.format(ConfigData:GetTipContent(TipContent.exploration_Player_ExitExpoWithStaminaBack), returnStamina)
  end
  CS.MessageCommon.ShowMessageBox(msg, function()
    if self.returnCallback ~= nil then
      self.returnCallback()
    end
  end, nil, false)
end

function UIExplorationResult:OnBtnSuccessSettle()
  if ExplorationManager:HasEpRewardBag() then
    if self.isWin then
      self:__AfterSettleWin()
    elseif self.returnCallback ~= nil then
      self.returnCallback()
    end
    self:Delete()
  elseif ExplorationManager:GetIsInWeeklyChallenge() then
    if self.isWin then
      self:__AfterSettleWin()
    else
      self:Delete()
      if self.returnCallback ~= nil then
        self.returnCallback()
      end
    end
  else
    if self.isWin then
      self:__AfterSettleWin()
    elseif self.returnCallback ~= nil then
      self.returnCallback()
    end
    self:Delete()
  end
end

function UIExplorationResult:__OnClickRestartAuto()
  self.__enableAutoMode = not self.__enableAutoMode
  self.ui.tex_AutoON:SetActive(self.__enableAutoMode)
  self.ui.tex_AutoOFF:SetActive(not self.__enableAutoMode)
  self.ui.img_AudoSelect:SetIndex(self.__enableAutoMode and 1 or 0)
end

function UIExplorationResult:__ResetAllResultGroup()
  self.ui.normalBtnGroup:SetActive(false)
  self.ui.overBtnGroup:SetActive(false)
  self.ui.failureBtnGroup:SetActive(false)
end

function UIExplorationResult:ShowWCTokenTip()
  if not ExplorationManager:GetIsInWeeklyChallenge() then
    return
  end
  local rewardDic = ExplorationManager:GetDynPlayer():GetWeekExtrReward()
  if rewardDic ~= nil and table.count(rewardDic) > 0 then
    return
  end
  self.ui.noReward:SetActive(true)
  self.ui.tex_noReward:SetIndex(0)
end

function UIExplorationResult:UpdataResultsUI(isWin, isFloor, needFirsPassReward)
  DestroyUnityObject(self.resultBG_Material)
  self.resultBG_Material = nil
  self.resultBG_Material = UIUtil.GetImageMaterial(self.ui.img_ResultBG)
  local resultBG_Material = self.resultBG_Material
  local hasEpRewardBag = ExplorationManager:HasEpRewardBag()
  self:__ResetAllResultGroup()
  isFloor = isFloor or false
  if isWin then
    AudioManager:PlayAudioById(1003)
    self.ui.img_ResultState:SetIndex(0)
    self.ui.tex_ResultState:SetIndex(0)
    self.ui.vectoryNode:SetActive(true)
    self.ui.failureNode:SetActive(false)
    resultBG_Material:SetFloat("_Decoloration", 0)
    self.ui.img_ResultBG.color = self.ui.col_Success
    if EpCommonUtil.IsSupportEpRestart() then
      local stageCfg = ExplorationManager:GetSectorStageCfg()
      local againCostStamina = stageCfg.cost_strength_num
      self.ui.tex_AgainPoint.text = tostring(againCostStamina)
      self.ui.btn_Again.gameObject:SetActive(true)
      local supportAutoMode = EpCommonUtil.IsSupportEpAutoMode()
      if supportAutoMode then
        self.ui.btn_AutoModule.gameObject:SetActive(true)
        self:__OnClickRestartAuto()
      end
    end
  else
    AudioManager:PlayAudioById(1004)
    self.ui.img_ResultState:SetIndex(1)
    self.ui.tex_ResultState:SetIndex(1)
    self.ui.vectoryNode:SetActive(false)
    self.ui.failureNode:SetActive(true)
    resultBG_Material:SetFloat("_Decoloration", 1)
    self.ui.suggestBtn:SetActive(true)
    self.ui.suggestTips:SetActive(false)
    local battleFailJumpUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_BattleFailJump)
    if not battleFailJumpUnlock then
      self.ui.failureNode.gameObject:SetActive(false)
    end
  end
  self.ui.tex_CurLevelLayer.transform.parent.gameObject:SetActive(isFloor)
  if isFloor then
    self.ui.overBtnGroup:SetActive(true)
    self.ui.tex_CurLevelLayer:SetIndex(0, tostring(ExplorationManager:GetCurLevelIndex() + 1))
    self.ui.tex_ResultState:SetIndex(2)
    resultBG_Material:SetFloat("_Decoloration", 0)
    self.ui.img_ResultBG.color = self.ui.col_Over
  end
  self.ui.tex_LevelName.gameObject:SetActive(not isFloor)
  if not isFloor then
    local sectorStageCfg = ExplorationManager:GetSectorStageCfg()
    if sectorStageCfg ~= nil then
      local msg
      if sectorStageCfg.endlessCfg ~= nil then
        msg = ConfigData:GetEndlessInfoMsg(sectorStageCfg.endlessCfg, sectorStageCfg.endlessCfg.index * 10)
      elseif sectorStageCfg.challengeCfg ~= nil then
        local moduleId = ExplorationManager:GetEpModuleId()
        msg = ConfigData:GetChallengeInfoMsg(moduleId)
      else
        msg = ConfigData:GetSectorInfoMsg(sectorStageCfg.sector, sectorStageCfg.num, sectorStageCfg.difficulty)
      end
      self.ui.tex_LevelCount.text = msg
      self.ui.tex_LevelName.text = LanguageUtil.GetLocaleText(sectorStageCfg.name)
    end
  end
  self:ShowReward(isWin, isFloor, needFirsPassReward)
  self:ShowChip()
  self:ShowCoin()
  self:ShowPowerIncrease()
  self:ShowMVP()
  self:ShowGBack()
  if not isFloor then
    if (self._returnStamina or 0) == 0 or isWin then
      self.ui.failureBtnGroup:SetActive(false)
      if hasEpRewardBag then
        local hasReward = 0 < #self.rewardList
        self.ui.normalBtnGroup:SetActive(true)
        self.ui.btn_SuccessSettle.gameObject:SetActive(hasReward)
        self.ui.btn_Return.gameObject:SetActive(not hasReward)
        self.ui.noReward:SetActive(not hasReward)
        self.ui.rewardTips:SetActive(hasReward)
        local dropList = ExplorationManager:GetDynPlayer().dynRewardBag:GetEpRewardBagDataList()
        local hasEpBagDrop = dropList ~= nil and 0 < #dropList
        self.ui.tex_noReward:SetIndex(hasEpBagDrop and 1 or 0)
      else
        self.ui.normalBtnGroup:SetActive(true)
      end
    else
      self.ui.failureBtnGroup:SetActive(true)
      self.ui.tex_GetRewardPoint.text = tostring(self._returnStamina)
      self.ui.tex_RetreatPoint.text = tostring(self._returnStamina)
    end
  end
  self:ShowWCTokenTip()
end

function UIExplorationResult:IsCanShowAth()
  return FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm)
end

function UIExplorationResult:UpdateAthReward()
  if PlayerDataCenter.lastAthDiff ~= nil then
    local athIndex = 0
    for i = 1, #self.rewardList do
      local item = self.rewardList[i]
      local isAthItem = item.itemCfg.type == eItemType.Arithmetic or ConfigData.item.athGiftDic[item.itemCfg.id] ~= nil
      if isAthItem then
        athIndex = athIndex + 1
        local ath = PlayerDataCenter.lastAthDiff[athIndex]
        if ath ~= nil then
          item = {
            num = 1,
            itemCfg = ath.itemCfg,
            isAth = true,
            ath = athData
          }
          self.rewardList[i] = item
          table.remove(PlayerDataCenter.lastAthDiff, #PlayerDataCenter.lastAthDiff)
        end
      end
    end
    PlayerDataCenter.lastAthDiff = nil
    ExplorationManager:RewardSort(self.rewardList)
  end
end

function UIExplorationResult:SetCRTransDic(tranDic)
  self.crTransDic = tranDic
end

function UIExplorationResult:ShowReward(isWin, isFloor, needFirsPassReward)
  local isShowAth = self:IsCanShowAth()
  self.rewardList = {}
  local hasRandomAth = false
  local items = {}
  
  local function addItem(itemId, num)
    local itemCfg = ConfigData.item[itemId]
    local hasAth = ConfigData:IsRewardNotShowATH(itemCfg)
    if hasAth and not isFloor and PlayerDataCenter.lastAthDiff ~= nil then
      hasRandomAth = true
      return
    end
    if not hasAth or isShowAth then
      if items[itemId] ~= nil then
        items[itemId] = items[itemId] + num
      else
        items[itemId] = num
      end
    end
  end
  
  for itemId, num in pairs(self.rewardsRecord) do
    addItem(itemId, num)
  end
  if self.firstClearRewards ~= nil then
    for itemId, num in pairs(self.firstClearRewards) do
      addItem(itemId, num)
    end
  end
  if self.fixRewardDic ~= nil then
    for itemId, num in pairs(self.fixRewardDic) do
      addItem(itemId, num)
    end
  end
  local notShowDic = {
    [eItemActionType.ActExp] = true
  }
  for itemId, itemNum in pairs(items) do
    local itemCfg = ConfigData.item[itemId]
    if itemCfg == nil then
      error("can't get itemCfg with id=" .. tostring(itemId))
    end
    if not notShowDic[itemCfg.action_type] then
      table.insert(self.rewardList, {num = itemNum, itemCfg = itemCfg})
    end
  end
  if hasRandomAth and not isFloor then
    if PlayerDataCenter.lastAthDiff ~= nil then
      for _, athData in ipairs(PlayerDataCenter.lastAthDiff) do
        table.insert(self.rewardList, {
          num = 1,
          itemCfg = athData.itemCfg,
          isAth = true,
          athData = athData
        })
      end
    end
    PlayerDataCenter.lastAthDiff = nil
  end
  ExplorationManager:RewardSort(self.rewardList)
  local containAth = false
  for k, rewardData in ipairs(self.rewardList) do
    if not containAth and rewardData.itemCfg.type == eItemType.Arithmetic then
      containAth = true
    end
    
    local function ClickItemFunc()
      UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
        if win ~= nil then
          win:InitListDetail(self.rewardList, k)
        end
      end)
    end
    
    local itemId = rewardData.itemCfg.id
    if self.__overflowRewardTurnInfo ~= nil and self.__overflowRewardTurnInfo[itemId] ~= nil then
      do
        local turnData = self.__overflowRewardTurnInfo[itemId]
        local transRewardItem = self.transRewardItemPool:GetOne()
        local transIds = {}
        local tansNums = {}
        for key, value in pairs(turnData.product) do
          table.insert(transIds, key)
          table.insert(tansNums, value)
        end
        transRewardItem:SetItemTranNum(turnData.itemNum)
        transRewardItem:SetCommonRewardItemCustomTrans(transIds, tansNums)
        transRewardItem:InitCommonRewardItem(rewardData.itemCfg, rewardData.num, nil, ClickItemFunc)
      end
    else
      local rewardItem = self.rewardItemPool:GetOne()
      rewardItem.ui.obj_isDouble:SetActive(self.__isWCDouble)
      local num = 0
      if self.crTransDic then
        num = self.crTransDic[rewardData.itemCfg.id] or 0
      elseif rewardData.itemCfg.overflow_type == eItemTransType.actMoneyX then
        num = PlayerDataCenter:GetItemOverflowNum(rewardData.itemCfg.id, rewardData.num)
      end
      if num ~= 0 then
        local transItemCfg, trans_num
        if not (#rewardData.itemCfg.overflow_para % 2) == 0 then
          error("this overflow type has error para")
        end
        transItemCfg = ConfigData.item[rewardData.itemCfg.overflow_para[1]]
        trans_num = rewardData.itemCfg.overflow_para[2] * num
        rewardData.itemCfg = transItemCfg
        rewardData.num = trans_num
      end
      rewardItem:InitItemWithCount(rewardData.itemCfg, rewardData.num, ClickItemFunc)
    end
  end
  self.ui.noReward:SetActive(#self.rewardList == 0)
  local rewardSequence = cs_DoTween.Sequence()
  for index, item in ipairs(self.rewardItemPool.listItem) do
    item:SetFade(0)
    rewardSequence:AppendCallback(function()
      if ConfigData.game_config.itemWithGreatFxDic[item.itemCfg.id] then
        item:LoadGetGreatRewardFx(self.resloader, 5)
      else
        item:LoadGetRewardFx(self.resloader, 5)
      end
    end)
    rewardSequence:Append(item:GetFade():DOFade(1, 0.15):SetLink(item.gameObject))
  end
  rewardSequence:SetDelay(0.15)
  rewardSequence:Play()
  if self.rewardSequence ~= nil then
    self.rewardSequence:Kill()
  end
  self.rewardSequence = rewardSequence
  if containAth and #PlayerDataCenter.allAthData:GetAllAthList() >= ConfigData.game_config.athMaxNum then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.Ath_MaxCount))
  end
end

function UIExplorationResult:ShowChip()
  self.chipList = ExplorationManager.epCtrl.dynPlayer:GetChipList()
  local chipNum = 0
  for _, chipData in ipairs(self.chipList) do
    chipNum = chipNum + chipData:GetCount()
  end
  self.ui.tex_ChipCount.text = tostring(chipNum)
  if chipNum <= 0 then
    self.ui.btn_Detail.interactable = false
  else
    self.ui.btn_Detail.interactable = true
  end
end

function UIExplorationResult:ShowCoin()
  local CCNum = ExplorationManager:GetDynPlayer():GetMoneyCount()
  self.ui.tex_MoneyCount.text = tostring(CCNum)
end

function UIExplorationResult:ShowPowerIncrease()
  local newPower = ExplorationManager.epCtrl.dynPlayer:GetTotalFightingPower(true, false)
  local oldPower = ExplorationManager.epCtrl.dynPlayer:GetMirrorTeamFightPower(true, false) or 1
  local increase = (newPower / oldPower - 1) * 100
  increase = 0 < increase and increase or 0
  self.ui.tex_BuffRate:SetIndex(0, GetPreciseDecimalStr(increase, 0))
end

function UIExplorationResult:ShowMVP()
  if not self.isWin then
    return
  end
  if self:_ShowEpSpecialMvp() then
    return
  end
  if ExplorationManager.epMvpData ~= nil then
    local heroId, MvpType, diggestRate = ExplorationManager.epMvpData:GetEpMvpData()
    local heroData = ExplorationManager:GetDynPlayer().heroDic[heroId]
    if heroData == nil then
      local heroCfg = ConfigData.hero_data[heroId]
      heroData = HeroData.New({
        basic = {
          id = heroId,
          level = 1,
          exp = 0,
          star = heroCfg.rank,
          potentialLvl = 0,
          ts = -1,
          career = heroCfg.career,
          company = heroCfg.camp,
          skinId = PlayerDataCenter.skinData:DealNotSelfHaveHeroSkinOverraid(0, heroId)
        }
      })
    end
    ExplorationManager:PlayMVPVoice(heroId)
    self.ui.tex_MvpType:SetIndex(MvpType)
    self.ui.tex_Rate:SetIndex(0, GetPreciseDecimalStr(diggestRate * 100, 0))
    self:_LoadMvpPic(heroData:GetResPicName())
  end
end

function UIExplorationResult:_ShowEpSpecialMvp()
  local epId = ExplorationManager:GetCurExplorationId()
  local epMvpSpecialCfg = ConfigData.ep_mvp_special[epId]
  if epMvpSpecialCfg == nil then
    return false
  end
  self.ui.obj_mvpInfo:SetActive(false)
  self:_LoadMvpPic(epMvpSpecialCfg.lpic)
  return true
end

function UIExplorationResult:_LoadMvpPic(resPicName)
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
  end
  self.bigImgResloader = cs_ResLoader.Create()
  self.bigImgResloader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(resPicName, SkinEnum.fromWhere.mpv), function(prefab)
    DestroyUnityObject(self.bigImgGameObject)
    self.bigImgGameObject = prefab:Instantiate(self.ui.heroBigImgNode)
    local commonPicCtrl = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroList")
  end)
end

function UIExplorationResult:ShowAllChips()
  UIManager:ShowWindowAsync(UIWindowTypeID.ViewChips, function(windows)
    if windows ~= nil then
      self.viewAllChipWin = windows
      if self.chipList ~= nil then
        windows:InitChips(self.chipList, self.resloader)
      end
    end
  end)
end

function UIExplorationResult:ShowAllItems()
  UIManager:ShowWindowAsync(UIWindowTypeID.ViewItems, function(windows)
    if windows ~= nil then
      self.viewAllItemWin = windows
      windows:InitItems(self.rewardList, self.resloader)
    end
  end)
end

function UIExplorationResult:ShowGBack()
  local convertItemId = ConfigData.game_config.epMoneyConvert
  local convertMoney = self.backRewards.exByte or 0
  if 0 < convertMoney then
    local itemCfg = ConfigData.item[convertItemId]
    if itemCfg ~= nil then
      self.ui.img_BackItemIcom.sprite = CRH:GetSprite(itemCfg.small_icon)
      self.ui.Tex_BackCount.text = "+" .. tostring(convertMoney)
      self.ui.resTransformation:SetActive(true)
      return
    end
  end
  self.ui.resTransformation:SetActive(false)
end

function UIExplorationResult:__RefreshDefeatJump()
  local list = table.emptytable
  local sectorIICtrl = ControllerManager:GetController(ControllerTypeId.SectorII)
  if sectorIICtrl ~= nil then
    local stageCfg = ExplorationManager:GetSectorStageCfg()
    if stageCfg ~= nil then
      local sectorId = stageCfg.sector
      local sectorIIData = sectorIICtrl:GetSectorIIDataBySectorId(sectorId)
      if sectorIIData ~= nil then
        list = sectorIIData:GetBeDefeatJumpList()
      end
    end
  end
  local cfg1 = ConfigData.defeat_jump[list[1] or 1]
  local cfg2 = ConfigData.defeat_jump[list[2] or 2]
  self.__defeatJumpCfgList = {cfg1, cfg2}
  self.ui.img_PicGotoItem2.enabled = false
  self.ui.img_PicGotoItem1.enabled = false
  self.resloader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("ExplorationResultFailures"), function(spriteAtlas)
    if spriteAtlas == nil then
      return
    end
    if IsNull(self.transform) then
      return
    end
    self.ui.img_PicGotoItem1.sprite = AtlasUtil.GetResldSprite(spriteAtlas, cfg1.pic_path)
    self.ui.img_PicGotoItem2.sprite = AtlasUtil.GetResldSprite(spriteAtlas, cfg2.pic_path)
    self.ui.img_PicGotoItem2.enabled = true
    self.ui.img_PicGotoItem1.enabled = true
  end)
  self.ui.text_GotoItem1.text = LanguageUtil.GetLocaleText(cfg1.des)
  self.ui.text_GotoItem2.text = LanguageUtil.GetLocaleText(cfg2.des)
end

function UIExplorationResult:OnClickJump2DefeatAdvise(typeIndex)
  ExplorationManager.resultCtrl:ExecuteBattleEndClear()
  ExplorationManager:ExitExploration(Consts.SceneName.Main, function()
    local defeatJumpCfg = self.__defeatJumpCfgList[typeIndex]
    if defeatJumpCfg == nil then
      error("defeatJumpCfg is nil with index " .. tostring(typeIndex))
      return
    end
    local jumpId = defeatJumpCfg.jump_id
    local jumpArg = defeatJumpCfg.jump_arg
    JumpManager:Jump(jumpId, nil, function()
      local aftertTeatmentCtrl = ControllerManager:GetController(ControllerTypeId.BattleResultAftertTeatment)
      if aftertTeatmentCtrl ~= nil then
        aftertTeatmentCtrl:TeatmentBengin()
      end
    end, jumpArg)
  end)
end

function UIExplorationResult:OnClickRecomme()
  PlayerClickCollectManager:BtnClickNumCollect(1007)
  local recommeCtr = ControllerManager:GetController(ControllerTypeId.RecommeFormation, true)
  recommeCtr:ReqRecommeFormationNew(self:GetDungeonId(), false)
  recommeCtr:SetTopStatusHide(true)
end

function UIExplorationResult:GetDungeonId()
  local dungeonId
  local moduleId = ExplorationManager:GetEpModuleId()
  if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration then
    dungeonId = ExplorationManager.stageCfg.id
  elseif moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless then
    dungeonId = ExplorationManager.stageCfg.dungeonId
  end
  return dungeonId
end

function UIExplorationResult:__AfterSettleWin()
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  avgPlayCtrl:TryPlayTaskAvg(2, function()
    if self.returnCallback ~= nil then
      self.returnCallback()
    end
  end)
end

function UIExplorationResult:OnDelete()
  DestroyUnityObject(self.resultBG_Material)
  self.resultBG_Material = nil
  if self.resLoader ~= nil then
    self.resLoader:Put2Pool()
    self.resLoader = nil
  end
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
    self.bigImgResloader = nil
  end
  if self.viewAllChipWin ~= nil then
    self.viewAllChipWin:Delete()
  end
  if self.viewAllItemWin ~= nil then
    self.viewAllItemWin:Delete()
  end
  if self.rewardSequence ~= nil then
    self.rewardSequence:Kill()
    self.rewardSequence = nil
  end
  base.OnDelete(self)
end

return UIExplorationResult
