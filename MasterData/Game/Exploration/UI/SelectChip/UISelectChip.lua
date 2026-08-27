local UISelectChip = class("UISelectChip", UIBaseWindow)
local base = UIBaseWindow
local UISelectChipItem = require("Game.Exploration.UI.Base.UISelectChipItem")
local cs_GameObject = CS.UnityEngine.GameObject
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local cs_MessageCommon = CS.MessageCommon
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")
local EpStoreRoomUtil = require("Game.Exploration.Util.EpStoreRoomUtil")
local REFRESH_CHIP_UID = 4294967300

function UISelectChip:OnInit()
  UIUtil.SetTopStatus(self, self.StartGiveUpLogic, nil, nil, nil, true)
  self.__OnChipDetailActiveChange = BindCallback(self, self.OnChipDetailActiveChange)
  MsgCenter:AddListener(eMsgEventId.OnDungeonDetailWinChange, self.__OnChipDetailActiveChange)
  UIUtil.AddButtonListener(self.ui.btn_return, self, self.__OnClickSkipButton)
  UIUtil.AddButtonListener(self.ui.btn_Refresh, self, self.__ClickRefresh)
  UIUtil.AddButtonListener(self.ui.btn_CampBondSkill, self, self.__OnClickActiveCampFetter)
  UIUtil.AddButtonListener(self.ui.btn_Skip, self, self.OnClickGiveup)
  UIUtil.AddButtonListener(self.ui.btn_Map, self, self.OnClickMap)
  self.ui.propChipItem:SetActive(false)
  self.__ShowDungeonState = BindCallback(self, self.ShowDungeonState)
  MsgCenter:AddListener(eMsgEventId.OnSettleMentTimeLinePlayToEnd, self.__ShowDungeonState)
  self.selectChipItemPool = UIItemPool.New(UISelectChipItem, self.ui.propChipItem)
  self.__onMoneyUpdate = BindCallback(self, self.OnUpdateRemainRefreshInfo)
  MsgCenter:AddListener(eMsgEventId.EpMoneyChange, self.__onMoneyUpdate)
  if BattleDungeonManager:InBattleDungeon() then
    self.ui.tex_Tips.text = ConfigData:GetTipContent(1017)
  else
    self.ui.tex_Tips.text = ConfigData:GetTipContent(1016)
  end
end

function UISelectChip:OnUpdateRemainRefreshInfo()
  if self._isGiveUp then
    return
  end
  local roomData = ExplorationManager.epCtrl.playerCtrl:GetCurrentRoomData()
  if roomData == nil then
    return 0
  end
  self.refreshCount = roomData.refreshAlgCntAfterBattle
  local totalRefreshCount, refreshTimeCfg, refreshPriceCfg, currencyId = self:__GetCurRoomTotalRefreshCountAndPriceCfg()
  self.totalRefreshCount = totalRefreshCount
  self.currencyId = currencyId
  self.curRefreshPrice = ConfigData:CalculatePriceGeneralFunc(self.refreshCount, refreshTimeCfg, refreshPriceCfg)
  self.curRefreshPrice = EpStoreRoomUtil.GetFinalRefreshPriceWithOriginPrice(self.curRefreshPrice)
  self.remainRefreshTime = self.totalRefreshCount
  if 0 < self.totalRefreshCount then
    self.remainRefreshTime = self.totalRefreshCount - self.refreshCount
  end
  local canRefresh = false
  local canShowRemainCount = false
  if self.remainRefreshTime == -1 or 0 < self.remainRefreshTime then
    canRefresh = true
  end
  if 0 < self.remainRefreshTime then
    canShowRemainCount = true
  end
  self:UpdateRefreshCount(canRefresh, self.remainRefreshTime, canShowRemainCount, self.curRefreshPrice)
end

function UISelectChip:__UpdateRefreshPriceInfo()
  local curMoney = ExplorationManager.epCtrl.dynPlayer:GetItemCount(self.currencyId)
  self.isLack = curMoney < self.curRefreshPrice
  self.ui.img_Lack:SetActive(self.isLack)
  self.ui.tex_Refresh:SetIndex(self.isLack and 1 or 0)
