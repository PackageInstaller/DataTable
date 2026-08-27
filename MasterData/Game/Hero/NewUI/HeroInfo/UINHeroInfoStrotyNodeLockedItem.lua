local UINHeroInfoStrotyNodeLockedItem = class("UINHeroInfoStrotyNodeLockedItem", UIBaseNode)
local base = UIBaseNode
local eHeroInfoenum = require("Game.Hero.NewUI.HeroInfo.eHeroInfoenum")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UINHeroInfoStrotyNodeLockedItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Unlock, self, self.__OnClickUnlock)
  self.baseItemWithCount = UINBaseItemWithCount.New()
  self.baseItemWithCount:Init(self.ui.uINBaseItemWithCount)
end

function UINHeroInfoStrotyNodeLockedItem:InitHISNLockedItem(storyData, unlockCallback)
  self.storyData = storyData
  self.unlockCallback = unlockCallback
  if storyData.state == eHeroInfoenum.achriveState.locked then
    self:__SetUIState(false)
  elseif storyData.state == eHeroInfoenum.achriveState.completed then
    self:__SetUIState(true)
  else
    error("UINHeroInfoStrotyNodeLockedItem state is not legal")
  end
  local itemId = self.storyData.cfg.awardIds[1]
  local num = self.storyData.cfg.awardNums[1]
  local itemCfg = ConfigData.item[itemId]
  self.baseItemWithCount:InitItemWithCount(itemCfg, num)
end

function UINHeroInfoStrotyNodeLockedItem:__SetUIState(isCompleted)
  self.ui.btn_Unlock.gameObject:SetActive(isCompleted)
  local color
  self.ui.redDot:SetActive(isCompleted)
  if isCompleted then
    self.ui.imgInfo_LockIcon:SetIndex(1)
    self.ui.texInfo_Condition:SetIndex(1)
    color = self.ui.color_completed
  else
    self.ui.imgInfo_LockIcon:SetIndex(0)
    self.ui.texInfo_Condition:SetIndex(0, tostring(self.storyData.cfg.friendship_level))
    color = self.ui.color_locked
  end
  self.ui.tex_Condition.color = color
  self.ui.img_LockIcon.color = color
  self.ui.text.color = color
end

function UINHeroInfoStrotyNodeLockedItem:__OnClickUnlock()
  if self.unlockCallback ~= nil then
    self.unlockCallback(self.storyData)
  end
end

function UINHeroInfoStrotyNodeLockedItem:OnDelete()
  base.OnDelete(self)
end

return UINHeroInfoStrotyNodeLockedItem
