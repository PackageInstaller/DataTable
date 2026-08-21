module("bootstrap.view.BootstrapViewLogic", package.seeall)

local var_0_0 = class("BootstrapViewLogic")

function var_0_0.ctor(arg_1_0)
	arg_1_0._currentReceivedBytes = 0
	arg_1_0._totalBytesToReceive = 0
	arg_1_0.helper = Astral.GameUpdateHelper.Instance
end

function var_0_0.setCurReceivedBytes(arg_2_0, arg_2_1)
	arg_2_0._currentReceivedBytes = arg_2_1
end

function var_0_0.setTotalBytesToReceive(arg_3_0, arg_3_1)
	arg_3_0._totalBytesToReceive = arg_3_1
end

function var_0_0.onMsgBoxOkBtnClick(arg_4_0)
	if BootstrapConstdef.CurBootstrapState ~= BootstrapConstdef.EBootstrapState.NeedPackageUpdate then
		BootstrapMsgBoxView.show(false)
	end

	if BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.LoadUIPrefabError then
		-- block empty
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.GetGameConfig then
		-- block empty
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.GetGameConfigError then
		BootstrapGameConfigMgr.reqGameConfig()
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.GetGameConfigSuccess then
		-- block empty
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.NeedToStartHotUpdate then
		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EStartHotUpdate, {
			totalSize = tostring(1),
			autoDownload = tostring(NetworkUtils.GetCurrentNetworkType() == 2)
		})
		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EStartHotUpdateIp)

		arg_4_0._startHotUpdateDowntime = os.time()
		arg_4_0._isSendEHotUpdateDownloadProgress1 = false
		arg_4_0._isSendEHotUpdateDownloadProgress10 = false
		arg_4_0._isSendEHotUpdateDownloadProgress25 = false
		arg_4_0._isSendEHotUpdateDownloadProgress50 = false
		arg_4_0._isSendEHotUpdateDownloadProgress80 = false
		arg_4_0._isSendEHotUpdateDownloadProgress100 = false

		arg_4_0.helper:DoNext()
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.NeedPackageUpdate then
		local var_4_0 = 0
		local var_4_1 = 0

		if Astral.OSDef.RunOS == Astral.OSDef.Android then
			var_4_0 = BootstrapUtil.getPlatformId()
			var_4_1 = tonumber(BootstrapUtil.getDevJson().channelId)
		end

		if var_4_0 == 2 and var_4_1 == 140002 then
			local var_4_2 = "taptap://taptap.com/app?app_id=133555&source=outer|update"
			local var_4_3 = "https://www.taptap.com/app/133555"

			BootstrapUtil.openMobileApp(var_4_2, var_4_3)
		else
			forcePrint("整包更新地址：", arg_4_0._urlNeedPackageUpdate)
			BootstrapUtil.showWebBrowser(arg_4_0._urlNeedPackageUpdate)
		end
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.RequestRemoteVersionFail then
		arg_4_0.helper:DoNext()
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.RequestRemoteProjectManifestFail then
		arg_4_0.helper:DoNext()
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.HotUpdateDownloadFail then
		arg_4_0:showUITipByState(BootstrapConstdef.EBootstrapState.HotUpdateDownloadBeginning)
		arg_4_0.helper:DoNext()
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.UnzipFail then
		arg_4_0:showUITipByState(BootstrapConstdef.EBootstrapState.StartUnzipNotify)
		arg_4_0.helper:DoNext()
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.SDKInitFail then
		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EExecSDKInitFailAndRetry)
		BootstrapUtil.sdkInit(true)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.DiskSpaceInsufficient then
		arg_4_0:applicationQuit()
	end
end

function var_0_0.onMsgBoxCancelBtnClick(arg_5_0)
	BootstrapMsgBoxView.show(false)

	if BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.LoadUIPrefabError then
		-- block empty
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.GetGameConfig then
		-- block empty
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.GetGameConfigError then
		arg_5_0:applicationQuit()
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.GetGameConfigSuccess then
		-- block empty
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.NeedToStartHotUpdate then
		arg_5_0:applicationQuit()
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.NeedPackageUpdate then
		arg_5_0:applicationQuit()
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.RequestRemoteVersionFail then
		arg_5_0:applicationQuit()
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.RequestRemoteProjectManifestFail then
		arg_5_0:applicationQuit()
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.HotUpdateDownloadFail then
		arg_5_0:applicationQuit()
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.UnzipFail then
		arg_5_0:applicationQuit()
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.SDKInitFail then
		arg_5_0:applicationQuit()
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.DiskSpaceInsufficient then
		arg_5_0:applicationQuit()
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.ObbDownload then
		arg_5_0:applicationQuit()
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.ObbDownloadFail then
		arg_5_0:applicationQuit()
	end
