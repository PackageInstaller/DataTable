local GuildDynamicBG = class("GuildDynamicBG")
local var_0_1 = false
local var_0_2 = false
local GuildDynamicBGConfig = require("view.guild.views.DynamicBG.GuildDynamicBGConfig")

function GuildDynamicBG:Ctor(arg_1_1)
	self.mainScrollrect = arg_1_1:Find("scrollrect")
	self.assistScrollrect = arg_1_1:Find("scrollrect1")
	self.pathContainer = arg_1_1:Find("scrollrect/content/path")
	self.nameTF = arg_1_1:Find("name")
	self.commanderTag = arg_1_1:Find("commander_tag")
	self.path = {}
	self.ships = {}
	self.furnitures = {}

	onScroll(nil, self.mainScrollrect, function(arg_2_0)
		scrollTo(self.assistScrollrect, arg_2_0.x / 2, arg_2_0.y)

		return
	end)

	return
end

function GuildDynamicBG:Init(arg_3_1)
	self.shipVOs = arg_3_1 or {}

	seriesAsync({
		function(arg_4_0)
			self:InitPath()
			arg_4_0()

			return
		end,
		function(arg_5_0)
			self:InitFurnitures(arg_5_0)

			return
		end,
		function(arg_6_0)
			if var_0_2 then
				self:AddDebugShip(arg_6_0)
			else
				self:InitShips(arg_6_0)
			end

			return
		end
	}, function()
		if var_0_1 then
			self:AddGridDebugView()
		end

		self:SortScene()

		return
	end)

	return
end

function GuildDynamicBG:InitPath()
	local var_8_0 = Vector2(GuildDynamicBGConfig.gridSize[1], GuildDynamicBGConfig.gridSize[2])
	local var_8_1 = Vector2(GuildDynamicBGConfig.gridStartPos[1], GuildDynamicBGConfig.gridStartPos[2])

	for iter_8_0 = 0, GuildDynamicBGConfig.gridCnt[1] - 1 do
		self.path[iter_8_0] = {}

		for iter_8_1 = 0, GuildDynamicBGConfig.gridCnt[2] - 1 do
			self.path[iter_8_0][iter_8_1] = GuildDynamicBgPathGrid.New({
				position = Vector2(iter_8_0, iter_8_1),
				canWalk = not _.any(GuildDynamicBGConfig.cantWalkPos, function(arg_9_0)
					return arg_9_0[1] == iter_8_0 and arg_9_0[2] == iter_8_1
				end),
				sizeDelta = var_8_0,
				startPosOffset = var_8_1
			})
		end
	end

	return
end