end

function UISelectChip:__GetCurRoomTotalRefreshCountAndPriceCfg()
  local epId = ExplorationManager.epCtrl.mapData.exploraionId
  local epMonsterRefreshId = ConfigData.exploration[epId].monster_room_refresh
  local epMonsterRoomCfg = ConfigData.exploration_monster_room[epMonsterRefreshId]
  if epMonsterRoomCfg == nil then
    error("找不到对应的怪物房配置,id= " .. epMonsterRefreshId)
    return 0
  end
  if epMonsterRoomCfg.refresh_times == nil then
    return 0
  end
  local maxTime = epMonsterRoomCfg.refresh_times[#epMonsterRoomCfg.refresh_times]
  return maxTime, epMonsterRoomCfg.refresh_times, epMonsterRoomCfg.prices, epMonsterRoomCfg.currency
end

function UISelectChip:__GetCurRoomRefreshedRemainCount()
  local roomData = ExplorationManager.epCtrl.playerCtrl:GetCurrentRoomData()
  if roomData == nil then
    return 0
  end
  return roomData.refreshAlgCntAfterBattle
end

function UISelectChip:OnShow()
  base.OnShow(self)
  MsgCenter:Broadcast(eMsgEventId.OnEpBuffListDisplay, false)
end

function UISelectChip:OnHide()
  base.OnHide(self)
  MsgCenter:Broadcast(eMsgEventId.OnEpBuffListDisplay, true)
end

function UISelectChip:InitSelectChip(refreshable, chipDataList, dynPlayer, selectEvent, giveupEvent, toFakeCamera, refreshEvent)
  self.ui.btn_Map.gameObject:SetActive(ExplorationManager:HasRoomSceneInEp())
  self:RefreshMapBtnState(true)
  self.ui.btn_Refresh.gameObject:SetActive(refreshable)
  if refreshable then
    self.__onlockClickAction = BindCallback(self, self.OnLockSelect)
    self:OnUpdateRemainRefreshInfo()
    self:SetClickRefreshCallback(BindCallback(self, self.OnRefreshChipAction))
  end
  self.toFakeCamera = toFakeCamera
  self.dynPlayer = dynPlayer
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
  end
  self.resloader = CS.ResLoader.Create()
  self.selectEvent = selectEvent
  self.giveupEvent = giveupEvent
  self.refreshChipEvent = refreshEvent
  self.chipItemList = {}
  self.chipDataList = chipDataList
  self.__clickedPanelAction = BindCallback(self, self.OnChipPanelClicked)
  self:RefreshChipList(self.chipDataList, refreshable)
  if toFakeCamera then
    self:__ToFackCameraCanvas()
    self.transform:SetLayer(LayerMask.UI3D)
  else
    self.transform:SetLayer(LayerMask.UI)
    if GuideManager:TryTriggerGuide(eGuideCondition.InSelectChip) then
    end
    if ExplorationManager:IsInExploration() then
      local curRoomData = ExplorationManager.epCtrl:GetCurrentRoomData()
      local actionList = ExplorationManager:GetEpGuideActionList(curRoomData.x, ExplorationEnum.epGuideMomentType.BattleSelectChip)
      if actionList ~= nil and 0 < #actionList then
        local EpGuideUtil = require("Game.Exploration.Util.EpGuideUtil")
        EpGuideUtil.ExecuteEpGuideActions(actionList)
      end
    end
  end
  MsgCenter:Broadcast(eMsgEventId.DungeonHeroListActiveSet, false)
end

function UISelectChip:OnLockSelect(chipItem)
  if self.lockedChipItems == nil then
    self.lockedChipItems = {}
  end
  chipItem.lockState = not chipItem.lockState
  if chipItem.lockState then
    if table.count(self.lockedChipItems) >= #self.chipItemList - 1 then
      chipItem.lockState = not chipItem.lockState
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.exploration_Treasure_AlertNotSelectAllReward))
      return
    end
    self.lockedChipItems[chipItem.idx] = chipItem
  else
    self.lockedChipItems[chipItem.idx] = nil
  end
  chipItem:ChangelockUi()
