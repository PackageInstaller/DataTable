local var_0_0 = {}
local var_0_1 = DownloadConst

var_0_1.NotifyDownloadFinish = "DownloadConst.NotifyDownloadFinish"

function var_0_1.GetAllGroup()
	BundleWizard = var_1_10000

	local var_1_0 = var_1_10000.Inst

	return var_0.GetAllGroups(var_1_0)
end

function var_0_1.VerifyFile(arg_2_0)
	GroupHelper = var_1_10001

	local var_2_0 = var_1_10001.GetGroupNameByFilePath(arg_2_0)

	GroupHelper = var_2

	return var_2.VerifyFile(var_2_0, arg_2_0)
end

function var_0_1.IsNeedCheck()
	Application = var_1_10000

	local var_3_0 = var_1_10000.isEditor

	SplitPackHelper = var_1_10001

	local var_3_1 = var_1_10001.Inst
	local var_3_2 = var_1.IsSplitPackMode(var_3_1)

	if var_3_0 and not var_3_2 then
		return false
	end

	GroupHelper = var_3_1

	local var_3_3 = var_3_1.IsAllGroupVerLastest()

	GroupHelper = var_1_10003

	local var_3_4 = var_1_10003.IsAnyGroupWaitToUpdate()

	if not var_3_2 then
		if var_3_0 or var_3_3 or not var_3_4 then
			return false
		else
			return true
		end
	elseif var_3_4 then
		return true
	else
		return false
	end

	return
end

function var_0_1.CalcListSize(arg_4_0)
	local var_4_0 = 0

	pairs = var_1_10002

	for iter_4_0, iter_4_1 in var_1_10002(arg_4_0) do
		GroupHelper = var_1_10007
		var_4_0 = var_4_0 + var_1_10007.CalcSizeWithFileArr(iter_4_0, iter_4_1)
	end

	HashUtil = var_2

	local var_4_1 = var_2.BytesToString(var_4_0)

	return var_4_0, var_4_1
end

function var_0_1.IndexFileListByGroup(arg_5_0)
	local var_5_0 = 0
	local var_5_1 = {}

	ipairs = var_1_10003

	for iter_5_0, iter_5_1 in var_1_10003(arg_5_0) do
		string = var_1_10008
		iter_5_1 = var_1_10008.lower(iter_5_1)
		GroupHelper = var_1_10008

		if var_5_1[var_1_10008.GetGroupNameByFilePath(iter_5_1)] == nil then
			var_5_1[var_1_10008] = {}
		end

		if var_0_1.VerifyFile(iter_5_1) then
			table = var_9

			if not var_9.contains(var_5_1[var_1_10008], iter_5_1) then
				table = var_9

				var_9.insert(var_5_1[var_1_10008], iter_5_1)

				var_5_0 = var_5_0 + 1
			end
		end
	end

	return var_5_1, var_5_0
end

function var_0_1.Download(arg_6_0)
	local var_6_0 = {}
	local var_6_1

	if var_0_1.IsNeedCheck() then
		var_6_1 = arg_6_0.isShowBox
		pg = var_1_10003

		local var_6_2 = var_1_10003.FileDownloadMgr.GetInstance()
		local var_6_3 = var_3.IsNeedRemind(var_6_2)

		IsUsingWifi = var_6_2

		local var_6_4 = var_6_2()
		local var_6_5 = var_6_1 and var_6_3
		local var_6_6, var_6_7 = var_0_1.IndexFileListByGroup(arg_6_0.fileList)

		if 0 < var_6_7 then
			local var_6_8

			if var_6_5 then
				local var_6_9

				var_6_8, var_6_9 = var_0_1.CalcListSize(var_6_6)
				table = var_1_10010

				var_1_10010.insert(var_6_0, function(arg_7_0)
					pg = var_2_10001

					local var_7_0 = var_2_10001.MsgboxMgr.GetInstance()
					local var_7_1 = var_1.ShowMsgBox
					local var_7_2 = {
						modal = true,
						locked = true,
						hideToggle = true
					}

					MSGBOX_TYPE_FILE_DOWNLOAD = var_2_10004
					var_7_2.type = var_2_10004
					string = var_2_10004

					local var_7_3 = var_2_10004.format

					i18n = var_2_10005
					var_7_2.content = var_7_3(var_2_10005("file_down_msgbox", var_6_9))
					var_7_2.onYes = arg_7_0
					var_7_2.onNo = arg_6_0.onNo
					var_7_2.onClose = arg_6_0.onClose

					var_7_1(var_7_0, var_7_2)

					return
				end)
			end

			table = var_6_8

			var_6_8.insert(var_6_0, function(arg_8_0)
				local var_8_0 = {
					dataList = {},
					onFinish = arg_8_0
				}

				pairs = var_2

				for iter_8_0, iter_8_1 in var_2(var_6_6) do
					local var_8_1 = {
						groupName = iter_8_0,
						fileNameList = iter_8_1
					}

					table = var_2_10008

					var_2_10008.insert(var_8_0.dataList, var_8_1)
				end

				pg = var_2

				local var_8_2 = var_2.FileDownloadMgr.GetInstance()

				var_2.Main(var_8_2, var_8_0)

				return
			end)

			table = var_8

			var_8.insert(var_6_0, function(arg_9_0)
				pg = var_2_10001

				local var_9_0 = var_2_10001.m02

				var_1.sendNotification(var_9_0, var_0_1.NotifyDownloadFinish)
				arg_9_0()

				return
			end)
		end
	end

	seriesAsync = var_6_1

	var_6_1(var_6_0, arg_6_0.finishFunc)

	return
end

return var_0_1
