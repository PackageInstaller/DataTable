local TemplatePerkItemCtrl = class("TemplatePerkItemCtrl", BaseCtrl)
TemplatePerkItemCtrl._mapNodeConfig = {
  imgRare = {sComponentName = "Image"},
  imgIcon = {sComponentName = "Image"},
  imgSelect = {},
  goStar = {
    sCtrlName = "Game.UI.TemplateEx.TemplateStarCtrl"
  },
  imgMask = {nCount = 2, sComponentName = "Image"},
  Enhanced = {},
  imgEnhancedNone = {},
  imgEnhancedBar = {nCount = 2},
  txtEnhancedState1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "PerkQuest_State_Doing"
  },
  txtEnhancedState2 = {sComponentName = "TMP_Text"}
}
TemplatePerkItemCtrl._mapEventConfig = {}

function TemplatePerkItemCtrl:SetPerk(nTid, nStar, nMaxStar, bHas, nState)
  local mapCfg = ConfigTable.GetData_Item(nTid)
  self:SetPngSprite(self._mapNode.imgIcon, mapCfg.Icon)
  local mapPerk = ConfigTable.GetData_Perk(nTid)
  local bEnhanced = mapPerk.PerkType == GameEnum.perkType.Strengthen
  local sPath = ""
  if mapPerk.Slot ~= 0 then
    sPath = AllEnum.FrameType_New.SlotPerk .. 4
  elseif bEnhanced then
    sPath = AllEnum.FrameType_New.SlotPerk .. 5
  else
    sPath = AllEnum.FrameType_New.ThemePerk .. AllEnum.FrameColor_New[mapCfg.Rarity]
  end
  self:SetAtlasSprite(self._mapNode.imgRare, "12_rare", sPath)
  self._mapNode.goStar:SetStar(nStar, nMaxStar)
  self._mapNode.imgSelect:SetActive(false)
  if bHas == false then
    if bEnhanced then
      self._mapNode.Enhanced:SetActive(true)
      self._mapNode.imgMask[2].gameObject:SetActive(nState ~= AllEnum.EnhancedPerkState.Off)
      self._mapNode.imgEnhancedBar[1]:SetActive(nState == AllEnum.EnhancedPerkState.On)
      self._mapNode.imgEnhancedBar[2]:SetActive(nState ~= AllEnum.EnhancedPerkState.On)
      self._mapNode.imgEnhancedNone:SetActive(nState == AllEnum.EnhancedPerkState.Off)
      self._mapNode.imgIcon.gameObject:SetActive(nState ~= AllEnum.EnhancedPerkState.Off)
      if nState == AllEnum.EnhancedPerkState.Off then
        NovaAPI.SetTMPText(self._mapNode.txtEnhancedState2, ConfigTable.GetUIText("PerkQuest_State_Off"))
      elseif nState == AllEnum.EnhancedPerkState.Lock then
        NovaAPI.SetTMPText(self._mapNode.txtEnhancedState2, ConfigTable.GetUIText("PerkQuest_State_Stop"))
      end
    else
      self._mapNode.imgMask[1].gameObject:SetActive(true)
      self:SetAtlasSprite(self._mapNode.imgMask[1], "12_rare", sPath)
    end
  else
    self._mapNode.imgMask[1].gameObject:SetActive(false)
    self._mapNode.Enhanced:SetActive(false)
  end
end

function TemplatePerkItemCtrl:SetSelect(bSelect)
  self._mapNode.imgSelect:SetActive(bSelect)
end

return TemplatePerkItemCtrl
