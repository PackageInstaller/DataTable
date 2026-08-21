AssetPendDownloadState = {
	UNDOWNLOAD = 0,
	DOWNLOAD_SUCCESS = 4,
	DOWNLOADING = 1,
	DOWNLOAD_FAIL = 5,
	DOWNLOAD_PAUSE = 3,
	DOWNLOAD_QUEUE = 2
}

local var_0_0 = class("AssetPendMgr")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.cacheAssetPendList = nil
	arg_1_0.assetPendState = {}
	arg_1_0.assetPendProcess = {}
	arg_1_0.assetExistSizeList_ = {}

	AssetPendDownLoadManager.instance:ContinueDownLoadPackage()

	arg_1_0.disable_ = AssetPendDownLoadManager.instance.disable
	arg_1_0.downloadLangQueue_ = {}
	arg_1_0.pauseLangQueue_ = {}
	arg_1_0.curDownloadingLang_ = nil
	arg_1_0.downloadingSizes_ = {}
end

function var_0_0.CheckAssetPend(arg_2_0, arg_2_1)
	if arg_2_1 == nil or arg_2_1 == "" or arg_2_0.disable_ then
		return true
	end

	return AssetPendDownLoadManager.instance:CheckAssetPendDownloaded(PendType.Package, arg_2_1)
end

function var_0_0.GetIsDownloading(arg_3_0)
	return AssetPendDownLoadManager.instance:GetCurOptionKey() ~= ""
end

function var_0_0.GetDownloadingKey(arg_4_0)
	return AssetPendDownLoadManager.instance:GetCurOptionKey()
end

function var_0_0.GetDownloadProcess(arg_5_0)
	return AssetPendDownLoadManager.instance:GetProcess()
end

function var_0_0.GetDownloadProcessStr(arg_6_0)
	return AssetPendDownLoadManager.instance:GetProcessStr()
end

function var_0_0.GetSpeedStr(arg_7_0)
	return AssetPendDownLoadManager.instance:GetSpeedStr() .. "/S"
end

function var_0_0.GetAssetPendList(arg_8_0)
	if arg_8_0.cacheAssetPendList ~= nil then
		return arg_8_0.cacheAssetPendList
	end

	if arg_8_0.disable_ then
		arg_8_0.cacheAssetPendList = {}

		return arg_8_0.cacheAssetPendList
	end

	local var_8_0 = AssetPendDownLoadManager.instance:GetAssetPendList()
	local var_8_1 = var_8_0.Count

	arg_8_0.cacheAssetPendList = {}

	for iter_8_0 = 0, var_8_1 - 1 do
		table.insert(arg_8_0.cacheAssetPendList, var_8_0[iter_8_0])
	end

	return arg_8_0.cacheAssetPendList
end

function var_0_0.IsPermanentAssetPend(arg_9_0, arg_9_1)
	return AssetPendDownLoadManager.instance:IsPermanentAssetPend(arg_9_1)
end

function var_0_0.UpdateAssetPendSize(arg_10_0)
	AssetPendDownLoadManager.instance:UpdateAssetPendSize()
end

