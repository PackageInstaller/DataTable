local var_0_0 = class("CryptolaliaDownloadMgr")

var_0_0.PROGRESS_FINISH = -99
var_0_0.PROGRESS_ERROR = -100

function var_0_0.Ctor(arg_1_0)
	arg_1_0.callbacks = {}
	arg_1_0.mgr = pg.CipherGroupMgr.GetInstance()

	arg_1_0.mgr:SetCallBack({
		progressCB = function(arg_2_0, arg_2_1)
			if arg_1_0.callbacks[arg_2_0] then
				arg_1_0.callbacks[arg_2_0](arg_2_0, arg_2_1)
			end

			return
		end,
		allFinishCB = function(arg_3_0, arg_3_1)
			warning("全部完成")

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
			warning((string.format("出错文件:%s", arg_5_0)))

			if arg_1_0.callbacks[arg_5_0] then
				arg_1_0.callbacks[arg_5_0](arg_5_0, var_0_0.PROGRESS_ERROR)

				arg_1_0.callbacks[arg_5_0] = nil
			end

			return
		end
	})

	return
end

function var_0_0.Request(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.callbacks[string.lower(arg_6_1[#arg_6_1])] = arg_6_2

	local var_6_0 = GroupHelper.GetGroupMgrByName("CIPHER")
	local var_6_1 = table.concat(arg_6_1, ",")

	if arg_6_0.mgr:IsAnyFileInProgress() then
		arg_6_0.mgr:AddFileList(arg_6_1)
	else
		arg_6_0.mgr:StartWithFileList(arg_6_1)
	end

	return
end

function var_0_0.ReConnection(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0:IsDownloadState(arg_7_1[#arg_7_1]) then
		arg_7_0.callbacks[string.lower(arg_7_1[#arg_7_1])] = arg_7_2
	end

	return
end

function var_0_0.IsDownloadState(arg_8_0, arg_8_1)
	arg_8_1 = string.lower(arg_8_1)

	for iter_8_0 = arg_8_0.mgr.curIndex, #arg_8_0.mgr.downloadList do
		if arg_8_0.mgr.downloadList[iter_8_0] == arg_8_1 then
			return true
		end
	end

	return false
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.callbacks = {}

	arg_9_0.mgr:SetCallBack({})

	return
end

return var_0_0
