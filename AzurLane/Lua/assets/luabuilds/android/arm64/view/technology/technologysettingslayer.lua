class = var_0_10000

local var_0_0 = "TechnologySettingsLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

var_0_1.TEC_PAGE_TENDENCY = 1
var_0_1.TEC_PAGE_CATCHUP_TARGET1 = 2
var_0_1.TEC_PAGE_CATCHUP_TARGET2 = 3
var_0_1.TEC_PAGE_CATCHUP_TARGET3 = 4
var_0_1.TEC_PAGE_CATCHUP_TARGET4 = 5
var_0_1.TEC_PAGE_CATCHUP_TARGET5 = 6
var_0_1.TEC_PAGE_CATCHUP_TARGET6 = 7
var_0_1.TEC_PAGE_CATCHUP_TARGET7 = 8
var_0_1.TEC_PAGE_CATCHUP_ACT = 99
var_0_1.PANEL_INTO_TIME = 0.15
var_0_1.SELECT_TENDENCY_FADE_TIME = 0.3
var_0_1.SELECT_CHAR_LIGHT_FADE_TIME = 0.3

local var_0_2 = {}

import = var_0_0
var_0_2[1] = var_0_0("view.technology.TargetCatchup.TargetCatchupPanel1")
import = var_2
var_0_2[2] = var_2("view.technology.TargetCatchup.TargetCatchupPanel2")
import = var_2
var_0_2[3] = var_2("view.technology.TargetCatchup.TargetCatchupPanel3")
import = var_2
var_0_2[4] = var_2("view.technology.TargetCatchup.TargetCatchupPanel4")
import = var_2
var_0_2[5] = var_2("view.technology.TargetCatchup.TargetCatchupPanel5")
import = var_2
var_0_2[6] = var_2("view.technology.TargetCatchup.TargetCatchupPanel6")
import = var_2
var_0_2[7] = var_2("view.technology.TargetCatchup.TargetCatchupPanel7")
var_0_1.CATCHUP_CLASSES = var_0_2
var_0_1.CATCHUP_VERSION = 7

function var_0_1.getUIName(arg_1_0)
	return "TechnologySettingsUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()
	arg_2_0:initTendencyPage()
	arg_2_0:initActCatchupPage()

	return
end

function var_0_1.didEnter(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_0, arg_3_0._tf)
	arg_3_0:resetLeftBtnUnsel()
	arg_3_0:updateTendencyBtn(arg_3_0.curTendency)
	arg_3_0:updateTargetCatchupBtns()
	arg_3_0:updateActCatchupBtn()

	triggerButton = var_1

	var_1(arg_3_0.leftBtnList[1])

	triggerToggle = var_1

	var_1(arg_3_0.showFinish, arg_3_0.showFinishFlag == 1 and true or false)

	getProxy = var_1
	CommanderManualProxy = var_3

	local var_3_1 = var_1(var_3)

	var_1.TaskProgressAdd(var_3_1, 2024, 1)

	return
end

function var_0_1.willExit(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_4_0, arg_4_0._tf)

	if arg_4_0.actCatchupTimer then
		local var_4_1 = arg_4_0.actCatchupTimer

		var_1.Stop(var_4_1)

		arg_4_0.actCatchupTimer = nil
	end

	pairs = var_1

	for iter_4_0, iter_4_1 in var_1(arg_4_0.catchupPanels) do
		iter_4_1:willExit()
	end

	local var_4_2 = arg_4_0.loader

	var_1.Clear(var_4_2)

	return
end

