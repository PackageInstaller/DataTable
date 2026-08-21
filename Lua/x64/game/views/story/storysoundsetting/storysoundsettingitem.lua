local var_0_0 = class("StorySoundSettingItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.soundType_ = arg_1_2

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddToggleListener(arg_3_0.slider_, function(arg_4_0)
		arg_3_0:SetSoundValue(arg_4_0)
	end)
	arg_3_0:AddPressingByTimeListener(arg_3_0.subtractBtn_.gameObject, 3, 0.2, 0.2, function()
		if arg_3_0.subtractBtn_.interactable and arg_3_0.slider_.value > 0 then
			local var_5_0 = arg_3_0.slider_.value - 1

			arg_3_0:SetSoundValue(var_5_0)

			return true
		end

		return false
	end)
	arg_3_0:AddPressingByTimeListener(arg_3_0.addBtn_.gameObject, 3, 0.2, 0.2, function()
		if arg_3_0.addBtn_.interactable and arg_3_0.slider_.value < 100 then
			local var_6_0 = arg_3_0.slider_.value + 1

			arg_3_0:SetSoundValue(var_6_0)

			return true
		end

		return false
	end)
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0:RefreshText(arg_7_1)
	arg_7_0:Enabled(arg_7_2)
end

function var_0_0.SetSoundValue(arg_8_0, arg_8_1)
	SettingAction.ChangeSoundSetting(arg_8_0.soundType_, arg_8_1)
	arg_8_0:RefreshText(arg_8_1)
end

function var_0_0.RefreshText(arg_9_0, arg_9_1)
	arg_9_0.percentText_.text = string.format("%s%%", arg_9_1)
	arg_9_0.slider_.value = arg_9_1
end

function var_0_0.Enabled(arg_10_0, arg_10_1)
	arg_10_0.slider_.interactable = arg_10_1
	arg_10_0.subtractBtn_.interactable = arg_10_1
	arg_10_0.addBtn_.interactable = arg_10_1
end

return var_0_0
