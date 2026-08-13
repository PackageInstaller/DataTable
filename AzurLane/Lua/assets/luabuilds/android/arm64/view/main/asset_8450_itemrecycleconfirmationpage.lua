class = var_0_10000

local var_0_0 = "ItemRecycleConfirmationPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "ItemRecycleConfirmationUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_0, "window/top/btnBack")

	local var_2_1 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_1, "window/button_container/cancel")

	local var_2_2 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_2, "window/button_container/confirm")

	local var_2_3 = arg_2_0._tf

	arg_2_0.content = var_1.Find(var_2_3, "window/single_item_panel/Text")

	local var_2_4 = arg_2_0._tf

	arg_2_0.itemTpl = var_1.Find(var_2_4, "window/single_item_panel/left")

	local var_2_5 = arg_2_0._tf

	arg_2_0.resTpl = var_1.Find(var_2_5, "window/single_item_panel/right")

	local var_2_6 = arg_2_0.itemTpl
	local var_2_7 = var_1.Find(var_2_6, "name_bg/Text")
	local var_2_8 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.itemName = var_2_8(var_2_7, var_4(var_1_10006))

	local var_2_9 = arg_2_0.resTpl
	local var_2_10 = var_1.Find(var_2_9, "name_bg/Text")
	local var_2_11 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.resName = var_2_11(var_2_10, var_4(var_1_10006))
	setText = var_1

	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_3.Find(var_2_12, "window/top/bg/infomation/title")

	i18n = var_4

	var_1(var_2_13, var_4("words_information"))

	setText = var_1

	local var_2_14 = arg_2_0._tf
	local var_2_15 = var_3.Find(var_2_14, "window/button_container/cancel/pic")

	i18n = var_4

	var_1(var_2_15, var_4("word_cancel"))

	setText = var_1

	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_3.Find(var_2_16, "window/button_container/confirm/pic")

	i18n = var_4

	var_1(var_2_17, var_4("word_ok"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.closeBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.cancelBtn

	local function var_3_8()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10006)

	onButton = var_1_10001

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.confirmBtn

	local function var_3_11()
		if arg_3_0.itemId then
			pg = var_0

			local var_7_0 = var_0.m02
			local var_7_1 = var_0.sendNotification

			GAME = var_2_10003

			var_7_1(var_7_0, var_2_10003.SELL_ITEM, {
				items = {
					{
						count = 1,
						id = arg_3_0.itemId
					}
				}
			})
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_9, var_3_10, var_3_11, var_1_10006)

	return
end

function var_0_1.SetCallback(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.onShowFunc = arg_8_1
	arg_8_0.onHideFunc = arg_8_2

	return
end

function var_0_1.Hide(arg_9_0)
	var_0_1.super.Hide(arg_9_0)

	if arg_9_0.onHideFunc then
		arg_9_0.onHideFunc()
	end

	return
end

function var_0_1.Show(arg_10_0, arg_10_1)
	var_0_1.super.Show(arg_10_0)

	arg_10_0.itemId = arg_10_1.itemId
	setText = var_2

	var_2(arg_10_0.content, arg_10_1.content)
	arg_10_0:UpdateItem()
	arg_10_0:UpdateResource()

	if arg_10_0.onShowFunc then
		arg_10_0.onShowFunc()
	end

	return
end

function var_0_1.UpdateItem(arg_11_0)
	local var_11_0 = arg_11_0.itemId

	Drop = var_1_10002

	local var_11_1 = var_1_10002.Create
	local var_11_2 = {
		nil,
		nil,
		1
	}

	DROP_TYPE_ITEM = var_1_10005
	var_11_2[1] = var_1_10005
	var_11_2[2] = var_11_0

	local var_11_3 = var_11_1(var_11_2)

	updateDrop = var_1_10003

	var_1_10003(arg_11_0.itemTpl, var_11_3)

	local var_11_4 = arg_11_0.itemName

	shortenString = var_11_2
	var_11_4.text = var_11_2(var_11_3:getName(), 5)

	return
end

function var_0_1.UpdateResource(arg_12_0)
	local var_12_0 = arg_12_0.itemId

	Item = var_1_10002

	local var_12_1 = var_1_10002.New({
		id = var_12_0
	})
	local var_12_2

	if not var_2.GetPrice(var_12_1) then
		var_12_2 = {
			1,
			0
		}
	end

	Drop = var_4

	local var_12_3 = var_4.Create
	local var_12_4 = {}

	DROP_TYPE_RESOURCE = var_1_10007
	var_12_4[1] = var_1_10007
	var_12_4[2] = var_12_2[1]
	var_12_4[3] = var_12_2[2]

	local var_12_5 = var_12_3(var_12_4)

	updateDrop = var_12_1

	var_12_1(arg_12_0.resTpl, var_12_5)

	local var_12_6 = arg_12_0.resName

	shortenString = var_12_4
	var_12_6.text = var_12_4(var_12_5:getName(), 5)

	return
end

function var_0_1.OnDestroy(arg_13_0)
	arg_13_0:SetCallback(nil, nil)

	return
end

return var_0_1
