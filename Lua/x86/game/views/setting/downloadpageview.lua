local var_0_0 = class("DownloadPageView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Setting/SettingDownUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.downloadStateController_ = arg_4_0.controllerEx_:GetController("default0")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.cancelBtn_, nil, function()
		if arg_5_0.canceling then
			return
		end

		arg_5_0.canceling = true

		VoicePackageManager.Instance:DownloadCancel()
	end)
	arg_5_0:AddBtnListener(arg_5_0.okBtn_, nil, function()
		CloseDownLoadPage()
	end)
end

function var_0_0.Init(arg_8_0)
	arg_8_0:InitUI()
	arg_8_0:AddUIListener()
end

function var_0_0.SetTitle(arg_9_0, arg_9_1)
	arg_9_0.titleText_.text = GetI18NText(arg_9_1)
end

function var_0_0.SetProgress(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.progressSli_.value = arg_10_1
	arg_10_0.progressText_.text = arg_10_2
end

function var_0_0.OnEnter(arg_11_0)
	if arg_11_0.params_.title then
		arg_11_0:SetTitle(arg_11_0.params_.title)
	end

	arg_11_0:SetParent()
	arg_11_0:SetProgress(0, GetTips("DOWNLOAD_START"))
	arg_11_0.downloadStateController_:SetSelectedIndex(1)

	arg_11_0.canceling = false

	VoicePackageManager.Instance:StartDownLoadPackage(arg_11_0.params_.abbr)

	if arg_11_0.updateTimer ~= nil then
		arg_11_0.updateTimer:Stop()

		arg_11_0.updateTimer = nil
	end

	if arg_11_0.updateTimer == nil then
		arg_11_0.updateTimer = Timer.New(function()
			local var_12_0 = GameObject.Find("UICamera_DontDestroy/Canvas/UIMessage/MessageBox_UI(Clone)")

			if not isNil(var_12_0) then
				local var_12_1 = GameObject.Find("UICamera_DontDestroy/Canvas/UIMessage/Canvas")

				if not isNil(var_12_1) then
					var_12_0.transform:SetParent(var_12_1.transform, true)
				end
			end

			local var_12_2 = VoicePackageManager.Instance:UpdateDownloading()

			if VoicePackageManager.Instance:IsDownloading(var_12_2) then
				local var_12_3 = VoicePackageManager.Instance:GetDownloadInfo(var_12_2)

				arg_11_0:SetTitle(GetTips("DOWNLOAD_START"))

				if var_12_3 ~= "" then
					local var_12_4 = string.split(var_12_3, ":")

					arg_11_0:SetProgress(tonumber(var_12_4[2]) / tonumber(var_12_4[3]), var_12_4[4])
				end
			end

			if VoicePackageManager.Instance:IsSucceed(var_12_2) then
				if arg_11_0.updateTimer ~= nil then
					arg_11_0.updateTimer:Stop()

					arg_11_0.updateTimer = nil
				end

				arg_11_0.downloadStateController_:SetSelectedIndex(0)
				arg_11_0:SetProgress(1, GetTips("DOWNLOAD_SUCCESS"))
				VoicePackageManager.Instance:InsertDownloadedPackage(arg_11_0.params_.abbr)
				VoicePackageManager.Instance:DownloadShutdown()
				manager.assetPend:UpdateAssetPendSize()
				manager.notify:CallUpdateFunc(LANGUAGE_PACKAGE_DOWNLOADED, arg_11_0.params_.abbr)
			end

			if VoicePackageManager.Instance:IsFailed(var_12_2) then
				local var_12_5 = VoicePackageManager.Instance:GetDownloadInfo(var_12_2)

				arg_11_0:SetTitle(GetTips("DOWNLOAD_FAIL"))
				arg_11_0:SetProgress(0, GetTips("DOWNLOAD_FAIL"))
				Debug.Log("Language DownLoad Fail:" .. var_12_5)
			end

			if VoicePackageManager.Instance:IsCanceling(var_12_2) then
				local var_12_6 = VoicePackageManager.Instance:GetDownloadInfo(var_12_2)

				arg_11_0:SetProgress(0, GetTips("DOWNLOAD_CANCEL"))
			end

			if VoicePackageManager.Instance:IsCanceled(var_12_2) then
				if arg_11_0.updateTimer ~= nil then
					arg_11_0.updateTimer:Stop()

					arg_11_0.updateTimer = nil
				end

				VoicePackageManager.Instance:DownloadShutdown()
				manager.notify:CallUpdateFunc(LANGUAGE_PACKAGE_CANCEL)
				CloseDownLoadPage()
			end
		end, 0.1, -1)
	end

	arg_11_0.updateTimer:Start()
end

function var_0_0.OnExit(arg_13_0)
	if arg_13_0.updateTimer ~= nil then
		arg_13_0.updateTimer:Stop()

		arg_13_0.updateTimer = nil
	end
end

function var_0_0.SetParent(arg_14_0)
	if arg_14_0.params_.needSetParent then
		arg_14_0.transform_:SetParent(manager.ui.uiStory.transform)
	else
		arg_14_0.transform_:SetParent(arg_14_0:UIParent())
	end
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0.params_ = nil

	var_0_0.super.Dispose(arg_15_0)
end

local var_0_1

function VoicePackageMissingFix_HotfixVersion(arg_16_0)
	VoicePackageManager.Instance:StartDownLoadPackage(arg_16_0.affix)

	var_0_1 = Timer.New(function()
		local var_17_0 = VoicePackageManager.Instance:UpdateDownloading()

		if VoicePackageManager.Instance:IsSucceed(var_17_0) then
			if var_0_1 ~= nil then
				var_0_1:Stop()

				var_0_1 = nil
			end

			VoicePackageManager.Instance:InsertDownloadedPackage(arg_16_0.affix)
			VoicePackageManager.Instance:DownloadShutdown()
			manager.assetPend:UpdateAssetPendSize()
			SettingAction.ChangeSoundSetting("voice_language", arg_16_0.id)
		end

		if VoicePackageManager.Instance:IsFailed(var_17_0) then
			local var_17_1 = VoicePackageManager.Instance:GetDownloadInfo(var_17_0)

			Debug.Log("Language DownLoad Fail:" .. var_17_1)
		end

		if VoicePackageManager.Instance:IsCanceled(var_17_0) then
			if var_0_1 ~= nil then
				var_0_1:Stop()

				var_0_1 = nil
			end

			VoicePackageManager.Instance:DownloadShutdown()
		end
	end, 0.1, -1)

	var_0_1:Start()
end

return var_0_0
