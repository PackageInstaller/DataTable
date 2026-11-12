local TemplateDiscNoteCtrl = class("TemplateDiscNoteCtrl", BaseCtrl)
TemplateDiscNoteCtrl._mapNodeConfig = {
  imgNoteBg = {sComponentName = "Image"},
  txtNoteCount = {sComponentName = "TMP_Text"}
}
TemplateDiscNoteCtrl._mapEventConfig = {}

function TemplateDiscNoteCtrl:SetNoteItem(nNoteId, nCount, bMain)
  local noteConfig = ConfigTable.GetData("Note", nNoteId)
  if noteConfig ~= nil then
    if nCount == nil then
      self:SetPngSprite(self._mapNode.imgNoteBg, bMain and noteConfig.Style6 or noteConfig.Style8)
      self._mapNode.txtNoteCount.gameObject:SetActive(false)
    else
      self._mapNode.txtNoteCount.gameObject:SetActive(true)
      self:SetPngSprite(self._mapNode.imgNoteBg, noteConfig.Style4)
      NovaAPI.SetTMPText(self._mapNode.txtNoteCount, nCount)
      local _, _color = ColorUtility.TryParseHtmlString(noteConfig.Color)
      NovaAPI.SetTMPColor(self._mapNode.txtNoteCount, _color)
    end
  end
end

return TemplateDiscNoteCtrl
