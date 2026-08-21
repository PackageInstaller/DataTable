pg = pg or {}

local var_0_0 = pg

pg.FileDownloadMgr = singletonClass("FileDownloadMgr")

local var_0_1 = pg.FileDownloadMgr

function pg.FileDownloadMgr.Init(arg_1_0, arg_1_1)
	print("initializing filedownloadmgr manager...")
	LoadAndInstantiateAsync("ui", "FileDownloadUI", function(arg_2_0)
		arg_1_0._go = arg_2_0

		arg_1_0._go:SetActive(false)

		arg_1_0._tf = arg_1_0._go.transform

		arg_1_0._tf:SetParent(var_0_0.UIMgr.GetInstance().OverlayMain, false)
		arg_1_0:initUI()
		arg_1_0:initUITextTips()
		arg_1_1()

		return
	end, true, true)

	return
end

function pg.FileDownloadMgr.Main(arg_3_0, arg_3_1)
	arg_3_0:initData()
	arg_3_0:setData(arg_3_1)
	arg_3_0:startDownload()

	return
end

function pg.FileDownloadMgr.IsRunning(arg_4_0)
	return isActive(arg_4_0._go)
end

pg.FileDownloadMgr.KEY_STOP_REMIND = "File_Download_Remind_Time"

function pg.FileDownloadMgr.SetRemind(arg_5_0, arg_5_1)
	arg_5_0.isStopRemind = arg_5_1

	return
end

function pg.FileDownloadMgr.IsNeedRemind(arg_6_0)
	if arg_6_0.isStopRemind == true then
		return false
	else
		return true
	end

	return
end

function pg.FileDownloadMgr.show(arg_7_0)
	arg_7_0._go:SetActive(true)

	return
end

function pg.FileDownloadMgr.hide(arg_8_0)
	arg_8_0._go:SetActive(false)

	return
end

function pg.FileDownloadMgr.initUI(arg_9_0)
	arg_9_0.mainTF = arg_9_0._tf:Find("Main")
	arg_9_0.titleText = arg_9_0.mainTF:Find("Title")
	arg_9_0.progressText = arg_9_0.mainTF:Find("ProgressText")
	arg_9_0.progressBar = arg_9_0.mainTF:Find("ProgressBar")

	return
end

function pg.FileDownloadMgr.initUITextTips(arg_10_0)
	setText(arg_10_0.titleText, i18n("file_down_mgr_title"))

	return
end

function pg.FileDownloadMgr.initData(arg_11_0)
	arg_11_0.curGroupIndex = 0
	arg_11_0.curGroupMgr = nil
	arg_11_0.dataList = nil
	arg_11_0.onFinish = nil

	return
end

function pg.FileDownloadMgr.setData(arg_12_0, arg_12_1)
	arg_12_0.dataList = arg_12_1.dataList
	arg_12_0.onFinish = arg_12_1.onFinish

	return
end

function pg.FileDownloadMgr.fileProgress(arg_13_0, arg_13_1, arg_13_2)
	setText(arg_13_0.progressText, i18n("file_down_mgr_progress", HashUtil.BytesToString(arg_13_1), (HashUtil.BytesToString(arg_13_2))))
	setSlider(arg_13_0.progressBar, 0, tonumber(tostring(arg_13_2)), tonumber(tostring(arg_13_1)))

	return
end

function pg.FileDownloadMgr.allComplete(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0.onFinish then
		arg_14_0.onFinish()
	end

	arg_14_0:initData()
	arg_14_0:hide()

	return
end

function pg.FileDownloadMgr.error(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0:hide()
	var_0_0.MsgboxMgr.GetInstance():ShowMsgBox({
		modal = true,
		locked = true,
		content = i18n("file_down_mgr_error", arg_15_1, arg_15_2),
		onYes = function()
			arg_15_0:startDownload()

			return
		end,
		onNo = function()
			Application.Quit()

			return
		end,
		onClose = function()
			Application.Quit()

			return
		end
	})

	return
end

function pg.FileDownloadMgr.download(arg_18_0)
	BundleWizardUpdater.Inst:StartUpdate(arg_18_0.info, nil, function(arg_20_0, arg_20_1)
		if arg_20_0 then
			arg_18_0:allComplete()
		else
			arg_18_0:error("", "")
		end

		return
	end, function(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5)
		arg_18_0:fileProgress(arg_19_3, arg_19_4)

		return
	end)

	return
end

function pg.FileDownloadMgr.startDownload(arg_21_0)
	if arg_21_0:verifyValidData() then
		arg_21_0:show()
		arg_21_0:download()
	else
		arg_21_0:allComplete()
	end

	return
end

function pg.FileDownloadMgr.verifyValidData(arg_22_0)
	arg_22_0.info = var_0_1.createDownloadFileInfo(arg_22_0.dataList)

	return BundleWizardUpdater.Inst:GetFileList(arg_22_0.info).Count > 0
end

function pg.FileDownloadMgr.createDownloadFileInfo(arg_23_0)
	local var_23_0 = BundleWizardUpdateInfo.New()

	for iter_23_0, iter_23_1 in ipairs(arg_23_0) do
		var_23_0:AddGroup(iter_23_1.groupName, iter_23_1.fileNameList)
		table.insert({}, iter_23_1.groupName)
	end

	var_23_0.infoName = table.concat({}, "_")

	return var_23_0
end

return
