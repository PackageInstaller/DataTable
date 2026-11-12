local TemplateMatGridCtrl = class("TemplateMatGridCtrl", BaseCtrl)
TemplateMatGridCtrl._mapNodeConfig = {
  goItem = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  goEmpty = {},
  txtCost = {sComponentName = "TMP_Text"},
  rtSelect = {},
  goReduce = {}
}
TemplateMatGridCtrl._mapEventConfig = {}

function TemplateMatGridCtrl:RerfeshGrid(mapData)
  self._mapNode.goReduce:SetActive(false)
  self._mapNode.rtSelect:SetActive(false)
  self._mapNode.goItem.gameObject:SetActive(true)
  self._mapNode.goEmpty:SetActive(false)
  self.nType = mapData.nType
  if self.nType == GameEnum.itemStype.DiscLimitBreak then
    self._mapNode.goItem:SetItem(mapData.nId, nil, nil, nil, nil, nil, nil, true, true)
  else
    self.nHasCount = PlayerData.Item:GetItemCountByID(mapData.nId)
    self.nItemId = mapData.nId
    self._mapNode.goItem:SetItem(mapData.nId, nil, self.nHasCount, nil, nil, nil, nil, true, true)
  end
end

function TemplateMatGridCtrl:RerfeshSelected(mapData)
  self._mapNode.goReduce:SetActive(false)
  self._mapNode.rtSelect:SetActive(false)
  self._mapNode.goItem.gameObject:SetActive(mapData)
  self._mapNode.goEmpty:SetActive(not mapData)
  if not mapData then
    return
  end
  self.nType = mapData.nType
  if self.nType == GameEnum.itemStype.DiscLimitBreak then
    self._mapNode.goItem:SetItem(mapData.nId, nil, nil, nil, nil, nil, nil, true, true)
  else
    self.nHasCount = mapData.nCost
    self.nItemId = mapData.nId
    self._mapNode.goItem:SetItem(mapData.nId, nil, self.nHasCount, nil, nil, nil, nil, true, true)
  end
end

function TemplateMatGridCtrl:SetGridCount(nCount)
  if self.nType ~= GameEnum.itemStype.DiscLimitBreak then
    if nCount and 0 < nCount then
      self._mapNode.goReduce:SetActive(true)
      NovaAPI.SetTMPText(self._mapNode.txtCost, nCount)
      self._mapNode.rtSelect:SetActive(true)
      self._mapNode.goItem:SetItem(self.nItemId, nil, self.nHasCount - nCount, nil, nil, nil, nil, true, true)
    else
      self._mapNode.rtSelect:SetActive(false)
      self._mapNode.goReduce:SetActive(false)
      self._mapNode.goItem:SetItem(self.nItemId, nil, self.nHasCount, nil, nil, nil, nil, true, true)
    end
  end
  self:SetMultiSelected_Blue(nCount and 0 < nCount)
end

function TemplateMatGridCtrl:SetSelectedCount(nCount)
  self._mapNode.goReduce:SetActive(true)
  if self.nType ~= GameEnum.itemStype.DiscLimitBreak then
    self._mapNode.goItem:SetItem(self.nItemId, nil, nCount, nil, nil, nil, nil, true)
  end
end

function TemplateMatGridCtrl:SetSelect(bSelect)
  self._mapNode.goItem:SetSelect(bSelect)
end

function TemplateMatGridCtrl:SetLock(bLock)
  self._mapNode.goItem:SetLock(bLock)
end

function TemplateMatGridCtrl:SetMultiSelected_Blue(bSelect)
  self._mapNode.goItem:SetMultiSelected_Blue(bSelect)
end

return TemplateMatGridCtrl
