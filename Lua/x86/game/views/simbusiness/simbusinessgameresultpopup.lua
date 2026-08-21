local var_0_0 = class("SimBusinessGameResultPopup", ReduxView)

SimBusinessConst = import("game.const.SimBusinessConst")

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/SummerUI_3_5/SummerUI_3_5_SimBusinessUI/SummerUI_3_5_SimBusinessResultPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.resultController = arg_4_0.controllerCollectionEx_:GetController("result")
	arg_4_0.guestInfoList = LuaList.New(handler(arg_4_0, arg_4_0.RenderGuestItem), arg_4_0.guestList_.gameObject, SimBusinessGuestInfoItem)

	arg_4_0:AddUIListener()
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0.guestInfoList:Dispose()
	var_0_0.super.Dispose(arg_5_0)
end

function var_0_0.OnEnter(arg_6_0)
	local var_6_0 = arg_6_0.params_.stage
	local var_6_1 = arg_6_0.params_.isClear

	arg_6_0.callback = arg_6_0.params_.callback
	arg_6_0.guestStatus = arg_6_0.params_.guest

	arg_6_0.resultController:SetSelectedState(var_6_1 and "succeed" or "fail")

	if var_6_1 then
		manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_enter")
		manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_dati_bingo")
	else
		manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_dati_error")
		manager.audio:PlayEffect("minigame_activity_3_3", "minigame_activity_3_3_chess_gridui_losecoin")
	end

	arg_6_0.guestInfoList:StartScroll(#arg_6_0.guestStatus)
end

function var_0_0.OnExit(arg_7_0)
	return
end

function var_0_0.OnTop(arg_8_0)
	manager.windowBar:HideBar()
end

function var_0_0.AddUIListener(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.maskBtn_, nil, function()
		JumpTools.Back()

		if arg_9_0.callback then
			arg_9_0.callback()
		end
	end)
end

function var_0_0.RenderGuestItem(arg_11_0, arg_11_1, arg_11_2)
	arg_11_2:HideIfHpBarEmpty(true)
	arg_11_2:RefreshData(arg_11_0.guestStatus[arg_11_1], arg_11_1, false, true, false)
end

return var_0_0
