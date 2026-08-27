local UIResetRoom = class("UIResetRoom", UIBaseWindow)
local base = UIBaseWindow
local UIResetRoomButton = require("Game.Exploration.UI.ResetRoom.UIResetRoomButton")
local UIResetRoomChip = require("Game.Exploration.UI.ResetRoom.UIResetRoomChip")
local cs_MessageCommon = CS.MessageCommon
local cs_ExplorationManager = CS.ExplorationManager.Instance
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")

function UIResetRoom:OnInit()
  self:__InitData()
  self:__InitUi()
end

function UIResetRoom:__InitData()
  self.rewardGlobalChip = {}
  self.poolButtonItem = UIItemPool.New(UIResetRoomButton, self.ui.btn_Operation)
  self.poolChipItem = UIItemPool.New(UIResetRoomChip, self.ui.chipItem)
  self.selectChipItemArr = {}
end

function UIResetRoom:__InitUi()
  self.ui.btn_Operation.gameObject:SetActive(false)
  self.ui.chipItem:SetActive(false)
  self.currBtnItems = {}
  UIUtil.AddButtonListener(self.ui.btn_Return, self, self.OnReturnClick)
  UIUtil.AddButtonListener(self.ui.btn_GiveUp, self, self.OnGiveUpClick)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.OnComfirmClick)
  self.__onOperationButtonClick = BindCallback(self, self.OnOperationButtonClick)
end

function UIResetRoom:InitResetRoom(ctrl, resetRoomDataList)
  self.ctrl = ctrl
  self.dynPlayer = ExplorationManager:GetDynPlayer()
  self.poolButtonItem:HideAll()
  local buttonItem
  for id, resetRoomData in ipairs(resetRoomDataList) do
    buttonItem = self.currBtnItems[id]
    if buttonItem == nil then
      buttonItem = self.poolButtonItem:GetOne()
      self.currBtnItems[id] = buttonItem
    end
    buttonItem:InitOperationButton(id, resetRoomData, self.__onOperationButtonClick)
    buttonItem.gameObject:SetActive(true)
  end
end

function UIResetRoom:UpdateMoney(money)
  self.ui.tex_MoneyCount:SetIndex(0, tostring(money))
end

function UIResetRoom:OnOperationButtonClick(buttonItem)
  if buttonItem == nil then
    return
  end
  if self.dynPlayer:GetMoneyCount() < buttonItem.price then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.exploration_Reconstitution_MoneyInsufficient))
    return
  end
  self.btnInfo = {}
  self.btnInfo.currBtnId = buttonItem.id
  if buttonItem.id == ExplorationEnum.eResetRoomType.Mix then
    self.btnInfo.selectCount = ConfigData.game_config.ExplorationResetRoomMixValue
  else
    self.btnInfo.selectCount = 1
  end
  self.btnInfo.clickCount = 0
  self:LoadGlobalChip()
  self:__SetSubPageActive(true)
end

function UIResetRoom:LoadGlobalChip()
  if #self.ctrl.playerChipDatas <= 0 or self.ctrl.playerChipDatas == nil then
    return
  end
  if self.currChipItemDic ~= nil then
    for key, item in pairs(self.currChipItemDic) do
      item:Delete()
    end
  end
  self.currChipItemDic = {}
  local chipItem
  for key, chipData in ipairs(self.ctrl.playerChipDatas) do
    chipItem = self.currChipItemDic[key]
    if chipItem == nil then
      chipItem = UIResetRoomChip.New()
      local go = self.ui.chipItem:Instantiate()
      go:SetActive(true)
      chipItem:Init(go)
      self.currChipItemDic[key] = chipItem
    end
    chipItem.gameObject:SetActive(true)
    chipItem:InitChipItem(chipData, chipData:GetCount(), BindCallback(self, self.OnChipItemClick))
  end
  self:__SortChip(self.currChipItemDic)
end

