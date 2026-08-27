local UIHStarUpSkillNode = class("UIHStarUpSkillNode", UIBaseNode)
local base = UIBaseNode
local UINBaseSkillItem = require("Game.CommonUI.Item.UINBaseSkillItem")
local UIRichIntroItem = require("Game.CommonUI.RichIntro.UIRichIntroItem")

function UIHStarUpSkillNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.skillItem = UINBaseSkillItem.New()
  self.skillItem:Init(self.ui.skillItem)
  self.richIntroItemPool = UIItemPool.New(UIRichIntroItem, self.ui.obj_richIntroItem)
  self.ui.obj_richIntroItem:SetActive(false)
  UIUtil.AddButtonListener(self.ui.btn_Back, self, self.__OnClickBackButton)
end

function UIHStarUpSkillNode:InitStarUpSkillNode(skillData, preUSkilllevel, resloader, unlockAdvance)
  self.skillItem:InitBaseSkillItem(skillData, resloader)
  self.skillItem:__SetUnlockUI(true)
  if preUSkilllevel ~= nil then
    self.ui.tex_Name.text = skillData:GetName() .. " LV." .. tostring(preUSkilllevel)
  else
    self.ui.tex_Name.text = skillData:GetName()
  end
  local intro
  if preUSkilllevel ~= nil then
    intro = skillData:GetLevelDescribe(preUSkilllevel)
  else
    intro = skillData:GetCurLevelDescribe(unlockAdvance)
  end
  self.ui.tex_Intro.text = intro
  local skillLabeList = skillData:GetSkillLabeIdList(preUSkilllevel or 1)
  self.richIntroItemPool:HideAll()
  if skillLabeList ~= nil then
    for i = 1, #skillLabeList do
      local item = self.richIntroItemPool:GetOne()
      local cfg = ConfigData.skill_label_info[skillLabeList[i]]
      if cfg ~= nil then
        item:InitRichIntroItem(cfg)
      end
    end
  end
  self.ui.Ani_Fade:DORestart(false)
end

function UIHStarUpSkillNode:__OnClickBackButton()
  self:Hide()
end

function UIHStarUpSkillNode:OnDelete()
  self.ui.Ani_Fade:DOKill()
  base.OnDelete(self)
end

return UIHStarUpSkillNode
