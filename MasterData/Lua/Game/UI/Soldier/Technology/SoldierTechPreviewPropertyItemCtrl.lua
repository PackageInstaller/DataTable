local SoldierTechPreviewPropertyItemCtrl = class("SoldierTechPreviewPropertyItemCtrl", BaseCtrl)
SoldierTechPreviewPropertyItemCtrl._mapNodeConfig = {
  imgIcon = {sComponentName = "Image"},
  txtProperty = {sComponentName = "TMP_Text"},
  txtValue2 = {sComponentName = "TMP_Text"}
}
SoldierTechPreviewPropertyItemCtrl._mapEventConfig = {}
SoldierTechPreviewPropertyItemCtrl._mapRedDotConfig = {}

function SoldierTechPreviewPropertyItemCtrl:Awake()
end

function SoldierTechPreviewPropertyItemCtrl:OnEnable()
end

function SoldierTechPreviewPropertyItemCtrl:OnDisable()
end

function SoldierTechPreviewPropertyItemCtrl:OnDestroy()
end

function SoldierTechPreviewPropertyItemCtrl:Refresh(sIcon, sName, sValue)
  if sIcon and 0 < #sIcon then
    self:SetPngSprite(self._mapNode.imgIcon, sIcon)
    self._mapNode.imgIcon.gameObject:SetActive(true)
  else
    self._mapNode.imgIcon.gameObject:SetActive(false)
  end
  NovaAPI.SetTMPText(self._mapNode.txtProperty, sName or "")
  NovaAPI.SetTMPText(self._mapNode.txtValue2, sValue or "")
end

return SoldierTechPreviewPropertyItemCtrl