function var_0_1.initData(arg_5_0)
	getProxy = var_1_10001
	TechnologyProxy = var_1_10003
	arg_5_0.technologyProxy = var_1_10001(var_1_10003)
	getProxy = var_1
	BayProxy = var_1_10003
	arg_5_0.bayProxy = var_1(var_1_10003)
	getProxy = var_1
	BagProxy = var_1_10003
	arg_5_0.bagProxy = var_1(var_1_10003)
	arg_5_0.curPageID = 0

	local var_5_0 = arg_5_0.technologyProxy

	arg_5_0.curTendency = var_1.getTendency(var_5_0, 2)
	arg_5_0.curSelectedIndex = 0
	arg_5_0.reSelectTag = false
	getProxy = var_1
	ActivityProxy = var_5_0

	local var_5_1 = var_1(var_5_0)
	local var_5_2 = var_1.getActivityByType

	ActivityConst = var_4
	arg_5_0.actCatchup = var_5_2(var_5_1, var_4.ACTIVITY_TYPE_BLUEPRINT_CATCHUP)

	local var_5_4

	if arg_5_0.actCatchup then
		local var_5_3 = arg_5_0.actCatchup

		var_5_4 = not var_1.isEnd(var_5_3)
	end

	arg_5_0.isShowActCatchup = var_5_4
	AutoLoader = var_5_4
	arg_5_0.loader = var_5_4.New()

	return
end

function var_0_1.findUI(arg_6_0)
	local var_6_0 = arg_6_0._tf

	arg_6_0.bg = var_1.Find(var_6_0, "BG")

	local var_6_1 = arg_6_0.bg
	local var_6_2

	var_6_2, setText = var_1.Find(var_6_1, "BackTips/ClickText"), var_1_10002
	i18n = var_1_10005

	var_1_10002(var_6_2, var_1_10005("click_back_tip"))

	local var_6_3 = arg_6_0._tf
	local var_6_4 = var_2.Find(var_6_3, "Panel")
	local var_6_5 = var_2.Find(var_6_4, "LeftScrollViewMask/LeftScrollView/LeftBtnList")

	arg_6_0.leftBtnList = {}
	arg_6_0.tendencyBtn = var_6_5:Find("TendencyBtn")
	arg_6_0.leftBtnList[var_0_1.TEC_PAGE_TENDENCY] = arg_6_0.tendencyBtn
	arg_6_0.catchupBtns = {}

	for iter_6_0 = 1, var_0_1.CATCHUP_VERSION do
		local var_6_6 = arg_6_0.catchupBtns

		cloneTplTo = var_1_10009
		var_6_6[iter_6_0] = var_1_10009(var_6_5:Find("TargetCatchupBtn_tpl"), var_6_5)
		arg_6_0.leftBtnList[iter_6_0 + 1] = arg_6_0.catchupBtns[iter_6_0]
	end

	arg_6_0.actCatchupBtn = var_6_5:Find("ActCatchupBtn")

	local var_6_7 = arg_6_0.actCatchupBtn

	var_4.SetAsLastSibling(var_6_7)

	arg_6_0.leftBtnList[var_0_1.TEC_PAGE_CATCHUP_ACT] = arg_6_0.actCatchupBtn

	local var_6_8 = var_2:Find("RightPanelContainer")

	arg_6_0.rightPageTFList = {}
	arg_6_0.tendencyPanel = var_6_8:Find("TecTendencyPanel")
	arg_6_0.rightPageTFList[var_0_1.TEC_PAGE_TENDENCY] = arg_6_0.tendencyPanel
	arg_6_0.catchupPanels = {}
	arg_6_0.actCatchupPanel = var_6_8:Find("ActCatchupPanel")
	arg_6_0.rightPageTFList[var_0_1.TEC_PAGE_CATCHUP_ACT] = arg_6_0.actCatchupPanel

	local var_6_9 = arg_6_0._tf

	arg_6_0.showFinish = var_5.Find(var_6_9, "ShowFinishToggle")
	setText = var_5

	local var_6_10 = arg_6_0.showFinish
	local var_6_11 = var_7.Find(var_6_10, "Label")

	i18n = var_8

	var_5(var_6_11, var_8("tec_target_catchup_show_the_finished_version"))

	PlayerPrefs = var_5

	local var_6_12

	if not var_5.GetInt("isShowFinishCatchupVersion") then
		var_6_12 = 0
	end

	arg_6_0.showFinishFlag = var_6_12

	if var_0_1.CATCHUP_VERSION < 1 then
		setActive = var_5

		var_5(arg_6_0.showFinish, false)
	end

	return
end

