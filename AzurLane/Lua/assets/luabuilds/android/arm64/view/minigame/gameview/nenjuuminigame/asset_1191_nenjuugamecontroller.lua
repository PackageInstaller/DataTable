class = var_0_10000

local var_0_0 = var_0_10000("NenjuuGameController")

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

function var_0_0.InitTimer(arg_3_0)
	Timer = var_1_10001

	local var_3_0 = var_1_10001.New

	local function var_3_1()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.OnTimer

		NenjuuGameConfig = var_2_10003

		var_4_1(var_4_0, var_2_10003.TIME_INTERVAL)

		return
	end

	NenjuuGameConfig = var_1_10004
	arg_3_0.timer = var_3_0(var_3_1, var_1_10004.TIME_INTERVAL, -1)

	if not arg_3_0.handle then
		UpdateBeat = var_1
		arg_3_0.handle = var_1:CreateListener(arg_3_0.Update, arg_3_0)
	end

	UpdateBeat = var_1

	var_1:AddListener(arg_3_0.handle)

	return
end

function var_0_0.InitGameUI(arg_5_0, arg_5_1)
	arg_5_0.rtViewport = arg_5_1:Find("Viewport")

	local var_5_0 = arg_5_0.rtViewport

	arg_5_0.rtMainContent = var_2.Find(var_5_0, "MainContent")
	arg_5_0.rtResource = arg_5_1:Find("Resource")
	arg_5_0.rtJoyStick = arg_5_1:Find("Controller/bottom/joy_stick")

	local var_5_1 = {
		"E",
		"S",
		"W",
		"N"
	}

	ipairs = var_1_10003

	for iter_5_0, iter_5_1 in var_1_10003({
		"right",
		"down",
		"left",
		"up"
	}) do
		local var_5_2 = arg_5_0.rtJoyStick
		local var_5_3 = var_8.Find(var_5_2, iter_5_1)
		local var_5_4 = var_8.GetComponent

		typeof = var_11
		EventTriggerListener = var_1_10013

		local var_5_5 = var_5_4(var_5_3, var_11(var_1_10013))

		var_8.AddPointDownFunc(var_5_5, function()
			arg_5_0.cacheInput = var_5_1[iter_5_0]

			return
		end)
		var_8:AddPointEnterFunc(function()
			if arg_5_0.cacheInput and arg_5_0.cacheInput ~= var_5_1[iter_5_0] then
				arg_5_0.cacheInput = var_5_1[iter_5_0]
			end

			return
		end)
		var_8:AddPointUpFunc(function()
			if arg_5_0.cacheInput then
				arg_5_0.cacheInput = nil
			end

			return
		end)
	end

	arg_5_0.inPress = {}
	arg_5_0.rtSkillButton = arg_5_1:Find("Controller/bottom/skill_button")

	for iter_5_2 = 0, 3 do
		local var_5_6 = "Skill_" .. iter_5_2
		local var_5_7 = arg_5_0.rtSkillButton
		local var_5_8 = var_8.Find(var_5_7, var_5_6)
		local var_5_9 = var_8.GetComponent

		typeof = var_11
		EventTriggerListener = var_1_10013

		local var_5_10 = var_5_9(var_5_8, var_11(var_1_10013))

		var_8.AddPointDownFunc(var_5_10, function()
			arg_5_0.inPress[var_5_6] = true

			return
		end)
		var_8:AddPointUpFunc(function()
			arg_5_0.inPress[var_5_6] = false

			return
		end)
	end

	arg_5_0.textTime = arg_5_1:Find("Controller/top/panel/time/Text")
	arg_5_0.textPoint = arg_5_1:Find("Controller/top/panel/point/Text")
	arg_5_0.rtCollection = arg_5_1:Find("Controller/top/target")

	return
end

function var_0_0.Update(arg_11_0)
	arg_11_0:AddDebugInput()

	return
end

function var_0_0.AddDebugInput(arg_12_0)
	IsUnityEditor = var_1_10001

	if var_1_10001 then
		local var_12_0 = {
			"E",
			"S",
			"W",
			"N"
		}
		local var_12_1 = {
			"D",
			"S",
			"A",
			"W"
		}

		ipairs = var_1_10003

		for iter_12_0, iter_12_1 in var_1_10003(var_12_1) do
			Input = var_1_10008
			var_1_10008 = var_1_10008.GetKeyDown
			KeyCode = var_1_10010

			if var_1_10008(var_1_10010[iter_12_1]) then
				arg_12_0.cacheInput = var_12_0[iter_12_0]
			end

			Input = var_1_10008
			var_1_10008 = var_1_10008.GetKeyUp
			KeyCode = var_1_10010

			if var_1_10008(var_1_10010[iter_12_1]) and arg_12_0.cacheInput == var_12_0[iter_12_0] then
				arg_12_0.cacheInput = nil
			end
		end
	end

	return
end

