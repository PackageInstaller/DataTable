class = var_0_10000

local var_0_0 = "ShipExpItemUsagePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "ShipExpItemUsagePage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.backBtn = var_1.Find(var_2_0, "frame/top/btnBack")

	local var_2_1 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_1, "frame/buttons/confirm")

	local var_2_2 = arg_2_0._tf

	arg_2_0.recomBtn = var_1.Find(var_2_2, "frame/buttons/recom")

	local var_2_3 = arg_2_0._tf

	arg_2_0.clearBtn = var_1.Find(var_2_3, "frame/buttons/clear")

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_1.Find(var_2_4, "frame/content/level/Text")
	local var_2_6 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.levelTxt = var_2_6(var_2_5, var_4(var_1_10006))

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_1.Find(var_2_7, "frame/content/level/exp")
	local var_2_9 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.expTxt = var_2_9(var_2_8, var_4(var_1_10006))

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_1.Find(var_2_10, "frame/content/level/y")
	local var_2_12 = var_1.GetComponent

	typeof = var_4
	Slider = var_1_10006
	arg_2_0.currentProgress = var_2_12(var_2_11, var_4(var_1_10006))

	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_1.Find(var_2_13, "frame/content/level/w")
	local var_2_15 = var_1.GetComponent

	typeof = var_4
	Slider = var_1_10006
	arg_2_0.tipProgress = var_2_15(var_2_14, var_4(var_1_10006))

	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_1.Find(var_2_16, "frame/content/level/g")
	local var_2_18 = var_1.GetComponent

	typeof = var_4
	Slider = var_1_10006
	arg_2_0.previewProgress = var_2_18(var_2_17, var_4(var_1_10006))
	arg_2_0.itemIds = arg_2_0:GetAllItemIDs()

	local var_2_19

	if #arg_2_0.itemIds <= 3 then
		UIItemList = var_2_19
		var_2_19 = var_2_19.New

		local var_2_20 = arg_2_0._tf
		local var_2_21 = var_4.Find(var_2_20, "frame/content/items")
		local var_2_22 = arg_2_0._tf

		arg_2_0.uiItemList = var_2_19(var_2_21, var_5.Find(var_2_22, "frame/content/items/tpl"))
	else
		UIItemList = var_2_19
		var_2_19 = var_2_19.New

		local var_2_23 = arg_2_0._tf
		local var_2_24 = var_4.Find(var_2_23, "frame/content/scrollrect/content")
		local var_2_25 = arg_2_0._tf

		arg_2_0.uiItemList = var_2_19(var_2_24, var_5.Find(var_2_25, "frame/content/items/tpl"))
	end

	setActive = var_2_19

	local var_2_26 = arg_2_0._tf

	var_2_19(var_4.Find(var_2_26, "frame/content/items"), var_1)

	setActive = var_2_19

	local var_2_27 = arg_2_0._tf

	var_2_19(var_4.Find(var_2_27, "frame/content/scrollrect"), not var_1)

	setText = var_2_19

	local var_2_28 = arg_2_0._tf
	local var_2_29 = var_4.Find(var_2_28, "frame/top/bg/infomation/title")

	i18n = var_5

	var_2_19(var_2_29, var_5("ship_exp_item_title"))

	setText = var_2_19

	local var_2_30 = arg_2_0._tf
	local var_2_31 = var_4.Find(var_2_30, "frame/content/label")

	i18n = var_5

	var_2_19(var_2_31, var_5("coures_level_tip"))

	setText = var_2_19

	local var_2_32 = arg_2_0.confirmBtn
	local var_2_33 = var_4.Find(var_2_32, "pic")

	i18n = var_5

	var_2_19(var_2_33, var_5("ship_exp_item_label_confirm"))

	setText = var_2_19

	local var_2_34 = arg_2_0.recomBtn
	local var_2_35 = var_4.Find(var_2_34, "pic")

	i18n = var_5

	var_2_19(var_2_35, var_5("ship_exp_item_label_recom"))

	setText = var_2_19

	local var_2_36 = arg_2_0.clearBtn
	local var_2_37 = var_4.Find(var_2_36, "pic")

	i18n = var_5

	var_2_19(var_2_37, var_5("ship_exp_item_label_clear"))

	return
