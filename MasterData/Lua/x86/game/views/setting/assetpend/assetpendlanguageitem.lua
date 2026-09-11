LoopScrollViewBaseItem = import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")

local AssetPendLanguageItem = class("AssetPendLanguageItem", LoopScrollViewBaseItem)

function AssetPendLanguageItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:Init()
	self:AddUIListener()
end

function AssetPendLanguageItem:Dispose()
	AssetPendLanguageItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

function AssetPendLanguageItem:Init()
	self:BindCfgUI()

	self.stateController_ = self.m_controller:GetController("state")
	self.sizeController_ = self.m_controller:GetController("size")
	self.cancelController_ = self.m_controller:GetController("cancelbtn")
	self.deleteSelectController_ = self.m_controller:GetController("batch")

	local var_3_0 = self.m_controller:GetController("text")

	if var_3_0 then
		var_3_0:SetSelectedState("language")
	end
end

function AssetPendLanguageItem:AddUIListener()
	self:AddBtnListener(self.m_download, nil, function()
		if manager.assetPend:IsDownloadingAssetPend() then
			ShowTips(GetTips("ASSET_PEND_FORBID_DOWNLOAD_VOICE_PAK"))

			return
		end

		manager.assetPend:StartDownLoadLanguage(self.abbr_)
	end)
	self:AddBtnListener(self.m_restoreBtn, nil, function()
		manager.assetPend:StartDownLoadLanguage(self.abbr_)
	end)
	self:AddBtnListener(self.m_pauseBtn, nil, function()
		manager.assetPend:CancelDownloadLanguage(self.abbr_)
	end)
	self:AddBtnListener(self.m_removeBtn, nil, function()
		manager.assetPend:CancelDownloadLanguage(self.abbr_)
	end)
	self:AddBtnListener(self.m_deleteSelectBtn, nil, function()
		if AssetPendData:GetDeleteFlag() then
			if AssetPendTools.IsSelectDeleteLanguage(self.abbr_) then
				AssetPendData:RemoveDeleteLanguage(self.abbr_)
			else
				AssetPendData:AddDeleteLanguage(self.abbr_)
			end
		elseif SettingData:GetSoundSettingData().voice_language ~= self.id_ then
			SettingAction.ChangeSoundSetting("voice_language", self.id_)
		end
	end)
end

function AssetPendLanguageItem:SetData(arg_10_1, arg_10_2)
	self.id_ = arg_10_1
	self.abbr_ = VoiceLanguageCfg[self.id_].affix
	self.index_ = arg_10_2

	self:Show(true)
	self:RefreshUI()
end

function AssetPendLanguageItem:RefreshUI()
	local var_11_0 = self.abbr_

	self.langText_.text = VoiceLanguageCfg[self.id_].name
	self.m_size.text = string.format("%.1fMB", manager.assetPend:GetLanguageTotalSize(var_11_0))

	local var_11_1 = manager.assetPend:GetLanguageDownloadState(var_11_0)
	local var_11_2 = SettingData:GetSoundSettingData().voice_language == self.id_

	if AssetPendData:GetDeleteFlag() == false then
		self.deleteSelectController_:SetSelectedState("null")

		if AssetPendDownloadState.DOWNLOAD_SUCCESS == var_11_1 then
			if var_11_2 then
				self.deleteSelectController_:SetSelectedState("currenticon")
			else
				self.deleteSelectController_:SetSelectedState("unselect")
			end

			self.stateController_:SetSelectedState("null")
			self.sizeController_:SetSelectedState("state3")
			self.cancelController_:SetSelectedState("off")
		elseif AssetPendDownloadState.DOWNLOADING == var_11_1 then
			self.stateController_:SetSelectedState("downloading")
			self.sizeController_:SetSelectedState("state1")
			self.cancelController_:SetSelectedState("on")

			self.m_speed.font = manager.assetPend:IsLanguageVerifying() and self.m_des.font or self.m_size.font
			self.m_speed.text = manager.assetPend:GetLanguageSpeedStr()

			local var_11_3 = manager.assetPend:GetLaunguageDownloadedSize(var_11_0)
			local var_11_4 = manager.assetPend:GetLanguageTotalSize(var_11_0)

			self.m_processLab.text = string.format("%.1fMB/%.1fMB", var_11_3, var_11_4)
			self.m_processFill2.text = string.format("%.1f%%", var_11_3 / var_11_4 * 100)
		elseif AssetPendDownloadState.DOWNLOAD_PAUSE == var_11_1 then
			self.stateController_:SetSelectedState("downloaded")
			self.sizeController_:SetSelectedState("state2")
			self.cancelController_:SetSelectedState("on")

			local var_11_5 = manager.assetPend:GetLaunguageDownloadedSize(var_11_0)
			local var_11_6 = manager.assetPend:GetLanguageTotalSize(var_11_0)

			self.m_processLab.text = string.format("%.1fMB/%.1fMB", var_11_5, var_11_6)
			self.m_processFill.text = string.format("%.1f%%", var_11_5 / var_11_6 * 100)
		elseif AssetPendDownloadState.DOWNLOAD_QUEUE == var_11_1 then
			self.stateController_:SetSelectedState("downloaded")
			self.sizeController_:SetSelectedState("state4")
			self.cancelController_:SetSelectedState("on")

			self.m_processFill.text = "0%"
		else
			self.stateController_:SetSelectedState("download")
			self.sizeController_:SetSelectedState("state3")
			self.cancelController_:SetSelectedState("off")
		end
	else
		self.stateController_:SetSelectedState("null")
		self.sizeController_:SetSelectedState("state3")
		self.cancelController_:SetSelectedState("off")

		if var_11_2 then
			self.deleteSelectController_:SetSelectedState("current")
		elseif AssetPendDownloadState.DOWNLOAD_SUCCESS == var_11_1 then
			if AssetPendTools.IsSelectDeleteLanguage(var_11_0) then
				self.deleteSelectController_:SetSelectedState("select")
			else
				self.deleteSelectController_:SetSelectedState("unselect")
			end
		else
			self.deleteSelectController_:SetSelectedState("lock")
		end
	end
end

return AssetPendLanguageItem
