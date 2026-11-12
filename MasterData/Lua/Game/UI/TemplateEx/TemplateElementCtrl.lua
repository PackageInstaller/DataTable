local TemplateElementCtrl = class("TemplateElementCtrl", BaseCtrl)
local ElementColor = {
  [GameEnum.elementType.WE] = Color(0.3058823529411765, 0.6235294117647059, 0.8470588235294118),
  [GameEnum.elementType.FE] = Color(0.9372549019607843, 0.3215686274509804, 0.1803921568627451),
  [GameEnum.elementType.SE] = Color(0.6313725490196078, 0.403921568627451, 0.23921568627450981),
  [GameEnum.elementType.AE] = Color(0.5294117647058824, 0.7490196078431373, 0.06274509803921569),
  [GameEnum.elementType.LE] = Color(0.9529411764705882, 0.7098039215686275, 0.12941176470588237),
  [GameEnum.elementType.DE] = Color(0.6941176470588235, 0.37254901960784315, 0.6235294117647059)
}
TemplateElementCtrl._mapNodeConfig = {
  imgElementBg = {sComponentName = "Image"},
  txtTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "T_Element_Property"
  },
  txtElement = {sComponentName = "TMP_Text"},
  imgElementIcon = {sComponentName = "Image"}
}
TemplateElementCtrl._mapEventConfig = {}

function TemplateElementCtrl:Refresh(nEET)
  local sName = AllEnum.ElementIconType.Icon .. nEET
  self:SetAtlasSprite(self._mapNode.imgElementIcon, "12_rare", sName)
  NovaAPI.SetImageColor(self._mapNode.imgElementBg, ElementColor[nEET])
  NovaAPI.SetTMPText(self._mapNode.txtElement, ConfigTable.GetUIText("T_Element_Attr_" .. nEET))
end

return TemplateElementCtrl
