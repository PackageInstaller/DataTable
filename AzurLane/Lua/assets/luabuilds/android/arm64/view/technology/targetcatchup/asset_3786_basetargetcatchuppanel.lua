class = var_0_10000

local var_0_0 = "BaseTargetCatchupPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseUI"))

var_0_1.SELECT_CHAR_LIGHT_FADE_TIME = 0.3

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0)

	PoolMgr = var_3

	local var_1_0 = var_3.GetInstance()

	var_3.GetUI(var_1_0, arg_1_0:getUIName(), true, function(arg_2_0)
		local var_2_0 = arg_2_0.transform

		var_1.SetParent(var_2_0, arg_1_1, false)

		local var_2_1 = arg_1_0

		var_1.onUILoaded(var_2_1, arg_2_0)

		if arg_1_2 then
			arg_1_2()
		end

		return
	end)

	return
end

function var_0_1.getUIName(arg_3_0)
	assert = var_1_10001

	var_1_10001(false)

	return ""
end

function var_0_1.init(arg_4_0)
	return
end

function var_0_1.initData(arg_5_0)
	arg_5_0.curSelectedIndex = 0
	getProxy = var_1
	TechnologyProxy = var_1_10003
	arg_5_0.technologyProxy = var_1(var_1_10003)
	getProxy = var_1
	BayProxy = var_1_10003
	arg_5_0.bayProxy = var_1(var_1_10003)
	getProxy = var_1
	BagProxy = var_1_10003
	arg_5_0.bagProxy = var_1(var_1_10003)
	pg = var_1
	arg_5_0.configCatchup = var_1.technology_catchup_template
	arg_5_0.charIDList = arg_5_0.configCatchup[arg_5_0.tecID].char_choice
	arg_5_0.urList = arg_5_0.configCatchup[arg_5_0.tecID].ur_char

	local var_5_0 = arg_5_0.technologyProxy

	arg_5_0.state = var_1.getCatchupState(var_5_0, arg_5_0.tecID)

	return
end

