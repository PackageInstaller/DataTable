local UITreasureRoom = class("UITreasureRoom", UIBaseWindow)
local base = UIBaseWindow
local UITreasureRoomChipItem = require("Game.Exploration.UI.Base.UISelectChipItem")
local CS_ResLoader = CS.ResLoader
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")

function UITreasureRoom:OnInit()
  UIUtil.SetTopStatus(self, self.TreasureGiveupLogic, nil, nil, nil, true)
  self.resloader = CS_ResLoader.Create()
  UIUtil.AddButtonListener(self.ui.btn_Refresh, self, self.OnRefreshClick)
  UIUtil.AddButtonListener(self.ui.btn_Skip, self, self.OnSkipClick)
  UIUtil.AddButtonListener(self.ui.btn_Map, self, self.OnClickShowMap)
  self.itemPool = UIItemPool.New(UITreasureRoomChipItem, self.ui.obj_treasureItem)
  self.ui.obj_treasureItem:SetActive(false)
  self.chipItemArr = {}
  self.GlobalChipData = nil
  self.__mapActiveState = false
  self.__onToggleChipItemClick = BindCallback(self, self.OnChipPanelClicked)
  self.__onlockClickAction = BindCallback(self, self.OnlockClick)
  self.__OnChipDetailActiveChange = BindCallback(self, self.OnChipDetailActiveChange)
  MsgCenter:AddListener(eMsgEventId.OnDungeonDetailWinChange, self.__OnChipDetailActiveChange)
  self.__FromMapBackToUI = BindCallback(self, self.FromMapBackToUI)
  MsgCenter:AddListener(eMsgEventId.OnShowingMapRoomClick, self.__FromMapBackToUI)
  self.__onMoneyUpdate = BindCallback(self, self.__UpdateRefreshPriceText)
  MsgCenter:AddListener(eMsgEventId.EpMoneyChange, self.__onMoneyUpdate)
end

function UITreasureRoom:OnShow()
  base.OnShow(self)
  MsgCenter:Broadcast(eMsgEventId.OnEpBuffListDisplay, false)
  local dungeonInfoWin = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if dungeonInfoWin ~= nil then
    dungeonInfoWin:TrySetLimitSellBtnActive(false)
  end
end

function UITreasureRoom:OnHide()
  base.OnHide(self)
  MsgCenter:Broadcast(eMsgEventId.OnEpBuffListDisplay, true)
  local dungeonInfoWin = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if dungeonInfoWin ~= nil then
    dungeonInfoWin:TrySetLimitSellBtnActive(true)
  end
end

function UITreasureRoom:InitTreasureRoom(ctrl, roomData, isFirstOpen)
  self.ui.btn_Map.gameObject:SetActive(ExplorationManager:HasRoomSceneInEp())
  if roomData == nil then
    local err = "UITreasureRoom:InitTreasureRoom error:cfgData is nil "
    error(err)
    return
  end
  self.ctrl = ctrl
  self.roomData = roomData
  self.treasureData = roomData.treasureData
  self.cfg = roomData.cfg
  self:__UpdateRefreshPriceText()
  self:__ShowChipDetail(roomData.treasureData.chipDatas, isFirstOpen)
  self:__ShowGiveUpPrice(roomData.treasureData.chipDatas)
  self.__mapActiveState = false
  self:SwitchRoomMapBtnState(self.__mapActiveState)
  if GuideManager:TryTriggerGuide(eGuideCondition.InEpTreasureRoom) then
  end
end

function UITreasureRoom:__UpdateRefreshPriceText()
  local refreshPrice = self.ctrl:GetTreasureRoomRefreshPrice()
  self.ui.tex_Pay.text = "-" .. tostring(refreshPrice)
  self:UpdateCouldRefreshRoom()
end

