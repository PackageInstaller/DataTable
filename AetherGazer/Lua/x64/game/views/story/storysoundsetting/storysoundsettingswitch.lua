local var_0_0 = class("StorySoundSettingSwitch", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.soundType_ = arg_1_2
	arg_1_0.switchController_ = arg_1_0.conEx_:GetController("select")
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		arg_3_0.isEnabled_ = not arg_3_0.isEnabled_

		SettingAction.ChangeSoundSetting(arg_3_0.soundType_, arg_3_0.isEnabled_ == true and 1 or 0)
		arg_3_0:RefreshUI()

		if arg_3_0.soundType_ == "sound_open" then
			manager.notify:Invoke(SOUND_SETTING_SWICH)
		end
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.isEnabled_ = arg_5_1

	arg_5_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_6_0)
	if arg_6_0.isEnabled_ then
		arg_6_0.switchController_:SetSelectedState("on")
	else
		arg_6_0.switchController_:SetSelectedState("off")
	end
end

return var_0_0
