local MonopolyCar2Game = class("MonopolyCar2Game")
local var_0_1 = 100
local var_0_2 = 50
local var_0_3 = "xinnongpaoche"
local var_0_4 = {
	"yuekegongjue_2",
	"dafeng_5",
	"baerdimo_6"
}
local var_0_5 = {
	"gaoxiong_5",
	"aidang_5",
	"xinnong_3",
	"qiye_7"
}
local var_0_6 = {
	"ruihe_3",
	"xianghe_3",
	"ougen_5",
	"weiershiqinwang_3"
}
local var_0_7 = {
	xianghe_3 = "dance",
	baerdimo_6 = "stand2",
	xinnong_3 = "stand2",
	dafeng_5 = "stand2",
	weiershiqinwang_3 = "stand2",
	ruihe_3 = "stand2",
	qiye_7 = "dance",
	ougen_5 = "stand2",
	aidang_5 = "dance",
	yuekegongjue_2 = "stand2",
	gaoxiong_5 = "dance"
}
local var_0_8 = 0.6
local var_0_9 = "ui/activityuipage/monopolycar2_atlas"
local var_0_10 = "B-stand"
local var_0_11 = "F-stand"
local var_0_12 = "B-walk"
local var_0_13 = "F-walk"
local var_0_18 = {
	{
		5006,
		5007,
		5008,
		5009,
		5010
	},
	{
		5005,
		0,
		0,
		0,
		5011
	},
	{
		5004,
		0,
		0,
		0,
		5012
	},
	{
		5003,
		0,
		0,
		0,
		5013
	},
	{
		5002,
		0,
		0,
		0,
		5014
	},
	{
		2001,
		5018,
		5017,
		5016,
		5015
	}
}

function MonopolyCar2Game:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._binder = arg_1_1
	self._tf = arg_1_2
	self._event = arg_1_3

	self:initData()
	self:initUI()
	self:initEvent()

	return
end

