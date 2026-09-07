local FireworkFactoryView = class("FireworkFactoryView", import("..BaseMiniGameView"))
local var_0_1 = Mathf

function FireworkFactoryView:getUIName()
	return "FireworkFactoryUI"
end

local var_0_2 = 50
local var_0_3 = {
	{
		color = "FFD26FFF",
		name = "na"
	},
	{
		color = "DE89ECFF",
		name = "k"
	},
	{
		color = "8F77DFFF",
		name = "rb"
	},
	{
		color = "70ad9f",
		name = "zn"
	},
	{
		color = "FF7069FF",
		name = "ca"
	},
	{
		color = "7faf6e",
		name = "cu"
	}
}
local var_0_4 = {
	"s",
	"a",
	"b",
	"c"
}

function FireworkFactoryView:TransformColor()
	return Color.New(tonumber(string.sub(self, 1, 2), 16) / 255, tonumber(string.sub(self, 3, 4), 16) / 255, tonumber(string.sub(self, 5, 6), 16) / 255)
end

function FireworkFactoryView:init()
	self.top = self._tf:Find("top")
	self.plate = self._tf:Find("plate")
	self.storage = self._tf:Find("storage")
	self.dispenseView = self._tf:Find("top/dispenseView")

	setActive(self.dispenseView, false)

	self.resultWindow = self._tf:Find("top/resultwindow")

	setActive(self.resultWindow, false)

	self.btn_back = self.top:Find("noAdaptPanel/back")
	self.btn_help = self.top:Find("noAdaptPanel/title/help")
	self.timesText = self.top:Find("times/text")
	self.ballPlate = self.plate:Find("ball_plate")
	self.plateRings = {}

	for iter_3_0 = 1, 3 do
		table.insert(self.plateRings, self.ballPlate:GetChild(iter_3_0))
	end

	self.btn_load = self.plate:Find("btn_load")
	self.ballSelectPanel = self.plate:Find("panel/layout")
	self.ballSelects = CustomIndexLayer.Clone2Full(self.ballSelectPanel, 3)
	self.ballSelectStatus = {
		0,
		0,
		0
	}
	self.lastSelectedBall = nil
	self.ballStoragePanel = self.storage:Find("house/layout")
	self.ballStorages = CustomIndexLayer.Clone2Full(self.ballStoragePanel, 6)
	self.screen_mask = self._tf:Find("mask")
	self.btn_next = self._tf:Find("Button")
	self.btn_next_text = self.btn_next:Find("Image")
	self.desc_dispense = self.dispenseView:Find("intro/Scroll View/Viewport/text")

	setText(self.desc_dispense, i18n("help_firework_produce"))

	self.btn_dispenseBG = self.dispenseView:Find("bg")
	self.btn_hammer = self.dispenseView:Find("container/Button")
	self.btn_hammer_text = self.btn_hammer:Find("text")
	self.slider_powder = self.dispenseView:Find("container/Slider/Fill Area"):GetComponent("Slider")
	self.slider_progress = self.dispenseView:Find("progress/Slider"):GetComponent("Slider")
	self.slider_progress_bg = self.dispenseView:Find("progress/Slider/Background/progressdi")
	self.slider_bubble = self.dispenseView:Find("container/Slider/Fill Area/Fill/handler/bubble")
	self.slider_bubble_text = self.slider_bubble:Find("text")
	self.progress_width = self.dispenseView:Find("progress/Slider/Handle Slide Area").rect.width
	self.progress_sub_mark_1 = self.dispenseView:Find("progress/Slider/Handle Slide Area/submark1")
	self.progress_sub_mark_2 = self.dispenseView:Find("progress/Slider/Handle Slide Area/submark2")
	self.progress_dis = {}

	for iter_3_1 = 0, self.slider_progress_bg.childCount - 1 do
		table.insert(self.progress_dis, self.slider_progress_bg:GetChild(iter_3_1))
	end

	self.result_digits = {}

	pg.PoolMgr.GetInstance():GetPrefab("ui/light01", "", true, function(arg_4_0)
		tf(arg_4_0):SetParent(self.dispenseView, false)
		arg_4_0:SetActive(false)

		self.effect_light = arg_4_0

		return
	end)

	self.result_bg = self.resultWindow:Find("bg")
	self.result_desc = self.resultWindow:Find("window/Text")

	setText(self.result_desc, i18n("result_firework_produce"))

	self.btn_result_confirm = self.resultWindow:Find("window/button")
	self.result_pingjia = self.resultWindow:Find("window/pingjia"):GetComponent("Image")
	self.flagStart = false
	self.flagDispense = false
	self.progressDispense = 0

	return
