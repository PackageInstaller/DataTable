local LoveLetterActivityScene = class("LoveLetterActivityScene", import("view.base.BaseUI"))

function LoveLetterActivityScene:getUIName()
	return "LoveLetterActivityUI"
end

LoveLetterActivityScene.optionsPath = {}

function LoveLetterActivityScene:init()
	setText(self.rtSlider:Find("Text"), i18n("loveactivity_ui_1"))
	setText(self.textDailyTitle, i18n("mail_boxtitle_information"))
	setText(self.btnDaily:Find("content/Text"), i18n("loveactivity_ui_2"))
	setText(self.btnGift:Find("Text"), i18n("loveactivity_ui_3"))
	setText(self.textUITitle, i18n("activity_ninjia_main_title"))
	setText(self.btnDailyConfirm:Find("Text"), i18n("mail_box_confirm"))
	onButton(self, findTF(self._tf, "adapt/TopPage/top/deco/btn_help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.loveactivity_help_tips.tip
		})

		return
	end, SFX_CANCEL)
	onButton(self, self.btnBack, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.btnHome, function()
		self:emit(LoveLetterActivityScene.ON_HOME)

		return
	end, SFX_PANEL)
	onButton(self, self.btnSwitch, function()
		local var_6_0, var_6_1 = self.activity:GetChangeCount()

		if var_6_0 < var_6_1 then
			self:emit(LoveLetterActivityMediator.ON_SELECT_GROUP, self.activity.id)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_count_noenough"))
		end

		return
	end, SFX_PANEL)
	onButton(self, self.btnDaily:Find("content"), function()
		self:ShowDailyPanel()

		return
	end, SFX_PANEL)
	onButton(self, self.btnDailyConfirm, function()
		for iter_8_0 = 1, self.dailyActivity:getNDay() do
			local var_8_0 = self.dailyActivity:getConfig("config_data")[iter_8_0]

			if var_8_0 then
				local var_8_1 = getProxy(TaskProxy):getTaskVO(var_8_0) or nil

				if var_8_1 and var_8_1:getTaskStatus() == 1 then
					self:emit(LoveLetterActivityMediator.ON_DAILY_LOGIN_REWARD, var_8_0)

					return
				end
			end
		end

		return
	end, SFX_CONFIRM)
	onButton(self, self.btnDailyClose, function()
		self:HideDailyPanel()

		return
	end, SFX_CANCEL)
	onButton(self, self.btnGift, function()
		self:emit(LoveLetterActivityMediator.ON_GO_COLLECTION)

		return
	end, SFX_PANEL)

	return
end

function LoveLetterActivityScene:SetActivity(arg_11_1)
	self.activity = arg_11_1
	self.ll = getProxy(LoveLetterProxy):GetGroupData(self.activity:GetTargetGroupId())

	setText(self.rtDailyPanel:Find("panel/Text"), string.format("are you sure to add extra exp to character:%d ?", self.ll.groupId))

	return
end

function LoveLetterActivityScene:SetDailyActivity(arg_12_1)
	self.dailyActivity = arg_12_1

	local var_12_0 = arg_12_1:readyToAchieve()

	setActive(self.btnDaily:Find("got"), not var_12_0)

	local var_12_1 = Color.NewHex("393939")

	var_12_1.a = 0.8

	setBlackMask(self.btnDaily:Find("content"), not var_12_0, {
		color = var_12_1
	})
	setActive(self.btnDaily:Find("pick_up"), var_12_0)

	return
end

function LoveLetterActivityScene:didEnter()
	self:UpdateSlider()
	self:UpdatePainting()
	self:UpdateLoveLetterMedal()

	local var_13_0 = {}
	local var_13_1 = pg.NewStoryMgr.GetInstance()
	local var_13_2 = self.activity:getNDay()

	for iter_13_0, iter_13_1 in ipairs(self.activity:GetConfigClientSetting("story")) do
		if iter_13_0 <= var_13_2 and not var_13_1:IsPlayed(iter_13_1[1]) then
			table.insert(var_13_0, function(arg_14_0)
				var_13_1:Play(iter_13_1[1], arg_14_0)

				return
			end)
		end
	end

	seriesAsync(var_13_0, function()
		if not self.contextData.checkRalizeGift then
			self.contextData.checkRalizeGift = true

			if getProxy(LoveLetterProxy):IsTipRealizeGift() then
				self:emit(LoveLetterActivityMediator.ON_REALIZE_GIFT)
			end
		end

		checkFirstHelpShow("loveactivity_help_tips")

		return
	end)

	return
