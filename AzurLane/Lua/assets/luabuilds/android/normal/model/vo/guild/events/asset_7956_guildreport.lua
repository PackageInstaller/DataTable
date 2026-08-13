class = var_0_10000

local var_0_0 = "GuildReport"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...BaseVO"))

var_0_1.SCORE_TYPE_S = 1
var_0_1.SCORE_TYPE_A = 2
var_0_1.SCORE_TYPE_B = 3

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.eventId = arg_1_1.event_id
	arg_1_0.configId = arg_1_0.eventId
	arg_1_0.score = arg_1_1.score
	GuildConst = var_2
	arg_1_0.state = var_2.REPORT_STATE_LOCK
	arg_1_0.nodeAwards = {}

	local var_1_0 = {}

	ipairs = var_1_10003

	for iter_1_0, iter_1_1 in var_1_10003(arg_1_1.nodes) do
		var_1_10008 = nil
		Clone = var_1_10009
		pg = var_1_10010
		var_1_10009 = var_1_10009(var_1_10010.guild_event_node[iter_1_1.id])

		if iter_1_1.status == 1 then
			var_1_10008 = var_1_10009.success_award
		else
			var_1_10008 = var_1_10009.fail_award
		end

		ipairs = var_1_10010

		for iter_1_2, iter_1_3 in var_1_10010(var_1_10008) do
			if not var_1_0[iter_1_3[2]] then
				var_1_0[iter_1_3[2]] = iter_1_3
			else
				var_1_0[iter_1_3[2]][3] = var_1_0[iter_1_3[2]][3] + iter_1_3[3]
			end
		end
	end

	pairs = var_3

	for iter_1_4, iter_1_5 in var_3(var_1_0) do
		table = var_1_10008

		var_1_10008.insert(arg_1_0.nodeAwards, iter_1_5)
	end

	arg_1_0:SetStatus(arg_1_1.status)

	return
end

function var_0_1.SetStatus(arg_2_0, arg_2_1)
	arg_2_0.state = arg_2_1

	return
end

function var_0_1.IsBoss(arg_3_0)
	return false
end

function var_0_1.IsLock(arg_4_0)
	local var_4_0 = arg_4_0.state

	GuildConst = var_1_10002

	return var_4_0 == var_1_10002.REPORT_STATE_LOCK
end

function var_0_1.IsUnlock(arg_5_0)
	local var_5_0 = arg_5_0.state

	GuildConst = var_1_10002

	return var_5_0 > var_1_10002.REPORT_STATE_LOCK
end

function var_0_1.CanSubmit(arg_6_0)
	local var_6_0 = arg_6_0.state

	GuildConst = var_1_10002

	return var_6_0 == var_1_10002.REPORT_STATE_UNlOCK
end

function var_0_1.IsSubmited(arg_7_0)
	local var_7_0 = arg_7_0.state

	GuildConst = var_1_10002

	return var_7_0 == var_1_10002.REPORT_STATE_SUBMITED
end

function var_0_1.Submit(arg_8_0)
	if arg_8_0:CanSubmit() then
		GuildConst = var_1
		arg_8_0.state = var_1.REPORT_STATE_SUBMITED
	end

	return
end

function var_0_1.bindConfigTable(arg_9_0)
	pg = var_1_10001

	return var_1_10001.guild_base_event
end

function var_0_1.GetReportDesc(arg_10_0)
	return arg_10_0:getConfig("report")[arg_10_0.score]
end

function var_0_1.IsPerfectFinish(arg_11_0)
	return arg_11_0.score == var_0_1.SCORE_TYPE_S
end

function var_0_1.GetSelfDrop(arg_12_0)
	if arg_12_0.score == var_0_1.SCORE_TYPE_S then
		return arg_12_0:getConfig("award_list_report")
	else
		return {}
	end

	return
end

function var_0_1.GetNodeDrop(arg_13_0)
	return arg_13_0.nodeAwards
end

function var_0_1.GetDrop(arg_14_0)
	local var_14_0 = {}
	local var_14_1 = arg_14_0:GetSelfDrop()
	local var_14_2 = arg_14_0
	local var_14_3 = arg_14_0.GetNodeDrop(var_14_2)

	ipairs = var_14_2

	for iter_14_0, iter_14_1 in var_14_2(var_14_1) do
		table = var_1_10009

		var_1_10009.insert(var_14_0, iter_14_1)
	end

	ipairs = var_4

	for iter_14_2, iter_14_3 in var_4(var_14_3) do
		table = var_1_10009

		var_1_10009.insert(var_14_0, iter_14_3)
	end

	return var_14_0, #var_14_1
end

function var_0_1.GetType(arg_15_0)
	return arg_15_0:getConfig("type")
end

return var_0_1
