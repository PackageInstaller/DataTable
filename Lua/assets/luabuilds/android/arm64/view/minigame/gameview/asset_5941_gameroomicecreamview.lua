local GameRoomIceCreamView = class("GameRoomIceCreamView", import("..BaseMiniGameView"))
local var_0_1 = "EVENT_ICE_FINISH"
local var_0_2 = "EVENT_UPDATE_WAIT_TIME"
local var_0_3 = 0.05
local var_0_4 = 2
local var_0_5 = {
	{
		6,
		10
	},
	{
		8,
		12
	},
	{
		10,
		14
	}
}
local var_0_6 = 60
local var_0_7 = {
	750,
	250,
	300
}
local var_0_8 = {
	200,
	100
}
local var_0_9 = {
	100,
	50,
	20
}
local var_0_10 = 20
local var_0_11 = {
	point_boost = 100,
	wait_time_boost = 2,
	bullet_time = {
		0.1,
		4,
		0.8,
		5
	}
}
local var_0_12 = {
	{
		1
	},
	{
		0,
		1
	},
	{
		1,
		0,
		2
	}
}
local var_0_13 = {
	{
		1
	},
	{
		2
	},
	{
		1,
		3
	}
}
local var_0_14 = {
	"A",
	"B",
	"C",
	"D"
}
local var_0_15 = {
	"H",
	"J",
	"K",
	"I"
}
local var_0_16

local function var_0_17(arg_1_0)
	if var_0_16 then
		var_0_16:Pause(not arg_1_0)
	elseif arg_1_0 then
		pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-icecream_topping", function(arg_2_0)
			assert(arg_2_0)

			var_0_16 = arg_2_0.playback

			return
		end)
	end

	return
end

function GameRoomIceCreamView:getUIName()
	return "GameRoomIceCreamUI"
end

function GameRoomIceCreamView:initTimer()
	self.timer = Timer.New(function()
		self:onTimer()

		return
	end, var_0_3, -1)

	return
end

function GameRoomIceCreamView:didEnter()
	self:initTimer()
	self:initUI()
	self:initGameUI()
	self:openMainUI()

	return
end

