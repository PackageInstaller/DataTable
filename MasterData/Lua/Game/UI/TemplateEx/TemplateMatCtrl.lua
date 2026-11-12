local TemplateMatCtrl = class("TemplateMatCtrl", BaseCtrl)
local _, Green = ColorUtility.TryParseHtmlString("#0ABEC5")
TemplateMatCtrl._mapNodeConfig = {
  goItem = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  txtCost = {sComponentName = "TMP_Text"},
  rtSelect = {},
  txtHas = {sComponentName = "TMP_Text"},
  txtRequire = {sComponentName = "TMP_Text"},
  goReduce = {},
  imgMask = {}
}
TemplateMatCtrl._mapEventConfig = {}

function TemplateMatCtrl:SetEmpty(nItemId)
  self._mapNode.goItem:SetItem(nItemId)
  self._mapNode.rtSelect:SetActive(false)
  self._mapNode.imgMask:SetActive(false)
  self._mapNode.txtRequire.gameObject:SetActive(false)
end

function TemplateMatCtrl:SetMat(nItemId, nRequireCount, nCustomHas)
  self.nHasCount = nCustomHas and nCustomHas or PlayerData.Item:GetItemCountByID(nItemId)
  self.nItemId = nItemId
  self:SetSelectCount()
  if 0 == nItemId then
    self:SetEmpty()
  elseif nRequireCount then
    self._mapNode.goItem:SetItem(nItemId)
    self._mapNode.txtRequire.gameObject:SetActive(true)
    self._mapNode.rtSelect:SetActive(false)
    if self.nHasCount > 1000 then
      local nFloor = math.floor(self.nHasCount / 100)
      local nK = string.format("%.1f", nFloor / 10)
      local sHas = nK .. "k"
      NovaAPI.SetTMPText(self._mapNode.txtHas, sHas)
    else
      NovaAPI.SetTMPText(self._mapNode.txtHas, self.nHasCount)
    end
    NovaAPI.SetTMPColor(self._mapNode.txtHas, nRequireCount <= self.nHasCount and Green or Red_Unable)
    if 1000 < nRequireCount then
      local nFloor = math.floor(nRequireCount / 100)
      local nK = string.format("%.1f", nFloor / 10)
      local sRequire = nK .. "k"
      NovaAPI.SetTMPText(self._mapNode.txtRequire, "/" .. sRequire)
    else
      NovaAPI.SetTMPText(self._mapNode.txtRequire, "/" .. nRequireCount)
    end
    self._mapNode.imgMask:SetActive(false)
  else
    self._mapNode.imgMask:SetActive(self.nHasCount <= 0)
    self._mapNode.txtRequire.gameObject:SetActive(false)
    self._mapNode.rtSelect:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txtCost, self.nHasCount)
    self._mapNode.goItem:SetItem(nItemId)
  end
end

function TemplateMatCtrl:SetSelectCount(nCount)
  if nCount and 0 < nCount then
    self._mapNode.goReduce:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txtCost, self.nHasCount - nCount)
    NovaAPI.SetTMPColor(self._mapNode.txtCost, Blue_Normal)
    self._mapNode.goItem:SetItem(self.nItemId, nil, nCount, nil, nil, nil, nil, true, true)
  else
    NovaAPI.SetTMPText(self._mapNode.txtCost, self.nHasCount)
    self._mapNode.goReduce:SetActive(false)
    self._mapNode.goItem:SetItem(self.nItemId)
  end
end

function TemplateMatCtrl:SetSelect(flage)
  if self.nItemId == 0 then
    return
  end
  self._mapNode.goItem:SetMultiSelected_Blue(flage)
end

return TemplateMatCtrl
