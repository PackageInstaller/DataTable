local UINSpring23StoryCharExtraItem = class("UINSpring23StoryCharExtraItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")

function UINSpring23StoryCharExtraItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._itemPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.uINBaseItemWithReceived)
  self.ui.uINBaseItemWithReceived:SetActive(false)
  self._finishColor = self.ui.img_LevelBg.color
  self._finishTexColor = self.ui.tex_Level.color
end

function UINSpring23StoryCharExtraItem:InitSpring23StoryCharExtraItem(interactCfg, index, flag)
  self.ui.obj_Exp:SetActive(true)
  self.ui.tex_Level.text = tostring(index)
  self.ui.img_LevelBg.color = flag and self._finishColor or self.ui.color_lvBg
  self.ui.tex_Level.color = flag and self._finishTexColor or self.ui.color_LvTex
  self.ui.img_ExpProgress.gameObject:SetActive(flag)
  self._itemPool:HideAll()
  for i, itemId in ipairs(interactCfg.reward_ids) do
    local itemCfg = ConfigData.item[itemId]
    local itemCount = interactCfg.reward_nums[i]
    local item = self._itemPool:GetOne()
    item:InitItemWithCount(itemCfg, itemCount, nil, flag)
  end
end

function UINSpring23StoryCharExtraItem:HideSpring23StoryCharExtraItemBar()
  self.ui.obj_Exp:SetActive(false)
end

return UINSpring23StoryCharExtraItem
