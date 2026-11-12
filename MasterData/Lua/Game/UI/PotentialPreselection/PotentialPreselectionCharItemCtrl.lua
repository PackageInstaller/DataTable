local PotentialPreselectionCharItemCtrl = class("PotentialPreselectionCharItemCtrl", BaseCtrl)
PotentialPreselectionCharItemCtrl._mapNodeConfig = {
  imgLockMask = {},
  txtCharLock = {
    sComponentName = "TMP_Text",
    sLanguageId = "Potential_Preselection_Char_Lock"
  },
  imgSelect = {},
  goChar = {
    sCtrlName = "Game.UI.TemplateEx.TemplateCharCtrl"
  },
  btnGrid = {sComponentName = "UIButton"},
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
PotentialPreselectionCharItemCtrl._mapEventConfig = {}

function PotentialPreselectionCharItemCtrl:Awake()
end

function PotentialPreselectionCharItemCtrl:OnEnable()
end

function PotentialPreselectionCharItemCtrl:OnDisable()
end

function PotentialPreselectionCharItemCtrl:OnDestroy()
end

function PotentialPreselectionCharItemCtrl:RefreshItem(nSelectIdx, nCharId, nSortType)
  self.nCharId = nCharId
  local mapCharData = PlayerData.Char:GetCharDataByTid(nCharId)
  self.bUnlock = mapCharData ~= nil
  self._mapNode.goChar:SetChar(nCharId, false, not self.bUnlock, nil, nSortType)
  self._mapNode.goChar:SetSelect(0 < nSelectIdx)
  self._mapNode.imgSelect:SetActive(0 < nSelectIdx)
  if 0 < nSelectIdx then
    self._mapNode.t_team_leader:SetActive(nSelectIdx == 1)
    self._mapNode.t_team_sub:SetActive(nSelectIdx ~= 1)
  else
    self._mapNode.t_team_leader:SetActive(false)
    self._mapNode.t_team_sub:SetActive(false)
  end
  self._mapNode.imgLockMask.gameObject:SetActive(false)
  self._mapNode.txtCharLock.gameObject:SetActive(not self.bUnlock)
end

function PotentialPreselectionCharItemCtrl:SetSelect(bSelect, nIdx)
  self._mapNode.imgSelect:SetActive(bSelect)
  self._mapNode.goChar:SetSelect(bSelect)
  if nIdx ~= nil then
    self._mapNode.t_team_leader:SetActive(nIdx == 1)
    self._mapNode.t_team_sub:SetActive(nIdx ~= 1)
  else
    self._mapNode.t_team_leader:SetActive(false)
    self._mapNode.t_team_sub:SetActive(false)
  end
end

function PotentialPreselectionCharItemCtrl:OnBtnClick_Mask(btn)
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Potential_Preselection_Char_Selected"))
end

function PotentialPreselectionCharItemCtrl:OnBtnClick_Detail(btn)
  if self.nCharId ~= nil then
    if self.bUnlock then
      EventManager.Hit(EventId.OpenPanel, PanelId.CharBgPanel, PanelId.CharInfo, self.nCharId, {
        self.nCharId
      }, false)
    else
      EventManager.Hit(EventId.OpenPanel, PanelId.CharBgTrialPanel, PanelId.CharInfoTrial, self.nCharId)
    end
  end
end

return PotentialPreselectionCharItemCtrl
