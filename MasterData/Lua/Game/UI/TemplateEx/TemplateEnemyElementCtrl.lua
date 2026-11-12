local TemplateEnemyElementCtrl = class("TemplateEnemyElementCtrl", BaseCtrl)
local ElementColor = {
  [GameEnum.elementType.WE] = Color(0.3058823529411765, 0.6235294117647059, 0.8470588235294118),
  [GameEnum.elementType.FE] = Color(0.9372549019607843, 0.3215686274509804, 0.1803921568627451),
  [GameEnum.elementType.SE] = Color(0.6313725490196078, 0.403921568627451, 0.23921568627450981),
  [GameEnum.elementType.AE] = Color(0.5294117647058824, 0.7490196078431373, 0.06274509803921569),
  [GameEnum.elementType.LE] = Color(0.9529411764705882, 0.7098039215686275, 0.12941176470588237),
  [GameEnum.elementType.DE] = Color(0.6941176470588235, 0.37254901960784315, 0.6235294117647059)
}
TemplateEnemyElementCtrl._mapNodeConfig = {
  imgElementBg = {sComponentName = "Image"},
  txtTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "T_Element_Weakness"
  },
  imgElementIcon = {nCount = 3, sComponentName = "Image"}
}
TemplateEnemyElementCtrl._mapEventConfig = {}

function TemplateEnemyElementCtrl:Refresh(tbEETList)
  for _, v in ipairs(self._mapNode.imgElementIcon) do
    v.gameObject:SetActive(false)
  end
  for k, nEET in ipairs(tbEETList) do
    if nil ~= nEET and 0 ~= nEET and nil ~= self._mapNode.imgElementIcon[k] then
      self._mapNode.imgElementIcon[k].gameObject:SetActive(true)
      local sName = AllEnum.ElementIconType.Icon .. nEET
      self:SetAtlasSprite(self._mapNode.imgElementIcon[k], "12_rare", sName)
    end
  end
end

return TemplateEnemyElementCtrl
