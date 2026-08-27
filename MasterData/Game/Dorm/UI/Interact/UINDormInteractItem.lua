local UINDormInteractItem = class("UINDormInteractItem", UIBaseNode)
local DormEnum = require("Game.Dorm.DormEnum")

function UINDormInteractItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Interact, self, self.OnInteractBtnClick)
end

function UINDormInteractItem:InitInteractActionItem(interactAction, iconAtlas)
  self.interactAction = interactAction
  local desc, spriteName, title, hasNew = interactAction:GetActionData()
  local actionEnable = interactAction:GetInteractActionEnable()
  self.ui.tex_Interact.text = desc
  self.ui.tex_State.text = title
  self.ui.img_Icon.sprite = AtlasUtil.GetResldSprite(iconAtlas, spriteName)
  self.ui.canvsGroup.alpha = actionEnable and 1 or 0.7
  local buttomCol = hasNew and self.ui.col_HasNew or Color.white
  self.ui.img_Buttom.color = buttomCol
  self.ui.tex_IsNew.enabled = hasNew
  if hasNew then
    self.transform:SetAsFirstSibling()
  end
end

function UINDormInteractItem:OnInteractBtnClick()
  if self.interactAction ~= nil then
    self.interactAction:InvokeInteractAction()
  end
end

function UINDormInteractItem:OnDelete()
end

return UINDormInteractItem