end

function var_0_0.showUITipByState(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	BootstrapConstdef.CurBootstrapState = arg_6_1

	if BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.LoadUIPrefabError then
		BootstrapMsgBoxView.TxtVersionContent.text = BootstrapLanguage.getTipsTextByKey("a4")
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.GetGameConfig then
		BootstrapLoadingView.showPersent(false)
		BootstrapLoadingView.setPersentVal(0)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.GetGameConfigError then
		BootstrapLoadingView.showPersent(false)
		BootstrapLoadingView.setTxtContent("")
		BootstrapMsgBoxView.setBtnTxt(BootstrapLanguage.getTipsTextByKey("retry"), BootstrapLanguage.getTipsTextByKey("cancel"))
		BootstrapMsgBoxView.setTxtContent(BootstrapLanguage.getTipsTextByKey("a5"))
		BootstrapMsgBoxView.show(true)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.GetGameConfigSuccess then
		-- block empty
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.StartHotUpdate then
		-- block empty
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.BussLuaBundlesDone then
		BootstrapLoadingView.showPersent(not BootstrapLoadingView.isUseProgressEffect)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.HotUpdateDownloadProgress then
		BootstrapLoadingView.setTxtContent(arg_6_2)
		BootstrapLoadingView.showPersent(true)
		BootstrapLoadingView.setPersentVal(arg_6_3)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.HotUpdateDownloadBeginning then
		-- block empty
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.UnzipProgress then
		BootstrapLoadingView.setTxtContent(arg_6_2)
		BootstrapLoadingView.showPersent(true)
		BootstrapLoadingView.setPersentVal(arg_6_3)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.UnzipSuccess then
		BootstrapLoadingView.setTxtContent(BootstrapLanguage.getTipsTextByKey("a12"))
		BootstrapLoadingView.showPersent(false)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.HotUpdateComplete then
		BootstrapLoadingView.showPersent(false)
		BootstrapLoadingView.setPersentVal(0)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.NeedToStartHotUpdate then
		BootstrapLoadingView.setTxtContent("")
		BootstrapMsgBoxView.setBtnTxt(BootstrapLanguage.getTipsTextByKey("sure"), BootstrapLanguage.getTipsTextByKey("cancel"))

		local var_6_0 = (arg_6_0._totalBytesToReceive - arg_6_0._currentReceivedBytes) / 1024 / 1024
		local var_6_1

		if var_6_0 < 1 then
			var_6_0 = (arg_6_0._totalBytesToReceive - arg_6_0._currentReceivedBytes) / 1024
			var_6_1 = string.format("%dKB", var_6_0)
		else
			var_6_1 = string.format("%dMB", var_6_0)
		end

		if NetworkUtils.GetCurrentNetworkType() == BootstrapConst.NETWORK_TYPE.WIFI then
			arg_6_0:onMsgBoxOkBtnClick()
		else
			BootstrapMsgBoxView.setTxtContent(string.format(BootstrapLanguage.getTipsTextByKey("a2"), var_6_1))
			BootstrapMsgBoxView.show(true)
		end
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.NeedPackageUpdate then
		BootstrapLoadingView.setTxtContent("")
		BootstrapMsgBoxView.setBtnTxt(BootstrapLanguage.getTipsTextByKey("sure"), BootstrapLanguage.getTipsTextByKey("cancel"))
		BootstrapMsgBoxView.setTxtContent(BootstrapLanguage.getTipsTextByKey("a1"))
		BootstrapMsgBoxView.show(true)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.StartUnzipNotify then
		BootstrapLoadingView.setTxtContent(BootstrapLanguage.getTipsTextByKey("a14"))
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.HotUpdateAllDownloadSuccess then
		BootstrapLoadingView.setTxtContent(BootstrapLanguage.getTipsTextByKey("a15"))
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.RequestRemoteVersionSuccess then
		-- block empty
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.RequestRemoteProjectManifestSuccess then
		-- block empty
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.RequestRemoteVersionFail then
		BootstrapLoadingView.setTxtContent("")
		BootstrapMsgBoxView.setBtnTxt(BootstrapLanguage.getTipsTextByKey("sure"), BootstrapLanguage.getTipsTextByKey("cancel"))
		BootstrapMsgBoxView.setTxtContent(BootstrapLanguage.getTipsTextByKey("a18"))
		BootstrapMsgBoxView.show(true)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.RequestRemoteProjectManifestFail then
		BootstrapLoadingView.setTxtContent("")
		BootstrapMsgBoxView.setBtnTxt(BootstrapLanguage.getTipsTextByKey("sure"), BootstrapLanguage.getTipsTextByKey("cancel"))
		BootstrapMsgBoxView.setTxtContent(BootstrapLanguage.getTipsTextByKey("a18"))
		BootstrapMsgBoxView.show(true)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.HotUpdateDownloadFail then
		BootstrapLoadingView.setTxtContent("")
		BootstrapMsgBoxView.setBtnTxt(BootstrapLanguage.getTipsTextByKey("sure"), BootstrapLanguage.getTipsTextByKey("cancel"))

		local var_6_2 = BootstrapLanguage.getTipsTextByKey("a19")

		if arg_6_3 == Astral.DownloadError.NetworkDisconnect then
			var_6_2 = BootstrapLanguage.getTipsTextByKey("a23")
		elseif arg_6_3 == Astral.DownloadError.NotFound then
			var_6_2 = BootstrapLanguage.getTipsTextByKey("a24")
		elseif arg_6_3 == Astral.DownloadError.ServerMaintenance then
			var_6_2 = BootstrapLanguage.getTipsTextByKey("a23")
		elseif arg_6_3 == Astral.DownloadError.DiskFull then
			var_6_2 = BootstrapLanguage.getTipsTextByKey("a26")
		elseif arg_6_3 == Astral.DownloadError.Timeout then
			var_6_2 = BootstrapLanguage.getTipsTextByKey("a27")
		end

		BootstrapMsgBoxView.setTxtContent(var_6_2)
		BootstrapMsgBoxView.show(true)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.UnzipFail then
		BootstrapLoadingView.setTxtContent("")
		BootstrapMsgBoxView.setBtnTxt(BootstrapLanguage.getTipsTextByKey("sure"), BootstrapLanguage.getTipsTextByKey("cancel"))

		local var_6_3 = BootstrapLanguage.getTipsTextByKey("a20")

		if arg_6_2 == Astral.DownloadError.NetworkDisconnect then
			var_6_3 = BootstrapLanguage.getTipsTextByKey("a28")
		elseif arg_6_2 == Astral.DownloadError.NotFound then
			var_6_3 = BootstrapLanguage.getTipsTextByKey("a29")
		elseif arg_6_2 == Astral.DownloadError.ServerMaintenance then
			var_6_3 = BootstrapLanguage.getTipsTextByKey("a30")
		elseif arg_6_2 == Astral.DownloadError.DiskFull then
			var_6_3 = BootstrapLanguage.getTipsTextByKey("a31")
		elseif arg_6_2 == Astral.DownloadError.Timeout then
			var_6_3 = BootstrapLanguage.getTipsTextByKey("a32")
		end

		BootstrapMsgBoxView.setTxtContent(var_6_3)
		BootstrapMsgBoxView.show(true)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.SDKInitFail then
		BootstrapLoadingView.setTxtContent("")
		BootstrapMsgBoxView.setBtnTxt(BootstrapLanguage.getTipsTextByKey("sure"), BootstrapLanguage.getTipsTextByKey("cancel"))
		BootstrapMsgBoxView.setTxtContent(BootstrapLanguage.getTipsTextByKey("a21"))
		BootstrapMsgBoxView.show(true)

		if arg_6_2 then
			printError(BootstrapLanguage.getTipsTextByKey("a21") .. arg_6_2)
		end
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.DiskSpaceInsufficient then
		BootstrapLoadingView.setTxtContent("")
		BootstrapMsgBoxView.setBtnTxt(BootstrapLanguage.getTipsTextByKey("sure"), BootstrapLanguage.getTipsTextByKey("cancel"))
		BootstrapMsgBoxView.setTxtContent(BootstrapLanguage.getTipsTextByKey("a33"))
		BootstrapMsgBoxView.show(true)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.ObbDownload then
		print("BootstrapConstdef.EBootstrapState.ObbDownload")
		BootstrapLoadingView.showPersent(false)
		BootstrapLoadingView.setTxtContent("")
		BootstrapMsgBoxView.setBtnTxt(BootstrapLanguage.getTipsTextByKey("confirm"), BootstrapLanguage.getTipsTextByKey("cancel"))
		BootstrapMsgBoxView.setTxtContent(arg_6_2)
		BootstrapMsgBoxView.show(true, BootstrapMsgBoxView.KEY_OBBDOWNLOAD)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.ObbDownloadFail then
		print("BootstrapConstdef.EBootstrapState.ObbDownloadFail")
		BootstrapLoadingView.showPersent(false)
		BootstrapLoadingView.setTxtContent("")
		BootstrapMsgBoxView.setBtnTxt(BootstrapLanguage.getTipsTextByKey("retry"), BootstrapLanguage.getTipsTextByKey("cancel"))
		BootstrapMsgBoxView.setTxtContent(BootstrapLanguage.getTipsTextByKey("a36"))
		BootstrapMsgBoxView.show(true, BootstrapMsgBoxView.KEY_OBBDOWNLOAD)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.ObbDownloadBegin then
		print("BootstrapConstdef.EBootstrapState.ObbDownloadBegin")
		BootstrapLoadingView.showPersent(false)
		BootstrapLoadingView.setTxtContent(BootstrapLanguage.getTipsTextByKey("a37"))
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.ObbDownloadProcess then
		print("BootstrapConstdef.EBootstrapState.ObbDownloadProcess")
		BootstrapLoadingView.setTxtContent(string.format(BootstrapLanguage.getTipsTextByKey("a38"), arg_6_2))
		BootstrapLoadingView.showPersent(true)
		BootstrapLoadingView.setPersentVal(arg_6_3)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.ObbDownloadComplete then
		print("BootstrapConstdef.EBootstrapState.ObbDownloadComplete")
		BootstrapLoadingView.showPersent(false)
		BootstrapLoadingView.setTxtContent(BootstrapLanguage.getTipsTextByKey("a39"))
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.ObbVerificationBegin then
		print("BootstrapConstdef.EBootstrapState.ObbVerificationBegin")
		BootstrapLoadingView.showPersent(false)
		BootstrapLoadingView.setTxtContent(BootstrapLanguage.getTipsTextByKey("a40"))
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.ObbVerificationProcess then
		print("BootstrapConstdef.EBootstrapState.ObbVerificationProcess")
		BootstrapLoadingView.setTxtContent(string.format(BootstrapLanguage.getTipsTextByKey("a41"), arg_6_3))
		BootstrapLoadingView.showPersent(true)
		BootstrapLoadingView.setPersentVal(arg_6_3)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.ObbVerificationComplete then
		print("BootstrapConstdef.EBootstrapState.ObbVerificationComplete")
		BootstrapLoadingView.showPersent(false)
		BootstrapLoadingView.setTxtContent(BootstrapLanguage.getTipsTextByKey("a42"))
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.ObbDecompressionBegin then
		print("BootstrapConstdef.EBootstrapState.ObbDecompressionBegin")
		BootstrapLoadingView.showPersent(false)
		BootstrapLoadingView.setTxtContent(BootstrapLanguage.getTipsTextByKey("a43"))
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.ObbDecompressionProcess then
		print("BootstrapConstdef.EBootstrapState.ObbDecompressionProcess")
		BootstrapLoadingView.setTxtContent(string.format(BootstrapLanguage.getTipsTextByKey("a44"), arg_6_3))
		BootstrapLoadingView.showPersent(true)
		BootstrapLoadingView.setPersentVal(arg_6_3)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.ObbDecompressionComplete then
		print("BootstrapConstdef.EBootstrapState.ObbDecompressionComplete")
		BootstrapLoadingView.showPersent(false)
		BootstrapLoadingView.setTxtContent(BootstrapLanguage.getTipsTextByKey("a45"))
	end
end

function var_0_0.applicationQuit(arg_7_0)
	SystemUtil.Quit()
end

var_0_0.instance = var_0_0.New()

return var_0_0
