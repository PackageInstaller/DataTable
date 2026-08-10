ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("WaterPipeHomeView", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return "Widget/Version/BaichaoUI_3_9/BaichaoUI_3_9_WaterPipeUI/WaterPipeEntranceUI"
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.btnstartBtn_, nil, function()
		if arg_2_0:CheckAdvanceOpenTime() then
			return
		end

		JumpTools.OpenPageByJump("/waterPipeSelectView")
	end)
	arg_2_0:AddBtnListener(arg_2_0.btnlockBtn_, nil, function()
		local var_4_0, var_4_1 = arg_2_0:CheckAdvanceOpenTime()

		if var_4_0 then
			ShowTips(var_4_1)
		end
	end)
	arg_2_0:AddBtnListener(nil, arg_2_0.descBtn_, function()
		local var_5_0 = "ACTIVITY_WATER_PIPE_GAME_TIP"

		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips(var_5_0),
			key = var_5_0
		})
	end)
end

function var_0_0.Init(arg_6_0)
	var_0_0.super.Init(arg_6_0)

	arg_6_0.openController_ = arg_6_0.controller_:GetController("isOpen")
end

function var_0_0.OnEnter(arg_7_0)
	var_0_0.super.OnEnter(arg_7_0)

	local var_7_0 = ActivityTools.GetRedPointKey(WaterPipeData:GetMainActivityID()) .. WaterPipeData:GetMainActivityID()
	local var_7_1 = manager.redPoint:getTipBoolean(var_7_0)

	manager.redPoint:setRedPoint({
		display = arg_7_0.btnstartBtn_.transform
	}, var_7_1, RedPointStyle.NORMAL)
end

function var_0_0.OnExit(arg_8_0)
	var_0_0.super.OnExit(arg_8_0)
end

function var_0_0.RefreshAcvanceStatus(arg_9_0, arg_9_1)
	arg_9_0.openController_:SetSelectedState(arg_9_1 and "open" or "preview")
end

function var_0_0.isHasLeftTimeDes(arg_10_0)
	return true
end

return var_0_0
