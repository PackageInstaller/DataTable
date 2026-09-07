local RyzaMiniGameView = class("RyzaMiniGameView", import("view.miniGame.BaseMiniGameView"))

RyzaMiniGameView.EVENT_CREATE = "RyzaMiniGameView.EVENT_CREATE"
RyzaMiniGameView.EVENT_DESTROY = "RyzaMiniGameView.EVENT_DESTROY"
RyzaMiniGameView.EVENT_FINISH = "RyzaMiniGameView.EVENT_FINISH"
RyzaMiniGameView.EVENT_WINDOW_FOCUS = "RyzaMiniGameView.EVENT_WINDOW_FOCUS"
RyzaMiniGameView.EVENT_STATUS_SYNC = "RyzaMiniGameView.EVENT_STATUS_SYNC"
RyzaMiniGameView.EVENT_UPDATE_HIDE = "RyzaMiniGameView.EVENT_UPDATE_HIDE"

function RyzaMiniGameView:getUIName()
	return "RyzaMiniGameUI"
end

function RyzaMiniGameView:didEnter()
	self:initTimer()
	self:initUI()
	self:initGameUI()
	onNextTick(function()
		self:openUI("main")

		return
	end)

	return
end

local function var_0_1(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs((arg_4_0:GetComponentsInChildren(typeof(Animator), true):ToTable())) do
		iter_4_1.speed = arg_4_1
	end

	return
end

function RyzaMiniGameView:openUI(arg_5_1)
	if self.status then
		setActive(self.rtTitlePage:Find(self.status), false)
	end

	if arg_5_1 then
		setActive(self.rtTitlePage:Find(arg_5_1), true)
	end

	self.status = arg_5_1

	switch(arg_5_1, {
		main = function()
			self:updateMainUI()

			return
		end,
		pause = function()
			self:pauseGame()

			return
		end,
		exit = function()
			self:pauseGame()

			return
		end,
		result = function()
			local var_9_0 = self:GetMGData():GetRuntimeData("elements")
			local var_9_1 = self.scoreNum
			local var_9_2

			if var_9_0 and #var_9_0 > 0 then
				var_9_2 = var_9_0[1] or 0
			end

			local var_9_3 = self.rtTitlePage:Find("result")

			setActive(var_9_3:Find("window/now/new"), var_9_2 < var_9_1)

			if var_9_2 <= var_9_1 then
				var_9_2 = var_9_1

				self:StoreDataToServer({
					var_9_1
				})
			end

			setText(var_9_3:Find("window/high/Text"), var_9_2)
			setText(var_9_3:Find("window/now/Text"), var_9_1)

			local var_9_4 = self:GetMGHubData()

			if self.stageIndex == var_9_4.usedtime + 1 and var_9_4.count > 0 then
				self:SendSuccess(0)
			end

			return
		end
	})

	return
end

function RyzaMiniGameView:updateMainUI()
	local var_10_0 = self:GetMGHubData()
	local var_10_1 = var_10_0:getConfig("reward_need")
	local var_10_2 = var_10_0.usedtime
	local var_10_3 = var_10_0.usedtime + var_10_0.count
	local var_10_4 = var_10_0.usedtime == var_10_1 and 8 or math.min(var_10_0.usedtime + 1, var_10_3)
	local var_10_5 = self.itemList.container

	for iter_10_0 = 1, self.itemList.container.childCount do
		local var_10_6 = {}

		if iter_10_0 <= var_10_2 then
			var_10_6.finish = true
		elseif iter_10_0 <= var_10_3 then
			-- block empty
		elseif var_10_2 == var_10_1 then
			var_10_6.finish = false
			var_10_6.lock = false
		else
			var_10_6.lock = true
		end

		local var_10_7 = var_10_5:GetChild(iter_10_0 - 1)

		setActive(var_10_7:Find("finish"), var_10_6.finish)
		setActive(var_10_7:Find("lock"), var_10_6.lock)
		setToggleEnabled(var_10_7, iter_10_0 <= var_10_4)
		triggerToggle(var_10_7, iter_10_0 == var_10_4)
	end

	local var_10_8 = var_10_5:GetComponent(typeof(ScrollRect)).viewport.rect.height

	scrollTo(var_10_5, nil, 1 - math.clamp(var_10_5:GetChild(0).anchoredPosition.y - var_10_5:GetChild(var_10_4 - 1).anchoredPosition.y, 0, var_10_5.rect.height - var_10_8) / (var_10_5.rect.height - var_10_8))
	setActive(self.rtTitlePage:Find("main/tip/Image"), var_10_2 == var_10_1)
	self:checkGet()

	if var_10_2 == 1 and var_10_4 == 2 then
		if PlayerPrefs.GetInt("ryza_minigame_guide", 0) == 0 then
			scrollTo(var_10_5, nil, 1)
			pg.NewGuideMgr.GetInstance():Play("Ryza_MiniGame")
			PlayerPrefs.SetInt("ryza_minigame_guide", 1)
		end
	elseif PlayerPrefs.GetInt("ryza_minigame_help", 0) == 0 then
		triggerButton(self.rtTitlePage:Find("main/btn_rule"))
	end

	return
end

function RyzaMiniGameView:checkGet()
	local var_11_0 = self:GetMGHubData()

	if var_11_0.ultimate == 0 then
		if var_11_0.usedtime < var_11_0:getConfig("reward_need") then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = var_11_0.id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
	end

	return
end

function RyzaMiniGameView:initUI()
	self.rtTitlePage = self._tf:Find("TitlePage")

	local var_12_0 = self.rtTitlePage:Find("main")

	onButton(self, var_12_0:Find("btn_back"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, var_12_0:Find("btn_rule"), function()
		PlayerPrefs.SetInt("ryza_minigame_help", 1)
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.ryza_mini_game.tip
		})

		return
	end, SFX_PANEL)

	local var_12_1 = self:GetMGData():GetSimpleValue("story")

	onButton(self, var_12_0:Find("btn_start"), function()
		local var_15_0 = {}
		local var_15_1 = checkExist(var_12_1, {
			self.stageIndex
		}, {
			1
		})

		if var_15_1 then
			table.insert(var_15_0, function(arg_16_0)
				pg.NewStoryMgr.GetInstance():Play(var_15_1, arg_16_0)

				return
			end)
		end

		seriesAsync(var_15_0, function()
			self:readyStart()

			return
		end)

		return
	end, SFX_CONFIRM)

	self.stageIndex = 0

	local var_12_2 = pg.mini_game[self:GetMGData().id].simple_config_data.drop_ids
	local var_12_3 = var_12_0:Find("side_panel/award/content")

	self.itemList = UIItemList.New(var_12_3, var_12_3:GetChild(0))

	self.itemList:make(function(arg_18_0, arg_18_1, arg_18_2)
		arg_18_1 = arg_18_1 + 1

		if arg_18_0 == UIItemList.EventUpdate then
			local var_18_0 = arg_18_2:Find("IconTpl")
			local var_18_1 = {}

			var_18_1.type, var_18_1.id, var_18_1.count = unpack(var_12_2[arg_18_1])

			updateDrop(var_18_0, var_18_1)
			onButton(self, var_18_0, function()
				self:emit(RyzaMiniGameView.ON_DROP, var_18_1)

				return
			end, SFX_PANEL)
			onToggle(self, arg_18_2, function(arg_20_0)
				if arg_20_0 then
					self.stageIndex = arg_18_1
				end

				return
			end)
		end

		return
	end)
	self.itemList:align(#var_12_2)

	local var_12_4 = self:GetMGHubData():getConfig("reward_need")

	setActive(var_12_3:GetChild(var_12_4), true)
	onToggle(self, var_12_3:GetChild(var_12_4), function(arg_21_0)
		if arg_21_0 then
			self.stageIndex = 0
		end

		return
	end)
	self.rtTitlePage:Find("countdown"):Find("bg/Image"):GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		self:openUI()
		self:startGame()

		return
	end)
	onButton(self, self.rtTitlePage:Find("pause"):Find("window/btn_confirm"), function()
		self:openUI()
		self:resumeGame()

		return
	end, SFX_CONFIRM)

	local var_12_5 = self.rtTitlePage:Find("exit")

	onButton(self, var_12_5:Find("window/btn_cancel"), function()
		self:openUI()
		self:resumeGame()

		return
	end, SFX_CANCEL)
	onButton(self, var_12_5:Find("window/btn_confirm"), function()
		self:openUI()
		self:resumeGame()
		self:endGame()

		return
	end, SFX_CONFIRM)
	onButton(self, self.rtTitlePage:Find("result"):Find("window/btn_finish"), function()
		setActive(self._tf:Find("Viewport"), false)
		self:openUI("main")
		pg.BgmMgr.GetInstance():Push(self.__cname, "ryza-5")

		return
	end, SFX_CONFIRM)

	return
