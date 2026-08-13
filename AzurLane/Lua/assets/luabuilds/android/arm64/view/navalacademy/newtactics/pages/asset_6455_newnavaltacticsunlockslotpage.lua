class = var_0_10000

local var_0_0 = "NewNavalTacticsUnlockSlotPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("....base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "NewNavalTacticsUnlockSlotPage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "content/Text")
	local var_2_2 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.contentTxt = var_2_2(var_2_1, var_4(var_1_10006))

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "content/discountDate")
	local var_2_5 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.discountDateTxt = var_2_5(var_2_4, var_4(var_1_10006))

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_1.Find(var_2_6, "content/discountInfo/Text")
	local var_2_8 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.discountTxt = var_2_8(var_2_7, var_4(var_1_10006))

	local var_2_9 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_9, "content/confirm_btn")

	local var_2_10 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_10, "content/cancel_btn")

	local var_2_11 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_11, "content/btnBack")
	setText = var_1

	local var_2_12 = arg_2_0.confirmBtn
	local var_2_13 = var_3.Find(var_2_12, "pic")

	i18n = var_4

	var_1(var_2_13, var_4("word_ok"))

	setText = var_1

	local var_2_14 = arg_2_0.cancelBtn
	local var_2_15 = var_3.Find(var_2_14, "pic")

	i18n = var_4

	var_1(var_2_15, var_4("word_cancel"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.confirmBtn

	local function var_3_2()
		if arg_3_0.callback then
			arg_3_0.callback()
		end

		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.cancelBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0._tf

	local function var_3_8()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10006)

	onButton = var_1_10001

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.closeBtn

	local function var_3_11()
		local var_7_0 = arg_3_0

		var_0.Hide(var_7_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_9, var_3_10, var_3_11, var_1_10006)

	return
end

function var_0_1.Show(arg_8_0, arg_8_1, arg_8_2)
	var_0_1.super.Show(arg_8_0)

	arg_8_0.callback = arg_8_2
	CommonCommodity = var_3

	local var_8_0 = var_3.New
	local var_8_1 = {
		id = arg_8_1
	}

	Goods = var_1_10006

	local var_8_2 = var_8_0(var_8_1, var_1_10006.TYPE_SHOPSTREET)

	arg_8_0:Flush(var_8_2)

	arg_8_0.commodity = var_8_2

	return
end

function var_0_1.Flush(arg_9_0, arg_9_1)
	arg_9_0:RemoveTimer()

	if arg_9_1:isDisCount() then
		arg_9_0:UpdateDiscountView(arg_9_1)
	else
		local var_9_0 = arg_9_1

		var_1_10003 = arg_9_1.GetPrice(var_9_0)

		local var_9_1 = arg_9_0.contentTxt

		i18n = var_9_0
		var_9_1.text = var_9_0("open_skill_pos", var_1_10003)
	end

	setActive = var_1_10003

	var_1_10003(arg_9_0.discountDateTxt.gameObject, var_2)

	setActive = var_1_10003

	var_1_10003(arg_9_0.discountTxt.gameObject.transform.parent, var_2)

	return
end

function var_0_1.UpdateDiscountView(arg_10_0, arg_10_1)
	local var_10_0, var_10_1 = arg_10_1:GetPrice()
	local var_10_2 = arg_10_1:GetDiscountEndTime()

	arg_10_0:AddTimer(var_10_2)

	arg_10_0.discountTxt.text = var_10_1 .. "%"

	local var_10_3 = arg_10_1
	local var_10_4 = arg_10_1.getConfig(var_10_3, "resource_num")
	local var_10_5 = arg_10_0.contentTxt

	i18n = var_10_3
	var_10_5.text = var_10_3("open_skill_pos_discount", var_10_4, var_10_0)
	onNextTick = var_10_5

	var_10_5(function()
		local var_11_0 = arg_10_0.contentTxt.gameObject.transform
		local var_11_1 = var_0.GetChild(var_11_0, var_0.childCount - 1)

		IsNil = var_2_10002

		if not var_2_10002(var_11_1) then
			setAnchoredPosition = var_2

			var_2(var_11_1, {
				y = var_11_1.anchoredPosition.y + 15
			})
		end

		return
	end)

	return
end

function var_0_1.AddTimer(arg_12_0, arg_12_1)
	Timer = var_1_10002
	arg_12_0.timer = var_1_10002.New(function()
		pg = var_2_10000

		local var_13_0 = var_2_10000.TimeMgr.GetInstance()
		local var_13_1 = var_0.GetServerTime(var_13_0)
		local var_13_2

		if arg_12_1 - var_13_1 <= 0 then
			var_13_2 = arg_12_0.discountDateTxt
			var_13_2.text = ""

			local var_13_3 = arg_12_0

			var_13_2.Flush(var_13_3, arg_12_0.commodity)
		else
			i18n = var_13_2

			local var_13_4 = "discount_time"
			local var_13_5 = arg_12_0
			local var_13_6 = var_5.WarpDateTip(var_13_5, var_1)

			i18n = var_2_10006

			if var_13_2(var_13_4, var_13_6 .. var_2_10006("word_date")) ~= arg_12_0.str then
				arg_12_0.discountDateTxt.text = var_2
				arg_12_0.str = var_2
			end
		end

		return
	end, 1, -1)

	local var_12_0 = arg_12_0.timer

	var_2.Start(var_12_0)
	arg_12_0.timer.func()

	return
end

function var_0_1.WarpDateTip(arg_14_0, arg_14_1)
	local var_14_0 = ""

	if 0 <= arg_14_1 then
		math = var_3
		var_14_0 = var_3.floor(arg_14_1 / 0)
	elseif 3600 <= arg_14_1 then
		math = var_3
		var_14_0 = var_3.floor(arg_14_1 / 16)
	else
		math = var_3
		var_14_0 = var_3.floor(arg_14_1 / 60)
	end

	return var_14_0
end

function var_0_1.RemoveTimer(arg_15_0)
	if arg_15_0.timer then
		local var_15_0 = arg_15_0.timer

		var_1.Stop(var_15_0)

		arg_15_0.timer = nil
	end

	return
end

function var_0_1.Hide(arg_16_0)
	arg_16_0:RemoveTimer()
	var_0_1.super.Hide(arg_16_0)

	arg_16_0.callback = nil
	arg_16_0.commodity = nil

	return
end

function var_0_1.OnDestroy(arg_17_0)
	arg_17_0:Hide()

	return
end

return var_0_1
