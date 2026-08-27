local UIEpUpgradeRoom = class("UIEpUpgradeRoom", UIBaseWindow)
local base = UIBaseWindow
local UIEpUpgradeRoomItem = require("Game.Exploration.UI.UpgradeRoom.UIEpUpgradeRoomItem")
local UINChipDetailPanel = require("Game.CommonUI.Chip.UINEpChipDetail")

function UIEpUpgradeRoom:OnInit()
  UIUtil.SetTopStatus(self, self.BackAction, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_Skip, self, self.OnRoomSkipClicked)
  UIUtil.AddButtonListener(self.ui.btn_Map, self, self.OnMapClicked)
  self._onUpgradeClicked = BindCallback(self, self.OnUpgradeClicked)
  self.__OnChipItemClick = BindCallback(self, self.OnChipItemClick)
  self.chipItemDic = {}
  self.resloader = CS.ResLoader.Create()
  self.chipDetailPanel = UINChipDetailPanel.New()
  self.chipDetailPanel:Init(self.ui.chipItemDetail)
  self.__OnChipDetailActiveChange = BindCallback(self, self.OnChipDetailActiveChange)
  MsgCenter:AddListener(eMsgEventId.OnDungeonDetailWinChange, self.__OnChipDetailActiveChange)
  self.__FromMapBackToUI = BindCallback(self, self.FromMapBackToUI)
  MsgCenter:AddListener(eMsgEventId.OnShowingMapRoomClick, self.__FromMapBackToUI)
  self.onChipListUpdate = BindCallback(self, self.__onChipListUpdate)
  MsgCenter:AddListener(eMsgEventId.OnEpChipListChange, self.onChipListUpdate)
  self.onMoneyUpdate = BindCallback(self, self.__onMoneyUpdate)
  MsgCenter:AddListener(eMsgEventId.EpMoneyChange, self.onMoneyUpdate)
end

function UIEpUpgradeRoom:OnShow()
  base.OnShow(self)
  MsgCenter:Broadcast(eMsgEventId.OnEpBuffListDisplay, false)
end

function UIEpUpgradeRoom:OnHide()
  base.OnHide(self)
  MsgCenter:Broadcast(eMsgEventId.OnEpBuffListDisplay, true)
end