end

function RyzaMiniGameView:initGameUI()
	self.uiMgr = pg.UIMgr.GetInstance()
	self.rtResource = self._tf:Find("Resource")
	self.rtMain = self._tf:Find("Viewport/MainContent")
	self.rtPlane = self.rtMain:Find("plane")
	self.sprites = {}

	eachChild(self.rtPlane, function(arg_28_0)
		self.sprites[arg_28_0.name] = getImageSprite(arg_28_0)

		return
	end)

	self.rtController = self._tf:Find("Controller")
	self.rtJoyStick = self.rtController:Find("bottom/handle_stick")

	onButton(self, self.rtController:Find("bottom/btn_bomb"), function()
		self.responder:RyzaBomb()

		return
	end)

	self.rtScore = self.rtController:Find("top/title/SCORE/Text")
	self.rtTime = self.rtController:Find("top/title/TIME/Text")

	onButton(self, self.rtController:Find("top/btn_back"), function()
		self:openUI("exit")

		return
	end, SFX_PANEL)
	onButton(self, self.rtController:Find("top/btn_pause"), function()
		self:openUI("pause")

		return
	end, SFX_PANEL)

	self.rtStatus = self.rtController:Find("bottom/status")
	self.rtRyzaHP = self.rtController:Find("top/title/HP/heart")
	self.rtControllerUI = self.rtController:Find("UI")

	eachChild(self.rtControllerUI, function(arg_32_0)
		self["tplUI" .. arg_32_0.name] = arg_32_0

		setActive(arg_32_0, false)

		return
	end)

	self.responder = Responder.New(self)

	self:bind(RyzaMiniGameView.EVENT_CREATE, function(arg_33_0, ...)
		self:CreateReactor(...)

		return
	end)
	self:bind(RyzaMiniGameView.EVENT_DESTROY, function(arg_34_0, ...)
		self:DestroyReactor(...)

		return
	end)
	self:bind(RyzaMiniGameView.EVENT_FINISH, function(arg_35_0, arg_35_1)
		self:endGame(arg_35_1)

		return
	end)
	self:bind(RyzaMiniGameView.EVENT_WINDOW_FOCUS, function(arg_36_0, arg_36_1)
		setAnchoredPosition(self.rtMain, {
			x = math.clamp(-arg_36_1.x, -self.buffer.x, self.buffer.x),
			y = math.clamp(-arg_36_1.y, -self.buffer.y - 48, self.buffer.y - 48)
		})

		return
	end)
	self:bind(RyzaMiniGameView.EVENT_STATUS_SYNC, function(arg_37_0, ...)
		self:updateControllerStatus(...)
		self:popRyzaUI(...)

		return
	end)
	self:bind(RyzaMiniGameView.EVENT_UPDATE_HIDE, function(arg_38_0, arg_38_1, arg_38_2)
		if isa(arg_38_1, MoveEnemy) then
			GetOrAddComponent(self.reactorUIs[arg_38_1], typeof(CanvasGroup)).alpha = arg_38_2 and 0 or 1
		end

		return
	end)

	return
