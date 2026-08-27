local UINEventOptionGiftSelect = class("UINEventOptionGiftSelect", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local UINCmUseGiftItem = require("Game.CommonUI.UseGift.UINCmUseGiftItem")
local cs_MessageCommon = CS.MessageCommon

function UINEventOptionGiftSelect:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.OnClickConfitm)
  UIUtil.AddButtonListener(self.ui.btn_Cancle, self, self.OnClickBack)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickBack)
  self.__OnSelectItemCallback = BindCallback(self, self.__OnSelectItem)
  self._waitSelectItemPool = UIItemPool.New(UINCmUseGiftItem, self.ui.uINBaseItemWithCount)
  self.ui.uINBaseItemWithCount:SetActive(false)
  self._showSelectItemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.uINBaseItemWithCount_1)
  self.ui.uINBaseItemWithCount_1:SetActive(false)
  self._selectMarkList = {}
  table.insert(self._selectMarkList, self.ui.img_Selected)
  self._emptyList = {}
  table.insert(self._emptyList, self.ui.empty)
end

function UINEventOptionGiftSelect:InitEventOptionGiftSelect(payGiftInfo, confirmFunc)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.Hide):SetTopStatusVisible(false):PushTopStatusDataToBackStack(true)
  self._payGiftInfo = payGiftInfo
  self._confirmFunc = confirmFunc
  self._itemNodeDic = {}
  self._itemCountDic = {}
  self._selectItemList = {}
  self._customCfg = self._payGiftInfo:GetSelectGiftCustomCfg()
  self._waitSelectItemPool:HideAll()
  for i, itemId in ipairs(self._customCfg.param1) do
    local itemCfg = ConfigData.item[itemId]
    local itemCount = self._customCfg.param2[i]
    local item = self._waitSelectItemPool:GetOne()
    item:InitCmUseGiftItem(itemCfg, itemCount, self.__OnSelectItemCallback)
    self._itemNodeDic[itemId] = item
    self._itemCountDic[itemId] = itemCount
  end
  self:__RefreshSelectState()
end

function UINEventOptionGiftSelect:__OnSelectItem(itemCfg)
  if table.contain(self._selectItemList, itemCfg.id) then
    table.removebyvalue(self._selectItemList, itemCfg.id)
    self:__RefreshSelectState()
    return
  end
  if #self._selectItemList >= self._payGiftInfo:GetSelectGiftCustomCount() then
    return
  end
  table.insert(self._selectItemList, itemCfg.id)
  self:__RefreshSelectState()
end

function UINEventOptionGiftSelect:__RefreshSelectState()
  self.ui.tex_Tip:SetIndex(0, tostring(self._payGiftInfo:GetSelectGiftCustomCount()), tostring(#self._selectItemList))
  for i, go in ipairs(self._selectMarkList) do
    local itemId = self._selectItemList[i]
    go:SetActive(itemId ~= nil)
    if itemId ~= nil then
      local itemNode = self._itemNodeDic[itemId]
      go.transform:SetParent(itemNode.transform)
      go.transform.localPosition = Vector3.zero
      go:SetActive(true)
    end
  end
  for i = #self._selectMarkList + 1, #self._selectItemList do
    local go = self.ui.img_Selected:Instantiate()
    local itemId = self._selectItemList[i]
    local itemNode = self._itemNodeDic[itemId]
    go.transform:SetParent(itemNode.transform)
    go.transform.localPosition = Vector3.zero
    go:SetActive(true)
    table.insert(self._selectMarkList, go)
  end
  self._showSelectItemPool:HideAll()
  for i, itemId in ipairs(self._selectItemList) do
    local item = self._showSelectItemPool:GetOne()
    local itemCount = self._itemCountDic[itemId]
    local itemCfg = ConfigData.item[itemId]
    item:InitItemWithCount(itemCfg, itemCount)
  end
  local remainCount = self._payGiftInfo:GetSelectGiftCustomCount() - #self._selectItemList
  for i, go in ipairs(self._emptyList) do
    local flag = i <= remainCount
    go:SetActive(flag)
    if flag then
      go.transform:SetAsLastSibling()
    end
  end
  for i = #self._emptyList + 1, remainCount do
    local go = self.ui.empty:Instantiate(self.ui.empty.transform.parent)
    go:SetActive(true)
    table.insert(self._emptyList, go)
  end
end

function UINEventOptionGiftSelect:OnClickBack()
  UIUtil.OnClickBackByUiTab(self)
end

function UINEventOptionGiftSelect:OnClickConfitm()
  if #self._selectItemList ~= self._payGiftInfo:GetSelectGiftCustomCount() then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(424))
    return
  end
  if self._confirmFunc ~= nil then
    local selectItemNums = {}
    for i, itemId in ipairs(self._selectItemList) do
      table.insert(selectItemNums, self._itemCountDic[itemId])
    end
    self._confirmFunc(self._payGiftInfo, self._selectItemList, selectItemNums)
  end
  self:OnClickBack()
end

return UINEventOptionGiftSelect
