local TemplateCharInfoCtrl = class("TemplateCharInfoCtrl", BaseCtrl)
local ElementColor = {
  [GameEnum.elementType.WE] = Color(0.3058823529411765, 0.6235294117647059, 0.8470588235294118),
  [GameEnum.elementType.FE] = Color(0.9372549019607843, 0.3215686274509804, 0.1803921568627451),
  [GameEnum.elementType.SE] = Color(0.6313725490196078, 0.403921568627451, 0.23921568627450981),
  [GameEnum.elementType.AE] = Color(0.5294117647058824, 0.7490196078431373, 0.06274509803921569),
  [GameEnum.elementType.LE] = Color(0.9529411764705882, 0.7098039215686275, 0.12941176470588237),
  [GameEnum.elementType.DE] = Color(0.6941176470588235, 0.37254901960784315, 0.6235294117647059)
}
TemplateCharInfoCtrl._mapNodeConfig = {
  imgElementBg = {sComponentName = "Image"},
  txtTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "T_Element_Property"
  },
  txtElement = {sComponentName = "TMP_Text"},
  imgElementIcon = {sComponentName = "Image"},
  txtName = {sComponentName = "TMP_Text"},
  imgRareName = {sComponentName = "Image"},
  imgCharColor = {sComponentName = "Image"},
  txtLv = {sComponentName = "TMP_Text", sLanguageId = "Lv"},
  txtLevel = {sComponentName = "TMP_Text"}
}
TemplateCharInfoCtrl._mapEventConfig = {}

function TemplateCharInfoCtrl:Refresh(mapChar, configData, mapTrailCfg)
  local nLv = mapTrailCfg and mapTrailCfg.Level or mapChar.nLevel
  local nEET = configData.EET
  local sName = configData.Name
  local Grade = configData.Grade
  local CharColor
  local mapCharDescCfg = ConfigTable.GetData("CharacterDes", mapTrailCfg and mapTrailCfg.CharId or mapChar.nId)
  if mapCharDescCfg ~= nil then
    CharColor = mapCharDescCfg.CharColor
  else
    CharColor = ""
  end
  NovaAPI.SetTMPText(self._mapNode.txtLevel, nLv)
  local Name = AllEnum.ElementIconType.Icon .. nEET
  self:SetAtlasSprite(self._mapNode.imgElementIcon, "12_rare", Name)
  NovaAPI.SetImageColor(self._mapNode.imgElementBg, ElementColor[nEET])
  NovaAPI.SetTMPText(self._mapNode.txtElement, ConfigTable.GetUIText("T_Element_Attr_" .. nEET))
  NovaAPI.SetTMPText(self._mapNode.txtName, mapTrailCfg and mapTrailCfg.Name or sName)
  self:SetSprite_FrameColor(self._mapNode.imgRareName, Grade, AllEnum.FrameType_New.Text)
  NovaAPI.SetImageNativeSize(self._mapNode.imgRareName)
  local _, colorChar = ColorUtility.TryParseHtmlString(CharColor)
  NovaAPI.SetImageColor(self._mapNode.imgCharColor, colorChar)
end

return TemplateCharInfoCtrl