end

function RyzaMiniGameView:initTimer()
	self.timer = Timer.New(function()
		self:onTimer()

		return
	end, RyzaMiniGameConfig.TIME_INTERVAL, -1)

	return
end

function RyzaMiniGameView:readyStart()
	self:resetGame()
	setActive(self._tf:Find("Viewport"), true)
	var_0_1(self.rtMain, 1)
	self:initConfig()
	self:buildMap()
	self:initController()
	self:openUI("countdown")

	return
end

function RyzaMiniGameView:startGame()
	pg.BgmMgr.GetInstance():Push(self.__cname, "ryza-az-battle")

	self.gameStartFlag = true

	self:startTimer()

	return
end

function RyzaMiniGameView:endGame(arg_43_1)
	if arg_43_1 then
		self.scoreNum = self.scoreNum + RyzaMiniGameConfig.GetPassGamePoint(self.countTime)

		setText(self.rtScore, self.scoreNum)
	end

	self.gameEndFlag = true

	self:stopTimer()
	self:openUI("result")

	return
end

function RyzaMiniGameView:pauseGame()
	self.gamePause = true

	self:stopTimer()
	self:pauseManagedTween()

	return
end

function RyzaMiniGameView:resumeGame()
	self.gamePause = false

	self:startTimer()
	self:resumeManagedTween()

	return
