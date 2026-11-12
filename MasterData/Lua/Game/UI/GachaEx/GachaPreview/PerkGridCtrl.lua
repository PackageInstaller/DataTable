local SkillListGridCtrl = class("SkillListGridCtrl", BaseCtrl)
local ConfigData = require("GameCore.Data.ConfigData")
local minHeight = 178.84
local defaultWidth = 673
SkillListGridCtrl._mapNodeConfig = {
  imgPerkIcon = {sComponentName = "Image"},
  TMPPerkTitle = {sComponentName = "TMP_Text"},
  TMPDesc = {sComponentName = "TMP_Text"},
  rtTMPDesc = {
    sNodeName = "TMPDesc",
    sComponentName = "RectTransform"
  },
  imgDescBg = {
    sComponentName = "RectTransform"
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

function SkillListGridCtrl:SetPerk(nPerkId)
  if nPerkId == 0 or nPerkId == nil then
    self.gameObject:SetActive(false)
    return
  end
  local perkCfgData = ConfigTable.GetData_Perk(nPerkId)
  local perkItemCfgData = ConfigTable.GetData_Item(nPerkId)
  if perkCfgData == nil or perkItemCfgData == nil then
    self.gameObject:SetActive(false)
    return
  end
  local skillId = perkCfgData.EffectGroupId * 100 + 1
  local mapSkill = ConfigTable.GetData("PerkPassiveSkill", skillId)
  if mapSkill == nil then
    self.gameObject:SetActive(false)
    return
  end
  self.gameObject:SetActive(true)
  local sDesc = UTILS.SubDesc(mapSkill.Desc)
  NovaAPI.SetTMPSourceText(self._mapNode.TMPDesc, sDesc)
  NovaAPI.SetTMPText(self._mapNode.TMPPerkTitle, perkItemCfgData.Title)
  self:SetPngSprite(self._mapNode.imgPerkIcon, perkItemCfgData.Icon)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    local height = self._mapNode.rtTMPDesc.sizeDelta.y
    if height < minHeight then
      height = minHeight
    end
    self._mapNode.imgDescBg.sizeDelta = Vector2(defaultWidth, height)
  end
  
  cs_coroutine.start(wait)
end

function SkillListGridCtrl:OnBtnClick_Word(link, sWordId)
  UTILS.ClickWordLink(link, sWordId)
end

return SkillListGridCtrl
