local TemplateSkillSelectCtrl = class("TemplateSkillSelectCtrl", BaseCtrl)
TemplateSkillSelectCtrl._mapNodeConfig = {
  imgBg = {nCount = 2, sComponentName = "Image"},
  imgIcon = {sComponentName = "Image"},
  imgType = {sComponentName = "Image"},
  txtSkillLevelTxt = {
    sComponentName = "TMP_Text",
    sLanguageId = "CharacterSkill_Level"
  },
  txtSkillLevel = {nCount = 2, sComponentName = "TMP_Text"},
  txtAddLv = {sComponentName = "TMP_Text"},
  imgLv = {},
  Select = {},
  imgSelect = {},
  animRoot = {sNodeName = "AnimRoot", sComponentName = "Animator"},
  txtSkillName = {sComponentName = "TMP_Text"},
  imgSkillTypeBg = {sComponentName = "Image"},
  txtSkillType = {sComponentName = "TMP_Text"},
  imgSkillType = {sComponentName = "Image"}
}
TemplateSkillSelectCtrl._mapEventConfig = {}

function TemplateSkillSelectCtrl:SetSkill(nSkillId, nSkillIndex, nSkillLevel, nElementType, nAddLv)
  self._mapNode.Select:SetActive(false)
  self._mapNode.imgLv.gameObject:SetActive(true)
  self._mapNode.imgType.gameObject:SetActive(true)
  local skillCfg = ConfigTable.GetData_Skill(nSkillId)
  if nil == skillCfg then
    printError("找不到技能配置！！技能id = " .. nSkillId)
    return
  end
  local sName = AllEnum.ElementIconType.SkillEx .. nElementType
  self:SetAtlasSprite(self._mapNode.imgBg[1], "12_rare", sName)
  local skillShowCfg = AllEnum.SkillTypeShow[nSkillIndex]
  local bgIconIndex = skillShowCfg.bgIconIndex
  self:SetAtlasSprite(self._mapNode.imgBg[2], "10_ico", "zs_character_skill_" .. bgIconIndex)
  local _, color = ColorUtility.TryParseHtmlString(AllEnum.SkillElementBgColor[nElementType])
  NovaAPI.SetImageColor(self._mapNode.imgBg[2], Color(color.r, color.g, color.b, 0.19607843137254902))
  local skillTypeIconIdx = skillShowCfg.iconIndex
  self:SetAtlasSprite(self._mapNode.imgType, "05_language", "zs_character_skill_text_" .. skillTypeIconIdx)
  NovaAPI.SetImageNativeSize(self._mapNode.imgType)
  self:SetPngSprite(self._mapNode.imgIcon, skillCfg.Icon)
  local _, _color = ColorUtility.TryParseHtmlString(skillShowCfg.bgColor)
  NovaAPI.SetImageColor(self._mapNode.imgSkillTypeBg, _color)
  NovaAPI.SetTMPText(self._mapNode.txtSkillLevel[1], nSkillLevel)
  NovaAPI.SetTMPText(self._mapNode.txtSkillLevel[2], nSkillLevel + nAddLv)
  self._mapNode.txtAddLv.gameObject:SetActive(0 < nAddLv)
  if 0 < nAddLv then
    NovaAPI.SetTMPText(self._mapNode.txtAddLv, "(+" .. nAddLv .. ")")
  end
  NovaAPI.SetTMPText(self._mapNode.txtSkillName, skillCfg.Title)
  self:SetAtlasSprite(self._mapNode.imgSkillType, "05_language", "zs_character_skill_text_" .. skillTypeIconIdx)
  NovaAPI.SetImageNativeSize(self._mapNode.imgSkillType)
  NovaAPI.SetTMPText(self._mapNode.txtSkillType, ConfigTable.GetUIText(skillShowCfg.sLanguageId))
end

function TemplateSkillSelectCtrl:SetSelect(bSelect)
  self._mapNode.imgSelect.gameObject:SetActive(bSelect)
  self._mapNode.imgLv:SetActive(not bSelect)
  self._mapNode.imgType.gameObject:SetActive(not bSelect)
  if bSelect then
    self._mapNode.Select:SetActive(true)
    self._mapNode.animRoot:Play("tc_skill_char_select")
  else
    self._mapNode.animRoot:Play("tc_skill_char_close")
  end
end

function TemplateSkillSelectCtrl:Awake()
end

function TemplateSkillSelectCtrl:OnDestroy()
end

return TemplateSkillSelectCtrl
