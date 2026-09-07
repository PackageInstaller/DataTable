pg = pg or {}
pg.SettingsGroupMgr = singletonClass("SettingsGroupMgr")

local var_0_0 = pg.SettingsGroupMgr

pg.SettingsGroupMgr.State = {
	Success = 3,
	Updating = 2,
	Fail = 4,
	None = 1
}

function pg.SettingsGroupMgr.Init(arg_1_0, arg_1_1)
	arg_1_0.infoDict = {}

	return
end

function pg.SettingsGroupMgr.StartDownload(arg_2_0, arg_2_1, arg_2_2)
	BundleWizardUpdater.Inst:StartUpdate((BundleWizardUpdater.Inst:CreateListInfo(arg_2_1, BundleWizardUpdater.Inst:GetFileList(arg_2_2), nil, function(arg_4_0, arg_4_1)
		arg_2_0:onFinish(arg_2_1, arg_4_0, arg_4_1)

		return
	end, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
		arg_2_0:onProgress(arg_2_1, arg_3_0, arg_3_1, arg_3_2)

		return
	end)))

	return
end

function pg.SettingsGroupMgr:GetState(arg_5_1)
	if self.infoDict[arg_5_1] == nil then
		return var_0_0.State.None
	else
		return self.infoDict[arg_5_1].state
	end

	return
end

function pg.SettingsGroupMgr:GetCountProgress(arg_6_1)
	if self.infoDict[arg_6_1] == nil then
		return 0, 0
	else
		return self.infoDict[arg_6_1].curCount, self.infoDict[arg_6_1].totalCount
	end

	return
end

function pg.SettingsGroupMgr.GetTotalSize(arg_7_0, arg_7_1)
	local var_7_0 = 0

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		var_7_0 = var_7_0 + GroupHelper.GetGroupSize(iter_7_1)
	end

	return var_7_0
end

function pg.SettingsGroupMgr:beforeStart(arg_8_1)
	local var_8_0 = self.infoDict[arg_8_1]

	if self.infoDict[arg_8_1] == nil then
		var_8_0 = {}
		self.infoDict[arg_8_1] = var_8_0
	end

	var_8_0.state = var_0_0.State.Updating

	return
end

function pg.SettingsGroupMgr:onProgress(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = self.infoDict[arg_9_1]

	if self.infoDict[arg_9_1] == nil then
		var_9_0 = {}
		self.infoDict[arg_9_1] = var_9_0
	end

	var_9_0.state = var_0_0.State.Updating
	var_9_0.successCount = arg_9_2
	var_9_0.failCount = arg_9_3
	var_9_0.totalCount = arg_9_4
	var_9_0.curCount = arg_9_2 + arg_9_3

	return
end

function pg.SettingsGroupMgr:onFinish(arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = self.infoDict[arg_10_1]

	if self.infoDict[arg_10_1] == nil then
		var_10_0 = {}
		self.infoDict[arg_10_1] = var_10_0
	end

	var_10_0.state = arg_10_2 and var_0_0.State.Success or var_0_0.State.Fail

	return
end

function pg.SettingsGroupMgr.CheckGroupUpdateTip(arg_11_0)
	local var_11_0 = BundleWizard.Inst:GetGroupMgr(arg_11_0)

	var_11_0:CheckD()

	if var_11_0.state == DownloadState.CheckToUpdate then
		return false
	else
		return not GroupHelper.IsGroupVerLastest(arg_11_0)
	end

	return
end

return
