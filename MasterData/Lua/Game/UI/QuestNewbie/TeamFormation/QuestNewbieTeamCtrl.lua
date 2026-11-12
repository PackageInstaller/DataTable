local QuestNewbieTeamCtrl = class("QuestNewbieTeamCtrl", BaseCtrl)
QuestNewbieTeamCtrl._mapNodeConfig = {
  goLock = {},
  txtLock = {sComponentName = "TMP_Text"},
  imgChar = {nCount = 3, sComponentName = "Image"},
  goElement = {
    sCtrlName = "Game.UI.TemplateEx.TemplateElementCtrl"
  },
  txtTeamDesc = {sComponentName = "TMP_Text"}
}
QuestNewbieTeamCtrl._mapEventConfig = {}
QuestNewbieTeamCtrl._mapRedDotConfig = {}

function QuestNewbieTeamCtrl:Init(mapData, mapPrevData)
  if mapData == nil then
    return
  end
  self._mapNode.goElement:Refresh(mapData.EET)
  for i = 1, 3 do
    local nChar = mapData["Char" .. i]
    if nChar ~= nil and 0 < nChar then
      local sIconPath = "Icon/Head/head_" .. nChar .. "01" .. AllEnum.CharHeadIconSurfix.XL
      self:SetPngSprite(self._mapNode.imgChar[i], sIconPath)
    end
  end
  NovaAPI.SetTMPText(self._mapNode.txtTeamDesc, mapData.Desc)
  local bFinished = PlayerData.Quest:CheckTeamFormationAttributeCompleted(mapData.Id)
  local bUnlocked = PlayerData.Quest:CheckTeamFormationAttributeUnlocked(mapData.Id)
  self.bLocked = bFinished or not bUnlocked
  self._mapNode.goLock:SetActive(self.bLocked)
  local sTip = ""
  if bFinished then
    sTip = ConfigTable.GetUIText("Quest_Complete")
  elseif mapPrevData ~= nil then
    sTip = orderedFormat(ConfigTable.GetUIText("FormationQuest_UnLock"), ConfigTable.GetUIText("T_Element_Attr_" .. mapPrevData.EET))
  end
  NovaAPI.SetTMPText(self._mapNode.txtLock, sTip)
end

function QuestNewbieTeamCtrl:OnEnable()
end

return QuestNewbieTeamCtrl
