local HandBookAchievementPop = class("HandBookAchievementPop", require("app.fairyGUI.handBook.UI_HandBookAchievementPop"), function()
	return fgui.GComponent:create({
		resName = "HandBookAchievementPop",
		pkgPath = "ui/handBook/handBook",
		pkgName = "handBook"
	})
end)

function HandBookAchievementPop:ctor()
	self:showAtCenter()

	self._curLevel = 0

	self.m_showComp:init()
end

function HandBookAchievementPop:playTouchCloseAnimAndCallBack(arg_3_1)
	self.m_bgPanel:getCloseTransition():play(function()
		arg_3_1()
	end)
end

return HandBookAchievementPop
