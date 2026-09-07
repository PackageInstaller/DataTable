local ValentineQteGamePage = class("ValentineQteGamePage")

function ValentineQteGamePage:Ctor(arg_1_1)
	pg.DelegateInfo.New(self)

	self._tf = arg_1_1

	self:Init()

	return
end

function ValentineQteGamePage:Init()
	self.root = findTF(self._tf, "root")
	self.slideWay = findTF(self._tf, "slideway")
	self.slider = findTF(self._tf, "slider")
	self.goodArea = findTF(self._tf, "good")
	self.greatArea = findTF(self._tf, "great")
	self.perfectArea = findTF(self._tf, "perfect")
	self.scoreTxt = findTF(self._tf, "score/Text"):GetComponent(typeof(Text))
	self.comboTxt = findTF(self._tf, "score/combo"):GetComponent(typeof(Text))

	findTF(self._tf, "score/label"):GetComponent(typeof(Image)):SetNativeSize()

	self.refrigerator = findTF(self._tf, "bg/refrigerator"):GetComponent(typeof(SpineAnimUI))
	self.char = findTF(self._tf, "bg/char"):GetComponent(typeof(SpineAnimUI))
	self.backBtn = findTF(self._tf, "back")
	self.puaseBtn = findTF(self._tf, "pause")
	self.timeTxt = findTF(self._tf, "time/Text"):GetComponent(typeof(Text))
	self.lineTr = findTF(self._tf, "slideway/line")

	setActive(self.lineTr, false)

	self.itemContainer = findTF(self._tf, "items")
	self.effectContainer = findTF(self._tf, "effects")
	self.finger = findTF(self._tf, "finger")
	self.gearTr = findTF(self._tf, "gear"):GetComponent(typeof(Image))
	self.gearTrPos = self.gearTr.transform.localPosition.y
	self.gearSps = {
		[ValentineQteGameConst.OP_SCORE_GEAR_PERFECT] = GetSpriteFromAtlas("ui/minigameui/valentineqtegame_atlas", "Perfect"),
		[ValentineQteGameConst.OP_SCORE_GEAR_GREAT] = GetSpriteFromAtlas("ui/minigameui/valentineqtegame_atlas", "Great"),
		[ValentineQteGameConst.OP_SCORE_GEAR_GOOD] = GetSpriteFromAtlas("ui/minigameui/valentineqtegame_atlas", "Good"),
		[ValentineQteGameConst.OP_SCORE_GEAR_MISS] = GetSpriteFromAtlas("ui/minigameui/valentineqtegame_atlas", "Miss")
	}
	self.msgBox = ValentineQteGameMsgBox.New(self._tf:Find("msgbox"))
	self.itemPoolMgr = ValentineQteGamePoolMgr.New(self._tf:Find("root/item"), 2, 4)
	self.resultWindow = ValentineQteGameResultWindow.New(self._tf:Find("result_panel"))
	self.countDownWindow = findTF(self._tf, "countdown")
	self.countDown1 = findTF(self._tf, "countdown/1")
	self.countDown2 = findTF(self._tf, "countdown/2")
	self.countDown3 = findTF(self._tf, "countdown/3")
	self.effectPools = {}

	return
end

function ValentineQteGamePage:SetUp(arg_3_1, arg_3_2, arg_3_3)
	self.onComplete = arg_3_1
	self.onExist = arg_3_2
	self.isClick = not arg_3_3

	self:Show()

	return
end

function ValentineQteGamePage:Show()
	self:UpdateFinger()
	parallelAsync({
		function(arg_5_0)
			self:CountDown(arg_5_0)

			return
		end,
		function(arg_6_0)
			seriesAsync({
				function(arg_7_0)
					self:LoadEffects(arg_7_0)

					return
				end,
				function(arg_8_0)
					self:InitGame(arg_8_0)

					return
				end,
				function(arg_9_0)
					self:Reset(arg_9_0)

					return
				end
			}, arg_6_0)

			return
		end
	}, function()
		self:StartGame()

		return
	end)

	return
