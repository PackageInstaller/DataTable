local var_0_0 = class("LoveLetterActivityScene", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "LoveLetterActivityUI"
end

var_0_0.optionsPath = {}

function var_0_0.init(arg_2_0)
	setText(arg_2_0.rtSlider:Find("Text"), i18n("loveactivity_ui_1"))
	setText(arg_2_0.textDailyTitle, i18n("mail_boxtitle_information"))
	setText(arg_2_0.btnDaily:Find("content/Text"), i18n("loveactivity_ui_2"))
	setText(arg_2_0.btnGift:Find("Text"), i18n("loveactivity_ui_3"))
	setText(arg_2_0.textUITitle, i18n("activity_ninjia_main_title"))
	setText(arg_2_0.btnDailyConfirm:Find("Text"), i18n("mail_box_confirm"))
	onButton(arg_2_0, findTF(arg_2_0._tf, "adapt/TopPage/top/deco/btn_help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.loveactivity_help_tips.tip
		})

		return
	end, SFX_CANCEL)
	onButton(arg_2_0, arg_2_0.btnBack, function()
		arg_2_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_2_0, arg_2_0.btnHome, function()
		arg_2_0:emit(var_0_0.ON_HOME)

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.btnSwitch, function()
		local var_6_0, var_6_1 = arg_2_0.activity:GetChangeCount()

		if var_6_0 < var_6_1 then
			arg_2_0:emit(LoveLetterActivityMediator.ON_SELECT_GROUP, arg_2_0.activity.id)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_count_noenough"))
		end

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.btnDaily:Find("content"), function()
		arg_2_0:ShowDailyPanel()

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.btnDailyConfirm, function()
		for iter_8_0 = 1, arg_2_0.dailyActivity:getNDay() do
			local var_8_0 = arg_2_0.dailyActivity:getConfig("config_data")[iter_8_0]

			if var_8_0 then
				local var_8_1 = getProxy(TaskProxy):getTaskVO(var_8_0) or nil

				if var_8_1 and var_8_1:getTaskStatus() == 1 then
					arg_2_0:emit(LoveLetterActivityMediator.ON_DAILY_LOGIN_REWARD, var_8_0)

					return
				end
			end
		end

		return
	end, SFX_CONFIRM)
	onButton(arg_2_0, arg_2_0.btnDailyClose, function()
		arg_2_0:HideDailyPanel()

		return
	end, SFX_CANCEL)
	onButton(arg_2_0, arg_2_0.btnGift, function()
		arg_2_0:emit(LoveLetterActivityMediator.ON_GO_COLLECTION)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.SetActivity(arg_11_0, arg_11_1)
	arg_11_0.activity = arg_11_1
	arg_11_0.ll = getProxy(LoveLetterProxy):GetGroupData(arg_11_0.activity:GetTargetGroupId())

	setText(arg_11_0.rtDailyPanel:Find("panel/Text"), string.format("are you sure to add extra exp to character:%d ?", arg_11_0.ll.groupId))

	return
end

function var_0_0.SetDailyActivity(arg_12_0, arg_12_1)
	arg_12_0.dailyActivity = arg_12_1

	local var_12_0 = arg_12_1:readyToAchieve()

	setActive(arg_12_0.btnDaily:Find("got"), not var_12_0)

	local var_12_1 = Color.NewHex("393939")

	var_12_1.a = 0.8

	setBlackMask(arg_12_0.btnDaily:Find("content"), not var_12_0, {
		color = var_12_1
	})
	setActive(arg_12_0.btnDaily:Find("pick_up"), var_12_0)

	return
end

function var_0_0.didEnter(arg_13_0)
	arg_13_0:UpdateSlider()
	arg_13_0:UpdatePainting()
	arg_13_0:UpdateLoveLetterMedal()

	local var_13_0 = pg.NewStoryMgr.GetInstance()
	local var_13_1 = arg_13_0.activity:getNDay()

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.activity:GetConfigClientSetting("story")) do
		if iter_13_0 <= var_13_1 and not var_13_0:IsPlayed(iter_13_1[1]) then
			table.insert({}, function(arg_14_0)
				var_13_0:Play(iter_13_1[1], arg_14_0)

				return
			end)
		end
	end

	seriesAsync({}, function()
		if not arg_13_0.contextData.checkRalizeGift then
			arg_13_0.contextData.checkRalizeGift = true

			if getProxy(LoveLetterProxy):IsTipRealizeGift() then
				arg_13_0:emit(LoveLetterActivityMediator.ON_REALIZE_GIFT)
			end
		end

		checkFirstHelpShow("loveactivity_help_tips")

		return
	end)

	return
end

