LoopScrollViewBaseItem = import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")

local var_0_0 = class("AssetPendLanguageItem", LoopScrollViewBaseItem)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
	arg_1_0:AddUIListener()
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
	Object.Destroy(arg_2_0.gameObject_)

	arg_2_0.gameObject_ = nil
	arg_2_0.transform_ = nil
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateController_ = arg_3_0.m_controller:GetController("state")
	arg_3_0.sizeController_ = arg_3_0.m_controller:GetController("size")
	arg_3_0.cancelController_ = arg_3_0.m_controller:GetController("cancelbtn")
	arg_3_0.deleteSelectController_ = arg_3_0.m_controller:GetController("batch")

	local var_3_0 = arg_3_0.m_controller:GetController("text")

	if var_3_0 then
		var_3_0:SetSelectedState("language")
	end
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.m_download, nil, function()
		if manager.assetPend:IsDownloadingAssetPend() then
			ShowTips(GetTips("ASSET_PEND_FORBID_DOWNLOAD_VOICE_PAK"))

			return
		end

		manager.assetPend:StartDownLoadLanguage(arg_4_0.abbr_)
	end)
	arg_4_0:AddBtnListener(arg_4_0.m_restoreBtn, nil, function()
		manager.assetPend:StartDownLoadLanguage(arg_4_0.abbr_)
	end)
	arg_4_0:AddBtnListener(arg_4_0.m_pauseBtn, nil, function()
		manager.assetPend:CancelDownloadLanguage(arg_4_0.abbr_)
	end)
	arg_4_0:AddBtnListener(arg_4_0.m_removeBtn, nil, function()
		manager.assetPend:CancelDownloadLanguage(arg_4_0.abbr_)
	end)
	arg_4_0:AddBtnListener(arg_4_0.m_deleteSelectBtn, nil, function()
		local var_9_0 = arg_4_0.abbr_

		if AssetPendData:GetDeleteFlag() then
			if AssetPendTools.IsSelectDeleteLanguage(var_9_0) then
				AssetPendData:RemoveDeleteLanguage(var_9_0)
			else
				AssetPendData:AddDeleteLanguage(var_9_0)
			end
		elseif SettingData:GetSoundSettingData().voice_language ~= arg_4_0.id_ then
			SettingAction.ChangeSoundSetting("voice_language", arg_4_0.id_)
		end
	end)
end

function var_0_0.SetData(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.id_ = arg_10_1
	arg_10_0.abbr_ = VoiceLanguageCfg[arg_10_0.id_].affix
	arg_10_0.index_ = arg_10_2

	arg_10_0:Show(true)
	arg_10_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_11_0)
	local var_11_0 = VoiceLanguageCfg[arg_11_0.id_]
	local var_11_1 = arg_11_0.abbr_

	arg_11_0.langText_.text = var_11_0.name
	arg_11_0.m_size.text = string.format("%.1fMB", manager.assetPend:GetLanguageTotalSize(var_11_1))

	local var_11_2 = manager.assetPend:GetLanguageDownloadState(var_11_1)
	local var_11_3 = SettingData:GetSoundSettingData().voice_language == arg_11_0.id_

	if AssetPendData:GetDeleteFlag() == false then
		arg_11_0.deleteSelectController_:SetSelectedState("null")

		if AssetPendDownloadState.DOWNLOAD_SUCCESS == var_11_2 then
			if var_11_3 then
				arg_11_0.deleteSelectController_:SetSelectedState("currenticon")
			else
				arg_11_0.deleteSelectController_:SetSelectedState("unselect")
			end

			arg_11_0.stateController_:SetSelectedState("null")
			arg_11_0.sizeController_:SetSelectedState("state3")
			arg_11_0.cancelController_:SetSelectedState("off")
		elseif AssetPendDownloadState.DOWNLOADING == var_11_2 then
			arg_11_0.stateController_:SetSelectedState("downloading")
			arg_11_0.sizeController_:SetSelectedState("state1")
			arg_11_0.cancelController_:SetSelectedState("on")

			if manager.assetPend:IsLanguageVerifying() then
				arg_11_0.m_speed.font = arg_11_0.m_des.font
			else
				arg_11_0.m_speed.font = arg_11_0.m_size.font
			end

			arg_11_0.m_speed.text = manager.assetPend:GetLanguageSpeedStr()

			local var_11_4 = manager.assetPend:GetLaunguageDownloadedSize(var_11_1)
			local var_11_5 = manager.assetPend:GetLanguageTotalSize(var_11_1)
			local var_11_6 = var_11_4 / var_11_5

			arg_11_0.m_processLab.text = string.format("%.1fMB/%.1fMB", var_11_4, var_11_5)
			arg_11_0.m_processFill2.text = string.format("%.1f%%", var_11_6 * 100)
		elseif AssetPendDownloadState.DOWNLOAD_PAUSE == var_11_2 then
			arg_11_0.stateController_:SetSelectedState("downloaded")
			arg_11_0.sizeController_:SetSelectedState("state2")
			arg_11_0.cancelController_:SetSelectedState("on")

			local var_11_7 = manager.assetPend:GetLaunguageDownloadedSize(var_11_1)
			local var_11_8 = manager.assetPend:GetLanguageTotalSize(var_11_1)
			local var_11_9 = var_11_7 / var_11_8

			arg_11_0.m_processLab.text = string.format("%.1fMB/%.1fMB", var_11_7, var_11_8)
			arg_11_0.m_processFill.text = string.format("%.1f%%", var_11_9 * 100)
		elseif AssetPendDownloadState.DOWNLOAD_QUEUE == var_11_2 then
			arg_11_0.stateController_:SetSelectedState("downloaded")
			arg_11_0.sizeController_:SetSelectedState("state4")
			arg_11_0.cancelController_:SetSelectedState("on")

			arg_11_0.m_processFill.text = "0%"
		else
			arg_11_0.stateController_:SetSelectedState("download")
			arg_11_0.sizeController_:SetSelectedState("state3")
			arg_11_0.cancelController_:SetSelectedState("off")
		end
	else
		arg_11_0.stateController_:SetSelectedState("null")
		arg_11_0.sizeController_:SetSelectedState("state3")
		arg_11_0.cancelController_:SetSelectedState("off")

		if var_11_3 then
			arg_11_0.deleteSelectController_:SetSelectedState("current")
		elseif AssetPendDownloadState.DOWNLOAD_SUCCESS == var_11_2 then
			if AssetPendTools.IsSelectDeleteLanguage(var_11_1) then
				arg_11_0.deleteSelectController_:SetSelectedState("select")
			else
				arg_11_0.deleteSelectController_:SetSelectedState("unselect")
			end
		else
			arg_11_0.deleteSelectController_:SetSelectedState("lock")
		end
	end
end

return var_0_0
