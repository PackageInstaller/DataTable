class = var_0_10000

local var_0_0 = "MetaQuickTacticsLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "MetaQuickTacticsUI"
end

function var_0_1.getGroupName(arg_2_0)
	return "MetaCharacterScene"
end

function var_0_1.init(arg_3_0)
	arg_3_0:initUITextTips()
	arg_3_0:initData()
	arg_3_0:initUI()
	arg_3_0:addListener()
	arg_3_0:overlayPanel(true)

	return
end

function var_0_1.didEnter(arg_4_0)
	arg_4_0:initSkillInfoPanel()
	arg_4_0:initUIItemList()

	return
end

function var_0_1.willExit(arg_5_0)
	arg_5_0:overlayPanel(false)

	return
end

function var_0_1.onBackPressed(arg_6_0)
	arg_6_0:closeView()

	return
end

function var_0_1.initUITextTips(arg_7_0)
	local var_7_0 = arg_7_0._tf
	local var_7_1

	var_7_1, setText = var_1.Find(var_7_0, "Content/SkillInfo/UseTip"), var_1_10002
	i18n = var_1_10005

	var_1_10002(var_7_1, var_1_10005("metaskill_up"))

	return
end

function var_0_1.initData(arg_8_0)
	getProxy = var_1_10001
	MetaCharacterProxy = var_1_10003
	arg_8_0.metaProxy = var_1_10001(var_1_10003)
	getProxy = var_1
	BagProxy = var_1_10003
	arg_8_0.bagProxy = var_1(var_1_10003)
	getProxy = var_1
	BayProxy = var_1_10003
	arg_8_0.bayProxy = var_1(var_1_10003)
	arg_8_0.shipID = arg_8_0.contextData.shipID
	arg_8_0.skillID = arg_8_0.contextData.skillID
	pg = var_1

	local var_8_0 = var_1.item_data_statistics.get_id_list_by_type

	Item = var_1_10002
	arg_8_0.bookIDList = var_8_0[var_1_10002.METALESSON_TYPE]
	arg_8_0.useCountDict = {}
	arg_8_0.maxCountDict = {}
	arg_8_0.useCountTextDict = {}

	arg_8_0:resetUseData()

	local var_8_1 = {}

	ItemRarity = var_2
	var_8_1[var_2.Blue] = "#70D4FAFF"
	ItemRarity = var_2
	var_8_1[var_2.Purple] = "#C380FBFF"
	ItemRarity = var_2
	var_8_1[var_2.Gold] = "#FFCC4DFF"
	arg_8_0.colorDict = var_8_1
	arg_8_0.expDict = {}
	ipairs = var_1

	for iter_8_0, iter_8_1 in var_1(arg_8_0.bookIDList) do
		local var_8_2 = arg_8_0.expDict

		tonumber = var_1_10007
		Item = var_1_10009
		var_8_2[iter_8_1] = var_1_10007(var_1_10009.getConfigData(iter_8_1).usage_arg)
	end

	return
end

function var_0_1.initUI(arg_9_0)
	local var_9_0 = arg_9_0._tf

	arg_9_0.bg = var_1.Find(var_9_0, "BG")

	local var_9_1 = arg_9_0._tf

	arg_9_0.tpl = var_1.Find(var_9_1, "TacticsTpl")

	local var_9_2 = arg_9_0._tf
	local var_9_3 = var_1.Find(var_9_2, "Content")

	arg_9_0.closeBtn = var_1.Find(var_9_3, "Title/CloseBtn")

	local var_9_4 = var_1:Find("SkillInfo")
	local var_9_5 = var_2.Find(var_9_4, "Skill")

	arg_9_0.skillNameText = var_3.Find(var_9_5, "Name")
	arg_9_0.skillLevelText = var_3:Find("LevelNum")
	arg_9_0.skillLevelUpText = var_3:Find("LevelUp")

	local var_9_6 = var_2:Find("Exp")

	arg_9_0.curExpText = var_4.Find(var_9_6, "CurExp")
	arg_9_0.addExpText = var_4:Find("AddExp")
	arg_9_0.totalExpText = var_4:Find("TotalExp")
	arg_9_0.progressBar = var_2:Find("Slider")
	arg_9_0.containerTF = var_1:Find("Container")

	local var_9_7 = var_1:Find("Action")

	arg_9_0.clearBtn = var_5.Find(var_9_7, "ClearBtn")
	arg_9_0.onestepBtn = var_5:Find("OneStepBtn")
	arg_9_0.confirmBtn = var_5:Find("ConfirmBtn")

	return
