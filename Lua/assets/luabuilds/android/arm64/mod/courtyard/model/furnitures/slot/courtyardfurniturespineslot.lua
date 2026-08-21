local var_0_0 = class("CourtYardFurnitureSpineSlot", import(".CourtYardFurnitureBaseSlot"))
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3

function var_0_0.OnInit(arg_1_0, arg_1_1)
	arg_1_0.name = arg_1_1[1][1]
	arg_1_0.defaultAction = arg_1_1[1][2]
	arg_1_0.mask = arg_1_1[2] and arg_1_1[2][1]

	if arg_1_0.mask then
		arg_1_0.maskDefaultAction = arg_1_1[2][2]
	end

	local var_1_0 = arg_1_1[4]

	if arg_1_1[4] then
		if #arg_1_1[4] > 0 then
			var_1_0 = {}
			var_1_0.offset = arg_1_1[4][1] and Vector3(arg_1_1[4][1][1], arg_1_1[4][1][2], 0) or Vector3.zero
			var_1_0.size = arg_1_1[4][2] and Vector3(arg_1_1[4][2][1], arg_1_1[4][2][2], 0) or Vector3.zero
			var_1_0.img = arg_1_1[4][3]
		else
			var_1_0 = false
		end
	end

	if false then
		var_1_0 = true
	end

	arg_1_0.bodyMask = var_1_0
	arg_1_0.offset = arg_1_1[5] and Vector3(arg_1_1[5][1], arg_1_1[5][2], 0) or Vector3.zero
	arg_1_0.scale = arg_1_1[6] and Vector3(arg_1_1[6][1], arg_1_1[6][2], 0) or Vector3.one
	arg_1_0.substituteActions = {}
	arg_1_0.actions = {}
	arg_1_0.loop = false
	arg_1_0.valid = tobool(arg_1_1[3]) and tobool(arg_1_1[3][3])

	if arg_1_0.valid then
		arg_1_0.actions = arg_1_1[3][2]

		local var_1_1 = arg_1_1[3][3][2] or var_0_1

		if var_1_1 == true then
			var_1_1 = var_0_2
		end

		if arg_1_1[3][5] then
			var_1_1 = var_0_4
		end

		arg_1_0.strategyType = var_1_1
		arg_1_0.updateStrategy = arg_1_0:InitUpdateStrategy(var_1_1)
		arg_1_0.preheatAction = arg_1_1[3][3][3]
		arg_1_0.tailAction = arg_1_1[3][3][4]
		arg_1_0.loop = arg_1_1[3][4][1] == 1
		arg_1_0.variedActions = arg_1_1[3][5]
	end

	return
end

function var_0_0.OnInitCombine(arg_2_0, arg_2_1)
	arg_2_0.combineData = arg_2_1

	return
end

function var_0_0.InitUpdateStrategy(arg_3_0, arg_3_1)
	return arg_3_1 == var_0_2 and CourtYardFollowInteraction.New(arg_3_0) or arg_3_1 == var_0_3 and CourtYardMonglineInteraction.New(arg_3_0) or arg_3_1 == var_0_4 and CourtYardVariedInteraction.New(arg_3_0) or CourtYardInteraction.New(arg_3_0)
end