end

function UISelectChip:RefreshChipList(chipDataList, refreshable)
  local function afterAnim()
    self.chipDataList = chipDataList
    
    if self.selectChipItemPool ~= nil then
      self.selectChip = nil
      self.chipItemList = {}
      self.selectChipItemPool:HideAll()
      for k, chipData in ipairs(chipDataList) do
        local chipItem = self.selectChipItemPool:GetOne()
        chipItem.gameObject.name = tostring(chipData.dataId)
        chipItem:Show()
        chipItem:InitSelectChipItem(k, chipData, self.dynPlayer, self.resloader, self.__clickedPanelAction, self.__onlockClickAction, refreshable, false)
        chipItem:SetTRModifier(self.ui.modifier)
        chipItem.panel:ShowEpChipDetailEff(5)
        chipItem.panel:InitDissolveTweenSetting()
        local isHadChip = self.dynPlayer.chipDic[chipData.dataId] ~= nil
        local chipShowState = isHadChip and ChipEnum.eChipShowState.UpState or ChipEnum.eChipShowState.NewState
        chipItem:SetObjNewTagActive(true, chipShowState)
        table.insert(self.chipItemList, chipItem)
      end
    end
    self:RefreshGiveupState(chipDataList)
  end
  
  if #self.chipItemList > 0 then
    UIUtil.AddOneCover("UISelectChip")
    self:CleanSelect()
    local waitingAnimNum = 0
    local isAddedCallback = false
    
    local function palyOver()
      waitingAnimNum = waitingAnimNum - 1
      if waitingAnimNum <= 0 then
        afterAnim()
        UIUtil.CloseOneCover("UISelectChip")
      end
    end
    
    for chipIndex, chipItem in ipairs(self.chipItemList) do
      if not chipItem.lockState then
        local chipPanel = chipItem:GetChipDetailPanel()
        waitingAnimNum = waitingAnimNum + 1
        chipPanel:OnDissolveTweenCompleteAction(palyOver)
        isAddedCallback = true
        chipPanel:PlayDissolveTween()
      end
    end
    AudioManager:PlayAudioById(1123)
    if not isAddedCallback then
      afterAnim()
    end
  else
    afterAnim()
  end
end

function UISelectChip:GetChipPanelByIndex(index)
  local chipItem = self.chipItemList[index]
  if chipItem == nil then
    return nil
  end
  return chipItem:GetChipDetailPanel()
end

function UISelectChip:RefreshGiveupState(chipDataList)
  if self.giveupEvent == nil then
    self.ui.btn_Skip.gameObject:SetActive(false)
    return
  end
  self.ui.btn_Skip.gameObject:SetActive(true)
  local qualityChip
  for k, v in pairs(chipDataList) do
    if qualityChip == nil or qualityChip:GetQuality() < v:GetQuality() then
      qualityChip = v
    end
  end
  if qualityChip == nil then
    self.ui.priceText.gameObject:SetActive(false)
    return
  end
  self.ui.priceText.gameObject:SetActive(true)
  local epTypeCfg = ExplorationManager:GetEpTypeCfg()
  local chipPrice = qualityChip:GetChipBuyPrice(ExplorationManager:GetEpModuleTypeCfgId(), true)
  local price = ConfigData:CalculateEpChipSalePrice(epTypeCfg.store_pool, qualityChip:GetCount(), chipPrice, self.dynPlayer)
  self.ui.priceText.text = "+" .. tostring(price)
end

function UISelectChip:OnChipPanelClicked(chipPanel)
  if chipPanel == nil or self._isGiveUp then
    return
  end
  local stateInfoWindow = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if stateInfoWindow == nil or not stateInfoWindow.chipList.gameObject.activeInHierarchy then
    return
  end
  self:ComfirmSelectChip(chipPanel)
end

function UISelectChip:OnChipDetailActiveChange(bool)
  if bool then
    self:Hide()
  else
    self:Show()
  end
end

