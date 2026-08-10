local var_0_0 = class("LanguageSwitchItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.statusController_ = arg_2_0.comps_:GetController("status")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddToggleListener(arg_3_0.toggle_, function(arg_4_0)
		if arg_4_0 then
			manager.notify:CallUpdateFunc(GAME_LANGUAGE_SETTING, arg_3_0.info_.language_list[arg_3_0.index_])
		end
	end)
end

function var_0_0.Init(arg_5_0)
	arg_5_0:InitUI()
	arg_5_0:AddUIListener()
end

function var_0_0.Render(arg_6_0)
	arg_6_0:RefreshData(arg_6_0.index_)
end

function var_0_0.RefreshData(arg_7_0, arg_7_1)
	local var_7_0 = AreaDifferenceCfg[GameToSDK.CURRENT_SERVER]

	if var_7_0 then
		arg_7_0.info_ = var_7_0
		arg_7_0.index_ = arg_7_1
		arg_7_0.nameText_.text = GetI18NText(var_7_0.language_in_list[arg_7_1])

		if SettingData:GetSoundSettingData().text_language == var_7_0.language_list[arg_7_1] then
			arg_7_0.statusController_:SetSelectedState("in_use")

			arg_7_0.toggle_.isOn = true
		else
			arg_7_0.statusController_:SetSelectedState("downloaded")
		end
	end
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.params_ = nil

	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
