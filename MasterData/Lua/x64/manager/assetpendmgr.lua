AssetPendDownloadState = {
	UNDOWNLOAD = 0,
	DOWNLOAD_SUCCESS = 4,
	DOWNLOADING = 1,
	DOWNLOAD_FAIL = 5,
	DOWNLOAD_PAUSE = 3,
	DOWNLOAD_QUEUE = 2
}

local AssetPendMgr = class("AssetPendMgr")

function AssetPendMgr:Ctor()
	self.cacheAssetPendList = nil
	self.assetPendState = {}
	self.assetPendProcess = {}
	self.assetExistSizeList_ = {}

	AssetPendDownLoadManager.instance:ContinueDownLoadPackage()

	self.disable_ = AssetPendDownLoadManager.instance.disable
	self.downloadLangQueue_ = {}
	self.pauseLangQueue_ = {}
	self.curDownloadingLang_ = nil
	self.downloadingSizes_ = {}
end

function AssetPendMgr:CheckAssetPend(arg_2_1)
	if arg_2_1 == nil or arg_2_1 == "" or self.disable_ then
		return true
	end

	return AssetPendDownLoadManager.instance:CheckAssetPendDownloaded(PendType.Package, arg_2_1)
end

function AssetPendMgr:GetIsDownloading()
	return AssetPendDownLoadManager.instance:GetCurOptionKey() ~= ""
end

function AssetPendMgr:GetDownloadingKey()
	return AssetPendDownLoadManager.instance:GetCurOptionKey()
end

function AssetPendMgr:GetDownloadProcess()
	return AssetPendDownLoadManager.instance:GetProcess()
end

function AssetPendMgr:GetDownloadProcessStr()
	return AssetPendDownLoadManager.instance:GetProcessStr()
end

function AssetPendMgr:GetSpeedStr()
	return AssetPendDownLoadManager.instance:GetSpeedStr() .. "/S"
end

function AssetPendMgr:GetAssetPendList()
	if self.cacheAssetPendList ~= nil then
		return self.cacheAssetPendList
	end

	if self.disable_ then
		self.cacheAssetPendList = {}

		return self.cacheAssetPendList
	end

	local var_8_0 = AssetPendDownLoadManager.instance:GetAssetPendList()

	self.cacheAssetPendList = {}

	for iter_8_0 = 0, var_8_0.Count - 1 do
		table.insert(self.cacheAssetPendList, var_8_0[iter_8_0])
	end

	return self.cacheAssetPendList
end

function AssetPendMgr:IsPermanentAssetPend(arg_9_1)
	return AssetPendDownLoadManager.instance:IsPermanentAssetPend(arg_9_1)
end

function AssetPendMgr:UpdateAssetPendSize()
	AssetPendDownLoadManager.instance:UpdateAssetPendSize()
end

