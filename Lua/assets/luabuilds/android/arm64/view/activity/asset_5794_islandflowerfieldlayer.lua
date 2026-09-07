local IslandFlowerFieldLayer = class("IslandFlowerFieldLayer", import("..base.BaseUI"))

function IslandFlowerFieldLayer:getUIName()
	return "IslandFlowerFieldUI"
end

function IslandFlowerFieldLayer:setActivity(arg_2_1)
	self.activity = arg_2_1

	return
end

function IslandFlowerFieldLayer:init()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	local var_3_0 = self._tf:Find("Text")

	setText(var_3_0, i18n("islandnode_tips6"))
	var_3_0:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		setActive(var_3_0, false)

		return
	end)

	self.rtChars = self._tf:Find("chars")
	self.rtShip = self.rtChars:GetChild(math.random(self.rtChars.childCount) - 1)
	self.contextData.shipConfigId = tonumber(self.rtShip.name)

	eachChild(self.rtChars, function(arg_5_0)
		setActive(arg_5_0, arg_5_0 == self.rtShip)

		return
	end)

	self.fieldList = {}
	self.posList = {}

	eachChild(self._tf:Find("field"), function(arg_6_0)
		eachChild(arg_6_0, function(arg_7_0)
			table.insert(self.fieldList, arg_7_0)
			table.insert(self.posList, self.rtChars:InverseTransformPoint(arg_7_0.position))

			return
		end)

		return
	end)

	self.rtField = self._tf:Find("field")
	self.rtBtnGet = self._tf:Find("btn_get")

	onButton(self, self._tf:Find("btn_back"), function()
		self:closeView()

		return
	end, SFX_CANCEL)

	for iter_3_0, iter_3_1 in ipairs({
		"click",
		"click_lock"
	}) do
		onButton(self, self.rtBtnGet:Find(iter_3_1), function()
			if self.timer then
				setActive(var_3_0, true)

				return
			end

			self:emit(IslandFlowerFieldMediator.GET_FLOWER_AWARD, false)

			return
		end, SFX_CONFIRM)
	end

	return
end

function IslandFlowerFieldLayer:refreshDisplay()
	local var_10_0 = pg.TimeMgr.GetInstance()
	local var_10_1 = var_10_0:GetServerTime() >= var_10_0:GetTimeToNextTime(math.max(self.activity.data1, self.activity.data2))

	setActive(self.rtBtnGet:Find("click"), var_10_1)
	setActive(self.rtBtnGet:Find("click_lock"), not var_10_1)

	for iter_10_0, iter_10_1 in ipairs(self.fieldList) do
		triggerToggle(iter_10_1, var_10_1)
	end

	if var_10_1 then
		setText(self.rtBtnGet:Find("time/Text"), var_10_0:DescCDTime(0))
	else
		local var_10_2 = var_10_0:GetTimeToNextTime() - var_10_0:GetServerTime()
		local var_10_3 = 0

		self.timer = Timer.New(function()
			if var_10_3 < var_10_2 then
				var_10_3 = var_10_3 + 1

				setText(self.rtBtnGet:Find("time/Text"), var_10_0:DescCDTime(var_10_2 - var_10_3))
			else
				self.timer:Stop()

				self.timer = nil

				self:refreshDisplay()
			end

			return
		end, 1, var_10_2)

		self.timer.func()
		self.timer:Start()
	end

	return
end

function IslandFlowerFieldLayer:didEnter()
	local var_12_0 = pg.TimeMgr.GetInstance()

	if var_12_0:GetServerTime() - var_12_0:GetTimeToNextTime(math.max(self.activity.data1, self.activity.data2)) < 0 then
		self:refreshDisplay()
	else
		self:emit(IslandFlowerFieldMediator.GET_FLOWER_AWARD, true)
	end

	self:DoCharAction()

	return
end

local var_0_1 = 50

function IslandFlowerFieldLayer:DoCharAction()
	local var_13_0 = self.posList[math.random(#self.posList)]
	local var_13_1 = var_13_0 - self.rtShip.anchoredPosition3D

	if (var_13_0 - self.rtShip.anchoredPosition3D):SqrMagnitude() <= 0 then
		return self:DoCharAction()
	end

	var_13_1.x = var_13_1.x - (var_13_1.x < 0 and -1 or 1) * 100

	local var_13_2 = {}

	table.insert(var_13_2, function(arg_14_0)
		SetAction(self.rtShip, "jiaoshui_walk")
		setLocalScale(self.rtShip, {
			x = (var_13_1.x < 0 and -1 or 1) * math.abs(self.rtShip.localScale.x)
		})

		self.charLT = LeanTween.move(self.rtShip, self.rtShip.anchoredPosition3D + var_13_1, var_13_1:Magnitude() / var_0_1):setOnComplete(System.Action(arg_14_0)).uniqueId

		return
	end)
	table.insert(var_13_2, function(arg_15_0)
		var_13_1 = var_13_0 - self.rtShip.anchoredPosition3D

		SetAction(self.rtShip, "jiaoshui", false)
		setLocalScale(self.rtShip, {
			x = (var_13_1.x < 0 and -1 or 1) * math.abs(self.rtShip.localScale.x)
		})

		self.charLT = LeanTween.delayedCall(3, System.Action(arg_15_0)).uniqueId

		return
	end)
	table.insert(var_13_2, function(arg_16_0)
		SetAction(self.rtShip, "jiaoshui_stand")

		self.charLT = LeanTween.delayedCall(4.666666666666667, System.Action(arg_16_0)).uniqueId

		return
	end)
	seriesAsync(var_13_2, function()
		self.charLT = nil

		self:DoCharAction()

		return
	end)

	return
end

function IslandFlowerFieldLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	if self.charLT then
		LeanTween.cancel(self.charLT)

		self.charLT = nil
	end

	return
end

return IslandFlowerFieldLayer
