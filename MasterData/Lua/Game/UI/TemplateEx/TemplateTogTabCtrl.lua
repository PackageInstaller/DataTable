local TemplateTogTabCtrl = class("TemplateTogTabCtrl", BaseCtrl)
TemplateTogTabCtrl._mapNodeConfig = {
  imgOff = {nCount = 2},
  imgOn = {nCount = 2},
  txtLeft = {sComponentName = "TMP_Text", nCount = 2},
  txtRight = {sComponentName = "TMP_Text", nCount = 2}
}
TemplateTogTabCtrl._mapEventConfig = {}
TemplateTogTabCtrl._mapRedDotConfig = {}

function TemplateTogTabCtrl:Awake()
end

function TemplateTogTabCtrl:FadeIn()
end

function TemplateTogTabCtrl:FadeOut()
end

function TemplateTogTabCtrl:OnEnable()
end

function TemplateTogTabCtrl:OnDisable()
end

function TemplateTogTabCtrl:OnDestroy()
end

function TemplateTogTabCtrl:OnRelease()
end

function TemplateTogTabCtrl:SetText(sRight, sLeft)
  NovaAPI.SetTMPText(self._mapNode.txtLeft[1], sLeft)
  NovaAPI.SetTMPText(self._mapNode.txtLeft[2], sLeft)
  NovaAPI.SetTMPText(self._mapNode.txtRight[1], sRight)
  NovaAPI.SetTMPText(self._mapNode.txtRight[2], sRight)
end

function TemplateTogTabCtrl:SetState(bRight)
  self._mapNode.imgOff[1]:SetActive(bRight)
  self._mapNode.imgOff[2]:SetActive(not bRight)
  self._mapNode.imgOn[1]:SetActive(not bRight)
  self._mapNode.imgOn[2]:SetActive(bRight)
end

return TemplateTogTabCtrl
