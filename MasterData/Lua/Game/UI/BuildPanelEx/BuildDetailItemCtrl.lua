local BuildDetailItemCtrl = class("BuildDetailItemCtrl", BaseCtrl)
BuildDetailItemCtrl._mapNodeConfig = {
  imgRareFrame = {sComponentName = "Image"},
  imgRareScore = {sComponentName = "Image"},
  txtBuildName = {sComponentName = "TMP_Text"},
  txtScore = {sComponentName = "TMP_Text"},
  txtScoreCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Score"
  },
  txtLeaderCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Leader"
  },
  txtSubCn = {sComponentName = "TMP_Text", sLanguageId = "Build_Sub"},
  imgCharIcon = {nCount = 3, sComponentName = "Image"},
  imgCharFrame = {nCount = 3, sComponentName = "Image"}
}
BuildDetailItemCtrl._mapEventConfig = {}

function BuildDetailItemCtrl:Refresh(mapData)
  self.mapBuild = mapData
  self:RefreshInfo()
  self:RefreshChar()
end

function BuildDetailItemCtrl:RefreshInfo()
  local sScore = AllEnum.FrameType_New.BuildRank .. self.mapBuild.mapRank.Id
  self:SetAtlasSprite(self._mapNode.imgRareScore, "12_rare", sScore)
  NovaAPI.SetTMPText(self._mapNode.txtScore, self.mapBuild.nScore)
  if self.mapBuild.sName == "" or self.mapBuild.sName == nil then
    NovaAPI.SetTMPText(self._mapNode.txtBuildName, ConfigTable.GetUIText("RoguelikeBuild_EmptyBuildName"))
  else
    NovaAPI.SetTMPText(self._mapNode.txtBuildName, self.mapBuild.sName)
  end
end

function BuildDetailItemCtrl:RefreshChar()
  for i = 1, 3 do
    local nCharTid = self.mapBuild.tbChar[i].nTid
    local nCharSkinId = PlayerData.Char:GetCharSkinId(nCharTid)
    local mapCharSkin = ConfigTable.GetData_CharacterSkin(nCharSkinId)
    local mapCharCfg = ConfigTable.GetData_Character(nCharTid)
    local sFrame = AllEnum.FrameType_New.BoardFrame .. AllEnum.BoardFrameColor[mapCharCfg.Grade]
    self:SetPngSprite(self._mapNode.imgCharIcon[i], mapCharSkin.Icon .. AllEnum.CharHeadIconSurfix.XXL)
    self:SetAtlasSprite(self._mapNode.imgCharFrame[i], "12_rare", sFrame)
  end
end

function BuildDetailItemCtrl:SetName(sName)
  NovaAPI.SetTMPText(self._mapNode.txtBuildName, sName)
end

return BuildDetailItemCtrl
