local TemplateSortBtnCtrl = class("TemplateSortBtnCtrl", BaseCtrl)
local SortColor = {
  Enabled = Color(0.14901960784313725, 0.25882352941176473, 0.47058823529411764),
  Disabled = Color(0.5803921568627451, 0.6666666666666666, 0.7529411764705882)
}
TemplateSortBtnCtrl._mapNodeConfig = {
  txtSort = {sComponentName = "TMP_Text"},
  imgUp = {sComponentName = "Image"},
  imgDown = {sComponentName = "Image"}
}
TemplateSortBtnCtrl._mapEventConfig = {}

function TemplateSortBtnCtrl:SetText(sLanguageId)
  NovaAPI.SetTMPText(self._mapNode.txtSort, ConfigTable.GetUIText(sLanguageId))
end

function TemplateSortBtnCtrl:Refresh(bEnabled, bOrder)
  if bEnabled then
    NovaAPI.SetTMPColor(self._mapNode.txtSort, SortColor.Enabled)
    NovaAPI.SetImageColor(self._mapNode.imgUp, bOrder and SortColor.Disabled or SortColor.Enabled)
    NovaAPI.SetImageColor(self._mapNode.imgDown, bOrder and SortColor.Enabled or SortColor.Disabled)
  else
    NovaAPI.SetTMPColor(self._mapNode.txtSort, SortColor.Disabled)
    NovaAPI.SetImageColor(self._mapNode.imgUp, SortColor.Disabled)
    NovaAPI.SetImageColor(self._mapNode.imgDown, SortColor.Disabled)
  end
end

return TemplateSortBtnCtrl