function MonopolyCar2Game:initData()
	self.leftCount = 0
	self.inAnimatedFlag = false
	self.mapCells = {}
	self.showCharNames = {}

	if var_0_4 and #var_0_4 > 0 then
		table.insert(self.showCharNames, Clone(var_0_4[math.random(1, #var_0_4)]))
	end

	if var_0_5 and #var_0_5 > 0 then
		table.insert(self.showCharNames, Clone(var_0_5[math.random(1, #var_0_5)]))
	end

	if var_0_6 and #var_0_6 > 0 then
		table.insert(self.showCharNames, Clone(var_0_6[math.random(1, #var_0_6)]))
	end

	return
end

function MonopolyCar2Game:initUI()
	self.tplMapCell = findTF(self._tf, "tplMapCell")
	self.mapContainer = findTF(self._tf, "mapContainer")
	self.char = findTF(self._tf, "mapContainer/char")
	self.showChars = {}

	for iter_3_0 = 1, 3 do
		table.insert(self.showChars, findTF(self._tf, "showChar" .. iter_3_0))
	end

	setActive(self.char, false)

	self.btnStart = findTF(self._tf, "btnStart")
	self.btnHelp = findTF(self._tf, "btnHelp")
	self.btnRp = findTF(self._tf, "btnRp")
	self.commonAnim = findTF(self.btnRp, "rpAni"):GetComponent(typeof(Animator))
	self.labelLeftCountTip = findTF(self.btnStart, "labelLeftCountTip")

	setActive(self.labelLeftCountTip, false)

	self.labelLeftCount = findTF(self.btnStart, "labelLeftCount")
	self.labelDropShip = findTF(self._tf, "labelDropShip")
	self.labelLeftRpCount = findTF(self._tf, "labelLeftRpCount")
	self.rollStep = findTF(self._tf, "step")

	setActive(self.rollStep, false)
	self:initMap()
	self:initChar()

	return
end

function MonopolyCar2Game:initEvent()
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
		self._event:emit(MonopolyCar2Page.ON_START, self.activity.id, function(arg_6_0)
			if arg_6_0 and arg_6_0 > 0 then
				self:showRollAnimated(arg_6_0)
			end

			return
		end)

		return
	end, SFX_PANEL)
	onButton(self._binder, self.btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_monopoly_car_2.tip
		})

		return
	end, SFX_PANEL)

	for iter_4_0 = 1, #self.showChars do
		onButton(self._binder, self.showChars[iter_4_0], function()
			self._event:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SKINSHOP)

			return
		end, SFX_PANEL)
	end

	onButton(self._binder, self.btnRp, function()
		if self.leftAwardCnt > 0 then
			self._event:emit(MonopolyCar2Page.ON_AWARD)
		end

		return
	end, SFX_PANEL)

	return
end

function MonopolyCar2Game:showRollAnimated(arg_10_1)
	local var_10_0 = findTF(self.rollStep, "stepArrow")

	var_10_0.localEulerAngles = Vector3(0, 0, 0)
	findTF(self.rollStep, "progress/bg"):GetComponent(typeof(Image)).fillAmount = 0.1
	findTF(self.rollStep, "select/bg"):GetComponent(typeof(Image)).fillAmount = 0.1

	setText(findTF(self.rollStep, "labelRoll"), "0")
	seriesAsync({
		function(arg_11_0)
			LeanTween.value(go(self._tf), 1, 0, 0.2):setOnUpdate(System.Action_float(function(arg_12_0)
				self.btnStart:GetComponent(typeof(CanvasGroup)).alpha = arg_12_0

				return
			end)):setOnComplete(System.Action(function()
				setActive(self.btnStart, false)

				self.btnStart:GetComponent(typeof(CanvasGroup)).alpha = 1

				arg_11_0()

				return
			end))

			return
		end,
		function(arg_14_0)
			LeanTween.value(go(self._tf), 0, 1, 0.2):setOnUpdate(System.Action_float(function(arg_15_0)
				self.rollStep:GetComponent(typeof(CanvasGroup)).alpha = arg_15_0

				setActive(self.rollStep, true)

				return
			end)):setOnComplete(System.Action(function()
				arg_14_0()

				return
			end))

			return
		end,
		function(arg_17_0)
			local var_17_0 = arg_10_1 / 6 * 0.62
			local var_17_1 = arg_10_1 / 6 * 0.62 / arg_10_1
			local var_17_2 = -arg_10_1 * 31

			LeanTween.value(go(self._tf), 0, 1, 0.7 + arg_10_1 / 5):setEase(LeanTweenType.easeOutCirc):setOnUpdate(System.Action_float(function(arg_18_0)
				findTF(self.rollStep, "progress/bg"):GetComponent(typeof(Image)).fillAmount = var_17_0 * arg_18_0 + 0.13
				findTF(self.rollStep, "select/bg"):GetComponent(typeof(Image)).fillAmount = var_17_1 * math.floor(arg_18_0 / (1 / arg_10_1)) + 0.17

				setText(findTF(self.rollStep, "labelRoll"), math.floor(arg_18_0 / (1 / arg_10_1)))

				var_10_0.localEulerAngles = Vector3(0, 0, var_17_2 * arg_18_0 - 13)

				return
			end)):setOnComplete(System.Action(function()
				arg_17_0()

				return
			end))

			return
		end,
		function(arg_20_0)
			LeanTween.value(go(self._tf), 1, 0, 0.3):setOnComplete(System.Action(function()
				arg_20_0()

				return
			end))

			return
		end,
		function(arg_22_0)
			LeanTween.value(go(self._tf), 1, 0, 0.3):setOnUpdate(System.Action_float(function(arg_23_0)
				self.rollStep:GetComponent(typeof(CanvasGroup)).alpha = arg_23_0

				return
			end)):setOnComplete(System.Action(function()
				setActive(self.rollStep, false)

				self.rollStep:GetComponent(typeof(CanvasGroup)).alpha = 1

				arg_22_0()

				return
			end))

			return
		end
	}, function()
		self.useCount = self.useCount + 1
		self.step = arg_10_1

		if self.step > 0 then
			local var_25_0 = GetSpriteFromAtlas(var_0_9, self.step)
		end

		self:updataUI()
		self:checkCharActive()

		return
	end)

	return
end

function MonopolyCar2Game:checkCountStory(arg_26_1)
	local var_26_0 = self.useCount
	local var_26_1 = _.detect(self.activity:getDataConfig("story") or {}, function(arg_27_0)
		return arg_27_0[1] == var_26_0
	end)

	if var_26_1 then
		pg.NewStoryMgr.GetInstance():Play(var_26_1[2], arg_26_1)
	else
		arg_26_1()
	end

	return
end

function MonopolyCar2Game:changeAnimeState(arg_28_1)
	if arg_28_1 then
		self.btnStart:GetComponent(typeof(Image)).raycastTarget = false
		self.inAnimatedFlag = true

		self._event:emit(ActivityMainScene.LOCK_ACT_MAIN, true)
	else
		self.inAnimatedFlag = false
		self.btnStart:GetComponent(typeof(Image)).raycastTarget = true

		self._event:emit(ActivityMainScene.LOCK_ACT_MAIN, false)
	end

	setActive(self.btnStart, not arg_28_1)

	return
end

function MonopolyCar2Game:initMap()
	self.mapCells = {}

	for iter_29_0 = 1, #var_0_18 do
		local var_29_0 = {
			x = -(iter_29_0 - 1) * var_0_1,
			y = -(iter_29_0 - 1) * var_0_2
		}

		for iter_29_1 = 1, #var_0_18[iter_29_0] do
			if var_0_18[iter_29_0][iter_29_1] > 0 then
				local var_29_1 = cloneTplTo(self.tplMapCell, self.mapContainer, tostring(var_0_18[iter_29_0][iter_29_1]))
				local var_29_2 = Vector2(var_0_1 * (iter_29_1 - 1) + var_29_0.x, -var_0_2 * (iter_29_1 - 1) + var_29_0.y)

				var_29_1.localPosition = var_29_2
				findTF(var_29_1, "image"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas(var_0_9, pg.activity_event_monopoly_map[var_0_18[iter_29_0][iter_29_1]].icon)

				findTF(var_29_1, "image"):GetComponent(typeof(Image)):SetNativeSize()
				table.insert(self.mapCells, {
					col = iter_29_1 - 1,
					row = iter_29_0 - 1,
					mapId = var_0_18[iter_29_0][iter_29_1],
					tf = var_29_1,
					icon = pg.activity_event_monopoly_map[var_0_18[iter_29_0][iter_29_1]].icon,
					position = var_29_2
				})
			end
		end
	end

	table.sort(self.mapCells, function(arg_30_0, arg_30_1)
		return arg_30_0.mapId < arg_30_1.mapId
	end)

	return
end

function MonopolyCar2Game:initChar()
	PoolMgr.GetInstance():GetSpineChar(var_0_3, true, function(arg_32_0)
		self.model = arg_32_0
		self.model.transform.localScale = Vector3.one
		self.model.transform.localPosition = Vector3.zero

		self.model.transform:SetParent(self.char, false)

		self.anim = self.model:GetComponent(typeof(SpineAnimUI))

		self:checkCharActive()

		if self.pos then
			self:updataCharDirect(self.pos, false)
		end

		return
	end)

	self.showCharMods = {}

	for iter_31_0 = 1, #self.showCharNames do
		local var_31_0 = self.showCharNames[iter_31_0]

		PoolMgr.GetInstance():GetSpineChar(self.showCharNames[iter_31_0], true, function(arg_33_0)
			arg_33_0.transform.localScale = Vector3.one
			arg_33_0.transform.localPosition = Vector3.zero

			arg_33_0.transform:SetParent(self.showChars[iter_31_0], false)

			local var_33_0 = arg_33_0:GetComponent(typeof(SpineAnimUI))

			if var_0_7[var_31_0] then
				var_33_0:SetAction(var_0_7[var_31_0], 0)
			else
				var_33_0:SetAction("stand", 0)
			end

			table.insert(self.showCharMods, arg_33_0)

			return
		end)
	end

	return
end

function MonopolyCar2Game:updataCharDirect(arg_34_1, arg_34_2)
	if self.model then
		local var_34_2, var_34_3 = self:getMoveType(self.mapCells[arg_34_1].mapId, self.mapCells[arg_34_1 + 1 > #self.mapCells and 1 or arg_34_1 + 1].mapId, arg_34_2)

		self.char.localScale = Vector3(var_34_3, self.char.localScale.y, self.char.localScale.z)

		self.anim:SetActionCallBack(nil)
		self.anim:SetAction(var_34_2, 0)
	end

	return
end

function MonopolyCar2Game:getMoveType(arg_35_1, arg_35_2, arg_35_3)
	local var_35_0 = {}
	local var_35_1 = {}

	for iter_35_0 = 1, #var_0_18 do
		for iter_35_1 = 1, #var_0_18[iter_35_0] do
			if var_0_18[iter_35_0][iter_35_1] == arg_35_1 then
				var_35_0 = {
					x = iter_35_1,
					y = iter_35_0
				}
			end

			if var_0_18[iter_35_0][iter_35_1] == arg_35_2 then
				var_35_1 = {
					x = iter_35_1,
					y = iter_35_0
				}
			end
		end
	end

	local var_35_2
	local var_35_3

	if var_35_1.y > var_35_0.y then
		var_35_2 = arg_35_3 and var_0_13 or var_0_11
		var_35_3 = var_0_8
	elseif var_35_1.y < var_35_0.y then
		var_35_2 = arg_35_3 and var_0_12 or var_0_10
		var_35_3 = var_0_8
	elseif var_35_1.x > var_35_0.x then
		var_35_2 = arg_35_3 and var_0_13 or var_0_11
		var_35_3 = -var_0_8
	elseif var_35_1.x < var_35_0.x then
		var_35_2 = arg_35_3 and var_0_12 or var_0_10
		var_35_3 = -var_0_8
	end

	return var_35_2, var_35_3
end

function MonopolyCar2Game:checkCharActive()
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
		end
	end

	return
end

function MonopolyCar2Game:firstUpdata(arg_39_1)
	self:activityDataUpdata(arg_39_1)
	self:updataUI()
	self:updataChar()
	self:checkCharActive()

	return
end

function MonopolyCar2Game:updataActivity(arg_40_1)
	self:activityDataUpdata(arg_40_1)
	self:updataUI()

	return
end

function MonopolyCar2Game:activityDataUpdata(arg_41_1)
	self.activity = arg_41_1
	self.totalCnt = math.ceil((pg.TimeMgr.GetInstance():GetServerTime() - self.activity.data1) / 0) * self.activity:getDataConfig("daily_time") + self.activity.data1_list[1]
	self.useCount = self.activity.data1_list[2]
	self.leftCount = self.totalCnt - self.useCount
	self.turnCnt = self.activity.data1_list[3] - 1
	self.leftDropShipCnt = 8 - self.turnCnt

	local var_41_0 = self.activity.data2_list[2]

	self.advanceTotalCnt = #arg_41_1:getDataConfig("reward")
	self.isAdvanceRp = self.advanceTotalCnt - var_41_0 > 0
	self.leftAwardCnt = self.activity.data2_list[1] - var_41_0
	self.advanceRpCount = math.max(0, math.min(self.activity.data2_list[1], self.advanceTotalCnt) - var_41_0)
	self.commonRpCount = math.max(0, self.activity.data2_list[1] - self.advanceTotalCnt) - math.max(0, var_41_0 - self.advanceTotalCnt)

	local var_41_1 = arg_41_1:getDataConfig("reward_time")

	self.nextredPacketStep = var_41_1 - self.useCount % var_41_1
	self.pos = self.activity.data2
	self.step = self.activity.data3
	self.effectId = self.activity.data4

	return
end

function MonopolyCar2Game:checkStep(arg_42_1)
	if self.step > 0 then
		self._event:emit(MonopolyCar2Page.ON_MOVE, self.activity.id, function(arg_43_0, arg_43_1, arg_43_2)
			self.step = arg_43_0
			self.pos = arg_43_1[#arg_43_1]
			self.effectId = arg_43_2

			seriesAsync({
				function(arg_44_0)
					self:moveCharWithPaths(arg_43_1, nil, arg_44_0)

					return
				end,
				function(arg_45_0)
					self:checkEffect(arg_45_0)

					return
				end
			}, function()
				if arg_42_1 then
					arg_42_1()
				end

				return
			end)

			return
		end)
	elseif arg_42_1 then
		arg_42_1()
	end

	return
end

function MonopolyCar2Game:updataUI()
	setText(self.labelLeftRpCount, "" .. self.leftAwardCnt)
	self.commonAnim:SetInteger("count", self.leftAwardCnt)
	setText(self.labelDropShip, "" .. self.turnCnt + 1)
	setText(self.labelLeftCountTip, i18n("monopoly_left_count"))
	setText(self.labelLeftCount, self.leftCount)

	return
end

function MonopolyCar2Game:updataChar()
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

function MonopolyCar2Game:checkEffect(arg_49_1)
	if self.effectId > 0 then
		local var_49_1 = pg.activity_event_monopoly_event[self.effectId].story

		seriesAsync({
			function(arg_50_0)
				if var_49_1 and tonumber(var_49_1) ~= 0 then
					pg.NewStoryMgr.GetInstance():Play(var_49_1, arg_50_0, true, true)
				else
					arg_50_0()
				end

				return
			end,
			function(arg_51_0)
				self:triggerEfeect(arg_51_0)

				return
			end,
			function(arg_52_0)
				self:checkCountStory(arg_52_0)

				return
			end
		}, arg_49_1)
	elseif arg_49_1 then
		arg_49_1()
	end

	return
end

function MonopolyCar2Game:triggerEfeect(arg_53_1)
	self._event:emit(MonopolyCar2Page.ON_TRIGGER, self.activity.id, function(arg_54_0, arg_54_1)
		if arg_54_0 and #arg_54_0 >= 0 then
			self.effectId = arg_54_1
			self.pos = arg_54_0[#arg_54_0]

			seriesAsync({
				function(arg_55_0)
					self:moveCharWithPaths(arg_54_0, nil, arg_55_0)

					return
				end
			}, function()
				arg_53_1()

				return
			end)
		end

		return
	end)

	return
end

function MonopolyCar2Game:moveCarWithPaths(arg_57_1, arg_57_2, arg_57_3)
	if not arg_57_1 or #arg_57_1 <= 0 then
		if arg_57_3 then
			arg_57_3()
		end

		return
	end

	local var_57_0 = {}
	local var_57_2 = {}
	local var_57_3 = {}

	for iter_57_0 = 1, #arg_57_1 do
		if self:checkPathTurn(arg_57_1[iter_57_0]) then
			table.insert(var_57_2, self.mapCells[arg_57_1[iter_57_0]].position)
			table.insert(var_57_3, arg_57_1[iter_57_0])
		elseif iter_57_0 == #arg_57_1 then
			table.insert(var_57_2, self.mapCells[arg_57_1[iter_57_0]].position)
			table.insert(var_57_3, arg_57_1[iter_57_0])
		end
	end

	self.speedX = 0
	self.speedY = 0
	self.baseSpeed = 6
	self.baseASpeed = 0.1

	if not self.timer then
		self.timer = Timer.New(function()
			self:toMoveCar()

			return
		end, 0.016666666666666666, -1)

		self.timer:Start()
	end

	for iter_57_1 = 1, #var_57_2 do
		table.insert(var_57_0, function(arg_59_0)
			self.moveComplete = arg_59_0
			self.stopOnEnd = false
			self.targetPosition = var_57_2[iter_57_1]
			self.targetPosIndex = var_57_3[iter_57_1]
			self.moveX = self.targetPosition.x - self.char.localPosition.x
			self.moveY = self.targetPosition.y - self.char.localPosition.y
			self.baseSpeedX = self.baseSpeed * (self.moveX / math.abs(self.moveX))
			self.baseASpeedX = self.baseASpeed * (self.moveX / math.abs(self.moveX))
			self.baseSpeedY = math.abs(self.baseSpeedX) / (math.abs(self.moveX) / self.moveY)
			self.baseASpeedY = math.abs(self.baseASpeedX) / (math.abs(self.moveX) / self.moveY)

			if iter_57_1 == 1 then
				self.speedX = 0
				self.speedY = 0
			else
				self.speedX = self.baseSpeedX
				self.speedY = self.baseSpeedY
			end

			return
		end)
	end

	table.insert(var_57_0, function(arg_60_0)
		self.moveComplete = nil

		self:updataCharDirect(arg_57_1[#arg_57_1], false)
		arg_60_0()

		return
	end)
	table.insert(var_57_0, function(arg_61_0)
		LeanTween.value(go(self._tf), 1, 0, 0.1):setOnComplete(System.Action(function()
			arg_61_0()

			return
		end))

		return
	end)
	seriesAsync(var_57_0, arg_57_3)

	return
end

function MonopolyCar2Game:toMoveCar()
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

function MonopolyCar2Game:checkPathTurn(arg_64_1)
	local var_64_0 = arg_64_1 + 1 > #self.mapCells and 1 or arg_64_1 + 1

	if arg_64_1 - 1 < 1 then
		local var_64_1 = #self.mapCells or arg_64_1 - 1

		if self.mapCells[var_64_0].col == self.mapCells[var_64_1].col or self.mapCells[var_64_0].row == self.mapCells[var_64_1].row then
			return false
		end
	end

	return true
end

function MonopolyCar2Game:moveCharWithPaths(arg_65_1, arg_65_2, arg_65_3)
	self:moveCarWithPaths(arg_65_1, arg_65_2, arg_65_3)

	do return end

	if not arg_65_1 or #arg_65_1 <= 0 then
		if arg_65_3 then
			arg_65_3()
		end

		return
	end

	local var_65_0 = {}

	if arg_65_1[1] - 1 < 1 then
		local var_65_1 = #self.mapCells or arg_65_1[1] - 1
	end

	for iter_65_0 = 1, #arg_65_1 do
		local var_65_2 = self.mapCells[arg_65_1[iter_65_0]]

		table.insert(var_65_0, function(arg_66_0)
			self:updataCharDirect(var_65_1, true)

			var_65_1 = arg_65_1[iter_65_0]

			LeanTween.moveLocal(go(self.char), var_65_2.tf.localPosition, 0.35):setEase(LeanTweenType.linear):setOnComplete(System.Action(function()
				arg_66_0()

				return
			end))

			return
		end)

		if iter_65_0 == #arg_65_1 then
			table.insert(var_65_0, function(arg_68_0)
				self:updataCharDirect(arg_65_1[iter_65_0], false)
				arg_68_0()

				return
			end)
		end
	end

	seriesAsync(var_65_0, arg_65_3)

	return
end

function MonopolyCar2Game:dispose()
	PoolMgr.GetInstance():ReturnSpineChar(var_0_3, self.showModel)

	for iter_69_0 = 1, 3 do
		if self.showCharNames[iter_69_0] then
			PoolMgr.GetInstance():ReturnSpineChar(self.showCharNames[iter_69_0], self.showCharMods[iter_69_0])
		end
	end

	return
end

return MonopolyCar2Game
