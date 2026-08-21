local var_0_0 = class("BackYardSettlementLayer", import("...base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "BackYardStatisticsUI"
end

function var_0_0.setShipVOs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.oldShipVOs = arg_2_1
	arg_2_0.newShipVOs = arg_2_2

	return
end

function var_0_0.setDormVO(arg_3_0, arg_3_1)
	arg_3_0.dormVO = arg_3_1

	return
end

function var_0_0.init(arg_4_0)
	arg_4_0.frame = arg_4_0._tf:Find("frame")
	arg_4_0.painting = arg_4_0._tf:Find("painting")
	arg_4_0.confirmBtn = arg_4_0._tf:Find("painting/confirm_btn")
	arg_4_0.timeTF = arg_4_0._tf:Find("ship_word/text_contain1")
	arg_4_0.expTF = arg_4_0._tf:Find("ship_word/text_contain2")
	arg_4_0.emptyTF = arg_4_0._tf:Find("ship_word/Text")
	arg_4_0.uilist = UIItemList.New(arg_4_0.frame:Find("container"), arg_4_0.frame:Find("container/ship_tpl"))

	return
end

function var_0_0.didEnter(arg_5_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_5_0._tf)
	onButton(arg_5_0, arg_5_0.confirmBtn, function()
		arg_5_0:emit(var_0_0.ON_CLOSE)

		return
	end, SOUND_BACK)

	arg_5_0.cards = {}

	arg_5_0.uilist:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			arg_5_0.cards[arg_7_1] = BackYardSettlementCard.New(arg_7_2)
		end

		return
	end)

	local var_5_0, var_5_1 = arg_5_0:UpdateShips()

	arg_5_0:InitPainting(var_5_0, var_5_1)

	return
end

function var_0_0.InitPainting(arg_8_0, arg_8_1, arg_8_2)
	setPaintingPrefabAsync(arg_8_0.painting, arg_8_1:getPainting(), "jiesuan")
	setActive(arg_8_0.timeTF, arg_8_0.dormVO.food ~= 0)
	setActive(arg_8_0.expTF, arg_8_0.dormVO.food ~= 0)
	setActive(arg_8_0.emptyTF, arg_8_0.dormVO.food == 0)

	if arg_8_0.dormVO.food == 0 then
		setText(arg_8_0.emptyTF, i18n("backyard_backyardGranaryLayer_noFood"))
	else
		local var_8_0 = pg.TimeMgr.GetInstance():GetServerTime()
		local var_8_1 = arg_8_0.contextData.time or 0
		local var_8_2 = pg.TimeMgr.GetInstance():DescCDTime(var_8_0 - var_8_1)
		local var_8_3 = arg_8_0.contextData.food or 0
		local var_8_4 = i18n("backyard_addExp_Info", var_8_2, var_8_3, arg_8_2)
		local var_8_5 = string.split(var_8_4, "||")

		assert(#var_8_5 > 0, "gametip ==> backyard_addExp_Info 必须用||分开")

		local var_8_6 = arg_8_0._tf:Find("ship_word/text_contain1")
		local var_8_7 = 0

		while var_8_7 < var_8_6.childCount do
			setText(var_8_6:GetChild(var_8_7), var_8_5[var_8_7 + 1])

			var_8_7 = var_8_7 + 1
		end

		local var_8_8 = arg_8_0._tf:Find("ship_word/text_contain2")

		while 0 < var_8_8.childCount do
			setText(var_8_8:GetChild(0), var_8_5[var_8_7 + 1])

			var_8_7 = var_8_7 + 1
		end
	end

	return
end

function var_0_0.UpdateShips(arg_9_0)
	local var_9_0 = {}
	local var_9_1 = 0

	for iter_9_0, iter_9_1 in pairs(arg_9_0.newShipVOs) do
		table.insert({}, iter_9_0)

		if arg_9_0.oldShipVOs[iter_9_0].level ~= arg_9_0.oldShipVOs[iter_9_0]:getMaxLevel() then
			var_9_1 = var_9_1 + 1
		end
	end

	arg_9_0.uilist:align(#{})

	local var_9_2 = arg_9_0.contextData.exp or 0
	local var_9_3 = {}

	for iter_9_2, iter_9_3 in pairs(arg_9_0.cards) do
		table.insert(var_9_3, function(arg_10_0)
			if arg_9_0.exited then
				return
			end

			iter_9_3:Update(var_9_2, arg_9_0.oldShipVOs[var_9_0[iter_9_2 + 1]], arg_9_0.newShipVOs[var_9_0[iter_9_2 + 1]])
			onNextTick(arg_10_0)

			return
		end)
	end

	seriesAsync(var_9_3)

	return arg_9_0.newShipVOs[({})[1]], var_9_1 * var_9_2
end

function var_0_0.willExit(arg_11_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_11_0._tf, pg.UIMgr.GetInstance().UIMain)

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.cards) do
		iter_11_1:Dispose()
	end

	return
end

return var_0_0
