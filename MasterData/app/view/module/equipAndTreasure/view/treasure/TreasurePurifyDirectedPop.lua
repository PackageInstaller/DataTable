local TreasurePurifyDirectedPop = class("TreasurePurifyDirectedPop", require("app.fairyGUI.equipAndTreasure.UI_TreasurePurifyDirectedPop"), function()
	return fgui.GComponent:create({
		resName = "TreasurePurifyDirectedPop",
		pkgPath = "ui/equipAndTreasure/equipAndTreasure",
		pkgName = "equipAndTreasure"
	}, ...)
end)

function TreasurePurifyDirectedPop:ctor()
	self:showAtCenter()
end

return TreasurePurifyDirectedPop
