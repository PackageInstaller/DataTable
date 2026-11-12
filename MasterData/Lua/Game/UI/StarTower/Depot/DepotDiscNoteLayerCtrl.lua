local DepotDiscNoteLayerCtrl = class("DepotDiscNoteLayerCtrl", BaseCtrl)
DepotDiscNoteLayerCtrl._mapNodeConfig = {
  imgLine = {},
  goNote = {
    sCtrlName = "Game.UI.TemplateEx.TemplateDiscMultiNoteCtrl"
  },
  txtLayerDesc = {sComponentName = "TMP_Text"},
  txtLayerName = {sComponentName = "TMP_Text"},
  TMP_Link = {
    sNodeName = "txtLayerDesc",
    sComponentName = "TMPHyperLink",
    callback = "OnLinkClick_Word"
  },
  canvasGroupBg = {
    sNodeName = "imgBg",
    sComponentName = "CanvasGroup"
  }
}
DepotDiscNoteLayerCtrl._mapEventConfig = {}

function DepotDiscNoteLayerCtrl:Refresh(tbNoteId, nNoteCount, sDesc, nLayer, bLast, bUnLock)
  self._mapNode.goNote:SetNoteItem(tbNoteId, nNoteCount, not bUnLock)
  sDesc = sDesc or ""
  if bUnLock then
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroupBg, 1)
  else
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroupBg, 0.4)
    sDesc = sDesc .. ConfigTable.GetUIText("StarTower_Disc_Skill_Lock")
  end
  NovaAPI.SetTMPText(self._mapNode.txtLayerDesc, sDesc)
  local sLayer = ConfigTable.GetUIText("Disc_CoreSkill_Base")
  if 1 < nLayer then
    sLayer = orderedFormat(ConfigTable.GetUIText("Disc_CoreSkill_Expand"), nLayer - 1)
  end
  NovaAPI.SetTMPText(self._mapNode.txtLayerName, sLayer)
  self._mapNode.imgLine:SetActive(not bLast)
end

function DepotDiscNoteLayerCtrl:OnLinkClick_Word(link, sWordId)
  UTILS.ClickWordLink(link, sWordId)
end

return DepotDiscNoteLayerCtrl
