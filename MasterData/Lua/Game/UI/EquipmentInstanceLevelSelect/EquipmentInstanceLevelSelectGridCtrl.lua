local EquipmentInstanceLevelSelectGridCtrl = class("EquipmentInstanceLevelSelectGridCtrl", BaseCtrl)
EquipmentInstanceLevelSelectGridCtrl._mapNodeConfig = {
  imgLevelImage = {sComponentName = "Image"},
  goMask = {},
  TMPInstanceName = {sComponentName = "TMP_Text"},
  TMPHint = {sComponentName = "TMP_Text"},
  btnGrid = {sComponentName = "UIButton"},
  imgLock = {}
}
EquipmentInstanceLevelSelectGridCtrl._mapEventConfig = {}

function EquipmentInstanceLevelSelectGridCtrl:Refresh(nType)
  local mapLevelCfgData = ConfigTable.GetData("CharGemInstanceType", nType)
  NovaAPI.SetTMPText(self._mapNode.TMPInstanceName, mapLevelCfgData.Name)
  self:SetPngSprite(self._mapNode.imgLevelImage, mapLevelCfgData.Episode)
  local nLevelState, bUnlock = PlayerData.EquipmentInstance:GetLevelOpenState(nType)
  local bOpen = nLevelState == AllEnum.EquipmentInstanceState.Open
  self._mapNode.goMask:SetActive(not bOpen)
  self._mapNode.imgLock:SetActive(not bUnlock)
  NovaAPI.SetTMPText(self._mapNode.TMPHint, mapLevelCfgData.OpenDayDesc)
  self._mapNode.btnGrid.bSkipBtnAnim = not bOpen
end

function EquipmentInstanceLevelSelectGridCtrl:CheckMainlinePass(mapData)
  if mapData.MainLineId > 0 then
    local nStar = PlayerData.Mainline:GetMianlineLevelStar(mapData.MainLineId)
    return 0 < nStar
  else
    return true
  end
end

return EquipmentInstanceLevelSelectGridCtrl