end

function var_0_1.addListener(arg_10_0)
	local function var_10_0()
		local var_11_0 = arg_10_0

		var_0.closeView(var_11_0)

		return
	end

	onButton = var_1_10002

	local var_10_1 = arg_10_0
	local var_10_2 = arg_10_0.bg
	local var_10_3 = var_10_0

	SFX_PANEL = var_1_10007

	var_1_10002(var_10_1, var_10_2, var_10_3, var_1_10007)

	onButton = var_1_10002

	local var_10_4 = arg_10_0
	local var_10_5 = arg_10_0.closeBtn
	local var_10_6 = var_10_0

	SFX_PANEL = var_1_10007

	var_1_10002(var_10_4, var_10_5, var_10_6, var_1_10007)

	onButton = var_1_10002

	local var_10_7 = arg_10_0
	local var_10_8 = arg_10_0.clearBtn

	local function var_10_9()
		local var_12_0 = arg_10_0

		var_0.resetUseData(var_12_0)

		local var_12_1 = arg_10_0

		var_0.updateAfterModifyUseCount(var_12_1)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_10_7, var_10_8, var_10_9, var_1_10007)

	onButton = var_1_10002

	local var_10_10 = arg_10_0
	local var_10_11 = arg_10_0.onestepBtn

	local function var_10_12()
		local var_13_0 = arg_10_0

		var_0.oneStep(var_13_0)

		local var_13_1 = arg_10_0

		var_0.updateAfterModifyUseCount(var_13_1)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_10_10, var_10_11, var_10_12, var_1_10007)

	onButton = var_1_10002

	local var_10_13 = arg_10_0
	local var_10_14 = arg_10_0.confirmBtn

	local function var_10_15()
		local var_14_0 = 0

		ipairs = var_2_10001

		for iter_14_0, iter_14_1 in var_2_10001(arg_10_0.bookIDList) do
			var_14_0 = var_14_0 + arg_10_0.useCountDict[iter_14_1]
		end

		if var_14_0 <= 0 then
			pg = var_1

			local var_14_1 = var_1.TipsMgr.GetInstance()
			local var_14_2 = var_1.ShowTips

			i18n = iter_14_0

			var_14_2(var_14_1, iter_14_0("word_materal_no_enough"))
		else
			local var_14_3 = arg_10_0
			local var_14_4, var_14_5 = var_1.preCalcExpOverFlow(var_14_3, 0, 0)

			if var_14_4 then
				local var_14_6 = arg_10_0
				local var_14_7 = var_3.emit

				MetaQuickTacticsMediator = var_2_10006

				var_14_7(var_14_6, var_2_10006.OPEN_OVERFLOW_LAYER, arg_10_0.shipID, arg_10_0.skillID, arg_10_0.useCountDict, var_14_5)
			else
				local var_14_8 = arg_10_0
				local var_14_9 = var_3.emit

				MetaQuickTacticsMediator = var_2_10006

				var_14_9(var_14_8, var_2_10006.USE_TACTICS_BOOK, arg_10_0.shipID, arg_10_0.skillID, arg_10_0.useCountDict)
			end
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_10_13, var_10_14, var_10_15, var_1_10007)

	return
end

function var_0_1.overlayPanel(arg_15_0, arg_15_1)
	if arg_15_1 and arg_15_0._tf then
		arg_15_0:OverlayPanel(arg_15_0._tf)
	elseif arg_15_0._tf then
		arg_15_0:UnOverlayPanel(arg_15_0._tf)
	end

	return
end

