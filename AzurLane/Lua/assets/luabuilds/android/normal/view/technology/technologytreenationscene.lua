class = var_0_10000

local var_0_0 = "TechnologyTreeNationScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "TechnologyTreeCampUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:addListener()
	arg_3_0:updateTecItemList()
	arg_3_0:updateOneStepBtn()

	local var_3_0 = arg_3_0.nationProxy

	var_1.setRedPointIgnoreTecCampUpgrade(var_3_0)

	return
end

function var_0_1.willExit(arg_4_0)
	pairs = var_1_10001

	for iter_4_0, iter_4_1 in var_1_10001(arg_4_0.timerList) do
		iter_4_1:Stop()
	end

	local var_4_0 = arg_4_0.nationProxy

	var_1.refreshRedPoint(var_4_0)

	return
end

function var_0_1.initData(arg_5_0)
	getProxy = var_1_10001
	TechnologyNationProxy = var_1_10002
	arg_5_0.nationProxy = var_1_10001(var_1_10002)

	local var_5_0 = arg_5_0.nationProxy

	arg_5_0.nationToPoint = var_1.getNationPointList(var_5_0)

	local var_5_1 = arg_5_0.nationProxy

	arg_5_0.tecList = var_1.GetTecList(var_5_1)
	arg_5_0.panelList = {}
	arg_5_0.timerList = {}

	return
end

