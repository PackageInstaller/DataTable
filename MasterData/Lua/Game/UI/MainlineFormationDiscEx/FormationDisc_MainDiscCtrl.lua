local FormationDisc_MainDiscCtrl = class("FormationDisc_MainDiscCtrl", BaseCtrl)
FormationDisc_MainDiscCtrl._mapNodeConfig = {
  rtDisc = {},
  imgDiscEdge = {sComponentName = "Image"},
  imgDisc = {sComponentName = "Image"},
  imgElement = {sComponentName = "Image"},
  btnDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Detail"
  },
  btnDown = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Down"
  },
  txtLevel = {sComponentName = "TMP_Text"},
  txtLv = {sComponentName = "TMP_Text", sLanguageId = "Lv"},
  TMPNoteTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "DiscFormation_NeedNote"
  },
  goNote = {nCount = 6, sComponentName = "Image"},
  TMPNoteCount = {nCount = 6, sComponentName = "TMP_Text"},
  TMPDiscTitle = {sComponentName = "TMP_Text"},
  TMPEmptyTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainlineFormationDisc_None"
  },
  imgNoteBg = {},
  imgDiscStar = {sComponentName = "Image"}
}
FormationDisc_MainDiscCtrl._mapEventConfig = {}
FormationDisc_MainDiscCtrl._mapRedDotConfig = {}

function FormationDisc_MainDiscCtrl:Awake()
end

function FormationDisc_MainDiscCtrl:FadeIn()
end

function FormationDisc_MainDiscCtrl:FadeOut()
end

function FormationDisc_MainDiscCtrl:OnEnable()
end

function FormationDisc_MainDiscCtrl:OnDisable()
end

function FormationDisc_MainDiscCtrl:OnDestroy()
end

function FormationDisc_MainDiscCtrl:OnRelease()
end

function FormationDisc_MainDiscCtrl:SetDownButton(bEnable)
  self._mapNode.btnDown.gameObject:SetActive(bEnable)
end

function FormationDisc_MainDiscCtrl:SetDisc(mapDisc, mapNote)
  self.mapDisc = mapDisc
  if mapDisc == nil then
    self._mapNode.rtDisc:SetActive(false)
    return
  end
  self._mapNode.rtDisc:SetActive(true)
  NovaAPI.SetTMPText(self._mapNode.TMPDiscTitle, mapDisc.sName)
  NovaAPI.SetTMPText(self._mapNode.txtLevel, mapDisc.nLevel)
  self:SetPngSprite(self._mapNode.imgDisc, mapDisc.sIcon)
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
  self:SetAtlasSprite(self._mapNode.imgDiscEdge, "12_rare", "rare_outfit_team_l_" .. AllEnum.FrameColor_New[mapDisc.nRarity])
  self:SetAtlasSprite(self._mapNode.imgDiscStar, "12_rare", AllEnum.FrameType_New.DiscLimitS .. AllEnum.FrameColor_New[mapDisc.nRarity] .. "_0" .. mapDisc.nStar + 1)
  NovaAPI.SetImageNativeSize(self._mapNode.imgDiscStar)
  local sName = AllEnum.ElementIconType.Icon .. mapDisc.nEET
  self:SetAtlasSprite(self._mapNode.imgElement, "12_rare", sName)
end

function FormationDisc_MainDiscCtrl:RefreshNote(mapNote)
  if self.mapDisc == nil then
    return
  end
  for i = 1, 6 do
    if self.mapDisc.tbSkillNeedNote[i] == nil then
      self._mapNode.goNote[i].gameObject:SetActive(false)
    else
      local mapNoteCfg = ConfigTable.GetData("SubNoteSkill", self.mapDisc.tbSkillNeedNote[i].nId)
      if mapNoteCfg == nil then
        self._mapNode.goNote[i].gameObject:SetActive(false)
      else
        self._mapNode.goNote[i].gameObject:SetActive(true)
        local nNoteId = self.mapDisc.tbSkillNeedNote[i].nId
        local nNoteCount = self.mapDisc.tbSkillNeedNote[i].nCount
        NovaAPI.SetTMPText(self._mapNode.TMPNoteCount[i], nNoteCount)
        self:SetPngSprite(self._mapNode.goNote[i], mapNoteCfg.Icon .. AllEnum.DiscSkillIconSurfix.Small)
      end
    end
  end
end

function FormationDisc_MainDiscCtrl:OnBtnClick_Detail(btn)
  if self.mapDisc ~= nil then
    EventManager.Hit("DiscFormation_Detail", self.mapDisc.nId)
  end
end

function FormationDisc_MainDiscCtrl:OnBtnClick_Down(btn)
  EventManager.Hit("ForamtionDown", self.mapDisc, 1)
end

return FormationDisc_MainDiscCtrl
