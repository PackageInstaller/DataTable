local var_0_0 = class("SecondaryPWDProxy", import(".NetProxy"))

function var_0_0.register(arg_1_0)
	arg_1_0.data = arg_1_0.data or {}
	arg_1_0.data.state = 0
	arg_1_0.data.fail_count = 0
	arg_1_0.data.fail_cd = nil
	arg_1_0.data.notice = nil
	arg_1_0.data.system_list = {}

	return
end

function var_0_0.SetData(arg_2_0, arg_2_1)
	arg_2_0.data = arg_2_0.data or {}
	arg_2_0.data.state = arg_2_1.state
	arg_2_0.data.fail_count = arg_2_1.fail_count
	arg_2_0.data.fail_cd = arg_2_1.fail_cd
	arg_2_0.data.notice = arg_2_1.notice
	arg_2_0.data.system_list = {}

	for iter_2_0 = 1, #pg.SecondaryPWDMgr.LIMITED_OPERATION do
		table.insert(arg_2_0.data.system_list, arg_2_1.system_list[iter_2_0])
	end

	return
end

function var_0_0.OnFirstSet(arg_3_0, arg_3_1)
	arg_3_0.data = arg_3_0.data or {}
	arg_3_0.data.state = 1
	arg_3_0.data.system_list = Clone(arg_3_1.settings)
	arg_3_0.data.fail_count = 0
	arg_3_0.data.fail_cd = nil
	arg_3_0.data.notice = Clone(arg_3_1.tip)

	return
end

function var_0_0.OnSettingsChange(arg_4_0, arg_4_1)
	arg_4_0.data = arg_4_0.data or {}

	local var_4_0 = arg_4_0.data

	var_4_0.state = #arg_4_1.settings == 0 and 0 or 2
	var_4_0.system_list = Clone(arg_4_1.settings)
	var_4_0.fail_cd = nil
	var_4_0.fail_count = 0

	return
end

function var_0_0.GetPermissionState(arg_5_0)
	if arg_5_0.data.state == 0 then
		return true
	end

	local var_5_0 = arg_5_0.data.fail_cd
	local var_5_1 = pg.TimeMgr.GetInstance():GetServerTime()

	if arg_5_0.data.fail_cd and var_5_1 < var_5_0 then
		return false, var_5_0 - var_5_1
	end

	return true
end

return var_0_0