end

function RyzaMiniGameView:resetGame()
	self.gameStartFlag = false
	self.gamePause = false
	self.gameEndFlag = false
	self.scoreNum = 0
	self.countTime = 0

	self.responder:reset()

	if self.reactorUIs then
		for iter_46_0, iter_46_1 in pairs(self.reactorUIs) do
			Destroy(iter_46_1)
		end
	end

	self.reactorUIs = {}

	return
end

function RyzaMiniGameView:initConfig()
	local var_47_0 = self.stageIndex == 0 and math.random(7) or self.stageIndex
	local var_47_1 = 0
	local var_47_2 = underscore.rest(RyzaMiniGameConfig.ENEMY_TYPE_LIST, 1)
	local var_47_3 = {}
	local var_47_4 = pg.MiniGameTileMgr.GetInstance():getDataLayers("BoomGame", "BoomLevel_" .. var_47_0)

	self.config = {}
	self.config.mapSize = NewPos(var_47_4[1].width, var_47_4[1].height)
	self.config.reactorList = {}

	for iter_47_0, iter_47_1 in ipairs(var_47_4) do
		for iter_47_2, iter_47_3 in ipairs(iter_47_1.layer) do
			if iter_47_3.item then
				local var_47_5 = {
					name = iter_47_3.item
				}

				if self.stageIndex == 0 and isa(RyzaMiniGameConfig.CreateInfo(var_47_5.name), TargetMove) then
					if var_47_5.name == "Ryza" then
						-- block empty
					else
						local var_47_6 = math.random(#var_47_2)

						if string.find(var_47_2[var_47_6], "BOSS_") then
							var_47_5.name = table.remove(var_47_2, var_47_6)
							var_47_1 = var_47_1 + 1

							if var_47_1 == RyzaMiniGameConfig.FREE_MAP_BOSS_LIMIT[var_47_0] then
								while string.find(var_47_2[#var_47_2], "BOSS_") do
									table.remove(var_47_2)
								end
							end
						else
							var_47_5.name = var_47_2[var_47_6]
						end

						table.insert(var_47_3, #self.config.reactorList + 1)
					end
				elseif iter_47_3.prop then
					for iter_47_4, iter_47_5 in pairs(iter_47_3.prop) do
						var_47_5[iter_47_4] = iter_47_5
					end
				end

				var_47_5.pos = {
					(iter_47_3.index - 1) % self.config.mapSize.x,
					math.floor((iter_47_3.index - 1) / self.config.mapSize.x)
				}

				table.insert(self.config.reactorList, var_47_5)
			end
		end
	end

	if self.stageIndex == 0 and var_47_1 == 0 then
		local var_47_7 = math.random(#var_47_3)

		self.config.reactorList[var_47_7] = {
			name = "BOSS_" .. self.config.reactorList[var_47_7].name,
			pos = self.config.reactorList[var_47_7].pos
		}
	end

	return
end

function RyzaMiniGameView:buildMap()
	setSizeDelta(self.rtMain, self.config.mapSize * 32)
	eachChild(self.rtMain:Find("bg/NW"), function(arg_49_0)
		setActive(arg_49_0, arg_49_0.name == tostring(math.floor((self.stageIndex - 1) % 8 / 2) + 1))

		return
	end)

	local var_48_0 = self._tf:Find("Viewport").rect

	self.buffer = NewPos(math.max(self.rtMain.rect.width + 0 - var_48_0.width, 0), math.max(self.rtMain.rect.height + 160 - var_48_0.height, 0)) * 0.5

	local var_48_2 = self.config.mapSize.y
	local var_48_3 = UIItemList.New(self.rtPlane, self.rtPlane:GetChild(0))

	var_48_3:make(function(arg_50_0, arg_50_1, arg_50_2)
		if arg_50_0 == UIItemList.EventUpdate then
			arg_50_2.name = arg_50_1 % var_48_2 .. "_" .. math.floor(arg_50_1 / var_48_2)

			if math.random() < RyzaMiniGameConfig.GRASS_CHAGNE_RATE then
				setImageAlpha(arg_50_2, 1)
				setImageSprite(arg_50_2, self.sprites["Grass_" .. 3 + math.random(3)])
			else
				setImageAlpha(arg_50_2, 0)
			end
		end

		return
	end)
	var_48_3:align(self.config.mapSize.x * self.config.mapSize.y)
	self:soilMapPartition(Vector2.zero, self.config.mapSize)

	for iter_48_0, iter_48_1 in ipairs(self.config.reactorList) do
		self:CreateReactor(iter_48_1)
	end

	return
end

function RyzaMiniGameView:initController()
	setText(self.rtScore, self.scoreNum)
	setText(self.rtTime, string.format("%02d:%02d", math.floor(self.countTime / 60), math.floor(self.countTime % 60)))
	self:updateControllerStatus(self.responder.reactorRyza, "hp", {
		num = self.responder.reactorRyza.hp
	})
	self:updateControllerStatus(self.responder.reactorRyza, "bomb", {
		num = self.responder.reactorRyza.bomb
	})
	self:updateControllerStatus(self.responder.reactorRyza, "power", {
		num = self.responder.reactorRyza.power
	})
	self:updateControllerStatus(self.responder.reactorRyza, "speed", {
		num = self.responder.reactorRyza.speed
	})

	return
end

function RyzaMiniGameView:updateControllerStatus(arg_52_1, arg_52_2, arg_52_3)
	if isa(arg_52_1, MoveRyza) then
		if arg_52_2 == "hp" then
			eachChild(self.rtRyzaHP, function(arg_53_0)
				setActive(arg_53_0:Find("active"), tonumber(arg_53_0.name) <= arg_52_3.num)

				return
			end)
		else
			eachChild(self.rtStatus:Find(string.upper(arg_52_2) .. "/bit"), function(arg_54_0)
				setActive(arg_54_0, tonumber(arg_54_0.name) <= arg_52_3.num)

				return
			end)
		end
	elseif isa(arg_52_1, MoveEnemy) then
		setSlider(self.reactorUIs[arg_52_1]:Find("hp"), 0, arg_52_3.max, arg_52_3.num)
	end

	return
end

function RyzaMiniGameView:popRyzaUI(arg_55_1, arg_55_2, arg_55_3)
	if isa(arg_55_1, MoveRyza) then
		local var_55_0 = self.reactorUIs[arg_55_1]

		if arg_55_2 == "hp" then
			local var_55_1 = var_55_0:Find("pop/hp_" .. (arg_55_3.delta > 0 and "up" or "down"))

			for iter_55_0 = 1, 2 do
				setActive(var_55_1:Find(iter_55_0), iter_55_0 * iter_55_0 == arg_55_3.delta * arg_55_3.delta)
			end

			setActive(var_55_1, false)
			setActive(var_55_1, true)
		else
			local var_55_2 = var_55_0:Find("pop/" .. arg_55_2 .. "_up")

			setActive(var_55_2, false)
			setActive(var_55_2, true)
		end
	end

	return
end

function RyzaMiniGameView:CreateReactor(arg_56_1)
	local var_56_0, var_56_1, var_56_2 = RyzaMiniGameConfig.CreateInfo(arg_56_1.name)

	if not var_56_0 then
		warning(arg_56_1.name)

		return
	end

	local var_56_3 = var_56_0.New(arg_56_1, cloneTplTo(self.rtResource:Find(var_56_1), self.rtMain:Find(var_56_2)), self.responder)

	if isa(var_56_3, MoveRyza) then
		self.reactorUIs[var_56_3] = cloneTplTo(self.tplUIRyza, self.rtControllerUI)

		eachChild(self.reactorUIs[var_56_3]:Find("pop"), function(arg_57_0)
			arg_57_0:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
				setActive(arg_57_0, false)

				return
			end)

			return
		end)

		self.reactorUIs[var_56_3].position = var_56_3._tf.position
	elseif isa(var_56_3, MoveEnemy) then
		self.reactorUIs[var_56_3] = cloneTplTo(self.tplUIEnemy, self.rtControllerUI)

		setAnchoredPosition(self.reactorUIs[var_56_3]:Find("hp"), {
			y = var_56_3:GetUIHeight()
		})

		self.reactorUIs[var_56_3].position = var_56_3._tf.position
	end

	return
end

function RyzaMiniGameView:DestroyReactor(arg_59_1, arg_59_2)
	if self.reactorUIs[arg_59_1] then
		Destroy(self.reactorUIs[arg_59_1])

		self.reactorUIs[arg_59_1] = nil
	end

	self.scoreNum = self.scoreNum + arg_59_2

	setText(self.rtScore, self.scoreNum)

	return
end

function RyzaMiniGameView:soilMapPartition(arg_60_1, arg_60_2)
	local var_60_0 = RyzaMiniGameConfig.SOIL_RANDOM_CONFIG
	local var_60_1 = math.floor(math.min(arg_60_2.x, arg_60_2.y) * (RyzaMiniGameConfig.SOIL_RANDOM_CONFIG.size_rate[1] + math.random() * (RyzaMiniGameConfig.SOIL_RANDOM_CONFIG.size_rate[2] - RyzaMiniGameConfig.SOIL_RANDOM_CONFIG.size_rate[1])))

	if var_60_1 < 2 then
		return
	end

	local var_60_2 = math.random(4) % 4

	self:dealSoilMap(NewPos(arg_60_1.x + ((var_60_2 % 2 > 0 or nil) and (arg_60_2.x - var_60_1 or 0)), arg_60_1.y + ((var_60_2 > 1 or nil) and (arg_60_2.y - var_60_1 or 0))), var_60_1)

	local var_60_3 = var_60_1 + math.ceil((arg_60_2.x - var_60_1) * var_60_0.spacer_rate)
	local var_60_4 = var_60_1 + math.ceil((arg_60_2.y - var_60_1) * var_60_0.spacer_rate)

	if arg_60_2.x > arg_60_2.y then
		self:soilMapPartition(NewPos(arg_60_1.x + (var_60_2 % 2 > 0 and 0 or var_60_3), arg_60_1.y), NewPos(arg_60_2.x - var_60_3, arg_60_2.y))
		self:soilMapPartition(NewPos(arg_60_1.x + ((var_60_2 % 2 > 0 or nil) and (arg_60_2.x - var_60_1 or 0)), arg_60_1.y + (var_60_2 > 1 and 0 or var_60_4)), NewPos(var_60_1, arg_60_2.y - var_60_4))
	else
		self:soilMapPartition(NewPos(arg_60_1.x + (var_60_2 % 2 > 0 and 0 or var_60_3), arg_60_1.y + ((var_60_2 > 1 or nil) and (arg_60_2.y - var_60_1 or 0))), NewPos(arg_60_2.x - var_60_3, var_60_1))
		self:soilMapPartition(NewPos(arg_60_1.x, arg_60_1.y + (var_60_2 > 1 and 0 or var_60_4)), NewPos(arg_60_2.x, arg_60_2.y - var_60_4))
	end

	return
end

local var_0_2 = {
	{
		0,
		1
	},
	{
		1,
		0
	},
	{
		0,
		-1
	},
	{
		-1,
		0
	}
}
local var_0_3 = {
	{
		0,
		1
	},
	{
		1,
		0
	},
	{
		0,
		-1
	},
	{
		-1,
		0
	},
	{
		1,
		1
	},
	{
		1,
		-1
	},
	{
		-1,
		-1
	},
	{
		-1,
		1
	}
}

function RyzaMiniGameView:dealSoilMap(arg_61_1, arg_61_2)
	local var_61_0 = {}

	for iter_61_0 = 0, 3 do
		local var_61_2

		if iter_61_0 % 2 > 0 then
			var_61_2 = arg_61_2 - 1 or 0

			local var_61_3

			if iter_61_0 > 1 then
				var_61_3 = arg_61_2 - 1 or 0
			end
		end

		table.insert(var_61_0, arg_61_1 + NewPos(var_61_2, var_61_3))
	end

	local function var_61_4(arg_62_0)
		if arg_62_0.x < arg_61_1.x or arg_62_0.y < arg_61_1.y or arg_62_0.x >= arg_61_1.x + arg_61_2 or arg_62_0.y >= arg_61_1.y + arg_61_2 then
			return false
		else
			return true
		end

		return
	end

	local var_61_5 = {}

	local function var_61_6(arg_63_0)
		local var_63_0 = 0

		for iter_63_0, iter_63_1 in ipairs(var_0_3) do
			local var_63_1 = arg_63_0 + NewPos(unpack(iter_63_1))

			if var_61_4(var_63_1) and defaultValue(var_61_5[var_63_1.x .. "_" .. var_63_1.y], true) then
				var_63_0 = var_63_0 + 1
			end
		end

		return var_63_0
	end

	local function var_61_7(arg_64_0)
		for iter_64_0, iter_64_1 in ipairs(var_0_3) do
			local var_64_0 = arg_64_0 + NewPos(unpack(iter_64_1))

			if var_61_4(var_64_0) and defaultValue(var_61_5[var_64_0.x .. "_" .. var_64_0.y], true) and not RyzaMiniGameConfig.SOIL_SPRITES_DIC[var_61_6(var_64_0)] then
				return false
			end
		end

		return true
	end

	local var_61_9 = 0

	while var_61_9 < #var_61_0 do
		var_61_9 = var_61_9 + 1

		local var_61_10 = var_61_0[var_61_9]

		var_61_5[var_61_0[var_61_9].x .. "_" .. var_61_0[var_61_9].y] = false

		local var_61_11

		if math.random() < RyzaMiniGameConfig.SOIL_RANDOM_CONFIG.cancel_rate[1] + RyzaMiniGameConfig.SOIL_RANDOM_CONFIG.cancel_rate[2] * (1 - 0 / arg_61_2 / arg_61_2) * (1 - 0 / arg_61_2 / arg_61_2) and var_61_7(var_61_10) then
			var_61_11 = 0 + 1
		else
			var_61_5[var_61_10.x .. "_" .. var_61_10.y] = true
		end

		for iter_61_1, iter_61_2 in ipairs(var_0_2) do
			local var_61_12 = var_61_10 + NewPos(unpack(iter_61_2))

			if var_61_4(var_61_12) and var_61_5[var_61_12.x .. "_" .. var_61_12.y] == nil then
				table.insert(var_61_0, var_61_12)
			end
		end
	end

	local var_61_13 = self.config.mapSize.x

	for iter_61_3 = arg_61_1.x, arg_61_1.x + arg_61_2 - 1 do
		for iter_61_4 = arg_61_1.y, arg_61_1.y + arg_61_2 - 1 do
			if defaultValue(var_61_5[iter_61_3 .. "_" .. iter_61_4], true) then
				local var_61_15 = RyzaMiniGameConfig.SOIL_SPRITES_DIC[var_61_6(NewPos(iter_61_3, iter_61_4))]

				assert(var_61_15)

				local var_61_16 = self.rtPlane:GetChild(iter_61_4 * var_61_13 + iter_61_3)

				setImageAlpha(var_61_16, 1)
				setImageSprite(var_61_16, self.sprites[var_61_15])
			end
		end
	end

	return
end

function RyzaMiniGameView:startTimer()
	if not self.timer.running then
		self.timer:Start()
	end

	self.uiMgr:AttachStickOb(self.rtJoyStick)
	var_0_1(self.rtMain, 1)

	return
end

function RyzaMiniGameView:stopTimer()
	if self.timer.running then
		self.timer:Stop()
	end

	self.uiMgr:ClearStick()
	var_0_1(self.rtMain, 0)

	return
end

function RyzaMiniGameView:onTimer()
	self.countTime = self.countTime + RyzaMiniGameConfig.TIME_INTERVAL

	setText(self.rtTime, string.format("%02d:%02d", math.floor(self.countTime / 60), math.floor(self.countTime % 60)))
	self.responder:TimeFlow(RyzaMiniGameConfig.TIME_INTERVAL)

	for iter_67_0, iter_67_1 in pairs(self.reactorUIs) do
		iter_67_1.position = iter_67_0._tf.position
	end

	local var_67_0 = self.responder:GetJoyStick()

	if var_67_0.x ~= 0 or var_67_0.y ~= 0 then
		local var_67_1 = RyzaMiniGameConfig.ReSetDir(var_67_0)
		local var_67_2 = self.reactorUIs[self.responder.reactorRyza]:Find("dir")

		if var_67_1.x == 0 then
			setLocalEulerAngles(var_67_2, {
				z = var_67_1.y > 0 and 270 or 90
			})
		else
			setLocalEulerAngles(var_67_2, {
				z = math.atan2(-var_67_1.y, var_67_1.x) / math.pi * 180
			})
		end
	end

	return
end

function RyzaMiniGameView:OnApplicationPaused(arg_68_1)
	if arg_68_1 then
		-- block empty
	end

	return
end

function RyzaMiniGameView:onBackPressed()
	switch(self.status, {
		main = function()
			RyzaMiniGameView.super.onBackPressed(self)

			return
		end,
		countdown = function()
			return
		end,
		pause = function()
			self:openUI()
			self:resumeGame()

			return
		end,
		exit = function()
			self:openUI()
			self:resumeGame()

			return
		end,
		result = function()
			return
		end
	}, function()
		assert(self.gameStartFlag, "game start false")
		self:openUI("pause")

		return
	end)

	return
end

function RyzaMiniGameView:willExit()
	return
end

return RyzaMiniGameView
