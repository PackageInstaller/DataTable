class = var_0_10000

local var_0_0 = var_0_10000("TowerClimbingMapVO")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.view = arg_1_2
	arg_1_0.nextBlockIndex = 0
	arg_1_0.level = 0
	arg_1_0.higestLevel = 0
	arg_1_0.id = arg_1_1
	assert = var_3

	var_3(arg_1_0.id, arg_1_1)

	return
end

function var_0_0.Init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.mapWidth = arg_2_1.screenWidth
	arg_2_0.mapHeight = arg_2_1.screenHeight
	arg_2_0.awards = arg_2_1.awards[arg_2_0.id]
	seriesAsync = var_3

	var_3({
		function(arg_3_0)
			local var_3_0 = arg_2_0

			var_1.InitBlock(var_3_0, arg_3_0)

			return
		end,
		function(arg_4_0)
			local var_4_0 = arg_2_0

			var_1.InitPlayer(var_4_0, arg_2_1, arg_4_0)

			return
		end,
		function(arg_5_0)
			local var_5_0 = arg_2_0

			var_1.InitGround(var_5_0, arg_2_1, arg_5_0)

			return
		end,
		function(arg_6_0)
			local var_6_0 = arg_2_0.blocks[1]

			assert = var_2_10002

			var_2_10002(var_6_0)

			local var_6_1 = arg_2_0.player

			var_2.SetPosition(var_6_1, var_6_0.position)

			local var_6_2 = arg_2_0

			var_2.SendMapEvent(var_6_2, "OnPlayerLifeUpdate", arg_2_0.player.life)
			arg_6_0()

			return
		end
	}, arg_2_2)

	return
end

function var_0_0.InitGround(arg_7_0, arg_7_1, arg_7_2)
	TowerClimbingGameSettings = var_1_10003

	local var_7_0 = var_1_10003.MANJUU_START_POS

	arg_7_0.ground = {
		sleepTime = 0,
		IsRuning = false,
		position = var_7_0,
		name = arg_7_1.npcName
	}

	arg_7_0:SendMapEvent("OnCreateGround", arg_7_0.ground, arg_7_2)

	return
end

function var_0_0.InitBlock(arg_8_0, arg_8_1)
	arg_8_0.blocks = {}

	local var_8_0 = {}

	TowerClimbingGameSettings = var_1_10003

	local var_8_1 = var_1_10003.GetBlockInitCnt(arg_8_0.mapHeight)

	for iter_8_0 = 1, var_8_1 do
		table = var_1_10008

		var_1_10008.insert(var_8_0, function(arg_9_0)
			local var_9_0 = arg_8_0
			local var_9_1 = var_1.CreateBlock(var_9_0)

			table = var_9_0

			var_9_0.insert(arg_8_0.blocks, var_9_1)

			local var_9_2 = arg_8_0

			var_2.SendMapEvent(var_9_2, "OnCreateBlock", var_9_1, arg_9_0)

			return
		end)
	end

	parallelAsync = var_4

	var_4(var_8_0, arg_8_1)

	return
end

local function var_0_1(arg_10_0, arg_10_1)
	if arg_10_0 == 1 then
		TowerClimbingGameSettings = var_1_10002

		return var_1_10002.HEAD_BLOCK_TYPE
	else
		TowerClimbingGameSettings = var_1_10002

		local var_10_0 = var_1_10002.MapId2BlockType[arg_10_1]

		assert = var_1_10003

		var_1_10003(var_10_0, arg_10_1)

		math = var_1_10003

		local var_10_1 = var_1_10003.random(1, 100)

		ipairs = var_4

		for iter_10_0, iter_10_1 in var_4(var_10_0) do
			if var_10_1 <= iter_10_1[2] then
				return iter_10_1[1]
			end
		end

		assert = var_4

		var_4(false)
	end

	return
end

