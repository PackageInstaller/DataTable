class = var_0_10000

local var_0_0 = "BackYardSettlementLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "BackYardStatisticsUI"
end

function var_0_1.setShipVOs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.oldShipVOs = arg_2_1
	arg_2_0.newShipVOs = arg_2_2

	return
end

function var_0_1.setDormVO(arg_3_0, arg_3_1)
	arg_3_0.dormVO = arg_3_1

	return
end

function var_0_1.init(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.frame = var_1.Find(var_4_0, "frame")

	local var_4_1 = arg_4_0._tf

	arg_4_0.painting = var_1.Find(var_4_1, "painting")

	local var_4_2 = arg_4_0._tf

	arg_4_0.confirmBtn = var_1.Find(var_4_2, "painting/confirm_btn")

	local var_4_3 = arg_4_0._tf

	arg_4_0.timeTF = var_1.Find(var_4_3, "ship_word/text_contain1")

	local var_4_4 = arg_4_0._tf

	arg_4_0.expTF = var_1.Find(var_4_4, "ship_word/text_contain2")

	local var_4_5 = arg_4_0._tf

	arg_4_0.emptyTF = var_1.Find(var_4_5, "ship_word/Text")
	UIItemList = var_1

	local var_4_6 = var_1.New
	local var_4_7 = arg_4_0.frame
	local var_4_8 = var_2.Find(var_4_7, "container")
	local var_4_9 = arg_4_0.frame

	arg_4_0.uilist = var_4_6(var_4_8, var_3.Find(var_4_9, "container/ship_tpl"))

	return
end

function var_0_1.didEnter(arg_5_0)
	pg = var_1_10001

	local var_5_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_5_0, arg_5_0._tf)

	onButton = var_1

	local var_5_1 = arg_5_0
	local var_5_2 = arg_5_0.confirmBtn

	local function var_5_3()
		local var_6_0 = arg_5_0

		var_0.emit(var_6_0, var_0_1.ON_CLOSE)

		return
	end

	SOUND_BACK = var_1_10005

	var_1(var_5_1, var_5_2, var_5_3, var_1_10005)

	arg_5_0.cards = {}

	local var_5_4 = arg_5_0.uilist

	var_1.make(var_5_4, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			local var_7_0 = arg_5_0.cards

			BackYardSettlementCard = var_2_10004
			var_7_0[arg_7_1] = var_2_10004.New(arg_7_2)
		end

		return
	end)

	local var_5_5, var_5_6 = arg_5_0:UpdateShips()

	arg_5_0:InitPainting(var_5_5, var_5_6)

	return
end

function var_0_1.InitPainting(arg_8_0, arg_8_1, arg_8_2)
	setPaintingPrefabAsync = var_1_10003

	var_1_10003(arg_8_0.painting, arg_8_1:getPainting(), "jiesuan")

	setActive = var_1_10003

	var_1_10003(arg_8_0.timeTF, arg_8_0.dormVO.food ~= 0)

	setActive = var_1_10003

	var_1_10003(arg_8_0.expTF, arg_8_0.dormVO.food ~= 0)

	setActive = var_1_10003

	var_1_10003(arg_8_0.emptyTF, arg_8_0.dormVO.food == 0)

	if arg_8_0.dormVO.food == 0 then
		setText = var_3

		local var_8_0 = arg_8_0.emptyTF

		i18n = var_5

		var_3(var_8_0, var_5("backyard_backyardGranaryLayer_noFood"))
	else
		pg = var_3

		local var_8_1 = var_3.TimeMgr.GetInstance()
		local var_8_2 = var_3.GetServerTime(var_8_1)
		local var_8_3

		if not arg_8_0.contextData.time then
			var_8_3 = 0
		end

		local var_8_4 = var_8_2 - var_8_3

		i18n = var_8_3

		local var_8_5 = "backyard_addExp_Info"

		pg = var_6

		local var_8_6 = var_6.TimeMgr.GetInstance()
		local var_8_7 = var_6.DescCDTime(var_8_6, var_8_4)
		local var_8_8

		if not arg_8_0.contextData.food then
			var_8_8 = 0
		end

		local var_8_9 = var_8_3(var_8_5, var_8_7, var_8_8, arg_8_2)

		string = var_8_5

		local var_8_10 = var_8_5.split(var_8_9, "||")

		assert = var_6

		var_6(#var_8_10 > 0, "gametip ==> backyard_addExp_Info 必须用||分开")

		local var_8_11 = arg_8_0._tf
		local var_8_12 = var_6.Find(var_8_11, "ship_word/text_contain1")
		local var_8_13 = 0

		while var_8_13 < var_8_12.childCount do
			setText = var_8

			var_8(var_8_12:GetChild(var_8_13), var_8_10[var_8_13 + 1])

			var_8_13 = var_8_13 + 1
		end

		local var_8_14 = arg_8_0._tf
		local var_8_15 = var_8.Find(var_8_14, "ship_word/text_contain2")
		local var_8_16 = 0

		while var_8_16 < var_8_15.childCount do
			setText = var_10

			var_10(var_8_15:GetChild(var_8_16), var_8_10[var_8_13 + 1])

			var_8_13 = var_8_13 + 1
			var_8_16 = var_8_16 + 1
		end
	end

	return
end

function var_0_1.UpdateShips(arg_9_0)
	local var_9_0 = {}
	local var_9_1 = 0

	pairs = var_1_10003

	for iter_9_0, iter_9_1 in var_1_10003(arg_9_0.newShipVOs) do
		table = var_1_10008

		var_1_10008.insert(var_9_0, iter_9_0)

		if arg_9_0.oldShipVOs[iter_9_0].level ~= var_1_10008:getMaxLevel() then
			var_9_1 = var_9_1 + 1
		end
	end

	local var_9_2 = arg_9_0.uilist

	var_3.align(var_9_2, #var_9_0)

	local var_9_3

	if not arg_9_0.contextData.exp then
		var_9_3 = 0
	end

	local var_9_4 = {}

	pairs = var_5

	for iter_9_2, iter_9_3 in var_5(arg_9_0.cards) do
		table = var_1_10010

		var_1_10010.insert(var_9_4, function(arg_10_0)
			if arg_9_0.exited then
				return
			end

			local var_10_0 = var_9_0[iter_9_2 + 1]
			local var_10_1 = iter_9_3

			var_2.Update(var_10_1, var_9_3, arg_9_0.oldShipVOs[var_10_0], arg_9_0.newShipVOs[var_10_0])

			onNextTick = var_2

			var_2(arg_10_0)

			return
		end)
	end

	seriesAsync = var_5

	var_5(var_9_4)

	return arg_9_0.newShipVOs[var_9_0[1]], var_9_1 * var_9_3
end

function var_0_1.willExit(arg_11_0)
	pg = var_1_10001

	local var_11_0 = var_1_10001.UIMgr.GetInstance()
	local var_11_1 = var_1.UnOverlayPanel
	local var_11_2 = arg_11_0._tf

	pg = var_1_10004

	var_11_1(var_11_0, var_11_2, var_1_10004.UIMgr.GetInstance().UIMain)

	ipairs = var_11_1

	for iter_11_0, iter_11_1 in var_11_1(arg_11_0.cards) do
		iter_11_1:Dispose()
	end

	return
end

return var_0_1
