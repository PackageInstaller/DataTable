ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local ActivityChessChineseView = class("ActivityChessChineseView", ActivityMainBasePanel)

function ActivityChessChineseView:GetUIName()
	return "UI/VersionUI/XuHeng1stUI/XH1stWarChessUI/XH1stWarChessUI"
end

function ActivityChessChineseView:AddListeners()
	self:AddBtnListener(self.chessBtn_, nil, function()
		JumpTools.GoToSystem("/warChessStage", {
			firstChapter = 4040501,
			chapterClientID = 404
		}, ViewConst.SYSTEM_ID.WARCHESS)
	end)
end

return ActivityChessChineseView
