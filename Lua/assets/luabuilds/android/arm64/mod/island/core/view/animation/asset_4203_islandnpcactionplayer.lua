local IslandNpcActionPlayer = class("IslandNpcActionPlayer", import("..IslandBaseUnit"))

function IslandNpcActionPlayer:Resopon(arg_1_1, arg_1_2, arg_1_3)
	if not arg_1_1 or not arg_1_2 then
		return
	end

	local var_1_0, var_1_1 = arg_1_1.data:GetResponeAction(arg_1_3)

	if not var_1_0 then
		return
	end

	pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildActionOp(1, arg_1_3, 2, arg_1_1.modelId, var_1_0, 1))
	seriesAsync({
		function(arg_2_0)
			self:PlayBubble(arg_1_1, var_1_0)

			if not pg.island_action_feedback[var_1_0].state_name then
				arg_2_0()

				return
			end

			arg_1_1:PlayAnimation(pg.island_action_feedback[var_1_0].state_name, 0.25, arg_2_0)

			return
		end
	}, function()
		if var_1_1 then
			self:NotifiyMeditor(IslandMediator.NPC_ACTION_AWARD, (not arg_1_1.data:ExistActionFeedback() or nil) and 0, arg_1_1.data.shipId, var_1_0)
		end

		return
	end)

	return
end

