class = var_0_10000

local var_0_0 = var_0_10000("GuildDynamicBG")
local var_0_1 = false
local var_0_2 = false

require = var_0_10003

local var_0_3 = var_0_10003("view.guild.views.DynamicBG.GuildDynamicBGConfig")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.mainScrollrect = arg_1_1:Find("scrollrect")
	arg_1_0.assistScrollrect = arg_1_1:Find("scrollrect1")
	arg_1_0.pathContainer = arg_1_1:Find("scrollrect/content/path")
	arg_1_0.nameTF = arg_1_1:Find("name")
	arg_1_0.commanderTag = arg_1_1:Find("commander_tag")
	arg_1_0.path = {}
	arg_1_0.ships = {}
	arg_1_0.furnitures = {}
	onScroll = var_2

	var_2(nil, arg_1_0.mainScrollrect, function(arg_2_0)
		scrollTo = var_2_10001

		var_2_10001(arg_1_0.assistScrollrect, arg_2_0.x / 2, arg_2_0.y)

		return
	end)

	return
end

function var_0_0.Init(arg_3_0, arg_3_1)
	arg_3_0.shipVOs = arg_3_1 or {}
	seriesAsync = var_2

	var_2({
		function(arg_4_0)
			local var_4_0 = arg_3_0

			var_1.InitPath(var_4_0)
			arg_4_0()

			return
		end,
		function(arg_5_0)
			local var_5_0 = arg_3_0

			var_1.InitFurnitures(var_5_0, arg_5_0)

			return
		end,
		function(arg_6_0)
			if var_0_2 then
				local var_6_0 = arg_3_0

				var_1.AddDebugShip(var_6_0, arg_6_0)
			else
				local var_6_1 = arg_3_0

				var_1.InitShips(var_6_1, arg_6_0)
			end

			return
		end
	}, function()
		if var_0_1 then
			local var_7_0 = arg_3_0

			var_0.AddGridDebugView(var_7_0)
		end

		local var_7_1 = arg_3_0

		var_0.SortScene(var_7_1)

		return
	end)

	return
end

function var_0_0.InitPath(arg_8_0)
	local var_8_0 = var_0_3.gridCnt[1]
	local var_8_1 = var_0_3.gridCnt[2]
	local var_8_2 = var_0_3.cantWalkPos

	Vector2 = var_1_10004

	local var_8_3 = var_1_10004(var_0_3.gridSize[1], var_0_3.gridSize[2])

	Vector2 = var_1_10005

	local var_8_4 = var_1_10005(var_0_3.gridStartPos[1], var_0_3.gridStartPos[2])

	for iter_8_0 = 0, var_8_0 - 1 do
		arg_8_0.path[iter_8_0] = {}

		for iter_8_1 = 0, var_8_1 - 1 do
			_ = var_1_10014
			var_1_10014 = var_1_10014.any(var_8_2, function(arg_9_0)
				return arg_9_0[1] == iter_8_0 and arg_9_0[2] == iter_8_1
			end)
			GuildDynamicBgPathGrid = var_1_10015
			var_1_10015 = var_1_10015.New

			local var_8_5 = {}

			Vector2 = var_1_10018
			var_8_5.position = var_1_10018(iter_8_0, iter_8_1)
			var_8_5.canWalk = not var_1_10014
			var_8_5.sizeDelta = var_8_3
			var_8_5.startPosOffset = var_8_4
			var_1_10015 = var_1_10015(var_8_5)
			arg_8_0.path[iter_8_0][iter_8_1] = var_1_10015
		end
	end

	return
end