function var_0_1.addListener(arg_7_0)
	onButton = var_1_10001

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.bg

	local function var_7_2()
		local var_8_0 = arg_7_0

		var_0.closeView(var_8_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_7_0, var_7_1, var_7_2, var_1_10006)

	pairs = var_1_10001

	for iter_7_0, iter_7_1 in var_1_10001(arg_7_0.leftBtnList) do
		onButton = var_1_10006

		local var_7_3 = arg_7_0
		local var_7_4 = iter_7_1

		local function var_7_5()
			if arg_7_0.onPageSwitchAnim then
				return
			end

			if arg_7_0.curPageID ~= iter_7_0 then
				local var_9_0 = arg_7_0

				var_0.resetLeftBtnUnsel(var_9_0)

				setActive = var_0

				local var_9_1 = iter_7_1

				var_0(var_2.Find(var_9_1, "Selected"), true)

				local var_9_2 = arg_7_0

				var_0.switchRightPage(var_9_2, iter_7_0)
			end

			return
		end

		SFX_PANEL = var_1_10011

		var_1_10006(var_7_3, var_7_4, var_7_5, var_1_10011)
	end

	onToggle = var_1

	local var_7_6 = arg_7_0
	local var_7_7 = arg_7_0.showFinish

	local function var_7_8(arg_10_0)
		if var_0_1.CATCHUP_VERSION < 1 then
			return
		end

		pairs = var_1

		for iter_10_0, iter_10_1 in var_1(arg_7_0.catchupBtns) do
			if iter_10_0 <= var_0_1.CATCHUP_VERSION then
				local var_10_0 = arg_7_0.technologyProxy
				local var_10_1 = var_6.getCatchupState(var_10_0, iter_10_0)

				TechnologyCatchup = var_2_10007

				if var_10_1 == var_2_10007.STATE_FINISHED_ALL and not arg_10_0 then
					setActive = var_2_10007

					var_2_10007(iter_10_1, false)
				else
					setActive = var_2_10007

					var_2_10007(iter_10_1, true)
				end
			end
		end

		local var_10_2 = arg_7_0

		var_10_2.showFinishFlag = arg_10_0 and 1 or 0
		PlayerPrefs = var_10_2

		var_10_2.SetInt("isShowFinishCatchupVersion", arg_7_0.showFinishFlag)

		triggerButton = var_1

		var_1(arg_7_0.leftBtnList[1])

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_7_6, var_7_7, var_7_8, var_1_10006)

	return
end

function var_0_1.resetLeftBtnUnsel(arg_11_0)
	pairs = var_1_10001

	for iter_11_0, iter_11_1 in var_1_10001(arg_11_0.leftBtnList) do
		local var_11_0 = iter_11_1:Find("Selected")

		setActive = var_1_10007

		var_1_10007(var_11_0, false)
	end

	return
end