end

function var_0_1.OnInit(arg_3_0)
	arg_3_0.cards = {}
	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.backBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.recomBtn

	local function var_3_8()
		triggerButton = var_2_10000

		var_2_10000(arg_3_0.clearBtn)

		local var_6_0 = arg_3_0
		local var_6_1 = var_0.Recommand(var_6_0)

		pairs = var_2_10001

		for iter_6_0, iter_6_1 in var_2_10001(arg_3_0.cards) do
			local var_6_2

			if not var_6_1[iter_6_1.item.id] then
				var_6_2 = 0
			end

			iter_6_1.value = var_6_2

			iter_6_1:UpdateValue()
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_6, var_3_7, var_3_8, var_1_10006)

	onButton = var_1

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.clearBtn

	local function var_3_11()
		pairs = var_2_10000

		for iter_7_0, iter_7_1 in var_2_10000(arg_3_0.cards) do
			iter_7_1.value = 0

			iter_7_1:UpdateValue()
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_9, var_3_10, var_3_11, var_1_10006)

	onButton = var_1

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.confirmBtn

	local function var_3_14()
		_ = var_2_10000

		local var_8_0 = var_2_10000.all

		_ = var_2_10002

		local var_8_1

		if var_8_0(var_2_10002.values(arg_3_0.itemCnts), function(arg_9_0)
			return arg_9_0 == 0
		end) then
			pg = var_0
			var_8_1 = var_0.TipsMgr.GetInstance()

			local var_8_2 = var_0.ShowTips

			i18n = var_3

			var_8_2(var_8_1, var_3("ship_remould_no_material"))

			return
		end

		local function var_8_3(arg_10_0)
			local var_10_0 = arg_3_0
			local var_10_1 = var_1.emit

			ShipMainMediator = var_3_10004

			var_10_1(var_10_0, var_3_10004.ON_ADD_SHIP_EXP, arg_3_0.shipVO.id, arg_3_0.itemCnts)

			if arg_10_0 then
				local var_10_2 = arg_3_0

				var_1.Hide(var_10_2)
			else
				local var_10_3 = arg_3_0

				var_1.Flush(var_10_3, arg_3_0.shipVO)
			end

			return
		end

		local var_8_4 = arg_3_0
		local var_8_5 = var_1.GetAdditionExp(var_8_4)

		Clone = var_8_1

		local var_8_6 = var_8_1(arg_3_0.shipVO)
		local var_8_7 = var_2.getMaxLevel(var_8_6)

		var_2.exp = var_2.exp + var_8_5

		local var_8_8 = false

		while var_2:canLevelUp() do
			var_2.exp = var_2.exp - var_2:getLevelExpConfig().exp_interval
			math = var_5
			var_2.level = var_5.min(var_2.level + 1, var_8_7)
			var_8_8 = true
		end

		local var_8_9 = var_2.maxLevel <= var_2.level

		if var_8_8 and (var_2.maxLevel == var_2.level and var_2.exp > 0 or var_2.maxLevel < var_2.level) then
			pg = var_6

			local var_8_10 = var_6.MsgboxMgr.GetInstance()
			local var_8_11 = var_6.ShowMsgBox
			local var_8_12 = {}

			i18n = var_2_10010
			var_8_12.content = var_2_10010("coures_exp_overflow_tip", var_2.exp)

			function var_8_12.onYes()
				var_8_3(var_8_9)

				return
			end

			var_8_11(var_8_10, var_8_12)
		else
			var_8_3(var_8_9)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_12, var_3_13, var_3_14, var_1_10006)

	local var_3_15 = arg_3_0.uiItemList

	var_1.make(var_3_15, function(arg_12_0, arg_12_1, arg_12_2)
		UIItemList = var_2_10003

		if arg_12_0 == var_2_10003.EventUpdate then
			local var_12_0 = arg_3_0.itemIds[arg_12_1 + 1]
			local var_12_1 = arg_3_0

			var_4.UpdateItemPanel(var_12_1, var_12_0, arg_12_2)
		end

		return
	end)

	return
