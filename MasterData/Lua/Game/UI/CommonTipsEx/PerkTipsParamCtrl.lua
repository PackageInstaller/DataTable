local PerkTipsParamCtrl = class("PerkTipsParamCtrl", BaseCtrl)
local color_singular = "#e8eef2"
local color_even = "#ffffff"
PerkTipsParamCtrl._mapNodeConfig = {
  imgBg = {nCount = 4, sComponentName = "Image"},
  txtParamName = {sComponentName = "TMP_Text"},
  txtParamValue = {sComponentName = "TMP_Text"}
}
PerkTipsParamCtrl._mapEventConfig = {}

function PerkTipsParamCtrl:RefreshParam(nIndex, nAllCount, sName, sValue)
  local sColor = nIndex % 2 == 0 and color_even or color_singular
  local _b, _color = ColorUtility.TryParseHtmlString(sColor)
  for _, v in ipairs(self._mapNode.imgBg) do
    NovaAPI.SetImageColor(v, _color)
    v.gameObject:SetActive(false)
  end
  if nIndex == 1 then
    if nAllCount == 1 then
      self._mapNode.imgBg[1].gameObject:SetActive(true)
    else
      self._mapNode.imgBg[2].gameObject:SetActive(true)
    end
  elseif nIndex == nAllCount then
    self._mapNode.imgBg[4].gameObject:SetActive(true)
  else
    self._mapNode.imgBg[3].gameObject:SetActive(true)
  end
  NovaAPI.SetTMPText(self._mapNode.txtParamName, sName)
  NovaAPI.SetTMPText(self._mapNode.txtParamValue, sValue)
end

return PerkTipsParamCtrl
