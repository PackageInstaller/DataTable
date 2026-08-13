class = var_0_10000

local var_0_0 = "IslandAccessAgency"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandBaseAgency"))

function var_0_1.OnInit(arg_1_0, arg_1_1)
	arg_1_0.whiteList = {}
	arg_1_0.blackList = {}
	arg_1_0.visitorList = {}
	arg_1_0.inviteCode = ""
	arg_1_0.freshInviteCodeFlag = 0
	arg_1_0.openFlag = {}
	ipairs = var_2

	for iter_1_0, iter_1_1 in var_2(arg_1_1.flag_list) do
		table = var_1_10007

		var_1_10007.insert(arg_1_0.openFlag, iter_1_1)
	end

	return
end

function var_0_1.InitPrivateData(arg_2_0, arg_2_1)
	arg_2_0.inviteCode = arg_2_1.invite_code
	ipairs = var_2

	local var_2_0

	if not arg_2_1.white_list then
		var_2_0 = {}
	end

	for iter_2_0, iter_2_1 in var_2(var_2_0) do
		table = var_1_10007

		var_1_10007.insert(arg_2_0.whiteList, iter_2_1)
	end

	ipairs = var_2

	local var_2_1

	if not arg_2_1.black_list then
		var_2_1 = {}
	end

	for iter_2_2, iter_2_3 in var_2(var_2_1) do
		table = var_1_10007

		var_1_10007.insert(arg_2_0.blackList, iter_2_3)
	end

	ipairs = var_2

	local var_2_2

	if not arg_2_1.visitor_history then
		var_2_2 = {}
	end

	for iter_2_4, iter_2_5 in var_2(var_2_2) do
		table = var_1_10007
		var_1_10007 = var_1_10007.insert

		local var_2_3 = arg_2_0.visitorList

		IslandVisitorLog = var_1_10010

		var_1_10007(var_2_3, var_1_10010.New(iter_2_5))
	end

	ipairs = var_2

	for iter_2_6, iter_2_7 in var_2(arg_2_1.daily_list) do
		local var_2_4 = iter_2_7.key

		IslandConst = var_1_10008

		if var_2_4 == var_1_10008.DL_INVITE_CODE_FLAG then
			arg_2_0.freshInviteCodeFlag = iter_2_7.value
		end
	end

	return
end

function var_0_1.GetVisitorLogList(arg_3_0)
	return arg_3_0.visitorList
end

function var_0_1.AddVisitorLog(arg_4_0, arg_4_1)
	table = var_1_10002

	var_1_10002.insert(arg_4_0.visitorList, arg_4_1)

	return
end

function var_0_1.isFreshInviteCode(arg_5_0)
	return arg_5_0.freshInviteCodeFlag == 1
end

function var_0_1.MarkFreshInviteCodeFlag(arg_6_0)
	arg_6_0.freshInviteCodeFlag = 1

	return
end

function var_0_1.ResetFreshInviteCodeFlag(arg_7_0)
	arg_7_0.freshInviteCodeFlag = 0

	return
end

function var_0_1.GetInviteCode(arg_8_0)
	return arg_8_0.inviteCode
end

function var_0_1.SetInviteCode(arg_9_0, arg_9_1)
	arg_9_0.inviteCode = arg_9_1

	return
end

function var_0_1.GetOpenFlag(arg_10_0)
	local var_10_0 = {}

	ipairs = var_1_10002

	for iter_10_0, iter_10_1 in var_1_10002(arg_10_0.openFlag) do
		table = var_1_10007

		var_1_10007.insert(var_10_0, iter_10_1)
	end

	return var_10_0
end

function var_0_1.HasOpenFlag(arg_11_0, arg_11_1)
	table = var_1_10002

	return var_1_10002.contains(arg_11_0.openFlag, arg_11_1)
end

function var_0_1.AddOpenFlag(arg_12_0, arg_12_1)
	if arg_12_0:HasOpenFlag(arg_12_1) then
		return
	end

	table = var_2

	var_2.insert(arg_12_0.openFlag, arg_12_1)

	return
end

function var_0_1.RemoveOpenFlag(arg_13_0, arg_13_1)
	if not arg_13_0:HasOpenFlag(arg_13_1) then
		return
	end

	table = var_2

	var_2.removebyvalue(arg_13_0.openFlag, arg_13_1)

	return
end

function var_0_1.SetWhiteList(arg_14_0, arg_14_1)
	arg_14_0.whiteList = {}
	ipairs = var_2

	for iter_14_0, iter_14_1 in var_2(arg_14_1) do
		table = var_1_10007

		var_1_10007.insert(arg_14_0.whiteList, iter_14_1)
	end

	return
end

function var_0_1.GetWhiteList(arg_15_0)
	return arg_15_0.whiteList
end

function var_0_1.SetBlackList(arg_16_0, arg_16_1)
	arg_16_0.blackList = {}
	ipairs = var_2

	for iter_16_0, iter_16_1 in var_2(arg_16_1) do
		table = var_1_10007

		var_1_10007.insert(arg_16_0.blackList, iter_16_1)
	end

	return
end

function var_0_1.GetBlackList(arg_17_0)
	return arg_17_0.blackList
end

function var_0_1.AddBlackList(arg_18_0, arg_18_1)
	ipairs = var_1_10002

	for iter_18_0, iter_18_1 in var_1_10002(arg_18_1) do
		if not arg_18_0:InBlackList(iter_18_1) then
			table = var_7

			var_7.insert(arg_18_0.blackList, iter_18_1)
		end
	end

	return
end

function var_0_1.InWhiteList(arg_19_0, arg_19_1)
	table = var_1_10002

	return var_1_10002.contains(arg_19_0.whiteList, arg_19_1)
end

function var_0_1.InBlackList(arg_20_0, arg_20_1)
	table = var_1_10002

	return var_1_10002.contains(arg_20_0.blackList, arg_20_1)
end

return var_0_1
