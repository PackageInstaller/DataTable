local var_0_0 = class("IslandStrollUnitVO", import(".IslandUnitVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.shipId = arg_1_1

	var_0_0.super.Ctor(arg_1_0, {
		name = "StrollNpc",
		id = arg_1_2,
		type = IslandConst.UNIT_TYPE_STROLL,
		modelId = arg_1_3 or pg.island_strollnpc[arg_1_2].unit_id,
		behaviourTree = arg_1_0:GetDefaultBt(pg.island_strollnpc[arg_1_2]),
		position = {
			0,
			0,
			0
		},
		rotation = {
			0,
			0,
			0
		},
		scale = {
			0,
			0,
			0
		}
	})

	arg_1_0.config = pg.island_strollnpc[arg_1_2]
	arg_1_0.actionFeedback = nil
	arg_1_0.skillActionFeedback = nil

	return
end

function var_0_0.GetShipId(arg_2_0)
	return arg_2_0.shipId
end

function var_0_0.IsSameShip(arg_3_0, arg_3_1)
	return arg_3_0.shipId == arg_3_1
end

function var_0_0.SetSkillActionFeedback(arg_4_0, arg_4_1)
	arg_4_0.skillActionFeedback = arg_4_1

	return
end

function var_0_0.ClearSkillActionFeedback(arg_5_0)
	arg_5_0.skillActionFeedback = nil

	return
end

function var_0_0.ExistSkillActionFeedback(arg_6_0)
	return arg_6_0.skillActionFeedback ~= nil
end

function var_0_0.SetActionFeedback(arg_7_0, arg_7_1)
	arg_7_0.actionFeedback = arg_7_1

	return
end

function var_0_0.ExistActionFeedback(arg_8_0)
	return arg_8_0.actionFeedback ~= nil
end

function var_0_0.ClearActionFeedback(arg_9_0)
	arg_9_0.actionFeedback = nil

	return
end

function var_0_0.GetGreetingFeedback(arg_10_0)
	return arg_10_0.actionFeedback or arg_10_0.skillActionFeedback
end

function var_0_0.ExistGreetingActionFeedback(arg_11_0)
	return arg_11_0:GetGreetingFeedback() ~= nil
end

function var_0_0.ClearGreetingActionFeedback(arg_12_0)
	arg_12_0.actionFeedback = nil
	arg_12_0.skillActionFeedback = nil

	return
end

function var_0_0.OnlySkillActionFeedback(arg_13_0)
	return not arg_13_0:ExistActionFeedback() and arg_13_0:ExistSkillActionFeedback()
end

local function var_0_1(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		if pg.island_action_feedback[iter_14_1].feedback_type == arg_14_0 then
			table.insert({}, iter_14_1)
		end
	end

	if #{} <= 0 then
		return nil
	end

	return ({})[math.random(1, #{})]
end

function var_0_0.GetResponeAction(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:GetGreetingFeedback()
	local var_15_1 = pg.island_action[arg_15_1].feedback_type

	if var_15_0 and var_15_0 == arg_15_1 then
		return var_0_1(var_15_1, pg.island_action_feedback.get_id_list_by_condition[1]), true
	else
		return var_0_1(var_15_1, pg.island_action_feedback.get_id_list_by_condition[2]), false
	end

	return
end

function var_0_0.GetDefaultBt(arg_16_0, arg_16_1)
	if not arg_16_1.behaviourTree or arg_16_1.behaviourTree == "" then
		return "Island/NodeCanvas/Npc/StrollNpc"
	end

	return arg_16_1.behaviourTree
end

function var_0_0.GetDefaultPathId(arg_17_0, arg_17_1)
	local var_17_0 = _.detect(arg_17_0.config.mapId, function(arg_18_0)
		return arg_18_0[1] == arg_17_1
	end)

	return var_17_0 and var_17_0[2]
end

function var_0_0.SetPath(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0.position = BuildVector3(arg_19_2)
	arg_19_0.pathId = arg_19_1

	return
end

function var_0_0.GetPath(arg_20_0)
	return arg_20_0.pathId
end

return var_0_0