function AssetPendMgr:StartDownloadAsset(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	return self:StartDownload(arg_11_1, PendType.SingleAsset, arg_11_2, arg_11_3, arg_11_4)
end

function AssetPendMgr:StartDownloadAudio(arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5)
	return self:StartDownload(arg_12_1, PendType.SingleVoice, arg_12_3, arg_12_4, arg_12_5)
end

function AssetPendMgr:StartDownload(arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
	self:GetAssetPendExistSize(arg_13_1)

	if AssetPendDownLoadManager.instance:AddPend(arg_13_2 or PendType.Package, arg_13_1, function(arg_14_0)
		self:OnDownloadSuccess(arg_14_0)

		if arg_13_3 then
			arg_13_3()
		end
	end, function(arg_15_0)
		self:OnDownloadFail(arg_15_0)

		if arg_13_4 then
			arg_13_4()
		end
	end, function(arg_16_0)
		self:OnDownloadPause(arg_16_0)

		if arg_13_5 then
			arg_13_5()
		end
	end) then
		return true
	else
		return false
	end
end

function AssetPendMgr:StopDownload(arg_17_1)
	if self:GetDownloadingKey() == arg_17_1 then
		self.assetPendProcess[arg_17_1] = {
			process = self:GetDownloadProcess(),
			processStr = self:GetDownloadProcessStr()
		}
	end

	AssetPendDownLoadManager.instance:StopAssetPendDownload(arg_17_1)
end

function AssetPendMgr:CancelDownload(arg_18_1)
	if self:GetDownloadingKey() == arg_18_1 then
		self.assetPendProcess[arg_18_1] = {
			process = self:GetDownloadProcess(),
			processStr = self:GetDownloadProcessStr()
		}
	end

	AssetPendDownLoadManager.instance:CancelAssetPendDownload(arg_18_1)
	manager.assetPend:RemovePackage(arg_18_1)
end

function AssetPendMgr:OnDownloadPause(arg_19_1)
	self.assetPendState[arg_19_1] = "pause"

	manager.notify:CallUpdateFunc(ASSET_PEND_DOWNLOAD_END, arg_19_1, false)
end

function AssetPendMgr:OnDownloadSuccess(arg_20_1)
	self.assetPendState[arg_20_1] = "success"

	if arg_20_1 == "assetpend_consistent_activity_m" or arg_20_1 == "assetpend_background_music_default" then
		manager.audio:CleanCriAtom()
		PlayGameSetBGM()
	end

	manager.notify:CallUpdateFunc(ASSET_PEND_DOWNLOAD_END, arg_20_1, true)
	manager.assetPend:RecalculateAssetPendExistSizes()
	AssetPendData:SetNeedRecalc()
end

function AssetPendMgr:OnDownloadFail(arg_21_1)
	self.assetPendState[arg_21_1] = "fail"

	manager.notify:CallUpdateFunc(ASSET_PEND_DOWNLOAD_END, arg_21_1, false)
end

function AssetPendMgr:RemovePackage(arg_22_1)
	self.assetPendState[arg_22_1] = nil

	AssetPendDownLoadManager.instance:RemovePackage(arg_22_1)
end

function AssetPendMgr:DownloadPendList(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	AssetPendDownLoadManager.instance:AddPendList(arg_23_1, function(arg_24_0)
		self:OnDownloadSuccess(arg_24_0)

		if arg_23_2 then
			arg_23_2()
		end
	end, function(arg_25_0)
		self:OnDownloadFail(arg_25_0)

		if arg_23_3 then
			arg_23_3()
		end
	end, function(arg_26_0)
		self:OnDownloadPause(arg_26_0)

		if arg_23_4 then
			arg_23_4()
		end
	end)

	for iter_23_0, iter_23_1 in ipairs(arg_23_1) do
		self:GetAssetPendExistSize(iter_23_1)
	end
end

function AssetPendMgr:GetRemoveAssetPendListSize(arg_27_1, arg_27_2)
	local var_27_0 = 0

	for iter_27_0, iter_27_1 in ipairs(arg_27_2) do
		var_27_0 = var_27_0 + manager.assetPend:GetLanguageTotalSize(iter_27_1)
	end

	return AssetPendDownLoadManager.instance:GetRemoveAssetPendListSize(arg_27_1, var_27_0)
end

function AssetPendMgr:RemovePendList(arg_28_1)
	for iter_28_0, iter_28_1 in ipairs(arg_28_1) do
		AssetPendDownLoadManager.instance:RemovePackage(iter_28_1)
	end
end

function AssetPendMgr:GetAssetPendState(arg_29_1)
	if self:CheckAssetPend(arg_29_1) then
		return AssetPendDownloadState.DOWNLOAD_SUCCESS
	end

	if arg_29_1 == AssetPendDownLoadManager.instance:GetCurOptionKey() then
		return AssetPendDownloadState.DOWNLOADING
	end

	if AssetPendDownLoadManager.instance:IsDownloadingQueue(arg_29_1) then
		return AssetPendDownloadState.DOWNLOAD_QUEUE
	end

	local var_29_0 = self.assetPendState[arg_29_1]

	if self.assetPendState[arg_29_1] == "pause" then
		return AssetPendDownloadState.DOWNLOAD_PAUSE
	elseif var_29_0 == "fail" then
		return AssetPendDownloadState.DOWNLOAD_FAIL
	else
		return AssetPendDownloadState.UNDOWNLOAD
	end

	return AssetPendDownloadState.DOWNLOAD_SUCCESS
end

function AssetPendMgr:GetAssetPendCacheProcess(arg_30_1)
	if self.assetPendProcess[arg_30_1] then
		return self.assetPendProcess[arg_30_1].process, self.assetPendProcess[arg_30_1].processStr
	end

	return 0, ""
end

function AssetPendMgr:GetAssetPendExistSize(arg_31_1)
	if self.assetExistSizeList_[arg_31_1] then
		return self.assetExistSizeList_[arg_31_1]
	end

	self.assetExistSizeList_[arg_31_1] = AssetPendDownLoadManager.instance:GetAssetPendExistSize(arg_31_1)

	return self.assetExistSizeList_[arg_31_1]
end

function AssetPendMgr:RecalculateAssetPendExistSizes()
	for iter_32_0, iter_32_1 in pairs(self.assetExistSizeList_) do
		self.assetExistSizeList_[iter_32_0] = AssetPendDownLoadManager.instance:GetAssetPendExistSize(iter_32_0)
	end

	self:ClearLanguageExistSize()
end

function AssetPendMgr:ClearLanguageExistSize()
	self.downloadingSizes_ = {}
end

function AssetPendMgr:ClearAssetPendExistSize()
	self.assetExistSizeList_ = {}
end

function AssetPendMgr:GetAssetPendSize(arg_35_1)
	if arg_35_1 == nil or arg_35_1 == "" then
		return 0
	end

	return AssetPendDownLoadManager.instance:GetAssetPendSize(arg_35_1)
end

function AssetPendMgr:GetFormatSizeStr(arg_36_1)
	return AssetPendDownLoadManager.instance:GetFormatSizeStr(arg_36_1)
end

function AssetPendMgr:CheckSpaceToDownload(arg_37_1)
	local var_37_0 = AssetPendDownLoadManager.instance:CheckSpaceToDownload(arg_37_1)

	if var_37_0 >= int64.new(0, 0) then
		return true, uint64.new(var_37_0:tostring())
	else
		return false, uint64.new((-var_37_0):tostring())
	end
end

function AssetPendMgr:CheckLauncherBattle(arg_38_1, arg_38_2)
	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == arg_38_1 or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT == arg_38_1 or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAILY == arg_38_1 then
		local var_38_0 = getChapterIDByStageID(arg_38_2)
		local var_38_1 = ChapterCfg[var_38_0] and ChapterCfg[var_38_0].clientID

		if var_38_1 and ChapterClientCfg[var_38_1] then
			return self:CheckAssetPend(ChapterClientCfg[var_38_1].asset_pend_key), ChapterClientCfg[var_38_1].asset_pend_key
		end

		return true
	end

	local var_38_2 = AssetPendInfoCfg.get_id_list_by_asset_stage_type[arg_38_1] or {}

	for iter_38_0 = 1, #var_38_2 do
		if not self:CheckAssetPend(AssetPendInfoCfg[var_38_2[iter_38_0]].asset_id) then
			return false, AssetPendInfoCfg[var_38_2[iter_38_0]].asset_id
		end
	end

	return true
end

function AssetPendMgr:ShowAssetPendMessageBox(arg_39_1)
	JumpTools.OpenPageByJump("assetPendPop", {
		assetPend = arg_39_1
	})
end

function AssetPendMgr:CheckJumpToPage(arg_40_1)
	if not SystemLinkCfg[arg_40_1[1]] then
		return true
	end

	if table.indexof({
		305,
		309,
		310,
		308,
		312,
		307,
		331
	}, arg_40_1[1]) then
		local var_40_0 = getChapterClientCfgByChapterID(arg_40_1[2])

		if var_40_0 then
			return self:CheckAssetPend(var_40_0.asset_pend_key), var_40_0.asset_pend_key
		end
	end

	return self:CheckAssetPend(SystemLinkCfg[arg_40_1[1]].asset_pend_key), SystemLinkCfg[arg_40_1[1]].asset_pend_key
end

function AssetPendMgr:IsDownloadingLanguage()
	return #self.downloadLangQueue_ > 0 or self.curDownloadingLang_ ~= nil
end

function AssetPendMgr:IsDownloadingAssetPend()
	if AssetPendDownLoadManager.instance:IsDownloading() then
		return true
	end

	for iter_42_0, iter_42_1 in pairs(self.assetPendState) do
		if iter_42_1 == "pause" then
			return true
		end
	end

	return false
end

function AssetPendMgr:StartDownLoadLanguage(arg_43_1)
	if VoicePackageManager.Instance:IsHavePackage(arg_43_1) then
		return
	end

	table.removebyvalue(self.pauseLangQueue_, arg_43_1)
	table.removebyvalue(self.downloadLangQueue_, arg_43_1, true)

	self.downloadingSizes_[arg_43_1] = nil

	table.insert(self.downloadLangQueue_, 1, arg_43_1)

	if self.curDownloadingLang_ and self.curDownloadingLang_ ~= arg_43_1 then
		VoicePackageManager.Instance:DownloadCancel()
		table.insert(self.downloadLangQueue_, self.curDownloadingLang_)
	end

	if self.updateTimer ~= nil then
		self.updateTimer:Stop()

		self.updateTimer = nil
	end

	if self.updateTimer == nil then
		self.updateTimer = Timer.New(function()
			self:UpdateLanguageDownload()
		end, 0.1, -1)
	end

	self.updateTimer:Start()
end

function AssetPendMgr:PauseDownLoadLanguage(arg_45_1)
	if self.curDownloadingLang_ == arg_45_1 then
		VoicePackageManager.Instance:DownloadCancel()
	end

	table.removebyvalue(self.pauseLangQueue_, arg_45_1, true)
	table.insert(self.pauseLangQueue_, arg_45_1)
	table.removebyvalue(self.downloadLangQueue_, arg_45_1)
end

function AssetPendMgr:CancelDownloadLanguage(arg_46_1)
	if self.curDownloadingLang_ == arg_46_1 then
		VoicePackageManager.Instance:DownloadCancel()
	end

	if self.downloadingSizes_[arg_46_1] then
		self.downloadingSizes_[arg_46_1][1] = 0
	end

	table.removebyvalue(self.pauseLangQueue_, arg_46_1)
	table.removebyvalue(self.downloadLangQueue_, arg_46_1)
end

function AssetPendMgr:GetLanguageDownloadState(arg_47_1)
	if self.curDownloadingLang_ == arg_47_1 then
		return AssetPendDownloadState.DOWNLOADING
	end

	if table.indexof(self.downloadLangQueue_, arg_47_1) then
		return AssetPendDownloadState.DOWNLOAD_QUEUE
	else
		if VoicePackageManager.Instance:IsHavePackage(arg_47_1) then
			return AssetPendDownloadState.DOWNLOAD_SUCCESS
		end

		if table.indexof(self.pauseLangQueue_, arg_47_1) then
			return AssetPendDownloadState.DOWNLOAD_PAUSE
		end

		return AssetPendDownloadState.UNDOWNLOAD
	end
end

function AssetPendMgr:GetLanguageTotalSize(arg_48_1)
	if self.downloadingSizes_[arg_48_1] then
		return self.downloadingSizes_[arg_48_1][2]
	end

	local var_48_0 = AssetPendDownLoadManager.instance:GetVoicePackageSize(arg_48_1)

	self.downloadingSizes_[arg_48_1] = VoicePackageManager.Instance:IsHavePackage(arg_48_1) and {
		var_48_0,
		var_48_0
	} or {
		0,
		var_48_0
	}

	return var_48_0
end

function AssetPendMgr:GetLaunguageDownloadedSize(arg_49_1)
	if self.downloadingSizes_[arg_49_1] then
		return self.downloadingSizes_[arg_49_1][1]
	end

	return 0
end

function AssetPendMgr:GetLanguageSpeedStr()
	return self.downloadSpeedStr_ or ""
end

function AssetPendMgr:IsLanguageVerifying()
	return self.isLanguageVerifying_
end

function AssetPendMgr:UpdateLanguageDownload()
	if #self.downloadLangQueue_ == 0 and self.curDownloadingLang_ == nil then
		if self.updateTimer ~= nil then
			self.updateTimer:Stop()

			self.updateTimer = nil
		end

		return
	end

	if self.curDownloadingLang_ == nil then
		self.curDownloadingLang_ = self.downloadLangQueue_[1]

		table.remove(self.downloadLangQueue_, 1)

		if VoicePackageManager.Instance:IsHavePackage(self.curDownloadingLang_) then
			return
		end

		if AssetPendDownLoadManager.instance:GetVoicePackageSize(self.curDownloadingLang_) + 200 > LuaForUtil.GetFreeDiskSpace() then
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

			self.curDownloadingLang_ = nil

			return
		end

		VoicePackageManager.Instance:StartDownLoadPackage(self.curDownloadingLang_)
	end

	local var_52_0 = self.curDownloadingLang_
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
				self.downloadSpeedStr_ = var_52_6
				self.downloadingSizes_[var_52_0] = {
					var_52_4,
					var_52_5
				}
			else
				self.downloadSpeedStr_ = GetTips("ASSET_PEND_VERIFICATION_TIPS")
				self.isLanguageVerifying_ = true
				self.downloadingSizes_[var_52_0][1] = var_52_4 / var_52_5 * self.downloadingSizes_[var_52_0][2]
			end
		end
	end

	if VoicePackageManager.Instance:IsSucceed(var_52_1) then
		VoicePackageManager.Instance:InsertDownloadedPackage(var_52_0)
		VoicePackageManager.Instance:DownloadShutdown()
		manager.assetPend:UpdateAssetPendSize()
		manager.notify:CallUpdateFunc(LANGUAGE_PACKAGE_DOWNLOADED, var_52_0)

		self.downloadingSizes_[var_52_0] = nil
		self.curDownloadingLang_ = nil
		self.downloadSpeedStr_ = nil
		self.isLanguageVerifying_ = false
	end

	if VoicePackageManager.Instance:IsFailed(var_52_1) then
		Debug.Log("Language DownLoad Fail:" .. VoicePackageManager.Instance:GetDownloadInfo(var_52_1))
	end

	if VoicePackageManager.Instance:IsCanceling(var_52_1) then
		local var_52_7 = VoicePackageManager.Instance:GetDownloadInfo(var_52_1)
	end

	if VoicePackageManager.Instance:IsCanceled(var_52_1) then
		VoicePackageManager.Instance:DownloadShutdown()
		manager.notify:CallUpdateFunc(LANGUAGE_PACKAGE_CANCEL)

		self.curDownloadingLang_ = nil
		self.downloadSpeedStr_ = nil
		self.isLanguageVerifying_ = false
	end
end

return AssetPendMgr
