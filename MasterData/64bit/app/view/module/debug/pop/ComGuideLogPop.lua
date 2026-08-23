local ComGuideLogPop = class("ComGuideLogPop", require("app.fairyGUI.debug.UI_ComGuideLogPop"), function()
	return fgui.GComponent:create({
		resName = "ComGuideLogPop",
		pkgName = "debug",
		pkgPath = "ui/debug/debug"
	})
end)

function ComGuideLogPop:ctor()
	self:showAtCenter()
end

return ComGuideLogPop