function var_0_0.SetAnimators(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1[1][arg_4_0.id] or arg_4_1[1][1] or {}

	if type(var_4_0) == "string" then
		local var_4_1 = {
			var_4_0
		}

		if not {
			var_4_0
		} then
			var_4_1 = var_4_0
		end

		for iter_4_0, iter_4_1 in ipairs(var_4_1) do
			table.insert(arg_4_0.animators, {
				key = arg_4_0.id .. "_" .. iter_4_0,
				value = iter_4_1
			})
		end

		return
	end
end

function var_0_0.SetFollower(arg_5_0, arg_5_1)
	arg_5_0.follower = {
		bone = arg_5_1[1],
		scale = Vector3(arg_5_1[2], 1, 1)
	}

	return
end

function var_0_0.SetSubstitute(arg_6_0, arg_6_1)
	arg_6_0.substituteActions = _.map(arg_6_1, function(arg_7_0)
		return {
			action = arg_7_0[1],
			match = arg_7_0[2],
			replace = arg_7_0[3],
			replace_mode = arg_7_0[4],
			math_mode = arg_7_0[5]
		}
	end)

	return
end

function var_0_0.GetSubstituteAction(arg_8_0, arg_8_1, arg_8_2)
	local function var_8_0(arg_9_0)
		local var_9_0 = arg_8_0:GetUser()
		local var_9_1 = arg_9_0.math_mode == 1 and var_9_0:GetSkinID() or var_9_0:GetGroupID()

		return table.contains(arg_9_0.match, var_9_1) and (arg_9_0.replace_mode == 0 or arg_9_0.replace_mode == arg_8_2)
	end

	local var_8_1 = _.detect(arg_8_0.substituteActions, function(arg_10_0)
		return arg_10_0.action == arg_8_1 and var_8_0(arg_10_0)
	end)

	if var_8_1 then
		return var_8_1.replace or arg_8_1
	end
end

function var_0_0.GetUserSubstituteAction(arg_11_0, arg_11_1)
	return arg_11_0:GetSubstituteAction(arg_11_1, 1)
end

function var_0_0.GetOwnerSubstituteAction(arg_12_0, arg_12_1)
	return arg_12_0:GetSubstituteAction(arg_12_1, 2)
end

function var_0_0.IsEmpty(arg_13_0)
	return var_0_0.super.IsEmpty(arg_13_0) and arg_13_0.valid
end

function var_0_0.GetScale(arg_14_0)
	if arg_14_0.follower then
		return arg_14_0.follower.scale
	else
		return arg_14_0.scale
	end

	return
end

local function var_0_5(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0.variedActions) do
		table.insert({}, iter_15_1[math.random(1, #iter_15_1)])
		table.insert({}, arg_15_0.actions[1][3])
		table.insert({}, arg_15_0.actions[1][2])
	end

	return {}, {}, {}
end

local function var_0_6(arg_16_0)
	local var_16_0 = arg_16_0:GetCombineFurnitureAnimator()
	local var_16_1 = {}
	local var_16_2 = {}
	local var_16_3 = {}

	for iter_16_0, iter_16_1 in ipairs(arg_16_0.actions) do
		local var_16_4 = iter_16_1[1]
		local var_16_5 = iter_16_1[3]

		var_16_4 = var_16_0 and var_16_0[3] and var_16_0[3][iter_16_0] or var_16_4

		local var_16_6 = type(var_16_4) == "table" and var_16_4[math.random(1, #var_16_4)] or var_16_4

		table.insert(var_16_1, (arg_16_0:GetOwnerSubstituteAction(var_16_6)))
		table.insert(var_16_2, (arg_16_0:GetUserSubstituteAction(var_16_5 or var_16_6)))
		table.insert(var_16_3, tobool(iter_16_1[2]))
	end

	return var_16_1, var_16_2, var_16_3
end

function var_0_0.GetActions(arg_17_0)
	local var_17_0
	local var_17_1
	local var_17_2

	if arg_17_0.preheatAction and type(arg_17_0.preheatAction) == "string" then
		var_17_2 = false
		var_17_0 = arg_17_0.preheatAction
	elseif arg_17_0.preheatAction and type(arg_17_0.preheatAction) == "table" then
		local var_17_3 = {}

		if type(arg_17_0.preheatAction[1]) == "table" then
			for iter_17_0, iter_17_1 in ipairs(arg_17_0.preheatAction[1]) do
				table.insert(var_17_3, iter_17_1)
			end
		else
			table.insert(var_17_3, arg_17_0.preheatAction[1])
		end

		local var_17_4 = 1
		local var_17_5 = arg_17_0:GetOwner()

		if isa(var_17_5, CourtYardFurniture) then
			var_17_4 = #var_17_5:GetUsingSlots()
		end

		var_17_0, var_17_1, var_17_2, preheatOnlyHost = var_17_3[var_17_4], arg_17_0.preheatAction[2], arg_17_0.preheatAction[3], arg_17_0.preheatAction[4]
	end

	local var_17_6
	local var_17_7
	local var_17_8

	if arg_17_0.strategyType == var_0_4 then
		var_17_6, var_17_7, var_17_8 = var_0_5(arg_17_0)
	else
		var_17_6, var_17_7, var_17_8 = var_0_6(arg_17_0)
	end

	if var_17_2 then
		var_17_8[0] = true
	end

	return var_17_6, var_17_7, var_17_8, var_17_0, var_17_1, arg_17_0.tailAction, preheatOnlyHost
end

function var_0_0.OnAwake(arg_18_0)
	if #arg_18_0.animators > 0 then
		arg_18_0.animatorIndex = math.random(1, #arg_18_0.animators)
	end

	return
end

function var_0_0.OnStart(arg_19_0)
	arg_19_0.updateStrategy:Update(arg_19_0.loop)

	return
end

function var_0_0.OnContinue(arg_20_0, arg_20_1)
	arg_20_0.updateStrategy:StepEnd(arg_20_1)

	return
end

function var_0_0.Reset(arg_21_0)
	arg_21_0.updateStrategy:Reset()

	return
end

function var_0_0.GetSpineDefaultAction(arg_22_0)
	local var_22_0 = arg_22_0:GetCombineFurnitureAnimator()

	if var_22_0 then
		return var_22_0[2] or arg_22_0.defaultAction
	end

	return arg_22_0.defaultAction
end

function var_0_0.GetSpineMaskDefaultAcation(arg_23_0)
	return arg_23_0.maskDefaultAction
end

return var_0_0
