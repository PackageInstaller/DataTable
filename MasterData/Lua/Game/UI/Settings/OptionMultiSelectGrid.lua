local OptionMultiSelectGrid = class("OptionMultiSelectGrid", BaseCtrl)
OptionMultiSelectGrid._mapNodeConfig = {
  imgChooseOutter = {},
  imgChooseInner = {},
  txtSortNum = {sComponentName = "TMP_Text"},
  txtGrid = {sComponentName = "TMP_Text"}
}
OptionMultiSelectGrid._mapEventConfig = {}

function OptionMultiSelectGrid:OnEnable()
  self.nIndex = 0
  self.nSort = 0
end

function OptionMultiSelectGrid:Init(sTitle, nIndex)
  self.nIndex = nIndex
  NovaAPI.SetTMPText(self._mapNode.txtGrid, sTitle)
  self._mapNode.imgChooseOutter:SetActive(false)
  self._mapNode.imgChooseInner:SetActive(false)
  NovaAPI.SetTMPText(self._mapNode.txtSortNum, "")
end

function OptionMultiSelectGrid:SetSelect(bSelect, nSort)
  self.nSort = nSort
  NovaAPI.SetTMPText(self._mapNode.txtSortNum, nSort)
  self._mapNode.imgChooseOutter:SetActive(bSelect)
  self._mapNode.imgChooseInner:SetActive(bSelect)
end

function OptionMultiSelectGrid:GetIndex()
  return self.nIndex
end

function OptionMultiSelectGrid:GetSort()
  return self.nSort
end

return OptionMultiSelectGrid