function UISelectChip:CleanSelect()
  for _, v in pairs(self.chipItemList) do
    v.panel:UnSelectAlpha(false)
    v.panel:SetSelectAnima(false)
    v.panel:OnSelectChipChanged(false)
  end
end

function UISelectChip:ComfirmSelectChip(chipPanel)
  UIUtil.PopFromBackStackByUiTab(self)
  local index = chipPanel.index
  local chipData = chipPanel:GetChipDetailPanelData()
  local chipReturnMoney = 0
  if ExplorationManager:IsInExploration() then
    chipReturnMoney = ExplorationManager:GetDynPlayer():GetChipReturnMoney(chipData.dataId, chipData:GetCount())
  end
  if self.selectEvent ~= nil then
    self.selectEvent(index, function()
      local selectChipItem = self.chipItemList[index]
      if selectChipItem ~= nil then
        local chipPanel = selectChipItem:GetChipDetailPanel()
        local chipData = chipPanel:GetChipDetailPanelData()
        local chipIconTran = chipPanel:GetChipItemTransform()
        local dungeonStateWindow = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
        if dungeonStateWindow ~= nil then
          local uiPos
          if self.toFakeCamera then
            uiPos = UIManager:World2UIPosition(chipIconTran.position)
            uiPos = Vector3.New(uiPos.x, uiPos.y, 0)
          else
            uiPos = self.transform:InverseTransformPoint(chipIconTran.position)
          end
          dungeonStateWindow:ShowGetChipAni(chipData, uiPos, chipIconTran.localScale, chipReturnMoney)
        end
        if ExplorationManager:IsInExploration() then
          ExplorationManager:GetEpDataCenter():AddNewChip(chipData.dataId)
        end
      end
      self:Delete()
    end)
  end
end

function UISelectChip:OnClickGiveup()
  UIUtil.OnClickBackByUiTab(self)
end

function UISelectChip:StartGiveUpLogic()
  if self._isGiveUp then
    return
  end
  self._isGiveUp = true
  if self.giveupEvent ~= nil then
    UIUtil.AddOneCover("UISelectChip")
    self.giveupEvent(function(afterAnimCallabck)
      self:CleanSelect()
      
      local function afterAnim()
        self:Delete()
        UIUtil.CloseOneCover("UISelectChip")
        if afterAnimCallabck ~= nil then
          afterAnimCallabck()
        end
      end
      
      local waitingAnimNum = 0
      local isAddedCallback = false
      
      local function palyOver()
        waitingAnimNum = waitingAnimNum - 1
        if waitingAnimNum <= 0 then
          afterAnim()
        end
      end
      
      for chipIndex, chipItem in ipairs(self.chipItemList) do
        local chipPanel = chipItem:GetChipDetailPanel()
        waitingAnimNum = waitingAnimNum + 1
        chipPanel:OnDissolveTweenCompleteAction(palyOver)
        isAddedCallback = true
        chipPanel:PlayDissolveTween()
      end
      AudioManager:PlayAudioById(1123)
      if not isAddedCallback then
        afterAnim()
      end
    end)
  end
end

function UISelectChip:OnRefreshChipAction()
  if self.refreshChipEvent ~= nil then
    local idxs
    if self.lockedChipItems ~= nil and table.count(self.lockedChipItems) > 0 then
      idxs = {}
      for k, v in pairs(self.lockedChipItems) do
        table.insert(idxs, k)
      end
    end
    self.refreshChipEvent(self.currencyId, self.remainRefreshTime, self.curRefreshPrice, idxs)
  end
end

function UISelectChip:UpdateRefreshCount(isCouldRefresh, remaindTime, showRemainText, price)
  self.ui.btn_Refresh.gameObject:SetActive(isCouldRefresh)
  self.ui.tex_RefreshCount.gameObject:SetActive(showRemainText)
  if showRemainText then
    self.ui.tex_RefreshCount:SetIndex(0, tostring(remaindTime))
  end
  self.ui.tex_Pay.text = "-" .. tostring(price)
  self:__UpdateRefreshPriceInfo()
end

function UISelectChip:SetClickRefreshCallback(clickRefreshCallback)
  self.clickRefreshCallback = clickRefreshCallback
