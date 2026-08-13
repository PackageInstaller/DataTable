class = var_0_10000

local var_0_0 = "SecondaryPWDProxy"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NetProxy"))

function var_0_1.register(arg_1_0)
	local var_1_0

	if not arg_1_0.data then
		var_1_0 = {}
	end

	arg_1_0.data = var_1_0

	local var_1_1 = arg_1_0.data

	var_1_1.state = 0
	var_1_1.fail_count = 0
	var_1_1.fail_cd = nil
	var_1_1.notice = nil
	var_1_1.system_list = {}

	return
end

function var_0_1.SetData(arg_2_0, arg_2_1)
	local var_2_0

	if not arg_2_0.data then
		var_2_0 = {}
	end

	arg_2_0.data = var_2_0

	local var_2_1 = arg_2_0.data

	var_2_1.state = arg_2_1.state
	var_2_1.fail_count = arg_2_1.fail_count
	var_2_1.fail_cd = arg_2_1.fail_cd
	var_2_1.notice = arg_2_1.notice
	var_2_1.system_list = {}

	local var_2_2 = 1

	pg = var_1_10004

	for iter_2_0 = var_2_2, #var_1_10004.SecondaryPWDMgr.LIMITED_OPERATION do
		table = var_1_10007

		var_1_10007.insert(var_2_1.system_list, arg_2_1.system_list[iter_2_0])
	end

	return
end

function var_0_1.OnFirstSet(arg_3_0, arg_3_1)
	local var_3_0

	if not arg_3_0.data then
		var_3_0 = {}
	end

	arg_3_0.data = var_3_0

	local var_3_1 = arg_3_0.data

	var_3_1.state = 1
	Clone = var_3
	var_3_1.system_list = var_3(arg_3_1.settings)
	var_3_1.fail_count = 0
	var_3_1.fail_cd = nil
	Clone = var_3
	var_3_1.notice = var_3(arg_3_1.tip)

	return
end

function var_0_1.OnSettingsChange(arg_4_0, arg_4_1)
	local var_4_0

	if not arg_4_0.data then
		var_4_0 = {}
	end

	arg_4_0.data = var_4_0

	local var_4_1 = arg_4_0.data

	var_4_1.state = #arg_4_1.settings == 0 and 0 or 2
	Clone = var_3
	var_4_1.system_list = var_3(arg_4_1.settings)
	var_4_1.fail_cd = nil
	var_4_1.fail_count = 0

	return
end

function var_0_1.GetPermissionState(arg_5_0)
	if arg_5_0.data.state == 0 then
		return true
	end

	local var_5_0 = arg_5_0.data.fail_cd

	pg = var_1_10003

	local var_5_1 = var_1_10003.TimeMgr.GetInstance()
	local var_5_2 = var_3.GetServerTime(var_5_1)

	if var_5_0 and var_5_2 < var_5_0 then
		return false, var_5_0 - var_5_2
	end

	return true
end

return var_0_1
