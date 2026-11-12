local DepotItemInfoCtrl = class("DepotItemInfoCtrl", BaseCtrl)
DepotItemInfoCtrl._mapNodeConfig = {
  goSkill = {
    sCtrlName = "Game.UI.DepotEx.DepotInfoSkillCtrl"
  },
  goDescribe = {
    sCtrlName = "Game.UI.DepotEx.DepotInfoDescribeCtrl"
  },
  goSource = {
    sCtrlName = "Game.UI.DepotEx.DepotInfoSourceCtrl"
  },
  Content = {
    sComponentName = "RectTransform"
  },
  Scrollbar = {sComponentName = "Transform"}
}
DepotItemInfoCtrl._mapEventConfig = {}

function DepotItemInfoCtrl:SetItemInfo(nTog, mapItem)
  self._mapNode.Scrollbar.localScale = Vector3.zero
  self:SetItem(mapItem.nTid)
  self._mapNode.Scrollbar.localScale = Vector3.one
end

function DepotItemInfoCtrl:SetItem(nId)
  self._mapNode.goSkill.gameObject:SetActive(false)
  self._mapNode.goDescribe.gameObject:SetActive(true)
  self._mapNode.goSource.gameObject:SetActive(true)
  self._mapNode.goDescribe:SetDesc(nId)
  self._mapNode.goSource:Refresh(nId)
end

function DepotItemInfoCtrl:Awake()
end

function DepotItemInfoCtrl:OnEnable()
end

function DepotItemInfoCtrl:OnDisable()
end

function DepotItemInfoCtrl:OnDestroy()
end

return DepotItemInfoCtrl