end

function var_0_1.GetItem(arg_13_0, arg_13_1)
	getProxy = var_1_10002
	BagProxy = var_1_10004

	local var_13_0 = var_1_10002(var_1_10004)
	local var_13_1

	if not var_2.getItemById(var_13_0, arg_13_1) then
		Drop = var_13_1
		var_13_1 = var_13_1.New

		local var_13_2 = {
			count = 0
		}

		DROP_TYPE_ITEM = var_5
		var_13_2.type = var_5
		var_13_2.id = arg_13_1
		var_13_1 = var_13_1(var_13_2)
	end

	return var_13_1
end

function var_0_1.Recommand(arg_14_0)
	local var_14_0 = {}

	Clone = var_1_10002

	local var_14_1 = var_1_10002(arg_14_0.shipVO)

	underscore = var_1_10003

	local var_14_2 = var_1_10003.map
	local var_14_3 = arg_14_0
	local var_14_4 = var_14_2(arg_14_0.GetAllItemIDs(var_14_3), function(arg_15_0)
		local var_15_0 = arg_14_0

		return var_1.GetItem(var_15_0, arg_15_0)
	end)

	table = var_4

	local var_14_5 = var_4.sort
	local var_14_6 = var_14_4

	CompareFuncs = var_14_3

	var_14_5(var_14_6, var_14_3({
		function(arg_16_0)
			return -arg_16_0.id
		end
	}))

	ipairs = var_14_5

	for iter_14_0, iter_14_1 in var_14_5(var_14_4) do
		var_14_0[iter_14_1.id] = 0

		local var_14_7 = iter_14_1:getConfig("usage_arg")

		if iter_14_0 < #var_14_4 then
			local var_14_8 = var_14_4[iter_14_0 + 1]
			local var_14_9

			if not var_10.getConfig(var_14_8, "usage_arg") then
				var_14_9 = 0
			end

			for iter_14_2 = 1, iter_14_1.count do
				if iter_14_0 ~= #var_14_4 then
					local var_14_10 = arg_14_0
					local var_14_11 = arg_14_0.PreCalcExpOverFlow

					var_1_10018 = var_14_1
					tonumber = var_1_10019
					var_1_10019 = var_1_10019(var_14_7)
					tonumber = var_1_10020

					if var_14_11(var_14_10, var_1_10018, var_1_10019, var_1_10020(var_14_9)) then
						do break end
						goto label_14_0
					end
				end

				do
					local var_14_12 = var_14_1
					local var_14_13 = var_14_1.addExp

					tonumber = var_1_10018

					var_14_13(var_14_12, var_1_10018(var_14_7))

					var_14_0[iter_14_1.id] = var_14_0[iter_14_1.id] + 1

					if var_14_1.maxLevel == var_14_1.level then
						return var_14_0
					end
				end

				::label_14_0::
			end
		end
	end

	return var_14_0
end

