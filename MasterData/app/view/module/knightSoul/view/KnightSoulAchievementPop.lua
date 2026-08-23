local KnightSoulAchievementPop = class("KnightSoulAchievementPop", require("app.fairyGUI.knightSoul.UI_KnightSoulAchievementPop"), function()
	return fgui.GComponent:create({
		resName = "KnightSoulAchievementPop",
		pkgPath = "ui/knightSoul/knightSoul",
		pkgName = "knightSoul"
	}, ...)
end)

function KnightSoulAchievementPop:ctor()
	self:showAtCenter()
end

return KnightSoulAchievementPop
