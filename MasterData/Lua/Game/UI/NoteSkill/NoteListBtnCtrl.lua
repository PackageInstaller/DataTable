local NoteListBtnCtrl = class("NoteListBtnCtrl", BaseCtrl)
NoteListBtnCtrl._mapNodeConfig = {
  btnItem = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Item"
  },
  imgNoteIcon = {sComponentName = "Image"},
  imgIconMask = {sComponentName = "Image"},
  txtNoteName = {sComponentName = "TMP_Text"},
  imgChoose = {},
  txtLv = {sComponentName = "TMP_Text"},
  txtNotHave = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Depot_Potential_Lock"
  }
}
NoteListBtnCtrl._mapEventConfig = {
  SelectNoteListBtn = "OnEvent_SelectNoteListBtn"
}

function NoteListBtnCtrl:SetItem(noteCfg, nLv)
  self.nNoteId = noteCfg.Id
  self.nLv = nLv
  self:SetPngSprite(self._mapNode.imgNoteIcon, noteCfg.Icon .. AllEnum.DiscSkillIconSurfix.Small)
  self:SetPngSprite(self._mapNode.imgIconMask, noteCfg.Icon .. AllEnum.DiscSkillIconSurfix.Small)
  NovaAPI.SetTMPText(self._mapNode.txtNoteName, noteCfg.Name)
  NovaAPI.SetTMPText(self._mapNode.txtLv, orderedFormat(ConfigTable.GetUIText("Note_Count"), nLv))
  if nLv <= 0 then
    self._mapNode.imgIconMask.gameObject:SetActive(true)
    self._mapNode.txtLv.gameObject:SetActive(false)
    self._mapNode.txtNotHave.gameObject:SetActive(true)
  end
end

function NoteListBtnCtrl:OnEvent_SelectNoteListBtn(nNoteId, _)
  self._mapNode.imgChoose.gameObject:SetActive(self.nNoteId == nNoteId)
end

function NoteListBtnCtrl:OnBtnClick_Item()
  EventManager.Hit("SelectNoteListBtn", self.nNoteId, self.nLv)
end

return NoteListBtnCtrl
