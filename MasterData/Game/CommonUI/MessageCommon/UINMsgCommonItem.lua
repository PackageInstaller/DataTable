local UINMsgCommonItem = class("UINMsgCommonItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")

function UINMsgCommonItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.baseItem = UINBaseItem.New()
  self.baseItem:Init(self.ui.obj_uINBaseItem)
end

function UINMsgCommonItem:InitMsgCommonItem(itemCfg, costNum, itemNum)
  self.baseItem:InitBaseItem(itemCfg, function()
  end)
  if costNum ~= nil then
    local containNum = PlayerDataCenter:GetItemCount(itemCfg.id)
    local enough = costNum <= containNum
    self.ui.tex_ExtrCount:SetIndex(enough and 0 or 2, tostring(costNum), tostring(containNum))
  else
    self.ui.tex_ExtrCount:SetIndex(1, tostring(itemNum))
  end
end

function UINMsgCommonItem:OnDelete()
  self.baseItem:Delete()
  base.OnDelete(self)
end

return UINMsgCommonItem
