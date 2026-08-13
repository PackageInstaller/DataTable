class = var_0_10000

local var_0_0 = "IslandTicketAgency"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandBaseAgency"))

var_0_1.REMIND_TIP_KEY = "IslandTicketAgency.REMIND_TIP_KEY"

function var_0_1.OnInit(arg_1_0, arg_1_1)
	arg_1_0.data = {}
	ipairs = var_2

	for iter_1_0, iter_1_1 in var_2(arg_1_1.speed_tickets) do
		local var_1_0 = iter_1_1.key.speed_id
		local var_1_1 = iter_1_1.key.end_time
		local var_1_2 = iter_1_1.num

		if not arg_1_0.data[var_1_0] then
			arg_1_0.data[var_1_0] = {}
		end

		local var_1_3 = arg_1_0.data[var_1_0]

		IslandTicket = var_1_10011
		var_1_3[var_1_1] = var_1_10011.New(var_1_0, var_1_1, var_1_2)
	end

	local var_1_4 = var_0_1.REMIND_TIP_KEY
	local var_1_5 = "_"

	getProxy = var_4
	PlayerProxy = iter_1_1

	local var_1_6 = var_4(iter_1_1)

	arg_1_0.localTipKey = var_1_4 .. var_1_5 .. var_4.getRawData(var_1_6).id

	return
end

function var_0_1.AddTicket(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if not arg_2_0.data[arg_2_1] then
		arg_2_0.data[arg_2_1] = {}
	end

	if arg_2_0.data[arg_2_1][arg_2_2] then
		local var_2_0 = arg_2_0.data[arg_2_1][arg_2_2]

		var_4.AddCount(var_2_0, arg_2_3)
	else
		local var_2_1 = arg_2_0.data[arg_2_1]

		IslandTicket = var_1_10005
		var_2_1[arg_2_2] = var_1_10005.New(arg_2_1, arg_2_2, arg_2_3)
	end

	return
end

function var_0_1.ReduceTicket(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if not arg_3_0.data[arg_3_1] then
		return
	end

	if not arg_3_0.data[arg_3_1][arg_3_2] then
		return
	end

	if arg_3_3 > var_4:GetCount() then
		return
	end

	var_4:ReduceCount(arg_3_3)

	if var_4:IsEmpty() then
		arg_3_0:RemoveTicket(arg_3_1, arg_3_2)
	else
		arg_3_0.data[arg_3_1][arg_3_2] = var_4
	end

	return
end

function var_0_1.RemoveTicket(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.data[arg_4_1][arg_4_2] = nil

	return
end

function var_0_1.GetAllTicketList(arg_5_0)
	local var_5_0 = {}

	pairs = var_1_10002

	for iter_5_0, iter_5_1 in var_1_10002(arg_5_0.data) do
		pairs = var_1_10007

		for iter_5_2, iter_5_3 in var_1_10007(iter_5_1) do
			table = var_1_10012

			var_1_10012.insert(var_5_0, iter_5_3)
		end
	end

	return var_5_0
end

function var_0_1.GetTicketData(arg_6_0)
	return arg_6_0.data
end

function var_0_1.GetTikcetListById(arg_7_0, arg_7_1)
	if not arg_7_0.data[arg_7_1] then
		return {}
	end

	underscore = var_2

	return var_2.values(arg_7_0.data[arg_7_1])
end

function var_0_1.GetExpiredTickets(arg_8_0)
	local var_8_0 = {}

	pairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(arg_8_0.data) do
		pairs = var_1_10007

		for iter_8_2, iter_8_3 in var_1_10007(iter_8_1) do
			if iter_8_3:IsExpired() then
				table = var_12

				var_12.insert(var_8_0, iter_8_3)
			end
		end
	end

	return var_8_0
end

function var_0_1.GetExpireRemindTickets(arg_9_0)
	local var_9_0 = {}

	PlayerPrefs = var_1_10002

	local var_9_1 = var_1_10002.GetInt
	local var_9_2 = arg_9_0.localTipKey
	local var_9_3 = "_"

	GetZeroTime = var_1_10006

	if var_9_1(var_9_2 .. var_9_3 .. var_1_10006()) == 1 then
		return var_9_0
	end

	pairs = var_1_10003

	for iter_9_0, iter_9_1 in var_1_10003(arg_9_0.data) do
		pairs = var_1_10008

		for iter_9_2, iter_9_3 in var_1_10008(iter_9_1) do
			if iter_9_3:WillExpire() then
				table = var_13

				var_13.insert(var_9_0, iter_9_3)
			end
		end
	end

	return var_9_0
end

function var_0_1.SetRemindFlag(arg_10_0)
	PlayerPrefs = var_1_10001

	local var_10_0 = var_1_10001.SetInt
	local var_10_1 = arg_10_0.localTipKey
	local var_10_2 = "_"

	GetZeroTime = var_1_10005

	var_10_0(var_10_1 .. var_10_2 .. var_1_10005(), 1)

	PlayerPrefs = var_10_0

	var_10_0.Save()

	return
end

return var_0_1