function UITreasureRoom:UpdateCouldRefreshRoom()
  local totalRefreshTime = 0
  if self.cfg.times ~= nil then
    totalRefreshTime = self.cfg.maxRefreshTime
  end
  if totalRefreshTime == 0 then
    self.ui.btn_Refresh.gameObject:SetActive(false)
  else
    local remainRefreshTime = 0
    if 0 < totalRefreshTime then
      remainRefreshTime = totalRefreshTime - self.treasureData.freshCnt
    end
    if totalRefreshTime == -1 or remainRefreshTime <= 0 then
      self.ui.tex_RefreshCount.gameObject:SetActive(false)
    else
      self.ui.tex_RefreshCount:SetIndex(0, tostring(remainRefreshTime))
    end
    if 0 <= totalRefreshTime and remainRefreshTime <= 0 then
      self.ui.btn_Refresh.gameObject:SetActive(false)
    end
    self.currMoney = self.ctrl.dynPlayer:GetMoneyCount()
    self.isLack = self.currMoney < self.roomData.refreshCostNum
    self.ui.obj_Lack:SetActive(self.isLack)
    self.ui.tex_Refresh:SetIndex(self.isLack and 1 or 0)
  end
end

function UITreasureRoom:__ShowChipDetail(chipDatas, isFirstOpen)
  UIUtil.AddOneCover("UITreasureRoom")
  
  local function afterAnim()
    self.itemPool:HideAll()
    self.chipItemArr = {}
    for index, chipData in pairs(chipDatas) do
      local item = self.itemPool:GetOne(true)
      item.gameObject.name = tostring(chipData.data.dataId)
      item:InitSelectChipItem(chipData.idx, chipData.data, self.ctrl.dynPlayer, self.resloader, self.__onToggleChipItemClick, self.__onlockClickAction, true)
      item:SetTRModifier(self.ui.modifier)
      item.panel:ShowEpChipDetailEff(5)
      item.panel:InitDissolveTweenSetting()
      local isHadChip = self.ctrl.dynPlayer.chipDic[chipData.data.dataId] ~= nil
      local chipShowState = isHadChip and ChipEnum.eChipShowState.UpState or ChipEnum.eChipShowState.NewState
      item:SetObjNewTagActive(true, chipShowState)
      table.insert(self.chipItemArr, item)
    end
    UIUtil.CloseOneCover("UITreasureRoom")
  end
  
  local waitingAnimNum = 0
  local isAddedCallback = false
  
  local function palyOver()
    waitingAnimNum = waitingAnimNum - 1
    if waitingAnimNum <= 0 then
      afterAnim()
    end
  end
  
  if not isFirstOpen then
    self:CleanSelect()
    for chipIndex, chipItem in ipairs(self.chipItemArr) do
      if not chipItem.lockState then
        local chipPanel = chipItem:GetChipDetailPanel()
        waitingAnimNum = waitingAnimNum + 1
        chipPanel:OnDissolveTweenCompleteAction(palyOver)
        isAddedCallback = true
        chipPanel:PlayDissolveTween()
      end
    end
    AudioManager:PlayAudioById(1123)
  end
  if not isAddedCallback then
    afterAnim()
  end
end

function UITreasureRoom:__ShowGiveUpPrice(chipDatas)
  local qualityChip
  for k, v in pairs(chipDatas) do
    if qualityChip == nil or qualityChip:GetQuality() < v.data:GetQuality() then
      qualityChip = v.data
    end
  end
  if qualityChip == nil then
    self.ui.priceText.gameObject:SetActive(false)
    return
  end
  self.ui.priceText.gameObject:SetActive(true)
  local epTypeCfg = ExplorationManager:GetEpTypeCfg()
  local chipPrice = qualityChip:GetChipBuyPrice(ExplorationManager:GetEpModuleTypeCfgId(), true)
  local price = ConfigData:CalculateEpChipSalePrice(epTypeCfg.store_pool, qualityChip:GetCount(), chipPrice, self.ctrl.dynPlayer)
  self.ui.priceText.text = "+" .. tostring(price)
end

function UITreasureRoom:GetChipPanelByIndex(index)
  local chipItem = self.chipItemArr[index]
  if chipItem == nil then
    return nil
  end
  return chipItem:GetChipDetailPanel()
end

function UITreasureRoom:OnChipPanelClicked(chipPanel)
  if chipPanel == nil or self._isGiveUp then
    return
  end
  self:OnComfirmClick(chipPanel)
end

function UITreasureRoom:CleanSelect()
  for _, v in pairs(self.itemPool.listItem) do
    v.panel:UnSelectAlpha(false)
    v.panel:SetSelectAnima(false)
    v.panel:OnSelectChipChanged(false)
  end
