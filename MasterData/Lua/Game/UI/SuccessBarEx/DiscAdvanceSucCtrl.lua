local DiscAdvanceSucCtrl = class("DiscAdvanceSucCtrl", BaseCtrl)
DiscAdvanceSucCtrl._mapNodeConfig = {
  txtNextLevel = {nCount = 2, sComponentName = "TMP_Text"},
  txtLvCn = {sComponentName = "TMP_Text", sLanguageId = "Disc_Level"},
  goProperty = {},
  goBuff = {},
  goAdvanceStar = {
    sCtrlName = "Game.UI.TemplateEx.TemplateStarAdvanceCtrl"
  },
  trBg = {sNodeName = "rtProperty", sComponentName = "Transform"},
  txtLvMax = {sComponentName = "TMP_Text"},
  ani1 = {sNodeName = "rtTitle", sComponentName = "Animator"},
  ani2 = {
    sNodeName = "t_unlockdesc_01",
    sComponentName = "Animator"
  },
  aniLine = {
    nCount = 2,
    sNodeName = "Line",
    sComponentName = "Animator"
  },
  Line = {nCount = 2}
}
DiscAdvanceSucCtrl._mapEventConfig = {}

function DiscAdvanceSucCtrl:Open()
  self:RefreshContent()
  local SuccessBar = self:BindCtrlByNode(self.gameObject, "Game.UI.SuccessBarEx.SuccessBarCtrl")
  SuccessBar:PlayAni(AllEnum.SuccessBar.Yellow, self.tbAni)
end

function DiscAdvanceSucCtrl:RefreshContent()
  self.tbAni = {}
  local nLevel = self._panel.mapData.nLevel
  local nLevelMax = self._panel.mapData.nLevelMax
  local mapAttrBefore = self._panel.mapData.mapAttrBefore
  local mapAttrAfter = self._panel.mapData.mapAttrAfter
  local tbDesc = self._panel.mapData.tbDesc
  local nPhase = self._panel.mapData.nPhase
  local nMaxPhase = self._panel.mapData.nMaxPhase
  local tbUpgradeNote = self._panel.mapData.tbUpgradeNote
  self._mapNode.goAdvanceStar:SetStar(nPhase, nMaxPhase)
  NovaAPI.SetTMPText(self._mapNode.txtNextLevel[1], nLevel)
  NovaAPI.SetTMPText(self._mapNode.txtNextLevel[2], "/" .. nLevelMax)
  NovaAPI.SetTMPText(self._mapNode.txtLvMax, nLevelMax)
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
  for _, v in pairs(tbUpgradeNote) do
    local goItemObj = instantiate(self._mapNode.goProperty, self._mapNode.trBg)
    goItemObj:SetActive(true)
    local ctrlItem = self:BindCtrlByNode(goItemObj, "Game.UI.TemplateEx.TemplatePropertyCtrl")
    ctrlItem:SetNote(v[1], v[2], v[3], true)
    table.insert(self.tbAni, goItemObj.transform:GetComponent("Animator"))
  end
  local nCount = tbDesc and #tbDesc or 0
  if 0 < nCount then
    local goGrid = instantiate(self._mapNode.goBuff, self._mapNode.trBg)
    goGrid:SetActive(true)
    local txtBuff = goGrid.transform:Find("--Basic--/txtBuff")
    if txtBuff ~= nil then
      NovaAPI.SetTMPText(txtBuff:GetComponent("TMP_Text"), tbDesc[1].sFront)
    end
    local txtBuffContent = goGrid.transform:Find("--Basic--/txtBuffContent")
    if txtBuffContent ~= nil then
      NovaAPI.SetTMPText(txtBuffContent:GetComponent("TMP_Text"), tbDesc[1].sAfter)
    end
    table.insert(self.tbAni, goGrid.transform:GetComponent("Animator"))
  end
end

function DiscAdvanceSucCtrl:Awake()
end

function DiscAdvanceSucCtrl:OnEnable()
end

function DiscAdvanceSucCtrl:OnDisable()
end

function DiscAdvanceSucCtrl:OnDestroy()
end

return DiscAdvanceSucCtrl
