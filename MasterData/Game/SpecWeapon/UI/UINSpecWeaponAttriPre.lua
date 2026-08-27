local UINSpecWeaponAttriPre = class("UINSpecWeaponAttriPre", UIBaseNode)
local base = UIBaseNode
local UINHeroTalentNodeDetailEffect = require("Game.HeroTalent.UI.UINHeroTalentNodeDetailEffect")
local UINSpecWeaponSkillItem = require("Game.SpecWeapon.UI.UINSpecWeaponSkillItem")
local HeroSkillData = require("Game.PlayerData.Skill.HeroSkillData")

function UINSpecWeaponAttriPre:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.tween_root.onRewind:AddListener(BindCallback(self, self.__OnMoveTweenRewind))
  self._attriPool = UIItemPool.New(UINHeroTalentNodeDetailEffect, self.ui.attItem)
  self.ui.attItem:SetActive(false)
  self._skillPool = UIItemPool.New(UINSpecWeaponSkillItem, self.ui.texDescItem)
  self.ui.texDescItem:SetActive(false)
end

function UINSpecWeaponAttriPre:InitSpecWeaponAttriPre(specWeaponData, heroData, resloader, skillIntroCallback, closeCallback)
  self._specWeaponData = specWeaponData
  self._skillIntroCallback = skillIntroCallback
  self._resloader = resloader
  self._closeCallback = closeCallback
  self._heroData = heroData
  local baseCfg = self._specWeaponData:GetSpecWeaponBasicCfg()
  self.ui.tex_Name.text = self._heroData:GetName()
  self.ui.tex_HeroTip.text = LanguageUtil.GetLocaleText(baseCfg.name)
  self.ui.tex_Desc.text = LanguageUtil.GetLocaleText(baseCfg.describe)
  self.ui.img_HeroPic.gameObject:SetActive(false)
  local path = PathConsts:GetCharacterPicPath(self._heroData:GetResPicName())
  self._resloader:LoadABAssetAsync(path, function(texture)
    if IsNull(self.transform) or IsNull(texture) then
      return
    end
    self.ui.img_HeroPic.gameObject:SetActive(true)
    self.ui.img_HeroPic.texture = texture
  end)
end

function UINSpecWeaponAttriPre:OpenSpecWeaponAttriPre(lock)
  if lock then
    self.ui.text_stage.text.text = ""
    self.ui.heroNode:SetActive(false)
  else
    self.ui.heroNode:SetActive(true)
    self:__Refresh()
  end
  if self.canClose ~= false then
    self.canClose = false
    self.ui.tween_root:DORewind()
    self.ui.tween_root:DOPlayForward()
  end
end

function UINSpecWeaponAttriPre:__Refresh()
  local step = self._specWeaponData:GetSpecWeaponCurStep()
  local level = self._specWeaponData:GetSpecWeaponCurLevel()
  self.ui.text_stage:SetIndex(0, LanguageUtil.GetRomanNumber(step), tostring(level))
  self:__RefreshAttri(step, level)
  self:__RefreshSkill(step, level)
end

function UINSpecWeaponAttriPre:__RefreshAttri(step, level)
  self._attriPool:HideAll()
  local nowAttriDic = self._specWeaponData:GetSpecWeaponAttriAddtion()
  local nowShowDic = {}
  for attriId, _ in pairs(nowAttriDic) do
    local attriCfg = ConfigData.attribute[attriId]
    local showAttriId = attriCfg.merge_attribute > 0 and attriCfg.merge_attribute or attriId
    if nowShowDic[showAttriId] == nil then
      nowShowDic[showAttriId] = self._heroData:GetAttr(showAttriId, false, true)
    end
  end
  self._specWeaponData:RefreshSpecWeapon(0, 0)
  for attriId, v in pairs(nowShowDic) do
    local item = self._attriPool:GetOne()
    local oriAttriVal = self._heroData:GetAttr(attriId, false, true)
    item:RefreshDetailEffectByAttriId(attriId, v - oriAttriVal, nil, false)
  end
  self._specWeaponData:RefreshSpecWeapon(step, level)
end

function UINSpecWeaponAttriPre:__RefreshSkill(step, level)
  self._skillPool:HideAll()
  local nowStepCfg = self._specWeaponData:GetSpecWeaponStepCfg(step)
  local hasReplaceSkill = table.count(nowStepCfg.replaceSkillDic)
  if not hasReplaceSkill then
    self.ui.skillNode:SetActive(false)
    return
  end
  self.ui.skillNode:SetActive(true)
  for i = 1, step do
    local stepCfg = self._specWeaponData:GetSpecWeaponStepCfg(i)
    for i, skillId in ipairs(stepCfg.new_skills) do
      local item = self._skillPool:GetOne()
      local desCfg = ConfigData.spec_weapon_skill_des[skillId]
      local skillData = HeroSkillData.New(skillId, self._heroData)
      skillData:UpdateSkill(1)
      local desStr = LanguageUtil.GetLocaleText(desCfg.new_skill_describe)
      item:InitSpecWeaponSkilDes(skillData, desStr, self._resloader, function()
        if self._skillIntroCallback ~= nil then
          self._skillIntroCallback(skillId, stepCfg.last_skills[i])
        end
      end)
    end
  end
end

function UINSpecWeaponAttriPre:OnClickSkillIntro()
  if self._skillIntroCallback ~= nil then
    self._skillIntroCallback()
  end
end

function UINSpecWeaponAttriPre:OnClosePreView()
  self.canClose = true
  self.ui.tween_root:DOPlayBackwards()
  if self._closeCallback ~= nil then
    self._closeCallback()
  end
end

function UINSpecWeaponAttriPre:__OnMoveTweenRewind()
  if self.canClose then
    self.canClose = false
    self:Hide()
  end
end

function UINSpecWeaponAttriPre:OnDelete()
  self.ui.tween_root:DOKill()
  base.OnDelete(self)
end

return UINSpecWeaponAttriPre
