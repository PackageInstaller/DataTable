local DiscSubSkillItem = class("DiscSubSkillItem", BaseCtrl)
DiscSubSkillItem._mapNodeConfig = {
  imgLv = {sComponentName = "Image"},
  imgIcon = {sComponentName = "Image"},
  txtNoteName = {sComponentName = "TMP_Text"},
  txtDesc = {sComponentName = "TMP_Text"},
  txtLv = {sComponentName = "TMP_Text"}
}
DiscSubSkillItem._mapEventConfig = {}

function DiscSubSkillItem:SetItem(nNoteId, nLevel)
  local noteCfg = ConfigTable.GetData("SubNoteSkill", nNoteId)
  self:SetPngSprite(self._mapNode.imgIcon, noteCfg.Icon)
  NovaAPI.SetTMPText(self._mapNode.txtNoteName, noteCfg.Name)
  NovaAPI.SetTMPText(self._mapNode.txtDesc, noteCfg.BriefDesc)
  NovaAPI.SetTMPText(self._mapNode.txtLv, orderedFormat(ConfigTable.GetUIText("Note_Count"), nLevel))
  local nImgCount = 2
  self:SetPngSprite(self._mapNode.imgLv, "UI/big_sprites/zs_outfit_lv_" .. nImgCount)
end

function DiscSubSkillItem:OnEnable()
end

return DiscSubSkillItem
