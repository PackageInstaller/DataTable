local TemplateAffixCtrl = class("TemplateAffixCtrl", BaseCtrl)
local _, Gray = ColorUtility.TryParseHtmlString("#B5C3D0")
TemplateAffixCtrl._mapNodeConfig = {
  imgBgNormal = {},
  imgBgActive = {},
  txtActive = {
    sComponentName = "TMP_Text",
    sLanguageId = "Template_Active"
  },
  imgAffixIcon = {sComponentName = "Image"},
  txtAffixUnlock = {sComponentName = "TMP_Text"},
  txtAffixDesc = {sComponentName = "TMP_Text"},
  imgAffixLock = {}
}
TemplateAffixCtrl._mapEventConfig = {}

function TemplateAffixCtrl:SetAffix(sDesc, sIcon, bNew, bLock, nLimit)
  self._mapNode.imgBgNormal:SetActive(not bNew)
  self._mapNode.imgBgActive:SetActive(bNew)
  self:SetPngSprite(self._mapNode.imgAffixIcon, sIcon)
  NovaAPI.SetImageColor(self._mapNode.imgAffixIcon, bLock and Gray or Blue_Normal)
  NovaAPI.SetTMPText(self._mapNode.txtAffixDesc, sDesc)
  NovaAPI.SetTMPColor(self._mapNode.txtAffixDesc, bLock and Gray or Blue_Normal)
  self._mapNode.imgAffixLock:SetActive(bLock)
  self._mapNode.txtAffixUnlock.gameObject:SetActive(bLock)
  if bLock then
    NovaAPI.SetTMPText(self._mapNode.txtAffixUnlock, nLimit)
  end
end

return TemplateAffixCtrl
