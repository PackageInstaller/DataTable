local MonopolyCar2024Game = class("MonopolyCar2024Game")
local var_0_1 = 88
local var_0_2 = 43
local var_0_3 = "redcar"
local var_0_4 = MonopolyCar2024Const.map_dic
local var_0_5 = 0.6
local var_0_6 = {
	"sitelasibao_2",
	"u96_4",
	"xiafei_4"
}
local var_0_7 = {
	Vector3(56, 121, 0),
	Vector3(-557, -447, 0),
	Vector3(590, -344, 0)
}
local var_0_8 = "B-stand"
local var_0_9 = "F-stand"
local var_0_10 = "B-walk"
local var_0_11 = "F-walk"

function MonopolyCar2024Game:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._tf = arg_1_2
	self._event = arg_1_3

	pg.DelegateInfo.New(self)

	self.cg = GetOrAddComponent(self._tf, typeof(CanvasGroup))
	self.maskTr = findTF(self._tf.parent, "mask")
	self.pickPage = self:NewPickPage(arg_1_2, arg_1_3)
	self.bubblePage = self:NewBubblePage(arg_1_2, arg_1_3)
	self.awardWindow = AwardWindow.New(arg_1_2, arg_1_3)
	self.resultPage = MonopolyCar2024TotalRewardPanel.New(arg_1_2, arg_1_3)
	self.awardCollector = MonopolyCar2024GameAwardCollector.New()

	self:UpdateActData(arg_1_1)

	return
end

function MonopolyCar2024Game:UpdateStory()
	return
end

function MonopolyCar2024Game:NewBubblePage(arg_3_1, arg_3_2)
	return MonopolyCar2024BubblePage.New(arg_3_1:Find("bubble"), arg_3_2)
end

function MonopolyCar2024Game:NewPickPage(arg_4_1, arg_4_2)
	return MonopolyCar2024PickPage.New(arg_4_1, arg_4_2)
end

function MonopolyCar2024Game:emit(...)
	self._event:emit(...)

	return
end

function MonopolyCar2024Game:UpdateActData(arg_6_1)
	self.actId = arg_6_1.id
	self.totalCnt = math.ceil((pg.TimeMgr.GetInstance():GetServerTime() - arg_6_1.data1) / 0) * arg_6_1:getDataConfig("daily_time") + (arg_6_1.data1_list[1] or 0)
	self.useCount = arg_6_1.data1_list[2] or 0
	self.leftCount = self.totalCnt - self.useCount
	self.dialogRecorder = arg_6_1.data4_list
	self.pickCharList = arg_6_1.data3_list
	self.pos = math.max(arg_6_1.data2, 1)
	self.step = arg_6_1.data3 or 0
	self.effectId = arg_6_1.data4 or 0
	self.turnCnt = arg_6_1.data1_list[3] or 0
	self.selectedShipId = arg_6_1.data1_list[4] or 0
	self.storys = arg_6_1:getDataConfig("story") or {}
	self.lapReward = arg_6_1:getDataConfig("sum_lap_reward_show") or {}
	self.titles = {
		i18n("MonopolyCar2024Game_title1"),
		i18n("MonopolyCar2024Game_title2")
	}
	self.pickableShipId = _.map(arg_6_1:getDataConfig("ship_reward"), function(arg_7_0)
		return arg_7_0[1]
	end)
	self.spEvents = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1:getDataConfig("ship_dialog") or {}) do
		self.spEvents[iter_6_1[1]] = iter_6_1[2]
	end

	self.cacheTurnCnt = self.turnCnt

	return
end

