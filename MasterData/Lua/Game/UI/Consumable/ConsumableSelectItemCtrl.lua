local ConsumableSelectItemCtrl = class("ConsumableSelectItemCtrl", BaseCtrl)
ConsumableSelectItemCtrl._mapNodeConfig = {
  rtItem = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  imgSelect = {}
}
ConsumableSelectItemCtrl._mapEventConfig = {}
ConsumableSelectItemCtrl._mapRedDotConfig = {}

function ConsumableSelectItemCtrl:Awake()
end

function ConsumableSelectItemCtrl:FadeIn()
end

function ConsumableSelectItemCtrl:FadeOut()
end

function ConsumableSelectItemCtrl:OnEnable()
end

function ConsumableSelectItemCtrl:OnDisable()
end

function ConsumableSelectItemCtrl:OnDestroy()
end

function ConsumableSelectItemCtrl:OnRelease()
end

function ConsumableSelectItemCtrl:Refresh(nTid, nCount, bSelect)
  self._mapNode.rtItem:SetItem(nTid, nil, nCount, nil, nil, false, false, false, false)
  self._mapNode.imgSelect:SetActive(bSelect)
end

function ConsumableSelectItemCtrl:SetSelect(bSelect)
  self._mapNode.imgSelect:SetActive(bSelect)
end

return ConsumableSelectItemCtrl
