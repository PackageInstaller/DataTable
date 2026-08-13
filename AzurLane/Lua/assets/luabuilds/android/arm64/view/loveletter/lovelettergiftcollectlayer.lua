class = var_0_10000

local var_0_0 = "LoveLetterGiftCollectLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "LoveLetterGiftCollectUI"
end

var_0_1.optionsPath = {}

function var_0_1.init(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0.textTitle

	i18n = var_1_10004

	var_1_10001(var_2_0, var_1_10004("loveactivity_ui_5"))

	setText = var_1_10001

	local var_2_1 = arg_2_0.textHelp

	i18n = var_4

	var_1_10001(var_2_1, var_4("loveactivity_ui_7"))

	setText = var_1_10001

	local var_2_2 = arg_2_0.btnConfirm
	local var_2_3 = var_3.Find(var_2_2, "Text")

	i18n = var_4

	var_1_10001(var_2_3, var_4("loveactivity_ui_8"))

	setText = var_1_10001

	local var_2_4 = arg_2_0.btnSelectConfirm
	local var_2_5 = var_3.Find(var_2_4, "Text")

	i18n = var_4

	var_1_10001(var_2_5, var_4("loveactivity_ui_8"))

	UIItemList = var_1_10001
	arg_2_0.itemList = var_1_10001.New(arg_2_0.rtScrollContent, arg_2_0.rtScrollTpl)

	local var_2_6 = arg_2_0.itemList

	var_1.make(var_2_6, function(arg_3_0, arg_3_1, arg_3_2)
		arg_3_1 = arg_3_1 + 1
		UIItemList = var_2_10003

		if arg_3_0 == var_2_10003.EventUpdate then
			local var_3_0 = arg_2_0.tempList[arg_3_1]

			setText = var_2_10004

			local var_3_1 = arg_3_2:Find("year")

			tostring = var_2_10007

			var_2_10004(var_3_1, var_2_10007(var_3_0))

			local var_3_2 = arg_2_0.confirmDic[var_3_0]

			setActive = var_2_10005

			var_2_10005(arg_3_2:Find("icon/mask/IconTpl"), var_3_2)

			setActive = var_2_10005

			var_2_10005(arg_3_2:Find("icon/on"), var_3_2)

			setActive = var_2_10005

			var_2_10005(arg_3_2:Find("now"), var_3_2)

			if var_3_2 then
				unpack = var_2_10005
				var_2_10005, var_3_1 = var_2_10005(arg_2_0.giftItemList[var_3_2])
				updateDrop = var_7

				local var_3_3 = arg_3_2:Find("icon/mask/IconTpl")

				Drop = var_10

				local var_3_4 = var_10.New
				local var_3_5 = {
					count = 1
				}

				DROP_TYPE_ITEM = var_2_10013
				var_3_5.type = var_2_10013
				var_3_5.id = var_2_10005
				var_3_5.extra = var_3_1

				var_7(var_3_3, var_3_4(var_3_5))

				getProxy = var_7
				LoveLetterProxy = var_3_3

				local var_3_6 = var_7(var_3_3)
				local var_3_7 = var_7.GetGroupData(var_3_6, arg_2_0.giftGroupList[var_3_2])

				setLoveLetterMedal = var_8

				var_8(arg_3_2:Find("now/medal"), var_3_7)
			end

			setActive = var_2_10005

			var_2_10005(arg_3_2:Find("active/active_off"), not var_3_2)

			setActive = var_2_10005

			var_2_10005(arg_3_2:Find("active/active_on"), var_3_2)

			setText = var_2_10005

			local var_3_8 = arg_3_2:Find("active/Text")

			i18n = var_8

			var_2_10005(var_3_8, var_8("loveactivity_ui_6"))

			if not var_3_2 then
				local var_3_9 = arg_2_0.heap
				local var_3_10 = var_5.GetLength(var_3_9)

				if 0 < var_3_10 then
					local var_3_11 = arg_2_0.heap
					local var_3_12

					if var_3_0 ~= var_5.GetTop(var_3_11).element then
						var_3_12 = false
					else
						var_3_12 = true
					end

					setActive = var_3_1

					var_3_1(arg_3_2:Find("icon/tip"), var_3_12)

					setButtonEnabled = var_3_1

					var_3_1(arg_3_2:Find("icon"), var_3_12)

					if var_3_12 then
						onButton = var_3_1

						local var_3_13 = arg_2_0
						local var_3_14 = arg_3_2
						local var_3_15 = arg_3_2.Find(var_3_14, "icon")

						local function var_3_16()
							local var_4_0 = arg_2_0

							var_0.OpenSelectWindow(var_4_0, var_3_0)

							return
						end

						SFX_PANEL = var_3_14

						var_3_1(var_3_13, var_3_15, var_3_16, var_3_14)
					end

					return
				end
			end
		end
	end)

	setActive = var_1

	var_1(arg_2_0.rtPanel, true)

	setActive = var_1

	var_1(arg_2_0.rtSelectWindow, false)
	arg_2_0:BlurPanel(arg_2_0._tf)

	return
end

function var_0_1.didEnter(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.rtBg

	local function var_5_2()
		isActive = var_2_10000

		if var_2_10000(arg_5_0.rtSelectWindow) then
			local var_6_0 = arg_5_0

			var_0.CloseSelectWindow(var_6_0)
		else
			local var_6_1 = arg_5_0

			var_0.closeView(var_6_1)
		end

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_5_0, var_5_1, var_5_2, var_1_10006)

	onButton = var_1_10001

	local var_5_3 = arg_5_0
	local var_5_4 = arg_5_0.btnClose

	local function var_5_5()
		local var_7_0 = arg_5_0

		var_0.closeView(var_7_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_5_3, var_5_4, var_5_5, var_1_10006)

	onButton = var_1_10001

	local var_5_6 = arg_5_0
	local var_5_7 = arg_5_0.btnConfirm

	local function var_5_8()
		local var_8_0 = arg_5_0.heap
		local var_8_1 = var_0.GetLength(var_8_0)

		if 0 < var_8_1 then
			pg = var_8_1

			local var_8_2 = var_8_1.TipsMgr.GetInstance()
			local var_8_3 = var_0.ShowTips

			i18n = var_2_10003

			var_8_3(var_8_2, var_2_10003("loveactivity_ui_19"))

			return
		end

		local var_8_4 = {}

		pairs = var_1

		for iter_8_0, iter_8_1 in var_1(arg_5_0.confirmDic) do
			unpack = var_2_10006

			local var_8_5

			var_2_10006, var_8_5 = var_2_10006(arg_5_0.giftItemList[iter_8_1])
			table = var_8

			var_8.insert(var_8_4, {
				year = iter_8_0,
				group_id = var_8_5 or arg_5_0.giftGroupList[iter_8_1],
				item_id = var_2_10006
			})
		end

		local var_8_6 = arg_5_0
		local var_8_7 = var_1.emit

		LoveLetterGiftCollectMediator = iter_8_0

		var_8_7(var_8_6, iter_8_0.ON_RECORD_GIFT, var_8_4)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_5_6, var_5_7, var_5_8, var_1_10006)

	onButton = var_1_10001

	local var_5_9 = arg_5_0
	local var_5_10 = arg_5_0.btnSelectClose

	local function var_5_11()
		local var_9_0 = arg_5_0

		var_0.CloseSelectWindow(var_9_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_5_9, var_5_10, var_5_11, var_1_10006)
	arg_5_0:InitGift()
	arg_5_0:DropHump()
	arg_5_0:UpdateDisplay()

	return
