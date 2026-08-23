local ExplorationFormationDiffTipPop = class("ExplorationFormationDiffTipPop", require("app.fairyGUI.exploration.UI_ExplorationFormationDiffTipPop"), function()
	return fgui.GComponent:create({
		resName = "ExplorationFormationDiffTipPop",
		pkgPath = "ui/exploration/exploration",
		pkgName = "exploration"
	}, ...)
end)

function ExplorationFormationDiffTipPop:ctor(arg_2_1)
	self:showAtCenter()
end

return ExplorationFormationDiffTipPop
