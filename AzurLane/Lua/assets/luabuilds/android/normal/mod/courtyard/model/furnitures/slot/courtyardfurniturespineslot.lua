class = var_0_10000

local var_0_0 = "CourtYardFurnitureSpineSlot"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".CourtYardFurnitureBaseSlot"))
local var_0_2 = 0
local var_0_3 = 1
local var_0_4 = 2
local var_0_5 = 3

function var_0_1.OnInit(arg_1_0, arg_1_1)
	arg_1_0.name = arg_1_1[1][1]
	arg_1_0.defaultAction = arg_1_1[1][2]

	local var_1_0

	if arg_1_1[2] then
		var_1_0 = arg_1_1[2][1]
	end

	arg_1_0.mask = var_1_0

	if arg_1_0.mask then
		arg_1_0.maskDefaultAction = arg_1_1[2][2]
	end

	if arg_1_1[4] then
		if #arg_1_1[4] > 0 then
			local var_1_1 = {}

			if arg_1_1[4][1] then
				Vector3 = var_1_2

				local var_1_2

				if not var_1_2(arg_1_1[4][1][1], arg_1_1[4][1][2], 0) then
					Vector3 = var_1_2
					var_1_2 = var_1_2.zero
				end

				var_1_1.offset = var_1_2

				if arg_1_1[4][2] then
					Vector3 = var_1_3

					local var_1_3

					if not var_1_3(arg_1_1[4][2][1], arg_1_1[4][2][2], 0) then
						Vector3 = var_1_3
						var_1_3 = var_1_3.zero
					end

					var_1_1.size = var_1_3
					var_1_1.img = arg_1_1[4][3]

					if false then
						var_1_1 = false
					end

					if false then
						var_1_1 = true
					end

					arg_1_0.bodyMask = var_1_1

					if arg_1_1[5] then
						Vector3 = var_1_4

						local var_1_4

						if not var_1_4(arg_1_1[5][1], arg_1_1[5][2], 0) then
							Vector3 = var_1_4
							var_1_4 = var_1_4.zero
						end

						arg_1_0.offset = var_1_4

						if arg_1_1[6] then
							Vector3 = var_1_5

							local var_1_5

							if not var_1_5(arg_1_1[6][1], arg_1_1[6][2], 0) then
								Vector3 = var_1_5
								var_1_5 = var_1_5.one
							end

							arg_1_0.scale = var_1_5
							arg_1_0.substituteActions = {}
							arg_1_0.actions = {}
							arg_1_0.loop = false
							tobool = var_2

							local var_1_6

							if var_2(arg_1_1[3]) then
								tobool = var_1_6
								var_1_6 = var_1_6(arg_1_1[3][3])
							end

							arg_1_0.valid = var_1_6

							if arg_1_0.valid then
								arg_1_0.actions = arg_1_1[3][2]

								local var_1_7

								if not arg_1_1[3][3][2] then
									var_1_7 = var_0_2
								end

								if var_1_7 == true then
									var_1_7 = var_0_3
								end

								if arg_1_1[3][5] then
									var_1_7 = var_0_5
								end

								arg_1_0.strategyType = var_1_7
								arg_1_0.updateStrategy = arg_1_0:InitUpdateStrategy(var_1_7)
								arg_1_0.preheatAction = arg_1_1[3][3][3]
								arg_1_0.tailAction = arg_1_1[3][3][4]
								arg_1_0.loop = arg_1_1[3][4][1] == 1
								arg_1_0.variedActions = arg_1_1[3][5]
							end

							return
						end
					end
				end
			end
		end
	end
end

function var_0_1.OnInitCombine(arg_2_0, arg_2_1)
	arg_2_0.combineData = arg_2_1

	return
end

function var_0_1.InitUpdateStrategy(arg_3_0, arg_3_1)
	local var_3_0

	if arg_3_1 == var_0_3 then
		CourtYardFollowInteraction = var_3
		var_3_0 = var_3.New(arg_3_0)
	elseif arg_3_1 == var_0_4 then
		CourtYardMonglineInteraction = var_3
		var_3_0 = var_3.New(arg_3_0)
	elseif arg_3_1 == var_0_5 then
		CourtYardVariedInteraction = var_3
		var_3_0 = var_3.New(arg_3_0)
	else
		CourtYardInteraction = var_3
		var_3_0 = var_3.New(arg_3_0)
	end

	return var_3_0
end