function var_0_0.UpdateSlider(arg_16_0)
	local var_16_0, var_16_1 = arg_16_0.activity:GetDailyProgress()

	setText(arg_16_0.rtSlider:Find("Slider/progress"), var_16_0 .. "/" .. var_16_1)
	setSlider(arg_16_0.rtSlider:Find("Slider"), 0, var_16_1, var_16_0)

	local var_16_2, var_16_3 = arg_16_0.ll:GetDisplayExp()

	if var_16_3 == 0 then
		setSlider(arg_16_0.rtNow:Find("Slider"), 0, 1, 1)
	else
		setSlider(arg_16_0.rtNow:Find("Slider"), 0, var_16_3, var_16_2)
	end

	setText(arg_16_0.rtNow:Find("Text"), string.format(setColorStr("%d", "#CF90A8") .. "/%d", var_16_2, var_16_3))

	return
end

function var_0_0.UpdatePainting(arg_17_0)
	local var_17_0, var_17_1 = arg_17_0.activity:GetChangeCount()

	setText(arg_17_0.btnSwitch:Find("Text"), string.format("%d/%d", var_17_1 - var_17_0, var_17_1))

	local var_17_2 = arg_17_0.ll:GetPainting()

	if arg_17_0.paint == var_17_2 then
		return
	end

	if arg_17_0.paint then
		retPaintingPrefab(arg_17_0.rtPainting, arg_17_0.paint)

		arg_17_0.paint = nil
	end

	arg_17_0.paint = var_17_2

	setPaintingPrefabAsync(arg_17_0.rtPainting, arg_17_0.paint, "mainNormal")

	return
end

function var_0_0.UpdateLoveLetterMedal(arg_18_0, arg_18_1)
	setActive(arg_18_0.btnGift:Find("tip"), getProxy(LoveLetterProxy):IsTipRealizeGift())

	arg_18_1 = arg_18_1 or arg_18_0.rtNow:Find("medal")
	;({}).showPickUp = arg_18_0.ll:CanLevelUp() and arg_18_0.ll.level < arg_18_0.ll:GetMaxLevel()

	var_18_0(arg_18_1, arg_18_0.ll, {})
	onButton(arg_18_0, arg_18_0.rtNow, function()
		arg_18_0:emit(LoveLetterActivityMediator.ON_GO_TROPHY)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.ShowDailyPanel(arg_20_0)
	setActive(arg_20_0.rtDailyPanel, true)
	arg_20_0:UpdateLoveLetterMedal(arg_20_0.rtDailyNow:Find("medal"))

	local var_20_0, var_20_1 = arg_20_0.ll:GetDisplayExp()

	if var_20_1 == 0 then
		setSlider(arg_20_0.rtDailyNow:Find("Slider"), 0, 1, 1)
	else
		setSlider(arg_20_0.rtDailyNow:Find("Slider"), 0, var_20_1, var_20_0)
	end

	setText(arg_20_0.rtDailyNow:Find("Text"), string.format(setColorStr("%d", "#CF90A8") .. "/%d", var_20_0, var_20_1))

	local var_20_2 = 1

	for iter_20_0 = 1, arg_20_0.dailyActivity:getNDay() do
		local var_20_3 = arg_20_0.dailyActivity:getConfig("config_data")[iter_20_0]

		if var_20_3 then
			local var_20_4 = getProxy(TaskProxy):getTaskVO(var_20_3) or nil

			if var_20_4 and var_20_4:getTaskStatus() == 1 then
				var_20_2 = iter_20_0

				break
			end
		end
	end

	setText(arg_20_0.textDailyContent, i18n("loveactivity_ui_4_" .. var_20_2, arg_20_0.ll:GetName(), arg_20_0.dailyActivity:GetConfigClientSetting("exp")))
	arg_20_0:BlurPanel(arg_20_0.rtDailyPanel)

	return
end

function var_0_0.HideDailyPanel(arg_21_0)
	setActive(arg_21_0.rtDailyPanel, false)
	arg_21_0:UnOverlayPanel(arg_21_0.rtDailyPanel)

	return
end

function var_0_0.onBackPressed(arg_22_0)
	if isActive(arg_22_0.rtDailyPanel) then
		arg_22_0:HideDailyPanel()
	else
		var_0_0.super.onBackPressed(arg_22_0)
	end

	return
end

function var_0_0.willExit(arg_23_0)
	if arg_23_0.paint then
		retPaintingPrefab(arg_23_0.rtPainting, arg_23_0.paint)

		arg_23_0.paint = nil
	end

	if arg_23_0.rtNow:Find("medal").childCount > 0 then
		eachChild(arg_23_0.rtNow:Find("medal"), function(arg_24_0, arg_24_1)
			returnLoveLetterMedal(arg_24_0)

			return
		end)
	end

	return
end

return var_0_0
