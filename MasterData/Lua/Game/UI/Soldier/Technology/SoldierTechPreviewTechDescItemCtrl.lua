local SoldierTechPreviewTechDescItemCtrl = class("SoldierTechPreviewTechDescItemCtrl", BaseCtrl)
SoldierTechPreviewTechDescItemCtrl._mapNodeConfig = {
  rtSkill = {
    sCtrlName = "Game.UI.Soldier.Technology.SoldierTechNodeCtrl"
  },
  txtTechTitle = {sComponentName = "TMP_Text"},
  txtTechDesc = {sComponentName = "TMP_Text"}
}
SoldierTechPreviewTechDescItemCtrl._mapEventConfig = {}
SoldierTechPreviewTechDescItemCtrl._mapRedDotConfig = {}

function SoldierTechPreviewTechDescItemCtrl:Awake()
end

function SoldierTechPreviewTechDescItemCtrl:OnEnable()
end

function SoldierTechPreviewTechDescItemCtrl:OnDisable()
end

function SoldierTechPreviewTechDescItemCtrl:OnDestroy()
end

function SoldierTechPreviewTechDescItemCtrl:Refresh(nId)
  local mapCfg = ConfigTable.GetData("SoldierTechNode", nId)
  if not mapCfg then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.txtTechTitle, mapCfg.Name or "")
  NovaAPI.SetTMPText(self._mapNode.txtTechDesc, mapCfg.Desc or "")
  self._mapNode.rtSkill:Refresh(nId, nil, true)
end

return SoldierTechPreviewTechDescItemCtrl
