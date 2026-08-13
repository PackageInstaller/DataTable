class = var_0_10000

local var_0_0 = var_0_10000("RacingMiniGameController")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.binder = arg_1_1

	arg_1_0:InitTimer()
	arg_1_0:InitGameUI(arg_1_2)

	return
end

local function var_0_1(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.GetComponentsInChildren

	typeof = var_1_10005
	Animator = var_1_10007

	local var_2_2 = var_2_1(var_2_0, var_1_10005(var_1_10007), true)
	local var_2_3 = var_2.ToTable(var_2_2)

	ipairs = var_1_10003

	for iter_2_0, iter_2_1 in var_1_10003(var_2_3) do
		iter_2_1.speed = arg_2_1
	end

	return
end

local function var_0_2(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.GetComponentsInChildren

	typeof = var_1_10005
	SpineAnimUI = var_1_10007

	local var_3_2 = var_3_1(var_3_0, var_1_10005(var_1_10007), true)
	local var_3_3 = var_2.ToTable(var_3_2)

	ipairs = var_1_10003

	for iter_3_0, iter_3_1 in var_1_10003(var_3_3) do
		IsNil = var_1_10008

		if var_1_10008(iter_3_1) then
			-- block empty
		elseif arg_3_1 then
			iter_3_1:Pause()
		else
			iter_3_1:Resume()
		end
	end

	return
end

function var_0_0.InitTimer(arg_4_0)
	Timer = var_1_10001

	local var_4_0 = var_1_10001.New

	local function var_4_1()
		local var_5_0 = arg_4_0
		local var_5_1 = var_0.OnTimer

		RacingMiniGameConfig = var_2_10003

		var_5_1(var_5_0, var_2_10003.TIME_INTERVAL)

		return
	end

	RacingMiniGameConfig = var_1_10004
	arg_4_0.timer = var_4_0(var_4_1, var_1_10004.TIME_INTERVAL, -1)
	IsUnityEditor = var_1

	if var_1 and not arg_4_0.handle then
		UpdateBeat = var_1
		arg_4_0.handle = var_1:CreateListener(function()
			Input = var_2_10000

			local var_6_0 = var_2_10000.GetKeyDown

			KeyCode = var_2_10002

			local var_6_1

			if var_6_0(var_2_10002.W) then
				var_6_1 = arg_4_0
				var_6_1.up = true
			end

			Input = var_6_1

			local var_6_2 = var_6_1.GetKeyUp

			KeyCode = var_2

			local var_6_3

			if var_6_2(var_2.W) then
				var_6_3 = arg_4_0
				var_6_3.up = false
			end

			Input = var_6_3

			local var_6_4 = var_6_3.GetKeyDown

			KeyCode = var_2

			local var_6_5

			if var_6_4(var_2.S) then
				var_6_5 = arg_4_0
				var_6_5.down = true
			end

			Input = var_6_5

			local var_6_6 = var_6_5.GetKeyUp

			KeyCode = var_2

			local var_6_7

			if var_6_6(var_2.S) then
				var_6_7 = arg_4_0
				var_6_7.down = false
			end

			Input = var_6_7

			local var_6_8 = var_6_7.GetKeyDown

			KeyCode = var_2

			local var_6_9

			if var_6_8(var_2.Space) then
				var_6_9 = arg_4_0
				var_6_9.boost = true
			end

			Input = var_6_9

			local var_6_10 = var_6_9.GetKeyUp

			KeyCode = var_2

			if var_6_10(var_2.Space) then
				arg_4_0.boost = false
			end

			return
		end, arg_4_0)
		UpdateBeat = var_1

		var_1:AddListener(arg_4_0.handle)
	end

	return
end

function var_0_0.InitGameUI(arg_7_0, arg_7_1)
	arg_7_0.rtViewport = arg_7_1:Find("Viewport")
	arg_7_0.bgSingleSize = arg_7_0.rtViewport.rect.width

	local var_7_0 = arg_7_0.rtViewport

	arg_7_0.rtBgContent = var_2.Find(var_7_0, "BgContent")

	local var_7_1 = arg_7_0.rtViewport

	arg_7_0.rtMainContent = var_2.Find(var_7_1, "MainContent")
	arg_7_0.singleHeight = arg_7_0.rtMainContent.rect.height / 3
	arg_7_0.rtRes = arg_7_1:Find("Resource")
	arg_7_0.rtController = arg_7_1:Find("Controller")
	ipairs = var_2

	for iter_7_0, iter_7_1 in var_2({
		"up",
		"down",
		"boost"
	}) do
		GetOrAddComponent = var_1_10007

		local var_7_2 = arg_7_0.rtController
		local var_7_3 = var_9.Find(var_7_2, "bottom/btn_" .. iter_7_1)

		typeof = var_1_10010
		EventTriggerListener = var_12
		var_1_10010 = var_1_10007(var_7_3, var_1_10010(var_12))

		var_1_10007.AddPointDownFunc(var_1_10010, function()
			arg_7_0[iter_7_1] = true

			return
		end)

		var_1_10010 = var_1_10007

		var_1_10007.AddPointUpFunc(var_1_10010, function()
			arg_7_0[iter_7_1] = false

			return
		end)
	end

	RacingMiniGameConfig = var_2

	if var_2.BOOST_BUTTON_TYPE_CHANGE then
		RemoveComponent = var_2

		local var_7_4 = arg_7_0.rtController
		local var_7_5 = var_4.Find(var_7_4, "bottom/btn_boost")

		typeof = iter_7_0
		EventTriggerListener = var_7

		var_2(var_7_5, iter_7_0(var_7))

		onButton = var_2

		local var_7_6 = arg_7_0.binder
		local var_7_7 = arg_7_0.rtController

		var_2(var_7_6, var_5.Find(var_7_7, "bottom/btn_boost"), function()
			if not arg_7_0.target.isBlock then
				RacingMiniGameConfig = var_0

				local var_10_0 = var_0.M_LIST

				RacingMiniGameConfig = var_2_10001

				local var_10_1 = var_2_10001.S_LIST
				local var_10_2 = arg_7_0

				math = var_2_10003

				local var_10_3 = var_2_10003.clamp
				local var_10_4 = arg_7_0.enginePower

				RacingMiniGameConfig = var_2_10006
				var_10_2.enginePower = var_10_3(var_10_4 + var_2_10006.BOOST_RATE[2], var_10_0[1], var_10_0[#var_10_0])

				if arg_7_0.target.state == "base" then
					local var_10_5 = arg_7_0.target

					var_2.Show(var_10_5, "accel")
				end
			end

			return
		end)
	end

	local var_7_8 = arg_7_0.rtController

	arg_7_0.rtTime = var_2.Find(var_7_8, "top/time")
	setText = var_2

	local var_7_9 = arg_7_0.rtTime
	local var_7_10 = var_4.Find(var_7_9, "Text/plus")
	local var_7_11 = "+"

	RacingMiniGameConfig = var_7_9

	var_2(var_7_10, var_7_11 .. var_7_9.ITEM_ADD_TIME .. "s")

	local var_7_12 = arg_7_0.rtTime
	local var_7_13 = var_2.Find(var_7_12, "Text/plus")
	local var_7_14 = var_2.GetComponent

	typeof = var_5
	DftAniEvent = var_7

	local var_7_15 = var_7_14(var_7_13, var_5(var_7))

	var_2.SetEndEvent(var_7_15, function()
		setActive = var_2_10000

		local var_11_0 = arg_7_0.rtTime

		var_2_10000(var_2.Find(var_11_0, "Text/plus"), false)

		return
	end)

	local var_7_16 = arg_7_0.rtController

	arg_7_0.rtDis = var_2.Find(var_7_16, "top/dis")

	local var_7_17 = arg_7_0.rtController

	arg_7_0.rtPower = var_2.Find(var_7_17, "bottom/speed")

	local var_7_18 = arg_7_0.rtController

	arg_7_0.rtFriend = var_2.Find(var_7_18, "top/friend")
	arg_7_0.queue = {}

	return
end

function var_0_0.ResetGame(arg_12_0)
	arg_12_0.timeCount = 0
	RacingMiniGameConfig = var_1
	arg_12_0.timeAll = var_1.ALL_TIME

	if arg_12_0.target then
		local var_12_0 = arg_12_0.target

		var_1.Clear(var_12_0)

		arg_12_0.target = nil
	end

	while #arg_12_0.queue > 0 do
		local var_12_1 = arg_12_0.queue[#arg_12_0.queue]

		var_1.Clear(var_12_1)
	end

	arg_12_0.enginePower = 0
	arg_12_0.chargeDis = 0
	arg_12_0.disCount = 0
	arg_12_0.rateDic = {}
	arg_12_0.itemCountDic = {}

	return
end

function var_0_0.ReadyGame(arg_13_0, arg_13_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10004

	local var_13_0 = var_1_10002(var_1_10004)
	local var_13_1 = var_2.getRawData(var_13_0)

	underscore = var_1_10003
	arg_13_0.rankData = var_1_10003.filter(arg_13_1, function(arg_14_0)
		return arg_14_0.player_id ~= var_13_1.id
	end)
	table = var_3

	local var_13_2 = var_3.sort
	local var_13_3 = arg_13_0.rankData

	CompareFuncs = var_6

	var_13_2(var_13_3, var_6({
		function(arg_15_0)
			return arg_15_0.score
		end
	}))

	RacingMiniNameSpace = var_13_2

	local var_13_4 = var_13_2.Motorcycle.New

	cloneTplTo = var_13_3

	local var_13_5 = arg_13_0.rtRes
	local var_13_6 = var_7.Find(var_13_5, "qiye_minigame")
	local var_13_7 = arg_13_0.rtMainContent
	local var_13_8 = var_13_3(var_13_6, var_8.Find(var_13_7, -2))

	NewPos = var_6
	arg_13_0.target = var_13_4(var_13_8, var_6(0, 0), arg_13_0)
	table = var_3

	local var_13_9 = var_3.insert
	local var_13_10 = arg_13_0.queue

	RacingMiniNameSpace = var_6

	local var_13_11 = var_6.StartMark.New

	cloneTplTo = var_8

	local var_13_12 = arg_13_0.rtRes
	local var_13_13 = var_10.Find(var_13_12, "start_mark")
	local var_13_14 = arg_13_0.rtMainContent
	local var_13_15 = var_8(var_13_13, var_11.Find(var_13_14, -2))

	NewPos = var_9

	var_13_9(var_13_10, var_13_11(var_13_15, var_9(550, 0), arg_13_0))
	arg_13_0:UpdateDisplay()

	onNextTick = var_3

	var_3(function()
		local var_16_0 = arg_13_0

		var_0.PauseGame(var_16_0)

		return
	end)

	return
end

function var_0_0.StartGame(arg_17_0)
	arg_17_0.isStart = true

	arg_17_0:ResumeGame()

	return
end

function var_0_0.EndGame(arg_18_0, arg_18_1)
	arg_18_0.isStart = false

	arg_18_0:PauseGame()

	arg_18_0.result = arg_18_1 or 0
	arg_18_0.point = arg_18_0.disCount / 20
	arg_18_0.point = arg_18_0.point - arg_18_0.point % 0.01

	local var_18_0 = arg_18_0.binder

	var_2.openUI(var_18_0, "result")

	return
end

function var_0_0.ResumeGame(arg_19_0)
	arg_19_0.isPause = false

	local var_19_0 = arg_19_0.timer

	var_1.Start(var_19_0)
	var_0_1(arg_19_0.rtViewport, 1)
	var_0_2(arg_19_0.rtViewport, false)

	return
end

function var_0_0.PauseGame(arg_20_0)
	arg_20_0.isPause = true

	local var_20_0 = arg_20_0.timer

	var_1.Stop(var_20_0)
	var_0_1(arg_20_0.rtViewport, 0)
	var_0_2(arg_20_0.rtViewport, true)

	return
end

local function var_0_3(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1.pos - arg_21_0.pos
	local var_21_1 = {}

	for iter_21_0 = 1, 2 do
		var_21_1[iter_21_0] = {}
		var_21_1[iter_21_0][1] = arg_21_0.colliderSize[iter_21_0][1] - arg_21_1.colliderSize[iter_21_0][2]
		var_21_1[iter_21_0][2] = arg_21_0.colliderSize[iter_21_0][2] - arg_21_1.colliderSize[iter_21_0][1]
	end

	return var_21_1[1][1] < var_21_0.x and var_21_0.x < var_21_1[1][2] and var_21_1[2][1] < var_21_0.y and var_21_0.y < var_21_1[2][2]
end

function var_0_0.OnTimer(arg_22_0, arg_22_1)
	arg_22_0.timeCount = arg_22_0.timeCount + arg_22_1

	if arg_22_0.timeCount > arg_22_0.timeAll then
		arg_22_0:EndGame(1)

		return
	end

	if arg_22_0.target.invincibleTime then
		local var_22_0 = arg_22_0.target

		var_2.UpdateInvincibility(var_22_0, arg_22_1)
	end

	NewPos = var_2

	local var_22_1 = var_2(0, 0)
	local var_22_2 = arg_22_0
	local var_22_3 = arg_22_0.GetSpeed

	RacingMiniGameConfig = var_1_10006
	var_22_1.x = var_22_3(var_22_2, var_1_10006.BOOST_RATE[not arg_22_0.target.isBlock and arg_22_0.boost and 2 or 1] * arg_22_1) * arg_22_1

	if not arg_22_0.target.isBlock then
		if var_3 > 0 then
			if arg_22_0.up then
				var_22_1.y = var_22_1.y + 1
			end

			if arg_22_0.down then
				var_22_1.y = var_22_1.y - 1
			end

			local var_22_4 = var_22_1.y * arg_22_0.singleHeight

			RacingMiniGameConfig = var_5

			local var_22_5 = var_22_4 / var_5.Y_COVER_TIME

			if arg_22_0.target.isVertigo then
				RacingMiniGameConfig = var_5

				local var_22_6

				if not var_5.Y_OBSTACLE_REDUCE then
					var_22_6 = 1
				end

				var_22_1.y = var_22_5 * var_22_6 * arg_22_1

				if arg_22_0.target.state == "base" and arg_22_0.boost then
					local var_22_7 = arg_22_0.target

					var_4.Show(var_22_7, "accel")
				end

				if false then
					if not arg_22_0.target.isVertigo and arg_22_0.target.state ~= "base" then
						local var_22_8 = arg_22_0.target

						var_4.Show(var_22_8, "base")
					end
				end

				local var_22_9 = arg_22_0.target
				local var_22_10 = var_4.UpdatePos

				NewPos = var_7

				var_22_10(var_22_9, var_22_1 * var_7(0, 1), arg_22_0.singleHeight)

				setParent = var_22_10

				local var_22_11 = arg_22_0.target.rt
				local var_22_12 = arg_22_0.rtMainContent
				local var_22_13 = var_7.Find

				math = var_10

				local var_22_14 = var_10.clamp

				math = var_1_10012

				var_22_10(var_22_11, var_22_13(var_22_12, var_22_14(var_1_10012.floor((arg_22_0.target.pos.y + arg_22_0.singleHeight) * 3 / 2 / arg_22_0.singleHeight) - 1, -1, 1) - 1))

				local var_22_15 = 1

				while var_22_15 <= #arg_22_0.queue do
					local var_22_16 = arg_22_0.queue[var_22_15]
					local var_22_17 = var_5.UpdatePos

					NewPos = var_22_12

					var_22_17(var_22_16, var_22_1 * var_22_12(-1, 0))

					if not var_5.isTriggered and var_5.colliderSize and var_0_3(var_5, arg_22_0.target) then
						var_5:Trigger(arg_22_0.target)
					end

					if var_5.pos.x < -arg_22_0.bgSingleSize then
						var_5:Clear()
					else
						var_22_15 = var_22_15 + 1
					end
				end

				local var_22_18

				if arg_22_0.rtBgContent.anchoredPosition.x - var_22_1.x < -arg_22_0.bgSingleSize / 2 then
					var_22_18 = var_22_18 + arg_22_0.bgSingleSize
				end

				setAnchoredPosition = var_6

				var_6(arg_22_0.rtBgContent, {
					x = var_22_18
				})

				arg_22_0.chargeDis = arg_22_0.chargeDis - var_22_1.x

				if arg_22_0.chargeDis <= 0 then
					arg_22_0:CreateNewObject()
				end

				arg_22_0.disCount = arg_22_0.disCount + var_22_1.x

				arg_22_0:UpdateDisplay()

				return
			end
		end
	end
end

function var_0_0.UpdateDisplay(arg_23_0)
	local var_23_0 = arg_23_0.timeAll - arg_23_0.timeCount

	setText = var_2

	local var_23_1 = arg_23_0.rtTime
	local var_23_2 = var_4.Find(var_23_1, "Text")

	string = var_1_10005

	local var_23_3 = var_1_10005.format
	local var_23_4 = "%02d:%02ds"

	math = var_1_10008

	local var_23_5 = var_1_10008.floor(var_23_0)

	math = var_1_10009

	local var_23_6 = var_1_10009.floor

	math = var_1_10011

	var_2(var_23_2, var_23_3(var_23_4, var_23_5, var_23_6((var_23_0 - var_1_10011.floor(var_23_0)) * 100)))

	local var_23_7 = arg_23_0.disCount / 20

	setText = var_1_10003

	local var_23_8 = arg_23_0.rtDis

	string = var_23_1

	var_1_10003(var_23_8, var_23_1.format("%.2fm", var_23_7 - var_23_7 % 0.01))

	RacingMiniGameConfig = var_1_10003

	local var_23_9 = var_1_10003.BUOY_POWER_LIST

	RacingMiniGameConfig = var_23_2

	local var_23_10 = var_23_2.BUOY_POS_LIST
	local var_23_11

	ipairs = var_6

	for iter_23_0, iter_23_1 in var_6(var_23_9) do
		if iter_23_1 >= arg_23_0.enginePower then
			var_23_11 = iter_23_0

			break
		end
	end

	setAnchoredPosition = var_6

	local var_23_12 = arg_23_0.rtPower
	local var_23_13 = var_8.Find(var_23_12, "range/buoy")
	local var_23_14 = {}
	local var_23_15

	if not (var_23_11 > 1) or not (var_23_10[var_23_11 - 1] + (arg_23_0.enginePower - var_23_9[var_23_11 - 1]) / (var_23_9[var_23_11] - var_23_9[var_23_11 - 1]) * (var_23_10[var_23_11] - var_23_10[var_23_11 - 1])) then
		var_23_15 = 0
	end

	var_23_14.x = var_23_15

	var_6(var_23_13, var_23_14)

	if arg_23_0.target.isVertigo then
		var_23_11 = 1
	end

	ipairs = var_6

	for iter_23_2, iter_23_3 in var_6(arg_23_0.target.effectList) do
		setActive = var_11

		var_11(iter_23_3, var_23_11 - 1 == iter_23_2)
	end

	RacingMiniGameConfig = var_6

	local var_23_16 = var_6.FRIEND_DIS_LIST

	defaultValue = var_7
	arg_23_0.friendIndex = var_7(arg_23_0.friendIndex, 1)

	while arg_23_0.friendIndex < #var_23_16 and var_23_16[arg_23_0.friendIndex + 1] < arg_23_0.disCount / 20 do
		arg_23_0.friendIndex = arg_23_0.friendIndex + 1
		arg_23_0.friendDirty = true
	end

	if arg_23_0.friendDirty then
		arg_23_0.friendDirty = false

		::label_23_0::

		local var_23_17 = #arg_23_0.rankData

		if 0 < var_23_17 and arg_23_0.rankData[1].score / 100 < var_23_16[arg_23_0.friendIndex] then
			repeat
				table = var_7

				var_7.remove(arg_23_0.rankData, 1)

				goto label_23_0
			until true
		end

		local var_23_18

		ipairs = var_8

		for iter_23_4, iter_23_5 in var_8(arg_23_0.rankData) do
			if arg_23_0.friendIndex == #var_23_16 or iter_23_5.score / 100 < var_23_16[arg_23_0.friendIndex + 1] then
				var_23_18 = iter_23_4
			else
				break
			end
		end

		setActive = var_8

		var_8(arg_23_0.rtFriend, var_23_18)

		if var_23_18 then
			local var_23_19 = arg_23_0.rankData

			math = var_9
			arg_23_0.friendInfo = var_23_19[var_9.random(var_23_18)]
		else
			arg_23_0.friendInfo = nil
		end

		if arg_23_0.friendInfo then
			setText = var_8

			local var_23_20 = arg_23_0.rtFriend

			var_8(var_10.Find(var_23_20, "Text"), arg_23_0.friendInfo.name)

			setText = var_8

			local var_23_21 = arg_23_0.rtFriend
			local var_23_22 = var_10.Find(var_23_21, "point")

			string = var_11

			var_8(var_23_22, var_11.format("%.2fm", arg_23_0.friendInfo.score / 100))
		end
	end

	return
end

local var_0_4 = {
	TrafficCone = "roadblocks",
	Bomb = "roadblocks",
	Roadblock = "roadblocks",
	SpeedBumps = "speed_bumps",
	Mire = "mire",
	MoreTime = "more_time",
	Invincibility = "invincibility"
}

function var_0_0.CreateNewObject(arg_24_0)
	local var_24_0

	ipairs = var_1_10002
	RacingMiniGameConfig = var_1_10004

	for iter_24_0, iter_24_1 in var_1_10002(var_1_10004.FIELD_CONFIG) do
		if arg_24_0.timeCount < iter_24_1.time then
			break
		else
			var_24_0 = iter_24_1
		end
	end

	local var_24_1 = {}
	local var_24_2 = 0

	for iter_24_2 = -1, 1 do
		local var_24_3 = arg_24_0.rateDic

		defaultValue = var_1_10009
		var_24_3[iter_24_2] = var_1_10009(arg_24_0.rateDic[iter_24_2], 0)
		math = var_24_3

		local var_24_4 = var_24_3.random() / (2 - iter_24_2)

		var_1_10009 = nil

		if var_24_4 < arg_24_0.rateDic[iter_24_2] then
			var_24_2 = var_24_2 + 1
			var_24_1[iter_24_2] = true
		else
			var_24_1[iter_24_2] = false
		end
	end

	if var_24_2 == 3 then
		math = var_4
		var_24_1[var_4.random(3) - 2] = false
	end

	for iter_24_3 = -1, 1 do
		local var_24_5

		if var_24_1[iter_24_3] then
			var_24_5 = var_24_0.obstacle_distribution
			var_24_5 = classCfg
		else
			var_24_5 = var_24_0.item_distribution
			var_24_5 = classCfg
		end

		math = var_24_5

		local var_24_6 = var_24_5.random()
		local var_24_7 = rate
		local var_24_8 = 0
		local var_24_9 = 0

		ipairs = var_1_10010
		classCfg = var_1_10012

		for iter_24_4, iter_24_5 in var_1_10010(var_1_10012) do
			var_24_9 = var_24_9 + iter_24_5[2]
		end

		var_1_10010 = nil
		ipairs = var_11
		classCfg = iter_24_4

		for iter_24_6, iter_24_7 in var_11(iter_24_4) do
			var_24_8 = var_24_8 + iter_24_7[2]
			rate = var_16

			if var_24_8 > var_16 * var_24_9 then
				var_1_10010 = iter_24_7[1]

				break
			end
		end

		local var_24_10, var_24_11

		if var_1_10010 then
			superof = var_24_11
			RacingMiniNameSpace = var_24_10
			var_24_10 = var_24_10[var_1_10010]
			RacingMiniNameSpace = iter_24_6

			if var_24_11(var_24_10, iter_24_6.Item) then
				defaultValue = var_24_11
				var_24_11 = var_24_11(arg_24_0.itemCountDic[var_1_10010], 0)
				defaultValue = var_1_10012

				if var_24_11 < var_1_10012(var_24_0.item_create_limit[var_1_10010], 0) then
					var_24_11 = arg_24_0.itemCountDic
					defaultValue = var_1_10012
					var_24_11[var_1_10010] = var_1_10012(arg_24_0.itemCountDic[var_1_10010], 0) + 1
				else
					var_1_10010 = nil
				end
			end
		end

		if var_1_10010 then
			RacingMiniNameSpace = var_24_11

			local var_24_12 = var_24_11[var_1_10010].New

			cloneTplTo = var_24_10

			local var_24_13 = arg_24_0.rtRes
			local var_24_14 = var_15.Find(var_24_13, var_0_4[var_1_10010])
			local var_24_15 = arg_24_0.rtMainContent
			local var_24_16 = var_24_10(var_24_14, var_16.Find(var_24_15, iter_24_3))

			NewPos = iter_24_6

			local var_24_17 = var_24_12(var_24_16, iter_24_6(arg_24_0.bgSingleSize * 1.5 + arg_24_0.chargeDis, iter_24_3 * arg_24_0.singleHeight), arg_24_0)

			table = var_1_10012

			var_1_10012.insert(arg_24_0.queue, var_24_17)

			var_1_10012 = arg_24_0.rateDic
			var_1_10012[iter_24_3] = arg_24_0.rateDic[iter_24_3] * var_24_0.continue_reduce
		else
			arg_24_0.rateDic[iter_24_3] = arg_24_0.rateDic[iter_24_3] + var_24_0.bye_plus
		end
	end

	arg_24_0.chargeDis = arg_24_0.chargeDis + var_24_0.recharge_dis

	return
end

function var_0_0.GetSpeed(arg_25_0, arg_25_1)
	local var_25_0

	RacingMiniGameConfig = var_1_10003

	local var_25_1 = var_1_10003.M_LIST

	RacingMiniGameConfig = var_1_10004

	local var_25_2 = var_1_10004.S_LIST

	for iter_25_0 = 1, #var_25_1 - 1 do
		if var_25_1[iter_25_0 + 1] > arg_25_0.enginePower then
			var_25_0 = var_25_2[iter_25_0] + (arg_25_0.enginePower - var_25_1[iter_25_0]) / (var_25_1[iter_25_0 + 1] - var_25_1[iter_25_0]) * (var_25_2[iter_25_0 + 1] - var_25_2[iter_25_0])

			break
		end
	end

	var_25_0 = var_25_0 or var_25_2[#var_25_2]
	math = var_5
	arg_25_0.enginePower = var_5.clamp(arg_25_0.enginePower + arg_25_1, var_25_1[1], var_25_1[#var_25_1])

	return var_25_0 * 10
end

function var_0_0.AddTime(arg_26_0, arg_26_1)
	arg_26_0.timeAll = arg_26_0.timeAll + arg_26_1
	setActive = var_2

	local var_26_0 = arg_26_0.rtTime

	var_2(var_4.Find(var_26_0, "Text/plus"), true)

	return
end

function var_0_0.SetEnginePower(arg_27_0, arg_27_1)
	math = var_1_10002
	arg_27_0.enginePower = var_1_10002.min(arg_27_0.enginePower, arg_27_1)

	return
end

function var_0_0.willExit(arg_28_0)
	if arg_28_0.handle then
		UpdateBeat = var_1

		var_1:RemoveListener(arg_28_0.handle)
	end

	return
end

return var_0_0