end

function LoveLetterActivityScene:UpdateSlider()
	local var_16_0, var_16_1 = self.activity:GetDailyProgress()

	setText(self.rtSlider:Find("Slider/progress"), var_16_0 .. "/" .. var_16_1)
	setSlider(self.rtSlider:Find("Slider"), 0, var_16_1, var_16_0)

	local var_16_2, var_16_3 = self.ll:GetDisplayExp()

	if var_16_3 == 0 then
		setSlider(self.rtNow:Find("Slider"), 0, 1, 1)
	else
		setSlider(self.rtNow:Find("Slider"), 0, var_16_3, var_16_2)
	end

	setText(self.rtNow:Find("Text"), string.format(setColorStr("%d", "#CF90A8") .. "/%d", var_16_2, var_16_3))

	return
end

function LoveLetterActivityScene:UpdatePainting()
	local var_17_0, var_17_1 = self.activity:GetChangeCount()

	setText(self.btnSwitch:Find("Text"), string.format("%d/%d", var_17_1 - var_17_0, var_17_1))

	local var_17_2 = self.ll:GetPainting()

	if self.paint == var_17_2 then
		return
	end

	if self.paint then
		retPaintingPrefab(self.rtPainting, self.paint)

		self.paint = nil
	end

	self.paint = var_17_2

	setPaintingPrefabAsync(self.rtPainting, self.paint, "mainNormal")

	return
end

function LoveLetterActivityScene:UpdateLoveLetterMedal(arg_18_1)
	setActive(self.btnGift:Find("tip"), getProxy(LoveLetterProxy):IsTipRealizeGift())

	arg_18_1 = arg_18_1 or self.rtNow:Find("medal")

	local var_18_0 = setLoveLetterMedal
	local var_18_1 = {}

	var_18_1.showPickUp = self.ll:CanLevelUp() and self.ll.level < self.ll:GetMaxLevel()

	var_18_0(arg_18_1, self.ll, var_18_1)
	onButton(self, self.rtNow, function()
		self:emit(LoveLetterActivityMediator.ON_GO_TROPHY)

		return
	end, SFX_PANEL)

	return
end

function LoveLetterActivityScene:ShowDailyPanel()
	setActive(self.rtDailyPanel, true)
	self:UpdateLoveLetterMedal(self.rtDailyNow:Find("medal"))

	local var_20_0, var_20_1 = self.ll:GetDisplayExp()

	if var_20_1 == 0 then
		setSlider(self.rtDailyNow:Find("Slider"), 0, 1, 1)
	else
		setSlider(self.rtDailyNow:Find("Slider"), 0, var_20_1, var_20_0)
	end

	setText(self.rtDailyNow:Find("Text"), string.format(setColorStr("%d", "#CF90A8") .. "/%d", var_20_0, var_20_1))

	local var_20_2 = 1

	for iter_20_0 = 1, self.dailyActivity:getNDay() do
		local var_20_3 = self.dailyActivity:getConfig("config_data")[iter_20_0]

		if var_20_3 then
			local var_20_4 = getProxy(TaskProxy):getTaskVO(var_20_3) or nil

			if var_20_4 and var_20_4:getTaskStatus() == 1 then
				var_20_2 = iter_20_0

				break
			end
		end
	end

	setText(self.textDailyContent, i18n("loveactivity_ui_4_" .. var_20_2, self.ll:GetName(), self.dailyActivity:GetConfigClientSetting("exp")))
	self:BlurPanel(self.rtDailyPanel)

	return
end

function LoveLetterActivityScene:HideDailyPanel()
	setActive(self.rtDailyPanel, false)
	self:UnOverlayPanel(self.rtDailyPanel)

	return
end

function LoveLetterActivityScene:onBackPressed()
	if isActive(self.rtDailyPanel) then
		self:HideDailyPanel()
	else
		LoveLetterActivityScene.super.onBackPressed(self)
	end

	return
end

function LoveLetterActivityScene:willExit()
	if self.paint then
		retPaintingPrefab(self.rtPainting, self.paint)

		self.paint = nil
	end

	if self.rtNow:Find("medal").childCount > 0 then
		eachChild(self.rtNow:Find("medal"), function(arg_24_0, arg_24_1)
			returnLoveLetterMedal(arg_24_0)

			return
		end)
	end

	return
end

return LoveLetterActivityScene