end

function UITreasureRoom:OnlockClick(chipItem)
  if chipItem ~= nil then
    self.ctrl:SendItemLockOrUnlock(chipItem)
  end
end

function UITreasureRoom:OnComfirmClick(chipPanel)
  UIUtil.PopFromBackStackByUiTab(self)
  local chipItemTran = chipPanel:GetChipItemTransform()
  local chipData = chipPanel:GetChipDetailPanelData()
  local dynPlayer = ExplorationManager:GetDynPlayer()
  local chipReturnMoney = dynPlayer:GetChipReturnMoney(chipData.dataId, chipData:GetCount())
  self.ctrl:SendItemSelect(chipPanel.index, function()
    local uiPos = self.transform:InverseTransformPoint(chipItemTran.position)
    local localScale = chipItemTran.localScale
    local dungeonStateWindow = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
    if dungeonStateWindow ~= nil then
      dungeonStateWindow:ShowGetChipAni(chipData, uiPos, localScale, chipReturnMoney)
    end
    local chipData = chipPanel:GetChipDetailPanelData()
    ExplorationManager:GetEpDataCenter():AddNewChip(chipData.dataId)
  end)
end

function UITreasureRoom:OnRefreshClick()
  self.ctrl:SendRefreshTreasureRoom(self.treasureData.boxId)
end

function UITreasureRoom:OnSkipClick()
  UIUtil.OnClickBackByUiTab(self)
end

function UITreasureRoom:TreasureGiveupLogic()
  if self._isGiveUp then
    return
  end
  self._isGiveUp = true
  UIUtil.AddOneCover("UITreasureRoom")
  self:CleanSelect()
  local waitingAnimNum = 0
  local isAddedCallback = false
  
  local function palyOver()
    waitingAnimNum = waitingAnimNum - 1
    if waitingAnimNum <= 0 then
      self.ctrl:SendTreasureRoomQuit()
      UIUtil.CloseOneCover("UITreasureRoom")
    end
  end
  
  for chipIndex, chipItem in ipairs(self.chipItemArr) do
    local chipPanel = chipItem:GetChipDetailPanel()
    waitingAnimNum = waitingAnimNum + 1
    chipPanel:OnDissolveTweenCompleteAction(palyOver)
    isAddedCallback = true
    chipPanel:PlayDissolveTween()
  end
  AudioManager:PlayAudioById(1123)
  if not isAddedCallback then
    self.ctrl:SendTreasureRoomQuit()
  end
end

function UITreasureRoom:OnClickShowMap()
  self.__mapActiveState = not self.__mapActiveState
  self:SwitchRoomMapBtnState(self.__mapActiveState)
end

function UITreasureRoom:FromMapBackToUI()
  self.__mapActiveState = false
  self:SwitchRoomMapBtnState(self.__mapActiveState)
end

function UITreasureRoom:OnChipDetailActiveChange(bool)
  if bool then
    self:Hide()
  else
    self:Show()
  end
end

function UITreasureRoom:SwitchRoomMapBtnState(openMap)
  if openMap then
    self.ui.tex_MapBtnName:SetIndex(1)
  else
    self.ui.tex_MapBtnName:SetIndex(0)
  end
  self.ui.frameNode:SetActive(not openMap)
  MsgCenter:Broadcast(eMsgEventId.DungeonHeroListActiveSet, openMap)
end

function UITreasureRoom:OnDelete()
  self.resloader:Put2Pool()
  self.resloader = nil
  self.GlobalChipData = nil
  MsgCenter:RemoveListener(eMsgEventId.OnDungeonDetailWinChange, self.__OnChipDetailActiveChange)
  MsgCenter:RemoveListener(eMsgEventId.OnShowingMapRoomClick, self.__FromMapBackToUI)
  MsgCenter:RemoveListener(eMsgEventId.EpMoneyChange, self.__onMoneyUpdate)
  MsgCenter:Broadcast(eMsgEventId.DungeonHeroListActiveSet, true)
  self.itemPool:DeleteAll()
  base.OnDelete(self)
end

return UITreasureRoom
