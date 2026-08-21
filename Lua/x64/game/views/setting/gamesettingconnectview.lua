local var_0_0 = class("GameSettingConnectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Setting/GameSettingConnectUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddToggleListener(arg_5_0.connect1Tgl_, function(arg_6_0)
		if arg_6_0 then
			arg_5_0.connectType = 0
		end
	end)
	arg_5_0:AddToggleListener(arg_5_0.connect2Tgl_, function(arg_7_0)
		if arg_7_0 then
			arg_5_0.connectType = 2
		end
	end)
	arg_5_0:AddToggleListener(arg_5_0.connect3Tgl_, function(arg_8_0)
		if arg_8_0 then
			arg_5_0.connectType = 3
		end
	end)
	arg_5_0:AddToggleListener(arg_5_0.connect4Tgl_, function(arg_9_0)
		if arg_9_0 then
			arg_5_0.connectType = 4
		end
	end)
	arg_5_0:AddToggleListener(arg_5_0.connect5Tgl_, function(arg_10_0)
		if arg_10_0 then
			arg_5_0.connectType = 1
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.yesBtn_, nil, function()
		if arg_5_0.connectType and arg_5_0.connectType ~= arg_5_0.params_.type then
			SettingAction.ChangeGameSetting("cus_full_play_controlled_type", arg_5_0.connectType)
		end

		JumpTools.Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.noBtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.Init(arg_13_0)
	arg_13_0:InitUI()
	arg_13_0:AddUIListener()
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0.connectType = arg_14_0.params_.type

	if arg_14_0.connectType == 0 then
		arg_14_0.connect1Tgl_.isOn = true
	elseif arg_14_0.connectType == 2 then
		arg_14_0.connect2Tgl_.isOn = true
	elseif arg_14_0.connectType == 3 then
		arg_14_0.connect3Tgl_.isOn = true
	elseif arg_14_0.connectType == 4 then
		arg_14_0.connect4Tgl_.isOn = true
	elseif arg_14_0.connectType == 1 then
		arg_14_0.connect5Tgl_.isOn = true
	end
end

function var_0_0.OnExit(arg_15_0)
	return
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0.params_ = nil

	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