function MonopolyCar2024Game:Setup()
	self:BlocksRaycasts(false)
	seriesAsync({
		function(arg_9_0)
			self:InitUI()
			self:InitMap()
			self:InitCar(arg_9_0)

			return
		end,
		function(arg_10_0)
			self:InitCheerLeaders(arg_10_0)

			return
		end,
		function(arg_11_0)
			self:OnEnterDone(arg_11_0)

			return
		end,
		function(arg_12_0)
			self:RegisterUI()
			self:UpdateUI()
			self:SetUpMainLoop()
			self:CheckEventAndMove(arg_12_0)

			return
		end,
		function(arg_13_0)
			self:CheckSpEvent({
				finished = true,
				shipId = self.selectedShipId
			}, arg_13_0)

			return
		end,
		function(arg_14_0)
			self:CheckPickCharacter(arg_14_0)

			return
		end,
		function(arg_15_0)
			self:InitDone(arg_15_0)

			return
		end,
		function(arg_16_0)
			self:CheckMainStorys(arg_16_0)

			return
		end
	}, function()
		self:BlocksRaycasts(true)

		return
	end)

	return
end

function MonopolyCar2024Game:CheckMainStorys(arg_18_1)
	arg_18_1()

	return
end

function MonopolyCar2024Game:OnEnterDone(arg_19_1)
	arg_19_1()

	return
end

function MonopolyCar2024Game:InitDone(arg_20_1)
	arg_20_1()

	return
end

function MonopolyCar2024Game:InitCheerLeaders(arg_21_1)
	local var_21_0 = {}

	self.cheerLeaders = {}

	for iter_21_0, iter_21_1 in ipairs(var_0_6) do
		table.insert(var_21_0, function(arg_22_0)
			PoolMgr.GetInstance():GetSpineChar(iter_21_1, true, function(arg_23_0)
				arg_23_0.transform.localScale = Vector3(0.6, 0.6, 1)
				arg_23_0.transform.localPosition = var_0_7[iter_21_0]

				arg_23_0.transform:SetParent(self._tf, false)
				arg_23_0:GetComponent(typeof(SpineAnimUI)):SetAction("stand", 0)

				self.cheerLeaders[iter_21_1] = arg_23_0

				arg_22_0()

				return
			end)

			return
		end)
	end

	seriesAsync(var_21_0, arg_21_1)

	return
end

function MonopolyCar2024Game:SetUpMainLoop()
	self.handle = self.handle or UpdateBeat:CreateListener(self.Update, self)

	UpdateBeat:AddListener(self.handle)

	return
end

function MonopolyCar2024Game:Update()
	self:MoveCar()

	return
end

function MonopolyCar2024Game:InitUI()
	self.tplMapCell = findTF(self._tf, "mapContainer/tplMapCell")
	self.mapContainer = findTF(self._tf, "mapContainer")
	self.car = findTF(self._tf, "mapContainer/char")
	self.btnStart = findTF(self._tf, "btnStart")
	self.btnHelp = findTF(self._tf, "btnHelp")
	self.topTr = self._tf.parent:Find("top")
	self.btnAuto = findTF(self.topTr, "btnAuto")
	self.btnAutoImg = findTF(self.topTr, "btnAuto"):GetComponent(typeof(Image))
	self.btnAutoSel = findTF(self.topTr, "btnAuto/Text")
	self.btnAutoAct = findTF(self.topTr, "btnAuto/actvie")
	self.btnBack = findTF(self._tf.parent, "adapt_1/btnBack")
	self.labelLeftCount = findTF(self.btnStart, "Text")
	self.register = findTF(self._tf, "register")
	self.registerTxt = findTF(self._tf, "register/Text")
	self.rollStep = findTF(self._tf, "step")
	self.hideList = {
		self.btnStart,
		self.btnHelp,
		self.btnBack,
		self.btnAuto,
		self.register
	}

	self:SetRollStepAct(false)

	return
end

function MonopolyCar2024Game:RegisterUI()
	onButton(self, self.btnStart, function()
		if self.leftCount and self.leftCount <= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_count_noenough"))

			return
		end

		self:Roll()

		return
	end, SFX_PANEL)
	onButton(self, self.btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_monopoly_car2024.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.btnAuto, function()
		if self.autoFlag then
			self:DisableAuto()
		else
			self:EnableAuto()
		end

		return
	end, SFX_PANEL)
	onButton(self, self.btnBack, function()
		self:emit(BaseUI.ON_CLOSE)

		return
	end, SFX_BACK)
	onButton(self, self.register, function()
		self.awardWindow:ExecuteAction("Flush", self.lapReward, self.turnCnt - 1, self.titles)

		return
	end, SFX_PANEL)
	self:UpdateAutoBtn()

	return
