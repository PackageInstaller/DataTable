module("bootstrap.flow.nodes.BootstrapHotUpdateDownload", package.seeall)

local var_0_0 = class("BootstrapHotUpdateDownload", BoostrapFlowLauncherNode)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)
	arg_1_0:resetData()
end

function var_0_0.resetData(arg_2_0)
	arg_2_0._isSendEHotUpdateDownloadProgress1 = false
	arg_2_0._isSendEHotUpdateDownloadProgress5 = false
	arg_2_0._isSendEHotUpdateDownloadProgress10 = false
	arg_2_0._isSendEHotUpdateDownloadProgress20 = false
	arg_2_0._isSendEHotUpdateDownloadProgress30 = false
	arg_2_0._isSendEHotUpdateDownloadProgress50 = false
	arg_2_0._isSendEHotUpdateDownloadProgress75 = false
	arg_2_0._isSendEHotUpdateDownloadProgress100 = false
	arg_2_0._currentReceivedBytes = 0
	arg_2_0._totalBytesToReceive = 0
	arg_2_0._startHotUpdateDowntime = 0
	arg_2_0._startHotUpdateDownClock = 0
	arg_2_0._countHotUpdateDownloadFail = 0
	arg_2_0._sensorsTrackPara = {}
	arg_2_0._kDownloadProgressTickInterval = 30
	arg_2_0._startHotUpdateTimeStamp = 0
	arg_2_0._startGetManifestTimeStamp = 0
	arg_2_0._startGetManifestClock = 0
	arg_2_0._requestRemoteCount = 1
	arg_2_0._isDownloadFromSourceResServer = false
end

function var_0_0.onDestroy(arg_3_0)
	var_0_0.super.onDestroy(arg_3_0)
	arg_3_0:resetData()
end

function var_0_0.syncViewData(arg_4_0)
	BootstrapViewLogic.instance:setCurReceivedBytes(arg_4_0._currentReceivedBytes)
	BootstrapViewLogic.instance:setTotalBytesToReceive(arg_4_0._totalBytesToReceive)
end

function var_0_0.onStart(arg_5_0)
	print("BootstrapFlow", "下载热更资源")
	arg_5_0:startHotUpdate()
end

function var_0_0.onReset(arg_6_0)
	Astral.GameUpdateHelper.Instance:ClearListeners()

	arg_6_0._isAddListener = false
end

function var_0_0._skipUpdate(arg_7_0)
	arg_7_0:onHotupdateDone()
end

function var_0_0.onHotupdateDone(arg_8_0)
	if Astral.VersionMgr.Instance.IsNeedRestartApp then
		BootstrapMsgBoxView.setBtnTxt(BootstrapLanguage.getTipsTextByKey("confirm"), BootstrapLanguage.getTipsTextByKey("cancel"))
		BootstrapMsgBoxView.setTxtContent(BootstrapLanguage.getTipsTextByKey("restart"))
		BootstrapMsgBoxView.show(true, BootstrapMsgBoxView.KEY_RESTART)

		return
	end

	arg_8_0:onEnd(BootstrapFlowConst.BTStatus.SUCCESS)
end

function var_0_0.handleEnd(arg_9_0)
	Astral.GameUpdateHelper.Instance:ClearListeners()
end

