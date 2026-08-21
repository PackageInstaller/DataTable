local var_0_0 = class("CourtYardTransportSlot", import(".CourtYardFurnitureBaseSlot"))

function var_0_0.OnInit(arg_1_0, arg_1_1)
	arg_1_0.name = arg_1_1[1][1]
	arg_1_0.defaultAction = arg_1_1[1][2]
	arg_1_0.actions = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1[2]) do
		table.insert(arg_1_0.actions, {
			userAction = iter_1_1[1],
			ownerAction = iter_1_1[2],
			time = iter_1_1[3]
		})
	end

	arg_1_0.animators = {}

	return
end

function var_0_0.SetAnimators(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		table.insert(arg_2_0.animators, {
			key = arg_2_0.id .. "_" .. iter_2_0,
			value = iter_2_1
		})
	end

	return
end

function var_0_0.GetSpineDefaultAction(arg_3_0)
	return arg_3_0.defaultAction
end

function var_0_0.OnAwake(arg_4_0)
	arg_4_0.animatorIndex = arg_4_0.index

	return
end

function var_0_0.OnStart(arg_5_0)
	arg_5_0.user:UpdateInteraction({
		action = arg_5_0.actions[arg_5_0.index].userAction,
		slot = arg_5_0
	})
	arg_5_0.owner:UpdateInteraction({
		action = arg_5_0.actions[arg_5_0.index].ownerAction,
		slot = arg_5_0
	})
	Timer.New(function()
		arg_5_0:End()

		return
	end, arg_5_0.actions[arg_5_0.index].time, 1):Start()

	return
end

function var_0_0.Occupy(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.index = 1

	var_0_0.super.Occupy(arg_7_0, arg_7_1, arg_7_2, arg_7_3)

	return
end

function var_0_0.Link(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0.index = 2

	var_0_0.super.Occupy(arg_8_0, arg_8_1, arg_8_2, arg_8_3)

	return
end

function var_0_0.IsFirstTime(arg_9_0)
	return arg_9_0.index == 1
end

return var_0_0
