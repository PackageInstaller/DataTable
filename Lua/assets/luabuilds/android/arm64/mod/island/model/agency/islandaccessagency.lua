local var_0_0 = class("IslandAccessAgency", import(".IslandBaseAgency"))

function var_0_0.OnInit(arg_1_0, arg_1_1)
	arg_1_0.whiteList = {}
	arg_1_0.blackList = {}
	arg_1_0.visitorList = {}
	arg_1_0.inviteCode = ""
	arg_1_0.freshInviteCodeFlag = 0
	arg_1_0.openFlag = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.flag_list) do
		table.insert(arg_1_0.openFlag, iter_1_1)
	end

	return
end

function var_0_0.InitPrivateData(arg_2_0, arg_2_1)
	arg_2_0.inviteCode = arg_2_1.invite_code

	local var_2_0 = arg_2_1.white_list or {}

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		table.insert(arg_2_0.whiteList, iter_2_1)
	end

	local var_2_1 = arg_2_1.black_list or {}

	for iter_2_2, iter_2_3 in ipairs(var_2_1) do
		table.insert(arg_2_0.blackList, iter_2_3)
	end

	local var_2_2 = arg_2_1.visitor_history or {}

	for iter_2_4, iter_2_5 in ipairs(var_2_2) do
		table.insert(arg_2_0.visitorList, IslandVisitorLog.New(iter_2_5))
	end

	for iter_2_6, iter_2_7 in ipairs(arg_2_1.daily_list) do
		if iter_2_7.key == IslandConst.DL_INVITE_CODE_FLAG then
			arg_2_0.freshInviteCodeFlag = iter_2_7.value
		end
	end

	return
end

function var_0_0.GetVisitorLogList(arg_3_0)
	return arg_3_0.visitorList
end

function var_0_0.AddVisitorLog(arg_4_0, arg_4_1)
	table.insert(arg_4_0.visitorList, arg_4_1)

	return
end

function var_0_0.isFreshInviteCode(arg_5_0)
	return arg_5_0.freshInviteCodeFlag == 1
end

function var_0_0.MarkFreshInviteCodeFlag(arg_6_0)
	arg_6_0.freshInviteCodeFlag = 1

	return
end

function var_0_0.ResetFreshInviteCodeFlag(arg_7_0)
	arg_7_0.freshInviteCodeFlag = 0

	return
end

function var_0_0.GetInviteCode(arg_8_0)
	return arg_8_0.inviteCode
end

function var_0_0.SetInviteCode(arg_9_0, arg_9_1)
	arg_9_0.inviteCode = arg_9_1

	return
end

function var_0_0.GetOpenFlag(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.openFlag) do
		table.insert({}, iter_10_1)
	end

	return {}
end

function var_0_0.HasOpenFlag(arg_11_0, arg_11_1)
	return table.contains(arg_11_0.openFlag, arg_11_1)
end

function var_0_0.AddOpenFlag(arg_12_0, arg_12_1)
	if arg_12_0:HasOpenFlag(arg_12_1) then
		return
	end

	table.insert(arg_12_0.openFlag, arg_12_1)

	return
end

function var_0_0.RemoveOpenFlag(arg_13_0, arg_13_1)
	if not arg_13_0:HasOpenFlag(arg_13_1) then
		return
	end

	table.removebyvalue(arg_13_0.openFlag, arg_13_1)

	return
end

function var_0_0.SetWhiteList(arg_14_0, arg_14_1)
	arg_14_0.whiteList = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		table.insert(arg_14_0.whiteList, iter_14_1)
	end

	return
end

function var_0_0.GetWhiteList(arg_15_0)
	return arg_15_0.whiteList
end

function var_0_0.SetBlackList(arg_16_0, arg_16_1)
	arg_16_0.blackList = {}

	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		table.insert(arg_16_0.blackList, iter_16_1)
	end

	return
end

function var_0_0.GetBlackList(arg_17_0)
	return arg_17_0.blackList
end

function var_0_0.AddBlackList(arg_18_0, arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
		if not arg_18_0:InBlackList(iter_18_1) then
			table.insert(arg_18_0.blackList, iter_18_1)
		end
	end

	return
end

function var_0_0.InWhiteList(arg_19_0, arg_19_1)
	return table.contains(arg_19_0.whiteList, arg_19_1)
end

function var_0_0.InBlackList(arg_20_0, arg_20_1)
	return table.contains(arg_20_0.blackList, arg_20_1)
end

return var_0_0
