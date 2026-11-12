local FormationDisc_ListGridMainCtrl = class("FormationDisc_ListGridMainCtrl", BaseCtrl)
FormationDisc_ListGridMainCtrl._mapNodeConfig = {
  imgEdge = {sComponentName = "Image"},
  imgIcon = {sComponentName = "Image"},
  imgEET = {sComponentName = "Image"},
  imgEET1 = {sComponentName = "Image"},
  txtLevel = {sComponentName = "TMP_Text"},
  txtLv = {sComponentName = "TMP_Text", sLanguageId = "Lv"},
  goNote = {nCount = 6, sComponentName = "Image"},
  imgDiscStar = {sComponentName = "Image"},
  TMPNoteCount = {nCount = 6, sComponentName = "TMP_Text"},
  TMPHintMain = {
    sComponentName = "TMP_Text",
    sLanguageId = "DiscFormation_InuseSub"
  },
  TMPSelectTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "RoguelikeBuild_Manage_SelectedTitle"
  },
  TMPNoteTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "DiscNote_ActiveHint"
  },
  Use_Mask = {},
  Select_bg = {},
  Select_Mask = {},
  imgNumber = {nCount = 3},
  imgNoteBg = {}
}
FormationDisc_ListGridMainCtrl._mapEventConfig = {}
FormationDisc_ListGridMainCtrl._mapRedDotConfig = {}

function FormationDisc_ListGridMainCtrl:Awake()
end

function FormationDisc_ListGridMainCtrl:FadeIn()
end

function FormationDisc_ListGridMainCtrl:FadeOut()
end

function FormationDisc_ListGridMainCtrl:OnEnable()
end

function FormationDisc_ListGridMainCtrl:OnDisable()
end

function FormationDisc_ListGridMainCtrl:OnDestroy()
end

function FormationDisc_ListGridMainCtrl:OnRelease()
end

function FormationDisc_ListGridMainCtrl:Refresh(mapDisc, mapNote, nIdx, bSubUse)
  self.mapDisc = mapDisc
  if mapDisc == nil then
    self.gameObject:SetActive(false)
    return
  end
  self.gameObject:SetActive(true)
  self:SetPngSprite(self._mapNode.imgIcon, mapDisc.sIcon .. AllEnum.OutfitIconSurfix.OutInfo)
  NovaAPI.SetTMPText(self._mapNode.txtLevel, mapDisc.nLevel)
  self._mapNode.imgNoteBg:SetActive(#mapDisc.tbSkillNeedNote > 0)
  for i = 1, 6 do
    if mapDisc.tbSkillNeedNote[i] == nil then
      self._mapNode.goNote[i].gameObject:SetActive(false)
    else
      local mapNoteCfg = ConfigTable.GetData("SubNoteSkill", mapDisc.tbSkillNeedNote[i].nId)
      if mapNoteCfg == nil then
        self._mapNode.goNote[i].gameObject:SetActive(false)
      else
        self._mapNode.goNote[i].gameObject:SetActive(true)
        local nNoteId = mapDisc.tbSkillNeedNote[i].nId
        local nNoteCount = mapDisc.tbSkillNeedNote[i].nCount
        NovaAPI.SetTMPText(self._mapNode.TMPNoteCount[i], nNoteCount)
        self:SetPngSprite(self._mapNode.goNote[i], mapNoteCfg.Icon .. AllEnum.DiscSkillIconSurfix.Small)
      end
    end
  end
  self:SetAtlasSprite(self._mapNode.imgDiscStar, "12_rare", AllEnum.FrameType_New.DiscLimitS .. AllEnum.FrameColor_New[mapDisc.nRarity] .. "_0" .. mapDisc.nStar + 1)
  NovaAPI.SetImageNativeSize(self._mapNode.imgDiscStar)
  self:SetAtlasSprite(self._mapNode.imgEdge, "12_rare", "rare_outfit_team_s_" .. AllEnum.FrameColor_New[mapDisc.nRarity])
  local sName = AllEnum.ElementIconType.Icon .. mapDisc.nEET
  self:SetAtlasSprite(self._mapNode.imgEET, "12_rare", sName)
  self:SetAtlasSprite(self._mapNode.imgEET1, "12_rare", sName)
  self._mapNode.Select_bg:SetActive(0 < nIdx)
  self._mapNode.Select_Mask:SetActive(0 < nIdx)
  self._mapNode.imgNumber[1]:SetActive(nIdx == 1)
  self._mapNode.imgNumber[2]:SetActive(nIdx == 2)
  self._mapNode.imgNumber[3]:SetActive(nIdx == 3)
  self._mapNode.Use_Mask:SetActive(bSubUse)
end

function FormationDisc_ListGridMainCtrl:SetSelect(nMainIdx, nSubIdx)
  self._mapNode.Select_bg:SetActive(0 < nMainIdx)
  self._mapNode.Select_Mask:SetActive(0 < nMainIdx)
  self._mapNode.imgNumber[1]:SetActive(nMainIdx == 1)
  self._mapNode.imgNumber[2]:SetActive(nMainIdx == 2)
  self._mapNode.imgNumber[3]:SetActive(nMainIdx == 3)
  self._mapNode.Use_Mask:SetActive(0 < nSubIdx)
end

return FormationDisc_ListGridMainCtrl