function GameRoomIceCreamView:initUI()
	self.clickMask = self._tf:Find("ui/click_mask")
	self.rtResource = self._tf:Find("Resource")
	self.mainUI = self._tf:Find("ui/main_ui")
	self.listScrollRect = GetComponent(self.mainUI:Find("right_panel/item_list/content"), typeof(ScrollRect))

	onButton(self, self.mainUI:Find("btn_back"), function()
		self:emit(GameRoomIceCreamView.ON_BACK_PRESSED)

		return
	end, SFX_PANEL)
	onButton(self, self.mainUI:Find("bg/btn_help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = self:getGameRoomData().game_help
		})

		return
	end, SFX_PANEL)
	onButton(self, self.mainUI:Find("bg/btn_start"), function()
		self:readyStart()

		return
	end, SFX_PANEL)

	self.totalTimes = self:getGameTotalTime()

	scrollTo(self.listScrollRect, 0, 1 - (self:getGameUsedTimes() - 4 < 0 and 0 or self:getGameUsedTimes() - 4) / (self.totalTimes - 4))
	onButton(self, self.mainUI:Find("right_panel/arrows_up"), function()
		scrollTo(self.listScrollRect, 0, (self.listScrollRect.normalizedPosition.y + 1 / (self.totalTimes - 4) > 1 or nil) and 1)

		return
	end, SFX_PANEL)
	onButton(self, self.mainUI:Find("right_panel/arrows_down"), function()
		scrollTo(self.listScrollRect, 0, (self.listScrollRect.normalizedPosition.y - 1 / (self.totalTimes - 4) < 0 or nil) and 0)

		return
	end, SFX_PANEL)

	local var_7_0 = pg.mini_game[self:GetMGData().id].simple_config_data.drop_ids
	local var_7_1 = self.mainUI:Find("right_panel/item_list/content")

	self.itemList = UIItemList.New(var_7_1, var_7_1:GetChild(0))

	self.itemList:make(function(arg_13_0, arg_13_1, arg_13_2)
		arg_13_1 = arg_13_1 + 1

		if arg_13_0 == UIItemList.EventUpdate then
			arg_13_2.name = arg_13_1

			GetImageSpriteFromAtlasAsync("ui/minigameui/icecreamgameui_atlas", "day_" .. arg_13_1, arg_13_2:Find("text"))

			local var_13_0 = arg_13_2:Find("IconTpl")
			local var_13_1 = {}

			var_13_1.type, var_13_1.id, var_13_1.count = unpack(var_7_0[arg_13_1])

			updateDrop(var_13_0, var_13_1)
			onButton(self, var_13_0, function()
				self:emit(GameRoomIceCreamView.ON_DROP, var_13_1)

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.itemList:align(#var_7_0)

	self.countUI = self._tf:Find("ui/count_ui")
	self.countAnimator = GetComponent(self.countUI:Find("count"), typeof(Animator))
	self.countDft = GetOrAddComponent(self.countUI:Find("count"), typeof(DftAniEvent))

	self.countDft:SetTriggerEvent(function()
		return
	end)
	self.countDft:SetEndEvent(function()
		setActive(self.countUI, false)
		self:startGame()

		return
	end)

	self.pauseUI = self._tf:Find("ui/pause_ui")

	onButton(self, self.pauseUI:Find("panel/btn_confirm"), function()
		pg.UIMgr.GetInstance():UnOverlayPanel(self.pauseUI, self._tf:Find("ui"))
		setActive(self.pauseUI, false)
		self:resumeGame()

		return
	end, SFX_PANEL)

	self.returnUI = self._tf:Find("ui/return_ui")

	onButton(self, self.returnUI:Find("panel/btn_confirm"), function()
		pg.UIMgr.GetInstance():UnOverlayPanel(self.returnUI, self._tf:Find("ui"))
		setActive(self.returnUI, false)
		self:resumeGame()
		self:endGame()

		return
	end, SFX_PANEL)
	onButton(self, self.returnUI:Find("panel/btn_cancel"), function()
		pg.UIMgr.GetInstance():UnOverlayPanel(self.returnUI, self._tf:Find("ui"))
		setActive(self.returnUI, false)
		self:resumeGame()

		return
	end, SFX_PANEL)

	self.endUI = self._tf:Find("ui/end_ui")

	onButton(self, self.endUI:Find("panel/btn_finish"), function()
		pg.UIMgr.GetInstance():UnOverlayPanel(self.endUI, self._tf:Find("ui"))
		setActive(self.endUI, false)
		self:openMainUI()

		return
	end, SFX_PANEL)

	self.handle = self.handle or UpdateBeat:CreateListener(self.Update, self)

	UpdateBeat:AddListener(self.handle)

	return
end

function GameRoomIceCreamView:Update()
	return
end

function GameRoomIceCreamView:initGameUI()
	self.gameUI = self._tf:Find("ui/game_ui")
	self.timeTF = self.gameUI:Find("Score/time/Text")
	self.scoreTF = self.gameUI:Find("Score/point/Text")
	self.addScoreTF = self.gameUI:Find("Score/add_score")

	onButton(self, self.gameUI:Find("Button/btn_pause"), function()
		self:pauseGame()
		pg.UIMgr.GetInstance():OverlayPanel(self.pauseUI)
		setActive(self.pauseUI, true)

		return
	end)
	onButton(self, self.gameUI:Find("Button/btn_back"), function()
		self:pauseGame()
		pg.UIMgr.GetInstance():OverlayPanel(self.returnUI)
		setActive(self.returnUI, true)

		return
	end)

	self.rtWalk = self.gameUI:Find("Walk")
	self.rtMake = self.gameUI:Find("Make")
	self.rtTime = self.gameUI:Find("Time")
	self.rtButton = self.gameUI:Find("Button")

	for iter_22_0 = 1, 4 do
		onButton(self, self.rtButton:Find("L" .. iter_22_0), function()
			if not self.iceBuild or self.iceBuild.isLeftLock then
				return
			end

			if #self.iceBuild._info[1] == #self.targetList[self.targetIndex]._info[1] then
				return
			end

			self.iceBuild:MakeBall(iter_22_0)

			return
		end)
		onButton(self, self.rtButton:Find("R" .. iter_22_0), function()
			if not self.iceBuild or self.iceBuild.isRightLock then
				return
			end

			local var_26_0 = self.targetList[self.targetIndex]._info

			if #self.iceBuild._info[2] == #self.targetList[self.targetIndex]._info[2] then
				return
			end

			if not self.iceBuild._info[1][var_0_13[#var_26_0[1]][#self.iceBuild._info[2] + 1]] then
				self.iceBuild:MakeMissTopping(iter_22_0)
			else
				self.iceBuild:MakeTopping(iter_22_0)
			end

			return
		end)
	end

	self:bind(var_0_1, function(arg_27_0, ...)
		self:ResultTarget(...)

		return
	end)
	self:bind(var_0_2, function(arg_28_0, arg_28_1, ...)
		eachChild(self.rtTime, function(arg_29_0)
			setActive(arg_29_0, arg_29_0.name == arg_28_1)

			return
		end)
		setSlider(self.rtTime:Find(arg_28_1), ...)

		return
	end)

	return
end

function GameRoomIceCreamView:updateMainUI()
	local var_30_0 = self:getGameUsedTimes()
	local var_30_1 = self:getGameTimes()
	local var_30_2 = self.itemList.container

	for iter_30_0 = 1, self.itemList.container.childCount do
		local var_30_3 = {
			award = true
		}

		if iter_30_0 <= var_30_0 then
			var_30_3.finish = true
		elseif iter_30_0 == var_30_0 + 1 and var_30_1 >= 1 then
			-- block empty
		elseif var_30_0 < iter_30_0 and iter_30_0 <= var_30_0 + var_30_1 then
			-- block empty
		else
			var_30_3.lock = true
			var_30_3.award = false
		end

		local var_30_4 = var_30_2:GetChild(iter_30_0 - 1)

		setActive(var_30_4:Find("finish"), var_30_3.finish)
		setActive(var_30_4:Find("lock"), var_30_3.lock)
		setActive(var_30_4:Find("IconTpl"), var_30_3.award)
	end

	self.totalTimes = self:getGameTotalTime()

	local var_30_5 = 1 - (self:getGameUsedTimes() - 3 < 0 and 0 or self:getGameUsedTimes() - 3) / (self.totalTimes - 4)

	if var_30_5 > 1 then
		var_30_5 = 1
	end

	scrollTo(self.listScrollRect, 0, var_30_5)
	self:checkGet()

	return
end

function GameRoomIceCreamView:checkGet()
	if self:getUltimate() == 0 then
		if self:getGameTotalTime() > self:getGameUsedTimes() then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = self:GetMGHubData().id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
	end

	return
end

function GameRoomIceCreamView:openMainUI()
	setActive(self.gameUI, false)
	setActive(self.mainUI, true)
	self:openCoinLayer(true)
	self:updateMainUI()

	return
end

function GameRoomIceCreamView:readyStart()
	setActive(self.mainUI, false)
	setActive(self.countUI, true)
	self.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/ddldaoshu2")
	self:resetGame()
	self:openCoinLayer(false)

	return
end

function GameRoomIceCreamView:resetGame()
	self.gameStartFlag = false
	self.gamePause = false
	self.gameEndFlag = false
	self.scoreNum = 0
	self.lastTime = var_0_6
	self.targetNameList = {}
	self.targetList = {}
	self.iceBuild = nil
	self.countList = {
		0,
		0,
		0
	}
	self.effectTrigger = {
		bullet_time = {
			doingTime = 0,
			waitTime = 0
		},
		wait_time_boost = {
			count = 0
		},
		point_boost = {}
	}

	eachChild(self.rtResource:Find("Character"), function(arg_35_0)
		table.insert(self.targetNameList, arg_35_0.name)

		return
	end)
	removeAllChildren(self.rtWalk)
	setActive(self.gameUI:Find("BulletTimeMask"), false)
	setActive(self.rtMake, false)
	setActive(self.rtTime, false)
	setText(self.scoreTF, self.scoreNum)
	setActive(self.addScoreTF, false)
	self:setAnimatorSpeed(self._tf, 1)

	return
end

local function var_0_18(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	local var_36_0 = {}

	local function var_36_1(arg_37_0, arg_37_1)
		for iter_37_0 = math.max(#arg_37_1[1], 2), 1, -1 do
			setActive(arg_37_0:Find(iter_37_0), arg_37_1[1][iter_37_0])

			if arg_37_1[1][iter_37_0] then
				local var_37_0 = arg_37_0:Find(iter_37_0)

				GetImageSpriteFromAtlasAsync("ui/minigameui/icecreamgameui_atlas", var_0_14[arg_37_1[1][iter_37_0]], var_37_0:Find("Scoop"), true)
				setActive(var_37_0:Find("Topping"), arg_37_1[2][var_0_12[#arg_37_1[1]][iter_37_0]])

				if arg_37_1[2][var_0_12[#arg_37_1[1]][iter_37_0]] then
					GetImageSpriteFromAtlasAsync("ui/minigameui/icecreamgameui_atlas", var_0_15[arg_37_1[2][var_0_12[#arg_37_1[1]][iter_37_0]]], var_37_0:Find("Topping"), true)
				end
			end
		end

		return
	end

	function var_36_0:Ctor()
		self._tf = arg_36_0
		self._event = arg_36_1
		self._info = arg_36_2
		self.time = arg_36_3
		self.pointBoost = 100
		self.result = nil

		local var_38_0 = #arg_36_2[1] < 3 and "Cone" or "Bowl"

		for iter_38_0, iter_38_1 in ipairs({
			"IceCream",
			"Bubble",
			"BadCream"
		}) do
			eachChild(arg_36_0:Find(iter_38_1), function(arg_39_0)
				setActive(arg_39_0, arg_39_0.name == var_38_0)

				return
			end)
		end

		var_36_1(arg_36_0:Find("Bubble/" .. var_38_0), arg_36_2)
		GetImageSpriteFromAtlasAsync("ui/minigameui/icecreamgameui_atlas", "bubble_" .. #arg_36_2[1], arg_36_0:Find("Bubble"), true)
		setActive(arg_36_0:Find("Bubble/Boost"), false)

		self.animator = GetComponent(self._tf, typeof(Animator))

		self._tf:GetComponent(typeof(DftAniEvent)):SetTriggerEvent(function()
			self.isLeave = true

			return
		end)

		return
	end

	function var_36_0:Result(arg_41_1, arg_41_2)
		self.result = arg_41_1

		local var_41_0 = #arg_41_2[1] < 3 and "Cone" or "Bowl"

		if arg_41_1 == 0 then
			self.animator:Play("Bad")
		elseif arg_41_1 == 1 then
			var_36_1(self._tf:Find("IceCream/" .. var_41_0), arg_41_2)
			self.animator:Play("Hmm")
		elseif arg_41_1 >= 2 then
			var_36_1(self._tf:Find("IceCream/" .. var_41_0), arg_41_2)
			self.animator:Play("Great")
		else
			assert(false)
		end

		return
	end

	var_36_0:Ctor()

	return var_36_0
end

function GameRoomIceCreamView:CreateTarget(arg_42_1)
	local var_42_0 = table.remove(self.targetNameList, math.random(#self.targetNameList))
	local var_42_1 = cloneTplTo(self.rtResource:Find("Character/" .. var_42_0), self.rtWalk, var_42_0)

	setAnchoredPosition(var_42_1, {
		x = arg_42_1 or -var_0_7[1]
	})

	local var_42_2 = {
		{},
		{}
	}
	local var_42_3 = var_42_0 == "Agir" and {
		1,
		2
	} or {
		1,
		2,
		3
	}

	if #self.targetList > 0 then
		table.removebyvalue(var_42_3, #self.targetList[#self.targetList]._info[1])
	end

	for iter_42_0 = var_42_3[math.random(#var_42_3)], 1, -1 do
		table.insert(var_42_2[1], math.random(4))
	end

	local var_42_4 = {
		1,
		2,
		3,
		4
	}

	for iter_42_1 = math.max(1, #var_42_2[1] - 1), 1, -1 do
		table.insert(var_42_2[2], table.remove(var_42_4, math.random(#var_42_4)))
	end

	self.countList[#var_42_2[1]] = self.countList[#var_42_2[1]] + 1

	table.insert(self.targetList, var_0_18(var_42_1, self, var_42_2, (math.clamp(var_0_5[#var_42_2[1]][2] - self.countList[#var_42_2[1]], unpack(var_0_5[#var_42_2[1]])))))

	return
end

function GameRoomIceCreamView:RemoveTarget()
	assert(#self.targetList > 0)

	local var_43_0 = table.remove(self.targetList, 1)

	self.targetIndex = self.targetIndex - 1

	table.insert(self.targetNameList, var_43_0._tf.name)
	Destroy(var_43_0._tf)

	return
end

function GameRoomIceCreamView:ResultTarget(arg_44_1, arg_44_2, ...)
	assert(#self.targetList > 0)

	arg_44_1 = math.ceil(arg_44_1 * self.targetList[self.targetIndex].pointBoost / 100)

	self:addScore(arg_44_1, arg_44_2)
	self.targetList[self.targetIndex]:Result(arg_44_2, ...)
	self:TriggerSpecialEffect(arg_44_2, ...)

	self.targetIndex = self.targetIndex + 1
	self.iceBuild = nil

	onNextTick(function()
		setActive(self.rtMake, false)
		setActive(self.rtTime, false)

		return
	end)

	if self.effectTrigger.bullet_time.doingTime > 0 then
		self.effectTrigger.bullet_time.doingTime = 0

		self:setAnimatorSpeed(self._tf, 1)
		setActive(self.gameUI:Find("BulletTimeMask"), false)
	end

	return
end

function GameRoomIceCreamView:TriggerSpecialEffect(arg_46_1, arg_46_2)
	if arg_46_1 == 3 then
		if #self.targetList[self.targetIndex]._info[1] == 3 and self.effectTrigger.bullet_time.waitTime <= 0 and math.random() < var_0_11.bullet_time[3] then
			self.targetList[self.targetIndex + 1].timeBoost = true
		end

		local var_46_0 = self.effectTrigger.wait_time_boost

		var_46_0.count = self.effectTrigger.wait_time_boost.count + 1

		if var_46_0.count == 2 then
			var_46_0.count = 0
			self.targetList[self.targetIndex + 1].time = self.targetList[self.targetIndex + 1].time + var_0_11.wait_time_boost
			self.targetList[self.targetIndex + 1].isWaitTimeBoost = true
		end

		local var_46_1 = self.effectTrigger.point_boost

		if self.effectTrigger.point_boost[self.targetList[self.targetIndex]._tf.name] == "finish" then
			-- block empty
		elseif var_46_1[self.targetList[self.targetIndex]._tf.name] == "count" then
			self.targetList[self.targetIndex + 1].pointBoost = self.targetList[self.targetIndex + 1].pointBoost + var_0_11.point_boost

			setActive(self.targetList[self.targetIndex + 1]._tf:Find("Bubble/Boost"), true)

			var_46_1[self.targetList[self.targetIndex]._tf.name] = "finish"
		else
			var_46_1[self.targetList[self.targetIndex]._tf.name] = "count"
		end
	elseif self.effectTrigger.point_boost[self.targetList[self.targetIndex]._tf.name] == "finish" then
		-- block empty
	else
		self.effectTrigger.point_boost[self.targetList[self.targetIndex]._tf.name] = nil
	end

	return
end

local function var_0_19(arg_47_0, arg_47_1, arg_47_2, arg_47_3, arg_47_4)
	local var_47_0 = {
		Ctor = function(self)
			self._tf = arg_47_0
			self._event = arg_47_1
			self._info = {
				{},
				{}
			}
			self.isLeftLock = false
			self.isRightLock = false
			self.missToppingMark = {}
			self.waitTime = arg_47_3
			self.isWaitTimeBoost = arg_47_4

			self:Reset()
			self:NextDeal()

			return
		end,
		NextDeal = function(self)
			if self.isLeftLock or self.isRightLock then
				return
			end

			if #self._info[1] < #arg_47_2[1] then
				self:ReadyBall()
			elseif #self._info[2] < #arg_47_2[2] then
				self:ReadyTopping()
			else
				self:Result()
			end

			return
		end,
		Result = function(self, arg_50_1)
			self.isResulted = true

			var_0_17(false)

			local var_50_0 = 0
			local var_50_1 = {
				{
					0,
					0,
					0,
					0
				},
				{
					0,
					0,
					0,
					0
				}
			}

			local function var_50_2(arg_51_0, arg_51_1, arg_51_2)
				arg_51_0[arg_51_1] = arg_51_0[arg_51_1] + arg_51_2

				return math.abs(arg_51_0[arg_51_1]) - math.abs(arg_51_0[arg_51_1])
			end

			for iter_50_0, iter_50_1 in ipairs(self._info) do
				for iter_50_2, iter_50_3 in ipairs(iter_50_1) do
					if var_50_2(var_50_1[iter_50_0], arg_47_2[iter_50_0][iter_50_2], -1) < 0 then
						var_50_0 = var_50_0 + var_0_9[iter_50_0]
					end

					if var_50_2(var_50_1[iter_50_0], iter_50_3, 1) < 0 then
						var_50_0 = var_50_0 + var_0_9[iter_50_0]
					end

					if arg_47_2[iter_50_0][iter_50_2] == iter_50_3 and (iter_50_0 == 1 or not self.missToppingMark[iter_50_2]) then
						var_50_0 = var_50_0 + var_0_9[3]
					end
				end
			end

			self.result = arg_50_1 and arg_50_1 or var_50_0 == #self._info[1] * var_0_9[1] + #self._info[2] * var_0_9[2] + (#self._info[1] + #self._info[2]) * var_0_9[3] and 3 or table.equal(self._info, arg_47_2) and 2 or var_50_0 >= (#self._info[1] * var_0_9[1] + #self._info[2] * var_0_9[2] + (#self._info[1] + #self._info[2]) * var_0_9[3]) / 2 and 1 or 0

			local var_50_3 = self._tf:GetComponent(typeof(Animator))

			if self.result == 3 then
				self.point = var_50_0 * (1 + var_0_10 / 100 + self.waitTime / arg_47_3)

				var_50_3:Play("Perfect")
				pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-icecream_great")
			elseif self.result == 2 then
				self.point = var_50_0 * (1 + self.waitTime / arg_47_3)

				var_50_3:Play("Pass")
			elseif self.result == 1 then
				self.point = var_50_0 * (1 + self.waitTime / arg_47_3)

				var_50_3:Play("Pass")
			elseif self.result == 0 then
				self.point = 0

				var_50_3:Play("Fail")
				pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-icecream_fail")
			else
				assert(false)
			end

			return
		end,
		CountDown = function(self, arg_52_1, arg_52_2)
			if self.isResulted then
				return
			end

			if self.waitTime > 0 then
				self.waitTime = self.waitTime - arg_52_1

				self._event:emit(var_0_2, arg_52_2, 0, arg_47_3, self.waitTime)
			else
				self.waitTime = 0

				self:Result(0)
			end

			if not self.missTime then
				return
			end

			if self.missTime > 0 then
				self.missTime = self.missTime - var_0_3
			else
				self.missTime = nil

				self:FailMissTopping()
			end

			return
		end,
		Reset = function(self)
			self._tf:GetComponent("DftAniEvent"):SetEndEvent(function()
				onNextTick(function()
					setActive(self._tf, false)

					return
				end)
				self._event:emit(var_0_1, self.point, self.result, self._info)

				return
			end)
			self._tf:GetComponent("DftAniEvent"):SetTriggerEvent(function()
				for iter_56_0 = self._tf.name == "Cone" and 2 or 3, 1, -1 do
					setActive(self._tf:Find(iter_56_0), false)
				end

				setActive(self._tf:Find("Back"), false)

				if self._tf.name == "Bowl" then
					setActive(self._tf:Find("Front"), false)
				end

				return
			end)
			setActive(self._tf:Find("Back"), true)

			if self._tf.name == "Bowl" then
				setActive(self._tf:Find("Front"), true)
			end

			for iter_53_0 = self._tf.name == "Cone" and 2 or 3, 1, -1 do
				local var_53_0 = self._tf:Find(iter_53_0)

				setActive(var_53_0, iter_53_0 <= #arg_47_2[1])

				if iter_53_0 <= #arg_47_2[1] then
					eachChild(var_53_0, function(arg_57_0)
						setActive(arg_57_0, false)

						return
					end)
					var_53_0:Find("Scoop"):GetComponent("DftAniEvent"):SetEndEvent(function()
						self.isLeftLock = false

						if self.successLeftLight then
							self.successLeftLight = false

							setAnchoredPosition(var_53_0:Find("Good"), {
								x = 0,
								y = -10
							})
							setActive(var_53_0:Find("Good"), false)
							setActive(var_53_0:Find("Good"), true)
						end

						self:NextDeal()

						return
					end)
					var_53_0:Find("Topping"):GetComponent("DftAniEvent"):SetEndEvent(function()
						self.isRightLock = false

						if self.successRightLight then
							self.successRightLight = false

							setAnchoredPosition(var_53_0:Find("Good"), {
								x = 10,
								y = 6
							})
							setActive(var_53_0:Find("Good"), false)
							setActive(var_53_0:Find("Good"), true)
						end

						self:NextDeal()

						return
					end)
				end
			end

			return
		end,
		ReadyBall = function(self)
			setActive(self._tf:Find(#self._info[1] + 1):Find("Scoop_Next"), true)

			return
		end,
		MakeBall = function(self, arg_61_1)
			self.isLeftLock = true

			local var_61_0 = self._tf:Find(#self._info[1] + 1)

			setActive(var_61_0:Find("Scoop_Next"), false)
			setActive(var_61_0:Find("Scoop"), true)
			var_61_0:Find("Scoop"):GetComponent(typeof(Animator)):Play("Scoop_" .. var_0_14[arg_61_1])
			table.insert(self._info[1], arg_61_1)

			self.successLeftLight = self._info[1][#self._info[1]] == arg_47_2[1][#self._info[1]]

			if self.temporaryKey and var_0_13[#arg_47_2[1]][#self._info[2] + 1] == #self._info[1] then
				self:SafeMissTopping()
			end

			pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-icecream_flavour")

			return
		end,
		ReadyTopping = function(self)
			setActive(self._tf:Find(var_0_13[#arg_47_2[1]][#self._info[2] + 1]):Find("Topping_Next"), true)

			return
		end,
		MakeTopping = function(self, arg_63_1)
			self.isRightLock = true

			local var_63_0 = self._tf:Find(var_0_13[#arg_47_2[1]][#self._info[2] + 1])

			setActive(var_63_0:Find("Topping_Next"), false)
			setActive(var_63_0:Find("Topping"), true)
			var_63_0:Find("Topping"):GetComponent(typeof(Animator)):Play("Topping_" .. var_0_15[arg_63_1])
			table.insert(self._info[2], arg_63_1)

			self.successRightLight = self._info[2][#self._info[2]] == arg_47_2[2][#self._info[2]]

			pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-icecream_mixer")

			return
		end,
		MakeMissTopping = function(self, arg_64_1)
			self.isRightLock = true
			self.temporaryKey = arg_64_1
			self.missTime = var_0_4 * (var_0_13[#arg_47_2[1]][#self._info[2] + 1] - #self._info[1])

			var_0_17(true)

			local var_64_0 = self._tf:Find(var_0_13[#arg_47_2[1]][#self._info[2] + 1])

			setActive(var_64_0:Find("Topping_Next"), false)
			setActive(var_64_0:Find("Topping"), true)
			var_64_0:Find("Topping"):GetComponent(typeof(Animator)):Play("Topping_pre_" .. var_0_15[arg_64_1])

			return
		end,
		FailMissTopping = function(self)
			self.isRightLock = true
			self.temporaryKey = nil
			self.missTime = nil

			var_0_17(false)

			local var_65_0 = self._tf:Find(var_0_13[#arg_47_2[1]][#self._info[2] + 1])

			setActive(var_65_0:Find("Topping_Next"), false)
			setActive(var_65_0:Find("Topping"), true)
			var_65_0:Find("Topping"):GetComponent(typeof(Animator)):Play("Topping_Err_" .. var_0_15[self.temporaryKey])

			return
		end,
		SafeMissTopping = function(self)
			self.isRightLock = true
			self.temporaryKey = nil
			self.missTime = nil

			var_0_17(false)

			local var_66_0 = self._tf:Find(var_0_13[#arg_47_2[1]][#self._info[2] + 1])

			setActive(var_66_0:Find("Topping_Next"), false)
			setActive(var_66_0:Find("Topping"), true)
			var_66_0:Find("Topping"):GetComponent(typeof(Animator)):Play("Topping_safe_" .. var_0_15[self.temporaryKey])
			table.insert(self._info[2], self.temporaryKey)

			self.successRightLight = self._info[2][#self._info[2]] == arg_47_2[2][#self._info[2]]
			self.missToppingMark[#self._info[2]] = true

			pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-icecream_mixer")

			return
		end
	}

	var_47_0:Ctor()

	return var_47_0
end

function GameRoomIceCreamView:DoIceCream()
	setActive(self.rtTime, true)
	setActive(self.rtMake, true)

	local var_67_0 = self.targetList[self.targetIndex]
	local var_67_1 = #self.targetList[self.targetIndex]._info[1] < 3 and "Cone" or "Bowl"

	eachChild(self.rtMake, function(arg_68_0)
		setActive(arg_68_0, arg_68_0.name == var_67_1)

		return
	end)

	local var_67_2 = self.rtMake:Find(var_67_1)

	for iter_67_0 = var_67_1 == "Cone" and 2 or 3, 1, -1 do
		setActive(var_67_2:Find(iter_67_0), false)
	end

	self.iceBuild = var_0_19(var_67_2, self, var_67_0._info, var_67_0.time, var_67_0.isWaitTimeBoost)

	if var_67_0.timeBoost then
		self.effectTrigger.bullet_time.doingTime = var_0_11.bullet_time[2]
		self.effectTrigger.bullet_time.waitTime = var_0_11.bullet_time[4]

		self:setAnimatorSpeed(self._tf, 0.5)
		self:setAnimatorSpeed(self.rtMake, 1)
		setActive(self.gameUI:Find("BulletTimeMask"), true)
	end

	return
end

function GameRoomIceCreamView:startGame()
	setActive(self.gameUI, true)

	self.gameStartFlag = true

	self:CreateTarget(-var_0_7[1] / 3)

	self.targetIndex = 1

	self:RandomBG()
	self:timerStart()

	return
end

function GameRoomIceCreamView:RandomBG()
	self.poolBG = self.poolBG or {
		GroupD = {
			1
		}
	}

	if not self.poolBG.GroupAB or #self.poolBG.GroupAB == 0 then
		self.poolBG.GroupAB = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	if not self.poolBG["GroupC/Other"] or #self.poolBG["GroupC/Other"] == 0 then
		self.poolBG["GroupC/Other"] = {
			1,
			2,
			3,
			4
		}
	end

	self.poolBG["GroupC/Manjuu"] = {
		1,
		2,
		3
	}

	for iter_70_0, iter_70_1 in pairs(self.poolBG) do
		local var_70_0 = {}

		for iter_70_2 = iter_70_0 == "GroupC/Manjuu" and 2 or 1, 1, -1 do
			if iter_70_0 == "GroupD" then
				var_70_0[iter_70_1[1]] = true
				iter_70_1[1] = 3 - iter_70_1[1]
			else
				var_70_0[table.remove(iter_70_1, math.random(#iter_70_1))] = true
			end
		end

		local var_70_1 = self.gameUI:Find("BG/" .. iter_70_0)

		for iter_70_3 = var_70_1.childCount, 1, -1 do
			setActive(var_70_1:GetChild(iter_70_3 - 1), var_70_0[iter_70_3])
		end
	end

	return
end

function GameRoomIceCreamView:getIntervalTime()
	if self.effectTrigger.bullet_time.doingTime > 0 then
		return var_0_3 * var_0_11.bullet_time[1]
	else
		return var_0_3
	end

	return
end

function GameRoomIceCreamView:onTimer()
	local var_72_0 = self.effectTrigger.bullet_time

	if self.effectTrigger.bullet_time.doingTime > 0 then
		var_72_0.doingTime = var_72_0.doingTime - var_0_3

		if var_72_0.doingTime <= 0 then
			self:setAnimatorSpeed(self._tf, 1)
			setActive(self.gameUI:Find("BulletTimeMask"), false)
		end
	elseif var_72_0.waitTime > 0 then
		var_72_0.waitTime = var_72_0.waitTime - var_0_3
	end

	self.lastTime = self.lastTime - self:getIntervalTime()

	self:updateWalker()

	if self.lastTime <= 0 then
		self:endGame()
	else
		setText(self.timeTF, math.floor(self.lastTime))

		if not self.iceBuild and self.targetList[self.targetIndex]._tf.anchoredPosition.x > 0 then
			self:DoIceCream()
		end

		if #self.targetList == self.targetIndex then
			self:CreateTarget()
		end
	end

	if self.iceBuild then
		self.iceBuild:CountDown(self:getIntervalTime(), var_72_0.doingTime > 0 and "frozen" or self.iceBuild.isWaitTimeBoost and "extend" or "base")
	end

	return
end

function GameRoomIceCreamView:updateWalker()
	for iter_73_0 = #self.targetList, 1, -1 do
		local var_73_0 = self.targetList[iter_73_0]._tf:GetComponent(typeof(Animator))
		local var_73_1 = var_73_0:GetCurrentAnimatorStateInfo(0)

		if self.targetList[iter_73_0].result then
			if self.targetList[iter_73_0].isLeave then
				setAnchoredPosition(self.targetList[iter_73_0]._tf, {
					x = self.targetList[iter_73_0]._tf.anchoredPosition.x + self:getIntervalTime() * var_0_8[1]
				})

				if self.targetList[iter_73_0]._tf.anchoredPosition.x > var_0_7[1] then
					self:RemoveTarget()
				end
			end
		else
			local var_73_2 = var_0_7[3]

			if iter_73_0 > 1 then
				var_73_2 = math.min(var_73_2, self.targetList[iter_73_0 - 1]._tf.anchoredPosition.x)
			end

			local var_73_3 = var_73_2 - self.targetList[iter_73_0]._tf.anchoredPosition.x

			if var_73_2 - self.targetList[iter_73_0]._tf.anchoredPosition.x < var_0_7[3] then
				if not self.targetList[iter_73_0].state or self.targetList[iter_73_0].state ~= "Stand" then
					self.targetList[iter_73_0].state = "Stand"

					var_73_0:Play("Stand")
				end
			elseif var_73_3 < var_0_7[2] then
				setAnchoredPosition(self.targetList[iter_73_0]._tf, {
					x = self.targetList[iter_73_0]._tf.anchoredPosition.x + self:getIntervalTime() * var_0_8[2]
				})

				if not self.targetList[iter_73_0].state or self.targetList[iter_73_0].state ~= "Walk" then
					self.targetList[iter_73_0].state = "Walk"

					var_73_0:Play("Walk")
				end
			else
				setAnchoredPosition(self.targetList[iter_73_0]._tf, {
					x = self.targetList[iter_73_0]._tf.anchoredPosition.x + self:getIntervalTime() * var_0_8[1]
				})

				if not self.targetList[iter_73_0].state or self.targetList[iter_73_0].state ~= "Run" then
					self.targetList[iter_73_0].state = "Run"

					var_73_0:Play("Run")
				end
			end
		end
	end

	return
end

function GameRoomIceCreamView:setAnimatorSpeed(arg_74_1, arg_74_2)
	for iter_74_0, iter_74_1 in ipairs((arg_74_1:GetComponentsInChildren(typeof(Animator), true):ToTable())) do
		iter_74_1.speed = arg_74_2
	end

	return
end

function GameRoomIceCreamView:timerStart()
	if not self.timer.running then
		self.timer:Start()
	end

	if self.effectTrigger.bullet_time.doingTime > 0 then
		self:setAnimatorSpeed(self._tf, 0.5)
		self:setAnimatorSpeed(self.rtMake, 1)
	else
		self:setAnimatorSpeed(self._tf, 1)
	end

	if self.iceBuild and self.iceBuild.missTime then
		var_0_17(true)
	end

	return
end

function GameRoomIceCreamView:timerStop()
	if self.timer.running then
		self.timer:Stop()
	end

	self:setAnimatorSpeed(self._tf, 0)

	if self.iceBuild and self.iceBuild.missTime then
		var_0_17(false)
	end

	return
end

function GameRoomIceCreamView:addScore(arg_77_1, arg_77_2)
	self.scoreNum = self.scoreNum + arg_77_1

	setText(self.scoreTF, self.scoreNum)
	setActive(self.addScoreTF, false)
	setActive(self.addScoreTF, true)

	local var_77_0 = self.addScoreTF:Find("score_tf")

	setText(var_77_0, "+" .. arg_77_1)

	if arg_77_2 == 0 then
		setTextColor(var_77_0, Color.NewHex("ED666DFF"))
	elseif arg_77_2 == 1 then
		setTextColor(var_77_0, Color.NewHex("FAB149FF"))
	elseif arg_77_2 == 2 then
		setTextColor(var_77_0, Color.NewHex("C6CC15FF"))
	elseif arg_77_2 == 3 then
		setTextColor(var_77_0, Color.NewHex("80BF1CFF"))
	else
		assert(false)
	end

	return
end

function GameRoomIceCreamView:pauseGame()
	self.gamePause = true

	self:timerStop()
	self:pauseManagedTween()

	return
end

function GameRoomIceCreamView:resumeGame()
	self.gamePause = false

	self:timerStart()
	self:resumeManagedTween()

	return
end

function GameRoomIceCreamView:endGame()
	if self.gameEndFlag then
		return
	end

	self:timerStop()

	self.gameEndFlag = true

	setActive(self.clickMask, true)
	self:managedTween(LeanTween.delayedCall, function()
		self.gameEndFlag = false
		self.gameStartFlag = false

		setActive(self.clickMask, false)
		self:showEndUI()

		return
	end, 0.1, nil)

	return
end

function GameRoomIceCreamView:showEndUI()
	pg.UIMgr.GetInstance():OverlayPanel(self.endUI)
	setActive(self.endUI, true)

	local var_82_0 = self.scoreNum
	local var_82_1 = getProxy(GameRoomProxy):getRoomScore(self:getGameRoomData().id)

	setActive(self.endUI:Find("panel/now/Text/new"), var_82_1 < self.scoreNum)

	if var_82_1 <= var_82_0 then
		var_82_1 = var_82_0

		self:StoreDataToServer({
			var_82_0
		})
	end

	setText(self.endUI:Find("panel/max/Text"), var_82_1)
	setText(self.endUI:Find("panel/now/Text"), var_82_0)
	self:SendSuccess(var_82_0)

	return
end

function GameRoomIceCreamView:getGameTimes()
	return self:GetMGHubData().count
end

function GameRoomIceCreamView:getGameUsedTimes()
	return self:GetMGHubData().usedtime
end

function GameRoomIceCreamView:getUltimate()
	return self:GetMGHubData().ultimate
end

function GameRoomIceCreamView:getGameTotalTime()
	return (self:GetMGHubData():getConfig("reward_need"))
end

function GameRoomIceCreamView:OnApplicationPaused(arg_87_1)
	if arg_87_1 and not self.gameEndFlag and self.gameStartFlag and not self.gamePause then
		self:pauseGame()
		pg.UIMgr.GetInstance():OverlayPanel(self.pauseUI)
		setActive(self.pauseUI, true)
	end

	return
end

function GameRoomIceCreamView:onBackPressed()
	if self.gameEndFlag then
		return
	end

	if isActive(self.pauseUI) then
		pg.UIMgr.GetInstance():UnOverlayPanel(self.pauseUI, self._tf:Find("ui"))
		setActive(self.pauseUI, false)
		self:resumeGame()

		return
	end

	if isActive(self.returnUI) then
		pg.UIMgr.GetInstance():UnOverlayPanel(self.returnUI, self._tf:Find("ui"))
		setActive(self.returnUI, false)
		self:resumeGame()

		return
	end

	if isActive(self.endUI) then
		return
	end

	if self.gameStartFlag then
		self:pauseGame()
		pg.UIMgr.GetInstance():OverlayPanel(self.pauseUI)
		setActive(self.pauseUI, true)

		return
	end

	self:emit(GameRoomIceCreamView.ON_BACK_PRESSED)

	return
end

function GameRoomIceCreamView:willExit()
	if self.handle then
		UpdateBeat:RemoveListener(self.handle)
	end

	self:cleanManagedTween()

	if self.timer and self.timer.running then
		self.timer:Stop()
	end

	Time.timeScale = 1
	self.timer = nil

	return
end

return GameRoomIceCreamView