function var_0_0.startHotUpdate(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = Astral.LocalStorage.Instance:GetInt(BootstrapConst.kOpenPcHotdate, 0) == 1
	local var_10_1 = Astral.OSDef.isEditor

	if Astral.VersionMgr.Instance.IsReloadLuaClient or not Astral.GameConstParser.Instance.gameOpenHotUpdate or not var_10_0 and var_10_1 then
		Astral.VersionMgr.Instance.IsReloadLuaClient = false

		Astral.VersionMgr.Instance:LoadLocalVersionCode()
		arg_10_0:_skipUpdate()

		return
	end

	arg_10_0._hotUpdateCallback = arg_10_1
	arg_10_0._hotUpdateCallbackHandler = arg_10_2

	arg_10_0:showUITipByState(BootstrapConstdef.EBootstrapState.StartHotUpdate)

	arg_10_0.helper = Astral.GameUpdateHelper.Instance

	if not arg_10_0._isAddListener then
		arg_10_0.helper:ClearListeners()
		arg_10_0.helper:AddListener(Astral.HotUpdateEventType.RequestRemoteVersionFail, arg_10_0.onRequestRemoteVersionFail, arg_10_0)
		arg_10_0.helper:AddListener(Astral.HotUpdateEventType.RequestRemoteVersionSuccess, arg_10_0.onRequestRemoteVersionSuccess, arg_10_0)
		arg_10_0.helper:AddListener(Astral.HotUpdateEventType.RequestRemoteProjectManifestFail, arg_10_0.onRequestRemoteProjectManifestFail, arg_10_0)
		arg_10_0.helper:AddListener(Astral.HotUpdateEventType.RequestRemoteProjectManifestSuccess, arg_10_0.onRequestRemoteProjectManifestSuccess, arg_10_0)
		arg_10_0.helper:AddListener(Astral.HotUpdateEventType.NeedPackageUpdate, arg_10_0.onNeedPackageUpdate, arg_10_0)
		arg_10_0.helper:AddListener(Astral.HotUpdateEventType.StartHotUpdateNotify, arg_10_0.onStartHotUpdateNotify, arg_10_0)
		arg_10_0.helper:AddListener(Astral.HotUpdateEventType.HotUpdateDownloadProgress, arg_10_0.onHotUpdateDownloadProgress, arg_10_0)
		arg_10_0.helper:AddListener(Astral.HotUpdateEventType.HotUpdateDownloadFail, arg_10_0.onHotUpdateDownloadFail, arg_10_0)
		arg_10_0.helper:AddListener(Astral.HotUpdateEventType.DiskSpaceInsufficient, arg_10_0.onDiskSpaceInsufficient, arg_10_0)
		arg_10_0.helper:AddListener(Astral.HotUpdateEventType.HotUpdateAllDownloadSuccess, arg_10_0.onHotUpdateAllDownloadSuccess, arg_10_0)
		arg_10_0.helper:AddListener(Astral.HotUpdateEventType.HotUpdateComplete, arg_10_0.onHotUpdateComplete, arg_10_0)
		arg_10_0.helper:AddListener(Astral.HotUpdateEventType.StartUnzipNotify, arg_10_0.onStartUnzipNotify, arg_10_0)
		arg_10_0.helper:AddListener(Astral.HotUpdateEventType.UnzipProgress, arg_10_0.onUnzipProgress, arg_10_0)
		arg_10_0.helper:AddListener(Astral.HotUpdateEventType.UnzipSuccess, arg_10_0.onUnzipSuccess, arg_10_0)
		arg_10_0.helper:AddListener(Astral.HotUpdateEventType.UnzipFail, arg_10_0.onUnzipFail, arg_10_0)

		arg_10_0._isAddListener = true
	end

	BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EStartRequestRemoteVersionIp)
	print("getHotUpdateInfoUrl===>" .. BootstrapGameConfigMgr.getHotUpdateInfoUrl(arg_10_0._requestRemoteCount))
	print("getHotUpdateAppCode===>" .. BootstrapGameConfigMgr.getHotUpdateAppCode())
	print("getHotUpdateDeviceType===>" .. BootstrapUtil.getHotUpdateDeviceType())
	print("getPlatformId===>" .. BootstrapUtil.getPlatformId())
	print("versionCode===>" .. BootstrapUtil.getGameVersionCode())
	print("packageName===>" .. BootstrapUtil.getGamePackageName())

	arg_10_0._startGetManifestTimeStamp = os.time()
	arg_10_0._startGetManifestClock = os.clock()
	arg_10_0._startHotUpdateDowntime = os.time()
	arg_10_0._startHotUpdateDownClock = os.clock()

	local var_10_2 = BootstrapUtil.getHotUpdateDeviceType()

	if var_10_0 then
		local var_10_3 = Astral.LocalStorage.Instance:GetInt(BootstrapConst.kDeviceType, 1)

		var_10_2 = BootstrapConst.HOTUPDATE_DEVIVE_TYPE[var_10_3]
	end

	local var_10_4, var_10_5 = HotUpdateUtil.GetUpdateUrl(BootstrapGameConfigMgr.getHotUpdateInfoUrl(arg_10_0._requestRemoteCount), BootstrapGameConfigMgr.getHotUpdateAppCode(), var_10_2, tostring(BootstrapUtil.getPlatformId()), BootstrapUtil.getGameVersionCode(), BootstrapUtil.getGamePackageName())

	arg_10_0.helper:StartUpdate(var_10_4, var_10_5)
