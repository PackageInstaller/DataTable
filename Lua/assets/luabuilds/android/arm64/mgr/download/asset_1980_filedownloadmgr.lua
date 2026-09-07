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

function pg.FileDownloadMgr:Main(arg_3_1)
	self:initData()
	self:setData(arg_3_1)
	self:startDownload()

	return
end

function pg.FileDownloadMgr:IsRunning()
	return isActive(self._go)
end

pg.FileDownloadMgr.KEY_STOP_REMIND = "File_Download_Remind_Time"

function pg.FileDownloadMgr.SetRemind(arg_5_0, arg_5_1)
	arg_5_0.isStopRemind = arg_5_1

	return
end

function pg.FileDownloadMgr:IsNeedRemind()
	if self.isStopRemind == true then
		return false
	else
		return true
	end

	return
end

function pg.FileDownloadMgr:show()
	self._go:SetActive(true)

	return
end

function pg.FileDownloadMgr:hide()
	self._go:SetActive(false)

	return
end

function pg.FileDownloadMgr:initUI()
	self.mainTF = self._tf:Find("Main")
	self.titleText = self.mainTF:Find("Title")
	self.progressText = self.mainTF:Find("ProgressText")
	self.progressBar = self.mainTF:Find("ProgressBar")

	return
end

function pg.FileDownloadMgr:initUITextTips()
	setText(self.titleText, i18n("file_down_mgr_title"))

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

function pg.FileDownloadMgr:fileProgress(arg_13_1, arg_13_2)
	setText(self.progressText, i18n("file_down_mgr_progress", HashUtil.BytesToString(arg_13_1), (HashUtil.BytesToString(arg_13_2))))
	setSlider(self.progressBar, 0, tonumber(tostring(arg_13_2)), tonumber(tostring(arg_13_1)))

	return
end

function pg.FileDownloadMgr:allComplete(arg_14_1, arg_14_2)
	if self.onFinish then
		self.onFinish()
	end

	self:initData()
	self:hide()

	return
end

function pg.FileDownloadMgr:error(arg_15_1, arg_15_2)
	local function var_15_0()
		Application.Quit()

		return
	end

	self:hide()
	var_0_0.MsgboxMgr.GetInstance():ShowMsgBox({
		modal = true,
		locked = true,
		content = i18n("file_down_mgr_error", arg_15_1, arg_15_2),
		onYes = function()
			self:startDownload()

			return
		end,
		onNo = var_15_0,
		onClose = var_15_0
	})

	return
end

function pg.FileDownloadMgr:download()
	BundleWizardUpdater.Inst:StartUpdate(self.info, nil, function(arg_20_0, arg_20_1)
		if arg_20_0 then
			self:allComplete()
		else
			self:error("", "")
		end

		return
	end, function(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5)
		self:fileProgress(arg_19_3, arg_19_4)

		return
	end)

	return
end

function pg.FileDownloadMgr:startDownload()
	if self:verifyValidData() then
		self:show()
		self:download()
	else
		self:allComplete()
	end

	return
end

function pg.FileDownloadMgr:verifyValidData()
	self.info = var_0_1.createDownloadFileInfo(self.dataList)

	return BundleWizardUpdater.Inst:GetFileList(self.info).Count > 0
end

function pg.FileDownloadMgr.createDownloadFileInfo(arg_23_0)
	local var_23_0 = BundleWizardUpdateInfo.New()
	local var_23_1 = {}

	for iter_23_0, iter_23_1 in ipairs(arg_23_0) do
		var_23_0:AddGroup(iter_23_1.groupName, iter_23_1.fileNameList)
		table.insert(var_23_1, iter_23_1.groupName)
	end

	var_23_0.infoName = table.concat(var_23_1, "_")

	return var_23_0
end

return
