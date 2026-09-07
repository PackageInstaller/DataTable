local RacingMiniGameController = class("RacingMiniGameController")

function RacingMiniGameController:Ctor(arg_1_1, arg_1_2)
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

local function var_0_2(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs((arg_3_0:GetComponentsInChildren(typeof(SpineAnimUI), true):ToTable())) do
		if IsNil(iter_3_1) then
			-- block empty
		elseif arg_3_1 then
			iter_3_1:Pause()
		else
			iter_3_1:Resume()
		end
	end

	return
end

function RacingMiniGameController:InitTimer()
	self.timer = Timer.New(function()
		self:OnTimer(RacingMiniGameConfig.TIME_INTERVAL)

		return
	end, RacingMiniGameConfig.TIME_INTERVAL, -1)

	if IsUnityEditor and not self.handle then
		self.handle = UpdateBeat:CreateListener(function()
			if Input.GetKeyDown(KeyCode.W) then
				self.up = true
			end

			if Input.GetKeyUp(KeyCode.W) then
				self.up = false
			end

			if Input.GetKeyDown(KeyCode.S) then
				self.down = true
			end

			if Input.GetKeyUp(KeyCode.S) then
				self.down = false
			end

			if Input.GetKeyDown(KeyCode.Space) then
				self.boost = true
			end

			if Input.GetKeyUp(KeyCode.Space) then
				self.boost = false
			end

			return
		end, self)

		UpdateBeat:AddListener(self.handle)
	end

	return
end

function RacingMiniGameController:InitGameUI(arg_7_1)
	self.rtViewport = arg_7_1:Find("Viewport")
	self.bgSingleSize = self.rtViewport.rect.width
	self.rtBgContent = self.rtViewport:Find("BgContent")
	self.rtMainContent = self.rtViewport:Find("MainContent")
	self.singleHeight = self.rtMainContent.rect.height / 3
	self.rtRes = arg_7_1:Find("Resource")
	self.rtController = arg_7_1:Find("Controller")

	for iter_7_0, iter_7_1 in ipairs({
		"up",
		"down",
		"boost"
	}) do
		local var_7_0 = GetOrAddComponent(self.rtController:Find("bottom/btn_" .. iter_7_1), typeof(EventTriggerListener))

		var_7_0:AddPointDownFunc(function()
			self[iter_7_1] = true

			return
		end)
		var_7_0:AddPointUpFunc(function()
			self[iter_7_1] = false

			return
		end)
	end

	if RacingMiniGameConfig.BOOST_BUTTON_TYPE_CHANGE then
		RemoveComponent(self.rtController:Find("bottom/btn_boost"), typeof(EventTriggerListener))
		onButton(self.binder, self.rtController:Find("bottom/btn_boost"), function()
			if not self.target.isBlock then
				self.enginePower = math.clamp(self.enginePower + RacingMiniGameConfig.BOOST_RATE[2], RacingMiniGameConfig.M_LIST[1], RacingMiniGameConfig.M_LIST[#RacingMiniGameConfig.M_LIST])

				if self.target.state == "base" then
					self.target:Show("accel")
				end
			end

			return
		end)
	end

	self.rtTime = self.rtController:Find("top/time")

	setText(self.rtTime:Find("Text/plus"), "+" .. RacingMiniGameConfig.ITEM_ADD_TIME .. "s")
	self.rtTime:Find("Text/plus"):GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		setActive(self.rtTime:Find("Text/plus"), false)

		return
	end)

	self.rtDis = self.rtController:Find("top/dis")
	self.rtPower = self.rtController:Find("bottom/speed")
	self.rtFriend = self.rtController:Find("top/friend")
	self.queue = {}

	return
end

function RacingMiniGameController:ResetGame()
	self.timeCount = 0
	self.timeAll = RacingMiniGameConfig.ALL_TIME

	if self.target then
		self.target:Clear()

		self.target = nil
	end

	while #self.queue > 0 do
		self.queue[#self.queue]:Clear()
	end

	self.enginePower = 0
	self.chargeDis = 0
	self.disCount = 0
	self.rateDic = {}
	self.itemCountDic = {}

	return
end

function RacingMiniGameController:ReadyGame(arg_13_1)
	local var_13_0 = getProxy(PlayerProxy):getRawData()

	self.rankData = underscore.filter(arg_13_1, function(arg_14_0)
		return arg_14_0.player_id ~= var_13_0.id
	end)

	table.sort(self.rankData, CompareFuncs({
		function(arg_15_0)
			return arg_15_0.score
		end
	}))

	self.target = RacingMiniNameSpace.Motorcycle.New(cloneTplTo(self.rtRes:Find("qiye_minigame"), self.rtMainContent:Find(-2)), NewPos(0, 0), self)

	table.insert(self.queue, RacingMiniNameSpace.StartMark.New(cloneTplTo(self.rtRes:Find("start_mark"), self.rtMainContent:Find(-2)), NewPos(550, 0), self))
	self:UpdateDisplay()
	onNextTick(function()
		self:PauseGame()

		return
	end)

	return
end

function RacingMiniGameController:StartGame()
	self.isStart = true

	self:ResumeGame()

	return
end

function RacingMiniGameController:EndGame(arg_18_1)
	self.isStart = false

	self:PauseGame()

	self.result = arg_18_1 or 0
	self.point = self.disCount / 20
	self.point = self.point - self.point % 0.01

	self.binder:openUI("result")

	return
end

function RacingMiniGameController:ResumeGame()
	self.isPause = false

	self.timer:Start()
	var_0_1(self.rtViewport, 1)
	var_0_2(self.rtViewport, false)

	return
end

function RacingMiniGameController:PauseGame()
	self.isPause = true

	self.timer:Stop()
	var_0_1(self.rtViewport, 0)
	var_0_2(self.rtViewport, true)

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

function RacingMiniGameController:OnTimer(arg_22_1)
	self.timeCount = self.timeCount + arg_22_1

	if self.timeCount > self.timeAll then
		self:EndGame(1)

		return
	end

	if self.target.invincibleTime then
		self.target:UpdateInvincibility(arg_22_1)
	end

	local var_22_0 = NewPos(0, 0)
	local var_22_1 = self:GetSpeed(RacingMiniGameConfig.BOOST_RATE[not self.target.isBlock and self.boost and 2 or 1] * arg_22_1)

	var_22_0.x = var_22_1 * arg_22_1

	if not self.target.isBlock then
		if var_22_1 > 0 then
			if self.up then
				var_22_0.y = var_22_0.y + 1
			end

			if self.down then
				var_22_0.y = var_22_0.y - 1
			end

			var_22_0.y = var_22_0.y * self.singleHeight / RacingMiniGameConfig.Y_COVER_TIME * ((self.target.isVertigo or nil) and (RacingMiniGameConfig.Y_OBSTACLE_REDUCE or 1)) * arg_22_1

			if self.target.state == "base" and self.boost then
				self.target:Show("accel")
			end
		elseif not self.target.isVertigo and self.target.state ~= "base" then
			self.target:Show("base")
		end
	end

	self.target:UpdatePos(var_22_0 * NewPos(0, 1), self.singleHeight)
	setParent(self.target.rt, self.rtMainContent:Find(math.clamp(math.floor((self.target.pos.y + self.singleHeight) * 3 / 2 / self.singleHeight) - 1, -1, 1) - 1))

	local var_22_2 = 1

	while var_22_2 <= #self.queue do
		self.queue[var_22_2]:UpdatePos(var_22_0 * NewPos(-1, 0))

		if not self.queue[var_22_2].isTriggered and self.queue[var_22_2].colliderSize and var_0_3(self.queue[var_22_2], self.target) then
			self.queue[var_22_2]:Trigger(self.target)
		end

		if self.queue[var_22_2].pos.x < -self.bgSingleSize then
			self.queue[var_22_2]:Clear()
		else
			var_22_2 = var_22_2 + 1
		end
	end

	local var_22_3 = self.rtBgContent.anchoredPosition.x - var_22_0.x

	if self.rtBgContent.anchoredPosition.x - var_22_0.x < -self.bgSingleSize / 2 then
		var_22_3 = var_22_3 + self.bgSingleSize
	end

	setAnchoredPosition(self.rtBgContent, {
		x = var_22_3
	})

	self.chargeDis = self.chargeDis - var_22_0.x

	if self.chargeDis <= 0 then
		self:CreateNewObject()
	end

	self.disCount = self.disCount + var_22_0.x

	self:UpdateDisplay()

	return
end

function RacingMiniGameController:UpdateDisplay()
	setText(self.rtTime:Find("Text"), string.format("%02d:%02ds", math.floor(self.timeAll - self.timeCount), math.floor((self.timeAll - self.timeCount - math.floor(self.timeAll - self.timeCount)) * 100)))
	setText(self.rtDis, string.format("%.2fm", self.disCount / 20 - self.disCount / 20 % 0.01))

	local var_23_0

	for iter_23_0, iter_23_1 in ipairs(RacingMiniGameConfig.BUOY_POWER_LIST) do
		if iter_23_1 >= self.enginePower then
			var_23_0 = iter_23_0

			break
		end
	end

	local var_23_2 = {}

	if var_23_0 > 1 then
		var_23_2.x = RacingMiniGameConfig.BUOY_POS_LIST[var_23_0 - 1] + (self.enginePower - RacingMiniGameConfig.BUOY_POWER_LIST[var_23_0 - 1]) / (RacingMiniGameConfig.BUOY_POWER_LIST[var_23_0] - RacingMiniGameConfig.BUOY_POWER_LIST[var_23_0 - 1]) * (RacingMiniGameConfig.BUOY_POS_LIST[var_23_0] - RacingMiniGameConfig.BUOY_POS_LIST[var_23_0 - 1]) or 0
	end

	setAnchoredPosition(self.rtPower:Find("range/buoy"), var_23_2)

	if self.target.isVertigo then
		var_23_0 = 1
	end

	for iter_23_2, iter_23_3 in ipairs(self.target.effectList) do
		setActive(iter_23_3, var_23_0 - 1 == iter_23_2)
	end

	self.friendIndex = defaultValue(self.friendIndex, 1)

	while self.friendIndex < #RacingMiniGameConfig.FRIEND_DIS_LIST and RacingMiniGameConfig.FRIEND_DIS_LIST[self.friendIndex + 1] < self.disCount / 20 do
		self.friendIndex = self.friendIndex + 1
		self.friendDirty = true
	end

	if self.friendDirty then
		self.friendDirty = false

		while #self.rankData > 0 and self.rankData[1].score / 100 < RacingMiniGameConfig.FRIEND_DIS_LIST[self.friendIndex] do
			table.remove(self.rankData, 1)
		end

		local var_23_3

		for iter_23_4, iter_23_5 in ipairs(self.rankData) do
			if self.friendIndex == #RacingMiniGameConfig.FRIEND_DIS_LIST or iter_23_5.score / 100 < RacingMiniGameConfig.FRIEND_DIS_LIST[self.friendIndex + 1] then
				var_23_3 = iter_23_4
			else
				break
			end
		end

		setActive(self.rtFriend, var_23_3)

		self.friendInfo = var_23_3 and self.rankData[math.random(var_23_3)] or nil

		if self.friendInfo then
			setText(self.rtFriend:Find("Text"), self.friendInfo.name)
			setText(self.rtFriend:Find("point"), string.format("%.2fm", self.friendInfo.score / 100))
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

function RacingMiniGameController:CreateNewObject()
	local var_24_0

	for iter_24_0, iter_24_1 in ipairs(RacingMiniGameConfig.FIELD_CONFIG) do
		if self.timeCount < iter_24_1.time then
			break
		else
			var_24_0 = iter_24_1
		end
	end

	local var_24_1 = {}
	local var_24_2 = 0

	for iter_24_2 = -1, 1 do
		self.rateDic[iter_24_2] = defaultValue(self.rateDic[iter_24_2], 0)

		if math.random() / (2 - iter_24_2) < self.rateDic[iter_24_2] then
			var_24_2 = var_24_2 + 1
			var_24_1[iter_24_2] = true
		else
			var_24_1[iter_24_2] = false
		end
	end

	if var_24_2 == 3 then
		var_24_1[math.random(3) - 2] = false
	end

	for iter_24_3 = -1, 1 do
		classCfg = var_24_1[iter_24_3] and var_24_0.obstacle_distribution or var_24_0.item_distribution
		rate = math.random()

		local var_24_4 = 0
		local var_24_5 = 0

		for iter_24_4, iter_24_5 in ipairs(classCfg) do
			var_24_5 = var_24_5 + iter_24_5[2]
		end

		local var_24_6

		for iter_24_6, iter_24_7 in ipairs(classCfg) do
			var_24_4 = var_24_4 + iter_24_7[2]

			if var_24_4 > rate * var_24_5 then
				var_24_6 = iter_24_7[1]

				break
			end
		end

		if var_24_6 and superof(RacingMiniNameSpace[var_24_6], RacingMiniNameSpace.Item) then
			if defaultValue(self.itemCountDic[var_24_6], 0) < defaultValue(var_24_0.item_create_limit[var_24_6], 0) then
				self.itemCountDic[var_24_6] = defaultValue(self.itemCountDic[var_24_6], 0) + 1
			else
				var_24_6 = nil
			end
		end

		if var_24_6 then
			table.insert(self.queue, (RacingMiniNameSpace[var_24_6].New(cloneTplTo(self.rtRes:Find(var_0_4[var_24_6]), self.rtMainContent:Find(iter_24_3)), NewPos(self.bgSingleSize * 1.5 + self.chargeDis, iter_24_3 * self.singleHeight), self)))

			self.rateDic[iter_24_3] = self.rateDic[iter_24_3] * var_24_0.continue_reduce
		else
			self.rateDic[iter_24_3] = self.rateDic[iter_24_3] + var_24_0.bye_plus
		end
	end

	self.chargeDis = self.chargeDis + var_24_0.recharge_dis

	return
end

function RacingMiniGameController:GetSpeed(arg_25_1)
	local var_25_0

	for iter_25_0 = 1, #RacingMiniGameConfig.M_LIST - 1 do
		if RacingMiniGameConfig.M_LIST[iter_25_0 + 1] > self.enginePower then
			var_25_0 = RacingMiniGameConfig.S_LIST[iter_25_0] + (self.enginePower - RacingMiniGameConfig.M_LIST[iter_25_0]) / (RacingMiniGameConfig.M_LIST[iter_25_0 + 1] - RacingMiniGameConfig.M_LIST[iter_25_0]) * (RacingMiniGameConfig.S_LIST[iter_25_0 + 1] - RacingMiniGameConfig.S_LIST[iter_25_0])

			break
		end
	end

	var_25_0 = var_25_0 or RacingMiniGameConfig.S_LIST[#RacingMiniGameConfig.S_LIST]
	self.enginePower = math.clamp(self.enginePower + arg_25_1, RacingMiniGameConfig.M_LIST[1], RacingMiniGameConfig.M_LIST[#RacingMiniGameConfig.M_LIST])

	return var_25_0 * 10
end

function RacingMiniGameController:AddTime(arg_26_1)
	self.timeAll = self.timeAll + arg_26_1

	setActive(self.rtTime:Find("Text/plus"), true)

	return
end

function RacingMiniGameController:SetEnginePower(arg_27_1)
	self.enginePower = math.min(self.enginePower, arg_27_1)

	return
end

function RacingMiniGameController:willExit()
	if self.handle then
		UpdateBeat:RemoveListener(self.handle)
	end

	return
end

return RacingMiniGameController