end

function UISelectChip:__ClickRefresh()
  if self._isGiveUp then
    return
  end
  if self.isLack then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.exploration_Treasure_MoneyInsufficient))
    return
  end
  if self.clickRefreshCallback ~= nil then
    self.clickRefreshCallback()
  end
end

function UISelectChip:SetHasEpActiveCampFetter(hasEpActive)
  self.ui.obj_btn_CampBondSkill:SetActive(hasEpActive)
end

function UISelectChip:SetActiveCampFetter(campId, heroNum, couldUse, cdStr)
  if couldUse then
    self.ui.img_btn_CampBondSkill:SetIndex(0)
    local campFetterCfg = ConfigData.camp_connection[campId][heroNum]
    self.ui.img_CampFetterIcon.sprite = AtlasUtil.GetSpriteFromAtlas(UIAtlasConsts.Atlas_CampFetterIcon, campFetterCfg.icon, self.resloader)
    self.ui.tex_campFetterName:SetIndex(0, LanguageUtil.GetLocaleText(campFetterCfg.name))
    self.ui.tex_subText:SetIndex(0, LanguageUtil.GetLocaleText(ConfigData.camp[campId].name))
  else
    self.ui.img_btn_CampBondSkill:SetIndex(1)
    local campFetterCfg = ConfigData.camp_connection[campId][heroNum]
    self.ui.img_CampFetterIcon.sprite = AtlasUtil.GetSpriteFromAtlas(UIAtlasConsts.Atlas_CampFetterIcon, campFetterCfg.icon, self.resloader)
    self.ui.tex_campFetterName:SetIndex(1)
    self.ui.tex_subText:SetIndex(1, cdStr)
  end
end

function UISelectChip:SetClickActiveCampFetter(useCampFetterCallback)
  self.useCampFetterCallback = useCampFetterCallback
end

function UISelectChip:__OnClickActiveCampFetter()
  if self.useCampFetterCallback ~= nil then
    self.useCampFetterCallback()
  end
end

function UISelectChip:__OnClickSkipButton()
  CS.MessageCommon.ShowMessageBox(ConfigData:GetTipContent(1011), function()
    if self.selectEvent ~= nil then
      local index = #self.chipDataList + 1
      self.selectEvent(index)
    end
    self:Delete()
  end, nil)
end

function UISelectChip:__ToFackCameraCanvas()
  local fakeCameraBattle = cs_GameObject.Find("FakeCameraBattleChip"):FindComponent(eUnityComponentID.Camera)
  self:AlignToFakeCamera(fakeCameraBattle)
end

function UISelectChip:ShowDungeonState()
  local win = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  win:Show()
  if ExplorationManager:IsInExploration() then
    win:OnlyShowChipList(false, false)
  end
  win:ChipListWeakenTween(false)
end

function UISelectChip:OnClickMap()
  self:RefreshMapBtnState(not self.mapBtnStateFlag)
end

function UISelectChip:RefreshMapBtnState(flag)
  self.mapBtnStateFlag = flag
  self.ui.modifier.gameObject:SetActive(flag)
  self.ui.tex_btnName:SetIndex(flag and 0 or 1)
  self.ui.obj_background:SetActive(flag)
  self.ui.obj_textContinue:SetActive(flag)
end

function UISelectChip:OnDelete()
  if not self.toFakeCamera and ExplorationManager:IsInExploration() then
    MsgCenter:Broadcast(eMsgEventId.DungeonHeroListActiveSet, true)
  end
  MsgCenter:RemoveListener(eMsgEventId.OnSettleMentTimeLinePlayToEnd, self.__ShowDungeonState)
  MsgCenter:RemoveListener(eMsgEventId.EpMoneyChange, self.__onMoneyUpdate)
  MsgCenter:RemoveListener(eMsgEventId.OnDungeonDetailWinChange, self.__OnChipDetailActiveChange)
  local window = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if window ~= nil then
    window.chipList:CancelHighlightChipItem()
  end
  self.selectChipItemPool:DeleteAll()
  base.OnDelete(self)
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
end

return UISelectChip
