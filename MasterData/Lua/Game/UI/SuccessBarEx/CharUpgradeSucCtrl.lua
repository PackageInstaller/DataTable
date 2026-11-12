local CharUpgradeSucCtrl = class("CharUpgradeSucCtrl", BaseCtrl)
CharUpgradeSucCtrl._mapNodeConfig = {
  txtNextLevel = {sComponentName = "TMP_Text"},
  txtLvCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Template_CharRank"
  },
  trBg = {sNodeName = "rtProperty", sComponentName = "Transform"},
  goProperty = {},
  ani1 = {sNodeName = "rtTitle", sComponentName = "Animator"}
}
CharUpgradeSucCtrl._mapEventConfig = {}

function CharUpgradeSucCtrl:Open()
  self:RefreshContent()
  local SuccessBar = self:BindCtrlByNode(self.gameObject, "Game.UI.SuccessBarEx.SuccessBarCtrl")
  SuccessBar:PlayAni(AllEnum.SuccessBar.Blue, self.tbAni)
end

function CharUpgradeSucCtrl:RefreshContent()
  self.tbAni = {}
  local nLevel = self._panel.mapData.nLevel
  local mapAttrBefore = self._panel.mapData.mapAttrBefore
  local mapAttrAfter = self._panel.mapData.mapAttrAfter
  NovaAPI.SetTMPText(self._mapNode.txtNextLevel, nLevel)
  table.insert(self.tbAni, self._mapNode.ani1)
  delChildren(self._mapNode.trBg)
  for k, mapAttachAttr in ipairs(AllEnum.CharAttr) do
    local mapAttr = mapAttrBefore[mapAttachAttr.sKey]
    if mapAttr and mapAttr.Value > 0 then
      local goItemObj = instantiate(self._mapNode.goProperty, self._mapNode.trBg)
      goItemObj:SetActive(true)
      local ctrlItem = self:BindCtrlByNode(goItemObj, "Game.UI.TemplateEx.TemplatePropertyCtrl")
      ctrlItem:SetItemProperty(mapAttr.Key, mapAttr.Value, mapAttrAfter[mapAttachAttr.sKey].Value)
      table.insert(self.tbAni, goItemObj.transform:GetComponent("Animator"))
    end
  end
end

function CharUpgradeSucCtrl:Awake()
end

function CharUpgradeSucCtrl:OnEnable()
end

function CharUpgradeSucCtrl:OnDisable()
end

function CharUpgradeSucCtrl:OnDestroy()
end

return CharUpgradeSucCtrl