function IslandNpcActionPlayer:PlayBubble(arg_4_1, arg_4_2)
	if not pg.island_action_feedback[arg_4_2].emoji or pg.island_action_feedback[arg_4_2].emoji == "" then
		return
	end

	require("nodecanvas.Task.NcPlayChatExpression").New(nil, {}):DoAction(type(pg.island_action_feedback[arg_4_2].emoji) == "table" and pg.island_action_feedback[arg_4_2].emoji[math.random(1, #pg.island_action_feedback[arg_4_2].emoji)] or pg.island_action_feedback[arg_4_2].emoji, arg_4_1.id, arg_4_1.unitType, function()
		return
	end)

	return
end

function IslandNpcActionPlayer:ResoponByRandom(arg_6_1, arg_6_2)
	if not pg.island_action[arg_6_2] then
		return
	end

	local var_6_0 = pg.island_action[arg_6_2].sigle_action_reply_type

	if not pg.island_action[arg_6_2].sigle_action_reply_type then
		return
	end

	local var_6_1 = self:GetResponActionName(pg.island_action[arg_6_2].chara_sigle_action_reply or {})

	if not var_6_1 then
		return
	end

	local var_6_2 = self:CollectUnits(var_6_0, arg_6_1)

	if #var_6_2 <= 0 then
		return
	end

	self:TurnToPlayer(var_6_2, arg_6_1)

	local var_6_3 = {}

	table.insert(var_6_3, function(arg_7_0)
		onNextTick(arg_7_0)

		return
	end)

	for iter_6_0, iter_6_1 in ipairs(var_6_2) do
		table.insert(var_6_3, function(arg_8_0)
			iter_6_1:PlayAnimation(var_6_1, 0.25, arg_8_0)

			return
		end)
	end

	table.insert(var_6_3, function(arg_9_0)
		onNextTick(arg_9_0)

		return
	end)
	parallelAsync(var_6_3, function()
		self:ResetUnits(var_6_2)

		return
	end)

	return
end

function IslandNpcActionPlayer:GetResponActionName(arg_11_1)
	if #arg_11_1 <= 0 then
		return
	end

	local var_11_0 = _.map(arg_11_1, function(arg_12_0)
		return pg.island_action_feedback[arg_12_0].state_name
	end)

	return var_11_0[math.random(1, #var_11_0)]
end

function IslandNpcActionPlayer:TurnToPlayer(arg_13_1, arg_13_2)
	local function var_13_0(arg_14_0, arg_14_1)
		arg_14_0.rotation = Quaternion.Euler(0, Quaternion.LookRotation(arg_14_1.position - arg_14_0.position).eulerAngles.y, 0)

		return
	end

	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		if iter_13_1 then
			iter_13_1:StopMove()
			iter_13_1:PauseBt()
			var_13_0(iter_13_1._go.transform, arg_13_2._go.transform)
		end
	end

	return
end

function IslandNpcActionPlayer:ResetUnits(arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		if iter_15_1 then
			iter_15_1:SetupBt()
		end
	end

	return
end

function IslandNpcActionPlayer:CollectUnits(arg_16_1, arg_16_2)
	local var_16_0 = {}

	if arg_16_1 == IslandConst.ACTION_REPOSON_TYPE_NEAREST_ONE then
		self:GetNearestUnit(var_16_0, arg_16_2, pg.island_set.single_action_respon_check_range.key_value_int)
	elseif arg_16_1 == IslandConst.ACTION_REPOSON_TYPE_NEAREST_FOLLOWER then
		self:GetNearestFollower(var_16_0, arg_16_2, pg.island_set.single_action_respon_check_range.key_value_int)
	elseif arg_16_1 == IslandConst.ACTION_REPOSON_TYPE_ALL_FOLLOWER then
		self:GetAllFollower(var_16_0, arg_16_2, pg.island_set.single_action_respon_check_range.key_value_int)
	elseif arg_16_1 == IslandConst.ACTION_REPOSON_TYPE_RANDOM_FOLLOWER then
		self:GetRandomFollower(var_16_0, arg_16_2, pg.island_set.single_action_respon_check_range.key_value_int)
	end

	return var_16_0
end

function IslandNpcActionPlayer:GetNearestUnit(arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in ipairs((self:GetView():GetAllUnits())) do
		if isa(iter_17_1, IslandNpcUnit) then
			table.insert(var_17_0, iter_17_1)
		end
	end

	if #var_17_0 <= 0 then
		return
	end

	local var_17_1

	for iter_17_2, iter_17_3 in ipairs(var_17_0) do
		local var_17_2 = Vector3.Distance(iter_17_3._go.transform.position, arg_17_2._go.transform.position)

		if var_17_2 <= arg_17_3 and var_17_2 < math.huge then
			var_17_1 = iter_17_3
		end
	end

	if var_17_1 then
		table.insert(arg_17_1, var_17_1)
	end

	return
end

function IslandNpcActionPlayer:GetNearestFollower(arg_18_1, arg_18_2, arg_18_3)
	local var_18_0

	for iter_18_0, iter_18_1 in ipairs((self:GetView():GetUnitListByKey(IslandConst.UNIT_LIST_FOLLOW))) do
		local var_18_1 = Vector3.Distance(iter_18_1._go.transform.position, arg_18_2._go.transform.position)

		if var_18_1 <= arg_18_3 and var_18_1 < math.huge then
			var_18_0 = iter_18_1
		end
	end

	if var_18_0 then
		table.insert(arg_18_1, var_18_0)
	end

	return
end

function IslandNpcActionPlayer:GetAllFollower(arg_19_1, arg_19_2, arg_19_3)
	for iter_19_0, iter_19_1 in ipairs((self:GetView():GetUnitListByKey(IslandConst.UNIT_LIST_FOLLOW))) do
		if arg_19_3 >= Vector3.Distance(iter_19_1._go.transform.position, arg_19_2._go.transform.position) then
			table.insert(arg_19_1, iter_19_1)
		end
	end

	return
end

function IslandNpcActionPlayer:GetRandomFollower(arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = {}

	for iter_20_0, iter_20_1 in ipairs((self:GetView():GetUnitListByKey(IslandConst.UNIT_LIST_FOLLOW))) do
		if arg_20_3 >= Vector3.Distance(iter_20_1._go.transform.position, arg_20_2._go.transform.position) then
			table.insert(var_20_0, iter_20_1)
		end
	end

	if #var_20_0 <= 0 then
		return
	end

	table.insert(arg_20_1, var_20_0[math.random(1, #var_20_0)])

	return
end

return IslandNpcActionPlayer
