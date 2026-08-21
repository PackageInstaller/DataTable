local var_0_0 = class("TechnologySettingsLayer", import("..base.BaseUI"))

var_0_0.TEC_PAGE_TENDENCY = 1
var_0_0.TEC_PAGE_CATCHUP_TARGET1 = 2
var_0_0.TEC_PAGE_CATCHUP_TARGET2 = 3
var_0_0.TEC_PAGE_CATCHUP_TARGET3 = 4
var_0_0.TEC_PAGE_CATCHUP_TARGET4 = 5
var_0_0.TEC_PAGE_CATCHUP_TARGET5 = 6
var_0_0.TEC_PAGE_CATCHUP_TARGET6 = 7
var_0_0.TEC_PAGE_CATCHUP_TARGET7 = 8
var_0_0.TEC_PAGE_CATCHUP_ACT = 99
var_0_0.PANEL_INTO_TIME = 0.15
var_0_0.SELECT_TENDENCY_FADE_TIME = 0.3
var_0_0.SELECT_CHAR_LIGHT_FADE_TIME = 0.3
var_0_0.CATCHUP_CLASSES = {
	import("view.technology.TargetCatchup.TargetCatchupPanel1"),
	import("view.technology.TargetCatchup.TargetCatchupPanel2"),
	import("view.technology.TargetCatchup.TargetCatchupPanel3"),
	import("view.technology.TargetCatchup.TargetCatchupPanel4"),
	import("view.technology.TargetCatchup.TargetCatchupPanel5"),
	import("view.technology.TargetCatchup.TargetCatchupPanel6"),
	import("view.technology.TargetCatchup.TargetCatchupPanel7")
}
var_0_0.CATCHUP_VERSION = 7

function var_0_0.getUIName(arg_1_0)
	return "TechnologySettingsUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()
	arg_2_0:initTendencyPage()
	arg_2_0:initActCatchupPage()

	return
end

function var_0_0.didEnter(arg_3_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_3_0._tf)
	arg_3_0:resetLeftBtnUnsel()
	arg_3_0:updateTendencyBtn(arg_3_0.curTendency)
	arg_3_0:updateTargetCatchupBtns()
	arg_3_0:updateActCatchupBtn()
	triggerButton(arg_3_0.leftBtnList[1])
	triggerToggle(arg_3_0.showFinish, arg_3_0.showFinishFlag == 1 and true or false)
	getProxy(CommanderManualProxy):TaskProgressAdd(2024, 1)

	return
end

function var_0_0.willExit(arg_4_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_4_0._tf)

	if arg_4_0.actCatchupTimer then
		arg_4_0.actCatchupTimer:Stop()

		arg_4_0.actCatchupTimer = nil
	end

	for iter_4_0, iter_4_1 in pairs(arg_4_0.catchupPanels) do
		iter_4_1:willExit()
	end

	arg_4_0.loader:Clear()

	return
end

function var_0_0.initData(arg_5_0)
	arg_5_0.technologyProxy = getProxy(TechnologyProxy)
	arg_5_0.bayProxy = getProxy(BayProxy)
	arg_5_0.bagProxy = getProxy(BagProxy)
	arg_5_0.curPageID = 0
	arg_5_0.curTendency = arg_5_0.technologyProxy:getTendency(2)
	arg_5_0.curSelectedIndex = 0
	arg_5_0.reSelectTag = false
	arg_5_0.actCatchup = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BLUEPRINT_CATCHUP)
	arg_5_0.isShowActCatchup = arg_5_0.actCatchup and not arg_5_0.actCatchup:isEnd()
	arg_5_0.loader = AutoLoader.New()

	return
end