function UIResetRoom:OnChipItemClick(chipItem)
  if self.btnInfo.clickCount >= self.btnInfo.selectCount then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.exploration_Reconstitution_SelectCountReachMax) .. self.btnInfo.selectCount)
    return
  end
  if chipItem:CanSelect() then
    self:__SelectChip(chipItem)
    if self.btnInfo.currBtnId == ExplorationEnum.eResetRoomType.Mix then
      self:__UpdateChipItemDic(chipItem.chipData:GetQuality())
    else
      self:__UpdateChipItemDic(nil)
    end
    chipItem:UpdateCountUI(self.btnInfo.clickCount)
  end
  if self.btnInfo.clickCount == self.btnInfo.selectCount then
    self.ui.btn_Confirm.gameObject:SetActive(true)
  else
    self.ui.btn_Confirm.gameObject:SetActive(false)
  end
end

function UIResetRoom:__SelectChip(chipItem, selectCount)
  self.btnInfo.clickCount = self.btnInfo.clickCount + 1
  local selectItem
  selectItem = UIResetRoomChip.New()
  local go = self.ui.chipItem:Instantiate()
  go:SetActive(true)
  selectItem:Init(go)
  selectItem.transform:SetParent(self.ui.selectContent)
  selectItem:InitChipItem(chipItem.chipData, 1, nil)
  table.insert(self.selectChipItemArr, selectItem)
end

function UIResetRoom:__UpdateChipItemDic(quality)
  for dataId, item in pairs(self.currChipItemDic) do
    if quality == nil or item.chipData:GetQuality() ~= quality then
      item:OnSelectUI(true)
      item.ui.btn_Item.enabled = false
    end
  end
end

function UIResetRoom:OnComfirmClick()
  if self.btnInfo == nil then
    return
  end
  self.selectChipItemList = {}
  local selectCount = #self.selectChipItemArr
  if selectCount < self.btnInfo.selectCount then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.exploration_Reconstitution_NotSelectEnourhChip) .. selectCount)
    return
  end
  self.ctrl:SendInfomationOperation(self.btnInfo, self.selectChipItemArr)
  self:OnReturnClick()
end

function UIResetRoom:OnReturnClick()
  self.ui.btn_Confirm.gameObject:SetActive(false)
  self:__SetSubPageActive(false)
  self:__ClearSelectChipData()
end

function UIResetRoom:__ClearSelectChipData()
  if self.selectChipItemArr ~= nil then
    for _, v in ipairs(self.selectChipItemArr) do
      v:Delete()
    end
    self.selectChipItemArr = {}
  end
end

function UIResetRoom:OnGiveUpClick()
  self.ctrl:SendResetRoomQuit()
end

function UIResetRoom:CloseResetRoom()
  self:Delete()
end

function UIResetRoom:__SetSubPageActive(active)
  self.ui.btn_GiveUp.gameObject:SetActive(not active)
  self.ui.ControlNode:SetActive(not active)
  self.ui.UserChipNode:SetActive(active)
  self.ui.SelectChipNode:SetActive(active)
  self.ui.btn_Return.gameObject:SetActive(active)
end

function UIResetRoom:__SortChip(datas)
  local tab = {}
  for key, value in pairs(datas) do
    table.insert(tab, value)
  end
  table.sort(tab, function(chip1, chip2)
    local quality1 = chip1.chipData:GetQuality()
    local quality2 = chip2.chipData:GetQuality()
    local id1 = chip1.chipData.dataId
    local id2 = chip2.chipData.dataId
    if quality1 == quality2 then
      return id1 < id2
    else
      return quality1 > quality2
    end
  end)
  for _, value in ipairs(tab) do
    value.transform:SetAsLastSibling()
  end
end

function UIResetRoom:OnDelete()
  self.currBtuttons = nil
  if self.currChipItemDic ~= nil then
    for _, v in pairs(self.currChipItemDic) do
      v:OnDelete()
    end
    self.currChipItemDic = nil
  end
  base.OnDelete(self)
end

return UIResetRoom
