local UINDungeonHeroList = class("UINDungeonHeroList", UIBaseNode)
local base = UIBaseNode
local UINDungeonHeroItem = require("Game.CommonUI.DungeonState.UINDungeonHeroItem")
local UINFairyHeadItem = require("Game.Fairy.UI.Common.UINFairyHeadItem")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")

function UINDungeonHeroList:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.itemPool = UIItemPool.New(UINDungeonHeroItem, self.ui.heroItem)
  self.ui.heroItem:SetActive(false)
  self.lastSelectItem = nil
  self.fairyHead = UINFairyHeadItem.New()
  self.fairyHead:Init(self.ui.fairyHeadItem)
  self.fairyHead:Hide()
  self.isHideHero = false
  self.HpChaged = false
  self.reviveCount = 0
  self.selectWithChipIdCallback = BindCallback(self, self.SelectHeroWithChipId)
  self.__DeselectCallback = BindCallback(self, self.DeselectHero)
  self.__SelectNextCallback = BindCallback(self, self.SelectNext)
  self.__OnClickFairyBtn = BindCallback(self, self.OnClickFairyBtn)
  self.__onHeroDataChange = BindCallback(self, self.OnHeroDataChange)
  MsgCenter:AddListener(eMsgEventId.OnEpPlayerHeroDataChange, self.__onHeroDataChange)
  self.__DelayRefreshHeroHp = BindCallback(self, self.DelayRefreshHeroHp)
  MsgCenter:AddListener(eMsgEventId.OnExitRoomComplete, self.__DelayRefreshHeroHp)
  self.__onChipListChange = BindCallback(self, self.OnChipListUpdata)
  MsgCenter:AddListener(eMsgEventId.OnEpChipListChange, self.__onChipListChange)
  self.__OnHeroCoordChanged = BindCallback(self, self.OnHeroCoordChanged)
  MsgCenter:AddListener(eMsgEventId.OnDeployCoordChanged, self.__OnHeroCoordChanged)
  self.__IsRevive = BindCallback(self, self.IsRevive)
  MsgCenter:AddListener(eMsgEventId.OnEpBuffListChange, self.__IsRevive)
end

function UINDungeonHeroList:InitHeroList(dynPlayer, resloader, selectHeroCallback, buffList)
  self.selectHeroCallback = selectHeroCallback
  self.dynPlayer = dynPlayer
  self.heroList = dynPlayer.heroList
  self.resloader = resloader
  self.itemPool:HideAll()
  for _, dynHeroData in ipairs(self.heroList) do
    local heroItem = self.itemPool:GetOne(true)
    heroItem:InitHeroItem(dynHeroData, self.resloader, function()
      self:OnHeroClick(heroItem)
    end)
  end
  local dynFairyData = dynPlayer:GetDynFairyData()
  if dynFairyData ~= nil then
    self.fairyHead:Show()
    self.fairyHead.transform:SetAsLastSibling()
    self.fairyHead:InitFairyHeadItem(dynFairyData, self.resloader, self.__OnClickFairyBtn)
  else
    self.fairyHead:Hide()
  end
  self:OnHeroCoordChanged()
  self:IsRevive(buffList)
end

function UINDungeonHeroList:OnHeroCoordChanged(entity)
  for _, Item in ipairs(self.itemPool.listItem) do
    Item.transform:SetParent(Item.dynHeroData:IsBench() and self.ui.tran_sub or self.ui.tran_main)
    self.fairyHead.transform:SetAsLastSibling()
  end
end

function UINDungeonHeroList:TowerPlacementChange(dataId, isOn)
  for _, Item in ipairs(self.itemPool.listItem) do
    if Item.dynHeroData.dataId == dataId then
      Item.transform:SetParent(isOn and self.ui.tran_main or self.ui.tran_sub)
      self.fairyHead.transform:SetAsLastSibling()
    else
      Item.transform:SetAsLastSibling()
    end
  end
end

function UINDungeonHeroList:OnHeroDataChange()
  if self.OnRevive then
    return
  end
  for _, item in ipairs(self.itemPool.listItem) do
    item:PlayHpChangeAnim()
  end
end

function UINDungeonHeroList:RefreshHeroHp()
  if self.OnRevive then
    return
  end
  for _, item in ipairs(self.itemPool.listItem) do
    item:RefreshHp(true)
  end
end

function UINDungeonHeroList:DelayRefreshHeroHp(fromWhere)
  if self.OnRevive then
    for _, item in ipairs(self.itemPool.listItem) do
      item:PlayHpChangeAnim()
    end
    self.OnRevive = false
  end
  if ExplorationManager:IsInExplorationLight() then
    for _, item in ipairs(self.itemPool.listItem) do
      item:PlayHpChangeAnim()
    end
  end