function var_0_1.initSkillInfoPanel(arg_16_0)
	local var_16_0 = arg_16_0.skillID
	local var_16_1 = arg_16_0.bayProxy
	local var_16_2 = var_2.getShipById(var_16_1, arg_16_0.shipID)
	local var_16_3 = var_2.getMetaSkillLevelBySkillID(var_16_2, var_16_0)

	getSkillConfig = var_16_1

	local var_16_4 = var_16_1(var_16_0)

	getSkillName = var_16_2

	local var_16_5 = var_16_2(var_16_4.id)

	setText = var_6

	var_6(arg_16_0.skillNameText, var_16_5)

	setText = var_6

	var_6(arg_16_0.skillLevelText, "LEVEL:" .. var_16_3)

	setText = var_6

	var_6(arg_16_0.skillLevelUpText, "")

	local var_16_6 = arg_16_0.metaProxy
	local var_16_7 = var_6.getMetaTacticsInfoByShipID(var_16_6, arg_16_0.shipID)
	local var_16_8 = var_6.getSkillExp(var_16_7, var_16_0)

	MetaCharacterConst = var_16_6

	local var_16_9 = var_16_6.getMetaSkillTacticsConfig(var_16_0, var_16_3).need_exp

	setText = var_10

	var_10(arg_16_0.curExpText, var_16_8)

	setText = var_10

	var_10(arg_16_0.totalExpText, var_16_9)

	setText = var_10

	var_10(arg_16_0.addExpText, "[+0]")

	setSlider = var_10

	var_10(arg_16_0.progressBar, 0, var_16_9, var_16_8)

	return
end