function var_0_0.findUI(arg_6_0)
	arg_6_0.bg = arg_6_0._tf:Find("BG")

	setText(arg_6_0.bg:Find("BackTips/ClickText"), i18n("click_back_tip"))

	local var_6_0 = arg_6_0._tf:Find("Panel")
	local var_6_1 = var_6_0:Find("LeftScrollViewMask/LeftScrollView/LeftBtnList")

	arg_6_0.leftBtnList = {}
	arg_6_0.tendencyBtn = var_6_1:Find("TendencyBtn")
	arg_6_0.leftBtnList[var_0_0.TEC_PAGE_TENDENCY] = arg_6_0.tendencyBtn
	arg_6_0.catchupBtns = {}

	for iter_6_0 = 1, var_0_0.CATCHUP_VERSION do
		arg_6_0.catchupBtns[iter_6_0] = cloneTplTo(var_6_1:Find("TargetCatchupBtn_tpl"), var_6_1)
		arg_6_0.leftBtnList[iter_6_0 + 1] = arg_6_0.catchupBtns[iter_6_0]
	end

	arg_6_0.actCatchupBtn = var_6_1:Find("ActCatchupBtn")

	arg_6_0.actCatchupBtn:SetAsLastSibling()

	arg_6_0.leftBtnList[var_0_0.TEC_PAGE_CATCHUP_ACT] = arg_6_0.actCatchupBtn

	local var_6_2 = var_6_0:Find("RightPanelContainer")

	arg_6_0.rightPageTFList = {}
	arg_6_0.tendencyPanel = var_6_2:Find("TecTendencyPanel")
	arg_6_0.rightPageTFList[var_0_0.TEC_PAGE_TENDENCY] = arg_6_0.tendencyPanel
	arg_6_0.catchupPanels = {}
	arg_6_0.actCatchupPanel = var_6_2:Find("ActCatchupPanel")
	arg_6_0.rightPageTFList[var_0_0.TEC_PAGE_CATCHUP_ACT] = arg_6_0.actCatchupPanel
	arg_6_0.showFinish = arg_6_0._tf:Find("ShowFinishToggle")

	setText(arg_6_0.showFinish:Find("Label"), i18n("tec_target_catchup_show_the_finished_version"))

	arg_6_0.showFinishFlag = PlayerPrefs.GetInt("isShowFinishCatchupVersion") or 0

	if var_0_0.CATCHUP_VERSION < 1 then
		setActive(arg_6_0.showFinish, false)
	end

	return
end

function var_0_0.addListener(arg_7_0)
	onButton(arg_7_0, arg_7_0.bg, function()
		arg_7_0:closeView()

		return
	end, SFX_PANEL)

	for iter_7_0, iter_7_1 in pairs(arg_7_0.leftBtnList) do
		onButton(arg_7_0, iter_7_1, function()
			if arg_7_0.onPageSwitchAnim then
				return
			end

			if arg_7_0.curPageID ~= iter_7_0 then
				arg_7_0:resetLeftBtnUnsel()
				setActive(iter_7_1:Find("Selected"), true)
				arg_7_0:switchRightPage(iter_7_0)
			end

			return
		end, SFX_PANEL)
	end

	onToggle(arg_7_0, arg_7_0.showFinish, function(arg_10_0)
		if var_0_0.CATCHUP_VERSION < 1 then
			return
		end

		for iter_10_0, iter_10_1 in pairs(arg_7_0.catchupBtns) do
			if iter_10_0 <= var_0_0.CATCHUP_VERSION then
				if arg_7_0.technologyProxy:getCatchupState(iter_10_0) == TechnologyCatchup.STATE_FINISHED_ALL and not arg_10_0 then
					setActive(iter_10_1, false)
				else
					setActive(iter_10_1, true)
				end
			end
		end

		arg_7_0.showFinishFlag = arg_10_0 and 1 or 0

		PlayerPrefs.SetInt("isShowFinishCatchupVersion", arg_7_0.showFinishFlag)
		triggerButton(arg_7_0.leftBtnList[1])

		return
	end, SFX_PANEL)

	return
end

function var_0_0.resetLeftBtnUnsel(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.leftBtnList) do
		setActive(iter_11_1:Find("Selected"), false)
	end

	return
end

