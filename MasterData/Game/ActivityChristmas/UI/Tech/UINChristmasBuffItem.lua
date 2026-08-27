local UINActSum22BuffItem = require("Game.ActivitySummer.Year22.Tech.Main.UINActSum22BuffItem")
local UINChristmasBuffItem = class("UINChristmasBuffItem", UINActSum22BuffItem)
local base = UINActSum22BuffItem

function UINChristmasBuffItem:SetBuffItemNew(flag)
  self.ui.obj_New:SetActive(flag)
end

return UINChristmasBuffItem
