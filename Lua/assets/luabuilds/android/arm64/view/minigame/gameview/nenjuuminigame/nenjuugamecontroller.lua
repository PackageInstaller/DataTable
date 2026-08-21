local var_0_0 = class("NenjuuGameController")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.binder = arg_1_1

	arg_1_0:InitTimer()
	arg_1_0:InitGameUI(arg_1_2)

	return
end

local function var_0_1(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs((arg_2_0:GetComponentsInChildren(typeof(Animator), true):ToTable())) do
		iter_2_1.speed = arg_2_1
	end

	return
end

function var_0_0.InitTimer(arg_3_0)
	arg_3_0.timer = Timer.New(function()
		arg_3_0:OnTimer(NenjuuGameConfig.TIME_INTERVAL)

		return
	end, NenjuuGameConfig.TIME_INTERVAL, -1)
	arg_3_0.handle = arg_3_0.handle or UpdateBeat:CreateListener(arg_3_0.Update, arg_3_0)

	UpdateBeat:AddListener(arg_3_0.handle)

	return
end

function var_0_0.InitGameUI(arg_5_0, arg_5_1)
	arg_5_0.rtViewport = arg_5_1:Find("Viewport")
	arg_5_0.rtMainContent = arg_5_0.rtViewport:Find("MainContent")
	arg_5_0.rtResource = arg_5_1:Find("Resource")
	arg_5_0.rtJoyStick = arg_5_1:Find("Controller/bottom/joy_stick")

	local var_5_0 = {
		"E",
		"S",
		"W",
		"N"
	}

	for iter_5_0, iter_5_1 in ipairs({
		"right",
		"down",
		"left",
		"up"
	}) do
		local var_5_1 = arg_5_0.rtJoyStick:Find(iter_5_1):GetComponent(typeof(EventTriggerListener))

		var_5_1:AddPointDownFunc(function()
			arg_5_0.cacheInput = var_5_0[iter_5_0]

			return
		end)
		var_5_1:AddPointEnterFunc(function()
			if arg_5_0.cacheInput and arg_5_0.cacheInput ~= var_5_0[iter_5_0] then
				arg_5_0.cacheInput = var_5_0[iter_5_0]
			end

			return
		end)
		var_5_1:AddPointUpFunc(function()
			if arg_5_0.cacheInput then
				arg_5_0.cacheInput = nil
			end

			return
		end)
	end

	arg_5_0.inPress = {}
	arg_5_0.rtSkillButton = arg_5_1:Find("Controller/bottom/skill_button")

	for iter_5_2 = 0, 3 do
		local var_5_2 = arg_5_0.rtSkillButton:Find("Skill_" .. iter_5_2):GetComponent(typeof(EventTriggerListener))

		var_5_2:AddPointDownFunc(function()
			arg_5_0.inPress[var_0] = true

			return
		end)
		var_5_2:AddPointUpFunc(function()
			arg_5_0.inPress[var_0] = false

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
	if IsUnityEditor then
		for iter_12_0, iter_12_1 in ipairs({
			"D",
			"S",
			"A",
			"W"
		}) do
			if Input.GetKeyDown(KeyCode[iter_12_1]) then
				arg_12_0.cacheInput = ({
					"E",
					"S",
					"W",
					"N"
				})[iter_12_0]
			end

			if Input.GetKeyUp(KeyCode[iter_12_1]) and arg_12_0.cacheInput == ({
				"E",
				"S",
				"W",
				"N"
			})[iter_12_0] then
				arg_12_0.cacheInput = nil
			end
		end
	end

	return
end

function var_0_0.InitMapConfig(arg_13_0, arg_13_1)
	arg_13_0.pointRate = arg_13_1.rate
	arg_13_0.config = NenjuuGameConfig.GetStageConfig("Spring23Level_" .. arg_13_1.index)

	for iter_13_0, iter_13_1 in ipairs(pg.MiniGameTileMgr.GetInstance():getDataLayers("Spring23Game", "Spring23Level_" .. arg_13_1.index)) do
		({})[iter_13_1.name] = iter_13_1
	end

	arg_13_0.timeCount = arg_13_0.config.extra_time[1]
	arg_13_0.point = 0

	setText(arg_13_0.textTime, string.format("%02d:%02ds", math.floor(arg_13_0.timeCount / 60), math.floor(arg_13_0.timeCount % 60)))
	setText(arg_13_0.textPoint, arg_13_0.point)
	eachChild(arg_13_0.rtCollection, function(arg_14_0)
		setActive(arg_14_0, false)

		return
	end)

	arg_13_0.mapSize = NewPos(({}).floor.width, ({}).floor.height)

	setSizeDelta(arg_13_0.rtMainContent, arg_13_0.mapSize * 32)

	arg_13_0.buffer = NewPos(math.max(arg_13_0.rtMainContent.rect.width + 192 - arg_13_0.rtViewport.rect.width, 0), math.max(arg_13_0.rtMainContent.rect.height + 160 - arg_13_0.rtViewport.rect.height, 0)) * 0.5

	for iter_13_2, iter_13_3 in ipairs(({}).floor.layer) do
		arg_13_0.plane[tostring((NewPos((iter_13_3.index - 1) % arg_13_0.mapSize.x, math.floor((iter_13_3.index - 1) / arg_13_0.mapSize.x))))] = iter_13_3.item
	end

	local var_13_0 = {
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
			local var_13_1 = arg_13_0.plane[iter_13_5 .. "_" .. iter_13_4] or "Snow"
			local var_13_2 = arg_13_0.rtResource:Find("plane/" .. var_13_1)

			if not var_13_2 then
				var_13_2 = cloneTplTo(arg_13_0.rtResource:Find("plane/Road"), arg_13_0.rtMainContent:Find("plane"))

				setImageSprite(var_13_2:Find("scale/Image"), getImageSprite(arg_13_0.rtResource:Find("plane_sprite/" .. var_13_1)))
			else
				var_13_2 = cloneTplTo(var_13_2, arg_13_0.rtMainContent:Find("plane"))
			end

			if var_13_2:Find("scale/Snow") then
				for iter_13_6 = -1, 1 do
					for iter_13_7 = -1, 1 do
						if (function(arg_15_0, arg_15_1)
							return not arg_13_0:InRange(NewPos(arg_15_0, arg_15_1)) or not arg_13_0.plane[arg_15_0 .. "_" .. arg_15_1] or arg_13_0.plane[arg_15_0 .. "_" .. arg_15_1] == "Snow"
						end)(iter_13_5 + iter_13_6, iter_13_4 + iter_13_7) and (iter_13_6 == 0 or iter_13_7 == 0 or not (function(arg_15_0, arg_15_1)
							return not arg_13_0:InRange(NewPos(arg_15_0, arg_15_1)) or not arg_13_0.plane[arg_15_0 .. "_" .. arg_15_1] or arg_13_0.plane[arg_15_0 .. "_" .. arg_15_1] == "Snow"
						end)(iter_13_5, iter_13_4 + iter_13_7) and not (function(arg_15_0, arg_15_1)
							return not arg_13_0:InRange(NewPos(arg_15_0, arg_15_1)) or not arg_13_0.plane[arg_15_0 .. "_" .. arg_15_1] or arg_13_0.plane[arg_15_0 .. "_" .. arg_15_1] == "Snow"
						end)(iter_13_5 + iter_13_6, iter_13_4)) then
							setActive(var_13_2:Find("scale/Snow/" .. var_13_0[iter_13_6 .. "_" .. iter_13_7]), true)
						end
					end
				end
			end
		end
	end

	for iter_13_8, iter_13_9 in ipairs(({}).item.layer) do
		local var_13_3 = arg_13_0:CreateTarget({
			name = iter_13_9.item,
			pos = NewPos((iter_13_9.index - 1) % arg_13_0.mapSize.x, math.floor((iter_13_9.index - 1) / arg_13_0.mapSize.x))
		})
	end

	for iter_13_10, iter_13_11 in ipairs(({}).character.layer) do
		switch(({
			name = iter_13_11.item,
			pos = NewPos((iter_13_11.index - 1) % arg_13_0.mapSize.x, math.floor((iter_13_11.index - 1) / arg_13_0.mapSize.x))
		}).name, {
			FuShun = function()
				var_0.level = arg_13_1.FuShun.level
				var_0.itemType = arg_13_1.FuShun.item
				arg_13_0.moveFuShun = arg_13_0:CreateTarget(var_0)

				return
			end,
			Nenjuu = function()
				var_0.abilitys = arg_13_1.Nenjuu
				arg_13_0.moveNenjuu = arg_13_0:CreateTarget(var_0)

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

		local var_18_0, var_18_1, var_18_2 = unpack(arg_18_0.config.wave[arg_18_0.wave])

		arg_18_0.itemType = var_18_0
		arg_18_0.itemCount = var_18_1

		for iter_18_0 = 0, arg_18_0.mapSize.x - 1 do
			for iter_18_1 = 0, arg_18_0.mapSize.y - 1 do
				local var_18_3 = NewPos(iter_18_0, iter_18_1)

				if arg_18_0:Moveable(var_18_3, true) and not arg_18_0.hideMap[tostring(var_18_3)] then
					table.insert({}, var_18_3)
				end
			end
		end

		for iter_18_2 = 1, arg_18_0.itemCount do
			local var_18_4

			repeat
				var_18_4 = math.random(#{})

				local var_18_5 = 0

				for iter_18_3 = -1, 1 do
					for iter_18_4 = -1, 1 do
						local var_18_6 = ({})[var_18_4] + NewPos(iter_18_3, iter_18_4)

						if arg_18_0:InRange(var_18_6) and underscore.any(arg_18_0.map[tostring(var_18_6)], function(arg_19_0)
							return arg_19_0.class == NenjuuGameNameSpace.TargetItem
						end) then
							var_18_5 = var_18_5 + 1
						end
					end
				end
			until var_18_5 < 7

			arg_18_0:CreateTarget({
				name = var_18_0,
				pos = table.remove({}, var_18_4),
				point = var_18_2
			})
		end

		eachChild(arg_18_0.rtCollection, function(arg_20_0)
			setActive(arg_20_0, arg_20_0.name == arg_18_0.itemType)

			return
		end)
	else
		arg_18_0.point = arg_18_0.point + arg_18_0.config.extra_time[2] * arg_18_0.pointRate

		setText(arg_18_0.textPoint, arg_18_0.point)
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
		return underscore.all(arg_22_0.map[tostring(arg_22_1)], function(arg_23_0)
			local var_23_0 = arg_23_0:Moveable()

			if not var_23_0 then
				if arg_22_2 then
					var_23_0 = arg_23_0:BreakMoveable() or arg_22_3 and isa(arg_23_0, NenjuuGameNameSpace.TargetMove)

					return var_23_0
				end
			end
		end)
	end

	return
end

function var_0_0.CreateTarget(arg_24_0, arg_24_1)
	local var_24_0, var_24_1, var_24_2 = NenjuuGameConfig.GetCreateConfig(arg_24_1)

	if not var_24_0 then
		return
	end

	local var_24_3 = arg_24_1.parent and cloneTplTo(arg_24_0.rtResource:Find(var_24_1), arg_24_1.parent) or cloneTplTo(arg_24_0.rtResource:Find(var_24_1), arg_24_0.rtMainContent:Find(var_24_2))
	local var_24_4 = var_24_0.New(arg_24_0, var_24_3, arg_24_1)

	if var_24_4:InTimeLine() then
		table.insert(arg_24_0.timeFlow, var_24_4)
	end

	return var_24_4
end

function var_0_0.DestoryTarget(arg_25_0, arg_25_1)
	arg_25_0.dirtyMap = true

	table.removebyvalue(arg_25_0.map[tostring(arg_25_1.pos)], arg_25_1)

	if arg_25_1:InTimeLine() then
		table.removebyvalue(arg_25_0.timeFlow, arg_25_1)
	end

	Destroy(arg_25_1._tf)

	arg_25_1 = nil

	return
end

function var_0_0.ResetGame(arg_26_0)
	for iter_26_0, iter_26_1 in ipairs({
		"plane",
		"object",
		"effect",
		"character"
	}) do
		eachChild(arg_26_0.rtMainContent:Find(iter_26_1), function(arg_27_0)
			Destroy(arg_27_0)

			return
		end)
	end

	arg_26_0.map = setmetatable({}, {
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
	arg_31_0.binder:openUI("result")

	return
end

function var_0_0.ResumeGame(arg_32_0)
	arg_32_0.isPause = false

	arg_32_0.timer:Start()
	var_0_1(arg_32_0.rtMainContent, 1)

	return
end

function var_0_0.PauseGame(arg_33_0)
	arg_33_0.isPause = true

	arg_33_0.timer:Stop()
	var_0_1(arg_33_0.rtMainContent, 0)

	return
end

function var_0_0.OnTimer(arg_34_0, arg_34_1)
	arg_34_0.timeCount = arg_34_0.timeCount - arg_34_1

	setText(arg_34_0.textTime, string.format("%02d:%02ds", math.floor(arg_34_0.timeCount / 60), math.floor(arg_34_0.timeCount % 60)))

	if arg_34_0.timeCount <= 0 then
		arg_34_0:EndGame()

		return
	end

	for iter_34_0, iter_34_1 in ipairs(arg_34_0.timeFlow) do
		iter_34_1:OnTimerUpdate(arg_34_1)
	end

	for iter_34_2, iter_34_3 in ipairs(arg_34_0.timeQueue) do
		iter_34_3.time = iter_34_3.time - arg_34_1
	end

	table.sort(arg_34_0.timeQueue, CompareFuncs({
		function(arg_35_0)
			return -arg_35_0.time
		end
	}))

	while #arg_34_0.timeQueue > 0 and arg_34_0.timeQueue[#arg_34_0.timeQueue].time <= 0 do
		table.remove(arg_34_0.timeQueue).func()
	end

	arg_34_0:UpdateSkillButtons()

	return
end

function var_0_0.UpdateSkillButtons(arg_36_0)
	for iter_36_0, iter_36_1 in ipairs(arg_36_0.moveFuShun:CalcSkillCDs()) do
		local var_36_0 = arg_36_0.rtSkillButton:Find("Skill_" .. iter_36_0 - 1)

		eachChild(var_36_0:Find("icon"), function(arg_37_0)
			setActive(arg_37_0, arg_37_0.name == iter_36_1.icon)

			return
		end)

		if not iter_36_1.cd then
			setActive(var_36_0:Find("cd"), false)
			setActive(var_36_0:Find("lock"), true)
		elseif iter_36_1.cd == true then
			setActive(var_36_0:Find("cd"), true)
			setFillAmount(var_36_0:Find("cd"), 1)
			setText(var_36_0:Find("cd/Text"), "")
			setActive(var_36_0:Find("lock"), false)
		elseif iter_36_1.cd > 0 then
			setActive(var_36_0:Find("cd"), true)
			setFillAmount(var_36_0:Find("cd"), iter_36_1.rate)
			setText(var_36_0:Find("cd/Text"), math.ceil(iter_36_1.cd) .. "s")
			setActive(var_36_0:Find("lock"), false)
		else
			setActive(var_36_0:Find("cd"), false)
			setActive(var_36_0:Find("lock"), false)
		end
	end

	return
end

function var_0_0.GetCacheInput(arg_38_0, arg_38_1)
	if arg_38_1 then
		arg_38_0.cacheInput = nil

		return arg_38_0.cacheInput
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
			local var_40_1 = NewPos(iter_40_0, iter_40_1)

			if arg_40_2 then
				table.removebyvalue(arg_40_0.map[tostring(arg_40_2 + var_40_1)], arg_40_1)
			end

			table.insert(arg_40_0.map[tostring(arg_40_3 + var_40_1)], arg_40_1)
		end
	end

	if arg_40_1.canHide then
		for iter_40_2 = 0, var_40_0.x - 1 do
			local var_40_2 = arg_40_3 + NewPos(iter_40_2, -1)

			if arg_40_0:InRange(var_40_2) then
				arg_40_0.hideMap[tostring(var_40_2)] = true
			end
		end
	end

	return
end

function var_0_0.WindowFocrus(arg_41_0, arg_41_1)
	setAnchoredPosition(arg_41_0.rtMainContent, {
		x = math.clamp(-arg_41_1.x, -arg_41_0.buffer.x, arg_41_0.buffer.x),
		y = math.clamp(-arg_41_1.y, -arg_41_0.buffer.y - 16, arg_41_0.buffer.y - 16)
	})

	return
end

function var_0_0.CheckIce(arg_42_0, arg_42_1)
	if not arg_42_0:InRange(arg_42_1) then
		return false
	else
		return underscore.detect(arg_42_0.map[tostring(arg_42_1)], function(arg_43_0)
			return arg_43_0.class == NenjuuGameNameSpace.TargetIce
		end)
	end

	return
end

function var_0_0.BuildIce(arg_44_0, arg_44_1)
	table.insert(arg_44_0.timeQueue, {
		time = 0,
		func = function()
			arg_44_1.pos = arg_44_1.pos + arg_44_1.dirPos

			if arg_44_0:Moveable(arg_44_1.pos) then
				arg_44_0:CreateTarget({
					create = true,
					name = "Ice",
					pos = arg_44_1.pos
				})

				arg_44_1.power = arg_44_1.power - 1

				if arg_44_1.power > 0 then
					table.insert(arg_44_0.timeQueue, {
						time = 0.035,
						func = var_0
					})
				end
			end

			return
		end
	})

	return
end

function var_0_0.BreakIce(arg_46_0, arg_46_1)
	arg_46_1.power = arg_46_1.power or math.max(arg_46_0.mapSize.x, arg_46_0.mapSize.y)

	table.insert(arg_46_0.timeQueue, {
		time = 0,
		func = function()
			arg_46_1.pos = arg_46_1.pos + arg_46_1.dirPos

			if arg_46_0:OnlyBreakIce(arg_46_1.pos) then
				arg_46_0:CreateTarget({
					name = "EF_Break_" .. arg_46_1.dir,
					pos = arg_46_1.pos
				})

				arg_46_1.power = arg_46_1.power - 1

				if arg_46_1.power > 0 then
					table.insert(arg_46_0.timeQueue, {
						time = 0.035,
						func = var_0
					})
				end
			end

			return
		end
	})

	return
end

function var_0_0.OnlyBreakIce(arg_48_0, arg_48_1)
	local var_48_0 = arg_48_0:CheckIce(arg_48_1)

	if var_48_0 and not var_48_0.isLost then
		var_48_0:Break()

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
			for iter_49_2 = -iter_49_0, iter_49_0 - 1 do
				var_49_0 = var_49_0 + 1

				if arg_49_0:Moveable(arg_49_1.pos + NewPos(var_0_2[(var_0_3[arg_49_1.dir] + iter_49_1 + 2) % 4 + 1][1] * ({
					iter_49_0,
					iter_49_2
				})[iter_49_1 % 2 + 1], var_0_2[(var_0_3[arg_49_1.dir] + iter_49_1 + 2) % 4 + 1][2] * ({
					iter_49_0,
					iter_49_2
				})[(iter_49_1 + 1) % 2 + 1]), false, true) then
					table.insert(arg_49_0.timeQueue, {
						time = (var_49_0 - 1) * 0.015,
						func = function()
							arg_49_0:CreateTarget({
								name = "Bomb",
								pos = var_0
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
	return string.split(arg_51_0.plane[tostring(arg_51_1)], "_")[2] == "warm"
end

function var_0_0.ScareEnemy(arg_52_0, arg_52_1)
	for iter_52_0, iter_52_1 in ipairs({
		arg_52_0.moveNenjuu,
		arg_52_0.moveDoppel
	}) do
		if math.abs((arg_52_1.pos - iter_52_1.realPos).x) + math.abs((arg_52_1.pos - iter_52_1.realPos).y) <= arg_52_1.range then
			iter_52_1:BeScare()
		end
	end

	return
end

function var_0_0.AttackCheck(arg_53_0, arg_53_1)
	local var_53_0 = NewPos(-0.5, -0.5)
	local var_53_1 = NewPos(0.5, 0.5)

	if arg_53_1.dirPos.x == 0 then
		var_53_0.y = var_53_0.y + (arg_53_1.dirPos.x + arg_53_1.dirPos.y) * 0.5 + (arg_53_1.dirPos.x + arg_53_1.dirPos.y - 1) * 0
		var_53_1.y = var_53_1.y + (arg_53_1.dirPos.x + arg_53_1.dirPos.y) * 0.5 + (arg_53_1.dirPos.x + arg_53_1.dirPos.y + 1) * 0
	elseif arg_53_1.dirPos.y == 0 then
		var_53_0.x = var_53_0.x + (arg_53_1.dirPos.x + arg_53_1.dirPos.y) * 0.5 + (arg_53_1.dirPos.x + arg_53_1.dirPos.y - 1) * 0
		var_53_1.x = var_53_1.x + (arg_53_1.dirPos.x + arg_53_1.dirPos.y) * 0.5 + (arg_53_1.dirPos.x + arg_53_1.dirPos.y + 1) * 0
	else
		assert(false)
	end

	local var_53_2 = arg_53_0.moveFuShun.realPos - arg_53_1.pos

	return math.clamp((arg_53_0.moveFuShun.realPos - arg_53_1.pos).x, var_53_0.x, var_53_1.x) == (arg_53_0.moveFuShun.realPos - arg_53_1.pos).x and math.clamp(var_53_2.y, var_53_0.y, var_53_1.y) == var_53_2.y
end

function var_0_0.EnemyAttack(arg_54_0, arg_54_1)
	if arg_54_0:AttackCheck(arg_54_1) then
		arg_54_0.moveFuShun:EnemyHit(arg_54_1.pos)
	end

	return
end

function var_0_0.GetDecoyPos(arg_55_0, arg_55_1, arg_55_2)
	for iter_55_0 = -NenjuuGameConfig.DECOY_RANGE, NenjuuGameConfig.DECOY_RANGE do
		for iter_55_1 = -NenjuuGameConfig.DECOY_RANGE, NenjuuGameConfig.DECOY_RANGE do
			local var_55_0 = arg_55_1 + NewPos(iter_55_0, iter_55_1)

			if arg_55_0:Moveable(var_55_0) then
				table.insert({}, var_55_0)
			end
		end
	end

	return ({})[math.random(#{})]
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
	local var_57_1 = arg_57_0.moveFuShun.pos + arg_57_0.moveFuShun:GetDirPos()

	if arg_57_2 and arg_57_0:InRange(var_57_1) then
		table.insert(var_57_0, var_57_1)
	else
		table.insert(var_57_0, arg_57_0.moveFuShun.pos)
	end

	local var_57_2 = {
		[tostring(var_57_0[1])] = {
			value = 0,
			pos = var_57_0[1]
		}
	}
	local var_57_3 = 0

	while var_57_3 < #var_57_0 do
		var_57_3 = var_57_3 + 1

		local var_57_4 = var_57_2[tostring(var_57_0[var_57_3])].value + 1

		for iter_57_0, iter_57_1 in ipairs(var_0_4) do
			local var_57_5 = var_57_0[var_57_3] + NewPos(unpack(iter_57_1))

			if var_57_5 == arg_57_1 or arg_57_0:Moveable(var_57_5, not arg_57_2) then
				local var_57_6 = tostring(var_57_5)

				if not var_57_2[var_57_6] then
					var_57_2[var_57_6] = {
						pos = var_57_5,
						value = var_57_4,
						last = var_57_0[var_57_3]
					}

					table.insert(var_57_0, var_57_5)
				elseif var_57_4 < var_57_2[var_57_6].value then
					var_57_2[var_57_6].value = var_57_4
					var_57_2[var_57_6].last = var_57_0[var_57_3]
				end
			end
		end
	end

	if arg_57_0.moveFuShun.inLantern then
		for iter_57_2 = -NenjuuGameConfig.LANTERN_RANGE, NenjuuGameConfig.LANTERN_RANGE do
			for iter_57_3 = -NenjuuGameConfig.LANTERN_RANGE, NenjuuGameConfig.LANTERN_RANGE do
				local var_57_7 = var_57_2[tostring(arg_57_0.moveFuShun.pos + NewPos(iter_57_2, iter_57_3))]

				if var_57_7 then
					var_57_7.lightValue = 1000 - var_57_7.value
				end
			end
		end
	end

	arg_57_0.wayfindCache[arg_57_2] = {
		pos = arg_57_0.moveFuShun.pos,
		inLantern = arg_57_0.moveFuShun.inLantern,
		basePos = arg_57_1,
		map = var_57_2
	}

	return var_57_2
end

function var_0_0.GetTeleportTargetPos(arg_58_0, arg_58_1, arg_58_2)
	local var_58_1 = math.random(4)

	for iter_58_0, iter_58_1 in pairs(arg_58_1) do
		table.insert({}, {
			pos = iter_58_1.pos,
			value = iter_58_1.value,
			mDis = math.abs((iter_58_1.pos - arg_58_2).x) + math.abs((iter_58_1.pos - arg_58_2).y)
		})
	end

	table.sort({}, CompareFuncs({
		function(arg_59_0)
			return math.abs(arg_59_0.value - var_58_1)
		end,
		function(arg_60_0)
			return arg_60_0.mDis
		end
	}))

	return ({})[1].pos
end

function var_0_0.StealthCheck(arg_61_0, arg_61_1)
	return math.abs((arg_61_0.moveFuShun.pos - arg_61_1).x) + math.abs((arg_61_0.moveFuShun.pos - arg_61_1).y) < 10
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
	return arg_63_0.moveNenjuu:CheckAbility(arg_63_1)
end

function var_0_0.BuildBlackHole(arg_64_0)
	for iter_64_0 = 1, arg_64_0.mapSize.x do
		for iter_64_1 = 1, arg_64_0.mapSize.y do
			local var_64_0 = NewPos(iter_64_0 - 1, iter_64_1 - 1)

			if arg_64_0:Moveable(var_64_0, true) then
				table.insert({}, var_64_0)
			end
		end
	end

	arg_64_0:CreateTarget({
		time = 20,
		name = "BlackHole",
		pos = ({})[math.random(#{})]
	})

	return
end

function var_0_0.InBlackHoleRange(arg_65_0, arg_65_1, arg_65_2)
	if arg_65_2 then
		local var_65_0 = arg_65_0:InRange(arg_65_1) and underscore.detect(arg_65_0.map[tostring(arg_65_1)], function(arg_66_0)
			return arg_66_0.class == NenjuuGameNameSpace.TargetBlackHole
		end)

		if var_65_0 and not var_65_0.isLost then
			var_65_0:BeTrigger()

			return true
		else
			return false
		end
	else
		local var_65_1 = NenjuuGameConfig.BLACK_HOLE_RANGE

		for iter_65_0 = -NenjuuGameConfig.BLACK_HOLE_RANGE, NenjuuGameConfig.BLACK_HOLE_RANGE do
			for iter_65_1 = -var_65_1, var_65_1 do
				local var_65_2 = arg_65_1 + NewPos(iter_65_0, iter_65_1)

				if arg_65_0:InRange(var_65_2) and underscore.any(arg_65_0.map[tostring(var_65_2)], function(arg_67_0)
					return arg_67_0.class == NenjuuGameNameSpace.TargetBlackHole
				end) then
					return true
				end
			end
		end
	end

	return
end

function var_0_0.BuildDoppelgangers(arg_68_0, arg_68_1)
	for iter_68_0 = -2, 2 do
		for iter_68_1 = -2, 2 do
			local var_68_0 = arg_68_1 + NewPos(iter_68_0, iter_68_1)

			if arg_68_0:Moveable(var_68_0) then
				arg_68_0.moveDoppel = arg_68_0:CreateTarget({
					name = "Nenjuu_Doppelgangers",
					isDoppel = true,
					pos = var_68_0,
					abilitys = {}
				})

				return
			end
		end
	end

	return
end

function var_0_0.EatItem(arg_69_0, arg_69_1)
	for iter_69_0, iter_69_1 in ipairs(arg_69_0.map[tostring(arg_69_1)]) do
		if iter_69_1.class == NenjuuGameNameSpace.TargetItem then
			arg_69_0:DestoryTarget(iter_69_1)

			arg_69_0.itemCount = arg_69_0.itemCount - 1
			arg_69_0.point = arg_69_0.point + iter_69_1.point * arg_69_0.pointRate

			setText(arg_69_0.textPoint, arg_69_0.point)
			arg_69_0.moveFuShun:PopPoint(iter_69_1.point * arg_69_0.pointRate)

			if arg_69_0.itemCount == 0 then
				arg_69_0:CheckWave()
			end
		end
	end

	return
end

return var_0_0
