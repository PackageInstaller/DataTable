local var_0_0 = class("ShipGiftItem", import("view.base.BasePanel"))

var_0_0.SELECT_ITEM = "ShipGiftItem::selectItem"
var_0_0.REFRESH_USE_ITEM_CNT = "ShipGiftItem::refreshUseItemCnt"

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = tf(arg_1_1)
	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	arg_2_0.item = arg_2_0._tf:Find("IconTpl")
	arg_2_0.nameText = arg_2_0._tf:Find("name")
	arg_2_0.valueText = arg_2_0._tf:Find("numberTitle/value")
	arg_2_0.useCntText = arg_2_0._tf:Find("count/value")
	arg_2_0.selectImg = arg_2_0._tf:Find("select")
	arg_2_0.countPanel = arg_2_0._tf:Find("count")
	arg_2_0.maxBtn = arg_2_0._tf:Find("count/maxBtn")
	arg_2_0.addBtn = arg_2_0._tf:Find("count/addBtn")
	arg_2_0.subtractBtn = arg_2_0._tf:Find("count/subtractBtn")
	arg_2_0.favoriteTF = arg_2_0.item:Find("favorite")

	setText(arg_2_0._tf:Find("numberTitle"), i18n("ship_gift_cnt"))
	pressPersistTrigger(arg_2_0.addBtn, 0.5, function(arg_3_0)
		if arg_2_0.selectCnt >= arg_2_0.maxCnt then
			return
		end

		arg_2_0.selectCnt = arg_2_0.selectCnt + 1

		arg_2_0:emit(ShipGiftItem.REFRESH_USE_ITEM_CNT, arg_2_0.selectCnt)
		arg_2_0:RefreshUseCnt()

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	pressPersistTrigger(arg_2_0.subtractBtn, 0.5, function(arg_4_0)
		if arg_2_0.selectCnt <= (arg_2_0.itemVO.count > 0 and 1 or 0) then
			return
		end

		arg_2_0.selectCnt = arg_2_0.selectCnt - 1

		arg_2_0:emit(ShipGiftItem.REFRESH_USE_ITEM_CNT, arg_2_0.selectCnt)
		arg_2_0:RefreshUseCnt()

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.maxBtn, function()
		arg_2_0.selectCnt = arg_2_0.maxCnt

		arg_2_0:emit(ShipGiftItem.REFRESH_USE_ITEM_CNT, arg_2_0.selectCnt)
		arg_2_0:RefreshUseCnt()

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.item, function()
		arg_2_0:emit(BaseUI.ON_ITEM, arg_2_0.itemVO.id)

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0._tf, function()
		if arg_2_0.selectIndex == arg_2_0.index then
			return
		end

		arg_2_0:emit(ShipGiftItem.SELECT_ITEM, arg_2_0.index)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.didEnter(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	arg_8_0:RefreshData(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	updateItem(arg_8_0.item, arg_8_2)
	setText(arg_8_0.nameText, arg_8_2:getConfig("name"))

	local var_8_0 = arg_8_2.count or 0

	setText(arg_8_0.valueText, var_8_0)
	setActive(findTF(arg_8_0.item, "icon_bg/count"), false)

	local var_8_1 = ShipGiftTools.GetItemFavoriteState(arg_8_1, arg_8_2)

	setImageSprite(arg_8_0.favoriteTF, (GetSpriteFromAtlas("energy", ShipGiftTools.GetItemIntimacySpriteName(arg_8_1, arg_8_2))))
	arg_8_0:RefreshSelect(arg_8_5, arg_8_4)

	return
end

function var_0_0.RefreshData(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	arg_9_0.shipVO = arg_9_1
	arg_9_0.index = arg_9_3
	arg_9_0.itemVO = arg_9_2
	arg_9_0.selectCnt = arg_9_4
	arg_9_0.maxCnt = ShipGiftTools.GetNeedMaxCnt(arg_9_1, arg_9_2)

	return
end

function var_0_0.RefreshSelect(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.index == arg_10_1

	arg_10_0.selectIndex = arg_10_1

	setActive(arg_10_0.selectImg, var_10_0)
	setActive(arg_10_0.countPanel, var_10_0)

	arg_10_0.selectCnt = arg_10_2

	if var_10_0 == true then
		arg_10_0:RefreshUseCnt()
	end

	return
end

function var_0_0.RefreshUI(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0:RefreshSelect(arg_11_1, arg_11_2)

	return
end

function var_0_0.RefreshUseCnt(arg_12_0)
	if arg_12_0.selectCnt >= arg_12_0.maxCnt then
		arg_12_0.selectCnt = arg_12_0.maxCnt

		setGray(arg_12_0.addBtn, true)
	else
		setGray(arg_12_0.addBtn, false)
	end

	if arg_12_0.selectCnt <= (arg_12_0.itemVO.count > 0 and 1 or 0) then
		setGray(arg_12_0.subtractBtn, true)
	else
		setGray(arg_12_0.subtractBtn, false)
	end

	setText(arg_12_0.useCntText, arg_12_0.selectCnt)

	return
end

function var_0_0.willExit(arg_13_0)
	return
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0:detach()

	return
end

return var_0_0