end

function var_0_1.InitGift(arg_10_0)
	underscore = var_1_10001
	arg_10_0.giftItemList = var_1_10001.to_array(arg_10_0.contextData.items)
	arg_10_0.giftGroupList = {}
	getProxy = var_1
	LoveLetterProxy = var_3

	local var_10_0 = var_1(var_3)
	local var_10_1 = var_1.GetLoveLetterItemDic(var_10_0)
	local var_10_2 = {}

	ipairs = var_10_0

	for iter_10_0, iter_10_1 in var_10_0(arg_10_0.giftItemList) do
		unpack = var_1_10008

		local var_10_3

		var_1_10008, var_10_3 = var_1_10008(iter_10_1)
		assert = var_10
		tobool = var_1_10012
		var_1_10012 = var_1_10012(var_10_3)
		pg = iter_10_2
		iter_10_2 = iter_10_2.item_data_statistics[var_1_10008].type
		Item = var_14
		iter_10_2 = iter_10_2 == var_14.LOVE_LETTER_TYPE
		var_1_10012 = var_1_10012 == iter_10_2

		var_10(var_1_10012)

		pairs = var_10

		for iter_10_2, iter_10_3 in var_10(var_10_1[var_1_10008 .. "_" .. (var_10_3 or 0)]) do
			assert = var_1_10015

			var_1_10015(not arg_10_0.giftGroupList[iter_10_0] or arg_10_0.giftGroupList[iter_10_0] == iter_10_3)

			var_1_10015 = arg_10_0.giftGroupList
			var_1_10015[iter_10_0] = iter_10_3

			if not var_10_2[iter_10_2] then
				var_1_10015 = {}
			end

			var_10_2[iter_10_2] = var_1_10015
			table = var_1_10015

			var_1_10015.insert(var_10_2[iter_10_2], iter_10_0)
		end
	end

	arg_10_0.itemDic = var_10_1
	arg_10_0.yearDic = var_10_2
	arg_10_0.confirmDic = {}
	Heap = var_3

	local var_10_4 = var_3.New

	underscore = var_5
	arg_10_0.heap = var_10_4(var_5.keys(var_10_2), function(arg_11_0)
		return #var_10_2[arg_11_0]
	end)
	underscore = var_3

	local var_10_5 = var_3(arg_10_0.yearDic)
	local var_10_6 = var_3.chain(var_10_5)
	local var_10_7 = var_3.keys(var_10_6)
	local var_10_8 = var_3.sort(var_10_7)

	arg_10_0.tempList = var_3.value(var_10_8)
	assert = var_3

	var_3(#arg_10_0.giftItemList <= #arg_10_0.tempList)

	return
end

function var_0_1.ConfirmItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.confirmDic

	var_12_0[arg_12_1] = arg_12_2
	pairs = var_12_0

	for iter_12_0, iter_12_1 in var_12_0(arg_12_0.yearDic) do
		table = var_1_10008

		if var_1_10008.removebyvalue(arg_12_0.yearDic[iter_12_0], arg_12_2) > 0 then
			local var_12_1 = arg_12_0.heap

			var_1_10008.UpdateValue(var_12_1, iter_12_0)
		end
	end

	return
end

function var_0_1.DropHump(arg_13_0)
	::label_13_0::

	local var_13_0 = arg_13_0.heap

	if var_1.GetLength(var_13_0) > 0 then
		local var_13_1 = arg_13_0.heap

		if var_1.GetTop(var_13_1).value == 1 then
			repeat
				local var_13_2 = arg_13_0.heap
				local var_13_3, var_13_4 = var_1.POP(var_13_2)
				local var_13_5 = arg_13_0.yearDic[var_13_3][1]

				arg_13_0:ConfirmItem(var_13_3, var_13_5)

				goto label_13_0
			until true
		end
	end

	return
end

function var_0_1.UpdateDisplay(arg_14_0)
	local var_14_0 = arg_14_0.itemList

	var_1.align(var_14_0, #arg_14_0.tempList)

	return
end

function var_0_1.OpenSelectWindow(arg_15_0, arg_15_1)
	setText = var_1_10002

	local var_15_0 = arg_15_0.textSelectTitile

	i18n = var_1_10005

	var_1_10002(var_15_0, var_1_10005("loveactivity_ui_9", arg_15_1))

	setActive = var_1_10002

	var_1_10002(arg_15_0.rtPanel, false)

	setActive = var_1_10002

	var_1_10002(arg_15_0.rtSelectWindow, true)

	local var_15_1

	UIItemList = var_1_10003

	var_1_10003.StaticAlign(arg_15_0.rtSelectScrollContent, arg_15_0.rtSelectScrollTpl, #arg_15_0.yearDic[arg_15_1], function(arg_16_0, arg_16_1, arg_16_2)
		arg_16_1 = arg_16_1 + 1
		UIItemList = var_2_10003

		if arg_16_0 == var_2_10003.EventUpdate then
			local var_16_0 = arg_15_0.yearDic[arg_15_1][arg_16_1]

			unpack = var_4

			local var_16_1, var_16_2 = var_4(arg_15_0.giftItemList[var_16_0])

			updateDrop = var_6

			local var_16_3 = arg_16_2:Find("mask/IconTpl")

			Drop = var_2_10009

			local var_16_4 = var_2_10009.New
			local var_16_5 = {
				count = 1
			}

			DROP_TYPE_ITEM = var_2_10012
			var_16_5.type = var_2_10012
			var_16_5.id = var_16_1
			var_16_5.extra = var_16_2

			var_6(var_16_3, var_16_4(var_16_5))

			onToggle = var_6

			local var_16_6 = arg_15_0
			local var_16_7 = arg_16_2

			local function var_16_8(arg_17_0)
				if arg_17_0 then
					var_15_1 = var_16_0
				end

				return
			end

			SFX_PANEL = var_16_5

			var_6(var_16_6, var_16_7, var_16_8, var_16_5)
		end

		return
	end)

	triggerToggle = var_3

	local var_15_2 = arg_15_0.rtSelectScrollContent

	var_3(var_5.GetChild(var_15_2, 0), true)

	onButton = var_3

	local var_15_3 = arg_15_0
	local var_15_4 = arg_15_0.btnSelectConfirm

	local function var_15_5()
		local var_18_0 = arg_15_0.heap

		var_0.POP(var_18_0, arg_15_1)

		local var_18_1 = arg_15_0

		var_0.ConfirmItem(var_18_1, arg_15_1, var_15_1)

		local var_18_2 = arg_15_0

		var_0.DropHump(var_18_2)

		local var_18_3 = arg_15_0

		var_0.UpdateDisplay(var_18_3)

		local var_18_4 = arg_15_0

		var_0.CloseSelectWindow(var_18_4)

		return
	end

	SFX_CONFIRM = var_8

	var_3(var_15_3, var_15_4, var_15_5, var_8)

	return
end

function var_0_1.CloseSelectWindow(arg_19_0)
	setActive = var_1_10001

	var_1_10001(arg_19_0.rtPanel, true)

	setActive = var_1_10001

	var_1_10001(arg_19_0.rtSelectWindow, false)

	return
end

function var_0_1.willExit(arg_20_0)
	arg_20_0:UnOverlayPanel(arg_20_0._tf)

	local var_20_0 = arg_20_0.itemList

	var_1.each(var_20_0, function(arg_21_0, arg_21_1)
		arg_21_0 = arg_21_0 + 1
		eachChild = var_2_10002

		var_2_10002(arg_21_1:Find("now/medal"), function(arg_22_0, arg_22_1)
			returnLoveLetterMedal = var_3_10002

			var_3_10002(arg_22_0)

			return
		end)

		return
	end)

	return
end

return var_0_1