function var_0_1.initUIItemList(arg_17_0)
	UIItemList = var_1_10001
	arg_17_0.uiitemList = var_1_10001.New(arg_17_0.containerTF, arg_17_0.tpl)

	local var_17_0 = arg_17_0.uiitemList

	var_1.make(var_17_0, function(arg_18_0, arg_18_1, arg_18_2)
		UIItemList = var_2_10003

		if arg_18_0 == var_2_10003.EventUpdate then
			arg_18_1 = arg_18_1 + 1

			local var_18_0 = arg_17_0

			var_3.updateTpl(var_18_0, arg_18_1, arg_18_2)
		end

		return
	end)

	local var_17_1 = arg_17_0.uiitemList

	var_1.align(var_17_1, #arg_17_0.bookIDList)

	return
end

function var_0_1.updateUIItemList(arg_19_0)
	local var_19_0 = arg_19_0.uiitemList

	var_1.align(var_19_0, #arg_19_0.bookIDList)

	return
end

function var_0_1.updateTpl(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_2:Find("IconTpl")
	local var_20_1 = arg_20_2:Find("Name")
	local var_20_2 = arg_20_2:Find("MinusTenBtn")
	local var_20_3 = arg_20_2:Find("AddTenBtn")
	local var_20_4 = arg_20_2:Find("MinusBtn")
	local var_20_5 = arg_20_2:Find("AddBtn")
	local var_20_6 = arg_20_2:Find("TextBG/UseNum")
	local var_20_7 = arg_20_0.bookIDList[arg_20_1]
	local var_20_8 = arg_20_0
	local var_20_9 = arg_20_0.getBookItem(var_20_8, var_20_7)
	local var_20_10 = arg_20_0.bagProxy
	local var_20_11

	if var_12.getItemCountById(var_20_10, var_20_7) == 0 then
		var_20_11 = "0"
	end

	Drop = var_20_8

	local var_20_12 = var_20_8.New
	local var_20_13 = {
		id = var_20_7
	}

	DROP_TYPE_ITEM = var_1_10016
	var_20_13.type = var_1_10016
	var_20_13.count = var_20_11

	local var_20_14 = var_20_12(var_20_13)

	updateDrop = var_20_10

	var_20_10(var_20_0, var_20_14)

	local var_20_15 = var_20_9
	local var_20_16 = var_20_9.getConfig(var_20_15, "name")
	local var_20_17 = var_20_9:getConfig("rarity")

	setColorStr = var_20_15

	local var_20_18 = var_20_15(var_20_16, arg_20_0.colorDict[var_20_17])

	setText = var_16

	var_16(var_20_1, var_20_18)

	local var_20_19 = arg_20_0.useCountTextDict

	var_20_19[var_20_7] = var_20_6
	onButton = var_20_19

	local var_20_20 = arg_20_0
	local var_20_21 = var_20_2

	local function var_20_22()
		local var_21_0 = arg_20_0

		var_0.tryModifyUseCount(var_21_0, var_20_7, -10)

		local var_21_1 = arg_20_0

		var_0.updateAfterModifyUseCount(var_21_1)

		return
	end

	SFX_PANEL = var_1_10021

	var_20_19(var_20_20, var_20_21, var_20_22, var_1_10021)

	onButton = var_20_19

	local var_20_23 = arg_20_0
	local var_20_24 = var_20_3

	local function var_20_25()
		local var_22_0 = arg_20_0

		if not var_0.isMaxLevel(var_22_0) then
			local var_22_1 = arg_20_0

			if not var_0.isCanUpMax(var_22_1) then
				local var_22_2 = arg_20_0

				var_0.tryModifyUseCount(var_22_2, var_20_7, 10)

				local var_22_3 = arg_20_0

				var_0.updateAfterModifyUseCount(var_22_3)
			end
		end

		return
	end

	SFX_PANEL = var_1_10021

	var_20_19(var_20_23, var_20_24, var_20_25, var_1_10021)

	onButton = var_20_19

	local var_20_26 = arg_20_0
	local var_20_27 = var_20_4

	local function var_20_28()
		local var_23_0 = arg_20_0

		var_0.tryModifyUseCount(var_23_0, var_20_7, -1)

		local var_23_1 = arg_20_0

		var_0.updateAfterModifyUseCount(var_23_1)

		return
	end

	SFX_PANEL = var_1_10021

	var_20_19(var_20_26, var_20_27, var_20_28, var_1_10021)

	onButton = var_20_19

	local var_20_29 = arg_20_0
	local var_20_30 = var_20_5

	local function var_20_31()
		local var_24_0 = arg_20_0

		if not var_0.isMaxLevel(var_24_0) then
			local var_24_1 = arg_20_0

			if not var_0.isCanUpMax(var_24_1) then
				local var_24_2 = arg_20_0

				var_0.tryModifyUseCount(var_24_2, var_20_7, 1)

				local var_24_3 = arg_20_0

				var_0.updateAfterModifyUseCount(var_24_3)
			end
		end

		return
	end

	SFX_PANEL = var_1_10021

	var_20_19(var_20_29, var_20_30, var_20_31, var_1_10021)

	return
end

function var_0_1.updateAfterModifyUseCount(arg_25_0)
	ipairs = var_1_10001

	for iter_25_0, iter_25_1 in var_1_10001(arg_25_0.bookIDList) do
		local var_25_0 = arg_25_0.useCountTextDict[iter_25_1]
		local var_25_1 = arg_25_0.useCountDict[iter_25_1]

		setText = var_1_10008

		var_1_10008(var_25_0, var_25_1)
	end

	local var_25_2 = arg_25_0.shipID
	local var_25_3 = arg_25_0.skillID
	local var_25_4 = arg_25_0.bayProxy
	local var_25_5 = var_3.getShipById(var_25_4, var_25_2)
	local var_25_6 = var_3.getMetaSkillLevelBySkillID(var_25_5, var_25_3)
	local var_25_7 = arg_25_0:calcAwardExp()
	local var_25_8 = arg_25_0:calcLevelWithAwardExp(var_25_7) - var_25_6

	if 0 < var_25_8 then
		setText = var_8

		var_8(arg_25_0.skillLevelUpText, "+" .. var_25_8)
	else
		setText = var_8

		var_8(arg_25_0.skillLevelUpText, "")
	end

	setText = var_8

	local var_25_9 = arg_25_0.addExpText

	string = var_1_10011

	var_8(var_25_9, var_1_10011.format("[+%d]", var_25_7))

	MetaCharacterConst = var_8

	if var_8.getMetaSkillTacticsConfig(var_25_3, var_25_6) then
		local var_25_10 = var_8.need_exp
		local var_25_11 = arg_25_0.metaProxy
		local var_25_12 = var_10.getMetaTacticsInfoByShipID(var_25_11, var_25_2)
		local var_25_13 = var_10.getSkillExp(var_25_12, var_25_3)

		setText = var_25_11

		var_25_11(arg_25_0.curExpText, var_25_13)

		setText = var_25_11

		var_25_11(arg_25_0.totalExpText, var_25_10)

		setSlider = var_25_11

		var_25_11(arg_25_0.progressBar, 0, var_25_10, var_25_13 + var_25_7)
	end

	return
end

function var_0_1.updateAfterUse(arg_26_0)
	local var_26_0 = arg_26_0.shipID
	local var_26_1 = arg_26_0.skillID
	local var_26_2 = arg_26_0.bayProxy
	local var_26_3 = var_3.getShipById(var_26_2, var_26_0)
	local var_26_4 = var_3.getMetaSkillLevelBySkillID(var_26_3, var_26_1)

	setText = var_26_2

	var_26_2(arg_26_0.skillLevelText, "LEVEL:" .. var_26_4)

	if arg_26_0:isMaxLevel() then
		setText = var_5

		var_5(arg_26_0.curExpText, "MAX")

		setSlider = var_5

		var_5(arg_26_0.progressBar, 0, 1, 1)
	end

	arg_26_0:updateUIItemList()

	return
end

function var_0_1.getBookItem(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0.bagProxy
	local var_27_3

	if not var_2.getItemById(var_27_0, arg_27_1) then
		Drop = var_1_10003

		local var_27_1 = var_1_10003.New
		local var_27_2 = {
			count = 0
		}

		DROP_TYPE_ITEM = var_1_10006
		var_27_2.type = var_1_10006
		var_27_2.id = arg_27_1
		var_27_3 = var_27_1(var_27_2)
	end

	return var_27_3
end

function var_0_1.resetUseData(arg_28_0)
	local var_28_0

	if not arg_28_0.useCountDict then
		var_28_0 = {}
	end

	arg_28_0.useCountDict = var_28_0

	local var_28_1

	if not arg_28_0.maxCountDict then
		var_28_1 = {}
	end

	arg_28_0.maxCountDict = var_28_1
	ipairs = var_28_1

	for iter_28_0, iter_28_1 in var_28_1(arg_28_0.bookIDList) do
		arg_28_0.useCountDict[iter_28_1] = 0

		local var_28_2 = arg_28_0.maxCountDict
		local var_28_3 = arg_28_0.bagProxy

		var_28_2[iter_28_1] = var_7.getItemCountById(var_28_3, iter_28_1)
	end

	return
end

function var_0_1.tryModifyUseCount(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_0.maxCountDict[arg_29_1]
	local var_29_1 = arg_29_0.useCountDict[arg_29_1]

	if var_29_0 <= 0 then
		return
	end

	local var_29_2

	if arg_29_2 < 0 then
		math = var_29_2
		var_29_2 = var_29_2.clamp(var_29_1 + arg_29_2, 0, var_29_0)
		arg_29_0.useCountDict[arg_29_1] = var_29_2
	else
		math = var_29_2

		local var_29_3 = var_29_2.min(var_29_0, arg_29_2)
		local var_29_4 = arg_29_0.expDict[arg_29_1]
		local var_29_5 = 0

		for iter_29_0 = 0, var_29_3 do
			local var_29_6 = var_29_5 * var_29_4

			if not arg_29_0:preCalcExpOverFlow(var_29_6, 0) and (var_29_3 <= iter_29_0 or var_29_0 <= var_29_1 + var_29_5) then
				break
			end
		end

		arg_29_0.useCountDict[arg_29_1] = var_29_1 + var_29_5
	end

	return
end

function var_0_1.getLevelTotalExp(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0.skillID
	local var_30_1 = arg_30_0.bayProxy
	local var_30_2 = var_3.getShipById(var_30_1, arg_30_0.shipID)

	pg = var_1_10004

	local var_30_3 = var_1_10004.skill_data_template[var_30_0].max_level

	pg = var_30_1

	local var_30_4 = var_30_1.ship_meta_skilltask.get_id_list_by_skill_ID[var_30_0]
	local var_30_5 = 0

	ipairs = var_1_10007

	for iter_30_0, iter_30_1 in var_1_10007(var_30_4) do
		pg = var_1_10012

		local var_30_6 = var_1_10012.ship_meta_skilltask[iter_30_1].level
		local var_30_7 = var_1_10012.need_exp

		if var_30_6 < arg_30_1 then
			var_30_5 = var_30_5 + var_30_7
		end
	end

	return var_30_5
end

function var_0_1.getCurLevelExp(arg_31_0)
	local var_31_0 = arg_31_0.skillID
	local var_31_1 = arg_31_0.bayProxy
	local var_31_2 = var_2.getShipById(var_31_1, arg_31_0.shipID)
	local var_31_3 = var_2.getMetaSkillLevelBySkillID(var_31_2, var_31_0)
	local var_31_4 = arg_31_0.metaProxy
	local var_31_5 = var_4.getMetaTacticsInfoByShipID(var_31_4, arg_31_0.shipID)
	local var_31_6 = var_4.getSkillExp(var_31_5, var_31_0)

	return arg_31_0:getLevelTotalExp(var_31_3) + var_31_6
end

function var_0_1.calcAwardExp(arg_32_0)
	local var_32_0 = 0

	ipairs = var_1_10002

	for iter_32_0, iter_32_1 in var_1_10002(arg_32_0.bookIDList) do
		var_32_0 = var_32_0 + arg_32_0.useCountDict[iter_32_1] * arg_32_0.expDict[iter_32_1]
	end

	return var_32_0
end

function var_0_1.calcLevelWithAwardExp(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0:getCurLevelExp() + arg_33_1
	local var_33_1 = arg_33_0.skillID

	pg = var_1_10005

	local var_33_2 = var_1_10005.ship_meta_skilltask.get_id_list_by_skill_ID[var_33_1]
	local var_33_3 = 1

	ipairs = var_1_10007

	for iter_33_0, iter_33_1 in var_1_10007(var_33_2) do
		pg = var_1_10012

		if var_1_10012.ship_meta_skilltask[iter_33_1].need_exp <= var_33_0 then
			var_33_0 = var_33_0 - var_1_10012
			var_33_3 = var_33_3 + 1
		else
			break
		end
	end

	return var_33_3
end

function var_0_1.isCanUpMax(arg_34_0)
	local var_34_0 = arg_34_0.skillID

	pg = var_1_10002

	local var_34_1 = var_1_10002.skill_data_template[var_34_0].max_level

	return arg_34_0:getLevelTotalExp(var_34_1) <= arg_34_0:getCurLevelExp() + arg_34_0:calcAwardExp()
end

function var_0_1.preCalcExpOverFlow(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = arg_35_0.skillID

	pg = var_1_10004

	local var_35_1 = var_1_10004.skill_data_template[var_35_0].max_level
	local var_35_2 = arg_35_0:getLevelTotalExp(var_35_1) - arg_35_0:getCurLevelExp()
	local var_35_3 = arg_35_0:calcAwardExp()
	local var_35_4 = false
	local var_35_5

	if var_35_2 <= var_35_3 + arg_35_1 and arg_35_2 <= var_11 - var_35_2 then
		var_35_4 = true
	end

	return var_35_4, var_35_5
end

function var_0_1.oneStep(arg_36_0)
	if arg_36_0:isMaxLevel() then
		return
	end

	arg_36_0:resetUseData()

	local var_36_0 = {}

	ipairs = var_1_10002

	for iter_36_0, iter_36_1 in var_1_10002(arg_36_0.bookIDList) do
		local var_36_1 = arg_36_0:getBookItem(iter_36_1).count

		if 0 < var_36_1 then
			table = var_8

			var_8.insert(var_36_0, iter_36_1)
		end
	end

	table = var_2

	var_2.sort(var_36_0, function(arg_37_0, arg_37_1)
		return arg_37_1 < arg_37_0
	end)

	ipairs = var_2

	for iter_36_2, iter_36_3 in var_2(var_36_0) do
		local var_36_2 = arg_36_0:getBookItem(iter_36_3)
		local var_36_3 = arg_36_0.expDict[iter_36_3]
		local var_36_4 = iter_36_2 + 1 > #var_36_0 and 0 or arg_36_0.expDict[var_36_0[iter_36_2 + 1]]

		for iter_36_4 = 1, var_36_2.count do
			if iter_36_2 < #var_36_0 and arg_36_0:preCalcExpOverFlow(var_36_3, var_36_4) then
				break
			else
				arg_36_0.useCountDict[iter_36_3] = arg_36_0.useCountDict[iter_36_3] + 1

				if arg_36_0:isCanUpMax() then
					return
				end
			end
		end
	end

	return
end

function var_0_1.isMaxLevel(arg_38_0)
	local var_38_0 = arg_38_0.skillID
	local var_38_1 = arg_38_0.shipID
	local var_38_2 = arg_38_0.bayProxy
	local var_38_3 = var_3.getShipById(var_38_2, var_38_1)

	return var_3.isSkillLevelMax(var_38_3, var_38_0)
end

return var_0_1
