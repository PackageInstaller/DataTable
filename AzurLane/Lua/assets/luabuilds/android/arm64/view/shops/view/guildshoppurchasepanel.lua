local var_0_0 = class("GuildShopPurchasePanel", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "GuildShopPurchaseMsgUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.list = UIItemList.New(arg_2_0._tf:Find("got/bottom/scroll/list"), arg_2_0._tf:Find("got/bottom/scroll/list/tpl"))
	arg_2_0.confirmBtn = arg_2_0._tf:Find("confirm")
	arg_2_0.descTxt = arg_2_0._tf:Find("got/top/desc"):GetComponent(typeof(Text))
	arg_2_0.exchagneCnt = arg_2_0._tf:Find("got/top/exchange/Text"):GetComponent(typeof(Text))
	arg_2_0.consumeCnt = arg_2_0._tf:Find("confirm/consume/Text"):GetComponent(typeof(Text))
	arg_2_0.title = arg_2_0._tf:Find("got/top/title")

	setText(arg_2_0._tf:Find("got/top/exchange/label"), i18n("guild_shop_label_2"))
	setText(arg_2_0._tf:Find("confirm/Text"), i18n("guild_shop_label_3"))
	setText(arg_2_0._tf:Find("confirm/consume/label"), i18n("guild_shop_label_4"))

	arg_2_0.resIcon = arg_2_0._tf:Find("confirm/consume/icon")

	arg_2_0:Hide()

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.confirmBtn, function()
		if #arg_3_0.selectedList == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_shop_must_select_goods"))

			return
		end

		arg_3_0:OnConfirm()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnConfirm(arg_6_0)
	arg_6_0:emit(NewShopMainMediator.ON_GUILD_SHOPPING, arg_6_0.data.id, arg_6_0.selectedList)

	return
end

function var_0_0.Show(arg_7_0, arg_7_1)
	var_0_0.super.Show(arg_7_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_7_0._tf)

	arg_7_0.data = arg_7_1
	arg_7_0.maxCnt = arg_7_1.count
	arg_7_0.selectedList = {}

	arg_7_0:InitList()
	arg_7_0:UpdateValue()

	if arg_7_1.type == 4 then
		setText(arg_7_0.title, i18n("guild_shop_label_5"))
	else
		setText(arg_7_0.title, i18n("guild_shop_label_1"))
	end

	arg_7_0.descTxt.text = ""

	return
end

function var_0_0.UpdateValue(arg_8_0)
	if arg_8_0.maxCnt - #arg_8_0.selectedList > 0 then
		local var_8_0 = "<color=#92FC63FF>" .. arg_8_0.maxCnt - #arg_8_0.selectedList .. "</color>/" or "<color=#FF5C5CFF>" .. arg_8_0.maxCnt - #arg_8_0.selectedList .. "</color>/"

		arg_8_0.exchagneCnt.text = var_8_0 .. arg_8_0.maxCnt

		setActive(arg_8_0._tf:Find("got/top/exchange"), arg_8_0.maxCnt ~= 0)

		arg_8_0.consumeCnt.text = arg_8_0.data.price * #arg_8_0.selectedList

		return
	end
end

function var_0_0.InitList(arg_9_0)
	arg_9_0.displays = arg_9_0.data.displays

	arg_9_0.list:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			arg_9_0:UpdateItem(var_0, arg_9_0.displays[arg_10_1 + 1], arg_10_2)
		end

		return
	end)
	arg_9_0.list:align(#arg_9_0.displays)

	return
end

function var_0_0.UpdateItem(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	updateDrop(arg_11_3:Find("item/bg"), {
		type = arg_11_1.type,
		id = arg_11_2,
		count = arg_11_1.num
	})
	arg_11_3:Find("name_bg/Text"):GetComponent("ScrollText"):SetText((Drop.New({
		type = arg_11_1.type,
		id = arg_11_2
	}):getConfig("name")))

	local var_11_0 = arg_11_3:Find("cnt/Text"):GetComponent(typeof(Text))

	local function var_11_1()
		local var_12_0 = 0

		for iter_12_0, iter_12_1 in ipairs(arg_11_0.selectedList) do
			if iter_12_1 == arg_11_2 then
				var_12_0 = var_12_0 + 1
			end
		end

		var_11_0.text = var_12_0

		return
	end

	onButton(arg_11_0, arg_11_3, function()
		arg_11_0:ClickItem(arg_11_3, arg_11_2)

		return
	end, SFX_PANEL)
	pressPersistTrigger(arg_11_3:Find("cnt/minus"), 0.5, function()
		arg_11_0:PressMinusBtn(arg_11_3, arg_11_2)
		var_11_1()

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	pressPersistTrigger(arg_11_3:Find("cnt/add"), 0.5, function()
		arg_11_0:PressAddBtn(arg_11_3, arg_11_2)
		var_11_1()

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	setActive(arg_11_3:Find("mask"), false)
	;(function()
		local var_12_0 = 0

		for iter_12_0, iter_12_1 in ipairs(arg_11_0.selectedList) do
			if iter_12_1 == arg_11_2 then
				var_12_0 = var_12_0 + 1
			end
		end

		var_11_0.text = var_12_0

		return
	end)()

	return
end

function var_0_0.ClearZeroItem(arg_16_0, arg_16_1)
	arg_16_0.list:each(function(arg_17_0, arg_17_1)
		if arg_16_1 ~= arg_17_1 and not table.contains(arg_16_0.selectedList, arg_16_0.displays[arg_17_0 + 1]) then
			setActive(arg_17_1:Find("cnt"), false)
			setActive(arg_17_1:Find("selected"), false)
		end

		return
	end)

	return
end

function var_0_0.ClickItem(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0:ClearZeroItem(arg_18_1)
	setActive(arg_18_1:Find("cnt"), true)
	setActive(arg_18_1:Find("selected"), true)

	return
end

function var_0_0.PressMinusBtn(arg_19_0, arg_19_1, arg_19_2)
	if #arg_19_0.selectedList == 0 then
		return
	end

	for iter_19_0, iter_19_1 in ipairs(arg_19_0.selectedList) do
		if iter_19_1 == arg_19_2 then
			table.remove(arg_19_0.selectedList, iter_19_0)

			break
		end
	end

	arg_19_0:UpdateValue()

	return
end

function var_0_0.PressAddBtn(arg_20_0, arg_20_1, arg_20_2)
	if #arg_20_0.selectedList == arg_20_0.maxCnt and arg_20_0.maxCnt ~= 0 then
		return
	end

	table.insert(arg_20_0.selectedList, arg_20_2)
	arg_20_0:UpdateValue()

	return
end

function var_0_0.Hide(arg_21_0)
	if arg_21_0:isShowing() then
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_21_0._tf, arg_21_0._parentTf)
	end

	arg_21_0.list:each(function(arg_22_0, arg_22_1)
		setActive(arg_22_1:Find("cnt"), false)
		setActive(arg_22_1:Find("selected"), false)

		return
	end)
	var_0_0.super.Hide(arg_21_0)

	return
end

function var_0_0.OnDestroy(arg_23_0)
	arg_23_0:Hide()

	return
end

return var_0_0
