class = var_0_10000

local var_0_0 = var_0_10000("PileGameController")

var_0_0.STATE_IDLE = 0
var_0_0.STATE_PREPARE = 1
var_0_0.STATE_START = 2
var_0_0.STATE_DROPING = 3
var_0_0.STATE_STOP_DROP = 4
var_0_0.STATE_SINK = 5
var_0_0.STATE_SINK_DONE = 6
var_0_0.STATE_STOP_SHAKE = 7
var_0_0.STATE_END = 8
var_0_0.STATE_EXIT = 9
var_0_0.DROP_AREA_SAFE = 1
var_0_0.DROP_AREA_WARN = 2
var_0_0.DROP_AREA_DANGER = 3

function var_0_0.Ctor(arg_1_0)
	PileGameModel = var_1_10001
	arg_1_0.model = var_1_10001.New(arg_1_0)
	PileGameView = var_1
	arg_1_0.view = var_1.New(arg_1_0)
	arg_1_0.state = var_0_0.STATE_IDLE
	arg_1_0.locked = false
	arg_1_0.time = 0
	arg_1_0.shakePositions = {}

	return
end

function var_0_0.SetUp(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0.model

	var_3.NetData(var_2_0, arg_2_1)

	local var_2_1 = arg_2_0.view

	var_3.OnEnterGame(var_2_1, arg_2_1)

	arg_2_0.gameEndCb = arg_2_2

	return
end

function var_0_0.StartGame(arg_3_0)
	seriesAsync = var_1_10001

	var_1_10001({
		function(arg_4_0)
			arg_3_0.locked = false

			local var_4_0 = arg_3_0

			var_1.OnInitGame(var_4_0)

			local var_4_1 = arg_3_0.view

			var_1.DoCurtain(var_4_1, arg_4_0)

			if arg_3_0.gameStateCallback then
				arg_3_0.gameStateCallback(false)
			end

			return
		end,
		function(arg_5_0)
			local var_5_0 = arg_3_0

			var_1.OnPrepare(var_5_0, arg_5_0)

			return
		end,
		function(arg_6_0)
			arg_3_0.state = var_0_0.STATE_PREPARE

			local var_6_0 = arg_3_0.view

			var_1.OnGameStart(var_6_0)

			return
		end
	})

	return
end

function var_0_0.setGameStartCallback(arg_7_0, arg_7_1)
	arg_7_0.gameStateCallback = arg_7_1

	return
end

function var_0_0.ExitGame(arg_8_0)
	arg_8_0.locked = false
	arg_8_0.shakePositions = {}
	arg_8_0.state = var_0_0.STATE_EXIT
	ipairs = var_1

	for iter_8_0, iter_8_1 in var_1(arg_8_0.model.items) do
		local var_8_0 = arg_8_0.view

		var_6.OnRemovePile(var_8_0, iter_8_1)
	end

	if arg_8_0.gameStateCallback then
		arg_8_0.gameStateCallback(true)
	end

	local var_8_1 = arg_8_0.model

	var_1.Clear(var_8_1)

	local var_8_2 = arg_8_0.view

	var_1.OnGameExited(var_8_2)

	return
end

function var_0_0.Drop(arg_9_0)
	if arg_9_0.state == var_0_0.STATE_START and not arg_9_0.locked then
		arg_9_0.state = var_0_0.STATE_DROPING

		arg_9_0:OnStartDrop()
	end

	return
end

function var_0_0.OnInitGame(arg_10_0)
	if not arg_10_0.handle then
		UpdateBeat = var_1
		arg_10_0.handle = var_1:CreateListener(arg_10_0.Update, arg_10_0)
	end

	UpdateBeat = var_1

	var_1:AddListener(arg_10_0.handle)

	local var_10_0 = arg_10_0.model

	var_1.AddDeathLineRight(var_10_0)

	local var_10_1 = arg_10_0.model

	var_1.AddDeathLineLeft(var_10_1)

	local var_10_2 = arg_10_0.model

	var_1.AddSafeLineRight(var_10_2)

	local var_10_3 = arg_10_0.model

	var_1.AddSafeLineLeft(var_10_3)

	local var_10_4 = arg_10_0.model

	var_1.AddGround(var_10_4)

	local var_10_5 = arg_10_0.view

	var_1.InitSup(var_10_5, arg_10_0.model)

	return
end

function var_0_0.OnPrepare(arg_11_0, arg_11_1)
	seriesAsync = var_1_10002

	var_1_10002({
		function(arg_12_0)
			local var_12_0 = arg_11_0.view

			var_1.UpdateScore(var_12_0, arg_11_0.model.score)

			local var_12_1 = arg_11_0.view

			var_1.UpdateFailedCnt(var_12_1, arg_11_0.model.maxFailedCnt, arg_11_0.model.failedCnt)
			arg_12_0()

			return
		end,
		function(arg_13_0)
			local var_13_0 = arg_11_0
			local var_13_1 = arg_11_0.model

			var_13_0.item = var_2.AddHeadPile(var_13_1)

			local var_13_2 = arg_11_0.item

			Vector3 = var_2
			var_13_2.position = var_2(0, -arg_11_0.model.screen.y / 2, 0)

			local var_13_3 = arg_11_0.view

			var_1.AddPile(var_13_3, arg_11_0.item, true, function()
				local var_14_0 = arg_11_0.view

				var_0.OnItemPositionChange(var_14_0, arg_11_0.item)
				arg_13_0()

				return
			end)

			return
		end,
		function(arg_15_0)
			local var_15_0 = arg_11_0.item
			local var_15_1 = arg_11_0
			local var_15_2 = arg_11_0.model

			var_15_1.item = var_3.AddPileByRandom(var_15_2)

			local var_15_3 = arg_11_0.item

			Vector3 = var_3
			var_15_3.position = var_3(0, -arg_11_0.model.screen.y / 2 + var_15_0.sizeDelta.y, 0)

			local var_15_4 = arg_11_0.view

			var_2.AddPile(var_15_4, arg_11_0.item, false, function()
				local var_16_0 = arg_11_0.view

				var_0.OnItemPositionChange(var_16_0, arg_11_0.item)
				arg_15_0()

				return
			end)

			return
		end
	}, arg_11_1)

	return
end

function var_0_0.OnStartGame(arg_17_0, arg_17_1)
	local function var_17_0()
		arg_17_0.state = var_0_0.STATE_SINK_DONE

		local var_18_0 = arg_17_0
		local var_18_1 = arg_17_0.model

		var_18_0.item = var_1.AddPileByRandom(var_18_1)

		local var_18_2 = arg_17_0.view

		var_0.AddPile(var_18_2, arg_17_0.item, false, function()
			arg_17_0.state = var_0_0.STATE_START

			return
		end)

		return
	end

	local var_17_1 = arg_17_0.model

	if var_3.ShouldSink(var_17_1) then
		arg_17_0.state = var_0_0.STATE_SINK

		arg_17_0:DoSink(var_17_0)
	else
		var_17_0()
	end

	arg_17_0:RemoveLockTimer()

	if arg_17_1 then
		arg_17_0.locked = true
		Timer = var_3

		local var_17_2 = var_3.New

		local function var_17_3()
			arg_17_0.locked = false

			return
		end

		PileGameConst = var_1_10005
		arg_17_0.lockTimer = var_17_2(var_17_3, var_1_10005.BAN_OP_TIME, 1)

		local var_17_4 = arg_17_0.lockTimer

		var_3.Start(var_17_4)
	end

	return
end

function var_0_0.RemoveLockTimer(arg_21_0)
	if arg_21_0.lockTimer then
		local var_21_0 = arg_21_0.lockTimer

		var_1.Stop(var_21_0)

		arg_21_0.lockTimer = nil
	end

	return
end

function var_0_0.OnEndGame(arg_22_0, arg_22_1)
	arg_22_0.state = var_0_0.STATE_END
	arg_22_0.time = 0
	arg_22_0.shakePositions = {}
	arg_22_0.locked = false

	local function var_22_0()
		local var_23_0 = arg_22_0.view

		var_0.OnGameEnd(var_23_0, arg_22_0.model.score, arg_22_0.model.highestScore)

		if arg_22_0.model.score > arg_22_0.model.highestScore then
			local var_23_1 = arg_22_0.model

			var_0.UpdateHighestScore(var_23_1)
		end

		arg_22_0.model.score = 0

		return
	end

	if arg_22_0.gameEndCb then
		arg_22_0.gameEndCb(arg_22_0.model.score, arg_22_0.model.highestScore)
	end

	if arg_22_1 then
		local var_22_1 = arg_22_0.model
		local var_22_2 = var_3.GetFirstItem(var_22_1).position.x
		local var_22_3 = arg_22_0.item.position.x > 0 and 1 or 0
		local var_22_4 = arg_22_0.view

		var_6.OnCollapse(var_22_4, var_22_2, var_22_3, var_22_0)
	else
		var_22_0()
	end

	return
end

function var_0_0.Update(arg_24_0)
	if arg_24_0.state == var_0_0.STATE_PREPARE then
		arg_24_0:OnStartGame()
	elseif arg_24_0.state == var_0_0.STATE_START then
		arg_24_0:Shuffling()
	elseif arg_24_0.state == var_0_0.STATE_DROPING then
		arg_24_0:Droping()
	elseif arg_24_0.state == var_0_0.STATE_STOP_DROP then
		arg_24_0:CheckCollide()
	end

	if #arg_24_0.shakePositions > 0 then
		arg_24_0:DoShake()
	end

	if arg_24_0.state >= var_0_0.STATE_START and arg_24_0.state < var_0_0.STATE_END then
		local var_24_0 = arg_24_0.time

		PileGameConst = var_2

		local var_24_1

		if var_2.PLAY_SPE_ACTION_TIME <= var_24_0 then
			var_24_1 = arg_24_0

			arg_24_0.PlaySpeAction(var_24_1)

			arg_24_0.time = 0
		end

		local var_24_2 = arg_24_0.time

		Time = var_24_1
		arg_24_0.time = var_24_2 + var_24_1.deltaTime
	end

	return
end

function var_0_0.PlaySpeAction(arg_25_0)
	pairs = var_1_10001

	for iter_25_0, iter_25_1 in var_1_10001(arg_25_0.model.items) do
		if iter_25_1 ~= arg_25_0.item then
			local var_25_0 = arg_25_0.view

			var_6.PlaySpeAction(var_25_0, iter_25_1)
		end
	end

	return
end

function var_0_0.StopShake(arg_26_0)
	ipairs = var_1_10001

	for iter_26_0, iter_26_1 in var_1_10001(arg_26_0.shakePositions) do
		iter_26_1[1].onTheMove = false
	end

	arg_26_0.shakePositions = {}

	return
end

function var_0_0.CheckRock(arg_27_0)
	local var_27_0 = arg_27_0.model
	local var_27_1 = var_1.GetTailItem(var_27_0)
	local var_27_2 = arg_27_0.model

	if var_2.GetDropArea(var_27_2, var_27_1) == var_0_0.DROP_AREA_WARN then
		local var_27_3 = arg_27_0.model

		arg_27_0.shakePositions = var_4.GetInitPos(var_27_3)
	end

	return
end

function var_0_0.DoShake(arg_28_0)
	Time = var_1_10001

	local var_28_0 = var_1_10001.deltaTime

	PileGameConst = var_1_10002

	local var_28_1 = var_28_0 * var_1_10002.SHAKE_SPEED
	local var_28_2 = arg_28_0.shakePositions[1][1].position

	ipairs = var_1_10003

	for iter_28_0, iter_28_1 in var_1_10003(arg_28_0.shakePositions) do
		local var_28_3 = iter_28_1[1]
		local var_28_4 = iter_28_1[2]
		local var_28_5 = iter_28_1[3]

		Vector3 = var_1_10011
		var_1_10011 = var_1_10011(var_28_4, var_28_3.position.y, 0)
		Vector3 = var_12

		local var_28_6 = var_12(var_28_5, var_28_3.position.y, 0)

		if var_28_3.onTheMove == true then
			Vector3 = var_13
			var_28_3.position = var_13.MoveTowards(var_28_3.position, var_1_10011, var_28_1)
		else
			Vector3 = var_13
			var_28_3.position = var_13.MoveTowards(var_28_3.position, var_28_6, var_28_1)
		end

		if var_28_3.position.x == var_28_6.x and var_28_3.onTheMove == false then
			var_28_3.onTheMove = true
		elseif var_28_3.position.x == var_1_10011.x and var_28_3.onTheMove == true then
			var_28_3.onTheMove = false
		end

		local var_28_7 = arg_28_0.view

		var_13.OnItemPositionChange(var_28_7, var_28_3)
	end

	if arg_28_0.shakePositions[1][1].position.x ~= var_28_2.x then
		local var_28_8 = arg_28_0.view

		var_4.OnShake(var_28_8, var_3.x - var_28_2.x)
	end

	return
end

function var_0_0.DoSink(arg_29_0, arg_29_1)
	local var_29_0 = {}

	for iter_29_0 = 1, #arg_29_0.model.items do
		table = var_1_10007

		var_1_10007.insert(var_29_0, function(arg_30_0)
			local var_30_0 = arg_29_0.model
			local var_30_1

			var_30_1.position, var_30_1 = var_1.GetNextPos(var_30_0, iter_29_0), arg_29_0.model.items[iter_29_0]

			local var_30_2 = arg_29_0.view

			var_3.OnItemPositionChangeWithAnim(var_30_2, var_30_1, arg_30_0)

			return
		end)
	end

	parallelAsync = var_3

	var_3({
		function(arg_31_0)
			seriesAsync = var_2_10001

			var_2_10001(var_29_0, arg_31_0)

			return
		end,
		function(arg_32_0)
			local var_32_0 = arg_29_0.model
			local var_32_1 = var_1.GetFirstItem(var_32_0)
			local var_32_2 = arg_29_0.view

			var_2.DoSink(var_32_2, var_32_1.sizeDelta.y, arg_32_0)

			return
		end
	}, function()
		local var_33_0 = arg_29_0.model
		local var_33_1 = var_0.RemoveFirstItem(var_33_0)
		local var_33_2 = arg_29_0.view

		var_1.OnRemovePile(var_33_2, var_33_1)
		arg_29_1()

		return
	end)

	return
end

function var_0_0.Shuffling(arg_34_0)
	Time = var_1_10001

	local var_34_0 = var_1_10001.deltaTime * arg_34_0.item.speed
	local var_34_1 = arg_34_0.item.leftMaxPosition
	local var_34_2 = arg_34_0.item.rightMaxPosition

	if arg_34_0.item.onTheMove == false then
		local var_34_3 = arg_34_0.item

		Vector3 = var_1_10005
		var_34_3.position = var_1_10005.MoveTowards(arg_34_0.item.position, var_34_2, var_34_0)
	else
		local var_34_4 = arg_34_0.item

		Vector3 = var_1_10005
		var_34_4.position = var_1_10005.MoveTowards(arg_34_0.item.position, var_34_1, var_34_0)
	end

	if arg_34_0.item.position.x == var_34_2.x and arg_34_0.item.onTheMove == false then
		arg_34_0.item.onTheMove = true
	elseif arg_34_0.item.position.x == var_34_1.x and arg_34_0.item.onTheMove == true then
		arg_34_0.item.onTheMove = false
	end

	local var_34_5 = arg_34_0.view

	var_4.OnItemPositionChange(var_34_5, arg_34_0.item)

	local var_34_6 = arg_34_0.view

	var_4.OnItemIndexPositionChange(var_34_6, arg_34_0.item)

	return
end

function var_0_0.OnStartDrop(arg_35_0)
	local var_35_0 = arg_35_0.model

	if var_1.GetDropArea(var_35_0, arg_35_0.item) then
		local var_35_1 = arg_35_0.model
		local var_35_2 = var_2.CanDropOnPrev(var_35_1, arg_35_0.item)
		local var_35_3 = arg_35_0.view

		var_3.OnStartDrop(var_35_3, arg_35_0.item, var_1, var_35_2)
	end

	return
end

function var_0_0.Droping(arg_36_0)
	Time = var_1_10001

	local var_36_0 = var_1_10001.deltaTime * arg_36_0.item.dropSpeed

	arg_36_0.item.onTheMove = false

	local var_36_1 = arg_36_0.model.ground.position.y - 100

	Vector3 = var_3

	local var_36_2 = var_3(arg_36_0.item.position.x, var_36_1, 0)
	local var_36_3 = arg_36_0.item

	Vector3 = var_5
	var_36_3.position = var_5.MoveTowards(arg_36_0.item.position, var_36_2, var_36_0)

	local var_36_4 = arg_36_0.view

	var_4.OnItemPositionChange(var_36_4, arg_36_0.item)

	local var_36_5 = arg_36_0.model

	if var_4.IsOverTailItem(var_36_5, arg_36_0.item) and #arg_36_0.shakePositions > 0 then
		arg_36_0:StopShake()
	end

	local var_36_6 = arg_36_0.model

	if var_4.IsStopDrop(var_36_6, arg_36_0.item) then
		arg_36_0.state = var_0_0.STATE_STOP_DROP
	end

	return
end

function var_0_0.CheckCollide(arg_37_0)
	local var_37_0 = arg_37_0.model
	local var_37_1 = var_1.IsOnGround(var_37_0, arg_37_0.item)
	local var_37_2 = arg_37_0.model
	local var_37_3 = var_2.GetIndex(var_37_2) == 1
	local var_37_4 = arg_37_0.model
	local var_37_5 = var_3.IsOverDeathLine(var_37_4, arg_37_0.item)

	if var_37_3 and var_37_1 then
		arg_37_0:OnStartGame(true)
	elseif not var_37_3 and var_37_1 then
		local var_37_6 = arg_37_0.model

		var_37_4.AddFailedCnt(var_37_6)

		local var_37_7 = arg_37_0.view

		var_37_4.UpdateFailedCnt(var_37_7, arg_37_0.model.maxFailedCnt, arg_37_0.model.failedCnt, true, arg_37_0.item)

		local var_37_8 = arg_37_0.model

		var_37_4.RemoveTailItem(var_37_8)

		local var_37_9 = arg_37_0.view

		var_37_4.OnRemovePile(var_37_9, arg_37_0.item)

		local var_37_10 = arg_37_0.model

		if var_37_4.IsMaxfailedCnt(var_37_10) then
			arg_37_0:OnEndGame(false)
		else
			arg_37_0:CheckRock()
			arg_37_0:OnStartGame(true)
		end
	elseif not var_37_1 and var_37_5 then
		arg_37_0:OnEndGame(true)
	elseif not var_37_1 and not var_37_5 then
		local var_37_11 = arg_37_0.model

		var_37_4.AddScore(var_37_11)

		local var_37_12 = arg_37_0.model

		if var_37_4.IsExceedingTheHighestScore(var_37_12) then
			local var_37_13 = arg_37_0.view

			var_37_4.OnExceedingTheHighestScore(var_37_13)
		end

		local var_37_14 = arg_37_0.view

		var_37_4.UpdateScore(var_37_14, arg_37_0.model.score, arg_37_0.item)
		arg_37_0:CheckRock()
		arg_37_0:OnStartGame(true)
	else
		assert = var_37_4

		var_37_4(false, "Why is it running here?")
	end

	return
end

function var_0_0.onBackPressed(arg_38_0)
	local var_38_0 = arg_38_0.view

	return var_1.onBackPressed(var_38_0)
end

function var_0_0.Dispose(arg_39_0)
	arg_39_0.gameEndCb = nil
	arg_39_0.locked = false

	if arg_39_0.handle then
		UpdateBeat = var_1

		var_1:RemoveListener(arg_39_0.handle)
	end

	arg_39_0:ExitGame()

	local var_39_0 = arg_39_0.model

	var_1.Dispose(var_39_0)

	local var_39_1 = arg_39_0.view

	var_1.Dispose(var_39_1)
	arg_39_0:RemoveLockTimer()

	arg_39_0.shakePositions = {}

	return
end

return var_0_0