end

function ValentineQteGamePage:CountDown(arg_11_1)
	local function var_11_0(arg_12_0)
		setActive(self.countDown1, arg_12_0 == 3)
		setActive(self.countDown2, arg_12_0 == 2)
		setActive(self.countDown3, arg_12_0 == 1)

		return
	end

	setActive(self.countDownWindow, true)

	local var_11_1 = 1

	self.countDownTimer = Timer.New(function()
		var_11_1 = var_11_1 + 1

		var_11_0(var_11_1)

		if var_11_1 == 4 then
			setActive(self.countDownWindow, false)
			arg_11_1()
		end

		return
	end, 1, 3)

	self.countDownTimer:Start()
	var_11_0(1)

	return
end

function ValentineQteGamePage:LoadEffects(arg_14_1)
	parallelAsync({
		function(arg_15_0)
			LoadAndInstantiateAsync("ui", "chufang_Prefect", function(arg_16_0)
				SetParent(arg_16_0, self.root)

				self.effectPools[ValentineQteGameConst.OP_SCORE_GEAR_PERFECT] = ValentineQteGamePoolMgr.New(arg_16_0, 1, 2)

				arg_15_0()

				return
			end)

			return
		end,
		function(arg_17_0)
			LoadAndInstantiateAsync("ui", "chufang_Great", function(arg_18_0)
				SetParent(arg_18_0, self.root)

				self.effectPools[ValentineQteGameConst.OP_SCORE_GEAR_GREAT] = ValentineQteGamePoolMgr.New(arg_18_0, 1, 2)

				arg_17_0()

				return
			end)

			return
		end,
		function(arg_19_0)
			LoadAndInstantiateAsync("ui", "chufang_Good", function(arg_20_0)
				SetParent(arg_20_0, self.root)

				self.effectPools[ValentineQteGameConst.OP_SCORE_GEAR_GOOD] = ValentineQteGamePoolMgr.New(arg_20_0, 1, 2)

				arg_19_0()

				return
			end)

			return
		end,
		function(arg_21_0)
			LoadAndInstantiateAsync("ui", "chufang_Miss", function(arg_22_0)
				SetParent(arg_22_0, self.root)

				self.effectPools[ValentineQteGameConst.OP_SCORE_GEAR_MISS] = ValentineQteGamePoolMgr.New(arg_22_0, 1, 2)

				arg_21_0()

				return
			end)

			return
		end,
		function(arg_23_0)
			LoadAndInstantiateAsync("ui", "chufang_shiqu", function(arg_24_0)
				SetParent(arg_24_0, self.root)

				self.pickPool = ValentineQteGamePoolMgr.New(arg_24_0, 1, 2)

				arg_23_0()

				return
			end)

			return
		end
	}, arg_14_1)

	return
end

