class = var_0_10000

local var_0_0 = "IslandStrollUnitVO"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandUnitVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	pg = var_1_10004

	local var_1_0 = var_1_10004.island_strollnpc[arg_1_2]

	arg_1_0.shipId = arg_1_1

	local var_1_1 = var_0_1.super.Ctor
	local var_1_2 = arg_1_0
	local var_1_3 = {
		name = "StrollNpc",
		id = arg_1_2
	}

	IslandConst = var_1_10009
	var_1_3.type = var_1_10009.UNIT_TYPE_STROLL
	var_1_3.modelId = arg_1_3 or var_1_0.unit_id
	var_1_3.behaviourTree = arg_1_0:GetDefaultBt(var_1_0)
	var_1_3.position = {
		0,
		0,
		0
	}
	var_1_3.rotation = {
		0,
		0,
		0
	}
	var_1_3.scale = {
		0,
		0,
		0
	}

	var_1_1(var_1_2, var_1_3)

	arg_1_0.config = var_1_0
	arg_1_0.actionFeedback = nil
	arg_1_0.skillActionFeedback = nil

	return
end

function var_0_1.GetShipId(arg_2_0)
	return arg_2_0.shipId
end

function var_0_1.IsSameShip(arg_3_0, arg_3_1)
	return arg_3_0.shipId == arg_3_1
end

function var_0_1.SetSkillActionFeedback(arg_4_0, arg_4_1)
	arg_4_0.skillActionFeedback = arg_4_1

	return
end

function var_0_1.ClearSkillActionFeedback(arg_5_0)
	arg_5_0.skillActionFeedback = nil

	return
end

function var_0_1.ExistSkillActionFeedback(arg_6_0)
	return arg_6_0.skillActionFeedback ~= nil
end

function var_0_1.SetActionFeedback(arg_7_0, arg_7_1)
	arg_7_0.actionFeedback = arg_7_1

	return
end

function var_0_1.ExistActionFeedback(arg_8_0)
	return arg_8_0.actionFeedback ~= nil
end

function var_0_1.ClearActionFeedback(arg_9_0)
	arg_9_0.actionFeedback = nil

	return
end

function var_0_1.GetGreetingFeedback(arg_10_0)
	local var_10_0

	if not arg_10_0.actionFeedback then
		var_10_0 = arg_10_0.skillActionFeedback
	end

	return var_10_0
end

function var_0_1.ExistGreetingActionFeedback(arg_11_0)
	return arg_11_0:GetGreetingFeedback() ~= nil
end

function var_0_1.ClearGreetingActionFeedback(arg_12_0)
	arg_12_0.actionFeedback = nil
	arg_12_0.skillActionFeedback = nil

	return
end

function var_0_1.OnlySkillActionFeedback(arg_13_0)
	return not arg_13_0:ExistActionFeedback() and arg_13_0:ExistSkillActionFeedback()
end

local function var_0_2(arg_14_0, arg_14_1)
	local var_14_0 = {}

	ipairs = var_1_10003

	for iter_14_0, iter_14_1 in var_1_10003(arg_14_1) do
		pg = var_1_10008

		if var_1_10008.island_action_feedback[iter_14_1].feedback_type == arg_14_0 then
			table = var_9

			var_9.insert(var_14_0, iter_14_1)
		end
	end

	if #var_14_0 <= 0 then
		return nil
	end

	math = var_3

	return var_14_0[var_3.random(1, #var_14_0)]
end

function var_0_1.GetResponeAction(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.GetGreetingFeedback(var_15_0) and var_2 == arg_15_1

	pg = var_15_0

	local var_15_2 = var_15_0.island_action[arg_15_1].feedback_type

	if var_15_1 then
		pg = var_1_10006
		var_1_10006 = var_1_10006.island_action_feedback.get_id_list_by_condition[1]

		return var_0_2(var_15_2, var_1_10006), true
	else
		pg = var_1_10006

		local var_15_3 = var_1_10006.island_action_feedback.get_id_list_by_condition[2]

		return var_0_2(var_15_2, var_15_3), false
	end

	return
end

function var_0_1.GetDefaultBt(arg_16_0, arg_16_1)
	if not arg_16_1.behaviourTree or arg_16_1.behaviourTree == "" then
		return "Island/NodeCanvas/Npc/StrollNpc"
	end

	return arg_16_1.behaviourTree
end

function var_0_1.GetDefaultPathId(arg_17_0, arg_17_1)
	_ = var_1_10002

	return var_1_10002.detect(arg_17_0.config.mapId, function(arg_18_0)
		return arg_18_0[1] == arg_17_1
	end) and var_2[2]
end

function var_0_1.SetPath(arg_19_0, arg_19_1, arg_19_2)
	BuildVector3 = var_1_10003
	arg_19_0.position = var_1_10003(arg_19_2)
	arg_19_0.pathId = arg_19_1

	return
end

function var_0_1.GetPath(arg_20_0)
	return arg_20_0.pathId
end

return var_0_1
