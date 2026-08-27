local UIEpChipDiscardBase = class("UIEpChipDiscardBase", UIBaseWindow)
local base = UIBaseWindow
local UINEpChipDiscardItem = require("Game.Exploration.UI.ChipDiscard.UINEpChipDiscardItem")
local UINChipDetailPanel = require("Game.CommonUI.Chip.UINEpChipDetail")
local cs_ResLoader = CS.ResLoader

function UIEpChipDiscardBase:OnInit()
  self.chipItemDic = {}
  self.isOverLimit = true
  self.costItemNum = 0
  self.costItemId = ConstGlobalItem.EpMoney
  self.resLoader = cs_ResLoader.Create()
  self._onChipListChange = BindCallback(self, self.OnChipListChange, false)
  MsgCenter:AddListener(eMsgEventId.OnEpChipListChange, self._onChipListChange)
  self._onChipLimitChange = BindCallback(self, self._OnChipLimitChange)
  MsgCenter:AddListener(eMsgEventId.OnChipLimitChange, self._onChipLimitChange)
  UIUtil.AddButtonListener(self.ui.btn_Skip, self, self.CloseEpDiscard)
  self._onDiscardItemClick = BindCallback(self, self._OnDiscardItemClick)
  self.ui.chipLoopList.onInstantiateItem = BindCallback(self, self._OnNewItem)
  self.ui.chipLoopList.onChangeItem = BindCallback(self, self._OnChangeItem)
  self.chipDetailPanel = UINChipDetailPanel.New()
  self.chipDetailPanel:Init(self.ui.uINChipItemDetail)
  self._onDiscardChip = BindCallback(self, self.OnDiscardChip)
  self._onChipDetailActiveChange = BindCallback(self, self._OnChipDetailActiveChange)
  MsgCenter:AddListener(eMsgEventId.OnDungeonDetailWinChange, self._onChipDetailActiveChange)
  self:SetEmptyUI(false)
end

function UIEpChipDiscardBase:OnShow()
  base.OnShow(self)
  MsgCenter:Broadcast(eMsgEventId.OnEpBuffListDisplay, false)
  self.transform:SetAsFirstSibling()
end

function UIEpChipDiscardBase:OnHide()
  base.OnHide(self)
  MsgCenter:Broadcast(eMsgEventId.OnEpBuffListDisplay, true)
end

function UIEpChipDiscardBase:InitEpChipDiscard(dynPlayer, closeCallback, needConsumeSkill)
  self.dynPlayer = dynPlayer
  self._closeCallback = closeCallback
  self._needConsumeSkill = needConsumeSkill
  self.discardId = self.dynPlayer:GetChipDiscardId()
  self:OnChipListChange(true)
end

function UIEpChipDiscardBase:OnChipListChange(isFirstOpen)
  self:RefreshExitSituation()
  self:RefreshAddLimit()
  self:RefreshLoopList()
  MsgCenter:Broadcast(eMsgEventId.OnChipDiscardChanged, isFirstOpen)
end

function UIEpChipDiscardBase:_OnChipLimitChange()
  self:RefreshExitSituation()
  self:RefreshAddLimit()
  MsgCenter:Broadcast(eMsgEventId.OnChipDiscardChanged, false)
end

function UIEpChipDiscardBase:RefreshExitSituation()
  local nowCount, nowLimit
  self.isOverLimit, nowCount, nowLimit = self.dynPlayer:IsChipOverLimitNum()
  self.ui.needDiscard:SetActive(self.isOverLimit)
  if self.isOverLimit then
    local needDrop = nowCount - nowLimit
    self.ui.tex_NeedDiscard:SetIndex(0, tostring(needDrop))
  end
end

function UIEpChipDiscardBase:RefreshAddLimit()
  self.costItemId, self.costItemNum = self.dynPlayer:GetChipUpgradeLimitPrice()
  self.ui.tex_Money.text = tostring(self.costItemNum)
  self.ui.img_Money.sprite = CRH:GetSpriteByItemId(self.costItemId)
end

