local TemplateSkillCharCtrl = class("TemplateSkillCharCtrl", BaseCtrl)
TemplateSkillCharCtrl._mapNodeConfig = {
  imgBg = {nCount = 2, sComponentName = "Image"},
  imgIcon = {sComponentName = "Image"},
  imgType = {sComponentName = "Image"},
  txtSkillLevel = {sComponentName = "TMP_Text"},
  Select = {}
}
TemplateSkillCharCtrl._mapEventConfig = {}

function TemplateSkillCharCtrl:SetSkill(nSkillId, nSkillIndex, nSkillLevel, nElementType, isCircle)
  if isCircle == nil then
    isCircle = false
  end
  self._mapNode.Select:SetActive(false)
  local skillCfg = ConfigTable.GetData_Skill(nSkillId)
  if nil == skillCfg then
    printError("找不到技能配置！！技能id = " .. nSkillId)
    return
  end
  local sName = AllEnum.ElementIconType.SkillEx .. nElementType
  if isCircle then
    sName = AllEnum.ElementIconType.VestigeSkill .. nElementType
  end
  local skillShowCfg = AllEnum.SkillTypeShow[nSkillIndex]
  self:SetAtlasSprite(self._mapNode.imgBg[1], "12_rare", sName)
  local bgIconIndex = skillShowCfg.bgIconIndex
  self:SetAtlasSprite(self._mapNode.imgBg[2], "10_ico", "zs_character_skill_" .. bgIconIndex)
  local _, color = ColorUtility.TryParseHtmlString(AllEnum.SkillElementBgColor[nElementType])
  NovaAPI.SetImageColor(self._mapNode.imgBg[2], Color(color.r, color.g, color.b, 0.19607843137254902))
  local skillTypeIconIdx = skillShowCfg.iconIndex
  self:SetAtlasSprite(self._mapNode.imgType, "05_language", "zs_character_skill_text_" .. skillTypeIconIdx)
  NovaAPI.SetImageNativeSize(self._mapNode.imgType)
  NovaAPI.SetTMPText(self._mapNode.txtSkillLevel, nSkillLevel)
  self:SetPngSprite(self._mapNode.imgIcon, skillCfg.Icon)
end

function TemplateSkillCharCtrl:SetSelect(bSelect)
  self._mapNode.Select:SetActive(bSelect)
end

function TemplateSkillCharCtrl:Awake()
end

function TemplateSkillCharCtrl:OnDestroy()
end

return TemplateSkillCharCtrl
