ActivityTemplate = class("ActivityTemplate")

function ActivityTemplate.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.activity_id
	arg_1_0.startTime = arg_1_1.start_time
	arg_1_0.stopTime = arg_1_1.stop_time
	arg_1_0.state = arg_1_1.state or 0
	arg_1_0.theme = arg_1_1.theme or 0
	arg_1_0.template = arg_1_1.template or 0
	arg_1_0.subActivityIdList = {}

	if arg_1_1.sub_activity_id_list then
		for iter_1_0, iter_1_1 in ipairs(arg_1_1.sub_activity_id_list) do
			table.insert(arg_1_0.subActivityIdList, iter_1_1)
		end
	end
end

function ActivityTemplate.IsActivitying(arg_2_0)
	local var_2_0 = manager.time:GetServerTime()

	if arg_2_0.stopTime == 0 then
		return true
	end

	if var_2_0 <= arg_2_0.stopTime then
		if arg_2_0.state ~= 1 then
			return false
		end

		return true
	end

	return false
end

function ActivityTemplate.IsOverdue(arg_3_0)
	local var_3_0 = manager.time:GetServerTime()

	if arg_3_0.stopTime == 0 then
		return false
	end

	return var_3_0 > arg_3_0.stopTime
end

function ActivityTemplate.GetRemainTime(arg_4_0)
	return arg_4_0.stopTime - manager.time:GetServerTime()
end

function ActivityTemplate.GetTimeBeforeStart(arg_5_0)
	return arg_5_0.startTime - manager.time:GetServerTime()
end

function ActivityTemplate.GetStateBool(arg_6_0)
	return arg_6_0.state == 1
end