function UIEpChipDiscardBase:RefreshLoopList()
  self.chipDataList = {}
  for chipId, chipData in pairs(self.dynPlayer:GetNormalChipDic()) do
    if self._needConsumeSkill or not chipData:IsConsumeSkillChip() then
      table.insert(self.chipDataList, chipData)
    end
  end
  local num = #self.chipDataList
  if 0 < num then
    self.chipDetailPanel:Show()
  else
    self.chipDetailPanel:Hide()
  end
  if #self.chipDataList > 0 then
    self.chipDataList = ExplorationManager:SortChipDataList(self.chipDataList, true)
  end
  self.ui.chipLoopList.totalCount = num
  self.ui.chipLoopList:RefillCells()
end

function UIEpChipDiscardBase:_OnNewItem(go)
  local item = UINEpChipDiscardItem.New()
  item:Init(go)
  self.chipItemDic[go] = item
end

function UIEpChipDiscardBase:_OnChangeItem(go, index)
  local item = self.chipItemDic[go]
  if item == nil then
    error("Can't find levelItem by gameObject")
    return
  end
  local chipData = self.chipDataList[index + 1]
  if chipData == nil then
    error("Can't find levelData by index, index = " .. tonumber(index))
  end
  self:InitDiscardChipItem(item, chipData, index)
end

function UIEpChipDiscardBase:InitDiscardChipItem(item, chipData, index)
end

function UIEpChipDiscardBase:_OnDiscardItemClick(discardItem)
  if discardItem == nil then
    return
  end
  if self.selectedData ~= nil and self.selectedData ~= discardItem.chipData then
    local lastItem = self:_GetItemByData(self.selectedData)
    if lastItem ~= nil then
      lastItem:SetItemSelect(false)
    end
  end
  self.selectedData = discardItem.chipData
  self.selectChipPrice = discardItem.price
  discardItem:SetItemSelect(true)
  self.chipDetailPanel:Show()
  self.chipDetailPanel:InitEpChipDetail(nil, discardItem.chipData, self.dynPlayer, self.resLoader, true, eChipDetailPowerType.Subtract, true)
  self.chipDetailPanel:ShowHeroHeadOrTacticActive(true)
  self.chipDetailPanel:ShowEpChipDetailEff()
  local sprite, numStr = discardItem:GetEpChipDiscardItemMoneyIconSpriteNum()
  self.chipDetailPanel:GetDetailButtonGroup():InitBtnSelByCost(false, numStr, self._onDiscardChip, sprite)
end

function UIEpChipDiscardBase:_GetItemByData(selData)
  for k, v in ipairs(self.chipDataList) do
    if v == selData then
      local index = k - 1
      return self:_GetItemGoByIndex(index)
    end
  end
end

function UIEpChipDiscardBase:_GetItemGoByIndex(index)
  local go = self.ui.chipLoopList:GetCellByIndex(index)
  if go ~= nil then
    local ChipDiscardItem = self.chipItemDic[go]
    return ChipDiscardItem
  end
  return nil
end

function UIEpChipDiscardBase:OnDiscardChip()
end

function UIEpChipDiscardBase:_OnChipDetailActiveChange(active)
  if active then
    self:Hide()
  else
    self:Show()
  end
end

function UIEpChipDiscardBase:OnWinClose()
  if self._closeCallback ~= nil then
    self._closeCallback()
  end
  self:Delete()
end

function UIEpChipDiscardBase:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnEpChipListChange, self._onChipListChange)
  MsgCenter:RemoveListener(eMsgEventId.OnChipLimitChange, self._onChipLimitChange)
  MsgCenter:RemoveListener(eMsgEventId.OnDungeonDetailWinChange, self._onChipDetailActiveChange)
  self.ui.chipLoopList.gameObject:SetActive(false)
  if self.chipItemDic ~= nil then
    for k, v in pairs(self.chipItemDic) do
      v:OnDelete()
    end
    self.chipItemDic = nil
  end
  base.OnDelete(self)
end

function UIEpChipDiscardBase:StopTimer()
end

function UIEpChipDiscardBase:CloseEpDiscard()
end

function UIEpChipDiscardBase:SetEmptyUI(active)
  for k, v in ipairs(self.ui.emptys) do
    v:SetActive(active)
  end
end

function UIEpChipDiscardBase:OnDeleteEntity()
  if self.resLoader ~= nil then
    self.resLoader:Put2Pool()
    self.resLoader = nil
  end
  self.chipDetailPanel:Delete()
  base.OnDeleteEntity(self)
end

return UIEpChipDiscardBase
