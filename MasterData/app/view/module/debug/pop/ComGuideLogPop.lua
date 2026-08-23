local ComGuideLogPop = class("ComGuideLogPop", require("app.fairyGUI.debug.UI_ComGuideLogPop"), function()
	return fgui.GComponent:create({
		resName = "ComGuideLogPop",
		pkgPath = "ui/debug/debug",
		pkgName = "debug"
	})
end)

function ComGuideLogPop:ctor()
	self:showAtCenter()
end

return ComGuideLogPop