end

function var_0_0.onHotUpdateComplete(arg_11_0)
	local var_11_0 = os.time() - arg_11_0._startHotUpdateDowntime

	BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EHotUpdateComplete, {
		totalSize = tostring(arg_11_0._totalBytesToReceive),
		totalSecond = tostring(var_11_0)
	})
	arg_11_0:showUITipByState(BootstrapConstdef.EBootstrapState.HotUpdateComplete)
	arg_11_0:onHotupdateDone()
end

function var_0_0.onRequestRemoteVersionSuccess(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5)
	BootstrapGameConfigMgr.setIsReview(arg_12_3)
	BootstrapGameConfigMgr.setZoneId(arg_12_2)
	arg_12_0:showUITipByState(BootstrapConstdef.EBootstrapState.RequestRemoteVersionSuccess)
	BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.ERequestRemoteVersionSuccess)

	local var_12_0 = ""

	if arg_12_1 ~= "0.0.0" then
		var_12_0 = string.format("App:%s Res:%s ~ %s %s", UnityEngine.Application.version, BootstrapUtil.getGameHotUpdateVersionCode(), arg_12_1, SpaceX.EngineVersionCode.Version)
	else
		var_12_0 = string.format("App:%s Res:%s %s", UnityEngine.Application.version, BootstrapUtil.getGameHotUpdateVersionCode(), arg_12_1, SpaceX.EngineVersionCode.Version)
	end

	BootstrapLoadingView.setVersionText(var_12_0)

	local var_12_1 = (os.clock() - arg_12_0._startGetManifestClock) * 1000
	local var_12_2 = BootstrapHelper.getGameId()

	Netkit.trackHttpData(Netkit.EventId.GetManifest[1], Netkit.EventId.GetManifest[2], var_12_2, var_12_1, arg_12_0._startGetManifestTimeStamp * 1000)
end

function var_0_0.onRequestRemoteVersionFail(arg_13_0, arg_13_1)
	if BootstrapGameConfigMgr.getIsUseBackupHotupdateInfo() and arg_13_0._requestRemoteCount > BootstrapConst.kHotUpdateRequestRemoteResetCount * 2 or not BootstrapGameConfigMgr.getIsUseBackupHotupdateInfo() and arg_13_0._requestRemoteCount > BootstrapConst.kHotUpdateRequestRemoteResetCount then
		arg_13_0:showUITipByState(BootstrapConstdef.EBootstrapState.RequestRemoteVersionFail)
		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EHotupdateCheckFail)
		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.ERequestRemoteVersionFail)

		local var_13_0 = (os.clock() - arg_13_0._startGetManifestClock) * 1000
		local var_13_1 = BootstrapHelper.getGameId()

		Netkit.trackHttpData(Netkit.EventId.GetManifestFail[1], Netkit.EventId.GetManifestFail[2], var_13_1, var_13_0, arg_13_0._startGetManifestTimeStamp * 1000)
	else
		arg_13_0._requestRemoteCount = arg_13_0._requestRemoteCount + 1

		print("当前重试次数", arg_13_0._requestRemoteCount)
		arg_13_0:startHotUpdate()
	end
end

function var_0_0.onRequestRemoteProjectManifestFail(arg_14_0, arg_14_1)
	if BootstrapGameConfigMgr.getIsUseBackupHotupdateInfo() and arg_14_0._requestRemoteCount > BootstrapConst.kHotUpdateRequestRemoteResetCount * 2 or not BootstrapGameConfigMgr.getIsUseBackupHotupdateInfo() and arg_14_0._requestRemoteCount > BootstrapConst.kHotUpdateRequestRemoteResetCount then
		arg_14_0:showUITipByState(BootstrapConstdef.EBootstrapState.RequestRemoteProjectManifestFail)
		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EHotupdateCheckFail)
		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.ERequestRemoteVersionFail)
	else
		arg_14_0._requestRemoteCount = arg_14_0._requestRemoteCount + 1

		arg_14_0:startHotUpdate()
	end
end