function var_0_0.switchRightPage(arg_12_0, arg_12_1)
	seriesAsync({
		function(arg_13_0)
			if not arg_12_0.rightPageTFList[arg_12_1] then
				local var_13_0 = arg_12_0._tf:Find("Panel/RightPanelContainer")

				arg_12_0.catchupPanels[arg_12_1 - 1] = var_0_0.CATCHUP_CLASSES[arg_12_1 - 1].New(nil, function()
					arg_12_0.rightPageTFList[arg_12_1] = arg_12_0.catchupPanels[var_0]._go

					setActive(arg_12_0.rightPageTFList[arg_12_1], false)
					SetParent(arg_12_0.rightPageTFList[arg_12_1], var_13_0, false)
					arg_13_0()

					return
				end)
			else
				arg_13_0()
			end

			return
		end,
		function(arg_15_0)
			local var_15_0 = arg_12_0.rightPageTFList[arg_12_0.curPageID]

			setActive(arg_12_0.rightPageTFList[arg_12_1], true)

			arg_12_0.onPageSwitchAnim = true

			arg_12_0:managedTween(LeanTween.alphaCanvas, function()
				arg_12_0.onPageSwitchAnim = false

				return
			end, GetOrAddComponent(arg_12_0.rightPageTFList[arg_12_1], typeof(CanvasGroup)), 1, var_0_0.PANEL_INTO_TIME):setFrom(0)

			if arg_12_0.rightPageTFList[arg_12_0.curPageID] then
				arg_12_0:managedTween(LeanTween.alphaCanvas, function()
					setActive(var_15_0, false)

					return
				end, GetOrAddComponent(arg_12_0.rightPageTFList[arg_12_0.curPageID], typeof(CanvasGroup)), 0, var_0_0.PANEL_INTO_TIME):setFrom(1)
			end

			arg_12_0.curPageID = arg_12_1

			if arg_12_1 == var_0_0.TEC_PAGE_TENDENCY then
				arg_12_0:updateTendencyPage(arg_12_0.curTendency)
			elseif arg_12_1 == var_0_0.TEC_PAGE_CATCHUP_ACT then
				arg_12_0:updateActCatchupPage()
			else
				arg_12_0:updateTargetCatchupPage(arg_12_1 - 1)
			end

			return
		end
	})

	return
end

function var_0_0.initTendencyPage(arg_18_0)
	local var_18_9000
	local var_18_0 = getProxy(TechnologyProxy)
	local var_18_1 = var_18_0.getConfigMaxVersion(var_18_9000)
	local var_18_2 = arg_18_0.tendencyPanel:Find("TecItemList")
	local var_18_3 = UIItemList.New(var_18_2, var_18_2:Find("tpl"))

	var_18_3.make(var_18_0, function(arg_19_0, arg_19_1, arg_19_2)
		if arg_19_0 == UIItemList.EventUpdate then
			local var_19_0 = arg_19_1 > 0 and i18n("tec_tendency_x", i18n("number_" .. arg_19_1)) or i18n("tec_tendency_0")

			setText(arg_19_2:Find("UnSelect/Text"), var_19_0)
			setText(arg_19_2:Find("Selected/Text"), var_19_0)
			onButton(arg_18_0, arg_19_2, function()
				if arg_18_0.curTendency ~= arg_19_1 then
					arg_18_0:emit(TechnologySettingsMediator.CHANGE_TENDENCY, arg_19_1)
				end

				return
			end, SFX_PANEL)
		end

		return
	end)
	var_18_3:align(var_18_1 + 1)

	return
end

