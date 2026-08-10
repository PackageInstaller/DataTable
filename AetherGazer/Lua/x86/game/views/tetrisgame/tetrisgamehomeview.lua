ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("TetrisGameHomeView", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return "Widget/Version/Alone_TetrisGameUI/TetrisGameEntranceUI"
end

function var_0_0.Init(arg_2_0)
	var_0_0.super.Init(arg_2_0)

	arg_2_0.btnController_ = arg_2_0.btnControllerEx_:GetController("statelock01")
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btnstartBtn_, nil, function()
		JumpTools.OpenPageByJump("/tetrisGameMainView")
	end)
	arg_3_0:AddBtnListener(nil, arg_3_0.infobtn, function()
		local var_5_0 = "TETRIS_GAME_HOME_DESC"

		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips(var_5_0),
			key = var_5_0
		})
	end)
end

function var_0_0.RefreshAcvanceStatus(arg_6_0, arg_6_1)
	if arg_6_1 then
		arg_6_0.btnController_:SetSelectedState("normal01")
	else
		arg_6_0.btnController_:SetSelectedState("lock01")
	end
end

function var_0_0.OnEnter(arg_7_0)
	var_0_0.super.OnEnter(arg_7_0)
	manager.redPoint:bindUIandKey(arg_7_0.btnstartBtn_.transform, string.format("%s%s", ActivityTools.GetRedPointKey(arg_7_0.activityID_), arg_7_0.activityID_))
end

function var_0_0.OnExit(arg_8_0)
	var_0_0.super.OnExit(arg_8_0)
	manager.redPoint:unbindUIandKey(arg_8_0.btnstartBtn_.transform, string.format("%s%s", ActivityTools.GetRedPointKey(arg_8_0.activityID_), arg_8_0.activityID_))
end

return var_0_0
