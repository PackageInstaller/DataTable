local var_0_0 = class("CooperationSearchRoomView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Formation/Cooperation/CooperationSearchRoomUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0.inputFieldNick_.textComponent:RegisterDirtyVerticesCallback(function()
		local var_5_0 = string.match(arg_4_0.inputFieldNick_.text, "%d+")

		if var_5_0 and #var_5_0 > 19 then
			var_5_0 = string.sub(var_5_0, 1, 19)
		end

		arg_4_0.inputFieldNick_.text = var_5_0
		arg_4_0.inputFieldNick_.textComponent.text = var_5_0
	end)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.buttonOk_, nil, function()
		local var_7_0 = arg_6_0.inputFieldNick_.text

		if var_7_0 == nil then
			ShowTips("ACTIVITY_STRONGHOLD_ROOM_NUM_TIPS")

			return
		end

		CooperationAction.JoinRoom(var_7_0, nil, CooperationConst.JOIN_ROOM_SOURCE.ROOM_ID)
	end)
	arg_6_0:AddBtnListener(arg_6_0.buttonClose_, nil, function()
		arg_6_0:Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.buttonCancel_, nil, function()
		arg_6_0:Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.btnPut_, nil, function()
		arg_6_0.inputFieldNick_.text = UnityEngine.GUIUtility.systemCopyBuffer
	end)
end

function var_0_0.OnTop(arg_11_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_12_0)
	return
end

function var_0_0.OnExit(arg_13_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_14_0)
	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
