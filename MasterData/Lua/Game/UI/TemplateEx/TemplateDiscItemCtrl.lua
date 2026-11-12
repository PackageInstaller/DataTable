local TemplateDiscItemCtrl = class("TemplateDiscItemCtrl", BaseCtrl)
TemplateDiscItemCtrl._mapNodeConfig = {
  imgIcon = {sComponentName = "Image"},
  txtLevel = {sComponentName = "TMP_Text"},
  txtLv = {sComponentName = "TMP_Text", sLanguageId = "Lv"},
  goStar = {sComponentName = "Image"},
  imgNoteBg = {nCount = 3, sComponentName = "Image"},
  Select = {},
  imgEET = {sComponentName = "Image"},
  txtDiscTag = {nCount = 3, sComponentName = "TMP_Text"},
  imgRareBg = {sComponentName = "Image"}
}
TemplateDiscItemCtrl._mapEventConfig = {}

function TemplateDiscItemCtrl:Refresh(nId, nStar, nMaxStar, nLevel, tbNote)
  local mapCfg = ConfigTable.GetData("Disc", nId)
  local mapItem = ConfigTable.GetData_Item(nId)
  if not mapCfg or not mapItem then
    return
  end
  self:SetAtlasSprite(self._mapNode.imgRareBg, "12_rare", AllEnum.FrameType_New.DiscFrameS .. AllEnum.FrameColor_New[mapItem.Rarity])
  self:SetPngSprite(self._mapNode.imgIcon, mapItem.Icon .. AllEnum.OutfitIconSurfix.OutInfo)
  local sName = AllEnum.ElementIconType.Icon .. mapCfg.EET
  self:SetAtlasSprite(self._mapNode.imgEET, "12_rare", sName)
  self._mapNode.txtLevel.gameObject:SetActive(nLevel)
  if nLevel then
    NovaAPI.SetTMPText(self._mapNode.txtLevel, nLevel)
  end
  self._mapNode.goStar.gameObject:SetActive(nStar)
  if nStar then
    self:SetAtlasSprite(self._mapNode.goStar, "12_rare", AllEnum.FrameType_New.DiscLimitS .. AllEnum.FrameColor_New[mapItem.Rarity] .. "_0" .. nStar + 1)
    NovaAPI.SetImageNativeSize(self._mapNode.goStar)
  end
  if tbNote then
    for i = 1, 3 do
      self._mapNode.imgNoteBg[i].gameObject:SetActive(tbNote[i])
      if tbNote[i] then
        local mapNote = ConfigTable.GetData("SubNoteSkill", tbNote[i])
        if mapNote then
          self:SetPngSprite(self._mapNode.imgNoteBg[i], mapNote.Icon .. AllEnum.DiscSkillIconSurfix.Small)
        end
      end
    end
  else
    for i = 1, 3 do
      self._mapNode.imgNoteBg[i].gameObject:SetActive(false)
    end
  end
  for i = 1, 3 do
    local nTag = mapCfg.Tags[i]
    if nTag then
      self._mapNode.txtDiscTag[i].gameObject:SetActive(true)
      NovaAPI.SetTMPText(self._mapNode.txtDiscTag[i], ConfigTable.GetData("DiscTag", nTag).Title)
    else
      self._mapNode.txtDiscTag[i].gameObject:SetActive(false)
    end
  end
end

function TemplateDiscItemCtrl:SetSelect(bSelect)
  self._mapNode.Select:SetActive(bSelect)
end

function TemplateDiscItemCtrl:Awake()
  self._mapNode.Select:SetActive(false)
end

return TemplateDiscItemCtrl
