local var_0_0 = class("LanguagePackageView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Setting/LanguagePackageUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.listGo_, LanguagePackageItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListenerScale(arg_5_0.yesBtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.Init(arg_7_0)
	arg_7_0:InitUI()
	arg_7_0:AddUIListener()
end

function var_0_0.InitTextLanguageOption(arg_8_0)
	if #AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].language_in_list < 2 then
		arg_8_0.languageBtn_.enabled = false

		SetActive(arg_8_0.languageIconGo_, false)
	else
		arg_8_0.languageBtn_.enabled = true

		SetActive(arg_8_0.languageIconGo_, true)
	end
end

function var_0_0.indexItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].voice_list[arg_9_1]

	arg_9_2:RefreshData(VoiceLanguageCfg[var_9_0], arg_9_0.params_.needSetParent)
end

function var_0_0.RefreshUI(arg_10_0)
	local var_10_0 = AreaDifferenceCfg[GameToSDK.CURRENT_SERVER]
	local var_10_1 = #var_10_0.voice_list

	arg_10_0.scrollHelper_:StartScroll(var_10_1)

	local var_10_2 = 0

	for iter_10_0 = 1, var_10_1 do
		local var_10_3 = var_10_0.voice_list[iter_10_0]
		local var_10_4 = VoiceLanguageCfg[var_10_3]

		if VoicePackageManager.Instance:IsHavePackage(var_10_4.affix) then
			var_10_2 = var_10_2 + AssetPendDownLoadManager.instance:GetVoicePackageSize(var_10_4.affix)
		end
	end

	arg_10_0.numberText_.text = string.format("%.2fMB", var_10_2)
end

function var_0_0.OnDownloaded(arg_11_0, arg_11_1)
	arg_11_0:RefreshUI()
end

function var_0_0.OnLanguagePackageDeleted(arg_12_0)
	arg_12_0:RefreshUI()
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

function var_0_0.OnAssetPendDownloadEnd(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_2 then
		arg_17_0:RefreshUI()
	end
end

return var_0_0
