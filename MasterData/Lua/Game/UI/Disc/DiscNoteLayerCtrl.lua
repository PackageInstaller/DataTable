local DiscNoteLayerCtrl = class("DiscNoteLayerCtrl", BaseCtrl)
DiscNoteLayerCtrl._mapNodeConfig = {
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
  }
}
DiscNoteLayerCtrl._mapEventConfig = {}

function DiscNoteLayerCtrl:Refresh(tbNoteId, nNoteCount, sDesc, nLayer, bLast)
  self._mapNode.goNote:SetNoteItem(tbNoteId, nNoteCount)
  NovaAPI.SetTMPText(self._mapNode.txtLayerDesc, sDesc)
  local sLayer = ConfigTable.GetUIText("Disc_CoreSkill_Base")
  if 1 < nLayer then
    sLayer = orderedFormat(ConfigTable.GetUIText("Disc_CoreSkill_Expand"), nLayer - 1)
  end
  NovaAPI.SetTMPText(self._mapNode.txtLayerName, sLayer)
  self._mapNode.imgLine:SetActive(not bLast)
end

function DiscNoteLayerCtrl:OnLinkClick_Word(link, sWordId)
  UTILS.ClickWordLink(link, sWordId)
end

return DiscNoteLayerCtrl
