local PopItemNormalView = class("PopItemNormalView", import("game.views.pop.PopItemView"))
local ItemTools = import("game.tools.ItemTools")

function PopItemNormalView:CustomInitUI()
	self.super.CustomInitUI(self)
end

return PopItemNormalView