function ValentineQteGamePage:InitGame(arg_25_1)
	self.slideWay.sizeDelta = Vector2(ValentineQteGameConst.SLIDEWAY_WIDTH, self.slideWay.sizeDelta.y)
	self.slider.sizeDelta = Vector2(ValentineQteGameConst.SLIDER_WIDTH, self.slider.sizeDelta.y)
	self.goodArea.sizeDelta = Vector2(ValentineQteGameConst.GOOD_WIDTH, self.goodArea.sizeDelta.y)
	self.greatArea.sizeDelta = Vector2(ValentineQteGameConst.GREAT_WIDTH, self.greatArea.sizeDelta.y)
	self.perfectArea.sizeDelta = Vector2(ValentineQteGameConst.PERFECT_WIDTH, self.perfectArea.sizeDelta.y)
	self.scoreTxt.text = 0
	self.comboTxt.text = 0
	self.slideWay.localPosition = Vector3(0, self.slideWay.localPosition.y, 0)
	self.goodArea.localPosition = Vector3(0, self.goodArea.localPosition.y, 0)
	self.greatArea.localPosition = Vector3(0, self.greatArea.localPosition.y, 0)
	self.perfectArea.localPosition = Vector3(0, self.perfectArea.localPosition.y, 0)
	self.missMinPosX, self.missMaxPosX = self:CalcGearArea(self.slideWay, self.slider.sizeDelta.x * 0.5)
	self.goodMinPosX, self.goodMaxPosX = self:CalcGearArea(self.goodArea, self.slider.sizeDelta.x * 0.5)
	self.greatMinPosX, self.greatMaxPosX = self:CalcGearArea(self.greatArea, self.slider.sizeDelta.x * 0.5)
	self.prefectMinPosX, self.prefectMaxPosX = self:CalcGearArea(self.perfectArea, self.slider.sizeDelta.x * 0.5)
	self.slider.localPosition = Vector3(self.missMinPosX, self.slideWay.localPosition.y, 0)
	self.itemGenMinArea = Vector2(self.missMinPosX - self.slider.sizeDelta.x * 0.5 + 40, self.goodMinPosX - self.slider.sizeDelta.x * 0.5 - 40)
	self.itemGenMaxArea = Vector2(self.goodMaxPosX + self.slider.sizeDelta.x * 0.5 + 40, self.missMaxPosX + self.slider.sizeDelta.x * 0.5 - 40)

	if ValentineQteGameConst.DEBUG then
		self:InitDebugView()
	end

	arg_25_1()

	return
end

function ValentineQteGamePage:Reset(arg_26_1)
	self.speedX = ValentineQteGameConst.INIT_SPEED
	self.time = ValentineQteGameConst.GMAE_TIME
	self.comboCnt = 0
	self.score = 0
	self.opCdTime = 0
	self.elapseTimes = {}
	self.accelerated = 0
	self.items = {}
	self.genItemTime = 0
	self.gearShowTime = 0
	self.timers = {}
	self.startFlag = false
	self.statistics = {
		Score = 0,
		Combo = 0,
		Great = 0,
		Perfect = 0,
		Good = 0,
		Miss = 0
	}

	arg_26_1()

	return
end

function ValentineQteGamePage:InitDebugView()
	self:CreateDebugLinePos("missMinPosX")
	self:CreateDebugLinePos("missMaxPosX")
	self:CreateDebugLinePos("goodMinPosX")
	self:CreateDebugLinePos("goodMaxPosX")
	self:CreateDebugLinePos("greatMinPosX")
	self:CreateDebugLinePos("greatMaxPosX")
	self:CreateDebugLinePos("prefectMinPosX")
	self:CreateDebugLinePos("prefectMaxPosX")
	self:CreateDebugArea("itemGenMinArea")
	self:CreateDebugArea("itemGenMaxArea")

	return
end

function ValentineQteGamePage:CreateDebugArea(arg_28_1)
	local var_28_0 = cloneTplTo(self.lineTr, self.lineTr.parent, arg_28_1 .. "01")

	var_28_0.localPosition = Vector3(self[arg_28_1].x, var_28_0.localPosition.y, 0)

	setActive(var_28_0, true)

	local var_28_1 = cloneTplTo(self.lineTr, self.lineTr.parent, arg_28_1 .. "02")

	var_28_1.localPosition = Vector3(self[arg_28_1].y, var_28_1.localPosition.y, 0)

	setActive(var_28_1, true)

	return
end

function ValentineQteGamePage:CreateDebugLinePos(arg_29_1)
	local var_29_0 = cloneTplTo(self.lineTr, self.lineTr.parent, arg_29_1)

	var_29_0.localPosition = Vector3(self[arg_29_1], var_29_0.localPosition.y, 0)

	setActive(var_29_0, true)

	return
end

function ValentineQteGamePage:CalcGearArea(arg_30_1, arg_30_2)
	return -arg_30_1.sizeDelta.x * 0.5 + arg_30_2, arg_30_1.sizeDelta.x * 0.5 - arg_30_2
end

