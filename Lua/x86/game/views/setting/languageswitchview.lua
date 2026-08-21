local var_0_0 = class("LanguageSwitchView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Setting/GameLanguageUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.listGo_, LanguageSwitchItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListenerScale(arg_5_0.yesBtn_, nil, function()
		arg_5_0:SaveData()
		JumpTools.Back()
	end)
	arg_5_0:AddBtnListenerScale(arg_5_0.noBtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.Init(arg_8_0)
	arg_8_0:InitUI()
	arg_8_0:AddUIListener()
end

function var_0_0.indexItem(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2:RefreshData(arg_9_1)
end

function var_0_0.RefreshUI(arg_10_0)
	local var_10_0 = AreaDifferenceCfg[GameToSDK.CURRENT_SERVER]

	arg_10_0.scrollHelper_:StartScroll(#var_10_0.language_in_list)

	arg_10_0.languageList = {}
end

function var_0_0.OnGameLanguageSettingChange(arg_11_0, arg_11_1)
	arg_11_0.settingData_ = arg_11_1
end

function var_0_0.SaveData(arg_12_0)
	SettingAction.ChangeSoundSetting("text_language", arg_12_0.settingData_)
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0:RefreshUI()
	arg_13_0:SetParent()
end

function var_0_0.OnExit(arg_14_0)
	return
end

function var_0_0.SetParent(arg_15_0)
	if arg_15_0.params_.needSetParent then
		arg_15_0.transform_:SetParent(manager.ui.uiStory.transform)
	else
		arg_15_0.transform_:SetParent(arg_15_0:UIParent())
	end
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0.scrollHelper_:Dispose()

	arg_16_0.params_ = nil

	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
