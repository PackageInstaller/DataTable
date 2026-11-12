local FormationCharListItem = class("FormationCharListItem", BaseCtrl)
FormationCharListItem._mapNodeConfig = {
  Mask = {},
  TMPHint = {
    sComponentName = "TMP_Text",
    sLanguageId = "In_Formation"
  },
  TMPSelectIdx = {sComponentName = "TMP_Text"},
  imgSelectIcon = {},
  imgSelect = {},
  goChar = {
    sCtrlName = "Game.UI.TemplateEx.TemplateCharCtrl"
  },
  btnGrid = {sComponentName = "UIButton"},
  btnMask = {
    sNodeName = "Mask",
    sComponentName = "Button",
    callback = "OnBtnClick_Mask"
  },
  t_team_leader = {},
  t_team_sub = {},
  txtLeader = {
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Leader"
  },
  txtSub = {sComponentName = "TMP_Text", sLanguageId = "Build_Sub"},
  TMPSelectTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "RoguelikeBuild_Manage_SelectedTitle"
  },
  btnDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Detail"
  }
}
FormationCharListItem._mapEventConfig = {}

function FormationCharListItem:Awake()
end

function FormationCharListItem:FadeIn()
end

function FormationCharListItem:FadeOut()
end

function FormationCharListItem:OnEnable()
end

function FormationCharListItem:OnDisable()
end

function FormationCharListItem:OnDestroy()
end

function FormationCharListItem:OnRelease()
end

function FormationCharListItem:RefreshItem(bSelect, nIdx, nCharId, bBanned, nSortType)
  self.nCharId = nCharId
  self._mapNode.goChar:SetChar(nCharId, false, false, nil, nSortType)
  self._mapNode.goChar:SetSelect(bSelect and not bBanned)
  self._mapNode.Mask:SetActive(bBanned)
  self._mapNode.imgSelect:SetActive(bSelect and not bBanned)
  self._mapNode.btnGrid.interactable = not bBanned
  if type(nIdx) == "number" then
    NovaAPI.SetTMPText(self._mapNode.TMPSelectIdx, "")
    self._mapNode.imgSelectIcon:SetActive(true)
    self._mapNode.t_team_leader:SetActive(nIdx == 1)
    self._mapNode.t_team_sub:SetActive(nIdx ~= 1)
  else
    NovaAPI.SetTMPText(self._mapNode.TMPSelectIdx, "")
    self._mapNode.imgSelectIcon:SetActive(true)
    self._mapNode.t_team_leader:SetActive(false)
    self._mapNode.t_team_sub:SetActive(false)
  end
end

function FormationCharListItem:SetSelect(bSelect, nIdx)
  self._mapNode.imgSelect:SetActive(bSelect)
  self._mapNode.goChar:SetSelect(bSelect)
  if nIdx ~= nil then
    NovaAPI.SetTMPText(self._mapNode.TMPSelectIdx, "")
    self._mapNode.imgSelectIcon:SetActive(true)
    self._mapNode.t_team_leader:SetActive(nIdx == 1)
    self._mapNode.t_team_sub:SetActive(nIdx ~= 1)
  else
    NovaAPI.SetTMPText(self._mapNode.TMPSelectIdx, "")
    self._mapNode.imgSelectIcon:SetActive(true)
    self._mapNode.t_team_leader:SetActive(false)
    self._mapNode.t_team_sub:SetActive(false)
  end
end

function FormationCharListItem:OnBtnClick_Mask(btn)
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Formation_Selected"))
end

function FormationCharListItem:OnBtnClick_Detail(btn)
  if self._panel.nLoadProcess ~= nil and self._panel.nLoadProcess > 1 then
    return
  end
  if PlayerData.Guide:GetGuideState() then
    return
  end
  if self.nCharId ~= nil then
    EventManager.Hit(EventId.OpenPanel, PanelId.CharBgPanel, PanelId.CharInfo, self.nCharId, {
      self.nCharId
    }, false)
  end
end

return FormationCharListItem
