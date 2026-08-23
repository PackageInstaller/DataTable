local TreasurePurifyDirectedPop = class("TreasurePurifyDirectedPop", require("app.fairyGUI.equipAndTreasure.UI_TreasurePurifyDirectedPop"), function()
	return fgui.GComponent:create({
		resName = "TreasurePurifyDirectedPop",
		pkgName = "equipAndTreasure",
		pkgPath = "ui/equipAndTreasure/equipAndTreasure"
	}, ...)
end)

function TreasurePurifyDirectedPop:ctor()
	self:showAtCenter()
end

return TreasurePurifyDirectedPop
