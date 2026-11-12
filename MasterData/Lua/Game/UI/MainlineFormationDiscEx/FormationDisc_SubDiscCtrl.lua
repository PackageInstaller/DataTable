local FormationDisc_SubDiscCtrl = class("FormationDisc_SubDiscCtrl", BaseCtrl)
FormationDisc_SubDiscCtrl._mapNodeConfig = {
  rtDiscRoot = {},
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
  goNote = {nCount = 3, sComponentName = "Image"},
  TMPNoteCount = {nCount = 3, sComponentName = "TMP_Text"},
  imgLock = {},
  imgEmpty = {},
  rtNotes = {},
  imgDiscStar = {sComponentName = "Image"},
  btnLock = {
    sNodeName = "imgLock",
    sComponentName = "Button",
    callback = "OnBtnClick_Lock"
  }
}
FormationDisc_SubDiscCtrl._mapEventConfig = {}
FormationDisc_SubDiscCtrl._mapRedDotConfig = {}

function FormationDisc_SubDiscCtrl:Awake()
end

function FormationDisc_SubDiscCtrl:FadeIn()
end

function FormationDisc_SubDiscCtrl:FadeOut()
end

function FormationDisc_SubDiscCtrl:OnEnable()
end

function FormationDisc_SubDiscCtrl:OnDisable()
end

function FormationDisc_SubDiscCtrl:OnDestroy()
end

function FormationDisc_SubDiscCtrl:OnRelease()
end

function FormationDisc_SubDiscCtrl:SetPosLock(bLock)
  self._mapNode.imgLock:SetActive(bLock)
  self._mapNode.imgEmpty:SetActive(not bLock)
end

function FormationDisc_SubDiscCtrl:SetDisc(mapDisc, mapNote, bLock)
  self.mapDisc = mapDisc
  self._mapNode.imgLock:SetActive(bLock)
  self._mapNode.imgEmpty:SetActive(not bLock)
  if mapDisc == nil then
    self._mapNode.rtDiscRoot:SetActive(false)
    return
  end
  self._mapNode.rtDiscRoot:SetActive(true)
  self:SetPngSprite(self._mapNode.imgDisc, mapDisc.sIcon .. AllEnum.OutfitIconSurfix.OutInfo)
  if mapDisc.tbSubNoteSkills ~= nil then
    local bHasNote = false
    for i = 1, 3 do
      if mapDisc.tbSubNoteSkills[i] ~= nil then
        local mapNoteCfg = ConfigTable.GetData("SubNoteSkill", mapDisc.tbSubNoteSkills[i].nId)
        if mapNoteCfg == nil then
          self._mapNode.goNote[i].gameObject:SetActive(false)
        else
          self._mapNode.goNote[i].gameObject:SetActive(true)
          NovaAPI.SetTMPText(self._mapNode.TMPNoteCount[i], mapDisc.tbSubNoteSkills[i].nCount)
          if mapNote[mapDisc.tbSubNoteSkills[i].nId] == nil then
            self:SetPngSprite(self._mapNode.goNote[i], mapNoteCfg.Icon .. AllEnum.DiscSkillIconSurfix.Small)
          else
            self:SetPngSprite(self._mapNode.goNote[i], mapNoteCfg.Icon .. AllEnum.DiscSkillIconSurfix.S_Light)
          end
        end
        bHasNote = true
      else
        self._mapNode.goNote[i].gameObject:SetActive(false)
      end
    end
    self._mapNode.rtNotes:SetActive(bHasNote)
  end
  self:SetAtlasSprite(self._mapNode.imgDiscEdge, "12_rare", "rare_outfit_team_s_" .. AllEnum.FrameColor_New[mapDisc.nRarity])
  self:SetAtlasSprite(self._mapNode.imgDiscStar, "12_rare", AllEnum.FrameType_New.DiscLimitS .. AllEnum.FrameColor_New[self.mapDisc.nRarity] .. "_0" .. self.mapDisc.nStar + 1)
  NovaAPI.SetImageNativeSize(self._mapNode.imgDiscStar)
  local sName = AllEnum.ElementIconType.Icon .. self.mapDisc.nEET
  NovaAPI.SetTMPText(self._mapNode.txtLevel, self.mapDisc.nLevel)
  self:SetAtlasSprite(self._mapNode.imgElement, "12_rare", sName)
end

function FormationDisc_SubDiscCtrl:OnBtnClick_Detail(btn)
  if self.mapDisc ~= nil then
    EventManager.Hit("DiscFormation_Detail", self.mapDisc.nId)
  end
end

function FormationDisc_SubDiscCtrl:OnBtnClick_Down(btn)
  EventManager.Hit("ForamtionDown", self.mapDisc, 2)
end

function FormationDisc_SubDiscCtrl:OnBtnClick_Lock(btn)
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("DiscFormation_UnlockDiscHint"))
end

return FormationDisc_SubDiscCtrl
