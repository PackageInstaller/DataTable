local DiscUpgradeSucCtrl = class("DiscUpgradeSucCtrl", BaseCtrl)
DiscUpgradeSucCtrl._mapNodeConfig = {
  txtNextLevel = {sComponentName = "TMP_Text"},
  txtLvCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Outfit_Level"
  },
  goProperty = {},
  trBg = {sNodeName = "rtProperty", sComponentName = "Transform"},
  ani1 = {sNodeName = "rtTitle", sComponentName = "Animator"}
}
DiscUpgradeSucCtrl._mapEventConfig = {}

function DiscUpgradeSucCtrl:Open()
  self:RefreshContent()
  local SuccessBar = self:BindCtrlByNode(self.gameObject, "Game.UI.SuccessBarEx.SuccessBarCtrl")
  SuccessBar:PlayAni(AllEnum.SuccessBar.Blue, self.tbAni)
end

function DiscUpgradeSucCtrl:RefreshContent()
  self.tbAni = {}
  local nLevel = self._panel.mapData.nLevel
  local mapAttrBefore = self._panel.mapData.mapAttrBefore
  local mapAttrAfter = self._panel.mapData.mapAttrAfter
  NovaAPI.SetTMPText(self._mapNode.txtNextLevel, nLevel)
  table.insert(self.tbAni, self._mapNode.ani1)
  delChildren(self._mapNode.trBg)
  for _, mapAttachAttr in pairs(AllEnum.AttachAttr) do
    local mapAttr = mapAttrBefore[mapAttachAttr.sKey]
    if mapAttr.Value > 0 then
      local goItemObj = instantiate(self._mapNode.goProperty, self._mapNode.trBg)
      goItemObj:SetActive(true)
      local ctrlItem = self:BindCtrlByNode(goItemObj, "Game.UI.TemplateEx.TemplatePropertyCtrl")
      local bValueChanged = mapAttrAfter[mapAttachAttr.sKey].Value ~= mapAttr.Value
      if bValueChanged then
        ctrlItem:SetItemProperty(mapAttr.Key, mapAttr.Value, mapAttrAfter[mapAttachAttr.sKey].Value, true)
      else
        ctrlItem:SetItemProperty(mapAttr.Key, mapAttr.Value, nil, true)
      end
      table.insert(self.tbAni, goItemObj.transform:GetComponent("Animator"))
    end
  end
end

function DiscUpgradeSucCtrl:Awake()
end

function DiscUpgradeSucCtrl:OnEnable()
end

function DiscUpgradeSucCtrl:OnDisable()
end

function DiscUpgradeSucCtrl:OnDestroy()
end

return DiscUpgradeSucCtrl
