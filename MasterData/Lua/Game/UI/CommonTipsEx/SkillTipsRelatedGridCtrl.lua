local ConfigData = require("GameCore.Data.ConfigData")
local SkillTipsRelatedGridCtrl = class("SkillTipsRelatedGridCtrl", BaseCtrl)
SkillTipsRelatedGridCtrl._mapNodeConfig = {
  TMPRelatedSkillTitle = {sComponentName = "TMP_Text"},
  TMPRelatedSkillLevel = {sComponentName = "TMP_Text"},
  imgRelatedSkillBg = {sComponentName = "Image"},
  imgRelatedSkillIcon = {sComponentName = "Image"},
  TMPRelatedSkillDesc = {sComponentName = "TMP_Text"},
  imgRelatedCDInfoBg = {},
  imgRelatedEnergyInfoBg = {},
  rtRelatedSkillInfo = {},
  TMPRelatedEnergy = {sComponentName = "TMP_Text"},
  TMPRelatedCD = {sComponentName = "TMP_Text"},
  imgLine = {},
  TMP_LinkRelatedSkill = {
    sNodeName = "TMPRelatedSkillDesc",
    sComponentName = "TMPHyperLink",
    callback = "OnBtnClick_Word"
  }
}
SkillTipsRelatedGridCtrl._mapEventConfig = {}

function SkillTipsRelatedGridCtrl:Refresh(nSkillId, nLevel, nElement, bLast)
  local mapSkill = ConfigTable.GetData_Skill(nSkillId)
  if mapSkill == nil then
    printError("SkillId未找到：" .. nSkillId)
    return
  end
  self:SetPngSprite(self._mapNode.imgRelatedSkillIcon, ConfigTable.GetData_Skill(nSkillId).Icon)
  self:SetAtlasSprite(self._mapNode.imgRelatedSkillBg, "12_rare", AllEnum.ElementIconType.Skill .. nElement)
  NovaAPI.SetTMPText(self._mapNode.TMPRelatedSkillTitle, mapSkill.Title)
  NovaAPI.SetTMPText(self._mapNode.TMPRelatedSkillLevel, orderedFormat(ConfigTable.GetUIText("CommonTips_LevelFormat"), nLevel))
  if mapSkill.Type == GameEnum.skillType.SKILL or mapSkill.Type == GameEnum.skillType.SUPPORT then
    self._mapNode.imgRelatedCDInfoBg:SetActive(true)
    self._mapNode.imgRelatedEnergyInfoBg:SetActive(false)
  elseif mapSkill.Type == GameEnum.skillType.ULTIMATE then
    self._mapNode.imgRelatedCDInfoBg:SetActive(true)
    self._mapNode.imgRelatedEnergyInfoBg:SetActive(true)
  else
    self._mapNode.imgRelatedCDInfoBg:SetActive(false)
    self._mapNode.imgRelatedEnergyInfoBg:SetActive(false)
    self._mapNode.rtRelatedSkillInfo:SetActive(false)
  end
  local bHasSectionResumeTime = mapSkill.SectionResumeTime and mapSkill.SectionResumeTime ~= "" and mapSkill.SectionResumeTime ~= 0
  local nCd = bHasSectionResumeTime and mapSkill.SectionResumeTime or mapSkill.SkillCD
  local sCd = tostring(FormatNum(nCd * ConfigData.IntFloatPrecision)) .. ConfigTable.GetUIText("Talent_Sec")
  if nCd <= 0 then
    sCd = ConfigTable.GetUIText("Skill_NoCD")
  end
  NovaAPI.SetTMPText(self._mapNode.TMPRelatedCD, sCd)
  NovaAPI.SetTMPText(self._mapNode.TMPRelatedEnergy, FormatNum(mapSkill.UltraEnergy * ConfigData.IntFloatPrecision))
  local sDesc = UTILS.ParseDesc(mapSkill)
  NovaAPI.SetTMPSourceText(self._mapNode.TMPRelatedSkillDesc, sDesc)
  self._mapNode.imgLine:SetActive(not bLast)
end

function SkillTipsRelatedGridCtrl:OnBtnClick_Word(link, _, sWordId)
  if self.parent ~= nil then
    self.parent:OnBtnClick_Word(link, _, sWordId)
  end
end

function SkillTipsRelatedGridCtrl:SetParent(parent)
  self.parent = parent
end

return SkillTipsRelatedGridCtrl