function ValentineQteGamePage:StartGame()
	self.startFlag = true
	self.handle = self.handle or UpdateBeat:CreateListener(self.UpdateGame, self)

	UpdateBeat:AddListener(self.handle)
	self.char:SetAction("1", 0)
	onButton(self, self.puaseBtn, function()
		if not self.puaseGameFlag then
			self:PuaseGame()
			self.msgBox:Show({
				noNo = true,
				content = ValentineQteGameMsgBox.PAUSE_TXT,
				onYes = function()
					self:ResumeGame()

					return
				end,
				onNo = function()
					self:ResumeGame()

					return
				end
			})
		else
			self:ResumeGame()
		end

		return
	end, SFX_PANEL)
	onButton(self, self.backBtn, function()
		self:PuaseGame()
		self.msgBox:Show({
			content = ValentineQteGameMsgBox.EXIT_TXT,
			onYes = function()
				self:EndGame(true)

				return
			end,
			onNo = function()
				self:ResumeGame()

				return
			end
		})

		return
	end, SFX_PANEL)

	self.dragDelegate = GetOrAddComponent(self._tf, "EventTriggerListener")

	self.dragDelegate:AddPointDownFunc(function()
		self.isClick = true

		if self.opCdTime <= 0 and not self.puaseGameFlag then
			self:Snap()

			self.opCdTime = ValentineQteGameConst.OP_INTERVAL
		end

		self:UpdateFinger()

		return
	end)

	return
end

function ValentineQteGamePage:UpdateFinger()
	setActive(self.finger, not self.isClick)

	return
end

function ValentineQteGamePage:UpdateGame()
	if self.puaseGameFlag then
		return
	end

	self:HideGear()
	self:CheckDisapperItems()
	self:UpdateSlider()
	self:UpdateSpeed()
	self:UpdateTime()
	self:UpdateOpCdTime()
	self:CheckAndGenItem()
	self:CheckInteraction()

	return
end

function ValentineQteGamePage:CheckInteraction()
	if not self.isInteraction and (function()
		return self.time <= ValentineQteGameConst.OPEN_DOOR_TIME
	end)() then
		self.isInteraction = true

		self.refrigerator:SetActionCallBack(function(arg_43_0)
			if arg_43_0 == "finish" then
				self.refrigerator:SetActionCallBack(nil)
				self.refrigerator:SetAction("3", 0)
			end

			return
		end)
		self.refrigerator:SetAction("2", 0)
	end

	return
end

function ValentineQteGamePage:HideGear()
	if self.gearShowTime <= 0 then
		return
	end

	if self.gearShowTime - self.time >= ValentineQteGameConst.GEAR_SHOW_TIME then
		self.gearShowTime = 0

		setActive(self.gearTr.gameObject, false)
	end

	return
end

function ValentineQteGamePage:CheckDisapperItems()
	for iter_45_0 = #self.items, 1, -1 do
		if self.items[iter_45_0]:ShouldDisapper(self.time) then
			self.items[iter_45_0]:Destroy()
			self.itemPoolMgr:Enqueue(self.items[iter_45_0]._go)
			table.remove(self.items, iter_45_0)
		end
	end

	return
end

function ValentineQteGamePage:CheckAndGenItem()
	if #self.items >= ValentineQteGameConst.MAX_ITEM_COUNT then
		return
	end

	if self.genItemTime == 0 and self.time <= ValentineQteGameConst.GMAE_TIME - ValentineQteGameConst.GEN_ITEM_FIRST_TIME or self.genItemTime > 0 and self.genItemTime - self.time > ValentineQteGameConst.GEN_ITEM_INTERVAL then
		self:RandomItemPosition(0)
	end

	return
end

function ValentineQteGamePage:IsValidItemPos(arg_47_1)
	for iter_47_0, iter_47_1 in ipairs(self.items) do
		if not iter_47_1:IsSufficientLength(arg_47_1, self.slider.sizeDelta.x + 80) then
			return false
		end
	end

	return true
end