function var_0_1.calculateCurBuff(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0

	if arg_6_1 == 0 then
		return {}, {}, {}
	else
		pg = var_1_10004
		var_6_0 = var_1_10004.fleet_tech_group[arg_6_2].techs[arg_6_1]
	end

	pg = var_1_10004

	local var_6_1 = var_1_10004.fleet_tech_template[var_6_0].add
	local var_6_2 = {}
	local var_6_3 = {}

	ipairs = var_1_10007

	for iter_6_0, iter_6_1 in var_1_10007(var_6_1) do
		local var_6_4 = iter_6_1[2]
		local var_6_5 = iter_6_1[3]

		var_1_10014 = iter_6_1[1]
		ipairs = var_1_10015

		for iter_6_2, iter_6_3 in var_1_10015(var_1_10014) do
			if var_6_2[iter_6_3] then
				table = var_20

				var_20.insert(var_6_2[iter_6_3], {
					attr = var_6_4,
					value = var_6_5
				})
			else
				var_6_2[iter_6_3] = {
					{
						attr = var_6_4,
						value = var_6_5
					}
				}
				var_6_3[#var_6_3 + 1] = iter_6_3
			end
		end
	end

	local var_6_6 = {}
	local var_6_7 = {}

	pairs = var_9

	for iter_6_4, iter_6_5 in var_9(var_6_2) do
		if not var_6_6[iter_6_4] then
			var_6_6[iter_6_4] = {}
			var_6_7[iter_6_4] = {}
		end

		ipairs = var_1_10014

		for iter_6_6, iter_6_7 in var_1_10014(iter_6_5) do
			local var_6_8 = iter_6_7.attr
			local var_6_9 = iter_6_7.value

			if not var_6_6[iter_6_4][var_6_8] then
				var_6_6[iter_6_4][var_6_8] = var_6_9
				var_6_7[iter_6_4][#var_6_7[iter_6_4] + 1] = var_6_8
			else
				var_6_6[iter_6_4][var_6_8] = var_6_6[iter_6_4][var_6_8] + var_6_9
			end
		end
	end

	table = var_9

	var_9.sort(var_6_3, function(arg_7_0, arg_7_1)
		return arg_7_0 < arg_7_1
	end)

	pairs = var_9

	for iter_6_8, iter_6_9 in var_9(var_6_7) do
		table = var_1_10014

		var_1_10014.sort(iter_6_9, function(arg_8_0, arg_8_1)
			return arg_8_0 < arg_8_1
		end)
	end

	return var_6_3, var_6_7, var_6_6
end

function var_0_1.findUI(arg_9_0)
	local var_9_0 = arg_9_0._tf

	arg_9_0.scrollRect = var_1.Find(var_9_0, "Scroll View")

	local var_9_1 = arg_9_0._tf

	arg_9_0.tecItemContainer = var_1.Find(var_9_1, "Scroll View/Viewport/Content")
	GetComponent = var_1
	arg_9_0.scrollRectCom = var_1(arg_9_0.scrollRect, "ScrollRect")

	local var_9_2 = arg_9_0._tf

	arg_9_0.tecItemTpl = var_1.Find(var_9_2, "CampTecItem")

	local var_9_3 = arg_9_0._tf

	arg_9_0.typeItemTpl = var_1.Find(var_9_3, "TypeItem")

	local var_9_4 = arg_9_0._tf

	arg_9_0.buffItemTpl = var_1.Find(var_9_4, "BuffItem")
	arg_9_0.tecItemTplOriginWidth = arg_9_0.tecItemTpl.rect.width

	local var_9_5 = arg_9_0._tf

	arg_9_0.oneStepBtn = var_1.Find(var_9_5, "OneStepBtn")
	LOCK_TEC_NATION_AWARD = var_9_8

	local var_9_8

	if not var_9_8 then
		local var_9_6 = arg_9_0._tf

		arg_9_0.awardTpl = var_9_8.Find(var_9_6, "IconTpl").gameObject
		setActive = var_9_8

		var_9_8(arg_9_0.awardTpl, false)

		local var_9_7 = arg_9_0.awardTpl

		var_9_8 = var_9_8.AddComponent
		typeof = var_3
		LayoutElement = var_1_10004
		var_9_8 = var_9_8(var_9_7, var_3(var_1_10004))
		var_9_8.preferredWidth = 204
		var_9_8.preferredHeight = 206

		local var_9_9 = arg_9_0._tf
		local var_9_10

		var_9_10, setText = var_2.Find(var_9_9, "CampTecItem/AwardPanel/FinishBtn/Text"), var_9_9
		i18n = var_1_10005

		var_9_9(var_9_10, var_1_10005("tec_nation_award_finish"))
	else
		setActive = var_9_8

		var_9_8(arg_9_0.oneStepBtn, false)
	end

	return
end

function var_0_1.onBackPressed(arg_10_0)
	arg_10_0:emit(var_0_1.ON_BACK)

	return
end

function var_0_1.closeMyself(arg_11_0)
	arg_11_0:emit(var_0_1.ON_CLOSE)

	return
end

function var_0_1.addListener(arg_12_0)
	onButton = var_1_10001

	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_0.oneStepBtn

	local function var_12_2()
		pg = var_2_10000

		local var_13_0 = var_2_10000.m02
		local var_13_1 = var_0.sendNotification

		GAME = var_2_10002

		var_13_1(var_13_0, var_2_10002.GET_CAMP_TEC_AWARD_ONESTEP)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_12_0, var_12_1, var_12_2, var_1_10005)

	return
end

function var_0_1.updateTecItemList(arg_14_0)
	UIItemList = var_1_10001

	local var_14_0 = var_1_10001.New(arg_14_0.tecItemContainer, arg_14_0.tecItemTpl)

	var_1.make(var_14_0, function(arg_15_0, arg_15_1, arg_15_2)
		UIItemList = var_2_10003

		if arg_15_0 == var_2_10003.EventUpdate then
			local var_15_0 = arg_15_1 + 1

			arg_14_0.panelList[var_15_0] = arg_15_2

			local var_15_1 = arg_14_0

			var_4.updateTecItem(var_15_1, var_15_0)
		end

		return
	end)

	local var_14_1 = var_1
	local var_14_2 = var_1.align

	pg = var_4

	var_14_2(var_14_1, #var_4.fleet_tech_group.all)
	arg_14_0:updateAllTecItemRp()

	return
end

function var_0_1.updateAllTecItemRp(arg_16_0)
	getProxy = var_1_10001
	TechnologyNationProxy = var_1_10002

	local var_16_0 = var_1_10001(var_1_10002)
	local var_16_1 = not var_1.getAnyTecCampStudying(var_16_0)

	pairs = var_16_0

	for iter_16_0, iter_16_1 in var_16_0(arg_16_0.panelList) do
		local var_16_2 = iter_16_1:Find("BaseInfo")
		local var_16_3 = var_7.Find(var_16_2, "UpLevelBG")
		local var_16_4 = var_8.Find(var_16_3, "UpLevelBtn")
		local var_16_5 = var_9.Find(var_16_4, "RedPoint")

		pg = var_16_4

		local var_16_6 = var_16_4.fleet_tech_group[iter_16_0].nation[1]
		local var_16_7
		local var_16_8

		if not arg_16_0.tecList[iter_16_0] then
			var_16_7 = 0
		else
			table = var_14

			local var_16_9 = var_14.indexof

			pg = var_1_10015
			var_16_7 = var_16_9(var_1_10015.fleet_tech_group[iter_16_0].techs, arg_16_0.tecList[iter_16_0].completeID, 1) or 0
		end

		local var_16_10 = arg_16_0.nationToPoint[var_16_6]

		var_1_10015 = nil

		if var_16_7 == 0 then
			pg = var_1_10016

			local var_16_11 = var_1_10016.fleet_tech_group[iter_16_0].techs[1]

			pg = var_1_10016
			var_1_10015 = var_1_10016.fleet_tech_template[var_16_11].pt
		else
			pg = var_1_10016

			if var_16_7 == #var_1_10016.fleet_tech_group[iter_16_0].techs then
				pg = var_1_10016

				local var_16_12 = var_1_10016.fleet_tech_group[iter_16_0].techs[var_16_7]

				pg = var_1_10016
				var_1_10015 = var_1_10016.fleet_tech_template[var_16_12].pt
			else
				pg = var_1_10016

				local var_16_13 = var_1_10016.fleet_tech_group[iter_16_0].techs[var_16_7 + 1]

				pg = var_1_10016
				var_1_10015 = var_1_10016.fleet_tech_template[var_16_13].pt
			end
		end

		var_1_10016 = var_1_10015 <= var_16_10
		pg = var_1_10017
		var_1_10017 = var_16_7 == #var_1_10017.fleet_tech_group[iter_16_0].techs

		local var_16_14 = var_1_10016 and not var_1_10017

		setActive = var_1_10019

		var_1_10019(var_16_5, var_16_14 and var_16_1)
	end

	return
end

function var_0_1.updateTecItem(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.panelList[arg_17_1]
	local var_17_1 = var_2.Find(var_17_0, "AwardPanel")

	arg_17_0:updateTecLevelAward(var_17_1, arg_17_1)

	local var_17_2 = var_2:Find("BaseInfo")
	local var_17_3 = var_4.Find(var_17_2, "BG/Title/Text")
	local var_17_4 = var_4:Find("BG/UpLevelColor")
	local var_17_5 = var_4:Find("NationBG")
	local var_17_6 = var_4:Find("Code")
	local var_17_7 = var_8.Find(var_17_6, "NationTextImg")
	local var_17_8 = var_4:Find("UpLevelBG")
	local var_17_9 = var_10.Find(var_17_8, "UpLevelBtn")
	local var_17_10 = var_10:Find("FinishBtn")
	local var_17_11 = var_4:Find("Uping")
	local var_17_12 = var_13.Find(var_17_11, "Text")
	local var_17_13 = var_4:Find("EnglishTextImg")
	local var_17_14 = var_4:Find("ProgressBarBG/Progress")
	local var_17_15 = var_4:Find("CampLogo")
	local var_17_16 = var_4:Find("LevelText/Text")
	local var_17_17 = var_4
	local var_17_18 = var_4.Find(var_17_17, "PointTextBar")

	pg = var_17_17

	local var_17_19 = var_17_17.fleet_tech_group[arg_17_1].name

	pg = var_21

	local var_17_20 = var_21.fleet_tech_group[arg_17_1].nation[1]

	setImageSprite = var_1_10022

	local var_17_21 = var_17_5

	GetSpriteFromAtlas = var_1_10024

	var_1_10022(var_17_21, var_1_10024("TecNation", "camptec_nation_bar_" .. var_17_20))

	setImageSprite = var_1_10022

	local var_17_22 = var_17_7

	GetSpriteFromAtlas = var_24

	var_1_10022(var_17_22, var_24("TecNation", "camptec_nation_text_" .. var_17_20), true)

	setImageSprite = var_1_10022

	local var_17_23 = var_17_13

	GetSpriteFromAtlas = var_24

	var_1_10022(var_17_23, var_24("TecNation", "camp_tec_english_" .. var_17_20), true)

	setImageSprite = var_1_10022

	local var_17_24 = var_17_15

	GetSpriteFromAtlas = var_24

	var_1_10022(var_17_24, var_24("TecNation", "camptec_logo_" .. var_17_20))

	setText = var_1_10022

	var_1_10022(var_17_3, var_17_19)

	local var_17_25
	local var_17_26

	if not arg_17_0.tecList[arg_17_1] then
		var_17_25 = 0
	else
		table = var_24

		local var_17_27 = var_24.indexof

		pg = var_25
		var_17_25 = var_17_27(var_25.fleet_tech_group[arg_17_1].techs, arg_17_0.tecList[arg_17_1].completeID, 1) or 0
	end

	local var_17_28 = arg_17_0.nationToPoint[var_17_20]
	local var_17_29

	if var_17_25 == 0 then
		pg = var_26
		var_17_26 = var_26.fleet_tech_group[arg_17_1].techs[1]
		pg = var_26
		var_17_29 = var_26.fleet_tech_template[var_17_26].pt
	else
		pg = var_26

		if var_17_25 == #var_26.fleet_tech_group[arg_17_1].techs then
			pg = var_26
			var_17_26 = var_26.fleet_tech_group[arg_17_1].techs[var_17_25]
			pg = var_26
			var_17_29 = var_26.fleet_tech_template[var_17_26].pt
		else
			pg = var_26
			var_17_26 = var_26.fleet_tech_group[arg_17_1].techs[var_17_25 + 1]
			pg = var_26
			var_17_29 = var_26.fleet_tech_template[var_17_26].pt
		end
	end

	BaseUI = var_26

	var_26:setImageAmount(var_17_14, 0.1 + 0.8 * var_17_28 / var_17_29)

	setText = var_26

	var_26(var_17_16, var_17_25)

	setText = var_26

	var_26(var_17_18, var_17_28 .. "/" .. var_17_29)

	local function var_17_30(arg_18_0, arg_18_1, arg_18_2)
		setActive = var_2_10003

		var_2_10003(var_0, arg_18_0)

		setActive = var_2_10003

		var_2_10003(var_0, arg_18_1)

		setActive = var_2_10003

		var_2_10003(var_17_4, arg_18_1)

		setActive = var_2_10003

		var_2_10003(var_17_9, arg_18_1)

		setActive = var_2_10003

		var_2_10003(var_0, arg_18_2)

		return
	end

	local var_17_33

	if not arg_17_0.tecList[arg_17_1] then
		if var_17_29 <= var_17_28 then
			var_17_30(false, true, false)
		else
			var_17_30(true, false, false)
		end
	else
		pg = var_17_33

		if var_17_25 == #var_17_33.fleet_tech_group[arg_17_1].techs then
			var_17_30(true, false, false)
		elseif arg_17_0.tecList[arg_17_1].studyID ~= 0 then
			var_17_30(false, false, true)

			if arg_17_0.timerList[arg_17_1] then
				local var_17_31 = arg_17_0.timerList[arg_17_1]

				var_17_33.Stop(var_17_31)
			end

			local var_17_32 = arg_17_0.nationProxy

			var_17_33 = var_17_33.getLeftTime(var_17_32)
			setText = var_17_32

			local var_17_34 = var_17_12

			pg = var_30
			var_1_10031 = var_30.TimeMgr.GetInstance()

			var_17_32(var_17_34, var_30.DescCDTime(var_1_10031, var_17_33))

			local var_17_35 = arg_17_0.timerList

			Timer = var_17_34
			var_17_35[arg_17_1] = var_17_34.New(function()
				var_17_33 = var_17_33 - 1
				setText = var_0

				local var_19_0 = var_17_12

				pg = var_2_10002

				local var_19_1 = var_2_10002.TimeMgr.GetInstance()

				var_0(var_19_0, var_2.DescCDTime(var_19_1, var_17_33))

				if var_17_33 == 0 then
					local var_19_2 = arg_17_0.timerList[arg_17_1]

					var_0.Stop(var_19_2)
				end

				return
			end, 1, -1)

			local var_17_36 = arg_17_0.timerList[arg_17_1]

			var_28.Start(var_17_36)
		elseif var_17_29 <= var_17_28 then
			var_17_30(false, true, false)
		else
			var_17_30(true, false, false)
		end
	end

	onButton = var_17_33

	local var_17_37 = arg_17_0
	local var_17_38 = var_17_9

	local function var_17_39()
		local var_20_0 = arg_17_0
		local var_20_1 = var_0.emit

		TechnologyConst = var_2_10002

		var_20_1(var_20_0, var_2_10002.CLICK_UP_TEC_BTN, arg_17_1, var_17_26)

		return
	end

	SFX_PANEL = var_1_10031

	var_17_33(var_17_37, var_17_38, var_17_39, var_1_10031)

	local var_17_40 = var_2
	local var_17_41 = var_2.Find(var_17_40, "Mask/DetailPanel")

	GetComponent = var_17_40

	local var_17_42 = var_17_40(var_2, "LayoutElement")
	local var_17_43 = var_17_41:Find("Toggle")

	arg_17_0:updateDetailPanel(var_17_41, var_17_25, arg_17_1, var_17_20, false)

	onToggle = var_30

	var_30(arg_17_0, var_4:Find("BG"), function(arg_21_0)
		if arg_21_0 then
			triggerToggle = var_2_10001

			var_2_10001(var_17_43, false)

			LeanTween = var_2_10001
			var_2_10001 = var_2_10001.value
			go = var_2_10002
			var_2_10002 = var_2_10001(var_2_10002(var_0), arg_17_0.tecItemTplOriginWidth, arg_17_0.tecItemTplOriginWidth + var_17_41.rect.width, 0.25)
			var_2_10001 = var_2_10001.setOnUpdate
			System = var_3
			var_2_10002 = var_2_10001(var_2_10002, var_3.Action_float(function(arg_22_0)
				var_17_42.preferredWidth = arg_22_0

				local var_22_0 = arg_17_1

				pg = var_3_10002

				if var_22_0 == #var_3_10002.fleet_tech_group.all then
					arg_17_0.scrollRectCom.horizontalNormalizedPosition = 1
				end

				return
			end))
			var_2_10001 = var_2_10001.setOnComplete
			System = var_3

			var_2_10001(var_2_10002, var_3.Action(function()
				local var_23_0 = arg_17_1

				pg = var_3_10001

				if var_23_0 == #var_3_10001.fleet_tech_group.all then
					arg_17_0.scrollRectCom.horizontalNormalizedPosition = 1
				end

				return
			end))
		else
			LeanTween = var_2_10001

			local var_21_0 = var_2_10001.cancel

			go = var_2_10002

			var_21_0(var_2_10002(var_0))

			local var_21_1 = var_17_42.preferredWidth

			LeanTween = var_2

			local var_21_2 = var_2.value

			go = var_3

			local var_21_3 = var_21_2(var_3(var_0), var_21_1, arg_17_0.tecItemTplOriginWidth, 0.25)
			local var_21_4 = var_2.setOnUpdate

			System = var_4

			var_21_4(var_21_3, var_4.Action_float(function(arg_24_0)
				var_17_42.preferredWidth = arg_24_0

				return
			end))
		end

		return
	end)

	return
end

function var_0_1.updateDetailPanel(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4, arg_25_5)
	local var_25_0 = arg_25_1:Find("TypeItemContainer")
	local var_25_1 = arg_25_1
	local var_25_2

	var_25_2, setImageSprite = arg_25_1.Find(var_25_1, "BG/Logo"), var_25_1
	GetSpriteFromAtlas = var_1_10010

	var_25_1(var_25_2, var_1_10010("TecNation", "camptec_logo_" .. arg_25_4))

	local var_25_3 = arg_25_1
	local var_25_4 = arg_25_1.Find(var_25_3, "Toggle")

	pg = var_25_3

	if arg_25_2 == #var_25_3.fleet_tech_group[arg_25_3].techs and arg_25_5 == false then
		setActive = var_9

		var_9(var_25_4, false)
	end

	local function var_25_5(arg_26_0, arg_26_1, arg_26_2)
		UIItemList = var_2_10003

		local var_26_0 = var_2_10003.New(var_25_0, arg_25_0.typeItemTpl)
		local var_26_1

		if arg_26_0 == 0 then
			var_26_0:align(0)

			return
		else
			pg = var_5
			var_26_1 = var_5.fleet_tech_group[arg_26_1].techs[arg_26_0]
		end

		local var_26_2
		local var_26_3
		local var_26_4

		Color = var_2_10008

		local var_26_5 = var_2_10008.New(1, 0.9333333333333333, 0.19215686274509805)
		local var_26_7

		if arg_26_2 then
			local var_26_6 = arg_25_0
			local var_26_8, var_26_9

			var_26_7, var_26_8, var_26_9 = var_26_7.calculateCurBuff(var_26_6, arg_26_0 - 1, arg_26_1)
			var_26_4 = var_26_9
			var_26_3 = var_26_8
			var_26_2 = var_26_7
		end

		pg = var_26_7

		local var_26_10 = var_26_7.fleet_tech_template[var_26_1].add
		local var_26_11 = {}
		local var_26_12 = {}

		ipairs = var_2_10012

		for iter_26_0, iter_26_1 in var_2_10012(var_26_10) do
			local var_26_13 = iter_26_1[2]
			local var_26_14 = iter_26_1[3]

			ShipType = var_2_10019
			var_2_10019 = var_2_10019.FilterOverQuZhuType(iter_26_1[1])
			ipairs = var_20

			for iter_26_2, iter_26_3 in var_20(var_2_10019) do
				local var_26_15

				if arg_26_2 then
					table = var_2_10026

					if not var_2_10026.indexof(var_26_2, iter_26_3, 1) then
						var_26_15 = {
							attr = var_26_13,
							value = var_26_14,
							attrColor = var_26_5,
							valueColor = var_26_5
						}
					else
						table = var_2_10026

						if not var_2_10026.indexof(var_26_3[iter_26_3], var_26_13, 1) then
							var_26_15 = {
								attr = var_26_13,
								value = var_26_14,
								attrColor = var_26_5,
								valueColor = var_26_5
							}
						elseif var_26_14 ~= var_26_4[iter_26_3][var_26_13] then
							var_26_15 = {
								attr = var_26_13,
								value = var_26_14,
								valueColor = var_26_5
							}
						else
							var_26_15 = {
								attr = var_26_13,
								value = var_26_14
							}
						end
					end
				else
					var_26_15 = {
						attr = var_26_13,
						value = var_26_14
					}
				end

				if var_26_11[iter_26_3] then
					table = var_2_10026

					var_2_10026.insert(var_26_11[iter_26_3], var_26_15)
				else
					var_26_11[iter_26_3] = {
						var_26_15
					}
					var_26_12[#var_26_12 + 1] = iter_26_3
				end
			end
		end

		var_26_0:make(function(arg_27_0, arg_27_1, arg_27_2)
			UIItemList = var_3_10003

			if arg_27_0 == var_3_10003.EventUpdate then
				local var_27_0 = arg_27_2:Find("TypeIcon")
				local var_27_1 = arg_27_2:Find("BuffItemContainer")
				local var_27_2 = var_26_12[arg_27_1 + 1]

				setImageSprite = var_6

				local var_27_3 = var_27_0

				GetSpriteFromAtlas = var_3_10008

				var_6(var_27_3, var_3_10008("ShipType", "buffitem_tec_" .. var_27_2))

				local var_27_4 = arg_25_0

				var_6.upBuffList(var_27_4, arg_27_2, var_26_11[var_27_2])
			end

			return
		end)
		var_26_0:align(#var_26_12)

		return
	end

	onToggle = var_10

	local var_25_6 = arg_25_0
	local var_25_7 = var_25_4

	local function var_25_8(arg_28_0)
		if arg_28_0 == true then
			var_25_5(arg_25_2 + 1, arg_25_3, true)
		else
			var_25_5(arg_25_2, arg_25_3)
		end

		return
	end

	SFX_PANEL = var_1_10014

	var_10(var_25_6, var_25_7, var_25_8, var_1_10014)

	if arg_25_5 == false then
		triggerToggle = var_10

		var_10(var_25_4, false)
	end

	return
end

function var_0_1.upBuffList(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_1
	local var_29_1 = arg_29_1.Find(var_29_0, "BuffItemContainer")

	UIItemList = var_29_0

	local var_29_2 = var_29_0.New(var_29_1, arg_29_0.buffItemTpl)

	var_4.make(var_29_2, function(arg_30_0, arg_30_1, arg_30_2)
		UIItemList = var_2_10003

		if arg_30_0 == var_2_10003.EventUpdate then
			local var_30_0 = arg_30_2:Find("AttrText")
			local var_30_1 = arg_30_2:Find("ValueText")
			local var_30_2 = arg_29_2[arg_30_1 + 1].attr
			local var_30_3 = arg_29_2[arg_30_1 + 1].value
			local var_30_4 = arg_29_2[arg_30_1 + 1].attrColor
			local var_30_5 = arg_29_2[arg_30_1 + 1].valueColor

			setText = var_9

			local var_30_6 = var_30_0

			AttributeType = var_2_10011

			local var_30_7 = var_2_10011.Type2Name

			pg = var_2_10012

			var_9(var_30_6, var_30_7(var_2_10012.attribute_info_by_type[var_30_2].name))

			setText = var_9

			var_9(var_30_1, "+" .. var_30_3)

			if var_30_4 then
				setTextColor = var_9

				var_9(var_30_0, var_30_4)
			else
				setTextColor = var_9

				local var_30_8 = var_30_0

				Color = var_11

				var_9(var_30_8, var_11.white)
			end

			if var_30_5 then
				setTextColor = var_9

				var_9(var_30_1, var_30_5)
			else
				setTextColor = var_9

				local var_30_9 = var_30_1

				Color = var_11

				var_9(var_30_9, var_11.green)
			end
		end

		return
	end)
	var_4:align(#arg_29_2)

	return
end

function var_0_1.updateTecLevelAward(arg_31_0, arg_31_1, arg_31_2)
	LOCK_TEC_NATION_AWARD = var_1_10003

	if var_1_10003 then
		setActive = var_1_10003

		var_1_10003(arg_31_1, false)

		return
	end

	local var_31_0 = arg_31_0._tf
	local var_31_1 = var_3.Find(var_31_0, "AwardItem")
	local var_31_2 = arg_31_1
	local var_31_3 = arg_31_1.Find(var_31_2, "ItemContainer")

	UIItemList = var_31_2

	local var_31_4 = var_31_2.New(var_31_3, arg_31_0.awardTpl)
	local var_31_5 = arg_31_1:Find("Level")
	local var_31_6 = arg_31_1:Find("Level/Num")
	local var_31_7 = arg_31_1:Find("GetBtn")
	local var_31_8 = arg_31_1:Find("DisGetBtn")
	local var_31_9 = arg_31_1:Find("FinishBtn")
	local var_31_10 = arg_31_0.nationProxy
	local var_31_11 = var_11.GetTecItemByGroupID(var_31_10, arg_31_2)

	pg = var_31_10

	local var_31_12 = var_31_10.fleet_tech_group[arg_31_2]
	local var_31_13

	if not var_31_11 or not var_31_11.rewardedID then
		var_31_13 = 0
	end

	local var_31_14

	if not var_31_11 or not var_31_11.completeID then
		var_31_14 = 0
	end

	table = var_1_10015

	local var_31_15

	if not var_1_10015.indexof(var_31_12.techs, var_31_13, 1) then
		var_31_15 = 0
	end

	table = var_16

	local var_31_16

	if not var_16.indexof(var_31_12.techs, var_31_14, 1) then
		var_31_16 = 0
	end

	local var_31_17 = var_31_15 + 1
	local var_31_18

	if var_31_15 < var_31_16 then
		var_31_18 = var_31_12.techs[var_31_17]
	elseif var_31_15 == var_31_16 and var_31_15 < #var_31_12.techs then
		var_31_18 = var_31_12.techs[var_31_17]
	end

	local var_31_19

	if var_31_18 then
		setActive = var_31_19

		var_31_19(var_31_5, true)

		setActive = var_31_19

		var_31_19(var_31_3, true)

		setActive = var_31_19

		var_31_19(var_31_7, var_31_15 < var_31_16)

		setActive = var_31_19

		var_31_19(var_31_8, var_31_15 == var_31_16)

		setActive = var_31_19

		var_31_19(var_31_9, false)

		setText = var_31_19

		var_31_19(var_31_6, var_31_17)

		pg = var_31_19
		var_31_19 = var_31_19.fleet_tech_template[var_31_18].level_award_display

		var_31_4:make(function(arg_32_0, arg_32_1, arg_32_2)
			UIItemList = var_2_10003

			if arg_32_0 == var_2_10003.EventUpdate then
				arg_32_1 = arg_32_1 + 1

				local var_32_0 = var_31_19[arg_32_1]
				local var_32_1 = {
					type = var_32_0[1],
					id = var_32_0[2],
					count = var_32_0[3]
				}

				updateDrop = var_5

				var_5(arg_32_2, var_32_1)
			end

			return
		end)
		var_31_4:align(#var_31_19)

		if var_31_15 < var_31_16 then
			onButton = var_20

			local var_31_20 = arg_31_0
			local var_31_21 = var_31_7

			local function var_31_22()
				pg = var_2_10000

				local var_33_0 = var_2_10000.m02
				local var_33_1 = var_0.sendNotification

				GAME = var_2_10002

				var_33_1(var_33_0, var_2_10002.GET_CAMP_TEC_AWARD, {
					groupID = arg_31_2,
					tecID = var_31_18
				})

				return
			end

			SFX_PANEL = var_1_10024

			var_20(var_31_20, var_31_21, var_31_22, var_1_10024)
		end
	else
		setActive = var_31_19

		var_31_19(var_31_5, false)

		setActive = var_31_19

		var_31_19(var_31_3, false)

		setActive = var_31_19

		var_31_19(var_31_7, false)

		setActive = var_31_19

		var_31_19(var_31_8, false)

		setActive = var_31_19

		var_31_19(var_31_9, true)
	end

	return
end

function var_0_1.updateOneStepBtn(arg_34_0)
	LOCK_TEC_NATION_AWARD = var_1_10001

	if var_1_10001 then
		setActive = var_1_10001

		var_1_10001(arg_34_0.oneStepBtn, false)

		return
	end

	setActive = var_1_10001

	local var_34_0 = arg_34_0.oneStepBtn
	local var_34_1 = arg_34_0.nationProxy

	var_1_10001(var_34_0, var_3.isAnyTecCampCanGetAward(var_34_1))

	return
end

function var_0_1.updateTecListData(arg_35_0)
	getProxy = var_1_10001
	TechnologyNationProxy = var_1_10002

	local var_35_0 = var_1_10001(var_1_10002)

	arg_35_0.tecList = var_1.GetTecList(var_35_0)

	return
end

return var_0_1
