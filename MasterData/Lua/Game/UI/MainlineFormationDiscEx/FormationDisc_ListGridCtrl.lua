local FormationDisc_ListGridCtrl = class("FormationDisc_ListGridCtrl", BaseCtrl)
FormationDisc_ListGridCtrl._mapNodeConfig = {
  rtMain = {
    sCtrlName = "Game.UI.MainlineFormationDiscEx.FormationDisc_ListGridMainCtrl"
  },
  rtSub = {
    sCtrlName = "Game.UI.MainlineFormationDiscEx.FormationDisc_ListGridSubCtrl"
  },
  btnDetail = {
    sComponentName = "UIButton",
    nCount = 2,
    callback = "OnBtnClick_Detail"
  }
}
FormationDisc_ListGridCtrl._mapEventConfig = {}
FormationDisc_ListGridCtrl._mapRedDotConfig = {}

function FormationDisc_ListGridCtrl:Awake()
end

function FormationDisc_ListGridCtrl:FadeIn()
end

function FormationDisc_ListGridCtrl:FadeOut()
end

function FormationDisc_ListGridCtrl:OnEnable()
end

function FormationDisc_ListGridCtrl:OnDisable()
end

function FormationDisc_ListGridCtrl:OnDestroy()
end

function FormationDisc_ListGridCtrl:OnRelease()
end

function FormationDisc_ListGridCtrl:OnGridRefresh(mapDisc, mapNote, mapNoteCur, nType, nMainIdx, nSubIdx)
  self.mapDisc = mapDisc
  if nType == 1 then
    self._mapNode.rtMain.gameObject:SetActive(true)
    self._mapNode.rtSub.gameObject:SetActive(false)
    self._mapNode.rtMain:Refresh(mapDisc, mapNoteCur, nMainIdx, 0 < nSubIdx)
  else
    self._mapNode.rtMain.gameObject:SetActive(false)
    self._mapNode.rtSub.gameObject:SetActive(true)
    self._mapNode.rtSub:Refresh(mapDisc, mapNote, nSubIdx, 0 < nMainIdx)
  end
end

function FormationDisc_ListGridCtrl:SetSelect(nMainIdx, nSubIdx)
  self._mapNode.rtMain:SetSelect(nMainIdx, nSubIdx)
  self._mapNode.rtSub:SetSelect(nMainIdx, nSubIdx)
end

function FormationDisc_ListGridCtrl:OnBtnClick_Detail()
  if self.mapDisc ~= nil then
    EventManager.Hit("DiscFormation_Detail", self.mapDisc.nId)
  end
end

return FormationDisc_ListGridCtrl
