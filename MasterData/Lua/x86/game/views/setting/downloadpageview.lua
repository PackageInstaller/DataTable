local DownloadPageView = class("DownloadPageView", ReduxView)

function DownloadPageView:UIName()
	return "Widget/System/Setting/SettingDownUI"
end

function DownloadPageView:UIParent()
	return manager.ui.uiPop.transform
end

function DownloadPageView:OnCtor()
	return
end

function DownloadPageView:InitUI()
	self:BindCfgUI()

	self.downloadStateController_ = self.controllerEx_:GetController("default0")
end

function DownloadPageView:AddUIListener()
	self:AddBtnListener(self.cancelBtn_, nil, function()
		if self.canceling then
			return
		end

		self.canceling = true

		VoicePackageManager.Instance:DownloadCancel()
	end)
	self:AddBtnListener(self.okBtn_, nil, function()
		CloseDownLoadPage()
	end)
end

function DownloadPageView:Init()
	self:InitUI()
	self:AddUIListener()
end

function DownloadPageView:SetTitle(arg_9_1)
	self.titleText_.text = GetI18NText(arg_9_1)
end

function DownloadPageView:SetProgress(arg_10_1, arg_10_2)
	self.progressSli_.value = arg_10_1
	self.progressText_.text = arg_10_2
end

function DownloadPageView:OnEnter()
	if self.params_.title then
		self:SetTitle(self.params_.title)
	end

	self:SetParent()
	self:SetProgress(0, GetTips("DOWNLOAD_START"))
	self.downloadStateController_:SetSelectedIndex(1)

	self.canceling = false

	VoicePackageManager.Instance:StartDownLoadPackage(self.params_.abbr)

	if self.updateTimer ~= nil then
		self.updateTimer:Stop()

		self.updateTimer = nil
	end

	if self.updateTimer == nil then
		self.updateTimer = Timer.New(function()
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

				self:SetTitle(GetTips("DOWNLOAD_START"))

				if var_12_3 ~= "" then
					local var_12_4 = string.split(var_12_3, ":")

					self:SetProgress(tonumber(var_12_4[2]) / tonumber(var_12_4[3]), var_12_4[4])
				end
			end

			if VoicePackageManager.Instance:IsSucceed(var_12_2) then
				if self.updateTimer ~= nil then
					self.updateTimer:Stop()

					self.updateTimer = nil
				end

				self.downloadStateController_:SetSelectedIndex(0)
				self:SetProgress(1, GetTips("DOWNLOAD_SUCCESS"))
				VoicePackageManager.Instance:InsertDownloadedPackage(self.params_.abbr)
				VoicePackageManager.Instance:DownloadShutdown()
				manager.assetPend:UpdateAssetPendSize()
				manager.notify:CallUpdateFunc(LANGUAGE_PACKAGE_DOWNLOADED, self.params_.abbr)
			end

			if VoicePackageManager.Instance:IsFailed(var_12_2) then
				self:SetTitle(GetTips("DOWNLOAD_FAIL"))
				self:SetProgress(0, GetTips("DOWNLOAD_FAIL"))
				Debug.Log("Language DownLoad Fail:" .. VoicePackageManager.Instance:GetDownloadInfo(var_12_2))
			end

			if VoicePackageManager.Instance:IsCanceling(var_12_2) then
				local var_12_5 = VoicePackageManager.Instance:GetDownloadInfo(var_12_2)

				self:SetProgress(0, GetTips("DOWNLOAD_CANCEL"))
			end

			if VoicePackageManager.Instance:IsCanceled(var_12_2) then
				if self.updateTimer ~= nil then
					self.updateTimer:Stop()

					self.updateTimer = nil
				end

				VoicePackageManager.Instance:DownloadShutdown()
				manager.notify:CallUpdateFunc(LANGUAGE_PACKAGE_CANCEL)
				CloseDownLoadPage()
			end
		end, 0.1, -1)
	end

	self.updateTimer:Start()
end

function DownloadPageView:OnExit()
	if self.updateTimer ~= nil then
		self.updateTimer:Stop()

		self.updateTimer = nil
	end
end

function DownloadPageView:SetParent()
	if self.params_.needSetParent then
		self.transform_:SetParent(manager.ui.uiStory.transform)
	else
		self.transform_:SetParent(self:UIParent())
	end
end

function DownloadPageView:Dispose()
	self.params_ = nil

	DownloadPageView.super.Dispose(self)
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
			Debug.Log("Language DownLoad Fail:" .. VoicePackageManager.Instance:GetDownloadInfo(var_17_0))
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

return DownloadPageView
