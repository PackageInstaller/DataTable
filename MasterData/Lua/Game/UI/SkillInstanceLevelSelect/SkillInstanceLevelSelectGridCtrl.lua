local SkillInstanceLevelSelectGridCtrl = class("SkillInstanceLevelSelectGridCtrl", BaseCtrl)
SkillInstanceLevelSelectGridCtrl._mapNodeConfig = {
  imgLevelImage = {sComponentName = "Image"},
  goMask = {},
  TMPInstanceName = {sComponentName = "TMP_Text"},
  TMPHint = {sComponentName = "TMP_Text"},
  btnGrid = {sComponentName = "UIButton"},
  imgLock = {}
}
SkillInstanceLevelSelectGridCtrl._mapEventConfig = {}

function SkillInstanceLevelSelectGridCtrl:Refresh(nType)
  local mapLevelCfgData = ConfigTable.GetData("SkillInstanceType", nType)
  NovaAPI.SetTMPText(self._mapNode.TMPInstanceName, mapLevelCfgData.Name)
  self:SetPngSprite(self._mapNode.imgLevelImage, mapLevelCfgData.Episode)
  local nLevelState, bUnlock = PlayerData.SkillInstance:GetLevelOpenState(nType)
  local bOpen = nLevelState == AllEnum.SkillInstanceState.Open
  self._mapNode.goMask:SetActive(not bOpen)
  self._mapNode.imgLock:SetActive(not bUnlock)
  self._mapNode.btnGrid.bSkipBtnAnim = not bOpen
end

function SkillInstanceLevelSelectGridCtrl:CheckMainlinePass(mapData)
  if mapData.MainLineId > 0 then
    local nStar = PlayerData.Mainline:GetMianlineLevelStar(mapData.MainLineId)
    return 0 < nStar
  else
    return true
  end
end

return SkillInstanceLevelSelectGridCtrl
