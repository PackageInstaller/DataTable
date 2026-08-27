local UINFairyRightConsumeItem = class("UINFairyRightConsumeItem", UIBaseNode)
local base = UIBaseNode

function UINFairyRightConsumeItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_cost, self, self.OnClickBtnCost)
end

function UINFairyRightConsumeItem:InitFairyRightConsumeItem(itemId, consumeNum, clickFunc)
  self.itemId = itemId
  self.consumeNum = consumeNum
  self.clickFunc = clickFunc
  self.ui.img_icon.sprite = CRH:GetSpriteByItemId(itemId, true)
  local nowHaveNum = PlayerDataCenter:GetItemCount(itemId)
  if consumeNum <= nowHaveNum then
    self.ui.tex_LevelUpExp:SetIndex(0, tostring(nowHaveNum), tostring(consumeNum))
  else
    self.ui.tex_LevelUpExp:SetIndex(1, tostring(nowHaveNum), tostring(consumeNum))
  end
end

function UINFairyRightConsumeItem:OnClickBtnCost()
  if self.clickFunc then
    self.clickFunc(self.itemId)
  end
end

function UINFairyRightConsumeItem:OnDelete()
end

return UINFairyRightConsumeItem
