local SkillListGridCtrl = class("SkillListGridCtrl", BaseCtrl)
local ConfigData = require("GameCore.Data.ConfigData")
SkillListGridCtrl._mapNodeConfig = {
  imgSkillIconBg = {sComponentName = "Image"},
  imgzsIcon = {sComponentName = "Image"},
  imgIconSkill = {sComponentName = "Image"},
  imgSkillTypeBg = {sComponentName = "Image"},
  txtSkillType = {sComponentName = "TMP_Text"},
  imgSkillType = {sComponentName = "Image"},
  TMPTitle = {sComponentName = "TMP_Text"},
  txtSkillLevel = {sComponentName = "TMP_Text"},
  imgEnergyInfoBg = {},
  imgCDInfoBg = {},
  srSkillDesc = {
    sComponentName = "RectTransform"
  },
  TMPCDTitle = {sComponentName = "TMP_Text", sLanguageId = "Talent_CD"},
  TMPCD = {sComponentName = "TMP_Text"},
  TMPEnergyTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Talent_Cost"
  },
  TMPEnergy = {sComponentName = "TMP_Text"},
  TMPDesc = {sComponentName = "TMP_Text"},
  rtTMPDesc = {
    sComponentName = "RectTransform",
    sNodeName = "TMPDesc"
  },
  TMP_Link = {
    sNodeName = "TMPDesc",
    sComponentName = "TMPHyperLink",
    callback = "OnBtnClick_Word"
  }
}
SkillListGridCtrl._mapEventConfig = {}

function SkillListGridCtrl:Awake()
end

function SkillListGridCtrl:FadeIn()
end

function SkillListGridCtrl:FadeOut()
end

function SkillListGridCtrl:OnEnable()
end

function SkillListGridCtrl:OnDisable()
end

function SkillListGridCtrl:OnDestroy()
end

function SkillListGridCtrl:OnRelease()
end

function SkillListGridCtrl:SetSkill(nSkillId, nLevel, nCharId, nType)
  local mapCharCfgData = ConfigTable.GetData_Character(nCharId)
  local mapCfgDataSkill = ConfigTable.GetData_Skill(nSkillId)
  local nCD = FormatNum(mapCfgDataSkill.SkillCD * ConfigData.IntFloatPrecision)
  local nCost = FormatNum(mapCfgDataSkill.UltraEnergy * ConfigData.IntFloatPrecision)
  NovaAPI.SetTMPText(self._mapNode.txtSkillLevel, ConfigTable.GetUIText("Skill_Level") .. nLevel)
  self:SetAtlasSprite(self._mapNode.imgSkillIconBg, "12_rare", AllEnum.ElementIconType.SkillEx .. mapCharCfgData.EET)
  self:SetPngSprite(self._mapNode.imgIconSkill, mapCfgDataSkill.Icon)
  local skillShowCfg = AllEnum.SkillTypeShow[nType]
  NovaAPI.SetTMPText(self._mapNode.txtSkillType, ConfigTable.GetUIText(skillShowCfg.sLanguageId))
  self:SetAtlasSprite(self._mapNode.imgzsIcon, "10_ico", "zs_character_skill_" .. skillShowCfg.bgIconIndex)
  local _, color = ColorUtility.TryParseHtmlString(AllEnum.SkillElementBgColor[mapCharCfgData.EET])
  NovaAPI.SetImageColor(self._mapNode.imgzsIcon, Color(color.r, color.g, color.b, 0.19607843137254902))
  local skillTypeIconIdx = skillShowCfg.iconIndex
  self:SetAtlasSprite(self._mapNode.imgSkillType, "05_language", "zs_character_skill_text_" .. skillTypeIconIdx)
  NovaAPI.SetImageNativeSize(self._mapNode.imgSkillType)
  local _, _color = ColorUtility.TryParseHtmlString(skillShowCfg.bgColor)
  NovaAPI.SetImageColor(self._mapNode.imgSkillTypeBg, _color)
  NovaAPI.SetTMPText(self._mapNode.TMPTitle, mapCfgDataSkill.Title)
  local sCD = tostring(nCD) .. ConfigTable.GetUIText("Talent_Sec")
  local sCost = tostring(nCost)
  if nCD <= 0 then
    sCD = ConfigTable.GetUIText("Skill_NoCD")
  end
  if nCost <= 0 then
    sCost = ConfigTable.GetUIText("Skill_NoCost")
  end
  NovaAPI.SetTMPText(self._mapNode.TMPCD, sCD)
  NovaAPI.SetTMPText(self._mapNode.TMPEnergy, sCost)
  local bVisibleCD, bVisibleCost = false, false
  if mapCfgDataSkill.Type == GameEnum.skillType.NORMAL then
    bVisibleCD, bVisibleCost = false, false
  elseif mapCfgDataSkill.Type == GameEnum.skillType.SKILL or mapCfgDataSkill.Type == GameEnum.skillType.SUPPORT then
    bVisibleCD, bVisibleCost = true, false
  elseif mapCfgDataSkill.Type == GameEnum.skillType.ULTIMATE then
    bVisibleCD, bVisibleCost = true, true
  end
  self._mapNode.imgEnergyInfoBg:SetActive(bVisibleCost)
  self._mapNode.imgCDInfoBg:SetActive(bVisibleCD)
  NovaAPI.SetTMPText(self._mapNode.TMPDesc, UTILS.ParseDesc(mapCfgDataSkill))
end

function SkillListGridCtrl:OnBtnClick_Word(link, sWordId)
  UTILS.ClickWordLink(link, sWordId)
end

return SkillListGridCtrl
