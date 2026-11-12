local DiscStarSucCtrl = class("DiscStarSucCtrl", BaseCtrl)
DiscStarSucCtrl._mapNodeConfig = {
  goStar = {
    nCount = 2,
    sCtrlName = "Game.UI.TemplateEx.TemplateDiscLimitCtrl"
  },
  goProperty = {},
  trBg = {sNodeName = "rtProperty", sComponentName = "Transform"},
  txtName = {sComponentName = "TMP_Text"},
  txtDesc = {sComponentName = "TMP_Text"},
  TMP_Link = {
    sNodeName = "txtDesc",
    sComponentName = "TMPHyperLink",
    callback = "OnLinkClick_Word"
  },
  rtStar = {sComponentName = "Transform"},
  imgDescBg = {sComponentName = "Transform"}
}
DiscStarSucCtrl._mapEventConfig = {}

function DiscStarSucCtrl:Open(nType)
  self:RefreshContent()
  local SuccessBar = self:BindCtrlByNode(self.gameObject, "Game.UI.SuccessBarEx.SuccessBarCtrl")
  SuccessBar:PlayAni(nType, self.tbAni)
end

function DiscStarSucCtrl:RefreshContent()
  local ani1 = self._mapNode.rtStar:GetComponent("Animator")
  local ani2 = self._mapNode.imgDescBg:GetComponent("Animator")
  self.tbAni = {}
  local nBeforeStar = self._panel.mapData.nBeforeStar
  local nAfterStar = self._panel.mapData.nAfterStar
  local sDesc = self._panel.mapData.sDesc
  local sName = self._panel.mapData.sName
  local mapAttrBefore = self._panel.mapData.mapAttrBefore
  local mapAttrAfter = self._panel.mapData.mapAttrAfter
  local mapDisc = PlayerData.Disc:GetDiscById(self._panel.mapData.nId)
  self._mapNode.goStar[1]:SetLimit(nBeforeStar + 1, 0, mapDisc.nRarity)
  self._mapNode.goStar[2]:SetLimit(nAfterStar + 1, 0, mapDisc.nRarity)
  table.insert(self.tbAni, ani1)
  delChildren(self._mapNode.trBg)
  for _, mapAttachAttr in pairs(AllEnum.AttachAttr) do
    local mapAttr = mapAttrBefore[mapAttachAttr.sKey]
    if 0 < mapAttr.Value then
      local bValueChanged = mapAttrAfter[mapAttachAttr.sKey].Value ~= mapAttr.Value
      if bValueChanged then
        local goItemObj = instantiate(self._mapNode.goProperty, self._mapNode.trBg)
        goItemObj:SetActive(true)
        local ctrlItem = self:BindCtrlByNode(goItemObj, "Game.UI.TemplateEx.TemplatePropertyCtrl")
        ctrlItem:SetItemProperty(mapAttr.Key, mapAttr.Value, mapAttrAfter[mapAttachAttr.sKey].Value, true)
        table.insert(self.tbAni, goItemObj.transform:GetComponent("Animator"))
      end
    end
  end
  NovaAPI.SetTMPText(self._mapNode.txtName, string.format("「%s」", sName))
  NovaAPI.SetTMPText(self._mapNode.txtDesc, sDesc)
  self._mapNode.txtDesc.gameObject:SetActive(false)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.txtDesc.gameObject:SetActive(true)
  end
  
  cs_coroutine.start(wait)
  table.insert(self.tbAni, ani2)
end

function DiscStarSucCtrl:Awake()
end

function DiscStarSucCtrl:OnEnable()
end

function DiscStarSucCtrl:OnDisable()
end

function DiscStarSucCtrl:OnDestroy()
end

function DiscStarSucCtrl:OnLinkClick_Word(link, sWordId)
  UTILS.ClickWordLink(link, sWordId)
end

return DiscStarSucCtrl