end

function UINDungeonHeroList:IsRevive(epBuffList)
  local count = 0
  for _, value in ipairs(epBuffList) do
    if value.dataId == 7001 then
      count = count + 1
    end
  end
  if count > self.reviveCount then
    self.reviveCount = count
  elseif count < self.reviveCount then
    self.reviveCount = count
    self.OnRevive = true
    for _, item in ipairs(self.itemPool.listItem) do
      item:FakeDead()
    end
  end
end

function UINDungeonHeroList:OnChipListUpdata()
  for _, item in ipairs(self.itemPool.listItem) do
    item:UpdateChipList()
  end
end

function UINDungeonHeroList:SetIsHideHeroList(bool)
  self.isHideHero = bool
  if bool then
    self:Hide()
  else
    self:Show()
  end
end

function UINDungeonHeroList:SetHpBarActive(bool)
  for _, item in ipairs(self.itemPool.listItem) do
    item:SetHpBarActive(bool)
  end
end

function UINDungeonHeroList:OnHeroClick(heroItem)
  if self.lastSelectItem == heroItem then
    return
  end
  if heroItem.dynHeroData:IsHasGuideResName() then
    return
  end
  if self.lastSelectItem ~= nil then
    self.lastSelectItem:SetSelect(false)
  end
  heroItem:SetSelect(true)
  self.lastSelectItem = heroItem
  self.selectHeroCallback(heroItem)
  local win = UIManager:ShowWindow(UIWindowTypeID.DungeonInfoDetail)
  win:ShowHeroDetail(heroItem.dynHeroData, self.__DeselectCallback, self.__SelectNextCallback)
  win:SetSwitchBtnActive(true)
end

function UINDungeonHeroList:SelectNext(bool)
  if self.lastSelectItem == nil then
    error("switch hero error")
    return
  end
  local index = table.indexof(self.itemPool.listItem, self.lastSelectItem)
  local listNum = #self.itemPool.listItem
  if bool then
    index = index + 1
    if listNum < index then
      index = 1
    end
  else
    index = index - 1
    if index <= 0 then
      index = listNum
    end
  end
  self:OnHeroClick(self.itemPool.listItem[index])
end

function UINDungeonHeroList:DeselectHero()
  if self.lastSelectItem ~= nil then
    self.lastSelectItem:SetSelect(false)
    self.lastSelectItem = nil
  end
  self.selectHeroCallback(nil)
  if self._extraCloseCallback ~= nil then
    self._extraCloseCallback()
  end
  if self.isHideHero then
    self:Hide()
  end
end

function UINDungeonHeroList:SelectHeroWithChipId(chipId, chipColor)
  if chipId == nil then
    if self.isHideHero then
      self:Hide()
    end
    for _, item in ipairs(self.itemPool.listItem) do
      item:SetChipSelect(false)
      item:SetTransparent(false)
    end
    return
  end
  if self.isHideHero then
    self:Show()
  end
  for _, item in ipairs(self.itemPool.listItem) do
    if table.contain(item.chipList, chipId) then
      item:SetChipSelect(true, chipColor)
      item:SetTransparent(false)
    else
      item:SetChipSelect(false)
      item:SetTransparent(true)
    end
  end
end

function UINDungeonHeroList:RegisterExrCloseCallBack(callback)
  self._extraCloseCallback = callback
end

function UINDungeonHeroList:CancleExrCloseCallBack()
  self._extraCloseCallback = nil
end

function UINDungeonHeroList:OnClickFairyBtn(fairyData, introHold)
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonFairyInfo, function(window)
    if window == nil then
      return
    end
    window:InitCommonFairyInfoWin(fairyData, introHold)
  end)
end

function UINDungeonHeroList:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnEpPlayerHeroDataChange, self.__onHeroDataChange)
  MsgCenter:RemoveListener(eMsgEventId.OnEpChipListChange, self.__onChipListChange)
  MsgCenter:RemoveListener(eMsgEventId.OnDeployCoordChanged, self.__OnHeroCoordChanged)
  MsgCenter:RemoveListener(eMsgEventId.OnExitRoomComplete, self.__DelayRefreshHeroHp)
  MsgCenter:RemoveListener(eMsgEventId.OnEpBuffListChange, self.__IsRevive)
  for _, item in ipairs(self.itemPool.listItem) do
    item:Delete()
  end
  base.OnDelete(self)
end

return UINDungeonHeroList
