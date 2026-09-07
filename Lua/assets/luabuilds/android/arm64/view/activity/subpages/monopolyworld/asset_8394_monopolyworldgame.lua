local MonopolyWorldGame = class("MonopolyWorldGame")
local var_0_1 = 117
local var_0_2 = 60
local var_0_3 = {
	{
		0,
		4007,
		4008,
		4009,
		4010,
		0
	},
	{
		4005,
		4006,
		0,
		0,
		4011,
		4012
	},
	{
		4004,
		0,
		0,
		0,
		0,
		4013
	},
	{
		4003,
		4002,
		0,
		0,
		4015,
		4014
	},
	{
		0,
		4001,
		4018,
		4017,
		4016,
		0
	}
}
local var_0_4 = "mengya"
local var_0_5 = "monopoly_world_tip1"
local var_0_6 = "monopoly_world_tip2"
local var_0_7 = "monopoly_world_tip3"
local var_0_8 = 0.6
local var_0_9 = "dafuweng_gold"
local var_0_10 = "dafuweng_oil"
local var_0_11 = "dafuweng_event"
local var_0_12 = "dafuweng_walk"
local var_0_13 = "dafuweng_stand"
local var_0_14 = "dafuweng_walk"
local var_0_15 = "dafuweng_run"
local var_0_16 = "dafuweng_touch"
local var_0_17 = "cell gold"
local var_0_18 = "cell move"
local var_0_19 = "cell oil"
local var_0_20 = "cell event"
local var_0_21 = "cell item"
local var_0_22 = {}
local var_0_23 = {
	name = "gulitemengya_1",
	path_length = 1
}

var_0_23.cell_type = "cell move"
var_0_22[1] = var_0_23
var_0_22[2] = {
	name = "gulitemengya_2",
	path_length = 2,
	cell_type = "cell move"
}
var_0_22[3] = {
	name = "gulitemengya_3",
	path_length = 3,
	cell_type = "cell move"
}
var_0_22[4] = {
	name = "gulitemengya_daoju",
	cell_type = "cell item"
}
var_0_22[5] = {
	name = "gulitemengya_jinbi",
	cell_type = "cell gold"
}
var_0_22[6] = {
	name = "gulitemengya_mingyun",
	cell_type = "cell event"
}
var_0_22[7] = {
	name = "gulitemengya_shiyou",
	cell_type = "cell oil"
}

local var_0_24 = {
	84180,
	84181,
	84183,
	84179,
	84182
}
local var_0_25
local var_0_26

function MonopolyWorldGame:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._binder = arg_1_1
	self._tf = arg_1_2
	self._event = arg_1_3

	self:initData()
	self:initUI()
	self:initEvent()

	return
end

function MonopolyWorldGame:initData()
	self.leftCount = 0
	self.inAnimatedFlag = false
	self.mapCells = {}

	return
end

function MonopolyWorldGame:initUI()
	self.tplMapCell = findTF(self._tf, "tplMapCell")
	self.gameTipUI1 = findTF(self._tf, "btnStart/desc")

	setText(self.gameTipUI1, i18n(var_0_5))

	self.gameTipUI2 = findTF(self._tf, "bg/desc")

	setText(self.gameTipUI2, "")

	self.mapContainer = findTF(self._tf, "mapContainer")
	self.char = findTF(self._tf, "mapContainer/char")

	setActive(self.char, false)

	self.btnStart = findTF(self._tf, "btnStart")
	self.effectStart = findTF(self.btnStart, "gulitemengya_pingmu")
	self.btnHelp = findTF(self._tf, "topRight/btnHelp")
	self.labelLeftCount = findTF(self.btnStart, "times")
	self.btnBack = findTF(self._tf, "leftTop/back")

	self:initMap()
	self:initChar()
	self:initFurn()

	return
end

