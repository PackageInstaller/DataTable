local FormationDisc_ListGridSubCtrl = class("FormationDisc_ListGridSubCtrl", BaseCtrl)
FormationDisc_ListGridSubCtrl._mapNodeConfig = {
  imgEdge = {sComponentName = "Image"},
  imgIcon = {sComponentName = "Image"},
  imgEET = {sComponentName = "Image"},
  imgEET1 = {sComponentName = "Image"},
  txtLevel = {sComponentName = "TMP_Text"},
  txtLv = {sComponentName = "TMP_Text", sLanguageId = "Lv"},
  imgDiscStar = {sComponentName = "Image"},
  imgNote = {nCount = 3, sComponentName = "Image"},
  goNoteUnuse = {nCount = 3, sComponentName = "Image"},
  TMPNoteCount = {nCount = 3, sComponentName = "TMP_Text"},
  TMPHintMain = {
    sComponentName = "TMP_Text",
    sLanguageId = "DiscFormation_InuseMain"
  },
  TMPSelectTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "RoguelikeBuild_Manage_SelectedTitle"
  },
  Use_Mask = {},
  Select_bg = {},
  Select_Mask = {},
  imgNumber = {nCount = 3}
}
FormationDisc_ListGridSubCtrl._mapEventConfig = {}
FormationDisc_ListGridSubCtrl._mapRedDotConfig = {}

function FormationDisc_ListGridSubCtrl:Awake()
end

function FormationDisc_ListGridSubCtrl:FadeIn()
end

function FormationDisc_ListGridSubCtrl:FadeOut()
end

function FormationDisc_ListGridSubCtrl:OnEnable()
end

function FormationDisc_ListGridSubCtrl:OnDisable()
end

function FormationDisc_ListGridSubCtrl:OnDestroy()
end

function FormationDisc_ListGridSubCtrl:OnRelease()
end

function FormationDisc_ListGridSubCtrl:Refresh(mapDisc, mapNote, nIdx, bMainUse)
  self.mapDisc = mapDisc
  if mapDisc == nil then
    self.gameObject:SetActive(false)
    return
  end
  self.gameObject:SetActive(true)
  self:SetPngSprite(self._mapNode.imgIcon, mapDisc.sIcon .. AllEnum.OutfitIconSurfix.OutInfo)
  NovaAPI.SetTMPText(self._mapNode.txtLevel, mapDisc.nLevel)
  for i = 1, 3 do
    if mapDisc.tbSubNoteSkills[i] == nil then
      self._mapNode.imgNote[i].gameObject:SetActive(false)
    else
      local mapNoteCfg = ConfigTable.GetData("SubNoteSkill", mapDisc.tbSubNoteSkills[i].nId)
      if mapNoteCfg == nil then
        self._mapNode.imgNote[i].gameObject:SetActive(false)
      else
        self._mapNode.imgNote[i].gameObject:SetActive(true)
        local nNoteId = mapDisc.tbSubNoteSkills[i].nId
        local nNoteCount = mapDisc.tbSubNoteSkills[i].nCount
        NovaAPI.SetTMPText(self._mapNode.TMPNoteCount[i], nNoteCount)
        self:SetPngSprite(self._mapNode.goNoteUnuse[i], mapNoteCfg.Icon .. AllEnum.DiscSkillIconSurfix.Small)
        if mapNote[nNoteId] == nil then
          self:SetPngSprite(self._mapNode.imgNote[i], mapNoteCfg.Icon .. AllEnum.DiscSkillIconSurfix.Small)
        else
          self:SetPngSprite(self._mapNode.imgNote[i], mapNoteCfg.Icon .. AllEnum.DiscSkillIconSurfix.S_Light)
        end
        self._mapNode.goNoteUnuse[i].gameObject:SetActive(false)
      end
    end
  end
  self:SetAtlasSprite(self._mapNode.imgEdge, "12_rare", "rare_outfit_team_s_" .. AllEnum.FrameColor_New[mapDisc.nRarity])
  self:SetAtlasSprite(self._mapNode.imgDiscStar, "12_rare", AllEnum.FrameType_New.DiscLimitS .. AllEnum.FrameColor_New[mapDisc.nRarity] .. "_0" .. mapDisc.nStar + 1)
  NovaAPI.SetImageNativeSize(self._mapNode.imgDiscStar)
  local sName = AllEnum.ElementIconType.Icon .. mapDisc.nEET
  self:SetAtlasSprite(self._mapNode.imgEET, "12_rare", sName)
  self:SetAtlasSprite(self._mapNode.imgEET1, "12_rare", sName)
  self._mapNode.Select_bg:SetActive(0 < nIdx)
  self._mapNode.Select_Mask:SetActive(0 < nIdx)
  self._mapNode.imgNumber[1]:SetActive(nIdx == 1)
  self._mapNode.imgNumber[2]:SetActive(nIdx == 2)
  self._mapNode.imgNumber[3]:SetActive(nIdx == 3)
  self._mapNode.Use_Mask:SetActive(bMainUse)
end

function FormationDisc_ListGridSubCtrl:SetSelect(nMainIdx, nSubIdx)
  self._mapNode.Select_bg:SetActive(0 < nSubIdx)
  self._mapNode.Select_Mask:SetActive(0 < nSubIdx)
  self._mapNode.imgNumber[1]:SetActive(nSubIdx == 1)
  self._mapNode.imgNumber[2]:SetActive(nSubIdx == 2)
  self._mapNode.imgNumber[3]:SetActive(nSubIdx == 3)
  self._mapNode.Use_Mask:SetActive(0 < nMainIdx)
end

return FormationDisc_ListGridSubCtrl
