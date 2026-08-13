class = var_0_10000

local var_0_0 = var_0_10000("CryptolaliaDownloadMgr")

var_0_0.PROGRESS_FINISH = -99
var_0_0.PROGRESS_ERROR = -100

function var_0_0.Ctor(arg_1_0)
	arg_1_0.callbacks = {}
	pg = var_1
	arg_1_0.mgr = var_1.CipherGroupMgr.GetInstance()

	local var_1_0 = {
		progressCB = function(arg_2_0, arg_2_1)
			if arg_1_0.callbacks[arg_2_0] then
				arg_1_0.callbacks[arg_2_0](arg_2_0, arg_2_1)
			end

			return
		end,
		allFinishCB = function(arg_3_0, arg_3_1)
			warning = var_2_10002

			var_2_10002("全部完成")

			return
		end,
		singleFinshCB = function(arg_4_0, arg_4_1, arg_4_2)
			if arg_1_0.callbacks[arg_4_0] then
				arg_1_0.callbacks[arg_4_0](arg_4_0, var_0_0.PROGRESS_FINISH)

				arg_1_0.callbacks[arg_4_0] = nil
			end

			return
		end,
		errorCB = function(arg_5_0)
			string = var_2_10001

			local var_5_0 = var_2_10001.format("出错文件:%s", arg_5_0)

			warning = var_2

			var_2(var_5_0)

			if arg_1_0.callbacks[arg_5_0] then
				arg_1_0.callbacks[arg_5_0](arg_5_0, var_0_0.PROGRESS_ERROR)

				arg_1_0.callbacks[arg_5_0] = nil
			end

			return
		end
	}
	local var_1_1 = arg_1_0.mgr

	var_2.SetCallBack(var_1_1, var_1_0)

	return
end

function var_0_0.Request(arg_6_0, arg_6_1, arg_6_2)
	string = var_1_10003

	local var_6_0 = var_1_10003.lower(arg_6_1[#arg_6_1])
	local var_6_1 = arg_6_0.callbacks

	var_6_1[var_6_0] = arg_6_2
	GroupHelper = var_6_1

	local var_6_2 = var_6_1.GetGroupMgrByName("CIPHER")
	local var_6_3 = arg_6_0.mgr
	local var_6_4 = var_5.IsAnyFileInProgress(var_6_3)

	table = var_6_3

	local var_6_5 = var_6_3.concat(arg_6_1, ",")

	if var_6_4 then
		local var_6_6 = arg_6_0.mgr

		var_7.AddFileList(var_6_6, arg_6_1)
	else
		local var_6_7 = arg_6_0.mgr

		var_7.StartWithFileList(var_6_7, arg_6_1)
	end

	return
end

function var_0_0.ReConnection(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_1[#arg_7_1]

	if arg_7_0:IsDownloadState(var_7_0) then
		string = var_4

		local var_7_1 = var_4.lower(var_7_0)

		arg_7_0.callbacks[var_7_1] = arg_7_2
	end

	return
end

function var_0_0.IsDownloadState(arg_8_0, arg_8_1)
	string = var_1_10002
	arg_8_1 = var_1_10002.lower(arg_8_1)

	local var_8_0 = arg_8_0.mgr.downloadList

	for iter_8_0 = arg_8_0.mgr.curIndex, #var_8_0 do
		if var_8_0[iter_8_0] == arg_8_1 then
			return true
		end
	end

	return false
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.callbacks = {}

	local var_9_0 = {}
	local var_9_1 = arg_9_0.mgr

	var_2.SetCallBack(var_9_1, var_9_0)

	return
end

return var_0_0