function UIEpUpgradeRoom:InitUpgradeRoom(roomCtrl, upgradeCfg, refreshTime)
  self.ui.btn_Map.gameObject:SetActive(ExplorationManager:HasRoomSceneInEp())
  self.roomCtrl = roomCtrl
  self.refreshTime = refreshTime
  self.ui.tex_Skip:SetIndex(refreshTime == 0 and 0 or 1)
  self:_UpdChipList(self.roomCtrl.dynPlayer:GetChipList())
  self.cfg = upgradeCfg
  if self.cfg.currency ~= nil then
    local itemCfg = ConfigData.item[self.cfg.currency]
    if itemCfg ~= nil then
      self.moneyIconId = itemCfg.icon
    end
  end
  self.maxRefreshTimes = 0
  if self.cfg.refresh_times ~= nil then
    self.maxRefreshTimes = self.cfg.refresh_times[#self.cfg.refresh_times]
  end
  if 0 <= self.maxRefreshTimes then
    self.ui.refreshTimeText.gameObject:SetActive(true)
    self.ui.refreshTimeText:SetIndex(0, tostring(self.maxRefreshTimes - self.refreshTime))
  else
    self.ui.refreshTimeText.gameObject:SetActive(false)
  end
  self.roomId = upgradeCfg.id
  self:LoadChipData()
  local selectItem = self:__GetChipItemByIndex(self.selectedIndex)
  self:RefreshSelectItemDetail(selectItem)
  if 0 < self.ui.chipList.totalCount then
    local needScrollIndex = math.max(self.selectedIndex - 1, 0)
    self.ui.chipList:SrollToCell(needScrollIndex, 10000)
  end
  self.__mapActiveState = false
  self:SwitchRoomMapBtnState(self.__mapActiveState)
  self:CheckRefreshTimeAndExit()
end

function UIEpUpgradeRoom:_UpdChipList(chipDataList)
  local list = {}
  for k, chipData in ipairs(chipDataList) do
    if not chipData:IsConsumeSkillChip() then
      table.insert(list, chipData)
    end
  end
  self.chipDataList = list
  if #self.chipDataList > 0 then
    self.chipDataList = ExplorationManager:SortChipDataList(self.chipDataList)
  end
end

function UIEpUpgradeRoom:LoadChipData()
  if self.selectedIndex == nil then
    self.selectedIndex = 1
  end
  self.ui.chipList:ClearCells()
  self.ui.chipList.onInstantiateItem = BindCallback(self, self.__ChipListInitItem)
  self.ui.chipList.onChangeItem = BindCallback(self, self.__ChipListUpdateItem)
  self:__ReFillList(self.chipDataList)
end

function UIEpUpgradeRoom:__ChipListInitItem(go)
  local chipItem = UIEpUpgradeRoomItem.New()
  chipItem:Init(go)
  self.chipItemDic[go] = chipItem
end

function UIEpUpgradeRoom:__ChipListUpdateItem(go, index)
  local chipItem = self.chipItemDic[go]
  if chipItem == nil then
    error("Can't find Item by gameObject")
    return
  end
  index = index + 1
  local chipData = self.chipDataList[index]
  chipData.idx = index
  if chipData == nil then
    error("Can't find chipData by index, index = " .. tonumber(index))
  end
  local upgradePrice = ConfigData:CalculateEpChipUpgradePrice(self.roomId, self.refreshTime)
  chipItem:InitUpgradeRoomItem(self.roomId, self.moneyIconId, upgradePrice, chipData, self.__OnChipItemClick)
  chipItem.chipItem:UpdateChipItem(self.roomCtrl.dynPlayer)
  chipItem:SetChipItemSelect(index == self.selectedIndex)
end

function UIEpUpgradeRoom:__GetChipItemByIndex(index)
  if self.ui.chipList.totalCount <= 0 then
    return nil
  end
  local go = self.ui.chipList:GetCellByIndex(index - 1)
  if not IsNull(go) then
    local chipItem = self.chipItemDic[go]
    return chipItem
  end
  return nil
end

function UIEpUpgradeRoom:__ReFillList(dataList)
  self.ui.chipList.totalCount = #dataList
  self.ui.chipList:RefillCells()
end

function UIEpUpgradeRoom:RefreshSelectItemDetail(selectItem)
  local chipData = self.chipDataList[self.selectedIndex]
  if chipData == nil then
    self.chipDetailPanel:Hide()
    return
  end
  self.chipDetailPanel:Show()
  self.chipDetailPanel:OnSelectChipChanged(true)
  self.chipDetailPanel:InitEpChipDetail(self.selectedIndex, chipData, self.roomCtrl.dynPlayer, self.resloader, levelMax, eChipDetailPowerType.Add, true)
  self.chipDetailPanel:ShowHeroHeadOrTacticActive(true)
  self.chipDetailPanel:ShowEpChipDetailEff(5)
  local btnGroup = self.chipDetailPanel:GetDetailButtonGroup()
  local upgradedChipData = chipData
  local levelMax = chipData:GetCount() >= chipData:GetChipMaxLevel()
  if levelMax then
    btnGroup:ShowIsLevelMaxTips()
    return
  end
  btnGroup:InitBtnSelect(self._onUpgradeClicked)
end

function UIEpUpgradeRoom:__onChipListUpdate(chipList)
  self:_UpdChipList(chipList)
  self:__ReFillList(self.chipDataList)
  local selectItem = self:__GetChipItemByIndex(self.selectedIndex)
  self:RefreshSelectItemDetail(selectItem)
end

function UIEpUpgradeRoom:__onMoneyUpdate()
  local currencyNum = ExplorationManager:GetDynPlayer():GetItemCount(self.cfg.currency)
  if self.currency ~= currencyNum and self.selectedIndex ~= nil then
    self.currency = currencyNum
    local selectItem = self:__GetChipItemByIndex(self.selectedIndex)
    self:RefreshSelectItemDetail(selectItem)
  end
end

function UIEpUpgradeRoom:OnChipItemClick(chipItem)
  if chipItem == nil then
    return
  end
  if self.selectedIndex == chipItem.index then
    return
  end
  local lastChipItem = self:__GetChipItemByIndex(self.selectedIndex)
  if lastChipItem ~= nil then
    lastChipItem:SetChipItemSelect(false)
  end
  self.selectedIndex = chipItem.index
  chipItem:SetChipItemSelect(true)
  chipItem.chipItem:RefreshLevelTween()
  self:RefreshSelectItemDetail(chipItem)
end

function UIEpUpgradeRoom:OnUpgradeClicked()
  local chipItem = self:__GetChipItemByIndex(self.selectedIndex)
  if chipItem == nil then
    return
  end
  local chipData = self.chipDataList[self.selectedIndex]
  if chipData == nil then
    return
  end
  if chipData:GetCount() >= chipData:GetChipMaxLevel() then
    CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.exploration_Upgrade_UpgradeItemLevelMax))
    return
  end
  if self.maxRefreshTimes <= self.refreshTime and self.maxRefreshTimes ~= -1 then
    CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.exploration_Upgrade_UpgradeTimesInsufficient))
    return
  end
  local uiPos = self.transform:InverseTransformPoint(chipItem.transform.position)
  local localScale = chipItem.transform.localScale
  self.roomCtrl:SendChipUpgrade(chipItem, self.cfg.currency, BindCallback(self, self.PlaySuccessEfc, chipItem.chipData, uiPos, localScale))
