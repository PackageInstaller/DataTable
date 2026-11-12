local SkillListCtrl = class("SkillListCtrl", BaseCtrl)
SkillListCtrl._mapNodeConfig = {
  rtSkillGrid = {
    nCount = 4,
    sCtrlName = "Game.UI.GachaEx.GachaPreview.SkillListGridCtrl"
  },
  txtTalentTitle = {sComponentName = "TMP_Text"},
  imgTalentBg = {sComponentName = "Image"},
  imgTalent = {sComponentName = "Image"},
  txtTalentName = {sComponentName = "TMP_Text"},
  TMPDescTalent = {sComponentName = "TMP_Text"},
  TMP_Link = {
    sNodeName = "TMPDescTalent",
    sComponentName = "TMPHyperLink",
    callback = "OnBtnClick_Word"
  }
}
SkillListCtrl._mapEventConfig = {}

function SkillListCtrl:Awake()
end

function SkillListCtrl:FadeIn()
end

function SkillListCtrl:FadeOut()
end

function SkillListCtrl:OnEnable()
end

function SkillListCtrl:OnDisable()
end

function SkillListCtrl:OnDestroy()
end

function SkillListCtrl:OnRelease()
end

function SkillListCtrl:Refresh(nCharId)
  local mapCharCfgData = ConfigTable.GetData_Character(nCharId)
  if mapCharCfgData == nil then
    self.gameObject:SetActive(false)
    return
  end
  local mapSkillNormal = ConfigTable.GetData_Skill(mapCharCfgData.NormalAtkId)
  local mapSkillMain = ConfigTable.GetData_Skill(mapCharCfgData.SkillId)
  local mapSkillAssist = ConfigTable.GetData_Skill(mapCharCfgData.AssistSkillId)
  local mapSkillUltra = ConfigTable.GetData_Skill(mapCharCfgData.UltimateId)
  local mapSkillTalent = ConfigTable.GetData_Skill(mapCharCfgData.TalentSkillId)
  local nNormalMaxLevel = PlayerData.Char:GetCharSkillMaxLevel(nCharId, 1)
  local nMainMaxLevel = PlayerData.Char:GetCharSkillMaxLevel(nCharId, 2)
  local nAssistMaxLevel = PlayerData.Char:GetCharSkillMaxLevel(nCharId, 3)
  local nUltraMaxLevel = PlayerData.Char:GetCharSkillMaxLevel(nCharId, 4)
  self._mapNode.rtSkillGrid[1]:SetSkill(mapSkillNormal.Id, nNormalMaxLevel, nCharId, 1)
  self._mapNode.rtSkillGrid[2]:SetSkill(mapSkillMain.Id, nMainMaxLevel, nCharId, 2)
  self._mapNode.rtSkillGrid[3]:SetSkill(mapSkillAssist.Id, nAssistMaxLevel, nCharId, 3)
  self._mapNode.rtSkillGrid[4]:SetSkill(mapSkillUltra.Id, nUltraMaxLevel, nCharId, 4)
  if nil ~= mapSkillTalent then
    NovaAPI.SetTMPText(self._mapNode.txtTalentName, mapSkillTalent.Title)
    local _, color = ColorUtility.TryParseHtmlString(AllEnum.SkillElementColor[mapCharCfgData.EET])
    NovaAPI.SetImageColor(self._mapNode.imgTalentBg, color)
    local sDesc = UTILS.ParseDesc(mapSkillTalent)
    NovaAPI.SetTMPText(self._mapNode.TMPDescTalent, sDesc)
    self:SetPngSprite(self._mapNode.imgTalent, mapSkillTalent.Icon)
  end
end

function SkillListCtrl:OnBtnClick_Word(link, sWordId)
  UTILS.ClickWordLink(link, sWordId)
end

return SkillListCtrl