local function var_0_2(arg_11_0, arg_11_1)
	if not arg_11_1 then
		TowerClimbingGameSettings = var_1_10002

		return var_1_10002.BLOCK_START_POSITION
	else
		local var_11_0 = arg_11_1.position
		local var_11_1 = arg_11_1.width

		TowerClimbingGameSettings = var_1_10004

		local var_11_2 = var_1_10004.BLOCK_INTERVAL_HEIGHT

		TowerClimbingGameSettings = var_1_10005

		local var_11_3 = var_1_10005.BLOCK_MAX_INTERVAL_WIDTH[1]

		TowerClimbingGameSettings = var_1_10006

		local var_11_4 = var_1_10006.BLOCK_MAX_INTERVAL_WIDTH[2]

		TowerClimbingGameSettings = var_1_10007

		local var_11_5 = var_1_10007.BOUNDS[1]

		TowerClimbingGameSettings = var_1_10008

		local var_11_6 = var_1_10008.BOUNDS[2]
		local var_11_7 = {}

		if var_11_3 < var_11_6 - (var_11_0.x + var_11_1 / 2) - arg_11_0 then
			math = var_1_10012

			local var_11_8 = var_1_10012.min(var_11_4, var_11)
			local var_11_9 = var_11_3

			if 0 <= var_11 then
				var_11_9 = 0
			end

			math = var_14

			local var_11_10 = var_14.random(var_11_9, var_11_8)

			table = var_15

			var_15.insert(var_11_7, var_10 + var_11_10 + arg_11_0 / 2)
		end

		local var_11_11 = var_11_0.x - var_11_1 / 2

		math = var_13

		local var_11_12

		if var_11_3 < var_13.abs(var_11_5 - var_11_11) - arg_11_0 then
			math = var_11_12
			var_11_12 = var_11_12.min(var_11_4, var_13)

			local var_11_13 = var_11_3

			if 0 <= var_13 then
				var_11_13 = 0
			end

			math = var_16

			local var_11_14 = var_16.random(var_11_13, var_11_12)

			table = var_17

			var_17.insert(var_11_7, var_11_11 - var_11_14 - arg_11_0 / 2)
		end

		assert = var_11_12

		var_11_12(#var_11_7 > 0, var_11 .. " & " .. var_13 .. " - " .. arg_11_0 .. " - " .. var_11_0.x .. "-" .. var_11_1)

		math = var_11_12

		local var_11_15 = var_11_12.random(1, #var_11_7)

		Vector2 = var_15

		return var_15(var_11_7[var_11_15], var_11_0.y + var_11_2)
	end

	return
end

function var_0_0.CreateBlock(arg_12_0)
	arg_12_0.nextBlockIndex = arg_12_0.nextBlockIndex + 1

	local var_12_0 = arg_12_0.blocks[#arg_12_0.blocks]
	local var_12_1 = var_0_1(arg_12_0.nextBlockIndex, arg_12_0.id)
	local var_12_2 = var_0_2(var_12_1[2], var_12_0)

	return {
		id = arg_12_0.nextBlockIndex,
		type = var_12_1[1],
		width = var_12_1[2],
		position = var_12_2,
		isActive = not var_12_0,
		level = arg_12_0.nextBlockIndex
	}
end

function var_0_0.ActicveNextBlock(arg_13_0, arg_13_1)
	ipairs = var_1_10002

	for iter_13_0, iter_13_1 in var_1_10002(arg_13_0.blocks) do
		if iter_13_1.level == arg_13_1 then
			iter_13_1.isActive = true

			arg_13_0:SendMapEvent("OnActiveBlock", iter_13_1)

			local var_13_0 = arg_13_0.player

			if var_7.IsInvincible(var_13_0) then
				arg_13_0:SendMapEvent("OnEnableStab", iter_13_1, false)
			end

			break
		end
	end

	return
end

function var_0_0.DeactiveAboveBlocks(arg_14_0, arg_14_1)
	ipairs = var_1_10002

	for iter_14_0, iter_14_1 in var_1_10002(arg_14_0.blocks) do
		if arg_14_1 < iter_14_1.level and iter_14_1.isActive == true then
			iter_14_1.isActive = false

			arg_14_0:SendMapEvent("OnActiveBlock", iter_14_1)
		end
	end

	return
end

function var_0_0.AddNewBlock(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.CreateBlock(var_15_0)

	table = var_15_0

	var_15_0.insert(arg_15_0.blocks, var_15_1)
	arg_15_0:SendMapEvent("OnCreateBlock", var_15_1, arg_15_1)

	return
end

function var_0_0.DoSink(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = {}

	table = var_1_10005

	var_1_10005.insert(var_16_0, function(arg_17_0)
		local var_17_0 = arg_16_0
		local var_17_1 = var_1.SendMapEvent
		local var_17_2 = "SinkHandler"

		TowerClimbingGameSettings = var_2_10004

		var_17_1(var_17_0, var_17_2, var_2_10004.SINK_DISTANCE * arg_16_2)

		return
	end)

	table = var_5

	var_5.insert(var_16_0, 1, function(arg_18_0)
		if not arg_16_0.ground.IsRuning then
			arg_18_0()

			return
		end

		local var_18_0 = arg_16_0.ground.position.y

		TowerClimbingGameSettings = var_2_10003

		local var_18_1 = var_18_0 - var_2_10003.SINK_DISTANCE * arg_16_2
		local var_18_2 = arg_16_0.ground

		Vector2 = var_4
		var_18_2.position = var_4(var_1.x, var_18_1)

		local var_18_3 = arg_16_0

		var_3.SendMapEvent(var_18_3, "OnGroundPositionChange", arg_16_0.ground.position)
		arg_18_0()

		return
	end)

	parallelAsync = var_5

	var_5(var_16_0, arg_16_3)

	return
end

function var_0_0.CheckCorssBoundBlocks(arg_19_0, arg_19_1)
	local var_19_0 = 0

	for iter_19_0 = #arg_19_0.blocks, 1, -1 do
		local var_19_1

		if arg_19_0.blocks[iter_19_0].position.y <= var_19_0 then
			var_19_1 = var_7.level
			table = var_1_10009

			var_1_10009.remove(arg_19_0.blocks, iter_19_0)
			arg_19_0:SendMapEvent("OnBlockDestory", var_19_1)
		else
			TowerClimbingGameSettings = var_19_1

			local var_19_2 = var_19_1.MANJUU_HEIGHT + arg_19_0.ground.position.y

			if var_7.position.y <= var_19_2 then
				var_7.isActive = false

				arg_19_0:SendMapEvent("OnActiveBlock", var_7)
			end
		end
	end

	arg_19_1()

	return
end

function var_0_0.InitPlayer(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_1.life
	local var_20_1 = arg_20_1.score
	local var_20_2 = arg_20_1.shipId
	local var_20_3 = arg_20_1.higestscore
	local var_20_4 = arg_20_1.pageIndex
	local var_20_5 = arg_20_1.mapScores[arg_20_0.id]

	TowerClimbingPlayerVO = var_9
	arg_20_0.player = var_9.New(arg_20_0.view, {
		id = var_20_2,
		life = var_20_0,
		score = var_20_1,
		higestscore = var_20_3,
		pageIndex = var_20_4,
		mapScore = var_20_5
	})

	arg_20_0:SendMapEvent("OnCreatePlayer", arg_20_0.player, arg_20_2)

	return
end

function var_0_0.GetPlayer(arg_21_0)
	return arg_21_0.player
end

function var_0_0.GetBlocks(arg_22_0)
	return arg_22_0.blocks
end

function var_0_0.SetCurrentLevel(arg_23_0, arg_23_1)
	if arg_23_1 > arg_23_0.level then
		arg_23_0:ActicveNextBlock(arg_23_1 + 1)
	elseif arg_23_1 < arg_23_0.level then
		arg_23_0:DeactiveAboveBlocks(arg_23_1 + 1)
	end

	arg_23_0.level = arg_23_1

	if arg_23_1 > arg_23_0.higestLevel then
		local var_23_0 = arg_23_1 - arg_23_0.higestLevel

		arg_23_0.higestLevel = arg_23_1

		local var_23_1 = arg_23_0.player

		var_3.AddScore(var_23_1)
		arg_23_0:DoCheck(var_23_0)
		arg_23_0:OverHigestScore()
	end

	return
end

function var_0_0.OverHigestScore(arg_24_0)
	local function var_24_0(arg_25_0)
		ipairs = var_2_10001

		for iter_25_0, iter_25_1 in var_2_10001(arg_24_0.awards) do
			if arg_25_0 == iter_25_1 then
				return true
			end
		end

		return false
	end

	local var_24_1 = arg_24_0.player

	if var_2.IsOverHigestScore(var_24_1) and var_24_0(arg_24_0.player.score) then
		arg_24_0:SendMapEvent("OnReachAwardScore")
	end

	return
end

function var_0_0.DoCheck(arg_26_0, arg_26_1)
	if arg_26_0.higestLevel <= 1 then
		return
	end

	seriesAsync = var_2

	var_2({
		function(arg_27_0)
			local var_27_0 = arg_26_0

			var_1.AddNewBlock(var_27_0, arg_27_0)

			return
		end,
		function(arg_28_0)
			parallelAsync = var_2_10001

			var_2_10001({
				function(arg_29_0)
					local var_29_0 = arg_26_0

					var_1.DoSink(var_29_0, arg_26_0.higestLevel, arg_26_1, arg_29_0)

					return
				end,
				function(arg_30_0)
					TowerClimbingGameSettings = var_3_10001

					local var_30_0 = var_3_10001.SINK_DISTANCE * arg_26_1
					local var_30_1 = arg_26_0

					var_2.SendMapEvent(var_30_1, "OnSink", var_30_0, arg_30_0)

					return
				end
			}, arg_28_0)

			return
		end,
		function(arg_31_0)
			local var_31_0 = arg_26_0

			var_1.CheckCorssBoundBlocks(var_31_0, arg_31_0)

			return
		end,
		function(arg_32_0)
			local var_32_0 = arg_26_0

			var_1.CheckGroundState(var_32_0)
			arg_32_0()

			return
		end
	})

	return
end

function var_0_0.CheckGroundState(arg_33_0)
	if not arg_33_0.ground.IsRuning then
		local var_33_0 = arg_33_0.higestLevel

		TowerClimbingGameSettings = var_1_10002

		if var_33_0 >= var_1_10002.GROUND_RISE_UP_LEVEL then
			arg_33_0.ground.IsRuning = true

			arg_33_0:SendMapEvent("OnGroundRuning")
		end
	end

	return
end

function var_0_0.ReBornPlayer(arg_34_0)
	local var_34_0 = {}
	local var_34_1

	ipairs = var_1_10003

	for iter_34_0, iter_34_1 in var_1_10003(arg_34_0.blocks) do
		if iter_34_1.isActive then
			table = var_8

			var_8.insert(var_34_0, iter_34_1)
		end
	end

	assert = var_3

	var_3(#var_34_0 > 0)

	_ = var_3

	local var_34_2

	if not var_3.detect(var_34_0, function(arg_35_0)
		return arg_35_0.level == arg_34_0.higestLevel
	end) then
		table = var_4

		var_4.sort(var_34_0, function(arg_36_0, arg_36_1)
			return arg_36_0.position.y > arg_36_1.position.y
		end)

		var_34_2 = var_34_0[1]
	end

	local var_34_3 = arg_34_0.player
	local var_34_4 = var_4.SetPosition
	local var_34_5 = var_34_2.position

	Vector2 = iter_34_1

	var_34_4(var_34_3, var_34_5 + iter_34_1(0, 10))

	return
end

function var_0_0.AddPlayerInvincibleEffect(arg_37_0, arg_37_1)
	ipairs = var_1_10002

	for iter_37_0, iter_37_1 in var_1_10002(arg_37_0.blocks) do
		if iter_37_1.isActive then
			arg_37_0:SendMapEvent("OnEnableStab", iter_37_1, not arg_37_1)
		end
	end

	if arg_37_0.ground.IsRuning then
		arg_37_0:SendMapEvent("OnEnableGround", not arg_37_1)
	end

	return
end

local function var_0_3(arg_38_0)
	TowerClimbingGameSettings = var_1_10001

	local var_38_0 = var_1[#var_1_10001.GROUND_RISE_UP_SPEED][2]

	ipairs = var_1_10003

	for iter_38_0, iter_38_1 in var_1_10003(var_1) do
		if arg_38_0 < iter_38_1[1] then
			var_38_0 = iter_38_1[2]

			break
		end
	end

	return var_38_0
end

function var_0_0.Update(arg_39_0)
	if arg_39_0.ground.sleepTime > 0 then
		local var_39_0 = arg_39_0.ground
		local var_39_1 = arg_39_0.ground.sleepTime

		Time = var_1_10003
		var_39_0.sleepTime = var_39_1 - var_1_10003.deltaTime

		arg_39_0:SendMapEvent("OnGroundSleepTimeChange", arg_39_0.ground.sleepTime)
	end

	if arg_39_0.ground.IsRuning and arg_39_0.ground.sleepTime <= 0 then
		local var_39_2 = arg_39_0.ground.position
		local var_39_3 = var_0_3(arg_39_0.higestLevel)
		local var_39_4 = arg_39_0.ground

		Vector2 = var_1_10004

		local var_39_5 = var_39_2.x
		local var_39_6 = var_39_2.y

		Time = var_1_10007
		var_39_4.position = var_1_10004(var_39_5, var_39_6 + var_39_3 * var_1_10007.deltaTime)

		arg_39_0:SendMapEvent("OnGroundPositionChange", arg_39_0.ground.position)
	end

	local var_39_7 = arg_39_0.player

	if var_1.IsInvincible(var_39_7) then
		local var_39_8 = arg_39_0.player
		local var_39_9 = var_1.GetInvincibleTime(var_39_8)

		TowerClimbingGameSettings = var_39_8

		if var_39_9 == var_39_8.INVINCEIBLE_TIME then
			arg_39_0:AddPlayerInvincibleEffect(true)
		end

		Time = var_2

		local var_39_10 = var_39_9 - var_2.deltaTime
		local var_39_11 = arg_39_0.player

		var_3.SetInvincibleTime(var_39_11, var_39_10)

		local var_39_12 = arg_39_0.player

		if not var_3.IsInvincible(var_39_12) then
			arg_39_0:AddPlayerInvincibleEffect(false)
		end
	end

	return
end

function var_0_0.SetGroundSleep(arg_40_0, arg_40_1)
	if arg_40_0.ground.IsRuning then
		local var_40_0 = arg_40_0.ground

		Vector2 = var_1_10003

		local var_40_1 = arg_40_0.ground.position.x
		local var_40_2 = arg_40_0.ground.position.y

		TowerClimbingGameSettings = var_1_10006
		var_40_0.position = var_1_10003(var_40_1, var_40_2 - var_1_10006.GROUND_SLIDE_DOWNWARD_DISTANCE)

		arg_40_0:SendMapEvent("OnGroundPositionChange", arg_40_0.ground.position)

		arg_40_0.ground.sleepTime = arg_40_1
	end

	return
end

function var_0_0.SendMapEvent(arg_41_0, arg_41_1, ...)
	local var_41_0 = arg_41_0.view.map[arg_41_1]
	local var_41_1 = var_2

	unpack = var_1_10005

	var_41_0(var_41_1, var_1_10005({
		...
	}))

	return
end

function var_0_0.Dispose(arg_42_0)
	if arg_42_0.player then
		local var_42_0 = arg_42_0.player

		var_1.Dispose(var_42_0)

		arg_42_0.player = nil
	end

	if arg_42_0.ground then
		arg_42_0.ground = nil
	end

	if arg_42_0.blocks then
		arg_42_0.blocks = nil
	end

	return
end

return var_0_0