end

function UIEpUpgradeRoom:PlaySuccessEfc(chipData, pos, scale)
  if chipData == nil then
    return
  end
  local dungeonStateWindow = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if dungeonStateWindow ~= nil then
    dungeonStateWindow:ShowGetChipAni(chipData, pos, scale, 0)
  end
end

function UIEpUpgradeRoom:BackAction()
  if self.refreshTime == 0 then
    self.roomCtrl:ReqChipUpgradeReturn()
  else
    self.roomCtrl:SendSpecifyExit()
  end
end

function UIEpUpgradeRoom:OnRoomSkipClicked()
  UIUtil.OnClickBackByUiTab(self)
end

function UIEpUpgradeRoom:OnMapClicked()
  self.__mapActiveState = not self.__mapActiveState
  self:SwitchRoomMapBtnState(self.__mapActiveState)
end

function UIEpUpgradeRoom:FromMapBackToUI()
  self.__mapActiveState = false
  self:SwitchRoomMapBtnState(self.__mapActiveState)
end

function UIEpUpgradeRoom:SwitchRoomMapBtnState(openMap)
  if openMap then
    self.ui.tex_MapBtnName:SetIndex(1)
  else
    self.ui.tex_MapBtnName:SetIndex(0)
  end
  self.ui.frameNode:SetActive(not openMap)
  MsgCenter:Broadcast(eMsgEventId.DungeonHeroListActiveSet, openMap)
end

function UIEpUpgradeRoom:OnChipDetailActiveChange(active)
  if active then
    self:Hide()
  else
    self:Show()
  end
end

function UIEpUpgradeRoom:CheckRefreshTimeEnough()
  if self.maxRefreshTimes > -1 and self.maxRefreshTimes - self.refreshTime <= 0 then
    return false
  end
  return true
end

function UIEpUpgradeRoom:CheckRefreshTimeAndExit()
  if not self:CheckRefreshTimeEnough() then
    self:OnRoomSkipClicked()
  end
end

function UIEpUpgradeRoom:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnDungeonDetailWinChange, self.__OnChipDetailActiveChange)
  MsgCenter:RemoveListener(eMsgEventId.OnShowingMapRoomClick, self.__FromMapBackToUI)
  MsgCenter:RemoveListener(eMsgEventId.OnEpChipListChange, self.onChipListUpdate)
  MsgCenter:RemoveListener(eMsgEventId.EpMoneyChange, self.onMoneyUpdate)
  MsgCenter:Broadcast(eMsgEventId.DungeonHeroListActiveSet, true)
  self.chipDetailPanel:OnDelete()
  base.OnDelete(self)
end

return UIEpUpgradeRoom
