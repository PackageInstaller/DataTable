local var_0_0 = class("GameSettingBattlePlayView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Setting/GameSettingBattlePlayUI"
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
	arg_5_0:AddToggleListener(arg_5_0.lock1Tgl_, function(arg_6_0)
		if arg_6_0 then
			arg_5_0.battlePlayType = 2
		end
	end)
	arg_5_0:AddToggleListener(arg_5_0.lock2Tgl_, function(arg_7_0)
		if arg_7_0 then
			arg_5_0.battlePlayType = 1
		end
	end)
	arg_5_0:AddToggleListener(arg_5_0.lock3Tgl_, function(arg_8_0)
		if arg_8_0 then
			arg_5_0.battlePlayType = 0
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.yesBtn_, nil, function()
		JumpTools.Back()

		if arg_5_0.battlePlayType and arg_5_0.battlePlayType ~= arg_5_0.params_.type then
			SettingAction.ChangeGameSetting("battle_play_type", arg_5_0.battlePlayType)
		end

		OperationRecorder.Record("setting", "setting_battle_play")
	end)
	arg_5_0:AddBtnListener(arg_5_0.noBtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.Init(arg_11_0)
	arg_11_0:InitUI()
	arg_11_0:AddUIListener()
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.battlePlayType = arg_12_0.params_.type

	if arg_12_0.battlePlayType == 2 then
		arg_12_0.lock1Tgl_.isOn = true
	elseif arg_12_0.battlePlayType == 1 then
		arg_12_0.lock2Tgl_.isOn = true
	elseif arg_12_0.battlePlayType == 0 then
		arg_12_0.lock3Tgl_.isOn = true
	end

	arg_12_0.text_1.text = GetTips("ADMIN_CHIP_ACT_QUALITY1")
	arg_12_0.text_2.text = GetTips("ADMIN_CHIP_ACT_QUALITY_TIPS1")
	arg_12_0.text_3.text = GetTips("ADMIN_CHIP_ACT_QUALITY2")
	arg_12_0.text_4.text = GetTips("ADMIN_CHIP_ACT_QUALITY_TIPS2")
	arg_12_0.text_5.text = GetTips("ADMIN_CHIP_ACT_QUALITY3")
	arg_12_0.text_6.text = GetTips("ADMIN_CHIP_ACT_QUALITY_TIPS3")
	arg_12_0.titleText_.text = GetTips("ADMIN_CHIP_ACT_QUALITY_TITLE")
end

function var_0_0.OnExit(arg_13_0)
	return
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0.params_ = nil

	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