function ValentineQteGamePage:RandomItemPosition(arg_48_1)
	if arg_48_1 > 10 then
		return
	end

	local var_48_0

	if math.random(1, 2) % 2 == 0 then
		var_48_0 = self.itemGenMinArea or self.itemGenMaxArea
	end

	local var_48_1 = math.random(var_48_0.x, var_48_0.y)

	if self:IsValidItemPos(var_48_1) then
		self.genItemTime = self.time

		local var_48_2 = self.itemPoolMgr:Dequeue()

		SetParent(var_48_2, self.itemContainer)
		table.insert(self.items, (ValentineQteGameItem.New(var_48_2, Vector2(var_48_1, self.slider.localPosition.y), self.time)))
	else
		self:RandomItemPosition(arg_48_1 + 1)
	end

	return
end

function ValentineQteGamePage:UpdateSlider()
	local var_49_0 = self.slider.localPosition

	if self.slider.localPosition.x == self.missMinPosX or var_49_0.x == self.missMaxPosX then
		self.speedX = -self.speedX
	end

	self.slider.localPosition = Vector3(math.clamp(var_49_0.x + self.speedX * Time.deltaTime, self.missMinPosX, self.missMaxPosX), var_49_0.y, 0)

	return
end

function ValentineQteGamePage:UpdateTime()
	self.time = self.time - Time.deltaTime

	if self.time <= 0 then
		self:EndGame(true)
	end

	self:UpdateTimeText(self.time)

	return
end

function ValentineQteGamePage:UpdateSpeed()
	local var_51_0 = math.floor(math.ceil(ValentineQteGameConst.GMAE_TIME - self.time) / 5)

	if var_51_0 > 0 and not self.elapseTimes[var_51_0] and self.accelerated + ValentineQteGameConst.INIT_SPEED < ValentineQteGameConst.MAX_SPEED then
		self.elapseTimes[var_51_0] = true
		self.accelerated = self.accelerated + ValentineQteGameConst.SPEED_UP
		self.speedX = self.speedX < 0 and self.speedX - self.accelerated or self.speedX + self.accelerated
	end

	return
end

function ValentineQteGamePage:UpdateOpCdTime()
	if self.opCdTime > 0 then
		self.opCdTime = math.max(0, self.opCdTime - Time.deltaTime)
	end

	return
end

function ValentineQteGamePage:Snap()
	local var_53_0 = self:GetScoreGear(self.slider.localPosition.x)
	local var_53_1 = {}
	local var_53_2 = false

	if var_53_0 == ValentineQteGameConst.OP_SCORE_GEAR_GREAT then
		self.comboCnt = self.comboCnt + 1
		self.statistics.Great = self.statistics.Great + 1
	elseif var_53_0 == ValentineQteGameConst.OP_SCORE_GEAR_PERFECT then
		self.comboCnt = self.comboCnt + 1
		self.statistics.Perfect = self.statistics.Perfect + 1
	elseif self:CanPickItem(self.slider.localPosition.x, var_53_1) then
		self.comboCnt = self.comboCnt + 1
		var_53_0 = ValentineQteGameConst.OP_SCORE_GEAR_PERFECT
		self.statistics.Perfect = self.statistics.Perfect + 1

		self:PickItems(var_53_1)

		var_53_2 = true
	elseif var_53_0 == ValentineQteGameConst.OP_SCORE_GEAR_MISS then
		self.comboCnt = 0
		self.statistics.Miss = self.statistics.Miss + 1
	elseif var_53_0 == ValentineQteGameConst.OP_SCORE_GEAR_GOOD then
		self.comboCnt = 0
		self.statistics.Good = self.statistics.Good + 1
	end

	self.score = self.score + self:GetScore(var_53_0, self.comboCnt)

	self:UpdateScoreText(self.score)
	self:UpdateComboText(self.comboCnt)

	if self.comboCnt > self.statistics.Combo then
		self.statistics.Combo = self.comboCnt
	end

	self:UpdateGear(var_53_0, var_53_2)

	return
end

