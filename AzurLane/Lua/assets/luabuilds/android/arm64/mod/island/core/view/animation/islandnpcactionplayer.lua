class = var_0_10000

local var_0_0 = "IslandNpcActionPlayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..IslandBaseUnit"))

function var_0_1.Resopon(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if not arg_1_1 or not arg_1_2 then
		return
	end

	local var_1_0 = arg_1_1.data
	local var_1_1, var_1_2 = var_4.GetResponeAction(var_1_0, arg_1_3)

	if not var_1_1 then
		return
	end

	pg = var_1_0

	local var_1_3 = var_1_0.GameTrackerMgr.GetInstance()
	local var_1_4 = var_6.Record

	GameTrackerBuilder = var_1_10009

	var_1_4(var_1_3, var_1_10009.BuildActionOp(1, arg_1_3, 2, arg_1_1.modelId, var_1_1, 1))

	seriesAsync = var_1_4

	var_1_4({
		function(arg_2_0)
			local var_2_0 = arg_1_0

			var_1.PlayBubble(var_2_0, arg_1_1, var_1_1)

			pg = var_1

			if not var_1.island_action_feedback[var_1_1].state_name then
				arg_2_0()

				return
			end

			local var_2_1 = arg_1_1

			var_2.PlayAnimation(var_2_1, var_1, 0.25, arg_2_0)

			return
		end
	}, function()
		if var_1_2 then
			local var_3_0 = arg_1_1.id
			local var_3_1 = arg_1_1.data

			if not var_1.ExistActionFeedback(var_3_1) then
				var_3_0 = 0
			end

			local var_3_2 = arg_1_0
			local var_3_3 = var_1.NotifiyMeditor

			IslandMediator = var_2_10004

			var_3_3(var_3_2, var_2_10004.NPC_ACTION_AWARD, var_3_0, arg_1_1.data.shipId, var_1_1)
		end

		return
	end)

	return
end

function var_0_1.PlayBubble(arg_4_0, arg_4_1, arg_4_2)
	pg = var_1_10003

	if not var_1_10003.island_action_feedback[arg_4_2].emoji or var_3.emoji == "" then
		return
	end

	local var_4_0 = 0

	type = var_1_10005

	local var_4_1

	if var_1_10005(var_3.emoji) == "table" then
		var_4_1 = var_3.emoji
		math = var_1_10006
		var_4_0 = var_4_1[var_1_10006.random(1, #var_4_1)]
	else
		var_4_0 = var_3.emoji
	end

	require = var_4_1

	local var_4_2 = var_4_1("nodecanvas.Task.NcPlayChatExpression").New(nil, {})

	var_6.DoAction(var_4_2, var_4_0, arg_4_1.id, arg_4_1.unitType, function()
		return
	end)

	return
end

function var_0_1.ResoponByRandom(arg_6_0, arg_6_1, arg_6_2)
	pg = var_1_10003

	if not var_1_10003.island_action[arg_6_2] then
		return
	end

	if not var_3.sigle_action_reply_type then
		return
	end

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.GetResponActionName
	local var_6_2

	if not var_3.chara_sigle_action_reply then
		var_6_2 = {}
	end

	if not var_6_1(var_6_0, var_6_2) then
		return
	end

	if #arg_6_0:CollectUnits(var_4, arg_6_1) <= 0 then
		return
	end

	arg_6_0:TurnToPlayer(var_6, arg_6_1)

	local var_6_3 = {}

	table = var_8

	var_8.insert(var_6_3, function(arg_7_0)
		onNextTick = var_2_10001

		var_2_10001(arg_7_0)

		return
	end)

	ipairs = var_8

	for iter_6_0, iter_6_1 in var_8(var_6) do
		table = var_1_10013

		var_1_10013.insert(var_6_3, function(arg_8_0)
			local var_8_0 = iter_6_1

			var_1.PlayAnimation(var_8_0, var_0, 0.25, arg_8_0)

			return
		end)
	end

	table = var_8

	var_8.insert(var_6_3, function(arg_9_0)
		onNextTick = var_2_10001

		var_2_10001(arg_9_0)

		return
	end)

	parallelAsync = var_8

	var_8(var_6_3, function()
		local var_10_0 = arg_6_0

		var_0.ResetUnits(var_10_0, var_0)

		return
	end)

	return
end

function var_0_1.GetResponActionName(arg_11_0, arg_11_1)
	if #arg_11_1 <= 0 then
		return
	end

	_ = var_2

	local var_11_0 = var_2.map(arg_11_1, function(arg_12_0)
		pg = var_2_10001

		return var_2_10001.island_action_feedback[arg_12_0].state_name
	end)

	math = var_3

	return var_11_0[var_3.random(1, #var_11_0)]
end

function var_0_1.TurnToPlayer(arg_13_0, arg_13_1, arg_13_2)
	local function var_13_0(arg_14_0, arg_14_1)
		local var_14_0 = arg_14_1.position - arg_14_0.position

		Quaternion = var_3

		local var_14_1 = var_3.LookRotation(var_14_0)

		Quaternion = var_2_10004
		arg_14_0.rotation = var_2_10004.Euler(0, var_14_1.eulerAngles.y, 0)

		return
	end

	ipairs = var_1_10004

	for iter_13_0, iter_13_1 in var_1_10004(arg_13_1) do
		if iter_13_1 then
			iter_13_1:StopMove()
			iter_13_1:PauseBt()
			var_13_0(iter_13_1._go.transform, arg_13_2._go.transform)
		end
	end

	return
end

function var_0_1.ResetUnits(arg_15_0, arg_15_1)
	ipairs = var_1_10002

	for iter_15_0, iter_15_1 in var_1_10002(arg_15_1) do
		if iter_15_1 then
			iter_15_1:SetupBt()
		end
	end

	return
end

function var_0_1.CollectUnits(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = {}

	pg = var_1_10004

	local var_16_1 = var_1_10004.island_set.single_action_respon_check_range.key_value_int

	IslandConst = var_1_10005

	if arg_16_1 == var_1_10005.ACTION_REPOSON_TYPE_NEAREST_ONE then
		arg_16_0:GetNearestUnit(var_16_0, arg_16_2, var_16_1)
	else
		IslandConst = var_5

		if arg_16_1 == var_5.ACTION_REPOSON_TYPE_NEAREST_FOLLOWER then
			arg_16_0:GetNearestFollower(var_16_0, arg_16_2, var_16_1)
		else
			IslandConst = var_5

			if arg_16_1 == var_5.ACTION_REPOSON_TYPE_ALL_FOLLOWER then
				arg_16_0:GetAllFollower(var_16_0, arg_16_2, var_16_1)
			else
				IslandConst = var_5

				if arg_16_1 == var_5.ACTION_REPOSON_TYPE_RANDOM_FOLLOWER then
					arg_16_0:GetRandomFollower(var_16_0, arg_16_2, var_16_1)
				end
			end
		end
	end

	return var_16_0
end

function var_0_1.GetNearestUnit(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = arg_17_0:GetView()
	local var_17_1 = var_4.GetAllUnits(var_17_0)
	local var_17_2 = {}

	ipairs = var_17_0

	for iter_17_0, iter_17_1 in var_17_0(var_17_1) do
		isa = var_1_10011
		var_1_10013 = iter_17_1
		IslandNpcUnit = var_1_10014

		if var_1_10011(var_1_10013, var_1_10014) then
			table = var_1_10011

			var_1_10011.insert(var_17_2, iter_17_1)
		end
	end

	if #var_17_2 <= 0 then
		return
	end

	local var_17_3

	math = var_7

	local var_17_4 = var_7.huge

	ipairs = var_8

	for iter_17_2, iter_17_3 in var_8(var_17_2) do
		Vector3 = var_1_10013

		if var_1_10013.Distance(iter_17_3._go.transform.position, arg_17_2._go.transform.position) <= arg_17_3 and var_1_10013 < var_17_4 then
			var_17_4 = var_1_10013
			var_17_3 = iter_17_3
		end
	end

	if var_17_3 then
		table = var_8

		var_8.insert(arg_17_1, var_17_3)
	end

	return
end

function var_0_1.GetNearestFollower(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_0:GetView()
	local var_18_1 = var_4.GetUnitListByKey

	IslandConst = var_1_10007

	local var_18_2 = var_18_1(var_18_0, var_1_10007.UNIT_LIST_FOLLOW)
	local var_18_3

	math = var_18_0

	local var_18_4 = var_18_0.huge

	ipairs = var_7

	for iter_18_0, iter_18_1 in var_7(var_18_2) do
		Vector3 = var_1_10012

		if var_1_10012.Distance(iter_18_1._go.transform.position, arg_18_2._go.transform.position) <= arg_18_3 and var_1_10012 < var_18_4 then
			var_18_4 = var_1_10012
			var_18_3 = iter_18_1
		end
	end

	if var_18_3 then
		table = var_7

		var_7.insert(arg_18_1, var_18_3)
	end

	return
end

function var_0_1.GetAllFollower(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = arg_19_0:GetView()
	local var_19_1 = var_4.GetUnitListByKey

	IslandConst = var_1_10007

	local var_19_2 = var_19_1(var_19_0, var_1_10007.UNIT_LIST_FOLLOW)

	ipairs = var_1_10005

	for iter_19_0, iter_19_1 in var_1_10005(var_19_2) do
		Vector3 = var_1_10010

		if var_1_10010.Distance(iter_19_1._go.transform.position, arg_19_2._go.transform.position) <= arg_19_3 then
			table = var_1_10011

			var_1_10011.insert(arg_19_1, iter_19_1)
		end
	end

	return
end

function var_0_1.GetRandomFollower(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = arg_20_0:GetView()
	local var_20_1 = var_4.GetUnitListByKey

	IslandConst = var_1_10007

	local var_20_2 = var_20_1(var_20_0, var_1_10007.UNIT_LIST_FOLLOW)
	local var_20_3 = {}

	ipairs = var_20_0

	for iter_20_0, iter_20_1 in var_20_0(var_20_2) do
		Vector3 = var_1_10011

		if var_1_10011.Distance(iter_20_1._go.transform.position, arg_20_2._go.transform.position) <= arg_20_3 then
			table = var_1_10012

			var_1_10012.insert(var_20_3, iter_20_1)
		end
	end

	if #var_20_3 <= 0 then
		return
	end

	math = var_6

	local var_20_4 = var_20_3[var_6.random(1, #var_20_3)]

	table = var_8

	var_8.insert(arg_20_1, var_20_4)

	return
end

return var_0_1