function var_0_0.onRequestRemoteProjectManifestSuccess(arg_15_0)
	arg_15_0:showUITipByState(BootstrapConstdef.EBootstrapState.RequestRemoteProjectManifestSuccess)
end

function var_0_0.onNeedPackageUpdate(arg_16_0, arg_16_1)
	BootstrapViewLogic.instance._urlNeedPackageUpdate = arg_16_1

	arg_16_0:showUITipByState(BootstrapConstdef.EBootstrapState.NeedPackageUpdate)
end

function var_0_0.onStartHotUpdateNotify(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	arg_17_0._countHotUpdateDownloadFail = 0
	arg_17_0._currentReceivedBytes = arg_17_1:tonum2()
	arg_17_0._totalBytesToReceive = arg_17_2:tonum2()

	arg_17_0:syncViewData()
	BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.ENeedHotUpdate, {
		totalSize = tostring(arg_17_0._totalBytesToReceive),
		autoDownload = tostring(NetworkUtils.GetCurrentNetworkType() == 2)
	})
	BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EHotupdateCheckSuccess)
	arg_17_0:showUITipByState(BootstrapConstdef.EBootstrapState.NeedToStartHotUpdate)

	arg_17_0._startHotUpdateTimeStamp = math.ceil(Time:GetTimestamp() * 1000)
end

