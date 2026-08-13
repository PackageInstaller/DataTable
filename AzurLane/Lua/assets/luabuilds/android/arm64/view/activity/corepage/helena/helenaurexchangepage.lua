class = var_0_10000

local var_0_0 = "HelenaUrExchangePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreURExchangeTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0._tf

	arg_1_0._btnExchange = var_1.Find(var_1_0, "AD/btn_exchange_on")

	local var_1_1 = arg_1_0._tf

	arg_1_0._btnExchange_off = var_1.Find(var_1_1, "AD/btn_exchange_off")

	local var_1_2 = arg_1_0._msgBox

	arg_1_0._msgBoxBtnCancel = var_1.Find(var_1_2, "msg_box/btn_cancel")

	local var_1_3 = arg_1_0._msgBox

	arg_1_0._msgBoxBtnConfirm = var_1.Find(var_1_3, "msg_box/btn_confirm")

	local var_1_4 = arg_1_0._msgBox

	arg_1_0._msgBoxLabel = var_1.Find(var_1_4, "msg_box/label/text_cn")

	local var_1_5 = arg_1_0._msgBox

	arg_1_0._msgBoxItem = var_1.Find(var_1_5, "msg_box/item/IconTpl")

	local var_1_6 = arg_1_0._msgBox

	arg_1_0._msgBoxItemName = var_1.Find(var_1_6, "msg_box/item/name")

	local var_1_7 = arg_1_0._msgBox

	arg_1_0._msgBoxItemDesc = var_1.Find(var_1_7, "msg_box/item/desc")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	var_0_1.super.OnFirstFlush(arg_2_0)

	onButton = var_1

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0._btnExchange

	local function var_2_2()
		Drop = var_2_10000

		local var_3_0 = var_2_10000.Create({
			arg_2_0.curGoods.commodity_type,
			arg_2_0.curGoods.commodity_id,
			1
		})

		updateDrop = var_2_10001

		var_2_10001(arg_2_0._msgBoxItem, var_3_0)

		setText = var_2_10001

		var_2_10001(arg_2_0._msgBoxItemName, var_3_0:getName())

		setText = var_2_10001

		var_2_10001(arg_2_0._msgBoxItemDesc, var_3_0.desc)

		pg = var_2_10001

		local var_3_1 = var_2_10001.UIMgr.GetInstance()

		var_1.BlurPanel(var_3_1, arg_2_0._msgBox)

		setActive = var_1

		var_1(arg_2_0._msgBox, true)

		arg_2_0.isMsgBoxShow = true

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_0, var_2_1, var_2_2, var_1_10006)

	onButton = var_1

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0._btnExchange_off

	local function var_2_5()
		setActive = var_2_10000

		var_2_10000(arg_2_0._ptTip, true)

		local var_4_0 = arg_2_0

		LeanTween = var_2_10001

		local var_4_1 = var_2_10001.delayedCall
		local var_4_2 = 1

		System = var_2_10004
		var_4_0.leantween = var_4_1(var_4_2, var_2_10004.Action(function()
			setActive = var_3_10000

			var_3_10000(arg_2_0._ptTip, false)

			return
		end)).uniqueId

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_3, var_2_4, var_2_5, var_1_10006)

	return
end

function var_0_1.OnUpdateFlush(arg_6_0)
	arg_6_0:UpdateExchangeStatus()

	local var_6_0 = arg_6_0.uilist

	var_1.align(var_6_0, #arg_6_0.taskConfig)
	arg_6_0:UpdatePtCount()

	setActive = var_1

	local var_6_1 = arg_6_0._btnExchange

	var_1(var_3.Find(var_6_1, "red"), arg_6_0.canExchange)

	setActive = var_1

	var_1(arg_6_0._btnExchange, arg_6_0.canExchange)

	setActive = var_1

	var_1(arg_6_0._btnExchange_off, not arg_6_0.canExchange)

	return
end

return var_0_1