function ValentineQteGamePage:UpdateGear(arg_54_1, arg_54_2)
	if LeanTween.isTweening(self.gearTr.gameObject) then
		LeanTween.cancel(self.gearTr.gameObject)
	end

	self.gearTr.sprite = self.gearSps[arg_54_1]

	self.gearTr:SetNativeSize()

	self.gearShowTime = self.time

	setActive(self.gearTr.gameObject, true)

	if arg_54_2 then
		setActive(self.gearTr.gameObject, false)
		self:GenEffect(ValentineQteGameConst.OP_SCORE_GEAR_GREAT)
		self:PlaySound(ValentineQteGameConst.SOUND_PICK_ITEM)
	else
		self:GenEffect(arg_54_1)
		self:GearAnim()
		self:PlaySound(ValentineQteGameConst.GEAR_SOUND[arg_54_1])
	end

	return
end

function ValentineQteGamePage:PlaySound(arg_55_1)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(arg_55_1)

	return
end

function ValentineQteGamePage:GearAnim()
	self.gearTr.gameObject.transform.localPosition = Vector3(self.gearTr.gameObject.transform.localPosition.x, self.gearTrPos, 0)

	LeanTween.value(self.gearTr.gameObject, self.gearTrPos, self.gearTrPos + 50, 0.3):setOnUpdate(System.Action_float(function(arg_57_0)
		self.gearTr.gameObject.transform.localPosition = Vector3(self.gearTr.gameObject.transform.localPosition.x, arg_57_0, 0)

		return
	end)):setOnComplete(System.Action(function()
		setActive(self.gearTr.gameObject, false)

		return
	end))

	return
end

function ValentineQteGamePage:GenEffect(arg_59_1)
	local var_59_0 = self.effectPools[arg_59_1]
	local var_59_1 = self.effectPools[arg_59_1]:Dequeue()

	SetParent(var_59_1, self.effectContainer)

	var_59_1.transform.localPosition = Vector3(self.slider.localPosition.x, self.slider.localPosition.y, -100)

	local var_59_2 = Timer.New(function()
		var_59_0:Enqueue(var_59_1)

		return
	end, 2, 1)

	var_59_2:Start()
	table.insert(self.timers, var_59_2)

	return
end

function ValentineQteGamePage:CanPickItem(arg_61_1, arg_61_2)
	for iter_61_0, iter_61_1 in ipairs(self.items) do
		if iter_61_1:IsOverlap(self.slider) then
			table.insert(arg_61_2, iter_61_1)
		end
	end

	return #arg_61_2 > 0
end

function ValentineQteGamePage:PickItems(arg_62_1)
	for iter_62_0, iter_62_1 in ipairs(arg_62_1) do
		self:PlayPickAnim(iter_62_1, function()
			iter_62_1:Destroy()
			self.itemPoolMgr:Enqueue(iter_62_1._tf)

			return
		end)
		table.removebyvalue(self.items, iter_62_1)
	end

	return
end

function ValentineQteGamePage:PlayPickAnim(arg_64_1, arg_64_2)
	LeanTween.value(arg_64_1._go, arg_64_1._tf.localPosition.y, arg_64_1._tf.localPosition.y + 70, 0.3):setOnUpdate(System.Action_float(function(arg_65_0)
		arg_64_1._tf.localPosition = Vector3(arg_64_1._tf.localPosition.x, arg_65_0, 0)

		return
	end)):setOnComplete(System.Action(function()
		local var_66_0 = self.pickPool:Dequeue()

		SetParent(var_66_0, self.effectContainer)

		var_66_0.transform.localPosition = Vector3(arg_64_1._tf.localPosition.x, arg_64_1._tf.localPosition.y, -100)

		local var_66_1 = Timer.New(function()
			self.pickPool:Enqueue(var_66_0)

			return
		end, 2, 1)

		var_66_1:Start()
		table.insert(self.timers, var_66_1)
		arg_64_2()

		return
	end))

	return
end

function ValentineQteGamePage:UpdateTimeText(arg_68_1)
	local var_68_0 = math.ceil(arg_68_1)

	self.timeTxt.text = var_68_0 <= 0 and "0" or math.max(0, var_68_0)

	return