function var_0_1.switchRightPage(arg_12_0, arg_12_1)
	seriesAsync = var_1_10002

	var_1_10002({
		function(arg_13_0)
			if not arg_12_0.rightPageTFList[arg_12_1] then
				local var_13_0 = arg_12_1 - 1
				local var_13_1 = arg_12_0._tf
				local var_13_2 = var_2.Find(var_13_1, "Panel/RightPanelContainer")

				arg_12_0.catchupPanels[var_13_0] = var_0_1.CATCHUP_CLASSES[var_13_0].New(nil, function()
					local var_14_0 = arg_12_0.rightPageTFList

					var_14_0[arg_12_1] = arg_12_0.catchupPanels[var_13_0]._go
					setActive = var_14_0

					var_14_0(arg_12_0.rightPageTFList[arg_12_1], false)

					SetParent = var_14_0

					var_14_0(arg_12_0.rightPageTFList[arg_12_1], var_13_2, false)
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
			local var_15_1 = arg_12_0.rightPageTFList[arg_12_1]

			setActive = var_3

			var_3(var_15_1, true)

			arg_12_0.onPageSwitchAnim = true

			local var_15_2 = arg_12_0
			local var_15_3 = var_3.managedTween

			LeanTween = var_6

			local var_15_4 = var_6.alphaCanvas

			local function var_15_5()
				arg_12_0.onPageSwitchAnim = false

				return
			end

			GetOrAddComponent = var_2_10008

			local var_15_6 = var_15_1

			typeof = var_2_10011
			CanvasGroup = var_2_10013

			local var_15_7 = var_15_3(var_15_2, var_15_4, var_15_5, var_2_10008(var_15_6, var_2_10011(var_2_10013)), 1, var_0_1.PANEL_INTO_TIME)

			var_3.setFrom(var_15_7, 0)

			if var_15_0 then
				local var_15_8 = arg_12_0
				local var_15_9 = var_3.managedTween

				LeanTween = var_6

				local var_15_10 = var_6.alphaCanvas

				local function var_15_11()
					setActive = var_3_10000

					var_3_10000(var_15_0, false)

					return
				end

				GetOrAddComponent = var_8

				local var_15_12 = var_15_0

				typeof = var_11
				CanvasGroup = var_2_10013

				local var_15_13 = var_15_9(var_15_8, var_15_10, var_15_11, var_8(var_15_12, var_11(var_2_10013)), 0, var_0_1.PANEL_INTO_TIME)

				var_3.setFrom(var_15_13, 1)
			end

			arg_12_0.curPageID = arg_12_1

			if arg_12_1 == var_0_1.TEC_PAGE_TENDENCY then
				local var_15_14 = arg_12_0

				var_3.updateTendencyPage(var_15_14, arg_12_0.curTendency)
			elseif arg_12_1 == var_0_1.TEC_PAGE_CATCHUP_ACT then
				local var_15_15 = arg_12_0

				var_3.updateActCatchupPage(var_15_15)
			else
				local var_15_16 = arg_12_0

				var_3.updateTargetCatchupPage(var_15_16, arg_12_1 - 1)
			end

			return
		end
	})

	return
end

function var_0_1.initTendencyPage(arg_18_0)
	getProxy = var_1_10001
	TechnologyProxy = var_1_10003

	local var_18_0 = var_1_10001(var_1_10003)
	local var_18_1 = var_1.getConfigMaxVersion(var_18_0)
	local var_18_2 = arg_18_0.tendencyPanel
	local var_18_3 = var_2.Find(var_18_2, "TecItemList")

	UIItemList = var_18_0

	local var_18_4 = var_18_0.New(var_18_3, var_18_3:Find("tpl"))

	var_3.make(var_18_4, function(arg_19_0, arg_19_1, arg_19_2)
		UIItemList = var_2_10003

		if arg_19_0 == var_2_10003.EventUpdate then
			if 0 < arg_19_1 then
				i18n = var_19_1

				local var_19_0 = "tec_tendency_x"

				i18n = var_2_10006

				local var_19_1

				if not var_19_1(var_19_0, var_2_10006("number_" .. arg_19_1)) then
					i18n = var_19_1
					var_19_1 = var_19_1("tec_tendency_0")
				end

				setText = var_2_10004

				var_2_10004(arg_19_2:Find("UnSelect/Text"), var_19_1)

				setText = var_2_10004

				var_2_10004(arg_19_2:Find("Selected/Text"), var_19_1)

				onButton = var_2_10004

				local var_19_2 = arg_18_0
				local var_19_3 = arg_19_2

				local function var_19_4()
					if arg_18_0.curTendency ~= arg_19_1 then
						local var_20_0 = arg_18_0
						local var_20_1 = var_0.emit

						TechnologySettingsMediator = var_3_10003

						var_20_1(var_20_0, var_3_10003.CHANGE_TENDENCY, arg_19_1)
					end

					return
				end

				SFX_PANEL = var_9

				var_2_10004(var_19_2, var_19_3, var_19_4, var_9)

				return
			end
		end
	end)
	var_3:align(var_18_1 + 1)

	return
end

function var_0_1.updateTendencyPage(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0.tendencyPanel
	local var_21_1 = var_2.Find(var_21_0, "TecItemList")

	setActive = var_1_10003

	local var_21_2 = var_21_1:GetChild(arg_21_0.curTendency)

	var_1_10003(var_5.Find(var_21_2, "Selected"), false)

	local var_21_3 = var_21_1:GetChild(arg_21_1)
	local var_21_4 = var_3.Find(var_21_3, "Selected")

	setActive = var_21_0

	var_21_0(var_21_4, true)

	setImageAlpha = var_21_0

	var_21_0(var_21_4:Find("Image"), 0)

	local var_21_5 = arg_21_0
	local var_21_6 = arg_21_0.managedTween

	LeanTween = var_7

	local var_21_7 = var_21_6(var_21_5, var_7.alpha, nil, var_21_4:Find("Image"), 1, var_0_1.SELECT_TENDENCY_FADE_TIME)

	var_4.setFrom(var_21_7, 0)

	local var_21_8 = arg_21_0.tendencyPanel
	local var_21_9 = var_4.Find(var_21_8, "TendencyNum")

	setImageAlpha = var_21_3

	var_21_3(var_21_9:Find("Image"), 0)

	if 0 < arg_21_1 then
		GetImageSpriteFromAtlasAsync = var_5

		var_5("ui/technologysettingsui_atlas", "right_tendency_num_" .. arg_21_1, var_21_9:Find("Image"), true)

		local var_21_10 = arg_21_0
		local var_21_11 = arg_21_0.managedTween

		LeanTween = var_8

		local var_21_12 = var_21_11(var_21_10, var_8.alpha, nil, var_21_9:Find("Image"), 1, var_0_1.SELECT_TENDENCY_FADE_TIME)

		var_5.setFrom(var_21_12, 0)
	end

	arg_21_0.curTendency = arg_21_1

	return
end

function var_0_1.updateTendencyBtn(arg_22_0, arg_22_1)
	if 0 < arg_22_1 then
		i18n = var_22_1

		local var_22_0 = "tec_tendency_cur_x"

		i18n = var_1_10005

		local var_22_1

		if not var_22_1(var_22_0, var_1_10005("number_" .. arg_22_1)) then
			i18n = var_22_1
			var_22_1 = var_22_1("tec_tendency_cur_0")
		end

		setText = var_1_10003

		local var_22_2 = arg_22_0.tendencyBtn

		var_1_10003(var_5.Find(var_22_2, "UnSelect/Text"), var_22_1)

		setText = var_1_10003

		local var_22_3 = arg_22_0.tendencyBtn

		var_1_10003(var_5.Find(var_22_3, "Selected/Text"), var_22_1)

		return
	end
end

function var_0_1.updateTargetCatchupPage(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0.catchupPanels[arg_23_1]

	var_2.updateTargetCatchupPage(var_23_0)

	return
end

function var_0_1.updateTargetCatchupBtns(arg_24_0)
	pairs = var_1_10001

	for iter_24_0, iter_24_1 in var_1_10001(arg_24_0.catchupBtns) do
		if iter_24_0 <= var_0_1.CATCHUP_VERSION then
			local var_24_0 = arg_24_0.technologyProxy
			local var_24_1 = var_6.getCatchupState(var_24_0, iter_24_0)

			TechnologyCatchup = var_1_10007
			var_1_10007 = var_24_1 == var_1_10007.STATE_CATCHUPING

			local var_24_2 = iter_24_1:Find("UnSelect/Text")
			local var_24_3 = iter_24_1:Find("Selected/Text")
			local var_24_4 = iter_24_1:Find("UnSelect/CharImg")
			local var_24_5 = iter_24_1:Find("Selected/CharImg")
			local var_24_6 = var_24_4
			local var_24_7 = var_24_4.Find(var_24_6, "ProgressText")
			local var_24_8 = var_24_5
			local var_24_9 = var_24_5.Find(var_24_8, "ProgressText")

			setActive = var_24_6

			var_24_6(var_24_4, var_1_10007)

			setActive = var_24_6

			var_24_6(var_24_5, var_1_10007)

			if var_1_10007 then
				if 0 < iter_24_0 then
					i18n = var_24_6

					local var_24_10 = "tec_target_catchup_selected_x"

					i18n = var_24_11

					if not var_24_6(var_24_10, var_24_11("number_" .. iter_24_0)) then
						i18n = var_24_6
						var_24_6 = var_24_6("tec_target_catchup_selected_0")
					end

					setText = var_24_8

					var_24_8(var_24_2, var_24_6)

					setText = var_24_8

					var_24_8(var_24_3, var_24_6)

					local var_24_11 = arg_24_0.technologyProxy
					local var_24_12 = var_24_8.getCurCatchupTecInfo(var_24_11).tecID

					var_24_11 = var_24_8.groupID

					local var_24_13 = var_24_8.printNum
					local var_24_14 = arg_24_0.technologyProxy
					local var_24_15 = var_19.getCatchupData(var_24_14, var_24_12)

					if var_19.isUr(var_24_15, var_24_11) then
						pg = var_24_14

						if not var_24_14.technology_catchup_template[var_24_12].obtain_max_per_ur then
							pg = var_24_14
							var_24_14 = var_24_14.technology_catchup_template[var_24_12].obtain_max
						end

						setImageSprite = var_24_15

						local var_24_16 = var_24_4

						LoadSprite = var_1_10025

						local var_24_17 = "TecCatchup/QChar" .. var_24_11

						tostring = var_28

						var_24_15(var_24_16, var_1_10025(var_24_17, var_28(var_24_11)))

						setImageSprite = var_24_15

						local var_24_18 = var_24_5

						LoadSprite = var_1_10025

						local var_24_19 = "TecCatchup/QChar" .. var_24_11

						tostring = var_28

						var_24_15(var_24_18, var_1_10025(var_24_19, var_28(var_24_11)))

						setText = var_24_15

						var_24_15(var_24_7, var_24_13 .. "/" .. var_24_14)

						setText = var_24_15

						var_24_15(var_24_9, var_24_13 .. "/" .. var_24_14)

						goto label_24_0

						TechnologyCatchup = var_24_6

						if var_24_1 == var_24_6.STATE_UNSELECT then
							if 0 < iter_24_0 then
								i18n = var_24_21

								local var_24_20 = "tec_target_catchup_none_x"

								i18n = var_24_11

								local var_24_21

								if not var_24_21(var_24_20, var_24_11("number_" .. iter_24_0)) then
									i18n = var_24_21
									var_24_21 = var_24_21("tec_target_catchup_none_0")
								end

								setText = var_24_8

								var_24_8(var_24_2, var_24_21)

								setText = var_24_8

								var_24_8(var_24_3, var_24_21)

								goto label_24_0

								TechnologyCatchup = var_24_21

								if var_24_1 == var_24_21.STATE_FINISHED_ALL then
									if 0 < iter_24_0 then
										i18n = var_24_23

										do
											local var_24_22 = "tec_target_catchup_finish_x"

											i18n = var_24_11

											local var_24_23

											if not var_24_23(var_24_22, var_24_11("number_" .. iter_24_0)) then
												i18n = var_24_23
												var_24_23 = var_24_23("tec_target_catchup_finish_0")
											end

											setText = var_24_8

											var_24_8(var_24_2, var_24_23)

											setText = var_24_8

											var_24_8(var_24_3, var_24_23)
										end

										::label_24_0::
									end
								end
							end
						end
					end
				end
			end
		end
	end

	return
end

function var_0_1.initActCatchupPage(arg_25_0)
	if arg_25_0.isShowActCatchup then
		local var_25_0 = arg_25_0.actCatchup
		local var_25_1 = var_1.getConfig(var_25_0, "page_info").ui_name
		local var_25_2 = arg_25_0.loader

		var_2.GetPrefab(var_25_2, "ui/" .. var_25_1, "", function(arg_26_0)
			setParent = var_2_10001

			var_2_10001(arg_26_0, arg_25_0.actCatchupPanel)

			setLocalScale = var_2_10001

			var_2_10001(arg_26_0, {
				x = 0.925,
				y = 0.923
			})

			setAnchoredPosition = var_2_10001

			local var_26_0 = arg_26_0

			Vector2 = var_4

			var_2_10001(var_26_0, var_4.zero)

			local var_26_1 = arg_25_0

			tf = var_2_10002

			local var_26_2 = var_2_10002(arg_26_0)

			var_26_1.actCatchupTF = var_2.Find(var_26_2, "AD")

			local var_26_3 = arg_25_0
			local var_26_4 = arg_25_0.actCatchupTF

			var_26_3.actCatchupItemTF = var_2.Find(var_26_4, "Award")

			local var_26_5 = arg_25_0
			local var_26_6 = arg_25_0.actCatchupTF

			var_26_5.actCatchupSliderTF = var_2.Find(var_26_6, "Slider")

			local var_26_7 = arg_25_0
			local var_26_8 = arg_25_0.actCatchupTF

			var_26_7.actCatchupProgressText = var_2.Find(var_26_8, "Progress")

			local var_26_9 = arg_25_0.actCatchupTF

			if var_1.Find(var_26_9, "GoBtn") then
				setActive = var_2

				var_2(var_1, false)
			end

			local var_26_10 = arg_25_0.actCatchupTF

			if var_2.Find(var_26_10, "FinishBtn") then
				setActive = var_26_9

				var_26_9(var_2, false)
			end

			local var_26_11 = arg_25_0.actCatchup.data1
			local var_26_12 = arg_25_0.actCatchup
			local var_26_13 = var_4.getConfig(var_26_12, "config_id")

			pg = var_5

			local var_26_14 = var_5.activity_event_blueprint_catchup[var_26_13].obtain_max
			local var_26_15 = arg_25_0.actCatchup
			local var_26_16 = var_6.getConfig(var_26_15, "config_client").itemid
			local var_26_17 = {}

			DROP_TYPE_ITEM = var_26_15
			var_26_17.type = var_26_15
			var_26_17.id = var_26_16
			updateDrop = var_26_15

			var_26_15(arg_25_0.actCatchupItemTF, var_26_17)

			onButton = var_26_15

			local var_26_18 = arg_25_0
			local var_26_19 = arg_25_0.actCatchupItemTF

			local function var_26_20()
				local var_27_0 = arg_25_0
				local var_27_1 = var_0.emit

				BaseUI = var_3_10003

				var_27_1(var_27_0, var_3_10003.ON_DROP, var_26_17)

				return
			end

			SFX_PANEL = var_2_10013

			var_26_15(var_26_18, var_26_19, var_26_20, var_2_10013)

			setSlider = var_26_15

			var_26_15(arg_25_0.actCatchupSliderTF, 0, var_26_14, var_26_11)

			setText = var_26_15

			var_26_15(arg_25_0.actCatchupProgressText, var_26_11 .. "/" .. var_26_14)

			setActive = var_26_15

			var_26_15(arg_26_0, true)

			return
		end)
	end

	return
end

function var_0_1.updateActCatchupPage(arg_28_0)
	return
end

function var_0_1.updateActCatchupBtn(arg_29_0)
	local var_29_0 = arg_29_0.actCatchupBtn
	local var_29_1 = var_1.Find(var_29_0, "UnSelect/Text")
	local var_29_2 = arg_29_0.actCatchupBtn
	local var_29_3 = var_2.Find(var_29_2, "Selected/Text")

	setText = var_29_0

	local var_29_4 = var_29_1

	i18n = var_1_10006

	var_29_0(var_29_4, var_1_10006("tec_act_catchup_btn_word"))

	setText = var_29_0

	local var_29_5 = var_29_3

	i18n = var_6

	var_29_0(var_29_5, var_6("tec_act_catchup_btn_word"))

	local var_29_6 = arg_29_0.actCatchupBtn
	local var_29_7 = var_3.Find(var_29_6, "UnSelect/CharImg")
	local var_29_8 = arg_29_0.actCatchupBtn
	local var_29_9 = var_4.Find(var_29_8, "Selected/CharImg")
	local var_29_10 = var_29_7:Find("ProgressText")
	local var_29_11 = var_29_9
	local var_29_12 = var_29_9.Find(var_29_11, "ProgressText")
	local var_29_13 = false

	getProxy = var_29_11
	ActivityProxy = var_1_10010

	local var_29_14 = var_29_11(var_1_10010)
	local var_29_15 = var_8.getActivityByType

	ActivityConst = var_1_10011

	local var_29_17

	if var_29_15(var_29_14, var_1_10011.ACTIVITY_TYPE_BLUEPRINT_CATCHUP) then
		local var_29_16 = var_8

		if not var_8.isEnd(var_29_16) then
			var_29_17 = var_8.data1

			local var_29_18 = var_8
			local var_29_19 = var_8.getConfig(var_29_18, "config_id")

			pg = var_29_16

			local var_29_20 = var_29_16.activity_event_blueprint_catchup[var_29_19].char_choice

			pg = var_29_18

			local var_29_21 = var_29_18.activity_event_blueprint_catchup[var_29_19].obtain_max

			setImageSprite = var_13

			local var_29_22 = var_29_7

			LoadSprite = var_1_10016

			local var_29_23 = "TecCatchup/QChar" .. var_29_20

			tostring = var_19

			var_13(var_29_22, var_1_10016(var_29_23, var_19(var_29_20)))

			setImageSprite = var_13

			local var_29_24 = var_29_9

			LoadSprite = var_16

			local var_29_25 = "TecCatchup/QChar" .. var_29_20

			tostring = var_19

			var_13(var_29_24, var_16(var_29_25, var_19(var_29_20)))

			setText = var_13

			var_13(var_29_10, var_29_17 .. "/" .. var_29_21)

			setText = var_13

			var_13(var_29_12, var_29_17 .. "/" .. var_29_21)

			local var_29_26 = var_8.stopTime

			pg = var_1_10014

			local var_29_27 = var_1_10014.TimeMgr.GetInstance()
			local var_29_28 = var_29_26 - var_14.GetServerTime(var_29_27)

			if arg_29_0.actCatchupTimer then
				local var_29_29 = arg_29_0.actCatchupTimer

				var_14.Stop(var_29_29)

				arg_29_0.actCatchupTimer = nil
			end

			local var_29_30 = arg_29_0.actCatchupBtn
			local var_29_31 = var_14.Find(var_29_30, "TimeLeft/Day")
			local var_29_32 = arg_29_0.actCatchupBtn
			local var_29_33 = var_15.Find(var_29_32, "TimeLeft/Hour")
			local var_29_34 = arg_29_0.actCatchupBtn
			local var_29_35 = var_16.Find(var_29_34, "TimeLeft/Min")
			local var_29_36 = arg_29_0.actCatchupBtn
			local var_29_37 = var_17.Find(var_29_36, "TimeLeft/NumText")

			local function var_29_38()
				pg = var_2_10000

				local var_30_0 = var_2_10000.TimeMgr.GetInstance()
				local var_30_1, var_30_2, var_30_3, var_30_4 = var_0.parseTimeFrom(var_30_0, var_29_28)

				var_29_28 = var_29_28 - 1

				if 1 <= var_30_1 then
					setActive = var_4

					var_4(var_29_31, true)

					setActive = var_4

					var_4(var_29_33, false)

					setActive = var_4

					var_4(var_29_35, false)

					setText = var_4

					var_4(var_29_37, var_30_1)
				elseif var_30_1 <= 0 and 0 < var_30_2 then
					setActive = var_4

					var_4(var_29_31, false)

					setActive = var_4

					var_4(var_29_33, true)

					setActive = var_4

					var_4(var_29_35, false)

					setText = var_4

					var_4(var_29_37, var_30_2)
				elseif var_30_1 <= 0 and var_30_2 <= 0 and (0 < var_30_3 or 0 < var_30_4) then
					setActive = var_4

					var_4(var_29_31, false)

					setActive = var_4

					var_4(var_29_33, false)

					setActive = var_4

					var_4(var_29_35, true)

					setText = var_4

					local var_30_5 = var_29_37

					math = var_7

					var_4(var_30_5, var_7.max(var_30_3, 1))
				elseif var_30_1 <= 0 and var_30_2 <= 0 and var_30_3 <= 0 and var_30_4 <= 0 and arg_29_0.actCatchupTimer then
					local var_30_6 = arg_29_0.actCatchupTimer

					var_4.Stop(var_30_6)

					arg_29_0.actCatchupTimer = nil

					local var_30_7 = arg_29_0

					var_4.switchRightPage(var_30_7, var_0_1.TEC_PAGE_TENDENCY)

					setActive = var_4

					var_4(arg_29_0.actCatchupBtn, false)
				end

				return
			end

			Timer = var_29_36
			arg_29_0.actCatchupTimer = var_29_36.New(var_29_38, 1, -1, 1)

			local var_29_39 = arg_29_0.actCatchupTimer

			var_19.Start(var_29_39)
			arg_29_0.actCatchupTimer.func()

			var_29_13 = true
		end
	end

	setActive = var_29_17

	var_29_17(arg_29_0.actCatchupBtn, var_29_13)

	return
end

return var_0_1
