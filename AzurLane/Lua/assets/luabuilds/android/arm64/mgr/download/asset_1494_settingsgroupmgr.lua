pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.SettingsGroupMgr = var_0_10001("SettingsGroupMgr")

local var_0_1 = var_0.SettingsGroupMgr

var_0_1.State = {
	Success = 3,
	Updating = 2,
	Fail = 4,
	None = 1
}

function var_0_1.Init(arg_1_0, arg_1_1)
	arg_1_0.infoDict = {}

	return
end

function var_0_1.StartDownload(arg_2_0, arg_2_1, arg_2_2)
	local function var_2_0(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
		local var_3_0 = arg_2_0

		var_6.onProgress(var_3_0, arg_2_1, arg_3_0, arg_3_1, arg_3_2)

		return
	end

	local function var_2_1(arg_4_0, arg_4_1)
		local var_4_0 = arg_2_0

		var_2.onFinish(var_4_0, arg_2_1, arg_4_0, arg_4_1)

		return
	end

	BundleWizardUpdater = var_1_10005

	local var_2_2 = var_1_10005.Inst
	local var_2_3 = var_5.GetFileList(var_2_2, arg_2_2)

	BundleWizardUpdater = var_1_10006

	local var_2_4 = var_1_10006.Inst
	local var_2_5 = var_6.CreateListInfo(var_2_4, arg_2_1, var_2_3, nil, var_2_1, var_2_0)

	BundleWizardUpdater = var_2_2

	local var_2_6 = var_2_2.Inst

	var_7.StartUpdate(var_2_6, var_2_5)

	return
end

function var_0_1.GetState(arg_5_0, arg_5_1)
	if arg_5_0.infoDict[arg_5_1] == nil then
		return var_0_1.State.None
	else
		return var_2.state
	end

	return
end

function var_0_1.GetCountProgress(arg_6_0, arg_6_1)
	if arg_6_0.infoDict[arg_6_1] == nil then
		return 0, 0
	else
		return var_2.curCount, var_2.totalCount
	end

	return
end

function var_0_1.GetTotalSize(arg_7_0, arg_7_1)
	local var_7_0 = 0

	ipairs = var_1_10003

	for iter_7_0, iter_7_1 in var_1_10003(arg_7_1) do
		GroupHelper = var_1_10008
		var_7_0 = var_7_0 + var_1_10008.GetGroupSize(iter_7_1)
	end

	return var_7_0
end

function var_0_1.beforeStart(arg_8_0, arg_8_1)
	local var_8_0

	if arg_8_0.infoDict[arg_8_1] == nil then
		var_8_0 = {}
		arg_8_0.infoDict[arg_8_1] = var_8_0
	end

	var_8_0.state = var_0_1.State.Updating

	return
end

function var_0_1.onProgress(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0

	if arg_9_0.infoDict[arg_9_1] == nil then
		var_9_0 = {}
		arg_9_0.infoDict[arg_9_1] = var_9_0
	end

	var_9_0.state = var_0_1.State.Updating
	var_9_0.successCount = arg_9_2
	var_9_0.failCount = arg_9_3
	var_9_0.totalCount = arg_9_4
	var_9_0.curCount = arg_9_2 + arg_9_3

	return
end

function var_0_1.onFinish(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0

	if arg_10_0.infoDict[arg_10_1] == nil then
		var_10_0 = {}
		arg_10_0.infoDict[arg_10_1] = var_10_0
	end

	if arg_10_2 then
		var_10_0.state = var_0_1.State.Success
	else
		var_10_0.state = var_0_1.State.Fail
	end

	return
end

function var_0_1.CheckGroupUpdateTip(arg_11_0)
	BundleWizard = var_1_10001

	local var_11_0 = var_1_10001.Inst
	local var_11_1 = var_1.GetGroupMgr(var_11_0, arg_11_0)

	var_1.CheckD(var_11_1)

	local var_11_2 = var_1.state

	DownloadState = var_11_0

	if var_11_2 == var_11_0.CheckToUpdate then
		return false
	else
		GroupHelper = var_11_2

		return not var_11_2.IsGroupVerLastest(arg_11_0)
	end

	return
end

return
