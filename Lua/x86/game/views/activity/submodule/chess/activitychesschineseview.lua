ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("ActivityChessChineseView", ActivityMainBasePanel)
local var_0_1 = "WARCHESS_INFO"

function var_0_0.GetUIName(arg_1_0)
	return "UI/VersionUI/XuHeng1stUI/XH1stWarChessUI/XH1stWarChessUI"
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.chessBtn_, nil, function()
		JumpTools.GoToSystem("/warChessStage", {
			firstChapter = 4040501,
			chapterClientID = 404
		}, ViewConst.SYSTEM_ID.WARCHESS)
	end)
end

return var_0_0