function var_0_0.StartDownloadAsset(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	return arg_11_0:StartDownload(arg_11_1, PendType.SingleAsset, arg_11_2, arg_11_3, arg_11_4)
end

function var_0_0.StartDownloadAudio(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5)
	return arg_12_0:StartDownload(arg_12_1, PendType.SingleVoice, arg_12_3, arg_12_4, arg_12_5)
end

function var_0_0.StartDownload(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
	arg_13_0:GetAssetPendExistSize(arg_13_1)

	if AssetPendDownLoadManager.instance:AddPend(arg_13_2 or PendType.Package, arg_13_1, function(arg_14_0)
		arg_13_0:OnDownloadSuccess(arg_14_0)

		if arg_13_3 then
			arg_13_3()
		end
	end, function(arg_15_0)
		arg_13_0:OnDownloadFail(arg_15_0)

		if arg_13_4 then
			arg_13_4()
		end
	end, function(arg_16_0)
		arg_13_0:OnDownloadPause(arg_16_0)

		if arg_13_5 then
			arg_13_5()
		end
	end) then
		return true
	else
		return false
	end
end

function var_0_0.StopDownload(arg_17_0, arg_17_1)
	if arg_17_0:GetDownloadingKey() == arg_17_1 then
		arg_17_0.assetPendProcess[arg_17_1] = {
			process = arg_17_0:GetDownloadProcess(),
			processStr = arg_17_0:GetDownloadProcessStr()
		}
	end

	AssetPendDownLoadManager.instance:StopAssetPendDownload(arg_17_1)
end

function var_0_0.CancelDownload(arg_18_0, arg_18_1)
	if arg_18_0:GetDownloadingKey() == arg_18_1 then
		arg_18_0.assetPendProcess[arg_18_1] = {
			process = arg_18_0:GetDownloadProcess(),
			processStr = arg_18_0:GetDownloadProcessStr()
		}
	end

	AssetPendDownLoadManager.instance:CancelAssetPendDownload(arg_18_1)
	manager.assetPend:RemovePackage(arg_18_1)
end

function var_0_0.OnDownloadPause(arg_19_0, arg_19_1)
	arg_19_0.assetPendState[arg_19_1] = "pause"

	manager.notify:CallUpdateFunc(ASSET_PEND_DOWNLOAD_END, arg_19_1, false)
end

function var_0_0.OnDownloadSuccess(arg_20_0, arg_20_1)
	arg_20_0.assetPendState[arg_20_1] = "success"

	if arg_20_1 == "assetpend_consistent_activity_m" or arg_20_1 == "assetpend_background_music_default" then
		manager.audio:CleanCriAtom()
		PlayGameSetBGM()
	end

	manager.notify:CallUpdateFunc(ASSET_PEND_DOWNLOAD_END, arg_20_1, true)
	manager.assetPend:RecalculateAssetPendExistSizes()
	AssetPendData:SetNeedRecalc()
end

function var_0_0.OnDownloadFail(arg_21_0, arg_21_1)
	arg_21_0.assetPendState[arg_21_1] = "fail"

	manager.notify:CallUpdateFunc(ASSET_PEND_DOWNLOAD_END, arg_21_1, false)
end

function var_0_0.RemovePackage(arg_22_0, arg_22_1)
	arg_22_0.assetPendState[arg_22_1] = nil

	AssetPendDownLoadManager.instance:RemovePackage(arg_22_1)
end

function var_0_0.DownloadPendList(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	AssetPendDownLoadManager.instance:AddPendList(arg_23_1, function(arg_24_0)
		arg_23_0:OnDownloadSuccess(arg_24_0)

		if arg_23_2 then
			arg_23_2()
		end
	end, function(arg_25_0)
		arg_23_0:OnDownloadFail(arg_25_0)

		if arg_23_3 then
			arg_23_3()
		end
	end, function(arg_26_0)
		arg_23_0:OnDownloadPause(arg_26_0)

		if arg_23_4 then
			arg_23_4()
		end
	end)

	for iter_23_0, iter_23_1 in ipairs(arg_23_1) do
		arg_23_0:GetAssetPendExistSize(iter_23_1)
	end
end

function var_0_0.GetRemoveAssetPendListSize(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = 0

	for iter_27_0, iter_27_1 in ipairs(arg_27_2) do
		var_27_0 = var_27_0 + manager.assetPend:GetLanguageTotalSize(iter_27_1)
	end

	return AssetPendDownLoadManager.instance:GetRemoveAssetPendListSize(arg_27_1, var_27_0)
end

function var_0_0.RemovePendList(arg_28_0, arg_28_1)
	for iter_28_0, iter_28_1 in ipairs(arg_28_1) do
		AssetPendDownLoadManager.instance:RemovePackage(iter_28_1)
	end
end

function var_0_0.GetAssetPendState(arg_29_0, arg_29_1)
	if arg_29_0:CheckAssetPend(arg_29_1) then
		return AssetPendDownloadState.DOWNLOAD_SUCCESS
	end

	if arg_29_1 == AssetPendDownLoadManager.instance:GetCurOptionKey() then
		return AssetPendDownloadState.DOWNLOADING
	end

	if AssetPendDownLoadManager.instance:IsDownloadingQueue(arg_29_1) then
		return AssetPendDownloadState.DOWNLOAD_QUEUE
	end

	local var_29_0 = arg_29_0.assetPendState[arg_29_1]

	if var_29_0 == "pause" then
		return AssetPendDownloadState.DOWNLOAD_PAUSE
	elseif var_29_0 == "fail" then
		return AssetPendDownloadState.DOWNLOAD_FAIL
	else
		return AssetPendDownloadState.UNDOWNLOAD
	end

	return AssetPendDownloadState.DOWNLOAD_SUCCESS
end

function var_0_0.GetAssetPendCacheProcess(arg_30_0, arg_30_1)
	if arg_30_0.assetPendProcess[arg_30_1] then
		return arg_30_0.assetPendProcess[arg_30_1].process, arg_30_0.assetPendProcess[arg_30_1].processStr
	end

	return 0, ""
end

function var_0_0.GetAssetPendExistSize(arg_31_0, arg_31_1)
	if arg_31_0.assetExistSizeList_[arg_31_1] then
		return arg_31_0.assetExistSizeList_[arg_31_1]
	end

	arg_31_0.assetExistSizeList_[arg_31_1] = AssetPendDownLoadManager.instance:GetAssetPendExistSize(arg_31_1)

	return arg_31_0.assetExistSizeList_[arg_31_1]
end

function var_0_0.RecalculateAssetPendExistSizes(arg_32_0)
	for iter_32_0, iter_32_1 in pairs(arg_32_0.assetExistSizeList_) do
		arg_32_0.assetExistSizeList_[iter_32_0] = AssetPendDownLoadManager.instance:GetAssetPendExistSize(iter_32_0)
	end

	arg_32_0:ClearLanguageExistSize()
end

function var_0_0.ClearLanguageExistSize(arg_33_0)
	arg_33_0.downloadingSizes_ = {}
end

function var_0_0.ClearAssetPendExistSize(arg_34_0)
	arg_34_0.assetExistSizeList_ = {}
end

function var_0_0.GetAssetPendSize(arg_35_0, arg_35_1)
	if arg_35_1 == nil or arg_35_1 == "" then
		return 0
	end

	return AssetPendDownLoadManager.instance:GetAssetPendSize(arg_35_1)
end

function var_0_0.GetFormatSizeStr(arg_36_0, arg_36_1)
	return AssetPendDownLoadManager.instance:GetFormatSizeStr(arg_36_1)
end

function var_0_0.CheckSpaceToDownload(arg_37_0, arg_37_1)
	local var_37_0 = AssetPendDownLoadManager.instance:CheckSpaceToDownload(arg_37_1)

	if var_37_0 >= int64.new(0, 0) then
		return true, uint64.new(var_37_0:tostring())
	else
		return false, uint64.new((-var_37_0):tostring())
	end
end

function var_0_0.CheckLauncherBattle(arg_38_0, arg_38_1, arg_38_2)
	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == arg_38_1 or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT == arg_38_1 or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAILY == arg_38_1 then
		local var_38_0 = getChapterIDByStageID(arg_38_2)
		local var_38_1 = ChapterCfg[var_38_0] and ChapterCfg[var_38_0].clientID

		if var_38_1 and ChapterClientCfg[var_38_1] then
			local var_38_2 = ChapterClientCfg[var_38_1].asset_pend_key

			return arg_38_0:CheckAssetPend(var_38_2), var_38_2
		end

		return true
	end

	local var_38_3 = AssetPendInfoCfg.get_id_list_by_asset_stage_type[arg_38_1] or {}

	for iter_38_0 = 1, #var_38_3 do
		local var_38_4 = var_38_3[iter_38_0]
		local var_38_5 = AssetPendInfoCfg[var_38_4].asset_id

		if not arg_38_0:CheckAssetPend(var_38_5) then
			return false, var_38_5
		end
	end

	return true
end

function var_0_0.ShowAssetPendMessageBox(arg_39_0, arg_39_1)
	JumpTools.OpenPageByJump("assetPendPop", {
		assetPend = arg_39_1
	})
end

function var_0_0.CheckJumpToPage(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_1[1]
	local var_40_1 = SystemLinkCfg[var_40_0]

	if not var_40_1 then
		return true
	end

	local var_40_2 = {
		305,
		309,
		310,
		308,
		312,
		307,
		331
	}

	if table.indexof(var_40_2, var_40_0) then
		local var_40_3 = arg_40_1[2]
		local var_40_4 = getChapterClientCfgByChapterID(var_40_3)

		if var_40_4 then
			return arg_40_0:CheckAssetPend(var_40_4.asset_pend_key), var_40_4.asset_pend_key
		end
	end

	return arg_40_0:CheckAssetPend(var_40_1.asset_pend_key), var_40_1.asset_pend_key
end

function var_0_0.IsDownloadingLanguage(arg_41_0)
	return #arg_41_0.downloadLangQueue_ > 0 or arg_41_0.curDownloadingLang_ ~= nil
end

function var_0_0.IsDownloadingAssetPend(arg_42_0)
	if AssetPendDownLoadManager.instance:IsDownloading() then
		return true
	end

	for iter_42_0, iter_42_1 in pairs(arg_42_0.assetPendState) do
		if iter_42_1 == "pause" then
			return true
		end
	end

	return false
end

function var_0_0.StartDownLoadLanguage(arg_43_0, arg_43_1)
	if VoicePackageManager.Instance:IsHavePackage(arg_43_1) then
		return
	end

	table.removebyvalue(arg_43_0.pauseLangQueue_, arg_43_1)
	table.removebyvalue(arg_43_0.downloadLangQueue_, arg_43_1, true)

	arg_43_0.downloadingSizes_[arg_43_1] = nil

	table.insert(arg_43_0.downloadLangQueue_, 1, arg_43_1)

	if arg_43_0.curDownloadingLang_ and arg_43_0.curDownloadingLang_ ~= arg_43_1 then
		VoicePackageManager.Instance:DownloadCancel()
		table.insert(arg_43_0.downloadLangQueue_, arg_43_0.curDownloadingLang_)
	end

	if arg_43_0.updateTimer ~= nil then
		arg_43_0.updateTimer:Stop()

		arg_43_0.updateTimer = nil
	end

	if arg_43_0.updateTimer == nil then
		arg_43_0.updateTimer = Timer.New(function()
			arg_43_0:UpdateLanguageDownload()
		end, 0.1, -1)
	end

	arg_43_0.updateTimer:Start()
end

function var_0_0.PauseDownLoadLanguage(arg_45_0, arg_45_1)
	if arg_45_0.curDownloadingLang_ == arg_45_1 then
		VoicePackageManager.Instance:DownloadCancel()
	end

	table.removebyvalue(arg_45_0.pauseLangQueue_, arg_45_1, true)
	table.insert(arg_45_0.pauseLangQueue_, arg_45_1)
	table.removebyvalue(arg_45_0.downloadLangQueue_, arg_45_1)
end

function var_0_0.CancelDownloadLanguage(arg_46_0, arg_46_1)
	if arg_46_0.curDownloadingLang_ == arg_46_1 then
		VoicePackageManager.Instance:DownloadCancel()
	end

	if arg_46_0.downloadingSizes_[arg_46_1] then
		arg_46_0.downloadingSizes_[arg_46_1][1] = 0
	end

	table.removebyvalue(arg_46_0.pauseLangQueue_, arg_46_1)
	table.removebyvalue(arg_46_0.downloadLangQueue_, arg_46_1)
end

function var_0_0.GetLanguageDownloadState(arg_47_0, arg_47_1)
	if arg_47_0.curDownloadingLang_ == arg_47_1 then
		return AssetPendDownloadState.DOWNLOADING
	end

	if table.indexof(arg_47_0.downloadLangQueue_, arg_47_1) then
		return AssetPendDownloadState.DOWNLOAD_QUEUE
	else
		if VoicePackageManager.Instance:IsHavePackage(arg_47_1) then
			return AssetPendDownloadState.DOWNLOAD_SUCCESS
		end

		if table.indexof(arg_47_0.pauseLangQueue_, arg_47_1) then
			return AssetPendDownloadState.DOWNLOAD_PAUSE
		end

		return AssetPendDownloadState.UNDOWNLOAD
	end
end

function var_0_0.GetLanguageTotalSize(arg_48_0, arg_48_1)
	if arg_48_0.downloadingSizes_[arg_48_1] then
		return arg_48_0.downloadingSizes_[arg_48_1][2]
	end

	local var_48_0 = AssetPendDownLoadManager.instance:GetVoicePackageSize(arg_48_1)

	if VoicePackageManager.Instance:IsHavePackage(arg_48_1) then
		arg_48_0.downloadingSizes_[arg_48_1] = {
			var_48_0,
			var_48_0
		}
	else
		arg_48_0.downloadingSizes_[arg_48_1] = {
			0,
			var_48_0
		}
	end

	return var_48_0
end

function var_0_0.GetLaunguageDownloadedSize(arg_49_0, arg_49_1)
	if arg_49_0.downloadingSizes_[arg_49_1] then
		return arg_49_0.downloadingSizes_[arg_49_1][1]
	end

	return 0
end

function var_0_0.GetLanguageSpeedStr(arg_50_0)
	return arg_50_0.downloadSpeedStr_ or ""
end

function var_0_0.IsLanguageVerifying(arg_51_0)
	return arg_51_0.isLanguageVerifying_
end

function var_0_0.UpdateLanguageDownload(arg_52_0)
	if #arg_52_0.downloadLangQueue_ == 0 and arg_52_0.curDownloadingLang_ == nil then
		if arg_52_0.updateTimer ~= nil then
			arg_52_0.updateTimer:Stop()

			arg_52_0.updateTimer = nil
		end

		return
	end

	if arg_52_0.curDownloadingLang_ == nil then
		arg_52_0.curDownloadingLang_ = arg_52_0.downloadLangQueue_[1]

		table.remove(arg_52_0.downloadLangQueue_, 1)

		if VoicePackageManager.Instance:IsHavePackage(arg_52_0.curDownloadingLang_) then
			return
		end

		if AssetPendDownLoadManager.instance:GetVoicePackageSize(arg_52_0.curDownloadingLang_) + 200 > LuaForUtil.GetFreeDiskSpace() then
			ShowMessageBox({
				content = GetTips("VOICE_STORAGE_FULL"),
				OkCallback = function()
					return
				end,
				CancelCallback = function()
					return
				end,
				MaskCallback = function()
					return
				end
			})

			arg_52_0.curDownloadingLang_ = nil

			return
		end

		VoicePackageManager.Instance:StartDownLoadPackage(arg_52_0.curDownloadingLang_)
	end

	local var_52_0 = arg_52_0.curDownloadingLang_
	local var_52_1 = VoicePackageManager.Instance:UpdateDownloading()

	if VoicePackageManager.Instance:IsDownloading(var_52_1) then
		local var_52_2 = VoicePackageManager.Instance:GetDownloadInfo(var_52_1)

		if var_52_2 ~= "" then
			local var_52_3 = string.split(var_52_2, ":")
			local var_52_4 = tonumber(var_52_3[2])
			local var_52_5 = tonumber(var_52_3[3])
			local var_52_6 = (function(arg_56_0)
				return (string.match(arg_56_0, "([%d%.]+[KMGT]?B/S)$"))
			end)(var_52_2)

			if var_52_6 then
				arg_52_0.downloadSpeedStr_ = var_52_6
				arg_52_0.downloadingSizes_[var_52_0] = {
					var_52_4,
					var_52_5
				}
			else
				arg_52_0.downloadSpeedStr_ = GetTips("ASSET_PEND_VERIFICATION_TIPS")
				arg_52_0.isLanguageVerifying_ = true
				arg_52_0.downloadingSizes_[var_52_0][1] = var_52_4 / var_52_5 * arg_52_0.downloadingSizes_[var_52_0][2]
			end
		end
	end

	if VoicePackageManager.Instance:IsSucceed(var_52_1) then
		VoicePackageManager.Instance:InsertDownloadedPackage(var_52_0)
		VoicePackageManager.Instance:DownloadShutdown()
		manager.assetPend:UpdateAssetPendSize()
		manager.notify:CallUpdateFunc(LANGUAGE_PACKAGE_DOWNLOADED, var_52_0)

		arg_52_0.downloadingSizes_[var_52_0] = nil
		arg_52_0.curDownloadingLang_ = nil
		arg_52_0.downloadSpeedStr_ = nil
		arg_52_0.isLanguageVerifying_ = false
	end

	if VoicePackageManager.Instance:IsFailed(var_52_1) then
		local var_52_7 = VoicePackageManager.Instance:GetDownloadInfo(var_52_1)

		Debug.Log("Language DownLoad Fail:" .. var_52_7)
	end

	if VoicePackageManager.Instance:IsCanceling(var_52_1) then
		local var_52_8 = VoicePackageManager.Instance:GetDownloadInfo(var_52_1)
	end

	if VoicePackageManager.Instance:IsCanceled(var_52_1) then
		VoicePackageManager.Instance:DownloadShutdown()
		manager.notify:CallUpdateFunc(LANGUAGE_PACKAGE_CANCEL)

		arg_52_0.curDownloadingLang_ = nil
		arg_52_0.downloadSpeedStr_ = nil
		arg_52_0.isLanguageVerifying_ = false
	end
end

return var_0_0
