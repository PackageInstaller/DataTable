local UINSpring23StoryLvRewardShowItem = class("UINSpring23StoryLvRewardShowItem", UIBaseNode)
local base = UIBaseNode
local ActivitySpringStoryEnum = require("Game.ActivitySpring.Data.ActivitySpringStoryEnum")
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local CS_DOTween = CS.DG.Tweening.DOTween

function UINSpring23StoryLvRewardShowItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._itemPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.UINBaseItemWithReceived, false)
end

function UINSpring23StoryLvRewardShowItem:InitUINSpring23StoryTeamLiveSuccess(cfg, gotLevel)
  local isClear = gotLevel >= cfg.level
  self.ui.tex_Lvl.text = tostring(cfg.level)
  self:RefreshGetState(isClear)
  self._itemPool:HideAll()
  for i, itemId in ipairs(cfg.reward_ids) do
    local itemCfg = ConfigData.item[itemId]
    local itemCount = cfg.reward_nums[i]
    local item = self._itemPool:GetOne()
    item:InitItemWithCount(itemCfg, itemCount, nil, isClear)
  end
end

function UINSpring23StoryLvRewardShowItem:RefreshGetState(isClear)
  self.ui.Obj_Clear:SetActive(isClear)
  self.ui.tex_Lvl.color = isClear and self.ui.gotColor or self.ui.notGetColor
  self.ui.tex_NorLv.color = isClear and self.ui.gotColor or self.ui.notGetColor
  self.ui.img_line.color = isClear and self.ui.gotColor or self.ui.notGetColor
  self.ui.img_Bottom.color = isClear and self.ui.gotBottomColor or self.ui.notGetBottomColor
  self.ui.tex_Word.color = isClear and self.ui.gotWordColor or self.ui.notGetWordColor
end

function UINSpring23StoryLvRewardShowItem:OnClickBtnBack()
  self:Hide()
end

function UINSpring23StoryLvRewardShowItem:OnDelete()
  base.OnDelete(self)
end

return UINSpring23StoryLvRewardShowItem