function var_0_1.SetAnimators(arg_4_0, arg_4_1)
	local var_4_0

	if not arg_4_1[1][arg_4_0.id] and not var_2[1] then
		var_4_0 = {}
	end

	type = var_1_10004

	local var_4_1

	if var_1_10004(var_4_0) ~= "string" or not {
		var_4_0
	} then
		var_4_1 = var_4_0
	end

	ipairs = var_5

	for iter_4_0, iter_4_1 in var_5(var_4_1) do
		table = var_1_10010

		var_1_10010.insert(arg_4_0.animators, {
			key = arg_4_0.id .. "_" .. iter_4_0,
			value = iter_4_1
		})
	end

	return
end

function var_0_1.SetFollower(arg_5_0, arg_5_1)
	local var_5_0 = {
		bone = arg_5_1[1]
	}

	Vector3 = var_3
	var_5_0.scale = var_3(arg_5_1[2], 1, 1)
	arg_5_0.follower = var_5_0

	return
end

function var_0_1.SetSubstitute(arg_6_0, arg_6_1)
	_ = var_1_10002
	arg_6_0.substituteActions = var_1_10002.map(arg_6_1, function(arg_7_0)
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

function var_0_1.GetSubstituteAction(arg_8_0, arg_8_1, arg_8_2)
	local function var_8_0(arg_9_0)
		local var_9_0 = arg_8_0
		local var_9_1 = var_1.GetUser(var_9_0)

		if arg_9_0.math_mode == 1 then
			var_2_10003 = var_9_1

			local var_9_2

			if not var_9_1.GetSkinID(var_2_10003) then
				var_2_10003 = var_9_1
				var_9_2 = var_9_1.GetGroupID(var_2_10003)
			end

			table = var_2_10003

			local var_9_3

			if var_2_10003.contains(arg_9_0.match, var_9_2) then
				var_9_3 = arg_9_0.replace_mode == 0 or arg_9_0.replace_mode == arg_8_2
			end

			return var_9_3
		end
	end

	_ = var_1_10004

	local var_8_1

	if not var_1_10004.detect(arg_8_0.substituteActions, function(arg_10_0)
		return arg_10_0.action == arg_8_1 and var_8_0(arg_10_0)
	end) or not var_4.replace then
		var_8_1 = arg_8_1
	end

	return var_8_1
end

function var_0_1.GetUserSubstituteAction(arg_11_0, arg_11_1)
	return arg_11_0:GetSubstituteAction(arg_11_1, 1)
end

function var_0_1.GetOwnerSubstituteAction(arg_12_0, arg_12_1)
	return arg_12_0:GetSubstituteAction(arg_12_1, 2)
end

function var_0_1.IsEmpty(arg_13_0)
	local var_13_0

	if var_0_1.super.IsEmpty(arg_13_0) then
		var_13_0 = arg_13_0.valid
	end

	return var_13_0
end

function var_0_1.GetScale(arg_14_0)
	if arg_14_0.follower then
		return arg_14_0.follower.scale
	else
		return arg_14_0.scale
	end

	return
end

local function var_0_6(arg_15_0)
	local var_15_0 = {}
	local var_15_1 = {}
	local var_15_2 = {}
	local var_15_3 = arg_15_0.actions[1][2]
	local var_15_4 = arg_15_0.actions[1][3]

	ipairs = var_1_10006

	for iter_15_0, iter_15_1 in var_1_10006(arg_15_0.variedActions) do
		math = var_1_10011

		local var_15_5 = iter_15_1[var_1_10011.random(1, #iter_15_1)]

		table = var_13

		var_13.insert(var_15_0, var_15_5)

		table = var_13

		var_13.insert(var_15_1, var_15_4)

		table = var_13

		var_13.insert(var_15_2, var_15_3)
	end

	return var_15_0, var_15_1, var_15_2
end

local function var_0_7(arg_16_0)
	local var_16_0 = arg_16_0:GetCombineFurnitureAnimator()
	local var_16_1 = {}
	local var_16_2 = {}
	local var_16_3 = {}

	ipairs = var_1_10005

	for iter_16_0, iter_16_1 in var_1_10005(arg_16_0.actions) do
		local var_16_4 = iter_16_1[1]
		local var_16_5 = iter_16_1[3]

		var_16_4 = var_16_0 and var_16_0[3] and var_16_0[3][iter_16_0] or var_16_4
		type = var_1_10012

		if var_1_10012(var_16_4) == "table" then
			math = var_1_10012

			if not var_16_4[var_1_10012.random(1, #var_16_4)] then
				var_1_10012 = var_16_4
			end

			local var_16_6 = arg_16_0
			local var_16_7 = arg_16_0.GetOwnerSubstituteAction(var_16_6, var_1_10012)

			table = var_16_6

			var_16_6.insert(var_16_1, var_16_7)

			local var_16_8 = arg_16_0
			local var_16_9 = arg_16_0.GetUserSubstituteAction(var_16_8, var_16_5 or var_1_10012)

			table = var_16_8

			var_16_8.insert(var_16_2, var_16_9)

			table = var_15

			local var_16_10 = var_15.insert
			local var_16_11 = var_16_3

			tobool = var_17

			var_16_10(var_16_11, var_17(iter_16_1[2]))
		end
	end

	return var_16_1, var_16_2, var_16_3
end

function var_0_1.GetActions(arg_17_0)
	local var_17_0
	local var_17_1
	local var_17_2

	if arg_17_0.preheatAction then
		type = var_4

		if var_4(arg_17_0.preheatAction) == "string" then
			var_17_0, var_17_2 = arg_17_0.preheatAction, false

			goto label_17_0
		end
	end

	if arg_17_0.preheatAction then
		type = var_4

		if var_4(arg_17_0.preheatAction) == "table" then
			local var_17_3 = {}

			type = var_5

			if var_5(arg_17_0.preheatAction[1]) == "table" then
				ipairs = var_5

				for iter_17_0, iter_17_1 in var_5(arg_17_0.preheatAction[1]) do
					table = var_1_10010

					var_1_10010.insert(var_17_3, iter_17_1)
				end
			else
				table = var_5

				var_5.insert(var_17_3, arg_17_0.preheatAction[1])
			end

			local var_17_4 = 1
			local var_17_5 = arg_17_0
			local var_17_6 = arg_17_0.GetOwner(var_17_5)

			isa = var_17_5

			local var_17_7 = var_17_6

			CourtYardFurniture = iter_17_1

			if var_17_5(var_17_7, iter_17_1) then
				var_17_4 = #var_17_6:GetUsingSlots()
			end

			var_17_0, var_17_1, var_17_2 = var_17_3[var_17_4], arg_17_0.preheatAction[2], arg_17_0.preheatAction[3], arg_17_0.preheatAction[4], preheatOnlyHost
		end
	end

	::label_17_0::

	local var_17_8
	local var_17_9
	local var_17_10

	if arg_17_0.strategyType == var_0_5 then
		var_17_8, var_17_9, var_17_10 = var_0_6(arg_17_0)
	else
		var_17_8, var_17_9, var_17_10 = var_0_7(arg_17_0)
	end

	if var_17_2 then
		var_17_10[0] = true
	end

	local var_17_11 = var_17_8
	local var_17_12 = var_17_9
	local var_17_13 = var_17_10
	local var_17_14 = var_17_0
	local var_17_15 = var_17_1
	local var_17_16 = arg_17_0.tailAction

	preheatOnlyHost = var_1_10013

	return var_17_11, var_17_12, var_17_13, var_17_14, var_17_15, var_17_16, var_1_10013
end

function var_0_1.OnAwake(arg_18_0)
	if #arg_18_0.animators > 0 then
		math = var_1
		arg_18_0.animatorIndex = var_1.random(1, #arg_18_0.animators)
	end

	return
end

function var_0_1.OnStart(arg_19_0)
	local var_19_0 = arg_19_0.updateStrategy

	var_1.Update(var_19_0, arg_19_0.loop)

	return
end

function var_0_1.OnContinue(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0.updateStrategy

	var_2.StepEnd(var_20_0, arg_20_1)

	return
end

function var_0_1.Reset(arg_21_0)
	local var_21_0 = arg_21_0.updateStrategy

	var_1.Reset(var_21_0)

	return
end

function var_0_1.GetSpineDefaultAction(arg_22_0)
	if arg_22_0:GetCombineFurnitureAnimator() then
		local var_22_0

		if not var_1[2] then
			var_22_0 = arg_22_0.defaultAction
		end

		return var_22_0
	end

	return arg_22_0.defaultAction
end

function var_0_1.GetSpineMaskDefaultAcation(arg_23_0)
	return arg_23_0.maskDefaultAction
end

return var_0_1