function var_0_0.GetRandomGrid(arg_10_0)
	local var_10_0 = {}

	pairs = var_1_10002

	for iter_10_0, iter_10_1 in var_1_10002(arg_10_0.path) do
		pairs = var_1_10007

		for iter_10_2, iter_10_3 in var_1_10007(iter_10_1) do
			if iter_10_3:CanWalk() then
				table = var_12

				var_12.insert(var_10_0, iter_10_3)
			end
		end
	end

	math = var_2

	return var_10_0[var_2.random(1, #var_10_0)]
end

function var_0_0.GetGrid(arg_11_0, arg_11_1, arg_11_2)
	return arg_11_0.path[arg_11_1][arg_11_2]
end

function var_0_0.InitFurnitures(arg_12_0, arg_12_1)
	local function var_12_0(arg_13_0, arg_13_1, arg_13_2)
		GetOrAddComponent = var_2_10003

		local var_13_0 = arg_13_1

		typeof = var_2_10006
		RectTransform = var_2_10008

		local var_13_1 = var_2_10003(var_13_0, var_2_10006(var_2_10008))

		Vector2 = var_2_10004
		var_13_1.pivot = var_2_10004(0, 0)

		local var_13_2 = arg_12_0
		local var_13_3 = var_4.GetGrid(var_13_2, arg_13_0.position[1], arg_13_0.position[2])

		assert = var_13_0

		var_13_0(var_13_3)

		GuildDynamicFurniture = var_13_0

		local var_13_4 = var_13_0.New
		local var_13_5 = {
			go = arg_13_1,
			grid = var_13_3,
			path = arg_12_0.path
		}

		Vector2 = var_8
		var_13_5.size = var_8(arg_13_0.size[1], arg_13_0.size[2])
		Vector2 = var_8
		var_13_5.offset = var_8(arg_13_0.offset[1], arg_13_0.offset[2])
		var_13_5.mode = arg_13_0.mode
		Vector2 = var_8
		var_13_5.interactionPosition = var_8(arg_13_0.interactionPosition[1], arg_13_0.interactionPosition[2])
		var_13_5.interactionDir = arg_13_0.interactionDir

		local var_13_6 = var_13_4(var_13_5)

		table = var_13_2

		var_13_2.insert(arg_12_0.furnitures, var_13_6)
		arg_13_2()

		return
	end

	local var_12_1 = {}
	local var_12_2 = var_0_3.furnitures

	ipairs = var_1_10005

	for iter_12_0, iter_12_1 in var_1_10005(var_12_2) do
		table = var_1_10010

		var_1_10010.insert(var_12_1, function(arg_14_0)
			ResourceMgr = var_2_10001

			local var_14_0 = var_2_10001.Inst
			local var_14_1 = var_1.getAssetAsync
			local var_14_2 = "furnitrues/guild/" .. iter_12_1.name
			local var_14_3 = ""

			typeof = var_2_10006
			GameObject = var_2_10008

			local var_14_4 = var_2_10006(var_2_10008)

			UnityEngine = var_2_10007

			var_14_1(var_14_0, var_14_2, var_14_3, var_14_4, var_2_10007.Events.UnityAction_UnityEngine_Object(function(arg_15_0)
				Object = var_3_10001

				local var_15_0 = var_3_10001.Instantiate(arg_15_0, arg_12_0.pathContainer)

				var_12_0(iter_12_1, var_15_0, arg_14_0)

				return
			end), true, true)

			return
		end)
	end

	seriesAsync = var_5

	var_5(var_12_1, arg_12_1)

	return
end

function var_0_0.InitShips(arg_16_0, arg_16_1)
	local var_16_0 = {}

	ipairs = var_1_10003

	for iter_16_0, iter_16_1 in var_1_10003(arg_16_0.shipVOs) do
		table = var_1_10008

		var_1_10008.insert(var_16_0, function(arg_17_0)
			local var_17_0 = arg_16_0

			var_1.AddShip(var_17_0, iter_16_1, arg_17_0)

			return
		end)
	end

	seriesAsync = var_3

	var_3(var_16_0, arg_16_1)

	return
end

function var_0_0.AddShip(arg_18_0, arg_18_1, arg_18_2)
	local function var_18_0(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
		local var_19_0 = arg_19_2:GetModel()

		arg_19_2:SetParent(arg_18_0.pathContainer)

		local var_19_1 = arg_19_2
		local var_19_2 = arg_19_2.SetLocalScale

		Vector3 = var_8

		var_19_2(var_19_1, var_8(0.5, 0.5, 1))

		GuildDynamicBgShip = var_19_2

		local var_19_3 = var_19_2.New({
			stand = arg_19_0.stand,
			auto = arg_19_0.auto,
			go = var_19_0,
			grid = arg_19_1,
			path = arg_18_0.path,
			furnitures = arg_18_0.furnitures,
			name = arg_19_0.name,
			isCommander = arg_19_0.isCommander,
			char = arg_19_2
		})

		var_5.SetOnMoveCallBack(var_19_3, function()
			local var_20_0 = arg_18_0

			var_0.SortScene(var_20_0)

			return
		end)

		table = var_6

		var_6.insert(arg_18_0.ships, var_5)
		arg_19_3()

		return
	end

	local var_18_1 = arg_18_1:getPrefab()

	if not arg_18_0:GetRandomGrid() then
		arg_18_2()
	end

	var_5:Lock()

	SpineAnimChar = var_6

	local var_18_2 = var_6.New()

	var_6.SetPaint(var_18_2, var_18_1)
	var_6:Load(true, function(arg_21_0)
		IsNil = var_2_10001

		if var_2_10001(arg_18_0.nameTF) then
			arg_21_0:Dispose()

			return
		end

		local var_21_0 = arg_21_0:GetModel()

		var_21_0.name = var_18_1
		cloneTplTo = var_2

		var_2(arg_18_0.nameTF, var_21_0.transform, "name")

		if arg_18_1.isCommander then
			cloneTplTo = var_2

			var_2(arg_18_0.commanderTag, var_21_0.transform, "tag")
		end

		var_18_0(arg_18_1, var_0, arg_21_0, arg_18_2)

		return
	end)

	return
end

function var_0_0.ExitShip(arg_22_0, arg_22_1)
	pairs = var_1_10002

	for iter_22_0, iter_22_1 in var_1_10002(arg_22_0.ships) do
		if iter_22_1.name == arg_22_1 then
			iter_22_1:Dispose()

			arg_22_0.ships[iter_22_0] = nil

			break
		end
	end

	return
end

function var_0_0.SortScene(arg_23_0)
	local var_23_0 = {}

	pairs = var_1_10002

	for iter_23_0, iter_23_1 in var_1_10002(arg_23_0.ships) do
		table = var_1_10007

		var_1_10007.insert(var_23_0, {
			obj = iter_23_1,
			position = iter_23_1.grid.position
		})
	end

	pairs = var_2

	for iter_23_2, iter_23_3 in var_2(arg_23_0.furnitures) do
		table = var_1_10007

		var_1_10007.insert(var_23_0, {
			obj = iter_23_3,
			position = iter_23_3.grid.position
		})
	end

	table = var_2

	var_2.sort(var_23_0, function(arg_24_0, arg_24_1)
		if arg_24_0.position.y == arg_24_1.position.y then
			return arg_24_0.position.x < arg_24_1.position.x
		else
			return arg_24_0.position.y > arg_24_1.position.y
		end

		return
	end)

	ipairs = var_2

	for iter_23_4, iter_23_5 in var_2(var_23_0) do
		local var_23_1 = iter_23_5.obj

		var_7.SetAsLastSibling(var_23_1)
	end

	return
end

function var_0_0.Dispose(arg_25_0)
	pairs = var_1_10001

	for iter_25_0, iter_25_1 in var_1_10001(arg_25_0.ships) do
		iter_25_1:Dispose()
	end

	pairs = var_1

	for iter_25_2, iter_25_3 in var_1(arg_25_0.furnitures) do
		iter_25_3:Dispose()
	end

	if var_0_1 then
		if arg_25_0.timer then
			local var_25_0 = arg_25_0.timer

			var_1.Stop(var_25_0)

			arg_25_0.timer = nil
		end

		if arg_25_0.timer1 then
			local var_25_1 = arg_25_0.timer1

			var_1.Stop(var_25_1)

			arg_25_0.timer1 = nil
		end
	end

	return
end

function var_0_0.AddGridDebugView(arg_26_0)
	local var_26_0 = {}

	pairs = var_1_10002

	for iter_26_0, iter_26_1 in var_1_10002(arg_26_0.path) do
		var_26_0[iter_26_0] = {}
		pairs = var_7

		for iter_26_2, iter_26_3 in var_7(iter_26_1) do
			GameObject = var_1_10012
			var_1_10012 = var_1_10012.New()
			SetParent = var_1_10013

			var_1_10013(var_1_10012, arg_26_0.pathContainer)

			GetOrAddComponent = var_1_10013

			local var_26_1 = var_1_10012

			typeof = var_16
			RectTransform = var_1_10018
			var_1_10013 = var_1_10013(var_26_1, var_16(var_1_10018))
			GetOrAddComponent = var_1_10014

			local var_26_2 = var_1_10012

			typeof = var_1_10017
			Image = var_1_10019
			var_1_10014 = var_1_10014(var_26_2, var_1_10017(var_1_10019))
			var_1_10013.sizeDelta = iter_26_3.sizeDelta
			Vector2 = var_15
			var_1_10013.pivot = var_15(0, 0)
			var_1_10013.localPosition = iter_26_3.localPosition
			var_26_0[iter_26_0][iter_26_2] = var_1_10014
			var_1_10012.name = iter_26_3.position.x .. "-" .. iter_26_3.position.y
			setActive = var_15

			var_15(var_1_10012, true)
		end
	end

	Timer = var_2
	arg_26_0.timer = var_2.New(function()
		pairs = var_2_10000

		for iter_27_0, iter_27_1 in var_2_10000(arg_26_0.path) do
			pairs = var_2_10005

			for iter_27_2, iter_27_3 in var_2_10005(iter_27_1) do
				local var_27_0

				if iter_27_3:IsLock() then
					Color = var_11
					var_27_0 = var_11.New(1, 0, 0, 0.3)
				elseif not iter_27_3:CanWalk() then
					Color = var_11
					var_27_0 = var_11.New(0.5, 0.5, 0.5, 0.3)
				else
					Color = var_11
					var_27_0 = var_11.New(1, 1, 1, 0.3)
				end

				var_26_0[iter_27_0][iter_27_2].color = var_27_0
			end
		end

		return
	end, 1, -1)

	local var_26_3 = arg_26_0.timer

	var_2.Start(var_26_3)
	arg_26_0.timer.func()

	return
end

function var_0_0.AddDebugShip(arg_28_0, arg_28_1)
	Ship = var_1_10002

	local var_28_0 = var_1_10002.New({
		id = 0,
		configId = 301284,
		name = "001"
	})

	var_28_0.stand = true
	arg_28_0.shipVOs = {
		var_28_0
	}

	arg_28_0:InitShips(function()
		local var_29_0 = arg_28_0

		Timer = var_2_10001

		local var_29_1 = var_2_10001.New

		local function var_29_2()
			Input = var_3_10000

			local var_30_0 = var_3_10000.GetKeyDown

			KeyCode = var_3_10002

			local var_30_1

			if var_30_0(var_3_10002.A) then
				var_30_1 = arg_28_0.ships[1]

				var_0.MoveLeft(var_30_1)
			end

			Input = var_0

			local var_30_2 = var_0.GetKeyDown

			KeyCode = var_30_1

			local var_30_3

			if var_30_2(var_30_1.S) then
				var_30_3 = arg_28_0.ships[1]

				var_0.MoveDown(var_30_3)
			end

			Input = var_0

			local var_30_4 = var_0.GetKeyDown

			KeyCode = var_30_3

			local var_30_5

			if var_30_4(var_30_3.W) then
				var_30_5 = arg_28_0.ships[1]

				var_0.MoveUp(var_30_5)
			end

			Input = var_0

			local var_30_6 = var_0.GetKeyDown

			KeyCode = var_30_5

			if var_30_6(var_30_5.D) then
				local var_30_7 = arg_28_0.ships[1]

				var_0.MoveRight(var_30_7)
			end

			return
		end

		Time = var_2_10004
		var_29_0.timer1 = var_29_1(var_29_2, var_2_10004.deltaTime, -1)

		local var_29_3 = arg_28_0.timer1

		var_0.Start(var_29_3)
		arg_28_0.timer1.func()
		arg_28_1()

		return
	end)

	return
end

return var_0_0
