local NenjuuGameController = class("NenjuuGameController")

function NenjuuGameController:Ctor(arg_1_1, arg_1_2)
	self.binder = arg_1_1

	self:InitTimer()
	self:InitGameUI(arg_1_2)

	return
end

local function var_0_1(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs((arg_2_0:GetComponentsInChildren(typeof(Animator), true):ToTable())) do
		iter_2_1.speed = arg_2_1
	end

	return
end

function NenjuuGameController:InitTimer()
	self.timer = Timer.New(function()
		self:OnTimer(NenjuuGameConfig.TIME_INTERVAL)

		return
	end, NenjuuGameConfig.TIME_INTERVAL, -1)
	self.handle = self.handle or UpdateBeat:CreateListener(self.Update, self)

	UpdateBeat:AddListener(self.handle)

	return
end

function NenjuuGameController:InitGameUI(arg_5_1)
	self.rtViewport = arg_5_1:Find("Viewport")
	self.rtMainContent = self.rtViewport:Find("MainContent")
	self.rtResource = arg_5_1:Find("Resource")
	self.rtJoyStick = arg_5_1:Find("Controller/bottom/joy_stick")

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
		local var_5_1 = self.rtJoyStick:Find(iter_5_1):GetComponent(typeof(EventTriggerListener))

		var_5_1:AddPointDownFunc(function()
			self.cacheInput = var_5_0[iter_5_0]

			return
		end)
		var_5_1:AddPointEnterFunc(function()
			if self.cacheInput and self.cacheInput ~= var_5_0[iter_5_0] then
				self.cacheInput = var_5_0[iter_5_0]
			end

			return
		end)
		var_5_1:AddPointUpFunc(function()
			if self.cacheInput then
				self.cacheInput = nil
			end

			return
		end)
	end

	self.inPress = {}
	self.rtSkillButton = arg_5_1:Find("Controller/bottom/skill_button")

	for iter_5_2 = 0, 3 do
		local var_5_2 = "Skill_" .. iter_5_2
		local var_5_3 = self.rtSkillButton:Find("Skill_" .. iter_5_2):GetComponent(typeof(EventTriggerListener))

		var_5_3:AddPointDownFunc(function()
			self.inPress[var_5_2] = true

			return
		end)
		var_5_3:AddPointUpFunc(function()
			self.inPress[var_5_2] = false

			return
		end)
	end

	self.textTime = arg_5_1:Find("Controller/top/panel/time/Text")
	self.textPoint = arg_5_1:Find("Controller/top/panel/point/Text")
	self.rtCollection = arg_5_1:Find("Controller/top/target")

	return
end

function NenjuuGameController:Update()
	self:AddDebugInput()

	return
end

function NenjuuGameController:AddDebugInput()
	if IsUnityEditor then
		local var_12_0 = {
			"E",
			"S",
			"W",
			"N"
		}

		for iter_12_0, iter_12_1 in ipairs({
			"D",
			"S",
			"A",
			"W"
		}) do
			if Input.GetKeyDown(KeyCode[iter_12_1]) then
				self.cacheInput = var_12_0[iter_12_0]
			end

			if Input.GetKeyUp(KeyCode[iter_12_1]) and self.cacheInput == var_12_0[iter_12_0] then
				self.cacheInput = nil
			end
		end
	end

	return
end

function NenjuuGameController:InitMapConfig(arg_13_1)
	self.pointRate = arg_13_1.rate
	self.config = NenjuuGameConfig.GetStageConfig("Spring23Level_" .. arg_13_1.index)

	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs(pg.MiniGameTileMgr.GetInstance():getDataLayers("Spring23Game", "Spring23Level_" .. arg_13_1.index)) do
		var_13_0[iter_13_1.name] = iter_13_1
	end

	self.timeCount = self.config.extra_time[1]
	self.point = 0

	setText(self.textTime, string.format("%02d:%02ds", math.floor(self.timeCount / 60), math.floor(self.timeCount % 60)))
	setText(self.textPoint, self.point)
	eachChild(self.rtCollection, function(arg_14_0)
		setActive(arg_14_0, false)

		return
	end)

	self.mapSize = NewPos(var_13_0.floor.width, var_13_0.floor.height)

	setSizeDelta(self.rtMainContent, self.mapSize * 32)

	self.buffer = NewPos(math.max(self.rtMainContent.rect.width + 192 - self.rtViewport.rect.width, 0), math.max(self.rtMainContent.rect.height + 160 - self.rtViewport.rect.height, 0)) * 0.5

	for iter_13_2, iter_13_3 in ipairs(var_13_0.floor.layer) do
		self.plane[tostring((NewPos((iter_13_3.index - 1) % self.mapSize.x, math.floor((iter_13_3.index - 1) / self.mapSize.x))))] = iter_13_3.item
	end

	local var_13_1 = {
		["0_-1"] = 3,
		["1_1"] = 5,
		["-1_0"] = 2,
		["1_0"] = 0,
		["0_1"] = 1,
		["1_-1"] = 4,
		["-1_-1"] = 7,
		["-1_1"] = 6
	}

	for iter_13_4 = 0, self.mapSize.y - 1 do
		for iter_13_5 = 0, self.mapSize.x - 1 do
			local var_13_2 = self.plane[iter_13_5 .. "_" .. iter_13_4] or "Snow"
			local var_13_3 = self.rtResource:Find("plane/" .. var_13_2)

			if not var_13_3 then
				var_13_3 = cloneTplTo(self.rtResource:Find("plane/Road"), self.rtMainContent:Find("plane"))

				setImageSprite(var_13_3:Find("scale/Image"), getImageSprite(self.rtResource:Find("plane_sprite/" .. var_13_2)))
			else
				var_13_3 = cloneTplTo(var_13_3, self.rtMainContent:Find("plane"))
			end

			if var_13_3:Find("scale/Snow") then
				local function var_13_4(arg_15_0, arg_15_1)
					return not self:InRange(NewPos(arg_15_0, arg_15_1)) or not self.plane[arg_15_0 .. "_" .. arg_15_1] or self.plane[arg_15_0 .. "_" .. arg_15_1] == "Snow"
				end

				for iter_13_6 = -1, 1 do
					for iter_13_7 = -1, 1 do
						if var_13_4(iter_13_5 + iter_13_6, iter_13_4 + iter_13_7) and (iter_13_6 == 0 or iter_13_7 == 0 or not var_13_4(iter_13_5, iter_13_4 + iter_13_7) and not var_13_4(iter_13_5 + iter_13_6, iter_13_4)) then
							setActive(var_13_3:Find("scale/Snow/" .. var_13_1[iter_13_6 .. "_" .. iter_13_7]), true)
						end
					end
				end
			end
		end
	end

	for iter_13_8, iter_13_9 in ipairs(var_13_0.item.layer) do
		local var_13_5 = self:CreateTarget({
			name = iter_13_9.item,
			pos = NewPos((iter_13_9.index - 1) % self.mapSize.x, math.floor((iter_13_9.index - 1) / self.mapSize.x))
		})
	end

	for iter_13_10, iter_13_11 in ipairs(var_13_0.character.layer) do
		local var_13_6 = {
			name = iter_13_11.item,
			pos = NewPos((iter_13_11.index - 1) % self.mapSize.x, math.floor((iter_13_11.index - 1) / self.mapSize.x))
		}

		switch(var_13_6.name, {
			FuShun = function()
				var_13_6.level = arg_13_1.FuShun.level
				var_13_6.itemType = arg_13_1.FuShun.item
				self.moveFuShun = self:CreateTarget(var_13_6)

				return
			end,
			Nenjuu = function()
				var_13_6.abilitys = arg_13_1.Nenjuu
				self.moveNenjuu = self:CreateTarget(var_13_6)

				return
			end
		})
	end

	self.wave = 0
	self.itemCount = 0

	return
end

function NenjuuGameController:CheckWave()
	if self.itemCount > 0 then
		return
	end

	if self.wave < #self.config.wave then
		self.wave = self.wave + 1

		local var_18_0, var_18_1, var_18_2 = unpack(self.config.wave[self.wave])

		self.itemType = var_18_0
		self.itemCount = var_18_1

		local var_18_3 = {}

		for iter_18_0 = 0, self.mapSize.x - 1 do
			for iter_18_1 = 0, self.mapSize.y - 1 do
				local var_18_4 = NewPos(iter_18_0, iter_18_1)

				if self:Moveable(var_18_4, true) and not self.hideMap[tostring(var_18_4)] then
					table.insert(var_18_3, var_18_4)
				end
			end
		end

		for iter_18_2 = 1, self.itemCount do
			local var_18_5

			repeat
				var_18_5 = math.random(#var_18_3)

				local var_18_6 = 0

				for iter_18_3 = -1, 1 do
					for iter_18_4 = -1, 1 do
						local var_18_7 = var_18_3[var_18_5] + NewPos(iter_18_3, iter_18_4)

						if self:InRange(var_18_7) and underscore.any(self.map[tostring(var_18_7)], function(arg_19_0)
							return arg_19_0.class == NenjuuGameNameSpace.TargetItem
						end) then
							var_18_6 = var_18_6 + 1
						end
					end
				end
			until var_18_6 < 7

			self:CreateTarget({
				name = var_18_0,
				pos = table.remove(var_18_3, var_18_5),
				point = var_18_2
			})
		end

		eachChild(self.rtCollection, function(arg_20_0)
			setActive(arg_20_0, arg_20_0.name == self.itemType)

			return
		end)
	else
		self.point = self.point + self.config.extra_time[2] * self.pointRate

		setText(self.textPoint, self.point)
		self:EndGame(true)
	end

	return
end

function NenjuuGameController:InRange(arg_21_1)
	return arg_21_1.x >= 0 and arg_21_1.x < self.mapSize.x and arg_21_1.y >= 0 and arg_21_1.y < self.mapSize.y
end

function NenjuuGameController:Moveable(arg_22_1, arg_22_2, arg_22_3)
	if not self:InRange(arg_22_1) then
		return false
	else
		return underscore.all(self.map[tostring(arg_22_1)], function(arg_23_0)
			local var_23_0 = arg_23_0:Moveable()

			if not var_23_0 then
				if arg_22_2 then
					var_23_0 = arg_23_0:BreakMoveable() or arg_22_3 and isa(arg_23_0, NenjuuGameNameSpace.TargetMove)
				end
			end

			return var_23_0
		end)
	end

	return
end

function NenjuuGameController:CreateTarget(arg_24_1)
	local var_24_0, var_24_1, var_24_2 = NenjuuGameConfig.GetCreateConfig(arg_24_1)

	if not var_24_0 then
		return
	end

	local var_24_4 = var_24_0.New(self, arg_24_1.parent and cloneTplTo(self.rtResource:Find(var_24_1), arg_24_1.parent) or cloneTplTo(self.rtResource:Find(var_24_1), self.rtMainContent:Find(var_24_2)), arg_24_1)

	if var_24_4:InTimeLine() then
		table.insert(self.timeFlow, var_24_4)
	end

	return var_24_4
end

function NenjuuGameController:DestoryTarget(arg_25_1)
	self.dirtyMap = true

	table.removebyvalue(self.map[tostring(arg_25_1.pos)], arg_25_1)

	if arg_25_1:InTimeLine() then
		table.removebyvalue(self.timeFlow, arg_25_1)
	end

	Destroy(arg_25_1._tf)

	arg_25_1 = nil

	return
end

function NenjuuGameController:ResetGame()
	for iter_26_0, iter_26_1 in ipairs({
		"plane",
		"object",
		"effect",
		"character"
	}) do
		eachChild(self.rtMainContent:Find(iter_26_1), function(arg_27_0)
			Destroy(arg_27_0)

			return
		end)
	end

	self.map = setmetatable({}, {
		__index = function(self, arg_28_1)
			self[arg_28_1] = {}

			return self[arg_28_1]
		end
	})
	self.hideMap = {}
	self.plane = {}
	self.cacheInput = nil
	self.timeQueue = {}
	self.timeFlow = {}
	self.moveFuShun = nil
	self.moveNenjuu = nil
	self.moveDoppel = nil
	self.wayfindCache = {}

	return
end

function NenjuuGameController:ReadyGame(arg_29_1)
	self:InitMapConfig(arg_29_1)
	self:UpdateSkillButtons()
	self:PauseGame()

	return
end

function NenjuuGameController:StartGame()
	self.isStart = true

	self:CheckWave()
	self:ResumeGame()

	return
end

function NenjuuGameController:EndGame(arg_31_1)
	self.isStart = false

	self:PauseGame()
	self.binder:openUI("result")

	return
end

function NenjuuGameController:ResumeGame()
	self.isPause = false

	self.timer:Start()
	var_0_1(self.rtMainContent, 1)

	return
end

function NenjuuGameController:PauseGame()
	self.isPause = true

	self.timer:Stop()
	var_0_1(self.rtMainContent, 0)

	return
end

function NenjuuGameController:OnTimer(arg_34_1)
	self.timeCount = self.timeCount - arg_34_1

	setText(self.textTime, string.format("%02d:%02ds", math.floor(self.timeCount / 60), math.floor(self.timeCount % 60)))

	if self.timeCount <= 0 then
		self:EndGame()

		return
	end

	for iter_34_0, iter_34_1 in ipairs(self.timeFlow) do
		iter_34_1:OnTimerUpdate(arg_34_1)
	end

	for iter_34_2, iter_34_3 in ipairs(self.timeQueue) do
		iter_34_3.time = iter_34_3.time - arg_34_1
	end

	table.sort(self.timeQueue, CompareFuncs({
		function(arg_35_0)
			return -arg_35_0.time
		end
	}))

	while #self.timeQueue > 0 and self.timeQueue[#self.timeQueue].time <= 0 do
		table.remove(self.timeQueue).func()
	end

	self:UpdateSkillButtons()

	return
end

function NenjuuGameController:UpdateSkillButtons()
	for iter_36_0, iter_36_1 in ipairs(self.moveFuShun:CalcSkillCDs()) do
		local var_36_0 = self.rtSkillButton:Find("Skill_" .. iter_36_0 - 1)

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

function NenjuuGameController:GetCacheInput(arg_38_1)
	if arg_38_1 then
		self.cacheInput = nil

		return self.cacheInput
	else
		return self.cacheInput
	end

	return
end

function NenjuuGameController:GetPressInput(arg_39_1)
	return self.inPress[arg_39_1]
end

function NenjuuGameController:UpdateTargetPos(arg_40_1, arg_40_2, arg_40_3)
	self.dirtyMap = true

	local var_40_0 = arg_40_1:GetSize()

	for iter_40_0 = 0, var_40_0.x - 1 do
		for iter_40_1 = 0, var_40_0.y - 1 do
			local var_40_1 = NewPos(iter_40_0, iter_40_1)

			if arg_40_2 then
				table.removebyvalue(self.map[tostring(arg_40_2 + var_40_1)], arg_40_1)
			end

			table.insert(self.map[tostring(arg_40_3 + var_40_1)], arg_40_1)
		end
	end

	if arg_40_1.canHide then
		for iter_40_2 = 0, var_40_0.x - 1 do
			local var_40_2 = arg_40_3 + NewPos(iter_40_2, -1)

			if self:InRange(var_40_2) then
				self.hideMap[tostring(var_40_2)] = true
			end
		end
	end

	return
end

function NenjuuGameController:WindowFocrus(arg_41_1)
	setAnchoredPosition(self.rtMainContent, {
		x = math.clamp(-arg_41_1.x, -self.buffer.x, self.buffer.x),
		y = math.clamp(-arg_41_1.y, -self.buffer.y - 16, self.buffer.y - 16)
	})

	return
end

function NenjuuGameController:CheckIce(arg_42_1)
	if not self:InRange(arg_42_1) then
		return false
	else
		return underscore.detect(self.map[tostring(arg_42_1)], function(arg_43_0)
			return arg_43_0.class == NenjuuGameNameSpace.TargetIce
		end)
	end

	return
end

function NenjuuGameController:BuildIce(arg_44_1)
	local function var_44_1()
		arg_44_1.pos = arg_44_1.pos + arg_44_1.dirPos

		if self:Moveable(arg_44_1.pos) then
			self:CreateTarget({
				create = true,
				name = "Ice",
				pos = arg_44_1.pos
			})

			arg_44_1.power = arg_44_1.power - 1

			if arg_44_1.power > 0 then
				table.insert(self.timeQueue, {
					time = 0.035,
					func = var_44_1
				})
			end
		end

		return
	end

	local var_44_2 = {
		time = 0
	}

	var_44_2.func = nil

	table.insert(self.timeQueue, var_44_2)

	return
end

function NenjuuGameController:BreakIce(arg_46_1)
	arg_46_1.power = arg_46_1.power or math.max(self.mapSize.x, self.mapSize.y)

	local function var_46_1()
		arg_46_1.pos = arg_46_1.pos + arg_46_1.dirPos

		if self:OnlyBreakIce(arg_46_1.pos) then
			self:CreateTarget({
				name = "EF_Break_" .. arg_46_1.dir,
				pos = arg_46_1.pos
			})

			arg_46_1.power = arg_46_1.power - 1

			if arg_46_1.power > 0 then
				table.insert(self.timeQueue, {
					time = 0.035,
					func = var_46_1
				})
			end
		end

		return
	end

	local var_46_2 = {
		time = 0
	}

	var_46_2.func = nil

	table.insert(self.timeQueue, var_46_2)

	return
end

function NenjuuGameController:OnlyBreakIce(arg_48_1)
	local var_48_0 = self:CheckIce(arg_48_1)

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

function NenjuuGameController:BuildBomb(arg_49_1)
	local var_49_0 = 0

	for iter_49_0 = 1, 2 do
		for iter_49_1 = 1, 4 do
			for iter_49_2 = -iter_49_0, iter_49_0 - 1 do
				var_49_0 = var_49_0 + 1

				local var_49_1 = {
					iter_49_0,
					iter_49_2
				}
				local var_49_2 = arg_49_1.pos + NewPos(var_0_2[(var_0_3[arg_49_1.dir] + iter_49_1 + 2) % 4 + 1][1] * var_49_1[iter_49_1 % 2 + 1], var_0_2[(var_0_3[arg_49_1.dir] + iter_49_1 + 2) % 4 + 1][2] * var_49_1[(iter_49_1 + 1) % 2 + 1])

				if self:Moveable(var_49_2, false, true) then
					table.insert(self.timeQueue, {
						time = (var_49_0 - 1) * 0.015,
						func = function()
							self:CreateTarget({
								name = "Bomb",
								pos = var_49_2
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

function NenjuuGameController:CheckMelt(arg_51_1)
	return string.split(self.plane[tostring(arg_51_1)], "_")[2] == "warm"
end

function NenjuuGameController:ScareEnemy(arg_52_1)
	for iter_52_0, iter_52_1 in ipairs({
		self.moveNenjuu,
		self.moveDoppel
	}) do
		if math.abs((arg_52_1.pos - iter_52_1.realPos).x) + math.abs((arg_52_1.pos - iter_52_1.realPos).y) <= arg_52_1.range then
			iter_52_1:BeScare()
		end
	end

	return
end

function NenjuuGameController:AttackCheck(arg_53_1)
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

	local var_53_2 = self.moveFuShun.realPos - arg_53_1.pos

	return math.clamp((self.moveFuShun.realPos - arg_53_1.pos).x, var_53_0.x, var_53_1.x) == (self.moveFuShun.realPos - arg_53_1.pos).x and math.clamp(var_53_2.y, var_53_0.y, var_53_1.y) == var_53_2.y
end

function NenjuuGameController:EnemyAttack(arg_54_1)
	if self:AttackCheck(arg_54_1) then
		self.moveFuShun:EnemyHit(arg_54_1.pos)
	end

	return
end

function NenjuuGameController:GetDecoyPos(arg_55_1, arg_55_2)
	local var_55_0 = {}

	for iter_55_0 = -NenjuuGameConfig.DECOY_RANGE, NenjuuGameConfig.DECOY_RANGE do
		for iter_55_1 = -NenjuuGameConfig.DECOY_RANGE, NenjuuGameConfig.DECOY_RANGE do
			local var_55_1 = arg_55_1 + NewPos(iter_55_0, iter_55_1)

			if self:Moveable(var_55_1) then
				table.insert(var_55_0, var_55_1)
			end
		end
	end

	return var_55_0[math.random(#var_55_0)]
end

function NenjuuGameController:BuildDecoy(arg_56_1)
	self:CreateTarget({
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

function NenjuuGameController:GetWayfindingMap(arg_57_1, arg_57_2)
	if not self.dirtyMap and self.wayfindCache[arg_57_2] and (self.wayfindCache[arg_57_2].inLantern and self.wayfindCache[arg_57_2].inLantern > 0 or false) == (self.moveFuShun.inLantern and self.moveFuShun.inLantern > 0 or false) and self.wayfindCache[arg_57_2].pos == self.moveFuShun.pos and self.wayfindCache[arg_57_2].basePos == arg_57_1 then
		return self.wayfindCache[arg_57_2].map
	end

	self.dirtyMap = false

	local var_57_0 = {}
	local var_57_1 = self.moveFuShun.pos + self.moveFuShun:GetDirPos()

	if arg_57_2 and self:InRange(var_57_1) then
		table.insert(var_57_0, var_57_1)
	else
		table.insert(var_57_0, self.moveFuShun.pos)
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

			if var_57_5 == arg_57_1 or self:Moveable(var_57_5, not arg_57_2) then
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

	if self.moveFuShun.inLantern then
		for iter_57_2 = -NenjuuGameConfig.LANTERN_RANGE, NenjuuGameConfig.LANTERN_RANGE do
			for iter_57_3 = -NenjuuGameConfig.LANTERN_RANGE, NenjuuGameConfig.LANTERN_RANGE do
				local var_57_7 = var_57_2[tostring(self.moveFuShun.pos + NewPos(iter_57_2, iter_57_3))]

				if var_57_7 then
					var_57_7.lightValue = 1000 - var_57_7.value
				end
			end
		end
	end

	self.wayfindCache[arg_57_2] = {
		pos = self.moveFuShun.pos,
		inLantern = self.moveFuShun.inLantern,
		basePos = arg_57_1,
		map = var_57_2
	}

	return var_57_2
end

function NenjuuGameController:GetTeleportTargetPos(arg_58_1, arg_58_2)
	local var_58_1 = math.random(4)
	local var_58_2 = {}

	for iter_58_0, iter_58_1 in pairs(arg_58_1) do
		table.insert(var_58_2, {
			pos = iter_58_1.pos,
			value = iter_58_1.value,
			mDis = math.abs((iter_58_1.pos - arg_58_2).x) + math.abs((iter_58_1.pos - arg_58_2).y)
		})
	end

	table.sort(var_58_2, CompareFuncs({
		function(arg_59_0)
			return math.abs(arg_59_0.value - var_58_1)
		end,
		function(arg_60_0)
			return arg_60_0.mDis
		end
	}))

	return var_58_2[1].pos
end

function NenjuuGameController:StealthCheck(arg_61_1)
	return math.abs((self.moveFuShun.pos - arg_61_1).x) + math.abs((self.moveFuShun.pos - arg_61_1).y) < 10
end

function NenjuuGameController:BuildTeleportSign(arg_62_1)
	self:CreateTarget({
		name = "SignWarp",
		pos = arg_62_1.pos,
		time = arg_62_1.time
	})

	return
end

function NenjuuGameController:GetEnemyEffect(arg_63_1)
	return self.moveNenjuu:CheckAbility(arg_63_1)
end

function NenjuuGameController:BuildBlackHole()
	local var_64_0 = {}

	for iter_64_0 = 1, self.mapSize.x do
		for iter_64_1 = 1, self.mapSize.y do
			local var_64_1 = NewPos(iter_64_0 - 1, iter_64_1 - 1)

			if self:Moveable(var_64_1, true) then
				table.insert(var_64_0, var_64_1)
			end
		end
	end

	self:CreateTarget({
		time = 20,
		name = "BlackHole",
		pos = var_64_0[math.random(#var_64_0)]
	})

	return
end

function NenjuuGameController:InBlackHoleRange(arg_65_1, arg_65_2)
	if arg_65_2 then
		local var_65_0 = self:InRange(arg_65_1) and underscore.detect(self.map[tostring(arg_65_1)], function(arg_66_0)
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

				if self:InRange(var_65_2) and underscore.any(self.map[tostring(var_65_2)], function(arg_67_0)
					return arg_67_0.class == NenjuuGameNameSpace.TargetBlackHole
				end) then
					return true
				end
			end
		end
	end

	return
end

function NenjuuGameController:BuildDoppelgangers(arg_68_1)
	for iter_68_0 = -2, 2 do
		for iter_68_1 = -2, 2 do
			local var_68_0 = arg_68_1 + NewPos(iter_68_0, iter_68_1)

			if self:Moveable(var_68_0) then
				self.moveDoppel = self:CreateTarget({
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

function NenjuuGameController:EatItem(arg_69_1)
	for iter_69_0, iter_69_1 in ipairs(self.map[tostring(arg_69_1)]) do
		if iter_69_1.class == NenjuuGameNameSpace.TargetItem then
			self:DestoryTarget(iter_69_1)

			self.itemCount = self.itemCount - 1
			self.point = self.point + iter_69_1.point * self.pointRate

			setText(self.textPoint, self.point)
			self.moveFuShun:PopPoint(iter_69_1.point * self.pointRate)

			if self.itemCount == 0 then
				self:CheckWave()
			end
		end
	end

	return
end

return NenjuuGameController