function var_0_1.initUI(arg_6_0)
	local var_6_0 = arg_6_0._tf

	arg_6_0.choosePanel = var_1.Find(var_6_0, "ChoosePanel")

	local var_6_1 = arg_6_0.choosePanel
	local var_6_2 = var_1.Find(var_6_1, "SelectedImgTpl")
	local var_6_3 = arg_6_0.choosePanel
	local var_6_4 = var_2.Find(var_6_3, "SelectedImgList")

	UIItemList = var_6_1
	arg_6_0.selectedImgUIItemList = var_6_1.New(var_6_4, var_6_2)

	local var_6_5 = arg_6_0.selectedImgUIItemList

	var_3.make(var_6_5, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			arg_7_1 = arg_7_1 + 1

			local var_7_0 = arg_7_2:Find("Selected")

			setActive = var_2_10004

			var_2_10004(var_7_0, arg_7_1 == arg_6_0.curSelectedIndex)

			if arg_7_1 == arg_6_0.curSelectedIndex then
				setImageAlpha = var_4

				var_4(var_7_0, 0)

				local var_7_1 = arg_6_0

				var_4.updateProgress(var_7_1, arg_6_0.charIDList[arg_6_0.curSelectedIndex])

				local var_7_2 = arg_6_0
				local var_7_3 = var_4.managedTween

				LeanTween = var_7

				local var_7_4 = var_7.alpha
				local var_7_5

				rtf = var_2_10009

				local var_7_6 = var_7_3(var_7_2, var_7_4, var_7_5, var_2_10009(var_7_0), 1, var_0_1.SELECT_CHAR_LIGHT_FADE_TIME)

				var_4.setFrom(var_7_6, 0)
			end
		end

		return
	end)

	local var_6_6 = arg_6_0.selectedImgUIItemList

	var_3.align(var_6_6, #arg_6_0.charIDList)

	local var_6_7 = arg_6_0.choosePanel
	local var_6_8 = var_3.Find(var_6_7, "CharTpl")
	local var_6_9 = arg_6_0.choosePanel
	local var_6_10 = var_4.Find(var_6_9, "CharList")

	UIItemList = var_6_7
	arg_6_0.charUIItemList = var_6_7.New(var_6_10, var_6_8)

	local var_6_11 = arg_6_0.charUIItemList

	var_5.make(var_6_11, function(arg_8_0, arg_8_1, arg_8_2)
		UIItemList = var_2_10003

		if arg_8_0 == var_2_10003.EventUpdate then
			arg_8_1 = arg_8_1 + 1

			local var_8_0 = arg_6_0

			var_3.updateCharTpl(var_8_0, arg_8_1, arg_8_2)

			onButton = var_3

			local var_8_1 = arg_6_0
			local var_8_2 = arg_8_2

			local function var_8_3()
				if arg_8_1 ~= arg_6_0.curSelectedIndex then
					arg_6_0.curSelectedIndex = arg_8_1

					local var_9_0 = arg_6_0.selectedImgUIItemList

					var_0.align(var_9_0, #arg_6_0.charIDList)
				end

				return
			end

			SFX_PANEL = var_2_10008

			var_3(var_8_1, var_8_2, var_8_3, var_2_10008)
		end

		return
	end)

	local var_6_12 = arg_6_0.charUIItemList

	var_5.align(var_6_12, #arg_6_0.charIDList)

	local var_6_13 = arg_6_0.choosePanel

	arg_6_0.confirmBtn = var_5.Find(var_6_13, "ConfirmBtn")
	onButton = var_5

	local var_6_14 = arg_6_0
	local var_6_15 = arg_6_0.confirmBtn

	local function var_6_16()
		if arg_6_0.curSelectedIndex and arg_6_0.curSelectedIndex ~= 0 then
			local var_10_0 = arg_6_0.charIDList[arg_6_0.curSelectedIndex]

			pg = var_1

			local var_10_1 = var_1.MsgboxMgr.GetInstance()
			local var_10_2 = var_1.ShowMsgBox
			local var_10_3 = {}

			i18n = var_2_10005

			local var_10_4 = "tec_target_catchup_select_tip"

			ShipGroup = var_2_10008
			var_10_3.content = var_2_10005(var_10_4, var_2_10008.getDefaultShipNameByGroupID(var_10_0))

			function var_10_3.onYes()
				pg = var_3_10000

				local var_11_0 = var_3_10000.m02
				local var_11_1 = var_0.sendNotification

				GAME = var_3_10003

				var_11_1(var_11_0, var_3_10003.SELECT_TEC_TARGET_CATCHUP, {
					tecID = arg_6_0.tecID,
					charID = var_10_0
				})

				return
			end

			var_10_2(var_10_1, var_10_3)
		end

		return
	end

	SFX_PANEL = var_1_10010

	var_5(var_6_14, var_6_15, var_6_16, var_1_10010)

	local var_6_17 = arg_6_0.choosePanel

	arg_6_0.proTitle = var_5.Find(var_6_17, "ProgressTitle/Text")
	setText = var_5

	local var_6_18 = arg_6_0.proTitle

	i18n = var_8

	var_5(var_6_18, var_8("tec_target_catchup_progress"))

	local var_6_19 = arg_6_0.choosePanel

	arg_6_0.ssrProgress = var_5.Find(var_6_19, "ProgressTitle/Progress_SSR")

	local var_6_20 = arg_6_0.choosePanel

	arg_6_0.urProgress = var_5.Find(var_6_20, "ProgressTitle/Progress_UR")

	local var_6_21 = arg_6_0._tf

	arg_6_0.showPanel = var_5.Find(var_6_21, "ShowPanel")

	local var_6_22 = arg_6_0.showPanel

	arg_6_0.showBG = var_5.Find(var_6_22, "BG")

	local var_6_23 = arg_6_0.showPanel

	arg_6_0.nameText = var_5.Find(var_6_23, "NameText")

	local var_6_24 = arg_6_0.showPanel

	arg_6_0.progressText = var_5.Find(var_6_24, "Progress/ProgressText")

	local var_6_25 = arg_6_0.showPanel

	arg_6_0.tipText = var_5.Find(var_6_25, "Progress/Text")
	setText = var_5

	local var_6_26 = arg_6_0.tipText

	i18n = var_8

	var_5(var_6_26, var_8("tec_target_catchup_progress"))

	local var_6_27 = arg_6_0.showPanel

	arg_6_0.selectedImg = var_5.Find(var_6_27, "Selected")

	local var_6_28 = arg_6_0.showPanel

	arg_6_0.giveupBtn = var_5.Find(var_6_28, "GiveupBtn")

	local var_6_29 = arg_6_0.showPanel

	arg_6_0.finishedImg = var_5.Find(var_6_29, "Finished")

	local var_6_30 = arg_6_0._tf

	arg_6_0.helpBtn = var_5.Find(var_6_30, "HelpBtn")
	onButton = var_5

	local var_6_31 = arg_6_0
	local var_6_32 = arg_6_0.helpBtn

	local function var_6_33()
		pg = var_2_10000

		local var_12_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_12_1 = var_0.ShowMsgBox
		local var_12_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_12_2.type = var_2_10004
		pg = var_2_10004
		var_12_2.helps = var_2_10004.gametip.tec_target_catchup_help_tip.tip

		var_12_1(var_12_0, var_12_2)

		return
	end

	SFX_PANEL = var_10

	var_5(var_6_31, var_6_32, var_6_33, var_10)

	setText = var_5

	local var_6_34 = arg_6_0.choosePanel
	local var_6_35 = var_7.Find(var_6_34, "FinishAll/BG/Text")

	i18n = var_6_32

	var_5(var_6_35, var_6_32("tec_target_catchup_all_finish_tip"))

	setText = var_5

	local var_6_36 = arg_6_0.choosePanel
	local var_6_37 = var_7.Find(var_6_36, "CharListBG/SSRTag/Text")

	i18n = var_8

	var_5(var_6_37, var_8("tec_target_catchup_pry_char"))

	if #arg_6_0.urList > 0 then
		setText = var_5

		local var_6_38 = arg_6_0.choosePanel
		local var_6_39 = var_7.Find(var_6_38, "FinishPart/BG/Text")

		i18n = var_8

		var_5(var_6_39, var_8("tec_target_catchup_dr_finish_tip"))

		setText = var_5

		local var_6_40 = arg_6_0.choosePanel
		local var_6_41 = var_7.Find(var_6_40, "CharListBG/URTag/Text")

		i18n = var_8

		var_5(var_6_41, var_8("tec_target_catchup_dr_char"))
	end

	ipairs = var_5

	for iter_6_0, iter_6_1 in var_5(arg_6_0.urList) do
		setText = var_10

		local var_6_42 = arg_6_0.choosePanel
		local var_6_43 = var_12.Find(var_6_42, "Finish_" .. iter_6_1 .. "/BG/Text")

		i18n = var_1_10013

		var_10(var_6_43, var_1_10013("tec_target_catchup_dr_finish_tip"))
	end

	return
end

function var_0_1.updateTargetCatchupPage(arg_13_0)
	local var_13_0 = arg_13_0.technologyProxy

	arg_13_0.state = var_1.getCatchupState(var_13_0, arg_13_0.tecID)

	local var_13_1 = arg_13_0.state

	TechnologyCatchup = var_1_10002

	if var_13_1 == var_1_10002.STATE_CATCHUPING then
		arg_13_0:updateShowPanel()
	else
		arg_13_0:updateChoosePanel()
	end

	return
end

function var_0_1.updateCharTpl(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0

	var_14_0, setText = arg_14_2:Find("PrintNum/Text"), var_1_10004
	i18n = var_1_10007

	var_1_10004(var_14_0, var_1_10007("tec_target_need_print"))

	local var_14_1 = arg_14_2:Find("PrintNum/NumText")
	local var_14_2 = arg_14_2:Find("NameText")
	local var_14_3 = arg_14_2:Find("LevelText")
	local var_14_4 = arg_14_2:Find("NotGetTag")
	local var_14_5 = arg_14_0.charIDList[arg_14_1]
	local var_14_6 = arg_14_0.bayProxy
	local var_14_7 = var_9.findShipByGroup(var_14_6, var_14_5)
	local var_14_8 = arg_14_0.technologyProxy
	local var_14_9 = var_10.getBluePrintVOByGroupID(var_14_8, var_14_5)

	pg = var_14_6

	local var_14_10 = var_14_6.ship_data_blueprint[var_14_5].strengthen_item

	if var_14_7 then
		math = var_14_8

		local var_14_11 = var_14_8.floor
		local var_14_12 = arg_14_0:getShipBluePrintCurExp(var_14_9)

		Item = var_1_10015

		local var_14_13

		if not var_14_11(var_14_12 / var_1_10015.getConfigData(var_14_10).usage_arg[1]) then
			var_14_13 = 0
		end

		local var_14_14 = arg_14_0.configCatchup[arg_14_0.tecID].blueprint_max[arg_14_1]
		local var_14_15 = arg_14_0.bagProxy
		local var_14_16 = var_14.getItemCountById(var_14_15, var_14_10)

		math = var_1_10015

		local var_14_17 = var_1_10015.max(var_14_14 - var_14_13 - var_14_16, 0)

		setText = var_14_15

		var_14_15(var_14_1, var_14_17)

		ShipGroup = var_14_15

		local var_14_18 = var_14_15.getDefaultShipNameByGroupID(var_14_5)

		setText = var_17

		var_17(var_14_2, var_14_18)

		setActive = var_17

		var_17(var_14_3, var_14_7)

		setActive = var_17

		var_17(var_14_4, not var_14_7)

		if var_14_7 then
			local var_14_19 = arg_14_0.technologyProxy
			local var_14_20 = var_17.getBluePrintVOByGroupID(var_14_19, var_14_5)

			setText = var_18

			var_18(var_14_3, "Lv. " .. var_14_20.level .. "/" .. var_14_20:getMaxLevel())
		end

		return
	end
end

function var_0_1.updateShowPanel(arg_15_0)
	setActive = var_1_10001

	var_1_10001(arg_15_0.showPanel, true)

	setActive = var_1_10001

	var_1_10001(arg_15_0.choosePanel, false)

	local var_15_0 = arg_15_0.technologyProxy
	local var_15_1 = var_1.getCurCatchupTecInfo(var_15_0).tecID
	local var_15_2 = var_1.groupID
	local var_15_3 = var_1.printNum

	setImageSprite = var_1_10005

	local var_15_4 = arg_15_0.showBG

	LoadSprite = var_1_10008

	var_1_10005(var_15_4, var_1_10008("TecCatchup/selbg" .. var_15_2, var_15_2))

	ShipGroup = var_1_10005

	local var_15_5 = var_1_10005.getDefaultShipNameByGroupID(var_15_2)

	setText = var_1_10006

	var_1_10006(arg_15_0.nameText, var_15_5)

	setText = var_1_10006

	var_1_10006(arg_15_0.progressText, var_15_3 .. "/" .. arg_15_0:getMaxNum(var_15_2))

	local var_15_6 = arg_15_0.state

	TechnologyCatchup = var_7

	local var_15_7 = var_15_6 == var_7.STATE_FINISHED_ALL

	setActive = var_7

	var_7(arg_15_0.finishedImg, var_15_7)

	setActive = var_7

	var_7(arg_15_0.selectedImg, not var_15_7)

	onButton = var_7

	local var_15_8 = arg_15_0
	local var_15_9 = arg_15_0.selectedImg

	local function var_15_10()
		local var_16_0 = arg_15_0

		var_0.updateChoosePanel(var_16_0)

		setActive = var_0

		local var_16_1 = arg_15_0.choosePanel

		var_0(var_2.Find(var_16_1, "ProgressTitle"), false)

		return
	end

	SFX_PANEL = var_1_10012

	var_7(var_15_8, var_15_9, var_15_10, var_1_10012)

	return
end

function var_0_1.updateChoosePanel(arg_17_0)
	setActive = var_1_10001

	var_1_10001(arg_17_0.showPanel, false)

	setActive = var_1_10001

	var_1_10001(arg_17_0.choosePanel, true)

	local var_17_0 = arg_17_0.technologyProxy
	local var_17_1 = var_1.getCatchupData(var_17_0, arg_17_0.tecID)
	local var_17_2 = arg_17_0.state

	TechnologyCatchup = var_17_0

	if var_17_2 == var_17_0.STATE_FINISHED_ALL then
		setActive = var_3

		local var_17_3 = arg_17_0.choosePanel

		var_3(var_5.Find(var_17_3, "FinishAll"), true)

		setActive = var_3

		local var_17_4 = arg_17_0.choosePanel

		var_3(var_5.Find(var_17_4, "ProgressTitle"), false)
	else
		local var_17_5 = #arg_17_0.urList

		if 0 < var_17_5 then
			setActive = var_17_5

			local var_17_6 = arg_17_0.choosePanel

			var_17_5(var_5.Find(var_17_6, "FinishAll"), false)

			local var_17_7 = var_17_1:isFinishSSR()

			setActive = var_4

			local var_17_8 = arg_17_0.choosePanel

			var_4(var_6.Find(var_17_8, "FinishPart"), var_17_7)

			ipairs = var_4

			for iter_17_0, iter_17_1 in var_4(arg_17_0.urList) do
				local var_17_9 = var_17_1:isFinish(iter_17_1)

				setActive = var_1_10010

				local var_17_10 = arg_17_0.choosePanel

				var_1_10010(var_12.Find(var_17_10, "Finish_" .. iter_17_1), var_17_9)
			end
		end
	end

	return
end

function var_0_1.updateProgress(arg_18_0, arg_18_1)
	setActive = var_1_10002

	local var_18_0 = arg_18_0.choosePanel

	var_1_10002(var_4.Find(var_18_0, "ProgressTitle"), true)

	local var_18_1 = arg_18_0.technologyProxy
	local var_18_2 = var_2.getCatchupData(var_18_1, arg_18_0.tecID)
	local var_18_3 = var_2.getTargetNum(var_18_2, arg_18_1)
	local var_18_4 = arg_18_0:getMaxNum(arg_18_1)

	if arg_18_0:isUR(arg_18_1) then
		setActive = var_5

		var_5(arg_18_0.urProgress, true)

		setActive = var_5

		var_5(arg_18_0.ssrProgress, false)

		setText = var_5

		local var_18_5 = arg_18_0.urProgress

		var_5(var_7.Find(var_18_5, "Text"), var_18_3 .. "/" .. var_18_4)
	else
		setActive = var_5

		var_5(arg_18_0.urProgress, false)

		setActive = var_5

		var_5(arg_18_0.ssrProgress, true)

		setText = var_5

		local var_18_6 = arg_18_0.ssrProgress

		var_5(var_7.Find(var_18_6, "Text"), var_18_3 .. "/" .. var_18_4)
	end

	return
end

function var_0_1.isUR(arg_19_0, arg_19_1)
	ipairs = var_1_10002

	for iter_19_0, iter_19_1 in var_1_10002(arg_19_0.urList) do
		if arg_19_1 == iter_19_1 then
			return true
		end
	end

	return false
end

function var_0_1.getMaxNum(arg_20_0, arg_20_1)
	if arg_20_0:isUR(arg_20_1) then
		pg = var_20_0

		local var_20_0

		if not var_20_0.technology_catchup_template[arg_20_0.tecID].obtain_max_per_ur then
			pg = var_20_0
			var_20_0 = var_20_0.technology_catchup_template[arg_20_0.tecID].obtain_max
		end

		return var_20_0
	end
end

function var_0_1.willExit(arg_21_0)
	PoolMgr = var_1_10001

	local var_21_0 = var_1_10001.GetInstance()

	var_1.ReturnUI(var_21_0, arg_21_0:getUIName(), arg_21_0._go)

	return
end

function var_0_1.getShipBluePrintCurExp(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1.level
	local var_22_1 = arg_22_1.fateLevel
	local var_22_2 = arg_22_1.exp
	local var_22_3 = arg_22_1:getConfig("strengthen_effect")
	local var_22_4 = arg_22_1:getConfig("fate_strengthen")
	local var_22_5 = 0 + var_22_2

	for iter_22_0 = 1, var_22_0 do
		pg = var_1_10012
		var_22_5 = var_22_5 + var_1_10012.ship_strengthen_blueprint[var_22_3[iter_22_0]].need_exp
	end

	for iter_22_1 = 1, var_22_1 do
		pg = var_1_10012
		var_22_5 = var_22_5 + var_1_10012.ship_strengthen_blueprint[var_22_4[iter_22_1]].need_exp
	end

	return var_22_5
end

return var_0_1