function var_0_1.PreCalcExpOverFlow(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = arg_17_1.exp
	local var_17_1 = arg_17_1.level

	arg_17_1.exp = arg_17_1.exp + arg_17_2

	local var_17_2 = arg_17_1:getMaxLevel()

	while arg_17_1:canLevelUp() do
		arg_17_1.exp = arg_17_1.exp - arg_17_1:getLevelExpConfig().exp_interval
		math = var_7
		arg_17_1.level = var_7.min(arg_17_1.level + 1, var_17_2)
	end

	local var_17_3 = var_17_2 <= arg_17_1.level and arg_17_3 < arg_17_1.exp

	arg_17_1.exp = var_17_0
	arg_17_1.level = var_17_1

	return var_17_3
end

function var_0_1.GetAllItemIDs(arg_18_0)
	pg = var_1_10001

	local var_18_0 = var_1_10001.gameset.ship_exp_books.description
	local var_18_1 = {}

	ipairs = var_1_10003

	for iter_18_0, iter_18_1 in var_1_10003(var_18_0) do
		Item = var_1_10008

		if var_1_10008.getConfigData(iter_18_1) then
			table = var_1_10009

			var_1_10009.insert(var_18_1, iter_18_1)
		end
	end

	return var_18_1
end

function var_0_1.Show(arg_19_0, arg_19_1)
	pg = var_1_10002

	local var_19_0 = var_1_10002.UIMgr.GetInstance()

	var_2.BlurPanel(var_19_0, arg_19_0._tf)
	var_0_1.super.Show(arg_19_0)
	arg_19_0:Flush(arg_19_1)

	return
end

function var_0_1.Flush(arg_20_0, arg_20_1)
	arg_20_0.itemCnts = {}
	arg_20_0.shipVO = arg_20_1

	arg_20_0:InitItems()
	arg_20_0:UpdateLevelInfo()

	return
end

function var_0_1.Hide(arg_21_0)
	pg = var_1_10001

	local var_21_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_21_0, arg_21_0._tf, arg_21_0._parentTf)
	var_0_1.super.Hide(arg_21_0)

	return
end