end

function FireworkFactoryView:SetSprite(arg_5_1, arg_5_2)
	self:SetImageSprite(arg_5_1:GetComponent("Image"), arg_5_2)

	return
end

function FireworkFactoryView:SetImageSprite(arg_6_1, arg_6_2)
	pg.PoolMgr.GetInstance():GetSprite("ui/fireworkfactoryui_atlas", arg_6_2, false, function(arg_7_0)
		arg_6_1.sprite = arg_7_0

		return
	end)

	return
end

function FireworkFactoryView:didEnter()
	onButton(self, self.btn_back, function()
		if self.flagDispense then
			self:ExitDispenseView()
		elseif self:CheckpowderDispensed() and self.flagStart then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("tips_firework_exit"),
				onYes = function()
					self:emit(FireworkFactoryView.ON_BACK_PRESSED)

					return
				end
			})
		else
			self:emit(FireworkFactoryView.ON_BACK)
		end

		return
	end)
	onButton(self, self.btn_dispenseBG, function()
		self:ExitDispenseView()

		return
	end)
	onButton(self, self.btn_help, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_xinnian2022_firework.tip
		})

		return
	end)
	onButton(self, self.btn_next, function()
		if not self.flagStart then
			self.flagStart = true

			self:UpdateNextBtn()
		elseif self:CheckballLoaded() then
			self:EnterDispenseView()
		end

		return
	end)
	onButton(self, self.btn_hammer, function()
		if self.progressDispense == 0 then
			self:ResetHammerAnim()
			self:FindNextPowderProgress()
			self:UpdateContainer()
		elseif self.progressDispense == 1 then
			self.result_digits[1] = self.slider_powder.value * 100

			self:FindandStopProgress()
			self:UpdateContainer()
		elseif self.progressDispense == 2 then
			self.result_digits[2] = self.slider_powder.value * 100

			self:FindandStopProgress()
			self:UpdateContainer()
		elseif self.progressDispense == 3 then
			self.result_digits[3] = self.slider_powder.value * 100

			self:FindandStopProgress()
			self:UpdateContainer()
		end

		return
	end)
	onButton(self, self.btn_result_confirm, function()
		self:ShowResult()

		return
	end)
	onButton(self, self.result_bg, function()
		self:ShowResult()

		return
	end)

	for iter_8_0 = 1, #self.ballStorages do
		self:UpdateBall(self.ballStorages[iter_8_0], iter_8_0)
		onButton(self, self.ballStorages[iter_8_0]:Find("mask"), function()
			if not self.lastSelectedBall or self.lastSelectedBall <= 0 then
				return
			end

			self.ballSelectStatus[self.lastSelectedBall] = iter_8_0

			self:UpdateRing(self.lastSelectedBall, iter_8_0)
			self:UpdateBall(self.ballSelects[self.lastSelectedBall]:Find("ball"), iter_8_0)
			self:UdpateSelectedBall(self.lastSelectedBall + 1)
			self:UpdateNextBtn()

			return
		end)
	end

	for iter_8_1 = 1, #self.ballSelects do
		self:UpdateBall(self.ballSelects[iter_8_1]:Find("ball"), 0)
		self:UpdateRing(iter_8_1, 0)
		onButton(self, self.ballSelects[iter_8_1]:Find("mask"), function()
			self.ballSelectStatus[iter_8_1] = 0

			self:UpdateBall(self.ballSelects[iter_8_1]:Find("ball"), 0)
			self:UpdateRing(iter_8_1, 0)
			self:UdpateSelectedBall(iter_8_1)
			self:UpdateNextBtn()

			return
		end)
	end

	self:ResetView()
	pg.UIMgr.GetInstance():OverlayPanel(self.top)

	local var_8_0 = self:GetMGData():GetSimpleValue("score_reference")
	local var_8_1 = {}

	var_8_1[1] = 0

	for iter_8_2, iter_8_3 in ipairs(var_8_0) do
		var_8_1[#var_8_0 - iter_8_2 + 2] = iter_8_3[1]
		var_8_1[#var_8_0 + iter_8_2 + 1] = iter_8_3[2]
	end

	var_8_1[#var_8_1] = 300

	for iter_8_4 = 1, #var_8_1 - 1 do
		self.progress_dis[iter_8_4].anchorMin = Vector2(var_8_1[iter_8_4] / 300, 0)
		self.progress_dis[iter_8_4].anchorMax = Vector2(var_8_1[iter_8_4 + 1] / 300, 1)
		self.progress_dis[iter_8_4].sizeDelta = Vector2.zero
	end

	return
end

function FireworkFactoryView:UpdateNextBtn()
	if not self.flagStart then
		local var_19_1 = self:GetMGData():GetRuntimeData("elements")

		self:SetSprite(self.btn_next_text, (var_19_1 and #var_19_1 > 3 and var_19_1[4] == SummerFeastScene.GetCurrentDay() or nil) and "dispense_retry")
	else
		self:SetSprite(self.btn_next_text, "dispense_confirm")
	end

	setActive(self.screen_mask, not self.flagStart)
	setButtonEnabled(self.btn_next, not self.flagStart or self:CheckballLoaded())

	return
end

function FireworkFactoryView:UpdateDispenseBtn()
	local var_20_0 = self:CheckpowderDispensed()

	self:SetImageSprite(self.btn_load_img, var_20_0 and "btn_loadcompleted" or "btn_load")
	self:SetSprite(self.btn_load_text, var_20_0 and "load_completed" or "load_ready")
	setButtonEnabled(self.btn_load, not var_20_0)

	return
end

local var_0_5 = {
	"start",
	"first_time",
	"second_time",
	"third_time",
	"finish_time"
}

function FireworkFactoryView:FindandStopProgress()
	self:StopHammerAnim()
	setButtonEnabled(self.btn_hammer, false)
	setButtonEnabled(self.btn_dispenseBG, false)
	setText(self.slider_bubble_text, math.ceil(self.result_digits[#self.result_digits]) .. "%")
	setActive(self.slider_bubble, true)
	setActive(self.effect_light, true)

	self.progressDispense = #self.result_digits >= 3 and 4 or 0

	local var_21_0 = 0

	for iter_21_0 = 1, 3 do
		if self.result_digits[iter_21_0] then
			var_21_0 = var_21_0 + self.result_digits[iter_21_0]
		end
	end

	local var_21_1 = 0

	for iter_21_1 = 1, #self.result_digits - 1 do
		if self.result_digits[iter_21_1] then
			var_21_1 = var_21_1 + self.result_digits[iter_21_1]

			if iter_21_1 == 1 then
				setActive(self.progress_sub_mark_1, true)

				self.progress_sub_mark_1.anchoredPosition = Vector2(self.progress_width * var_21_1 / 300, 27)
			elseif iter_21_1 == 2 then
				setActive(self.progress_sub_mark_2, true)

				self.progress_sub_mark_2.anchoredPosition = Vector2(self.progress_width * var_21_1 / 300, 27)
			end
		end
	end

	local var_21_2 = self.slider_bubble.transform.position
	local var_21_3 = self.slider_progress.transform.position
	local var_21_4 = self.slider_progress.value

	self.progressAnim = LeanTween.value(self.slider_progress.gameObject, 0, 1, 1.5):setEase(LeanTweenType.linear):setOnUpdate(System.Action_float(function(arg_22_0)
		self.slider_progress.value = var_0_1.Lerp(var_21_4, var_21_0 / 300, arg_22_0)

		if self.effect_light then
			self.effect_light.transform.position = Vector3.Lerp(var_21_2, var_21_3, arg_22_0 * 3) - Vector3(0, 0, 2)

			if arg_22_0 * 3 > 1 then
				setActive(self.effect_light, false)
			end
		end

		return
	end)):setOnComplete(System.Action(function()
		setButtonEnabled(self.btn_hammer, true)
		setButtonEnabled(self.btn_dispenseBG, true)

		if self.progressDispense > 3 then
			self:FindNextPowderProgress()
		end

		return
	end))

	return
end

function FireworkFactoryView:FindNextPowderProgress()
	self.progressDispense = #self.result_digits + 1

	if self.progressDispense > 3 then
		self:StopHammerAnim()
		setButtonEnabled(self.btn_hammer, false)
		self:ShowResultWindow()
	end

	return
end

function FireworkFactoryView:ShowResultWindow()
	if #self.result_digits < 3 then
		return
	end

	setActive(self.resultWindow, true)

	local var_25_0 = 0

	for iter_25_0 = 1, 3 do
		var_25_0 = var_25_0 + self.result_digits[iter_25_0]
	end

	local var_25_1 = 4

	for iter_25_1, iter_25_2 in ipairs((self:GetMGData():GetSimpleValue("score_reference"))) do
		if var_25_0 >= iter_25_2[1] and var_25_0 <= iter_25_2[2] then
			var_25_1 = iter_25_1

			break
		end
	end

	if var_25_1 <= 0 then
		return
	end

	self:SetImageSprite(self.result_pingjia, var_0_4[var_25_1])

	return
end

function FireworkFactoryView:ShowResult()
	if self:GetMGHubData().count <= 0 then
		self:AfterResult()
	else
		self:GetReward()
	end

	setActive(self.resultWindow, false)

	return
end

function FireworkFactoryView:OnGetAwardDone(arg_27_1)
	local var_27_0 = self:GetMGHubData()

	if arg_27_1.cmd == MiniGameOPCommand.CMD_COMPLETE and var_27_0.ultimate == 0 and var_27_0.usedtime >= var_27_0:getConfig("reward_need") then
		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = var_27_0.id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
	elseif arg_27_1.cmd == MiniGameOPCommand.CMD_ULTIMATE then
		self:AfterResult()
	else
		self:AfterResult()
	end

	return
end

function FireworkFactoryView:AfterResult()
	local var_28_0 = Clone(self.ballSelectStatus)

	table.insert(var_28_0, (SummerFeastScene.GetCurrentDay()))
	self:StoreDataToServer(var_28_0)
	onNextTick(function()
		self:emit(FireworkFactoryView.ON_BACK)

		return
	end)

	return
end

function FireworkFactoryView:reset()
	self:ExitDispenseView()

	self.flagStart = false
	self.flagDispense = false
	self.progressDispense = 0
	self.result_digits = {}

	self:ResetView()
	self:UpdateNextBtn()

	return
end

function FireworkFactoryView:GetReward()
	if #self.result_digits < 3 then
		return
	end

	local var_31_0 = self:GetMGData():GetSimpleValue("score_reference")
	local var_31_1 = 0

	for iter_31_0 = 1, 3 do
		var_31_1 = var_31_1 + self.result_digits[iter_31_0]
	end

	local var_31_2 = 4

	for iter_31_1, iter_31_2 in ipairs(var_31_0) do
		if var_31_1 >= iter_31_2[1] and var_31_1 <= iter_31_2[2] then
			var_31_2 = iter_31_1

			break
		end
	end

	if var_31_2 <= 0 then
		return
	end

	self:SendSuccess(var_31_2)

	return
end

function FireworkFactoryView:ResetHammerAnim()
	if self.hammerAnim then
		self:StopHammerAnim()
	end

	setActive(self.slider_bubble, false)

	self.hammerAnim = LeanTween.value(self.slider_powder.gameObject, 0, 1, (self:GetMGData():GetSimpleValue("roundTime") or var_0_2) / 100 * 2):setEase(LeanTweenType.linear):setLoopPingPong():setOnUpdate(System.Action_float(function(arg_33_0)
		self.slider_powder.value = arg_33_0

		return
	end))

	return
end

function FireworkFactoryView:StopHammerAnim()
	if not self.hammerAnim then
		return
	end

	LeanTween.cancel(self.hammerAnim.uniqueId)

	self.hammerAnim = nil

	return
end

function FireworkFactoryView:UpdateContainer()
	self:SetSprite(self.btn_hammer_text, var_0_5[self.progressDispense + 1])

	local var_35_0 = 0

	for iter_35_0 = 1, 3 do
		if self.result_digits[iter_35_0] then
			var_35_0 = var_35_0 + self.result_digits[iter_35_0]
		end
	end

	self.slider_progress.value = var_35_0 / 300

	return
end

function FireworkFactoryView:StopProgressAnim()
	if not self.progressAnim then
		return
	end

	LeanTween.cancel(self.progressAnim.uniqueId)

	self.progressAnim = nil

	return
end

function FireworkFactoryView:CheckballLoaded()
	return _.all(self.ballSelectStatus, function(arg_38_0)
		return arg_38_0 > 0
	end)
end

function FireworkFactoryView:CheckpowderDispensed()
	return #self.result_digits >= 3
end

function FireworkFactoryView:UpdateBall(arg_40_1, arg_40_2)
	setActive(arg_40_1, arg_40_2 > 0)

	if arg_40_2 <= 0 then
		return
	end

	arg_40_1:GetComponent("Image").color = self.TransformColor(var_0_3[arg_40_2].color)

	self:SetSprite(arg_40_1:Find("symbol"), var_0_3[arg_40_2].name)

	return
end

function FireworkFactoryView:UpdateRing(arg_41_1, arg_41_2)
	if arg_41_1 <= 0 or arg_41_1 > 3 then
		return
	end

	local var_41_0 = self.plateRings[arg_41_1]

	setActive(self.plateRings[arg_41_1], arg_41_2 > 0)

	if arg_41_2 <= 0 then
		return
	end

	var_41_0:GetComponent("Image").color = self.TransformColor(var_0_3[arg_41_2].color)

	return
end

function FireworkFactoryView:ResetView()
	_.each(self.plateRings, function(arg_43_0)
		setActive(arg_43_0, false)

		return
	end)
	_.each(self.ballSelects, function(arg_44_0)
		setActive(arg_44_0:Find("ball"), false)
		setActive(arg_44_0:Find("selected"), false)

		return
	end)
	setText(self.timesText, self:GetMGHubData().count)

	local var_42_0 = self:GetMGData():GetRuntimeData("elements")

	if var_42_0 and #var_42_0 > 3 and var_42_0[4] == SummerFeastScene.GetCurrentDay() then
		for iter_42_0 = 1, 3 do
			self.ballSelectStatus[iter_42_0] = var_42_0[iter_42_0]

			if var_42_0[iter_42_0] > 0 then
				self:UpdateRing(iter_42_0, var_42_0[iter_42_0])
				self:UpdateBall(self.ballSelects[iter_42_0]:Find("ball"), var_42_0[iter_42_0])
			end
		end
	end

	self:UdpateSelectedBall(1)
	self:UpdateNextBtn()
	setActive(self.slider_bubble, false)
	setActive(self.progress_sub_mark_1, false)
	setActive(self.progress_sub_mark_2, false)

	return
end

function FireworkFactoryView:UdpateSelectedBall(arg_45_1)
	if arg_45_1 <= 0 or arg_45_1 > 3 then
		return
	end

	if self.lastSelectedBall then
		if self.lastSelectedBall == arg_45_1 then
			return
		end

		setActive(self.ballSelects[self.lastSelectedBall]:Find("selected"), false)
	end

	setActive(self.ballSelects[arg_45_1]:Find("selected"), true)

	self.lastSelectedBall = arg_45_1

	return
end

function FireworkFactoryView:EnterDispenseView()
	setActive(self.dispenseView, true)

	self.flagDispense = true
	self.progressDispense = #self.result_digits >= 3 and 4 or 0

	self:UpdateContainer()

	self.slider_powder.value = 0

	return
end

function FireworkFactoryView:ExitDispenseView()
	if not self.flagDispense then
		return
	end

	self:UpdateNextBtn()
	self:StopHammerAnim()
	self:StopProgressAnim()

	self.progressDispense = 0

	setActive(self.dispenseView, false)
	setButtonEnabled(self.btn_hammer, true)
	setText(self.timesText, self:GetMGHubData().count)
	setActive(self.slider_bubble, false)

	if self.effect_light then
		setActive(self.effect_light, false)
	end

	self.flagDispense = false

	return
end

function FireworkFactoryView:willExit()
	self:ExitDispenseView()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.top, self._tf)

	if self.effect_light then
		pg.PoolMgr.GetInstance():ReturnPrefab("ui/light01", "", self.effect_light)
	end

	pg.PoolMgr.GetInstance():DestroyPrefab("ui/light01", "")
	pg.PoolMgr.GetInstance():DestroySprite("ui/fireworkfactoryui_atlas")

	if self.OPTimer then
		self.OPTimer:Stop()

		self.OPTimer = nil
	end

	return
end

return FireworkFactoryView
