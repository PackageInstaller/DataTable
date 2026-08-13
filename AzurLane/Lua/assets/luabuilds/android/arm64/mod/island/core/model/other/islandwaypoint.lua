class = var_0_10000

local var_0_0 = var_0_10000("IslandWayPoint")

var_0_0.ACTION_TYPE_CHATBUBBLE = 1
var_0_0.ACTION_TYPE_ANIM = 2

function var_0_0.Ctor(arg_1_0, arg_1_1)
	pg = var_1_10002
	arg_1_0.config = var_1_10002.island_waypoint[arg_1_1]
	BuildVector3 = var_2
	arg_1_0.position = var_2(arg_1_0.config.position)
	arg_1_0.processAction = nil
	arg_1_0.arriveAction = nil

	return
end

function var_0_0.RandomProcessAction(arg_2_0)
	arg_2_0.processAction = arg_2_0:BuildAction(arg_2_0.config.process_action, arg_2_0.config.process_dialogue, arg_2_0.config.process_time)

	return
end

function var_0_0.GetActionWhenProcess(arg_3_0)
	return arg_3_0.processAction
end

function var_0_0.RandomArriveAction(arg_4_0)
	arg_4_0.arriveAction = arg_4_0:BuildAction(arg_4_0.config.arrive_action, arg_4_0.config.arrive_dialogue, 0)

	return
end

function var_0_0.GetActionWhenArrive(arg_5_0)
	return arg_5_0.arriveAction
end

function var_0_0.GetRotationWhenArrive(arg_6_0)
	if arg_6_0.config.turn_to == 0 then
		return 0
	end

	local var_6_0

	if not arg_6_0.config.rotation then
		var_6_0 = 0
	end

	return var_6_0
end

function var_0_0.DisappearWhenArrive(arg_7_0)
	return arg_7_0.config.disappear == 1
end

function var_0_0.GetStartNextOneTime(arg_8_0)
	local var_8_0

	if not arg_8_0.config.wait then
		var_8_0 = 0
	end

	return var_8_0
end

function var_0_0.BuildAction(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = #arg_9_1

	if arg_9_2 ~= "" then
		var_9_0 = var_9_0 + 1
	end

	if var_9_0 == 0 then
		return nil
	end

	math = var_1_10006

	local var_9_1 = var_1_10006.random(1, var_9_0)

	if var_5 and var_9_1 == var_9_0 then
		return {
			type = var_0_0.ACTION_TYPE_CHATBUBBLE,
			action = arg_9_2,
			time = arg_9_3
		}
	else
		return {
			type = var_0_0.ACTION_TYPE_ANIM,
			action = arg_9_1[var_9_1],
			time = arg_9_3
		}
	end

	return
end

return var_0_0
