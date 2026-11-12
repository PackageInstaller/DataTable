local CharAdvanceSucCtrl = class("CharAdvanceSucCtrl", BaseCtrl)
CharAdvanceSucCtrl._mapNodeConfig = {
  txtNextLevel = {nCount = 2, sComponentName = "TMP_Text"},
  goAdvanceStar = {
    sCtrlName = "Game.UI.TemplateEx.TemplateStarAdvanceCtrl"
  },
  trBg = {sNodeName = "rtProperty", sComponentName = "Transform"},
  goProperty = {},
  txtContentDesc = {nCount = 3, sComponentName = "TMP_Text"},
  ani1 = {sNodeName = "rtTitle", sComponentName = "Animator"},
  ani2 = {
    sNodeName = "t_unlockdesc_01",
    sComponentName = "Animator"
  },
  aniLine = {
    nCount = 3,
    sNodeName = "Line",
    sComponentName = "Animator"
  },
  Line = {nCount = 3}
}
CharAdvanceSucCtrl._mapEventConfig = {}

function CharAdvanceSucCtrl:Open()
  self:RefreshContent()
  local SuccessBar = self:BindCtrlByNode(self.gameObject, "Game.UI.SuccessBarEx.SuccessBarCtrl")
  SuccessBar:PlayAni(AllEnum.SuccessBar.Yellow, self.tbAni)
end

function CharAdvanceSucCtrl:RefreshContent()
  self.tbAni = {}
  local nLevel = self._panel.mapData.nLevel
  local nLevelMax = self._panel.mapData.nLevelMax
  local mapAttrBefore = self._panel.mapData.mapAttrBefore
  local mapAttrAfter = self._panel.mapData.mapAttrAfter
  local tbDesc = self._panel.mapData.tbDesc
  local nAdvance = self._panel.mapData.nAdvance
  local nMaxAdvance = self._panel.mapData.nMaxAdvance
  self._mapNode.goAdvanceStar:SetStar(nAdvance, nMaxAdvance)
  NovaAPI.SetTMPText(self._mapNode.txtNextLevel[1], nLevel)
  NovaAPI.SetTMPText(self._mapNode.txtNextLevel[2], "/" .. nLevelMax)
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
  local nCount = tbDesc and #tbDesc or 0
  if nCount == 0 then
    self._mapNode.ani2.gameObject:SetActive(false)
  end
  for i = 1, 3 do
    if i <= nCount then
      if i == 1 then
        table.insert(self.tbAni, {
          self._mapNode.ani2,
          self._mapNode.aniLine[1],
          bMulti = true
        })
      else
        table.insert(self.tbAni, self._mapNode.aniLine[i])
      end
      local txtUnlockDesc = self._mapNode.Line[i].transform:Find("txtUnlockDesc"):GetComponent("TMP_Text")
      NovaAPI.SetTMPText(txtUnlockDesc, tbDesc[i].sFront)
      NovaAPI.SetTMPText(self._mapNode.txtContentDesc[i], tbDesc[i].sAfter)
    end
    self._mapNode.Line[i]:SetActive(i <= nCount)
  end
end

function CharAdvanceSucCtrl:Awake()
end

function CharAdvanceSucCtrl:OnEnable()
end

function CharAdvanceSucCtrl:OnDisable()
end

function CharAdvanceSucCtrl:OnDestroy()
end

return CharAdvanceSucCtrl
