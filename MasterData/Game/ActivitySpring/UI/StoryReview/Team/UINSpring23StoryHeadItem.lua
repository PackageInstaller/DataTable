local UINSpring23StoryHeadItem = class("UINSpring23StoryHeadItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")

function UINSpring23StoryHeadItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Check, self, self.OnClickCheck)
  self._itemPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.uINBaseItemWithReceived)
end

function UINSpring23StoryHeadItem:InitUINSpring23StoryTeamLiveSuccess(heroId, level, headId, clickCallback)
  self.heroId = heroId
  self.clickCallback = clickCallback
  self.ui.Tex_Lvl.text = "LV." .. tostring(level)
  self.ui.Img_HeroPic.sprite = CRH:GetSpriteByItemId(headId)
end

function UINSpring23StoryHeadItem:OnClickCheck()
  if self.clickCallback then
    self.clickCallback(self.heroId)
  end
end

function UINSpring23StoryHeadItem:OnClickBtnBack()
  self:Hide()
end

function UINSpring23StoryHeadItem:OnDelete()
  base.OnDelete(self)
end

return UINSpring23StoryHeadItem