function var_0_0.onHotUpdateDownloadProgress(arg_18_0, arg_18_1, arg_18_2)
	if BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.HotUpdateDownloadFail or BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.DiskSpaceInsufficient then
		return
	end

	arg_18_0._currentReceivedBytes = arg_18_0._currentReceivedBytes or 0

	local var_18_0 = arg_18_1:tonum2()
	local var_18_1 = arg_18_2:tonum2()
	local var_18_2 = (var_18_0 - arg_18_0._currentReceivedBytes) / 1024
	local var_18_3 = math.floor(var_18_2 / 1024)
	local var_18_4 = var_18_3 > 0
	local var_18_5 = string.format(BootstrapLanguage.getTipsTextByKey("a10"), var_18_4 and var_18_3 or var_18_2, var_18_4 and "MB" or "KB", var_18_0 / 1024 / 1024, var_18_1 / 1024 / 1024)
	local var_18_6 = var_18_0 / var_18_1

	if var_18_6 > 0.01 and not arg_18_0._isSendEHotUpdateDownloadProgress1 then
		local var_18_7 = os.time() - arg_18_0._startHotUpdateDowntime

		forcePrint("热更新下载进度1 需要时间秒=", var_18_7)

		arg_18_0._sensorsTrackPara.colA = BootstrapConstdef.getHotUpdateDownloadTimeStr(var_18_7)
		arg_18_0._isSendEHotUpdateDownloadProgress1 = true

		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EHotUpdateDownloadProgress1, {
			fileName = "",
			fileSize = "",
			totalSize = tostring(arg_18_0._totalBytesToReceive),
			totalSecond = tostring(var_18_7)
		})
	end

	if var_18_6 > 0.05 and not arg_18_0._isSendEHotUpdateDownloadProgress5 then
		arg_18_0._isSendEHotUpdateDownloadProgress5 = true

		local var_18_8 = os.time() - arg_18_0._startHotUpdateDowntime

		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EHotUpdateDownloadProgress5, {
			fileName = "",
			fileSize = "",
			totalSize = tostring(arg_18_0._totalBytesToReceive),
			totalSecond = tostring(var_18_8)
		})
	end

	if var_18_6 > 0.1 and not arg_18_0._isSendEHotUpdateDownloadProgress10 then
		local var_18_9 = os.time() - arg_18_0._startHotUpdateDowntime

		forcePrint("热更新下载进度10 需要时间秒=", var_18_9)

		arg_18_0._sensorsTrackPara.colA = BootstrapConstdef.getHotUpdateDownloadTimeStr(var_18_9)
		arg_18_0._isSendEHotUpdateDownloadProgress10 = true

		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EHotUpdateDownloadProgress10, {
			fileName = "",
			fileSize = "",
			totalSize = tostring(arg_18_0._totalBytesToReceive),
			totalSecond = tostring(var_18_9)
		})
	end

	if var_18_6 > 0.2 and not arg_18_0._isSendEHotUpdateDownloadProgress20 then
		local var_18_10 = os.time() - arg_18_0._startHotUpdateDowntime

		forcePrint("热更新下载进度20 需要时间秒=", var_18_10)

		arg_18_0._sensorsTrackPara.colA = BootstrapConstdef.getHotUpdateDownloadTimeStr(var_18_10)
		arg_18_0._isSendEHotUpdateDownloadProgress20 = true

		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EHotUpdateDownloadProgress20, {
			fileName = "",
			fileSize = "",
			totalSize = tostring(arg_18_0._totalBytesToReceive),
			totalSecond = tostring(var_18_10)
		})
	end

	if var_18_6 > 0.3 and not arg_18_0._isSendEHotUpdateDownloadProgress30 then
		local var_18_11 = os.time() - arg_18_0._startHotUpdateDowntime

		forcePrint("热更新下载进度30 需要时间秒=", var_18_11)

		arg_18_0._isSendEHotUpdateDownloadProgress30 = true

		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EHotUpdateDownloadProgress30, {
			fileName = "",
			fileSize = "",
			totalSize = tostring(arg_18_0._totalBytesToReceive),
			totalSecond = tostring(var_18_11)
		})
	end

	if var_18_6 > 0.5 and not arg_18_0._isSendEHotUpdateDownloadProgress50 then
		local var_18_12 = os.time() - arg_18_0._startHotUpdateDowntime

		forcePrint("热更新下载进度50 需要时间秒=", var_18_12)

		arg_18_0._sensorsTrackPara.colA = BootstrapConstdef.getHotUpdateDownloadTimeStr(var_18_12)
		arg_18_0._isSendEHotUpdateDownloadProgress50 = true

		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EHotUpdateDownloadProgress50, {
			fileName = "",
			fileSize = "",
			totalSize = tostring(arg_18_0._totalBytesToReceive),
			totalSecond = tostring(var_18_12)
		})
	end

	if var_18_6 > 0.75 and not arg_18_0._isSendEHotUpdateDownloadProgress75 then
		local var_18_13 = os.time() - arg_18_0._startHotUpdateDowntime

		forcePrint("热更新下载进度75 需要时间秒=", var_18_13)

		arg_18_0._sensorsTrackPara.colA = BootstrapConstdef.getHotUpdateDownloadTimeStr(var_18_13)
		arg_18_0._isSendEHotUpdateDownloadProgress75 = true

		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EHotUpdateDownloadProgress75, {
			fileName = "",
			fileSize = "",
			totalSize = tostring(arg_18_0._totalBytesToReceive),
			totalSecond = tostring(var_18_13)
		})
	end

	if var_18_6 > 0.95 and not arg_18_0._isSendEHotUpdateDownloadProgress100 then
		local var_18_14 = os.time() - arg_18_0._startHotUpdateDowntime

		forcePrint("热更新下载进度95 需要时间秒=", var_18_14)

		arg_18_0._sensorsTrackPara.colA = BootstrapConstdef.getHotUpdateDownloadTimeStr(var_18_14)
		arg_18_0._isSendEHotUpdateDownloadProgress100 = true

		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EHotUpdateDownloadProgress100, {
			fileName = "",
			fileSize = "",
			totalSize = tostring(arg_18_0._totalBytesToReceive),
			totalSecond = tostring(var_18_14)
		})
	end

	local var_18_15 = math.round(var_18_6 * 10000) / 100
	local var_18_16 = math.min(var_18_15, 100)

	arg_18_0:showUITipByState(BootstrapConstdef.EBootstrapState.HotUpdateDownloadProgress, var_18_5, var_18_16)

	arg_18_0._currentReceivedBytes = var_18_0

	arg_18_0:syncViewData()
end

