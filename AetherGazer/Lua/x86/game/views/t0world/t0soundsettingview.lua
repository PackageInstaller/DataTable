local var_0_0 = class("T0SoundSettingView", StorySoundSettingView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Story/StorySoundSettingUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiStory.transform
end

function var_0_0.Init(arg_3_0)
	var_0_0.super.Init(arg_3_0)

	arg_3_0.options = {}

	for iter_3_0 = 1, arg_3_0.settingOptionRoot_.childCount do
		local var_3_0 = arg_3_0.settingOptionRoot_:GetChild(iter_3_0 - 1)

		arg_3_0.options[iter_3_0] = {
			obj = var_3_0.gameObject
		}
	end
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.closeBtn_, nil, function()
		arg_4_0:Back()
	end)
end

function var_0_0.RefreshUI(arg_6_0)
	arg_6_0.soundMusicView_:SetData(arg_6_0.settingData_.music, arg_6_0.settingData_.sound_open == 1)
	arg_6_0.soundEffectView_:SetData(arg_6_0.settingData_.effect, arg_6_0.settingData_.sound_open == 1)
	arg_6_0.soundVoiceView_:SetData(arg_6_0.settingData_.voice, arg_6_0.settingData_.sound_open == 1)
	arg_6_0.soundSwitchView_:SetData(false)
end

function var_0_0.OnEnter(arg_7_0)
	var_0_0.super.OnEnter(arg_7_0)

	for iter_7_0 = 4, #arg_7_0.options do
		SetActive(arg_7_0.options[iter_7_0].obj, false)
	end
end

return var_0_0