end

function MonopolyCar2024Game:DisableAuto()
	self.autoFlag = false

	self:DisplayResult()
	self:UpdateAutoBtn()

	return
end

function MonopolyCar2024Game:EnableAuto()
	if self.rolling then
		return
	end

	if self.leftCount <= 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_count_noenough"))

		return
	end

	if self.useCount < 10 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("MonopolyCar2024Game_lock_auto_tip", self.useCount))

		return
	end

	self.awardCollector:SetUp()

	self.autoFlag = true

	self:RollAuto()
	self:UpdateAutoBtn()
	pg.TipsMgr.GetInstance():ShowTips(i18n("MonopolyCar2024Game_open_auto_tip"))

	return
end

function MonopolyCar2024Game:UpdateAutoBtn()
	local var_35_0 = self.useCount >= 10

	setActive(self.btnAutoSel, self.useCount >= 10)

	self.btnAutoImg.enabled = not var_35_0

	setActive(self.btnAutoAct, self.autoFlag)

	return
end

function MonopolyCar2024Game:DisplayResult()
	local var_36_0 = self.awardCollector:Fetch()

	if #var_36_0 <= 0 then
		return
	end

	self.resultPage:ExecuteAction("Show", var_36_0)

	return
end

function MonopolyCar2024Game:RollAuto()
	if not self.autoFlag then
		return
	end

	if self.leftCount <= 0 then
		self.autoFlag = false

		self:DisplayResult()
		self:UpdateAutoBtn()

		return
	end

	self:Roll(function()
		self:RollAuto()

		return
	end)

	return
end

function MonopolyCar2024Game:BlocksRaycasts(arg_39_1)
	self.cg.blocksRaycasts = arg_39_1

	setActive(self.maskTr, not arg_39_1)

	self.isBlocksRaycasts = not arg_39_1

	return
end

function MonopolyCar2024Game:Roll(arg_40_1)
	local var_40_0 = 0

	self:BlocksRaycasts(false)

	self.rolling = true

	seriesAsync({
		function(arg_41_0)
			self:emit(MonopolyCar2024Mediator.ON_START, self.actId, function(arg_42_0)
				if arg_42_0 and arg_42_0 > 0 then
					var_40_0 = arg_42_0

					arg_41_0()
				end

				return
			end)

			return
		end,
		function(arg_43_0)
			self:PlayRollAnimation(var_40_0, arg_43_0)

			return
		end,
		function(arg_44_0)
			self:CheckSpEvent({
				result = var_40_0,
				shipId = self.selectedShipId
			}, arg_44_0)

			return
		end,
		function(arg_45_0)
			self:CheckEventAndMove(arg_45_0)

			return
		end,
		function(arg_46_0)
			self:CheckSpStory(self.selectedShipId, arg_46_0)

			return
		end,
		function(arg_47_0)
			self:CheckSpEvent({
				finished = true,
				shipId = self.selectedShipId
			}, arg_47_0)

			return
		end,
		function(arg_48_0)
			self:CheckMainStorys(arg_48_0)

			return
		end
	}, function()
		self:UpdateAutoBtn()
		self:BlocksRaycasts(true)

		self.rolling = false

		if arg_40_1 then
			arg_40_1()
		end

		return
	end)

	return
end

