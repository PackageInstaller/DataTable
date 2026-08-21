local var_0_0 = class("IslandWayPoint")

var_0_0.ACTION_TYPE_CHATBUBBLE = 1
var_0_0.ACTION_TYPE_ANIM = 2

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.config = pg.island_waypoint[arg_1_1]
	arg_1_0.position = BuildVector3(arg_1_0.config.position)
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

	return arg_6_0.config.rotation or 0
end

function var_0_0.DisappearWhenArrive(arg_7_0)
	return arg_7_0.config.disappear == 1
end

function var_0_0.GetStartNextOneTime(arg_8_0)
	return arg_8_0.config.wait or 0
end

function var_0_0.BuildAction(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = #arg_9_1
	local var_9_1 = arg_9_2 ~= ""

	if arg_9_2 ~= "" then
		var_9_0 = var_9_0 + 1
	end

	if var_9_0 == 0 then
		return nil
	end

	local var_9_2 = math.random(1, var_9_0)

	if var_9_1 and var_9_2 == var_9_0 then
		return {
			type = var_0_0.ACTION_TYPE_CHATBUBBLE,
			action = arg_9_2,
			time = arg_9_3
		}
	else
		return {
			type = var_0_0.ACTION_TYPE_ANIM,
			action = arg_9_1[var_9_2],
			time = arg_9_3
		}
	end

	return
end

return var_0_0