end

function ValentineQteGamePage:UpdateScoreText(arg_69_1)
	self.scoreTxt.text = arg_69_1

	return
end

function ValentineQteGamePage:UpdateComboText(arg_70_1)
	self.comboTxt.text = arg_70_1

	return
end

function ValentineQteGamePage:GetScoreGear(arg_71_1)
	if arg_71_1 >= self.prefectMinPosX and arg_71_1 <= self.prefectMaxPosX then
		return ValentineQteGameConst.OP_SCORE_GEAR_PERFECT
	end

	if arg_71_1 >= self.greatMinPosX and arg_71_1 <= self.greatMaxPosX then
		return ValentineQteGameConst.OP_SCORE_GEAR_GREAT
	end

	if arg_71_1 >= self.goodMinPosX and arg_71_1 <= self.goodMaxPosX then
		return ValentineQteGameConst.OP_SCORE_GEAR_GOOD
	end

	return ValentineQteGameConst.OP_SCORE_GEAR_MISS
end

function ValentineQteGamePage:GetScore(arg_72_1, arg_72_2)
	local var_72_0 = 0

	for iter_72_0, iter_72_1 in ipairs(ValentineQteGameConst.COMBO_EXTRA_SCORE_RATIO) do
		if iter_72_1[1] <= arg_72_2 and arg_72_2 <= iter_72_1[2] then
			var_72_0 = iter_72_1[3]

			break
		end
	end

	return ValentineQteGameConst.BASE_OP_SCORE * ValentineQteGameConst.OP_SCORE[arg_72_1] + ValentineQteGameConst.BASE_OP_SCORE * var_72_0 * 0.01
end

function ValentineQteGamePage:PuaseGame()
	self.puaseGameFlag = true

	self.char:Pause()

	return
end

function ValentineQteGamePage:ResumeGame()
	self.puaseGameFlag = false

	self.char:Resume()

	return
end

function ValentineQteGamePage:EndGame(arg_75_1)
	if self.handle then
		UpdateBeat:RemoveListener(self.handle)
	end

	ClearEventTrigger(self.dragDelegate)
	removeOnButton(self.puaseBtn)

	if arg_75_1 then
		self.statistics.Score = self.score

		self.resultWindow:Show(self.statistics, function()
			self:Destroy()

			return
		end)
	end

	if self.onComplete and arg_75_1 then
		self.onComplete()
	end

	self.onComplete = nil

	return
end

function ValentineQteGamePage:ExitGame()
	self:EndGame(false)

	if self.onExist then
		self.onExist()

		self.onExist = nil
	end

	return
end

function ValentineQteGamePage:onBackPressed()
	if self.startFlag and not self.puaseGameFlag then
		triggerButton(self.puaseBtn)

		return true
	end

	if isActive(self.msgBox._tf) then
		triggerButton(self.msgBox.cancelBtn)

		return true
	end

	return false
end

function ValentineQteGamePage:Destroy()
	if self.countDownTimer then
		self.countDownTimer:Stop()

		self.countDownTimer = nil
	end

	if LeanTween.isTweening(self.gearTr.gameObject) then
		LeanTween.cancel(self.gearTr.gameObject)
	end

	for iter_79_0, iter_79_1 in ipairs(self.timers) do
		iter_79_1:Stop()
	end

	self.timers = nil

	for iter_79_2, iter_79_3 in pairs(self.effectPools) do
		iter_79_3:Destroy()
	end

	self.effectPools = nil

	self.refrigerator:SetActionCallBack(nil)

	if self.msgBox then
		self.msgBox:Destroy()

		self.msgBox = nil
	end

	if self.resultWindow then
		self.resultWindow:Destroy()

		self.resultWindow = nil
	end

	self:ExitGame()
	pg.DelegateInfo.Dispose(self)

	if self.itemPoolMgr then
		self.itemPoolMgr:Destroy()

		self.itemPoolMgr = nil
	end

	self.gearSps = nil

	return
end

return ValentineQteGamePage