function var_0_0.updateTendencyPage(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0.tendencyPanel:Find("TecItemList")

	setActive(var_21_0:GetChild(arg_21_0.curTendency):Find("Selected"), false)

	local var_21_1 = var_21_0:GetChild(arg_21_1):Find("Selected")

	setActive(var_21_1, true)
	setImageAlpha(var_21_1:Find("Image"), 0)
	arg_21_0:managedTween(LeanTween.alpha, nil, var_21_1:Find("Image"), 1, var_0_0.SELECT_TENDENCY_FADE_TIME):setFrom(0)

	local var_21_2 = arg_21_0.tendencyPanel:Find("TendencyNum")

	setImageAlpha(var_21_2:Find("Image"), 0)

	if arg_21_1 > 0 then
		GetImageSpriteFromAtlasAsync("ui/technologysettingsui_atlas", "right_tendency_num_" .. arg_21_1, var_21_2:Find("Image"), true)
		arg_21_0:managedTween(LeanTween.alpha, nil, var_21_2:Find("Image"), 1, var_0_0.SELECT_TENDENCY_FADE_TIME):setFrom(0)
	end

	arg_21_0.curTendency = arg_21_1

	return
end

function var_0_0.updateTendencyBtn(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1 > 0 and i18n("tec_tendency_cur_x", i18n("number_" .. arg_22_1)) or i18n("tec_tendency_cur_0")

	setText(arg_22_0.tendencyBtn:Find("UnSelect/Text"), var_22_0)
	setText(arg_22_0.tendencyBtn:Find("Selected/Text"), var_22_0)

	return
end

function var_0_0.updateTargetCatchupPage(arg_23_0, arg_23_1)
	arg_23_0.catchupPanels[arg_23_1]:updateTargetCatchupPage()

	return
end

function var_0_0.updateTargetCatchupBtns(arg_24_0)
	for iter_24_0, iter_24_1 in pairs(arg_24_0.catchupBtns) do
		if iter_24_0 <= var_0_0.CATCHUP_VERSION then
			local var_24_0 = arg_24_0.technologyProxy:getCatchupState(iter_24_0)
			local var_24_1 = var_24_0 == TechnologyCatchup.STATE_CATCHUPING
			local var_24_2 = iter_24_1:Find("UnSelect/Text")
			local var_24_3 = iter_24_1:Find("Selected/Text")
			local var_24_4 = iter_24_1:Find("UnSelect/CharImg")
			local var_24_5 = iter_24_1:Find("Selected/CharImg")
			local var_24_6 = var_24_4:Find("ProgressText")
			local var_24_7 = var_24_5:Find("ProgressText")

			setActive(var_24_4, var_24_0 == TechnologyCatchup.STATE_CATCHUPING)
			setActive(var_24_5, var_24_1)

			if var_24_1 then
				local var_24_8 = iter_24_0 > 0 and i18n("tec_target_catchup_selected_x", i18n("number_" .. iter_24_0)) or i18n("tec_target_catchup_selected_0")

				setText(var_24_2, var_24_8)
				setText(var_24_3, var_24_8)

				local var_24_9 = arg_24_0.technologyProxy:getCurCatchupTecInfo()
				local var_24_11 = var_24_9.printNum
				local var_24_12 = arg_24_0.technologyProxy:getCatchupData(var_24_9.tecID)

				if var_24_12:isUr(var_24_9.groupID) then
					local var_24_13 = pg.technology_catchup_template[var_24_9.tecID].obtain_max_per_ur or pg.technology_catchup_template[var_24_9.tecID].obtain_max

					setImageSprite(var_24_4, LoadSprite("TecCatchup/QChar" .. var_24_10, tostring(var_24_10)))
					setImageSprite(var_24_5, LoadSprite("TecCatchup/QChar" .. var_24_10, tostring(var_24_10)))
					setText(var_24_6, var_24_11 .. "/" .. var_24_13)
					setText(var_24_7, var_24_11 .. "/" .. var_24_13)

					if false then
						if var_24_0 == TechnologyCatchup.STATE_UNSELECT then
							local var_24_14 = iter_24_0 > 0 and i18n("tec_target_catchup_none_x", i18n("number_" .. iter_24_0)) or i18n("tec_target_catchup_none_0")

							setText(var_24_2, var_24_14)
							setText(var_24_3, var_24_14)
						elseif var_24_0 == TechnologyCatchup.STATE_FINISHED_ALL then
							local var_24_15 = iter_24_0 > 0 and i18n("tec_target_catchup_finish_x", i18n("number_" .. iter_24_0)) or i18n("tec_target_catchup_finish_0")

							setText(var_24_2, var_24_15)
							setText(var_24_3, var_24_15)
						end
					end
				end
			end
		end
	end

	return
end

function var_0_0.initActCatchupPage(arg_25_0)
	if arg_25_0.isShowActCatchup then
		arg_25_0.loader:GetPrefab("ui/" .. arg_25_0.actCatchup:getConfig("page_info").ui_name, "", function(arg_26_0)
			setParent(arg_26_0, arg_25_0.actCatchupPanel)
			setLocalScale(arg_26_0, {
				x = 0.925,
				y = 0.923
			})
			setAnchoredPosition(arg_26_0, Vector2.zero)

			arg_25_0.actCatchupTF = tf(arg_26_0):Find("AD")
			arg_25_0.actCatchupItemTF = arg_25_0.actCatchupTF:Find("Award")
			arg_25_0.actCatchupSliderTF = arg_25_0.actCatchupTF:Find("Slider")
			arg_25_0.actCatchupProgressText = arg_25_0.actCatchupTF:Find("Progress")

			local var_26_0 = arg_25_0.actCatchupTF:Find("GoBtn")

			if var_26_0 then
				setActive(var_26_0, false)
			end

			local var_26_1 = arg_25_0.actCatchupTF:Find("FinishBtn")

			if var_26_1 then
				setActive(var_26_1, false)
			end

			local var_26_2 = arg_25_0.actCatchup.data1
			local var_26_3 = pg.activity_event_blueprint_catchup[arg_25_0.actCatchup:getConfig("config_id")].obtain_max

			updateDrop(arg_25_0.actCatchupItemTF, {
				type = DROP_TYPE_ITEM,
				id = arg_25_0.actCatchup:getConfig("config_client").itemid
			})
			onButton(arg_25_0, arg_25_0.actCatchupItemTF, function()
				arg_25_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)
			setSlider(arg_25_0.actCatchupSliderTF, 0, var_26_3, var_26_2)
			setText(arg_25_0.actCatchupProgressText, var_26_2 .. "/" .. var_26_3)
			setActive(arg_26_0, true)

			return
		end)
	end

	return
end

function var_0_0.updateActCatchupPage(arg_28_0)
	return
end

function var_0_0.updateActCatchupBtn(arg_29_0)
	setText(arg_29_0.actCatchupBtn:Find("UnSelect/Text"), i18n("tec_act_catchup_btn_word"))
	setText(arg_29_0.actCatchupBtn:Find("Selected/Text"), i18n("tec_act_catchup_btn_word"))

	local var_29_0 = arg_29_0.actCatchupBtn:Find("UnSelect/CharImg")
	local var_29_1 = arg_29_0.actCatchupBtn:Find("Selected/CharImg")
	local var_29_2 = false
	local var_29_3 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BLUEPRINT_CATCHUP)

	if var_29_3 and not var_29_3:isEnd() then
		local var_29_4 = var_29_3:getConfig("config_id")

		setImageSprite(var_29_0, LoadSprite("TecCatchup/QChar" .. pg.activity_event_blueprint_catchup[var_29_4].char_choice, tostring(pg.activity_event_blueprint_catchup[var_29_4].char_choice)))
		setImageSprite(var_29_1, LoadSprite("TecCatchup/QChar" .. pg.activity_event_blueprint_catchup[var_29_4].char_choice, tostring(pg.activity_event_blueprint_catchup[var_29_4].char_choice)))
		setText(var_29_0:Find("ProgressText"), var_29_3.data1 .. "/" .. pg.activity_event_blueprint_catchup[var_29_4].obtain_max)
		setText(var_29_1:Find("ProgressText"), var_29_3.data1 .. "/" .. pg.activity_event_blueprint_catchup[var_29_4].obtain_max)

		local var_29_5 = var_29_3.stopTime - pg.TimeMgr.GetInstance():GetServerTime()

		if arg_29_0.actCatchupTimer then
			arg_29_0.actCatchupTimer:Stop()

			arg_29_0.actCatchupTimer = nil
		end

		local var_29_6 = arg_29_0.actCatchupBtn:Find("TimeLeft/Day")
		local var_29_7 = arg_29_0.actCatchupBtn:Find("TimeLeft/Hour")
		local var_29_8 = arg_29_0.actCatchupBtn:Find("TimeLeft/Min")
		local var_29_9 = arg_29_0.actCatchupBtn:Find("TimeLeft/NumText")

		arg_29_0.actCatchupTimer = Timer.New(function()
			local var_30_0, var_30_1, var_30_2, var_30_3 = pg.TimeMgr.GetInstance():parseTimeFrom(var_29_5)

			var_29_5 = var_29_5 - 1

			if var_30_0 >= 1 then
				setActive(var_29_6, true)
				setActive(var_29_7, false)
				setActive(var_29_8, false)
				setText(var_29_9, var_30_0)
			elseif var_30_0 <= 0 and var_30_1 > 0 then
				setActive(var_29_6, false)
				setActive(var_29_7, true)
				setActive(var_29_8, false)
				setText(var_29_9, var_30_1)
			elseif var_30_0 <= 0 and var_30_1 <= 0 and (var_30_2 > 0 or var_30_3 > 0) then
				setActive(var_29_6, false)
				setActive(var_29_7, false)
				setActive(var_29_8, true)
				setText(var_29_9, math.max(var_30_2, 1))
			elseif var_30_0 <= 0 and var_30_1 <= 0 and var_30_2 <= 0 and var_30_3 <= 0 and arg_29_0.actCatchupTimer then
				arg_29_0.actCatchupTimer:Stop()

				arg_29_0.actCatchupTimer = nil

				arg_29_0:switchRightPage(var_0_0.TEC_PAGE_TENDENCY)
				setActive(arg_29_0.actCatchupBtn, false)
			end

			return
		end, 1, -1, 1)

		arg_29_0.actCatchupTimer:Start()
		arg_29_0.actCatchupTimer.func()

		var_29_2 = true
	end

	setActive(arg_29_0.actCatchupBtn, var_29_2)

	return
end

return var_0_0