function GuildDynamicBG:GetRandomGrid()
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs(self.path) do
		for iter_10_2, iter_10_3 in pairs(iter_10_1) do
			if iter_10_3:CanWalk() then
				table.insert(var_10_0, iter_10_3)
			end
		end
	end

	return var_10_0[math.random(1, #var_10_0)]
end

function GuildDynamicBG:GetGrid(arg_11_1, arg_11_2)
	return self.path[arg_11_1][arg_11_2]
end

function GuildDynamicBG:InitFurnitures(arg_12_1)
	local function var_12_0(arg_13_0, arg_13_1, arg_13_2)
		GetOrAddComponent(arg_13_1, typeof(RectTransform)).pivot = Vector2(0, 0)

		local var_13_0 = self:GetGrid(arg_13_0.position[1], arg_13_0.position[2])

		assert(var_13_0)
		table.insert(self.furnitures, (GuildDynamicFurniture.New({
			go = arg_13_1,
			grid = var_13_0,
			path = self.path,
			size = Vector2(arg_13_0.size[1], arg_13_0.size[2]),
			offset = Vector2(arg_13_0.offset[1], arg_13_0.offset[2]),
			mode = arg_13_0.mode,
			interactionPosition = Vector2(arg_13_0.interactionPosition[1], arg_13_0.interactionPosition[2]),
			interactionDir = arg_13_0.interactionDir
		})))
		arg_13_2()

		return
	end

	local var_12_1 = {}

	for iter_12_0, iter_12_1 in ipairs(GuildDynamicBGConfig.furnitures) do
		table.insert(var_12_1, function(arg_14_0)
			ResourceMgr.Inst:getAssetAsync("furnitrues/guild/" .. iter_12_1.name, "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_15_0)
				var_12_0(iter_12_1, Object.Instantiate(arg_15_0, self.pathContainer), arg_14_0)

				return
			end), true, true)

			return
		end)
	end

	seriesAsync(var_12_1, arg_12_1)

	return
end

function GuildDynamicBG:InitShips(arg_16_1)
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in ipairs(self.shipVOs) do
		table.insert(var_16_0, function(arg_17_0)
			self:AddShip(iter_16_1, arg_17_0)

			return
		end)
	end

	seriesAsync(var_16_0, arg_16_1)

	return
end

function GuildDynamicBG:AddShip(arg_18_1, arg_18_2)
	local function var_18_0(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
		arg_19_2:SetParent(self.pathContainer)
		arg_19_2:SetLocalScale(Vector3(0.5, 0.5, 1))

		local var_19_0 = GuildDynamicBgShip.New({
			stand = arg_19_0.stand,
			auto = arg_19_0.auto,
			go = arg_19_2:GetModel(),
			grid = arg_19_1,
			path = self.path,
			furnitures = self.furnitures,
			name = arg_19_0.name,
			isCommander = arg_19_0.isCommander,
			char = arg_19_2
		})

		var_19_0:SetOnMoveCallBack(function()
			self:SortScene()

			return
		end)
		table.insert(self.ships, var_19_0)
		arg_19_3()

		return
	end

	local var_18_1 = arg_18_1:getPrefab()
	local var_18_2 = self:GetRandomGrid()

	if not var_18_2 then
		arg_18_2()
	end

	var_18_2:Lock()

	local var_18_3 = SpineAnimChar.New()

	var_18_3:SetPaint(var_18_1)
	var_18_3:Load(true, function(arg_21_0)
		if IsNil(self.nameTF) then
			arg_21_0:Dispose()

			return
		end

		local var_21_0 = arg_21_0:GetModel()

		var_21_0.name = var_18_1

		cloneTplTo(self.nameTF, var_21_0.transform, "name")

		if arg_18_1.isCommander then
			cloneTplTo(self.commanderTag, var_21_0.transform, "tag")
		end

		var_18_0(arg_18_1, var_18_2, arg_21_0, arg_18_2)

		return
	end)

	return
end

function GuildDynamicBG:ExitShip(arg_22_1)
	for iter_22_0, iter_22_1 in pairs(self.ships) do
		if iter_22_1.name == arg_22_1 then
			iter_22_1:Dispose()

			self.ships[iter_22_0] = nil

			break
		end
	end

	return
end

function GuildDynamicBG:SortScene()
	local var_23_0 = {}

	for iter_23_0, iter_23_1 in pairs(self.ships) do
		table.insert(var_23_0, {
			obj = iter_23_1,
			position = iter_23_1.grid.position
		})
	end

	for iter_23_2, iter_23_3 in pairs(self.furnitures) do
		table.insert(var_23_0, {
			obj = iter_23_3,
			position = iter_23_3.grid.position
		})
	end

	table.sort(var_23_0, function(arg_24_0, arg_24_1)
		if arg_24_0.position.y == arg_24_1.position.y then
			return arg_24_0.position.x < arg_24_1.position.x
		else
			return arg_24_0.position.y > arg_24_1.position.y
		end

		return
	end)

	for iter_23_4, iter_23_5 in ipairs(var_23_0) do
		iter_23_5.obj:SetAsLastSibling()
	end

	return
end

function GuildDynamicBG:Dispose()
	for iter_25_0, iter_25_1 in pairs(self.ships) do
		iter_25_1:Dispose()
	end

	for iter_25_2, iter_25_3 in pairs(self.furnitures) do
		iter_25_3:Dispose()
	end

	if var_0_1 then
		if self.timer then
			self.timer:Stop()

			self.timer = nil
		end

		if self.timer1 then
			self.timer1:Stop()

			self.timer1 = nil
		end
	end

	return
end

function GuildDynamicBG:AddGridDebugView()
	local var_26_0 = {}

	for iter_26_0, iter_26_1 in pairs(self.path) do
		var_26_0[iter_26_0] = {}

		for iter_26_2, iter_26_3 in pairs(iter_26_1) do
			local var_26_1 = GameObject.New()

			SetParent(var_26_1, self.pathContainer)

			local var_26_2 = GetOrAddComponent(var_26_1, typeof(RectTransform))
			local var_26_3 = GetOrAddComponent(var_26_1, typeof(Image))

			var_26_2.sizeDelta = iter_26_3.sizeDelta
			var_26_2.pivot = Vector2(0, 0)
			var_26_2.localPosition = iter_26_3.localPosition
			var_26_0[iter_26_0][iter_26_2] = var_26_3
			var_26_1.name = iter_26_3.position.x .. "-" .. iter_26_3.position.y

			setActive(var_26_1, true)
		end
	end

	self.timer = Timer.New(function()
		for iter_27_0, iter_27_1 in pairs(self.path) do
			for iter_27_2, iter_27_3 in pairs(iter_27_1) do
				var_26_0[iter_27_0][iter_27_2].color = iter_27_3:IsLock() and Color.New(1, 0, 0, 0.3) or not iter_27_3:CanWalk() and Color.New(0.5, 0.5, 0.5, 0.3) or Color.New(1, 1, 1, 0.3)
			end
		end

		return
	end, 1, -1)

	self.timer:Start()
	self.timer.func()

	return
end

function GuildDynamicBG:AddDebugShip(arg_28_1)
	local var_28_0 = Ship.New({
		id = 0,
		configId = 301284,
		name = "001"
	})

	var_28_0.stand = true
	self.shipVOs = {
		var_28_0
	}

	self:InitShips(function()
		self.timer1 = Timer.New(function()
			if Input.GetKeyDown(KeyCode.A) then
				self.ships[1]:MoveLeft()
			end

			if Input.GetKeyDown(KeyCode.S) then
				self.ships[1]:MoveDown()
			end

			if Input.GetKeyDown(KeyCode.W) then
				self.ships[1]:MoveUp()
			end

			if Input.GetKeyDown(KeyCode.D) then
				self.ships[1]:MoveRight()
			end

			return
		end, Time.deltaTime, -1)

		self.timer1:Start()
		self.timer1.func()
		arg_28_1()

		return
	end)

	return
end

return GuildDynamicBG