function MonopolyCar2024Game:CheckSpStory(arg_50_1, arg_50_2)
	if not self.mapCells[self.pos] then
		arg_50_2()

		return
	end

	local var_50_0 = _.detect(pg.activity_event_monopoly_map[self.mapCells[self.pos].mapId].ship_event, function(arg_51_0)
		return arg_51_0[1] == arg_50_1
	end)

	if not var_50_0 then
		arg_50_2()

		return
	end

	local var_50_1 = var_50_0[2] or {}

	if #var_50_1 <= 0 then
		arg_50_2()

		return
	end

	local var_50_2 = var_50_1[math.random(1, #var_50_1)]

	self:HideOrShowUI(false)

	local function var_50_3()
		self:HideOrShowUI(true)
		arg_50_2()

		return
	end

	if self.autoFlag then
		pg.NewStoryMgr.GetInstance():ForceAutoPlay(var_50_2, var_50_3, true, true)
	else
		pg.NewStoryMgr.GetInstance():Play(var_50_2, var_50_3, true)
	end

	return
end

function MonopolyCar2024Game:PlayRollAnimation(arg_53_1, arg_53_2)
	setText(findTF(self.rollStep, "animroot/Image/Text"), "00")

	local var_53_0 = self.btnStart:GetComponent(typeof(Animation))
	local var_53_1 = var_53_0:GetComponent(typeof(DftAniEvent))
	local var_53_2 = findTF(self.rollStep, "animroot"):GetComponent(typeof(Animation))
	local var_53_3 = var_53_2:GetComponent(typeof(DftAniEvent))

	var_53_3:SetTriggerEvent(function()
		setText(findTF(self.rollStep, "animroot/Image/Text"), "0" .. arg_53_1)

		return
	end)
	seriesAsync({
		function(arg_55_0)
			var_53_1:SetEndEvent(function()
				setActive(self.btnStart, false)
				arg_55_0()

				return
			end)
			var_53_0:Play("anim_monopolycar_mainui_btn_hide")

			return
		end,
		function(arg_57_0)
			self:SetRollStepAct(true)
			arg_57_0()

			return
		end,
		function(arg_58_0)
			var_53_3:SetEndEvent(function()
				arg_58_0()

				return
			end)
			var_53_2:Play("anim_monopolycar_mainui_step_0" .. arg_53_1)

			return
		end,
		function(arg_60_0)
			var_53_3:SetEndEvent(function()
				self:SetRollStepAct(false)
				arg_60_0()

				return
			end)
			var_53_2:Play("anim_monopolycar_mainui_step_hide")

			return
		end
	}, function()
		setActive(self.btnStart, true)
		var_53_0:Play("anim_monopolycar_mainui_btn_show")
		arg_53_2()

		return
	end)

	return
end

function MonopolyCar2024Game:SetRollStepAct(arg_63_1)
	setActive(self.rollStep, arg_63_1)

	return
end

function MonopolyCar2024Game:CheckEventAndMove(arg_64_1)
	local function var_64_0()
		self:CheckEventAndMove(arg_64_1)

		return
	end

	if self.selectedShipId == 0 then
		self:CheckPickCharacter(var_64_0)
	elseif self.effectId and self.effectId > 0 then
		self:CheckEvent(var_64_0)
	elseif self.step and self.step > 0 then
		self:CheckMove(var_64_0)
	else
		arg_64_1()
	end

	return
end

function MonopolyCar2024Game:CheckEvent(arg_66_1)
	if not self.effectId or self.effectId <= 0 then
		if arg_66_1 then
			arg_66_1()
		end

		return
	end

	local var_66_1 = {}

	seriesAsync({
		function(arg_67_0)
			if not pg.activity_event_monopoly_event[self.effectId].story or tonumber(pg.activity_event_monopoly_event[self.effectId].story) == 0 then
				arg_67_0()

				return
			end

			self:HideOrShowUI(false)

			if self.autoFlag then
				pg.NewStoryMgr.GetInstance():ForceAutoPlay(pg.activity_event_monopoly_event[self.effectId].story, arg_67_0, true, true)
			else
				pg.NewStoryMgr.GetInstance():Play(pg.activity_event_monopoly_event[self.effectId].story, arg_67_0, true, true)
			end

			return
		end,
		function(arg_68_0)
			self:HideOrShowUI(true)
			self:TriggerEvent(function(arg_69_0)
				var_66_1 = arg_69_0

				arg_68_0()

				return
			end)

			return
		end,
		function(arg_70_0)
			self:ReadyMoveCar(var_66_1, arg_70_0)

			return
		end,
		function(arg_71_0)
			self:CheckCountStory(arg_71_0)

			return
		end
	}, arg_66_1)

	return
end

function MonopolyCar2024Game:HideOrShowUI(arg_72_1)
	for iter_72_0, iter_72_1 in ipairs(self.hideList) do
		setActive(iter_72_1, arg_72_1)
	end

	return
end

function MonopolyCar2024Game:TriggerEvent(arg_73_1)
	self:emit(MonopolyCar2024Mediator.ON_TRIGGER, self.actId, function(arg_74_0, arg_74_1)
		if arg_74_0 and #arg_74_0 >= 0 then
			arg_73_1(arg_74_0)
		end

		return
	end)

	return
end

function MonopolyCar2024Game:CheckCountStory(arg_75_1)
	local var_75_0 = self.useCount
	local var_75_1 = _.detect(self.storys, function(arg_76_0)
		return arg_76_0[1] == var_75_0
	end)

	if var_75_1 then
		pg.NewStoryMgr.GetInstance():Play(var_75_1[2], arg_75_1)
	else
		arg_75_1()
	end

	return
end

function MonopolyCar2024Game:CheckSpEvent(arg_77_1, arg_77_2)
	if arg_77_1.result and arg_77_1.result > 0 then
		self:CheckRollResultForSpEvent(arg_77_1.result, arg_77_1.shipId)

		if arg_77_2 then
			arg_77_2()
		end
	elseif arg_77_1.repeatChat then
		self:CheckRepeatCharForSpEvent(arg_77_1.shipId)

		if arg_77_2 then
			arg_77_2()
		end
	elseif arg_77_1.finished then
		self:CheckFinishedForSpEvent(arg_77_1.shipId)

		if arg_77_2 then
			arg_77_2()
		end
	elseif arg_77_2 then
		arg_77_2()
	end

	return
end

function MonopolyCar2024Game:CheckFinishedForSpEvent(arg_78_1)
	if self.turnCnt <= self.cacheTurnCnt then
		return
	end

	self.cacheTurnCnt = self.turnCnt

	local var_78_0 = _.select(self.spEvents[arg_78_1], function(arg_79_0)
		return arg_79_0[1] == 4
	end)

	if #var_78_0 <= 0 then
		return
	end

	self.bubblePage:Show(self.actId, arg_78_1, (self:GetUnReadDialogue(var_78_0[1][2] or {})))

	return
end

function MonopolyCar2024Game:CheckRepeatCharForSpEvent(arg_80_1)
	if not table.contains(self.pickCharList, arg_80_1) then
		return
	end

	local var_80_0 = _.select(self.spEvents[arg_80_1] or {}, function(arg_81_0)
		return arg_81_0[1] == 5
	end)

	if #var_80_0 <= 0 then
		return
	end

	self.bubblePage:Show(self.actId, arg_80_1, (self:GetUnReadDialogue(var_80_0[1][2] or {})))

	return
end

function MonopolyCar2024Game:GetUnReadDialogue(arg_82_1)
	local var_82_0 = {}

	for iter_82_0, iter_82_1 in ipairs(arg_82_1) do
		if not table.contains(self.dialogRecorder, iter_82_1) then
			table.insert(var_82_0, iter_82_1)
		end
	end

	if #var_82_0 <= 0 then
		return arg_82_1[math.random(1, #arg_82_1)]
	end

	return var_82_0[math.random(1, #var_82_0)]
end

function MonopolyCar2024Game:CheckRollResultForSpEvent(arg_83_1, arg_83_2)
	local var_83_0 = {
		{
			1,
			2
		},
		{
			3,
			4
		},
		{
			5,
			6
		}
	}

	assert(self.spEvents[arg_83_2], arg_83_2)

	local var_83_1 = _.select(self.spEvents[arg_83_2] or {}, function(arg_84_0)
		local var_84_0 = var_83_0[arg_84_0[1]] or {
			99,
			99
		}

		return arg_83_1 == var_84_0[1] or arg_83_1 == var_84_0[2]
	end)

	if #var_83_1 <= 0 then
		return
	end

	self.bubblePage:Show(self.actId, arg_83_2, (self:GetUnReadDialogue(var_83_1[1][2] or {})))

	return
end

function MonopolyCar2024Game:CheckMove(arg_85_1)
	local var_85_0 = {}

	seriesAsync({
		function(arg_86_0)
			self:emit(MonopolyCar2024Mediator.ON_MOVE, self.actId, function(arg_87_0, arg_87_1, arg_87_2)
				if not arg_87_0 or not arg_87_1 or not arg_87_2 then
					warning(arg_87_0, arg_87_1, arg_87_2)

					return
				end

				var_85_0 = arg_87_1

				arg_86_0()

				return
			end)

			return
		end,
		function(arg_88_0)
			self:ReadyMoveCar(var_85_0, arg_88_0)

			return
		end
	}, arg_85_1)

	return
end

function MonopolyCar2024Game:ReadyMoveCar(arg_89_1, arg_89_2)
	if not arg_89_1 or #arg_89_1 <= 0 then
		if arg_89_2 then
			arg_89_2()
		end

		return
	end

	local var_89_0 = {}
	local var_89_2 = {}
	local var_89_3 = {}

	for iter_89_0 = 1, #arg_89_1 do
		if self:CheckPathTurn(arg_89_1[iter_89_0]) then
			table.insert(var_89_2, self.mapCells[arg_89_1[iter_89_0]].position)
			table.insert(var_89_3, arg_89_1[iter_89_0])
		elseif iter_89_0 == #arg_89_1 then
			table.insert(var_89_2, self.mapCells[arg_89_1[iter_89_0]].position)
			table.insert(var_89_3, arg_89_1[iter_89_0])
		end
	end

	self.speedX = 0
	self.speedY = 0
	self.baseSpeed = 6
	self.baseASpeed = 0.1

	for iter_89_1 = 1, #var_89_2 do
		table.insert(var_89_0, function(arg_90_0)
			self.moveComplete = arg_90_0
			self.stopOnEnd = false
			self.targetPosition = var_89_2[iter_89_1]
			self.targetPosIndex = var_89_3[iter_89_1]
			self.moveX = self.targetPosition.x - self.car.localPosition.x
			self.moveY = self.targetPosition.y - self.car.localPosition.y
			self.baseSpeedX = self.baseSpeed * (self.moveX / math.abs(self.moveX))
			self.baseASpeedX = self.baseASpeed * (self.moveX / math.abs(self.moveX))
			self.baseSpeedY = math.abs(self.baseSpeedX) / (math.abs(self.moveX) / self.moveY)
			self.baseASpeedY = math.abs(self.baseASpeedX) / (math.abs(self.moveX) / self.moveY)

			if iter_89_1 == 1 then
				self.speedX = 0
				self.speedY = 0
			else
				self.speedX = self.baseSpeedX
				self.speedY = self.baseSpeedY
			end

			return
		end)
	end

	table.insert(var_89_0, function(arg_91_0)
		self.moveComplete = nil

		self:UpdateCarPos(arg_89_1[#arg_89_1], false)
		arg_91_0()

		return
	end)
	table.insert(var_89_0, function(arg_92_0)
		LeanTween.value(go(self._tf), 1, 0, 0.1):setOnComplete(System.Action(arg_92_0))

		return
	end)
	seriesAsync(var_89_0, arg_89_2)

	return
end

function MonopolyCar2024Game:MoveCar()
	if not self.targetPosition then
		return
	end

	if math.abs(self.targetPosition.x - self.car.localPosition.x) <= 6.5 and math.abs(self.targetPosition.y - self.car.localPosition.y) <= 6.5 then
		self.targetPosition = nil

		if self.moveComplete then
			self:UpdateCarPos(self.targetPosIndex, true)
			self.moveComplete()
		end
	end

	if math.abs(self.speedX + self.baseASpeedX) > math.abs(self.baseSpeedX) then
		self.speedX = self.baseSpeedX or self.speedX + self.baseASpeedX
	end

	if math.abs(self.speedY + self.baseASpeedY) > math.abs(self.baseSpeedY) then
		self.speedY = self.baseSpeedY or self.speedY + self.baseASpeedY
	end

	self.car.localPosition = Vector3(self.car.localPosition.x + self.speedX, self.car.localPosition.y + self.speedY, 0)

	return
end

function MonopolyCar2024Game:CheckPathTurn(arg_94_1)
	local var_94_0 = arg_94_1 + 1 > #self.mapCells and 1 or arg_94_1 + 1

	if arg_94_1 - 1 < 1 then
		local var_94_1 = #self.mapCells or arg_94_1 - 1

		if self.mapCells[var_94_0].col == self.mapCells[var_94_1].col or self.mapCells[var_94_0].row == self.mapCells[var_94_1].row then
			return false
		end
	end

	return true
end

function MonopolyCar2024Game:CheckPickCharacter(arg_95_1)
	if self.selectedShipId == 0 or #self.pickCharList == 0 then
		self.pickPage:ExecuteAction("Show", self.actId, _.map(self.pickCharList, function(arg_100_0)
			return table.indexof(self.pickableShipId, arg_100_0)
		end), self.autoFlag, self.turnCnt, function(arg_96_0)
			self:CheckSpEvent({
				repeatChat = true,
				shipId = self.pickableShipId[arg_96_0]
			})
			self:emit(MonopolyCar2024Mediator.ON_PICK, self.actId, self.pickableShipId[arg_96_0], function(arg_97_0)
				self.pickPage:Hide()
				seriesAsync({
					function(arg_98_0)
						self:ReadyMoveCar(arg_97_0, arg_98_0)

						return
					end,
					function(arg_99_0)
						self:CheckEventAndMove(arg_99_0)

						return
					end
				}, arg_95_1)

				return
			end)

			return
		end)
	else
		arg_95_1()
	end

	return
end

function MonopolyCar2024Game:InitMap()
	self.mapCells = {}

	for iter_101_0 = 1, #var_0_4 do
		local var_101_0 = {
			x = -(iter_101_0 - 1) * var_0_1,
			y = -(iter_101_0 - 1) * var_0_2
		}

		for iter_101_1 = 1, #var_0_4[iter_101_0] do
			if var_0_4[iter_101_0][iter_101_1] > 0 then
				local var_101_1 = cloneTplTo(self.tplMapCell, self.mapContainer, tostring(var_0_4[iter_101_0][iter_101_1]))
				local var_101_2 = Vector2(var_0_1 * (iter_101_1 - 1) + var_101_0.x, -var_0_2 * (iter_101_1 - 1) + var_101_0.y)

				var_101_1.localPosition = var_101_2
				var_101_1:GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/MonopolyCar2024_atlas", pg.activity_event_monopoly_map[var_0_4[iter_101_0][iter_101_1]].icon)

				var_101_1:GetComponent(typeof(Image)):SetNativeSize()
				table.insert(self.mapCells, {
					col = iter_101_1 - 1,
					row = iter_101_0 - 1,
					mapId = var_0_4[iter_101_0][iter_101_1],
					tf = var_101_1,
					icon = pg.activity_event_monopoly_map[var_0_4[iter_101_0][iter_101_1]].icon,
					position = var_101_2
				})
			end
		end
	end

	table.sort(self.mapCells, function(arg_102_0, arg_102_1)
		return arg_102_0.mapId < arg_102_1.mapId
	end)

	return
end

function MonopolyCar2024Game:InitCar(arg_103_1)
	PoolMgr.GetInstance():GetSpineChar(var_0_3, true, function(arg_104_0)
		self.model = arg_104_0
		self.model.transform.localScale = Vector3.one
		self.model.transform.localPosition = Vector3.zero

		self.model.transform:SetParent(self.car, false)

		self.anim = self.model:GetComponent(typeof(SpineAnimUI))

		if self.pos then
			self:UpdateCarPos(self.pos, false)
		end

		arg_103_1()

		return
	end)

	return
end

function MonopolyCar2024Game:UpdateCarPos(arg_105_1, arg_105_2)
	if self.model then
		assert(self.mapCells[arg_105_1], arg_105_1)

		local var_105_0 = self.mapCells[arg_105_1].position
		local var_105_2, var_105_3 = self:GetCarMoveType(self.mapCells[arg_105_1].mapId, self.mapCells[arg_105_1 + 1 > #self.mapCells and 1 or arg_105_1 + 1].mapId, arg_105_2)

		self.car.localScale = var_105_3

		self.anim:SetActionCallBack(nil)
		self.anim:SetAction(var_105_2, 0)

		self.car.localPosition = var_105_0

		self.car:SetAsLastSibling()
	end

	return
end

function MonopolyCar2024Game:GetCarMoveType(arg_106_1, arg_106_2, arg_106_3)
	local var_106_0 = {}
	local var_106_1 = {}

	for iter_106_0 = 1, #var_0_4 do
		for iter_106_1 = 1, #var_0_4[iter_106_0] do
			if var_0_4[iter_106_0][iter_106_1] == arg_106_1 then
				var_106_0 = {
					x = iter_106_1,
					y = iter_106_0
				}
			end

			if var_0_4[iter_106_0][iter_106_1] == arg_106_2 then
				var_106_1 = {
					x = iter_106_1,
					y = iter_106_0
				}
			end
		end
	end

	local var_106_2
	local var_106_3

	if var_106_1.y > var_106_0.y then
		var_106_2 = arg_106_3 and var_0_11 or var_0_9
		var_106_3 = Vector3(var_0_5, var_0_5, var_0_5)
	elseif var_106_1.y < var_106_0.y then
		var_106_2 = arg_106_3 and var_0_10 or var_0_8
		var_106_3 = Vector3(var_0_5, var_0_5, var_0_5)
	elseif var_106_1.x > var_106_0.x then
		var_106_2 = arg_106_3 and var_0_11 or var_0_9
		var_106_3 = Vector3(-var_0_5, var_0_5, var_0_5)
	elseif var_106_1.x < var_106_0.x then
		var_106_2 = arg_106_3 and var_0_10 or var_0_8
		var_106_3 = Vector3(-var_0_5, var_0_5, var_0_5)
	end

	return var_106_2, var_106_3
end

function MonopolyCar2024Game:UpdateUI()
	setText(self.labelLeftCount, self.leftCount)
	setText(self.registerTxt, self.turnCnt - 1)

	return
end

function MonopolyCar2024Game:UpdateActivity(arg_108_1)
	self:UpdateActData(arg_108_1)
	self:UpdateUI()

	return
end

function MonopolyCar2024Game:Dispose()
	for iter_109_0, iter_109_1 in pairs(self.cheerLeaders or {}) do
		PoolMgr.GetInstance():ReturnSpineChar(iter_109_0, iter_109_1)
	end

	if self.handle then
		UpdateBeat:RemoveListener(self.handle)

		self.handle = nil
	end

	if self.awardWindow then
		self.awardWindow:Destroy()

		self.awardWindow = nil
	end

	if self.pickPage then
		if self.pickPage:isShowing() then
			self.pickPage:Hide()
		end

		self.pickPage:Destroy()

		self.pickPage = nil
	end

	if self.resultPage then
		self.resultPage:Destroy()

		self.resultPage = nil
	end

	if self.awardCollector then
		self.awardCollector:Dispose()

		self.awardCollector = nil
	end

	self.bubblePage:Dispose()
	pg.DelegateInfo.Dispose(self)
	PoolMgr.GetInstance():ReturnSpineChar(var_0_3, self.model)

	return
end

return MonopolyCar2024Game