function var_0_1.InitItems(arg_22_0)
	table = var_1_10001

	var_1_10001.sort(arg_22_0.itemIds, function(arg_23_0, arg_23_1)
		return arg_23_0 < arg_23_1
	end)

	local var_22_0 = arg_22_0.uiItemList

	var_1.align(var_22_0, #arg_22_0.itemIds)

	return
end

function var_0_1.UpdateItemPanel(arg_24_0, arg_24_1, arg_24_2)
	if not arg_24_0.cards[arg_24_2] then
		ShipExpItemUsageCard = var_1_10004

		local var_24_0 = var_1_10004.New(arg_24_2)

		var_3.SetCallBack(var_24_0, function(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
			local var_25_0 = arg_24_0

			var_4.OnAddItem(var_25_0, arg_25_0, arg_25_1, arg_25_2, arg_25_3)

			return
		end)

		arg_24_0.cards[arg_24_2] = var_3
	end

	var_3:Update(arg_24_1)

	return
end

function var_0_1.OnAddItem(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	local var_26_1

	if arg_26_0.shipVO.maxLevel == arg_26_0.shipVO.level then
		arg_26_1:ForceUpdateValue(arg_26_0.itemCnts[arg_26_2])

		pg = var_26_1

		local var_26_0 = var_26_1.TipsMgr.GetInstance()

		var_26_1 = var_26_1.ShowTips
		i18n = var_8

		var_26_1(var_26_0, var_8("coures_tip_exceeded_lv"))

		return
	end

	Clone = var_26_1

	local var_26_2 = var_26_1(arg_26_0.shipVO)
	local var_26_3 = 0

	pairs = var_7

	for iter_26_0, iter_26_1 in var_7(arg_26_0.itemCnts) do
		if iter_26_0 ~= arg_26_2 then
			Item = var_1_10012
			var_1_10012 = var_1_10012.getConfigData(iter_26_0).usage_arg
			tonumber = var_1_10013
			var_26_3 = var_26_3 + var_1_10013(var_1_10012) * iter_26_1
		end
	end

	var_26_2:addExp(var_26_3)

	Item = var_7

	local var_26_4 = var_7.getConfigData(arg_26_2).usage_arg
	local var_26_5 = 0

	if arg_26_4 then
		var_26_5 = arg_26_3
	elseif var_26_2.level ~= var_26_2.maxLevel then
		for iter_26_2 = 1, arg_26_3 do
			local var_26_6 = var_26_2
			local var_26_7 = var_26_2.addExp

			tonumber = var_1_10016

			var_26_7(var_26_6, var_1_10016(var_26_4))

			var_26_5 = var_26_5 + 1

			if var_26_2.maxLevel == var_26_2.level then
				break
			end
		end
	end

	local var_26_8

	if not arg_26_0.itemCnts[arg_26_2] then
		var_26_8 = 0
	end

	if var_26_8 < arg_26_3 then
		math = var_26_8

		local var_26_9 = var_26_8.max
		local var_26_10

		if not arg_26_0.itemCnts[arg_26_2] then
			var_26_10 = 0
		end

		var_26_5 = var_26_9(var_26_10, var_26_5)
	end

	if arg_26_3 ~= var_26_5 then
		arg_26_1:ForceUpdateValue(var_26_5)

		arg_26_3 = var_26_5
	end

	arg_26_0.itemCnts[arg_26_2] = arg_26_3

	arg_26_0:UpdateLevelInfo()

	return
end

function var_0_1.GetTempShipVO(arg_27_0, arg_27_1, arg_27_2)
	if 0 < arg_27_2 then
		Clone = var_3

		local var_27_0 = var_3(arg_27_1)

		var_3.addExp(var_27_0, arg_27_2)

		return var_3
	end

	return arg_27_1
end

function var_0_1.GetAdditionExp(arg_28_0)
	local var_28_0 = 0

	pairs = var_1_10002

	for iter_28_0, iter_28_1 in var_1_10002(arg_28_0.itemCnts) do
		Item = var_1_10007
		var_1_10007 = var_1_10007.getConfigData(iter_28_0).usage_arg
		tonumber = var_1_10008
		var_28_0 = var_28_0 + var_1_10008(var_1_10007) * iter_28_1
	end

	return var_28_0
end

function var_0_1.UpdateLevelInfo(arg_29_0)
	local var_29_0 = arg_29_0.shipVO
	local var_29_1 = arg_29_0:GetAdditionExp()
	local var_29_2

	if arg_29_0:GetTempShipVO(var_29_0, var_29_1).level - var_29_0.level <= 0 then
		if 0 < var_29_1 then
			var_29_2 = "+0"
		else
			var_29_2 = ""
		end
	else
		var_29_2 = "<color="
		COLOR_GREEN = var_6
		var_29_2 = var_29_2 .. var_6 .. ">+" .. var_4 .. "</color>"
	end

	arg_29_0.levelTxt.text = var_29_0.level .. var_29_2

	local var_29_3 = var_29_0:getLevelExpConfig().exp_interval
	local var_29_4 = arg_29_0.expTxt

	string = var_1_10009

	local var_29_5 = var_1_10009.format
	local var_29_6 = "%d<color=%s>(+%d)</color>/%d"
	local var_29_7 = var_29_0.exp

	COLOR_GREEN = var_1_10013
	var_29_4.text = var_29_5(var_29_6, var_29_7, var_1_10013, var_29_1, var_29_3)

	local var_29_8 = var_29_0.exp / var_29_3

	arg_29_0.currentProgress.value = var_29_8
	arg_29_0.tipProgress.value = var_29_1 <= 0 and var_29_8 or var_29_8 + 0.003
	arg_29_0.previewProgress.value = var_29_1 <= 0 and 0 or var_4 >= 1 and 1 or var_3.exp / var_29_3

	return
end

function var_0_1.OnDestroy(arg_30_0)
	pairs = var_1_10001

	for iter_30_0, iter_30_1 in var_1_10001(arg_30_0.cards) do
		iter_30_1:Dispose()
	end

	arg_30_0.cards = nil

	return
end

return var_0_1