function var_0_0.InitMapConfig(arg_13_0, arg_13_1)
	arg_13_0.pointRate = arg_13_1.rate
	NenjuuGameConfig = var_2
	arg_13_0.config = var_2.GetStageConfig("Spring23Level_" .. arg_13_1.index)

	local var_13_0 = {}

	ipairs = var_1_10003
	pg = var_5

	local var_13_1 = var_5.MiniGameTileMgr.GetInstance()

	for iter_13_0, iter_13_1 in var_1_10003(var_5.getDataLayers(var_13_1, "Spring23Game", "Spring23Level_" .. arg_13_1.index)) do
		var_13_0[iter_13_1.name] = iter_13_1
	end

	arg_13_0.timeCount = arg_13_0.config.extra_time[1]
	arg_13_0.point = 0
	setText = var_3

	local var_13_2 = arg_13_0.textTime

	string = iter_13_0

	local var_13_3 = iter_13_0.format
	local var_13_4 = "%02d:%02ds"

	math = var_9

	local var_13_5 = var_9.floor(arg_13_0.timeCount / 60)

	math = var_10

	var_3(var_13_2, var_13_3(var_13_4, var_13_5, var_10.floor(arg_13_0.timeCount % 60)))

	setText = var_3

	var_3(arg_13_0.textPoint, arg_13_0.point)

	eachChild = var_3

	var_3(arg_13_0.rtCollection, function(arg_14_0)
		setActive = var_2_10001

		var_2_10001(arg_14_0, false)

		return
	end)

	NewPos = var_3
	arg_13_0.mapSize = var_3(var_13_0.floor.width, var_13_0.floor.height)
	setSizeDelta = var_3

	var_3(arg_13_0.rtMainContent, arg_13_0.mapSize * 32)

	local var_13_6 = arg_13_0.rtViewport.rect
	local var_13_7 = arg_13_0.rtMainContent.rect

	NewPos = var_5
	math = iter_13_1

	local var_13_8 = iter_13_1.max(var_13_7.width + 192 - var_13_6.width, 0)

	math = var_13_4
	arg_13_0.buffer = var_5(var_13_8, var_13_4.max(var_13_7.height + 160 - var_13_6.height, 0)) * 0.5
	ipairs = var_5

	for iter_13_2, iter_13_3 in var_5(var_13_0.floor.layer) do
		NewPos = var_13_10

		local var_13_9 = (iter_13_3.index - 1) % arg_13_0.mapSize.x

		math = var_13

		local var_13_10 = var_13_10(var_13_9, var_13.floor((iter_13_3.index - 1) / arg_13_0.mapSize.x))
		local var_13_11 = arg_13_0.plane

		tostring = var_13_9
		var_13_11[var_13_9(var_13_10)] = iter_13_3.item
	end

	local var_13_12 = {
		["0_-1"] = 3,
		["1_1"] = 5,
		["-1_0"] = 2,
		["1_0"] = 0,
		["0_1"] = 1,
		["1_-1"] = 4,
		["-1_-1"] = 7,
		["-1_1"] = 6
	}

	for iter_13_4 = 0, arg_13_0.mapSize.y - 1 do
		for iter_13_5 = 0, arg_13_0.mapSize.x - 1 do
			local var_13_13

			if not arg_13_0.plane[iter_13_5 .. "_" .. iter_13_4] then
				var_13_13 = "Snow"
			end

			local var_13_14 = arg_13_0.rtResource
			local var_13_18

			if not var_15.Find(var_13_14, "plane/" .. var_13_13) then
				cloneTplTo = var_16

				local var_13_15 = arg_13_0.rtResource
				local var_13_16 = var_18.Find(var_13_15, "plane/Road")
				local var_13_17 = arg_13_0.rtMainContent

				var_13_18 = var_16(var_13_16, var_19.Find(var_13_17, "plane"))
				setImageSprite = var_16

				local var_13_19 = var_13_18:Find("scale/Image")

				getImageSprite = var_19

				local var_13_20 = arg_13_0.rtResource

				var_16(var_13_19, var_19(var_21.Find(var_13_20, "plane_sprite/" .. var_13_13)))
			else
				cloneTplTo = var_16

				local var_13_21 = var_13_18
				local var_13_22 = arg_13_0.rtMainContent

				var_13_18 = var_16(var_13_21, var_19.Find(var_13_22, "plane"))
			end

			if var_13_18:Find("scale/Snow") then
				local function var_13_23(arg_15_0, arg_15_1)
					local var_15_0 = arg_13_0
					local var_15_1 = var_2.InRange

					NewPos = var_2_10005

					return not var_15_1(var_15_0, var_2_10005(arg_15_0, arg_15_1)) or not arg_13_0.plane[arg_15_0 .. "_" .. arg_15_1] or arg_13_0.plane[arg_15_0 .. "_" .. arg_15_1] == "Snow"
				end

				for iter_13_6 = -1, 1 do
					for iter_13_7 = -1, 1 do
						if var_13_23(iter_13_5 + iter_13_6, iter_13_4 + iter_13_7) and (iter_13_6 == 0 or iter_13_7 == 0 or not var_13_23(iter_13_5, iter_13_4 + iter_13_7) and not var_13_23(iter_13_5 + iter_13_6, iter_13_4)) then
							setActive = var_25

							var_25(var_13_18:Find("scale/Snow/" .. var_13_12[iter_13_6 .. "_" .. iter_13_7]), true)
						end
					end
				end
			end
		end
	end

	ipairs = var_6

	for iter_13_8, iter_13_9 in var_6(var_13_0.item.layer) do
		NewPos = var_13_11

		local var_13_24 = (iter_13_9.index - 1) % arg_13_0.mapSize.x

		math = var_14
		var_13_11 = var_13_11(var_13_24, var_14.floor((iter_13_9.index - 1) / arg_13_0.mapSize.x))

		local var_13_25 = arg_13_0:CreateTarget({
			name = iter_13_9.item,
			pos = var_13_11
		})
	end

	ipairs = var_6

	for iter_13_10, iter_13_11 in var_6(var_13_0.character.layer) do
		NewPos = var_13_11

		local var_13_26 = (iter_13_11.index - 1) % arg_13_0.mapSize.x

		math = var_14
		var_13_11 = var_13_11(var_13_26, var_14.floor((iter_13_11.index - 1) / arg_13_0.mapSize.x))

		local var_13_27 = {
			name = iter_13_11.item,
			pos = var_13_11
		}

		switch = var_13

		var_13(var_13_27.name, {
			FuShun = function()
				var_13_27.level = arg_13_1.FuShun.level
				var_13_27.itemType = arg_13_1.FuShun.item

				local var_16_0 = arg_13_0
				local var_16_1 = arg_13_0

				var_16_0.moveFuShun = var_1.CreateTarget(var_16_1, var_13_27)

				return
			end,
			Nenjuu = function()
				var_13_27.abilitys = arg_13_1.Nenjuu

				local var_17_0 = arg_13_0
				local var_17_1 = arg_13_0

				var_17_0.moveNenjuu = var_1.CreateTarget(var_17_1, var_13_27)

				return
			end
		})
	end

	arg_13_0.wave = 0
	arg_13_0.itemCount = 0

	return