function MonopolyWorldGame:initFurn()
	local var_4_0 = findTF(self._tf, "bg/mask/event"):GetComponent("HScrollSnap")

	self.bannerCanvas = GetComponent(findTF(self._tf, "bg/mask"), typeof(CanvasGroup))

	var_4_0:Init()

	local var_4_1 = findTF(var_4_0, "item")
	local var_4_2 = findTF(self._tf, "bg/dots")
	local var_4_3 = findTF(self._tf, "bg/dot")

	setActive(var_4_1, false)
	setActive(var_4_3, false)

	self.furnItems = {}

	for iter_4_0 = 0, #var_0_24 - 1 do
		cloneTplTo(var_4_3, var_4_2)

		local var_4_4 = Instantiate(var_4_1)

		var_0_25 = pg.furniture_data_template[var_0_24[iter_4_0 + 1]]
		var_0_26 = var_0_25.icon

		GetImageSpriteFromAtlasAsync("ui/monopolyworldui_atlas", var_0_26, findTF(var_4_4, "img"), true)
		var_4_0:AddChild(var_4_4)
		setActive(var_4_4, true)
		table.insert(self.furnItems, var_4_4)
	end

	self.bannerSnap = var_4_0
	self.bannerContent = findTF(var_4_0, "content")
	self.bannerDots = var_4_2
	self.furnNames = {}

	for iter_4_1 = 1, #var_0_24 do
		table.insert(self.furnNames, findTF(self._tf, "bg/furnName/img" .. iter_4_1))
	end

	local function var_4_5()
		for iter_5_0 = 1, #var_0_24 do
			if iter_5_0 == self.bannerSnap:CurrentScreen() + 1 then
				if not isActive(self.furnNames[iter_5_0]) then
					setActive(self.furnNames[iter_5_0], true)
				end
			elseif isActive(self.furnNames[iter_5_0]) then
				setActive(self.furnNames[iter_5_0], false)
			end
		end

		return
	end

	self.funrTimer = Timer.New(var_4_5, 0.2, -1)

	self.funrTimer:Start()
	var_4_5()

	return
end

