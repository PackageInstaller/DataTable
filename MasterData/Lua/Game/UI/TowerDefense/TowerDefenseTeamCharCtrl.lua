local TowerDefenseTeamCharCtrl = class("TowerDefenseTeamCharCtrl", BaseCtrl)
TowerDefenseTeamCharCtrl._mapNodeConfig = {
  icon_char = {sComponentName = "Image"},
  txt_name = {sComponentName = "TMP_Text"},
  go_select = {},
  go_selectMask = {},
  selected_tips = {},
  index = {nCount = 6},
  txt_selected = {
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_TeamEditor_Selected"
  }
}
TowerDefenseTeamCharCtrl._mapEventConfig = {
  TowerDefense_CharUpdate = "OnEvent_UpdateIndex"
}
TowerDefenseTeamCharCtrl._mapRedDotConfig = {}

function TowerDefenseTeamCharCtrl:SetData(guideId, index)
  self.guideId = guideId
  local guideConfig = ConfigTable.GetData("TowerDefenseGuide", self.guideId)
  if guideConfig == nil then
    return
  end
  local characterConfig = ConfigTable.GetData("TowerDefenseCharacter", guideConfig.ObjectId)
  if characterConfig == nil then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.txt_name, characterConfig.Name)
  if characterConfig.Icon ~= "" then
    self:SetPngSprite(self._mapNode.icon_char, characterConfig.Icon .. AllEnum.CharHeadIconSurfix.QM)
  end
  self:UpdateIndex(index)
end

function TowerDefenseTeamCharCtrl:UpdateIndex(nIndex)
  if 0 < nIndex then
    self._mapNode.go_select:SetActive(true)
    self._mapNode.selected_tips:SetActive(true)
    self._mapNode.go_selectMask:SetActive(true)
    for i = 1, 6 do
      self._mapNode.index[i]:SetActive(i == nIndex)
    end
  else
    self._mapNode.go_select:SetActive(false)
    self._mapNode.selected_tips:SetActive(false)
    self._mapNode.go_selectMask:SetActive(false)
  end
end

function TowerDefenseTeamCharCtrl:OnEvent_UpdateIndex(tbCharacterIds)
  local index = table.indexof(tbCharacterIds, self.guideId)
  self:UpdateIndex(index)
end

return TowerDefenseTeamCharCtrl
