pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.FileDownloadMgr = var_0_10001("FileDownloadMgr")

local var_0_1 = var_0.FileDownloadMgr

FileDownloadConst = var_2

function var_0_1.Init(arg_1_0, arg_1_1)
	print = var_1_10002

	var_1_10002("initializing filedownloadmgr manager...")

	LoadAndInstantiateAsync = var_1_10002

	var_1_10002("ui", "FileDownloadUI", function(arg_2_0)
		arg_1_0._go = arg_2_0

		local var_2_0 = arg_1_0._go

		var_1.SetActive(var_2_0, false)

		arg_1_0._tf = arg_1_0._go.transform

		local var_2_1 = arg_1_0._tf

		var_1.SetParent(var_2_1, var_0.UIMgr.GetInstance().OverlayMain, false)

		local var_2_2 = arg_1_0

		var_1.initUI(var_2_2)

		local var_2_3 = arg_1_0

		var_1.initUITextTips(var_2_3)
		arg_1_1()

		return
	end, true, true)

	return
end

function var_0_1.Main(arg_3_0, arg_3_1)
	arg_3_0:initData()
	arg_3_0:setData(arg_3_1)
	arg_3_0:startDownload()

	return
end

function var_0_1.IsRunning(arg_4_0)
	isActive = var_1_10001

	return var_1_10001(arg_4_0._go)
end

var_0_1.KEY_STOP_REMIND = "File_Download_Remind_Time"

function var_0_1.SetRemind(arg_5_0, arg_5_1)
	arg_5_0.isStopRemind = arg_5_1

	return
end

function var_0_1.IsNeedRemind(arg_6_0)
	if arg_6_0.isStopRemind == true then
		return false
	else
		return true
	end

	return
end

function var_0_1.show(arg_7_0)
	local var_7_0 = arg_7_0._go

	var_1.SetActive(var_7_0, true)

	return
end

function var_0_1.hide(arg_8_0)
	local var_8_0 = arg_8_0._go

	var_1.SetActive(var_8_0, false)

	return
end

function var_0_1.initUI(arg_9_0)
	local var_9_0 = arg_9_0._tf

	arg_9_0.mainTF = var_1.Find(var_9_0, "Main")

	local var_9_1 = arg_9_0.mainTF

	arg_9_0.titleText = var_1.Find(var_9_1, "Title")

	local var_9_2 = arg_9_0.mainTF

	arg_9_0.progressText = var_1.Find(var_9_2, "ProgressText")

	local var_9_3 = arg_9_0.mainTF

	arg_9_0.progressBar = var_1.Find(var_9_3, "ProgressBar")

	return
end

function var_0_1.initUITextTips(arg_10_0)
	setText = var_1_10001

	local var_10_0 = arg_10_0.titleText

	i18n = var_1_10003

	var_1_10001(var_10_0, var_1_10003("file_down_mgr_title"))

	return
end

function var_0_1.initData(arg_11_0)
	arg_11_0.curGroupIndex = 0
	arg_11_0.curGroupMgr = nil
	arg_11_0.dataList = nil
	arg_11_0.onFinish = nil

	return
end

function var_0_1.setData(arg_12_0, arg_12_1)
	arg_12_0.dataList = arg_12_1.dataList
	arg_12_0.onFinish = arg_12_1.onFinish

	return
end

function var_0_1.fileProgress(arg_13_0, arg_13_1, arg_13_2)
	HashUtil = var_1_10003

	local var_13_0 = var_1_10003.BytesToString(arg_13_1)

	HashUtil = var_4

	local var_13_1 = var_4.BytesToString(arg_13_2)

	setText = var_5

	local var_13_2 = arg_13_0.progressText

	i18n = var_1_10007

	var_5(var_13_2, var_1_10007("file_down_mgr_progress", var_13_0, var_13_1))

	setSlider = var_5

	local var_13_3 = arg_13_0.progressBar
	local var_13_4 = 0

	tonumber = var_8
	tostring = var_9

	local var_13_5 = var_8(var_9(arg_13_2))

	tonumber = var_9
	tostring = var_10

	var_5(var_13_3, var_13_4, var_13_5, var_9(var_10(arg_13_1)))

	return
end

function var_0_1.allComplete(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0.onFinish then
		arg_14_0.onFinish()
	end

	arg_14_0:initData()
	arg_14_0:hide()

	return
end

function var_0_1.error(arg_15_0, arg_15_1, arg_15_2)
	local function var_15_0()
		local var_16_0 = arg_15_0

		var_0.startDownload(var_16_0)

		return
	end

	local function var_15_1()
		Application = var_2_10000

		var_2_10000.Quit()

		return
	end

	arg_15_0:hide()

	local var_15_2 = var_0.MsgboxMgr.GetInstance()
	local var_15_3 = var_5.ShowMsgBox
	local var_15_4 = {
		modal = true,
		locked = true
	}

	i18n = var_1_10008
	var_15_4.content = var_1_10008("file_down_mgr_error", arg_15_1, arg_15_2)
	var_15_4.onYes = var_15_0
	var_15_4.onNo = var_15_1
	var_15_4.onClose = var_15_1

	var_15_3(var_15_2, var_15_4)

	return
end

function var_0_1.download(arg_18_0)
	local function var_18_0(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5)
		local var_19_0 = arg_18_0

		var_6.fileProgress(var_19_0, arg_19_3, arg_19_4)

		return
	end

	local function var_18_1(arg_20_0, arg_20_1)
		if arg_20_0 then
			local var_20_0 = arg_18_0

			var_2.allComplete(var_20_0)
		else
			local var_20_1 = arg_18_0

			var_2.error(var_20_1, "", "")
		end

		return
	end

	BundleWizardUpdater = var_1_10003

	local var_18_2 = var_1_10003.Inst

	var_3.StartUpdate(var_18_2, arg_18_0.info, nil, var_18_1, var_18_0)

	return
end

function var_0_1.startDownload(arg_21_0)
	if arg_21_0:verifyValidData() then
		arg_21_0:show()
		arg_21_0:download()
	else
		arg_21_0:allComplete()
	end

	return
end

function var_0_1.verifyValidData(arg_22_0)
	arg_22_0.info = var_0_1.createDownloadFileInfo(arg_22_0.dataList)
	BundleWizardUpdater = var_1

	local var_22_0 = var_1.Inst

	return var_1.GetFileList(var_22_0, arg_22_0.info).Count > 0
end

function var_0_1.createDownloadFileInfo(arg_23_0)
	BundleWizardUpdateInfo = var_1_10001

	local var_23_0 = var_1_10001.New()
	local var_23_1 = {}

	ipairs = var_1_10003

	for iter_23_0, iter_23_1 in var_1_10003(arg_23_0) do
		var_23_0:AddGroup(iter_23_1.groupName, iter_23_1.fileNameList)

		table = var_8

		var_8.insert(var_23_1, iter_23_1.groupName)
	end

	table = var_3
	var_23_0.infoName = var_3.concat(var_23_1, "_")

	return var_23_0
end

return