function MonopolyWorldGame:initEvent()
	onButton(self._binder, self.btnStart, function()
		if self.inAnimatedFlag then
			return
		end

		if self.leftCount and self.leftCount <= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_count_noenough"))

			return
		end

		self:changeAnimeState(true)
		setActive(self.btnStart, true)
		self._event:emit(MonopolyWorldScene.ON_START, self.activity.id, function(arg_8_0)
			if arg_8_0 and arg_8_0 > 0 then
				self:showRollAnimated(arg_8_0)
			end

			return
		end)

		return
	end, SFX_PANEL)
	onButton(self._binder, self.btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_monopoly_world.tip
		})

		return
	end, SFX_PANEL)
	onButton(self._binder, self.btnBack, function()
		if not self.inAnimatedFlag then
			self._event:emit(BaseUI.ON_BACK)
		end

		return
	end, SFX_PANEL)
	onButton(self._binder, findTF(self.char, "click"), function()
		if not self.model or self.inAnimatedFlag then
			return
		end

		self:changeCharAction(var_0_16, 1, function()
			self:changeCharAction(var_0_13)

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function MonopolyWorldGame:showRollAnimated(arg_13_1)
	seriesAsync({
		function(arg_14_0)
			setActive(self.effectStart, true)
			GetComponent(findTF(self.btnStart, "anim"), typeof(Animator)):Play("start", -1, 0)
			LeanTween.delayedCall(1, System.Action(function()
				for iter_15_0 = 1, 6 do
					local var_15_0 = findTF(self.btnStart, "num/" .. iter_15_0)

					if iter_15_0 ~= arg_13_1 then
						setActive(var_15_0, false)
					else
						setActive(var_15_0, true)
					end
				end

				return
			end))
			LeanTween.delayedCall(2, System.Action(function()
				arg_14_0()

				return
			end))

			return
		end
	}, function()
		self.useCount = self.useCount + 1
		self.leftCount = self.leftCount - 1
		self.step = arg_13_1

		self:updataUI()
		self:checkCharActive()

		return
	end)

	return
end

function MonopolyWorldGame:checkCountStory(arg_18_1)
	local var_18_0 = self.useCount
	local var_18_1 = _.detect(self.activity:getDataConfig("story") or {}, function(arg_19_0)
		return arg_19_0[1] == var_18_0
	end)

	if var_18_1 then
		pg.NewStoryMgr.GetInstance():Play(var_18_1[2], arg_18_1)
	else
		arg_18_1()
	end

	return
end

function MonopolyWorldGame:changeAnimeState(arg_20_1)
	if arg_20_1 then
		self.btnStart:GetComponent(typeof(Image)).raycastTarget = false
		self.inAnimatedFlag = true

		self._event:emit(ActivityMainScene.LOCK_ACT_MAIN, true)
	else
		self.inAnimatedFlag = false
		self.btnStart:GetComponent(typeof(Image)).raycastTarget = true

		self._event:emit(ActivityMainScene.LOCK_ACT_MAIN, false)
	end

	return
end

function MonopolyWorldGame:initMap()
	self.mapCells = {}

	for iter_21_0 = 1, #var_0_3 do
		local var_21_0 = {
			x = -(iter_21_0 - 1) * var_0_1,
			y = -(iter_21_0 - 1) * var_0_2
		}

		for iter_21_1 = 1, #var_0_3[iter_21_0] do
			if var_0_3[iter_21_0][iter_21_1] > 0 then
				local var_21_1 = cloneTplTo(self.tplMapCell, self.mapContainer, tostring(var_0_3[iter_21_0][iter_21_1]))
				local var_21_2 = Vector2(var_0_1 * (iter_21_1 - 1) + var_21_0.x, -var_0_2 * (iter_21_1 - 1) + var_21_0.y)

				var_21_1.localPosition = var_21_2
				findTF(var_21_1, "image"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/monopolyworldui_atlas", pg.activity_event_monopoly_map[var_0_3[iter_21_0][iter_21_1]].icon)

				findTF(var_21_1, "image"):GetComponent(typeof(Image)):SetNativeSize()
				table.insert(self.mapCells, {
					col = iter_21_1 - 1,
					row = iter_21_0 - 1,
					mapId = var_0_3[iter_21_0][iter_21_1],
					tf = var_21_1,
					icon = pg.activity_event_monopoly_map[var_0_3[iter_21_0][iter_21_1]].icon,
					position = var_21_2
				})
			end
		end
	end

	table.sort(self.mapCells, function(arg_22_0, arg_22_1)
		return arg_22_0.mapId < arg_22_1.mapId
	end)

	return
end

function MonopolyWorldGame:initChar()
	PoolMgr.GetInstance():GetSpineChar(var_0_4, true, function(arg_24_0)
		self.model = arg_24_0
		self.model.transform.localScale = Vector3.one
		self.model.transform.localPosition = Vector3.zero

		self.model.transform:SetParent(self.char, false)

		self.anim = self.model:GetComponent(typeof(SpineAnimUI))

		self:changeCharAction(var_0_13, 0, nil)
		self:checkCharActive()

		if self.pos then
			self:updataCharDirect(self.pos, false)
		end

		return
	end)

	return
end

function MonopolyWorldGame:updataCharDirect(arg_25_1, arg_25_2)
	if self.model then
		self.char.localScale = Vector3(self:getMoveType(self.mapCells[arg_25_1].mapId, self.mapCells[arg_25_1 + 1 > #self.mapCells and 1 or arg_25_1 + 1].mapId, arg_25_2) or self.char.localScale.x, self.char.localScale.y, self.char.localScale.z)
	end

	return
end

function MonopolyWorldGame:getMoveType(arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = {}
	local var_26_1 = {}

	for iter_26_0 = 1, #var_0_3 do
		for iter_26_1 = 1, #var_0_3[iter_26_0] do
			if var_0_3[iter_26_0][iter_26_1] == arg_26_1 then
				var_26_0 = {
					x = iter_26_1,
					y = iter_26_0
				}
			end

			if var_0_3[iter_26_0][iter_26_1] == arg_26_2 then
				var_26_1 = {
					x = iter_26_1,
					y = iter_26_0
				}
			end
		end
	end

	local var_26_2

	if var_26_1.y > var_26_0.y then
		var_26_2 = -var_0_8
	elseif var_26_1.y < var_26_0.y then
		var_26_2 = var_0_8
	elseif var_26_1.x > var_26_0.x then
		var_26_2 = var_0_8
	elseif var_26_1.x < var_26_0.x then
		var_26_2 = -var_0_8
	end

	return var_26_2
end

function MonopolyWorldGame:checkCharActive()
	if self.anim then
		if self.effectId and self.effectId > 0 then
			self:changeAnimeState(true)
			self:checkEffect(function()
				self:changeAnimeState(false)
				self:checkCharActive()

				return
			end)
		elseif self.step and self.step > 0 then
			self:changeAnimeState(true)
			self:checkStep(function()
				self:changeAnimeState(false)
				self:checkCharActive()

				return
			end)
		elseif self.activity then
			self.activity = getProxy(ActivityProxy):getActivityById(self.activity.id)

			self:updataActivity(self.activity)
		end
	end

	return
end

function MonopolyWorldGame:firstUpdata(arg_30_1)
	self:activityDataUpdata(arg_30_1)
	self:updataUI()
	self:updataChar()
	self:checkCharActive()

	return
end

function MonopolyWorldGame:updataActivity(arg_31_1)
	self:activityDataUpdata(arg_31_1)
	self:updataUI()

	return
end

function MonopolyWorldGame:activityDataUpdata(arg_32_1)
	self.activity = arg_32_1
	self.totalCnt = math.ceil((pg.TimeMgr.GetInstance():GetServerTime() - self.activity.data1) / 0) * self.activity:getDataConfig("daily_time") + self.activity.data1_list[1]
	self.useCount = self.activity.data1_list[2]
	self.leftCount = self.totalCnt - self.useCount

	if self.turnCnt and self.turnCnt ~= self.activity.data1_list[3] - 1 then
		self.autoShowScreen = nil
	end

	self.turnCnt = self.activity.data1_list[3] - 1
	self.leftDropShipCnt = 8 - self.turnCnt

	local var_32_0 = self.activity.data2_list[2]

	self.advanceTotalCnt = #arg_32_1:getDataConfig("reward")
	self.isAdvanceRp = self.advanceTotalCnt - var_32_0 > 0
	self.leftAwardCnt = self.activity.data2_list[1] - var_32_0
	self.advanceRpCount = math.max(0, math.min(self.activity.data2_list[1], self.advanceTotalCnt) - var_32_0)
	self.commonRpCount = math.max(0, self.activity.data2_list[1] - self.advanceTotalCnt) - math.max(0, var_32_0 - self.advanceTotalCnt)

	local var_32_1 = arg_32_1:getDataConfig("reward_time")

	self.nextredPacketStep = var_32_1 - self.useCount % var_32_1
	self.pos = self.activity.data2
	self.lastPos = self.pos
	self.step = self.activity.data3
	self.effectId = self.activity.data4

	return
end

function MonopolyWorldGame:checkStep(arg_33_1)
	if self.step > 0 then
		self._event:emit(MonopolyWorldScene.ON_MOVE, self.activity.id, function(arg_34_0, arg_34_1, arg_34_2)
			self.step = arg_34_0
			self.lastPos = self.pos
			self.pos = arg_34_1[#arg_34_1]
			self.effectId = arg_34_2

			seriesAsync({
				function(arg_35_0)
					self:moveCharWithPaths(arg_34_1, (#arg_34_1 > 3 or nil) and (var_0_15 or var_0_14), arg_35_0)

					return
				end,
				function(arg_36_0)
					if arg_34_1 and #arg_34_1 > 0 and self.pos == 1 then
						self.turnCnt = self.turnCnt + 1

						setText(findTF(self._tf, "topRight/times"), tostring(self.turnCnt))
						self:changeBg()
					end

					if isActive(self.effectStart) then
						setActive(self.effectStart, false)
						setActive(self.effectStart, true)
						LeanTween.delayedCall(1, System.Action(function()
							for iter_37_0 = 1, 6 do
								setActive(findTF(self.btnStart, "num/" .. iter_37_0), false)
							end

							return
						end))
						LeanTween.delayedCall(2, System.Action(function()
							setActive(self.effectStart, false)

							return
						end))
					end

					self:checkEffect(arg_36_0)

					return
				end
			}, function()
				if arg_33_1 then
					arg_33_1()
				end

				return
			end)

			return
		end)
	else
		if self.pos == 1 then
			self.turnCnt = self.turnCnt + 1

			self:changeBg()
		end

		if arg_33_1 then
			arg_33_1()
		end
	end

	return
end

function MonopolyWorldGame:updataUI()
	setText(self.labelLeftCount, self.leftCount)

	local var_40_0 = self.activity:getDataConfig("daily_time")

	var_0_26 = var_0_25.icon

	if self.turnCnt and self.turnCnt < #var_0_24 then
		var_0_25 = pg.furniture_data_template[var_0_24[self.turnCnt + 1]]

		setText(self.gameTipUI2, i18n(var_0_6, var_40_0, 1))
	else
		setText(self.gameTipUI2, i18n(var_0_7, var_40_0))
	end

	if self.leftCount and self.leftCount > 0 then
		setActive(findTF(self.btnStart, "img3"), true)
		setActive(findTF(self.btnStart, "img4"), false)
	else
		setActive(findTF(self.btnStart, "img3"), false)
		setActive(findTF(self.btnStart, "img4"), true)
	end

	setText(findTF(self._tf, "topRight/times"), tostring(self.turnCnt))

	for iter_40_0 = 1, #self.furnItems do
		if iter_40_0 <= self.turnCnt then
			setActive(findTF(self.furnItems[iter_40_0], "got"), true)
		else
			setActive(findTF(self.furnItems[iter_40_0], "got"), false)
		end
	end

	if self.bannerSnap.StartingScreen == 0 and not self.bannerInit then
		if self.turnCnt < #var_0_24 then
			self.bannerSnap.StartingScreen = self.turnCnt % 5 + 1
			self.bannerInit = true
		else
			self.bannerSnap.autoSnap = 5
		end
	elseif self.bannerSnap:CurrentScreen() ~= self.turnCnt and self.turnCnt < #var_0_24 then
		local var_40_1 = self.turnCnt % 5 - self.bannerSnap:CurrentScreen()

		for iter_40_1 = 1, math.abs(var_40_1) do
			if math.sign(var_40_1) > 0 then
				self.bannerSnap:NextScreen(true)
			else
				self.bannerSnap:PreviousScreen(true)
			end
		end
	end

	if self.turnCnt >= #var_0_24 then
		if self.bannerCanvas.blocksRaycasts ~= true then
			self.bannerCanvas.blocksRaycasts = true
		end

		if not isActive(findTF(self._tf, "bg/dots")) then
			self.bannerSnap:NextScreen(true)
			setActive(findTF(self._tf, "bg/dots"), true)
		end
	else
		if self.bannerCanvas.blocksRaycasts == true then
			self.bannerCanvas.blocksRaycasts = false
		end

		if isActive(findTF(self._tf, "bg/dots")) then
			setActive(findTF(self._tf, "bg/dots"), false)
		end
	end

	self:changeBg()

	return
end

function MonopolyWorldGame:updataChar()
	self.char.localPosition = self.mapCells[self.pos].position

	if not isActive(self.char) then
		SetActive(self.char, true)
		self.char:SetAsLastSibling()
	end

	if self.model then
		self:updataCharDirect(self.pos, false)
	end

	return
end

function MonopolyWorldGame:getEffectTf(arg_42_1, arg_42_2)
	for iter_42_0 = 1, #var_0_22 do
		if var_0_22[iter_42_0].cell_type == arg_42_1 then
			if not arg_42_2 then
				return findTF(self._tf, "mapContainer/effect/" .. var_0_22[iter_42_0].name)
			elseif arg_42_2 == var_0_22[iter_42_0].path_length then
				return findTF(self._tf, "mapContainer/effect/" .. var_0_22[iter_42_0].name)
			end
		end
	end

	return nil
end

function MonopolyWorldGame:checkEffect(arg_43_1)
	if self.effectId > 0 then
		local var_43_0 = self.mapCells[self.pos]
		local var_43_1, var_43_2 = self:getActionName(self.mapCells[self.pos].icon)
		local var_43_3 = pg.activity_event_monopoly_event[self.effectId].story

		seriesAsync({
			function(arg_44_0)
				if var_43_1 then
					self:changeCharAction(var_43_1, 1, function()
						self:changeCharAction(var_0_13, 0, nil)
						arg_44_0()

						return
					end)
				end

				if var_43_2 then
					local var_44_0 = self:getEffectTf(var_43_2)

					if var_44_0 then
						var_44_0.anchoredPosition = Vector2(var_43_0.position.x, var_43_0.position.y)

						setActive(var_44_0, false)
						setActive(var_44_0, true)
					end
				end

				if not var_43_1 and not var_43_2 then
					arg_44_0()
				elseif not var_43_1 and var_43_2 then
					LeanTween.delayedCall(1, System.Action(function()
						arg_44_0()

						return
					end))
				end

				return
			end,
			function(arg_47_0)
				if var_43_3 and tonumber(var_43_3) ~= 0 then
					pg.NewStoryMgr.GetInstance():Play(var_43_3, arg_47_0, true, true)
				else
					arg_47_0()
				end

				return
			end,
			function(arg_48_0)
				self:triggerEfeect(arg_48_0)

				return
			end,
			function(arg_49_0)
				self:checkCountStory(arg_49_0)

				return
			end,
			function(arg_50_0)
				if self.pos == 1 then
					self:changeBg()
				end

				arg_50_0()

				return
			end
		}, arg_43_1)
	elseif arg_43_1 then
		arg_43_1()
	end

	return
end

function MonopolyWorldGame:triggerEfeect(arg_51_1)
	self._event:emit(MonopolyWorldScene.ON_TRIGGER, self.activity.id, function(arg_52_0, arg_52_1)
		if arg_52_0 and #arg_52_0 >= 0 then
			self.effectId = arg_52_1
			self.lastPos = self.pos
			self.pos = arg_52_0[#arg_52_0]

			if #arg_52_0 > 0 then
				print()
			end

			local var_52_0 = self:getEffectTf(var_0_18, #arg_52_0)

			seriesAsync({
				function(arg_53_0)
					if var_52_0 then
						setActive(var_52_0, false)
						setActive(var_52_0, true)

						var_52_0.anchoredPosition = self.mapCells[self.lastPos].position

						LeanTween.delayedCall(1, System.Action(function()
							arg_53_0()

							return
						end))
					else
						arg_53_0()
					end

					return
				end,
				function(arg_55_0)
					self:moveCharWithPaths(arg_52_0, var_0_12, arg_55_0)

					return
				end
			}, function()
				if var_52_0 then
					-- block empty
				end

				arg_51_1()

				return
			end)
		end

		return
	end)

	return
end

function MonopolyWorldGame:changeBg()
	for iter_57_0 = 1, 5 do
		local var_57_0 = findTF(self._tf, "bg/img" .. iter_57_0)
		local var_57_1 = GetComponent(var_57_0, typeof(Image)).color.a

		if iter_57_0 == ((self.turnCnt or nil) and (self.turnCnt % 5 + 1 or 1)) then
			if var_57_1 ~= 1 then
				LeanTween.alpha(var_57_0, 1, 0.5)
			end
		elseif var_57_1 ~= 0 then
			LeanTween.alpha(var_57_0, 0, 0.5)
		end
	end

	return
end

function MonopolyWorldGame:toMoveCar()
	if not self.targetPosition then
		return
	end

	if math.abs(self.targetPosition.x - self.char.localPosition.x) <= 6.5 and math.abs(self.targetPosition.y - self.char.localPosition.y) <= 6.5 then
		self.targetPosition = nil

		if self.moveComplete then
			self:updataCharDirect(self.targetPosIndex, true)
			self.moveComplete()
		end
	end

	if math.abs(self.speedX + self.baseASpeedX) > math.abs(self.baseSpeedX) then
		self.speedX = self.baseSpeedX or self.speedX + self.baseASpeedX
	end

	if math.abs(self.speedY + self.baseASpeedY) > math.abs(self.baseSpeedY) then
		self.speedY = self.baseSpeedY or self.speedY + self.baseASpeedY
	end

	self.char.localPosition = Vector3(self.char.localPosition.x + self.speedX, self.char.localPosition.y + self.speedY, 0)

	return
end

function MonopolyWorldGame:checkPathTurn(arg_59_1)
	local var_59_0 = arg_59_1 + 1 > #self.mapCells and 1 or arg_59_1 + 1

	if arg_59_1 - 1 < 1 then
		local var_59_1 = #self.mapCells or arg_59_1 - 1

		if self.mapCells[var_59_0].col == self.mapCells[var_59_1].col or self.mapCells[var_59_0].row == self.mapCells[var_59_1].row then
			return false
		end
	end

	return true
end

function MonopolyWorldGame:moveCharWithPaths(arg_60_1, arg_60_2, arg_60_3)
	if not arg_60_1 or #arg_60_1 <= 0 then
		if arg_60_3 then
			arg_60_3()
		end

		return
	end

	local var_60_0 = {}

	if arg_60_1[1] - 1 < 1 then
		local var_60_1 = #self.mapCells or arg_60_1[1] - 1
	end

	for iter_60_0 = 1, #arg_60_1 do
		local var_60_2 = self.mapCells[arg_60_1[iter_60_0]]

		table.insert(var_60_0, function(arg_61_0)
			self:changeCharAction(arg_60_2, 0, nil)
			self:updataCharDirect(var_60_1, true)

			var_60_1 = arg_60_1[iter_60_0]

			LeanTween.moveLocal(go(self.char), var_60_2.tf.localPosition, arg_60_2 == var_0_12 and 0.9 or arg_60_2 == var_0_14 and 0.9 or 0.5):setEase(LeanTweenType.linear):setOnComplete(System.Action(function()
				if arg_60_2 == var_0_14 then
					LeanTween.delayedCall(0.05, System.Action(function()
						arg_61_0()

						return
					end))
				else
					arg_61_0()
				end

				return
			end))

			return
		end)

		if iter_60_0 == #arg_60_1 then
			table.insert(var_60_0, function(arg_64_0)
				self:changeCharAction(var_0_13, 0, nil)
				self:updataCharDirect(arg_60_1[iter_60_0], false)
				arg_64_0()

				return
			end)
		end
	end

	seriesAsync(var_60_0, arg_60_3)

	return
end

function MonopolyWorldGame:changeCharAction(arg_65_1, arg_65_2, arg_65_3)
	if self.actionName == arg_65_1 and self.actionName ~= var_0_14 then
		return
	end

	self.actionName = arg_65_1

	self.anim:SetActionCallBack(nil)
	self.anim:SetAction(arg_65_1, 0)
	self.anim:SetActionCallBack(function(arg_66_0)
		if arg_66_0 == "finish" then
			if arg_65_2 == 1 then
				self.anim:SetActionCallBack(nil)
				self.anim:SetAction(var_0_13, 0)
			end

			if arg_65_3 then
				arg_65_3()
			end
		end

		return
	end)

	if arg_65_2 ~= 1 and arg_65_3 then
		arg_65_3()
	end

	return
end

function MonopolyWorldGame:getActionName(arg_67_1)
	if arg_67_1 == "icon_1" then
		return var_0_11, var_0_21
	elseif arg_67_1 == "icon_2" then
		return var_0_9, var_0_17
	elseif arg_67_1 == "icon_3" then
		return var_0_11, var_0_20
	elseif arg_67_1 == "icon_4" then
		return var_0_11, var_0_21
	elseif arg_67_1 == "icon_5" then
		return var_0_10, var_0_19
	elseif arg_67_1 == "icon_6" then
		return nil, nil
	end

	return
end

function MonopolyWorldGame:dispose()
	if self.skinCardName and self.showModel then
		PoolMgr.GetInstance():ReturnSpineChar(self.skinCardName, self.showModel)
	end

	if self.funrTimer then
		self.funrTimer:Stop()

		self.funrTimer = nil
	end

	for iter_68_0 = 1, 5 do
		local var_68_0 = findTF(self._tf, "bg/img" .. iter_68_0)

		if LeanTween.isTweening(var_68_0) then
			LeanTween.cancel(var_68_0)
		end
	end

	return
end

return MonopolyWorldGame