end

function var_0_0.CheckWave(arg_18_0)
	if arg_18_0.itemCount > 0 then
		return
	end

	if arg_18_0.wave < #arg_18_0.config.wave then
		arg_18_0.wave = arg_18_0.wave + 1
		unpack = var_1

		local var_18_0, var_18_1, var_18_2 = var_1(arg_18_0.config.wave[arg_18_0.wave])

		arg_18_0.itemType = var_18_0
		arg_18_0.itemCount = var_18_1

		local var_18_3 = {}

		for iter_18_0 = 0, arg_18_0.mapSize.x - 1 do
			for iter_18_1 = 0, arg_18_0.mapSize.y - 1 do
				NewPos = var_1_10013
				var_1_10013 = var_1_10013(iter_18_0, iter_18_1)

				if arg_18_0:Moveable(var_1_10013, true) then
					local var_18_4 = arg_18_0.hideMap

					tostring = var_15

					if not var_18_4[var_15(var_1_10013)] then
						table = var_14

						var_14.insert(var_18_3, var_1_10013)
					end
				end
			end
		end

		for iter_18_2 = 1, arg_18_0.itemCount do
			local var_18_5

			repeat
				math = var_1_10010
				var_18_5 = var_1_10010.random(#var_18_3)
				var_1_10010 = 0

				for iter_18_3 = -1, 1 do
					for iter_18_4 = -1, 1 do
						local var_18_6 = var_18_3[var_18_5]

						NewPos = var_1_10020

						local var_18_7 = var_18_6 + var_1_10020(iter_18_3, iter_18_4)

						if arg_18_0:InRange(var_18_7) then
							underscore = var_1_10020
							var_1_10020 = var_1_10020.any

							local var_18_8 = arg_18_0.map

							tostring = var_23

							if var_1_10020(var_18_8[var_23(var_18_7)], function(arg_19_0)
								local var_19_0 = arg_19_0.class

								NenjuuGameNameSpace = var_2_10002

								return var_19_0 == var_2_10002.TargetItem
							end) then
								var_1_10010 = var_1_10010 + 1
							end
						end
					end
				end
			until var_1_10010 < 7

			table = var_1_10010
			var_1_10010 = var_1_10010.remove(var_18_3, var_18_5)

			arg_18_0:CreateTarget({
				name = var_18_0,
				pos = var_1_10010,
				point = var_18_2
			})
		end

		eachChild = var_5

		var_5(arg_18_0.rtCollection, function(arg_20_0)
			setActive = var_2_10001

			var_2_10001(arg_20_0, arg_20_0.name == arg_18_0.itemType)

			return
		end)
	else
		arg_18_0.point = arg_18_0.point + arg_18_0.config.extra_time[2] * arg_18_0.pointRate
		setText = var_1

		var_1(arg_18_0.textPoint, arg_18_0.point)
		arg_18_0:EndGame(true)
	end

	return
end

function var_0_0.InRange(arg_21_0, arg_21_1)
	return arg_21_1.x >= 0 and arg_21_1.x < arg_21_0.mapSize.x and arg_21_1.y >= 0 and arg_21_1.y < arg_21_0.mapSize.y
end

function var_0_0.Moveable(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	if not arg_22_0:InRange(arg_22_1) then
		return false
	else
		underscore = var_4

		local var_22_0 = var_4.all
		local var_22_1 = arg_22_0.map

		tostring = var_7

		return var_22_0(var_22_1[var_7(arg_22_1)], function(arg_23_0)
			local var_23_1

			if not arg_23_0:Moveable() and (not arg_22_2 or not arg_23_0:BreakMoveable()) and arg_22_3 then
				isa = var_23_1

				local var_23_0 = arg_23_0

				NenjuuGameNameSpace = var_2_10004
				var_23_1 = var_23_1(var_23_0, var_2_10004.TargetMove)
			end

			return var_23_1
		end)
	end

	return
end

function var_0_0.CreateTarget(arg_24_0, arg_24_1)
	NenjuuGameConfig = var_1_10002

	local var_24_0, var_24_1, var_24_2 = var_1_10002.GetCreateConfig(arg_24_1)

	if not var_24_0 then
		return
	end

	local var_24_3

	if arg_24_1.parent then
		cloneTplTo = var_6

		local var_24_4 = arg_24_0.rtResource

		var_24_3 = var_6(var_8.Find(var_24_4, var_24_1), arg_24_1.parent)
	else
		cloneTplTo = var_6

		local var_24_5 = arg_24_0.rtResource
		local var_24_6 = var_8.Find(var_24_5, var_24_1)
		local var_24_7 = arg_24_0.rtMainContent

		var_24_3 = var_6(var_24_6, var_9.Find(var_24_7, var_24_2))
	end

	local var_24_8 = var_24_0.New(arg_24_0, var_24_3, arg_24_1)

	if var_6.InTimeLine(var_24_8) then
		table = var_7

		var_7.insert(arg_24_0.timeFlow, var_6)
	end

	return var_6
end

function var_0_0.DestoryTarget(arg_25_0, arg_25_1)
	arg_25_0.dirtyMap = true
	table = var_2

	local var_25_0 = var_2.removebyvalue
	local var_25_1 = arg_25_0.map

	tostring = var_1_10005

	var_25_0(var_25_1[var_1_10005(arg_25_1.pos)], arg_25_1)

	if arg_25_1:InTimeLine() then
		table = var_2

		var_2.removebyvalue(arg_25_0.timeFlow, arg_25_1)
	end

	Destroy = var_2

	var_2(arg_25_1._tf)

	arg_25_1 = nil

	return
end

function var_0_0.ResetGame(arg_26_0)
	ipairs = var_1_10001

	for iter_26_0, iter_26_1 in var_1_10001({
		"plane",
		"object",
		"effect",
		"character"
	}) do
		eachChild = var_1_10006

		local var_26_0 = arg_26_0.rtMainContent

		var_1_10006(var_8.Find(var_26_0, iter_26_1), function(arg_27_0)
			Destroy = var_2_10001

			var_2_10001(arg_27_0)

			return
		end)
	end

	setmetatable = var_1
	arg_26_0.map = var_1({}, {
		__index = function(arg_28_0, arg_28_1)
			arg_28_0[arg_28_1] = {}

			return arg_28_0[arg_28_1]
		end
	})
	arg_26_0.hideMap = {}
	arg_26_0.plane = {}
	arg_26_0.cacheInput = nil
	arg_26_0.timeQueue = {}
	arg_26_0.timeFlow = {}
	arg_26_0.moveFuShun = nil
	arg_26_0.moveNenjuu = nil
	arg_26_0.moveDoppel = nil
	arg_26_0.wayfindCache = {}

	return
end

function var_0_0.ReadyGame(arg_29_0, arg_29_1)
	arg_29_0:InitMapConfig(arg_29_1)
	arg_29_0:UpdateSkillButtons()
	arg_29_0:PauseGame()

	return
end

function var_0_0.StartGame(arg_30_0)
	arg_30_0.isStart = true

	arg_30_0:CheckWave()
	arg_30_0:ResumeGame()

	return
end

function var_0_0.EndGame(arg_31_0, arg_31_1)
	arg_31_0.isStart = false

	arg_31_0:PauseGame()

	local var_31_0 = arg_31_0.binder

	var_2.openUI(var_31_0, "result")

	return
end

function var_0_0.ResumeGame(arg_32_0)
	arg_32_0.isPause = false

	local var_32_0 = arg_32_0.timer

	var_1.Start(var_32_0)
	var_0_1(arg_32_0.rtMainContent, 1)

	return
end

function var_0_0.PauseGame(arg_33_0)
	arg_33_0.isPause = true

	local var_33_0 = arg_33_0.timer

	var_1.Stop(var_33_0)
	var_0_1(arg_33_0.rtMainContent, 0)

	return
end

function var_0_0.OnTimer(arg_34_0, arg_34_1)
	arg_34_0.timeCount = arg_34_0.timeCount - arg_34_1
	setText = var_2

	local var_34_0 = arg_34_0.textTime

	string = var_1_10005

	local var_34_1 = var_1_10005.format
	local var_34_2 = "%02d:%02ds"

	math = var_1_10008

	local var_34_3 = var_1_10008.floor(arg_34_0.timeCount / 60)

	math = var_1_10009

	var_2(var_34_0, var_34_1(var_34_2, var_34_3, var_1_10009.floor(arg_34_0.timeCount % 60)))

	if arg_34_0.timeCount <= 0 then
		arg_34_0:EndGame()

		return
	end

	ipairs = var_2

	for iter_34_0, iter_34_1 in var_2(arg_34_0.timeFlow) do
		iter_34_1:OnTimerUpdate(arg_34_1)
	end

	ipairs = var_2

	for iter_34_2, iter_34_3 in var_2(arg_34_0.timeQueue) do
		iter_34_3.time = iter_34_3.time - arg_34_1
	end

	table = var_2

	local var_34_4 = var_2.sort
	local var_34_5 = arg_34_0.timeQueue

	CompareFuncs = iter_34_2

	var_34_4(var_34_5, iter_34_2({
		function(arg_35_0)
			return -arg_35_0.time
		end
	}))

	while #arg_34_0.timeQueue > 0 and arg_34_0.timeQueue[#arg_34_0.timeQueue].time <= 0 do
		table = var_2

		var_2.remove(arg_34_0.timeQueue).func()
	end

	arg_34_0:UpdateSkillButtons()

	return
end

function var_0_0.UpdateSkillButtons(arg_36_0)
	ipairs = var_1_10001

	local var_36_0 = arg_36_0.moveFuShun

	for iter_36_0, iter_36_1 in var_1_10001(var_3.CalcSkillCDs(var_36_0)) do
		local var_36_1 = arg_36_0.rtSkillButton
		local var_36_2 = var_6.Find(var_36_1, "Skill_" .. iter_36_0 - 1)

		eachChild = var_1_10007

		var_1_10007(var_36_2:Find("icon"), function(arg_37_0)
			setActive = var_2_10001

			var_2_10001(arg_37_0, arg_37_0.name == iter_36_1.icon)

			return
		end)

		if not iter_36_1.cd then
			setActive = var_1_10007

			var_1_10007(var_36_2:Find("cd"), false)

			setActive = var_1_10007

			var_1_10007(var_36_2:Find("lock"), true)
		elseif iter_36_1.cd == true then
			setActive = var_1_10007

			var_1_10007(var_36_2:Find("cd"), true)

			setFillAmount = var_1_10007

			var_1_10007(var_36_2:Find("cd"), 1)

			setText = var_1_10007

			var_1_10007(var_36_2:Find("cd/Text"), "")

			setActive = var_1_10007

			var_1_10007(var_36_2:Find("lock"), false)
		elseif iter_36_1.cd > 0 then
			setActive = var_1_10007

			var_1_10007(var_36_2:Find("cd"), true)

			setFillAmount = var_1_10007

			var_1_10007(var_36_2:Find("cd"), iter_36_1.rate)

			setText = var_1_10007

			local var_36_3 = var_36_2:Find("cd/Text")

			math = var_10

			var_1_10007(var_36_3, var_10.ceil(iter_36_1.cd) .. "s")

			setActive = var_1_10007

			var_1_10007(var_36_2:Find("lock"), false)
		else
			setActive = var_1_10007

			var_1_10007(var_36_2:Find("cd"), false)

			setActive = var_1_10007

			var_1_10007(var_36_2:Find("lock"), false)
		end
	end

	return
end

function var_0_0.GetCacheInput(arg_38_0, arg_38_1)
	if arg_38_1 then
		local var_38_0 = arg_38_0.cacheInput

		arg_38_0.cacheInput = nil

		return var_38_0
	else
		return arg_38_0.cacheInput
	end

	return
end

function var_0_0.GetPressInput(arg_39_0, arg_39_1)
	return arg_39_0.inPress[arg_39_1]
end

function var_0_0.UpdateTargetPos(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	arg_40_0.dirtyMap = true

	local var_40_0 = arg_40_1:GetSize()

	for iter_40_0 = 0, var_40_0.x - 1 do
		for iter_40_1 = 0, var_40_0.y - 1 do
			NewPos = var_1_10013
			var_1_10013 = var_1_10013(iter_40_0, iter_40_1)

			if arg_40_2 then
				table = var_1_10014
				var_1_10014 = var_1_10014.removebyvalue

				local var_40_1 = arg_40_0.map

				tostring = var_1_10017

				var_1_10014(var_40_1[var_1_10017(arg_40_2 + var_1_10013)], arg_40_1)
			end

			table = var_1_10014
			var_1_10014 = var_1_10014.insert

			local var_40_2 = arg_40_0.map

			tostring = var_1_10017

			var_1_10014(var_40_2[var_1_10017(arg_40_3 + var_1_10013)], arg_40_1)
		end
	end

	if arg_40_1.canHide then
		for iter_40_2 = 0, var_40_0.x - 1 do
			NewPos = var_1_10009
			var_1_10009 = arg_40_3 + var_1_10009(iter_40_2, -1)

			if arg_40_0:InRange(var_1_10009) then
				local var_40_3 = arg_40_0.hideMap

				tostring = var_11
				var_40_3[var_11(var_1_10009)] = true
			end
		end
	end

	return
end

function var_0_0.WindowFocrus(arg_41_0, arg_41_1)
	setAnchoredPosition = var_1_10002

	local var_41_0 = arg_41_0.rtMainContent
	local var_41_1 = {}

	math = var_1_10006
	var_41_1.x = var_1_10006.clamp(-arg_41_1.x, -arg_41_0.buffer.x, arg_41_0.buffer.x)
	math = var_6
	var_41_1.y = var_6.clamp(-arg_41_1.y, -arg_41_0.buffer.y - 16, arg_41_0.buffer.y - 16)

	var_1_10002(var_41_0, var_41_1)

	return
end

function var_0_0.CheckIce(arg_42_0, arg_42_1)
	if not arg_42_0:InRange(arg_42_1) then
		return false
	else
		underscore = var_2

		local var_42_0 = var_2.detect
		local var_42_1 = arg_42_0.map

		tostring = var_5

		return var_42_0(var_42_1[var_5(arg_42_1)], function(arg_43_0)
			local var_43_0 = arg_43_0.class

			NenjuuGameNameSpace = var_2_10002

			return var_43_0 == var_2_10002.TargetIce
		end)
	end

	return
end

function var_0_0.BuildIce(arg_44_0, arg_44_1)
	local var_44_0

	local function var_44_1()
		arg_44_1.pos = arg_44_1.pos + arg_44_1.dirPos

		local var_45_0 = arg_44_0

		if var_0.Moveable(var_45_0, arg_44_1.pos) then
			local var_45_1 = arg_44_0

			var_0.CreateTarget(var_45_1, {
				create = true,
				name = "Ice",
				pos = arg_44_1.pos
			})

			arg_44_1.power = arg_44_1.power - 1

			if arg_44_1.power > 0 then
				table = var_0

				var_0.insert(arg_44_0.timeQueue, {
					time = 0.035,
					func = var_44_1
				})
			end
		end

		return
	end

	table = var_1_10003

	var_1_10003.insert(arg_44_0.timeQueue, {
		time = 0,
		func = var_44_1
	})

	return
end

function var_0_0.BreakIce(arg_46_0, arg_46_1)
	local var_46_0

	if not arg_46_1.power then
		math = var_46_0
		var_46_0 = var_46_0.max(arg_46_0.mapSize.x, arg_46_0.mapSize.y)
	end

	arg_46_1.power = var_46_0

	local var_46_1

	local function var_46_2()
		arg_46_1.pos = arg_46_1.pos + arg_46_1.dirPos

		local var_47_0 = arg_46_0

		if var_0.OnlyBreakIce(var_47_0, arg_46_1.pos) then
			local var_47_1 = arg_46_0

			var_0.CreateTarget(var_47_1, {
				name = "EF_Break_" .. arg_46_1.dir,
				pos = arg_46_1.pos
			})

			arg_46_1.power = arg_46_1.power - 1

			if arg_46_1.power > 0 then
				table = var_0

				var_0.insert(arg_46_0.timeQueue, {
					time = 0.035,
					func = var_46_2
				})
			end
		end

		return
	end

	table = var_1_10003

	var_1_10003.insert(arg_46_0.timeQueue, {
		time = 0,
		func = var_46_2
	})

	return
end

function var_0_0.OnlyBreakIce(arg_48_0, arg_48_1)
	if arg_48_0:CheckIce(arg_48_1) and not var_2.isLost then
		var_2:Break()

		return true
	else
		return false
	end

	return
end

local var_0_2 = {
	{
		1,
		-1
	},
	{
		1,
		1
	},
	{
		-1,
		1
	},
	{
		-1,
		-1
	}
}
local var_0_3 = {
	E = 2,
	S = 3,
	N = 1,
	W = 4
}

function var_0_0.BuildBomb(arg_49_0, arg_49_1)
	local var_49_0 = 0

	for iter_49_0 = 1, 2 do
		for iter_49_1 = 1, 4 do
			local var_49_1 = var_0_2[(var_0_3[arg_49_1.dir] + iter_49_1 + 2) % 4 + 1]

			for iter_49_2 = -iter_49_0, iter_49_0 - 1 do
				var_49_0 = var_49_0 + 1

				local var_49_2 = {
					iter_49_0,
					iter_49_2
				}
				local var_49_3 = arg_49_1.pos

				NewPos = var_1_10018

				local var_49_4 = var_49_3 + var_1_10018(var_49_1[1] * var_49_2[iter_49_1 % 2 + 1], var_49_1[2] * var_49_2[(iter_49_1 + 1) % 2 + 1])

				if arg_49_0:Moveable(var_49_4, false, true) then
					table = var_1_10018

					var_1_10018.insert(arg_49_0.timeQueue, {
						time = (var_49_0 - 1) * 0.015,
						func = function()
							local var_50_0 = arg_49_0

							var_0.CreateTarget(var_50_0, {
								name = "Bomb",
								pos = var_49_4
							})

							return
						end
					})
				end
			end
		end
	end

	return
end

function var_0_0.CheckMelt(arg_51_0, arg_51_1)
	string = var_1_10002

	local var_51_0 = var_1_10002.split
	local var_51_1 = arg_51_0.plane

	tostring = var_1_10005

	return var_51_0(var_51_1[var_1_10005(arg_51_1)], "_")[2] == "warm"
end

function var_0_0.ScareEnemy(arg_52_0, arg_52_1)
	ipairs = var_1_10002

	for iter_52_0, iter_52_1 in var_1_10002({
		arg_52_0.moveNenjuu,
		arg_52_0.moveDoppel
	}) do
		local var_52_0 = arg_52_1.pos - iter_52_1.realPos

		math = var_8

		local var_52_1 = var_8.abs(var_52_0.x)

		math = var_1_10009

		if var_52_1 + var_1_10009.abs(var_52_0.y) <= arg_52_1.range then
			iter_52_1:BeScare()
		end
	end

	return
end

function var_0_0.AttackCheck(arg_53_0, arg_53_1)
	NewPos = var_1_10002

	local var_53_0 = var_1_10002(-0.5, -0.5)

	NewPos = var_1_10003

	local var_53_1 = var_1_10003(0.5, 0.5)
	local var_53_2 = arg_53_1.dirPos.x + arg_53_1.dirPos.y

	if arg_53_1.dirPos.x == 0 then
		var_53_0.y = var_53_0.y + var_53_2 * 0.5 + (var_53_2 - 1) * 0
		var_53_1.y = var_53_1.y + var_53_2 * 0.5 + (var_53_2 + 1) * 0
	elseif arg_53_1.dirPos.y == 0 then
		var_53_0.x = var_53_0.x + var_53_2 * 0.5 + (var_53_2 - 1) * 0
		var_53_1.x = var_53_1.x + var_53_2 * 0.5 + (var_53_2 + 1) * 0
	else
		assert = var_5

		var_5(false)
	end

	local var_53_3 = arg_53_0.moveFuShun.realPos - arg_53_1.pos

	math = var_6

	if var_6.clamp(var_53_3.x, var_53_0.x, var_53_1.x) == var_53_3.x then
		math = var_6

		local var_53_4

		if var_6.clamp(var_53_3.y, var_53_0.y, var_53_1.y) ~= var_53_3.y then
			var_53_4 = false
		else
			var_53_4 = true
		end

		return var_53_4
	end
end

function var_0_0.EnemyAttack(arg_54_0, arg_54_1)
	if arg_54_0:AttackCheck(arg_54_1) then
		local var_54_0 = arg_54_0.moveFuShun

		var_2.EnemyHit(var_54_0, arg_54_1.pos)
	end

	return
end

function var_0_0.GetDecoyPos(arg_55_0, arg_55_1, arg_55_2)
	local var_55_0 = {}

	NenjuuGameConfig = var_1_10004

	for iter_55_0 = -var_1_10004.DECOY_RANGE, var_4 do
		for iter_55_1 = -var_4, var_4 do
			NewPos = var_1_10013
			var_1_10013 = arg_55_1 + var_1_10013(iter_55_0, iter_55_1)

			if arg_55_0:Moveable(var_1_10013) then
				table = var_14

				var_14.insert(var_55_0, var_1_10013)
			end
		end
	end

	math = var_5

	return var_55_0[var_5.random(#var_55_0)]
end

function var_0_0.BuildDecoy(arg_56_0, arg_56_1)
	arg_56_0:CreateTarget({
		name = "Decoy",
		pos = arg_56_1
	})

	return
end

local var_0_4 = {
	{
		1,
		0
	},
	{
		0,
		1
	},
	{
		-1,
		0
	},
	{
		0,
		-1
	}
}

function var_0_0.GetWayfindingMap(arg_57_0, arg_57_1, arg_57_2)
	if not arg_57_0.dirtyMap and arg_57_0.wayfindCache[arg_57_2] and (arg_57_0.wayfindCache[arg_57_2].inLantern and arg_57_0.wayfindCache[arg_57_2].inLantern > 0 or false) == (arg_57_0.moveFuShun.inLantern and arg_57_0.moveFuShun.inLantern > 0 or false) and arg_57_0.wayfindCache[arg_57_2].pos == arg_57_0.moveFuShun.pos and arg_57_0.wayfindCache[arg_57_2].basePos == arg_57_1 then
		return arg_57_0.wayfindCache[arg_57_2].map
	end

	arg_57_0.dirtyMap = false

	local var_57_0 = {}
	local var_57_1 = arg_57_0.moveFuShun.pos
	local var_57_2 = arg_57_0.moveFuShun
	local var_57_3 = var_57_1 + var_5.GetDirPos(var_57_2)

	if arg_57_2 and arg_57_0:InRange(var_57_3) then
		table = var_5

		var_5.insert(var_57_0, var_57_3)
	else
		table = var_5

		var_5.insert(var_57_0, arg_57_0.moveFuShun.pos)
	end

	local var_57_4 = {}

	tostring = var_1_10006
	var_57_4[var_1_10006(var_57_0[1])] = {
		value = 0,
		pos = var_57_0[1]
	}

	local var_57_5 = 0

	while var_57_5 < #var_57_0 do
		local var_57_6 = var_57_0[var_57_5 + 1]

		tostring = var_57_7

		local var_57_7 = var_57_4[var_57_7(var_57_6)].value + 1

		ipairs = var_1_10009

		for iter_57_0, iter_57_1 in var_1_10009(var_0_4) do
			NewPos = var_1_10014
			unpack = var_1_10016

			if var_57_6 + var_1_10014(var_1_10016(iter_57_1)) == arg_57_1 or arg_57_0:Moveable(var_1_10014, not arg_57_2) then
				tostring = var_1_10015

				if not var_57_4[var_1_10015(var_1_10014)] then
					var_57_4[var_1_10015] = {
						pos = var_1_10014,
						value = var_57_7,
						last = var_57_6
					}
					table = var_1_10016

					var_1_10016.insert(var_57_0, var_1_10014)
				elseif var_57_7 < var_57_4[var_1_10015].value then
					var_1_10016 = var_57_4[var_1_10015]
					var_1_10016.value = var_57_7
					var_1_10016 = var_57_4[var_1_10015]
					var_1_10016.last = var_57_6
				end
			end
		end
	end

	if arg_57_0.moveFuShun.inLantern then
		NenjuuGameConfig = var_7

		for iter_57_2 = -var_7.LANTERN_RANGE, var_7 do
			for iter_57_3 = -var_7, var_7 do
				tostring = var_1_10016

				local var_57_8 = arg_57_0.moveFuShun.pos

				NewPos = var_1_10019

				if var_57_4[var_1_10016(var_57_8 + var_1_10019(iter_57_2, iter_57_3))] then
					var_1_10016.lightValue = 1000 - var_1_10016.value
				end
			end
		end
	end

	arg_57_0.wayfindCache[arg_57_2] = {
		pos = arg_57_0.moveFuShun.pos,
		inLantern = arg_57_0.moveFuShun.inLantern,
		basePos = arg_57_1,
		map = var_57_4
	}

	return var_57_4
end

function var_0_0.GetTeleportTargetPos(arg_58_0, arg_58_1, arg_58_2)
	local var_58_0 = arg_58_0.moveFuShun.pos - arg_58_2

	math = var_1_10004

	local var_58_1 = var_1_10004.random(4)
	local var_58_2 = {}

	pairs = var_6

	for iter_58_0, iter_58_1 in var_6(arg_58_1) do
		local var_58_3 = iter_58_1.pos - arg_58_2

		table = var_1_10012
		var_1_10012 = var_1_10012.insert

		local var_58_4 = var_58_2
		local var_58_5 = {
			pos = iter_58_1.pos,
			value = iter_58_1.value
		}

		math = var_16

		local var_58_6 = var_16.abs(var_58_3.x)

		math = var_1_10017
		var_58_5.mDis = var_58_6 + var_1_10017.abs(var_58_3.y)

		var_1_10012(var_58_4, var_58_5)
	end

	table = var_6

	local var_58_7 = var_6.sort
	local var_58_8 = var_58_2

	CompareFuncs = iter_58_0

	var_58_7(var_58_8, iter_58_0({
		function(arg_59_0)
			math = var_2_10001

			return var_2_10001.abs(arg_59_0.value - var_58_1)
		end,
		function(arg_60_0)
			return arg_60_0.mDis
		end
	}))

	return var_58_2[1].pos
end

function var_0_0.StealthCheck(arg_61_0, arg_61_1)
	local var_61_0 = arg_61_0.moveFuShun.pos - arg_61_1

	math = var_1_10003

	local var_61_1 = var_1_10003.abs(var_61_0.x)

	math = var_1_10004

	return var_61_1 + var_1_10004.abs(var_61_0.y) < 10
end

function var_0_0.BuildTeleportSign(arg_62_0, arg_62_1)
	arg_62_0:CreateTarget({
		name = "SignWarp",
		pos = arg_62_1.pos,
		time = arg_62_1.time
	})

	return
end

function var_0_0.GetEnemyEffect(arg_63_0, arg_63_1)
	local var_63_0 = arg_63_0.moveNenjuu

	return var_2.CheckAbility(var_63_0, arg_63_1)
end

function var_0_0.BuildBlackHole(arg_64_0)
	local var_64_0 = {}

	for iter_64_0 = 1, arg_64_0.mapSize.x do
		for iter_64_1 = 1, arg_64_0.mapSize.y do
			NewPos = var_1_10010
			var_1_10010 = var_1_10010(iter_64_0 - 1, iter_64_1 - 1)

			if arg_64_0:Moveable(var_1_10010, true) then
				table = var_11

				var_11.insert(var_64_0, var_1_10010)
			end
		end
	end

	math = var_2

	local var_64_1 = var_64_0[var_2.random(#var_64_0)]

	arg_64_0:CreateTarget({
		time = 20,
		name = "BlackHole",
		pos = var_64_1
	})

	return
end

function var_0_0.InBlackHoleRange(arg_65_0, arg_65_1, arg_65_2)
	if arg_65_2 then
		if arg_65_0:InRange(arg_65_1) then
			underscore = var_1_10003
			var_1_10003 = var_1_10003.detect

			local var_65_0 = arg_65_0.map

			tostring = var_6
			var_1_10003 = var_1_10003(var_65_0[var_6(arg_65_1)], function(arg_66_0)
				local var_66_0 = arg_66_0.class

				NenjuuGameNameSpace = var_2_10002

				return var_66_0 == var_2_10002.TargetBlackHole
			end)
		end

		if var_1_10003 and not var_1_10003.isLost then
			var_1_10003:BeTrigger()

			return true
		else
			return false
		end
	else
		NenjuuGameConfig = var_1_10003

		for iter_65_0 = -var_1_10003.BLACK_HOLE_RANGE, var_3 do
			for iter_65_1 = -var_3, var_3 do
				NewPos = var_1_10012
				var_1_10012 = arg_65_1 + var_1_10012(iter_65_0, iter_65_1)

				if arg_65_0:InRange(var_1_10012) then
					underscore = var_13

					local var_65_1 = var_13.any
					local var_65_2 = arg_65_0.map

					tostring = var_16

					if var_65_1(var_65_2[var_16(var_1_10012)], function(arg_67_0)
						local var_67_0 = arg_67_0.class

						NenjuuGameNameSpace = var_2_10002

						return var_67_0 == var_2_10002.TargetBlackHole
					end) then
						return true
					end
				end
			end
		end
	end

	return
end

function var_0_0.BuildDoppelgangers(arg_68_0, arg_68_1)
	for iter_68_0 = -2, 2 do
		for iter_68_1 = -2, 2 do
			NewPos = var_1_10010
			var_1_10010 = arg_68_1 + var_1_10010(iter_68_0, iter_68_1)

			if arg_68_0:Moveable(var_1_10010) then
				arg_68_0.moveDoppel = arg_68_0:CreateTarget({
					name = "Nenjuu_Doppelgangers",
					isDoppel = true,
					pos = var_1_10010,
					abilitys = {}
				})

				return
			end
		end
	end

	return
end

function var_0_0.EatItem(arg_69_0, arg_69_1)
	ipairs = var_1_10002

	local var_69_0 = arg_69_0.map

	tostring = var_1_10005

	for iter_69_0, iter_69_1 in var_1_10002(var_69_0[var_1_10005(arg_69_1)]) do
		local var_69_1 = iter_69_1.class

		NenjuuGameNameSpace = var_1_10008

		if var_69_1 == var_1_10008.TargetItem then
			arg_69_0:DestoryTarget(iter_69_1)

			arg_69_0.itemCount = arg_69_0.itemCount - 1
			arg_69_0.point = arg_69_0.point + iter_69_1.point * arg_69_0.pointRate
			setText = var_7

			var_7(arg_69_0.textPoint, arg_69_0.point)

			local var_69_2 = arg_69_0.moveFuShun

			var_7.PopPoint(var_69_2, iter_69_1.point * arg_69_0.pointRate)

			if arg_69_0.itemCount == 0 then
				arg_69_0:CheckWave()
			end
		end
	end

	return
end

return var_0_0
