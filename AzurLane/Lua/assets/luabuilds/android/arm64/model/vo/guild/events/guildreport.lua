local var_0_0 = class("GuildReport", import("...BaseVO"))

var_0_0.SCORE_TYPE_S = 1
var_0_0.SCORE_TYPE_A = 2
var_0_0.SCORE_TYPE_B = 3

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.eventId = arg_1_1.event_id
	arg_1_0.configId = arg_1_0.eventId
	arg_1_0.score = arg_1_1.score
	arg_1_0.state = GuildConst.REPORT_STATE_LOCK
	arg_1_0.nodeAwards = {}

	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.nodes) do
		local var_1_1
		local var_1_2 = Clone(pg.guild_event_node[iter_1_1.id])

		var_1_1 = iter_1_1.status == 1 and var_1_2.success_award or var_1_2.fail_award

		for iter_1_2, iter_1_3 in ipairs(var_1_1) do
			if not var_1_0[iter_1_3[2]] then
				var_1_0[iter_1_3[2]] = iter_1_3
			else
				var_1_0[iter_1_3[2]][3] = var_1_0[iter_1_3[2]][3] + iter_1_3[3]
			end
		end
	end

	for iter_1_4, iter_1_5 in pairs(var_1_0) do
		table.insert(arg_1_0.nodeAwards, iter_1_5)
	end

	arg_1_0:SetStatus(arg_1_1.status)

	return
end

function var_0_0.SetStatus(arg_2_0, arg_2_1)
	arg_2_0.state = arg_2_1

	return
end

function var_0_0.IsBoss(arg_3_0)
	return false
end

function var_0_0.IsLock(arg_4_0)
	return arg_4_0.state == GuildConst.REPORT_STATE_LOCK
end

function var_0_0.IsUnlock(arg_5_0)
	return arg_5_0.state > GuildConst.REPORT_STATE_LOCK
end

function var_0_0.CanSubmit(arg_6_0)
	return arg_6_0.state == GuildConst.REPORT_STATE_UNlOCK
end

function var_0_0.IsSubmited(arg_7_0)
	return arg_7_0.state == GuildConst.REPORT_STATE_SUBMITED
end

function var_0_0.Submit(arg_8_0)
	if arg_8_0:CanSubmit() then
		arg_8_0.state = GuildConst.REPORT_STATE_SUBMITED
	end

	return
end

function var_0_0.bindConfigTable(arg_9_0)
	return pg.guild_base_event
end

function var_0_0.GetReportDesc(arg_10_0)
	return arg_10_0:getConfig("report")[arg_10_0.score]
end

function var_0_0.IsPerfectFinish(arg_11_0)
	return arg_11_0.score == var_0_0.SCORE_TYPE_S
end

function var_0_0.GetSelfDrop(arg_12_0)
	if arg_12_0.score == var_0_0.SCORE_TYPE_S then
		return arg_12_0:getConfig("award_list_report")
	else
		return {}
	end

	return
end

function var_0_0.GetNodeDrop(arg_13_0)
	return arg_13_0.nodeAwards
end

function var_0_0.GetDrop(arg_14_0)
	local var_14_0 = arg_14_0:GetSelfDrop()

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		table.insert({}, iter_14_1)
	end

	for iter_14_2, iter_14_3 in ipairs((arg_14_0:GetNodeDrop())) do
		table.insert({}, iter_14_3)
	end

	return {}, #var_14_0
end

function var_0_0.GetType(arg_15_0)
	return arg_15_0:getConfig("type")
end

return var_0_0