function var_0_0.onHotUpdateDownloadFail(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	if arg_19_0._countHotUpdateDownloadFail == BootstrapConst.kHotUpdateDownloadFailResetCount then
		Astral.GameUpdateMgr.Instance:SetDownloadFromSourceResServer()

		arg_19_0._isDownloadFromSourceResServer = true
		arg_19_0._countHotUpdateDownloadFail = 0
	else
		arg_19_0._countHotUpdateDownloadFail = arg_19_0._countHotUpdateDownloadFail + 1
	end

	arg_19_0:showUITipByState(BootstrapConstdef.EBootstrapState.HotUpdateDownloadFail, arg_19_1, arg_19_2)

	local var_19_0 = os.time() - arg_19_0._startHotUpdateDowntime
	local var_19_1 = (os.clock() - arg_19_0._startHotUpdateDownClock) * 1000
	local var_19_2 = arg_19_0._currentReceivedBytes / arg_19_0._totalBytesToReceive * 100

	BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EStartHotUpdateIpFail, {
		totalSize = tostring(arg_19_0._totalBytesToReceive),
		totalSecond = tostring(var_19_0),
		progressRate = tostring(var_19_2),
		fileName = tostring(arg_19_1),
		fileSize = tostring(0)
	})

	local var_19_3 = BootstrapHelper.getGameId()
	local var_19_4 = arg_19_0._isDownloadFromSourceResServer and Astral.VersionMgr.Instance.projectManifestInfo.packageUrl_backup or Astral.VersionMgr.Instance.projectManifestInfo.packageUrl
	local var_19_5 = string.format("%s/%s", var_19_4, Astral.VersionMgr.Instance.projectManifestInfo.assets)

	Netkit.trackPatchData(arg_19_0._totalBytesToReceive, Netkit.EventId.PatchFail[1], Netkit.EventId.PatchFail[2], var_19_3, var_19_5, var_19_1, arg_19_0._startHotUpdateDowntime * 1000)
end

function var_0_0.onDiskSpaceInsufficient(arg_20_0)
	arg_20_0:showUITipByState(BootstrapConstdef.EBootstrapState.DiskSpaceInsufficient)
	BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EDiskSpaceInsufficient)
end

function var_0_0.onHotUpdateAllDownloadSuccess(arg_21_0)
	arg_21_0:showUITipByState(BootstrapConstdef.EBootstrapState.HotUpdateAllDownloadSuccess)

	local var_21_0 = os.time() - arg_21_0._startHotUpdateDowntime
	local var_21_1 = (os.clock() - arg_21_0._startHotUpdateDownClock) * 1000

	if not arg_21_0._isSendEHotUpdateDownloadProgress100 then
		arg_21_0._isSendEHotUpdateDownloadProgress100 = true

		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EHotUpdateDownloadProgress100, {
			fileName = "",
			fileSize = "",
			totalSize = tostring(arg_21_0._totalBytesToReceive),
			totalSecond = tostring(var_21_0)
		})
	end

	local var_21_2 = BootstrapHelper.getGameId()
	local var_21_3 = arg_21_0._isDownloadFromSourceResServer and Astral.VersionMgr.Instance.projectManifestInfo.packageUrl_backup or Astral.VersionMgr.Instance.projectManifestInfo.packageUrl
	local var_21_4 = string.format("%s/%s", var_21_3, Astral.VersionMgr.Instance.projectManifestInfo.assets[0].path)

	Netkit.trackPatchData(arg_21_0._totalBytesToReceive, Netkit.EventId.Patch[1], Netkit.EventId.Patch[2], var_21_2, var_21_4, var_21_1, arg_21_0._startHotUpdateDowntime * 1000)
end

function var_0_0.onStartUnzipNotify(arg_22_0)
	BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EStartHotUpdateUnzip)
	arg_22_0:showUITipByState(BootstrapConstdef.EBootstrapState.StartUnzipNotify)
end

function var_0_0.onUnzipProgress(arg_23_0, arg_23_1)
	if BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.UnzipFail or BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.DiskSpaceInsufficient then
		return
	end

	if tostring(arg_23_1) ~= "nan" then
		local var_23_0 = math.round(arg_23_1 * 10000) / 100
		local var_23_1 = math.min(var_23_0, 100)
		local var_23_2 = string.format(BootstrapLanguage.getTipsTextByKey("a11"), var_23_1)

		arg_23_0:showUITipByState(BootstrapConstdef.EBootstrapState.UnzipProgress, var_23_2, var_23_1)
	end
end

function var_0_0.onUnzipSuccess(arg_24_0)
	BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EStartHotUpdateUnzipSuccess)
	arg_24_0:showUITipByState(BootstrapConstdef.EBootstrapState.UnzipSuccess)
end

function var_0_0.onUnzipFail(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0:showUITipByState(BootstrapConstdef.EBootstrapState.UnzipFail, arg_25_1)
end

return var_0_0
