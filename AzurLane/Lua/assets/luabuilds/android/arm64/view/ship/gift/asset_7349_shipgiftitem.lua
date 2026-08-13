class = var_0_10000

local var_0_0 = "ShipGiftItem"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BasePanel"))

var_0_1.SELECT_ITEM = "ShipGiftItem::selectItem"
var_0_1.REFRESH_USE_ITEM_CNT = "ShipGiftItem::refreshUseItemCnt"

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1
	tf = var_1_10003
	arg_1_0._tf = var_1_10003(arg_1_1)
	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_1.Init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.item = var_1.Find(var_2_0, "IconTpl")

	local var_2_1 = arg_2_0._tf

	arg_2_0.nameText = var_1.Find(var_2_1, "name")

	local var_2_2 = arg_2_0._tf

	arg_2_0.valueText = var_1.Find(var_2_2, "numberTitle/value")

	local var_2_3 = arg_2_0._tf

	arg_2_0.useCntText = var_1.Find(var_2_3, "count/value")

	local var_2_4 = arg_2_0._tf

	arg_2_0.selectImg = var_1.Find(var_2_4, "select")

	local var_2_5 = arg_2_0._tf

	arg_2_0.countPanel = var_1.Find(var_2_5, "count")

	local var_2_6 = arg_2_0._tf

	arg_2_0.maxBtn = var_1.Find(var_2_6, "count/maxBtn")

	local var_2_7 = arg_2_0._tf

	arg_2_0.addBtn = var_1.Find(var_2_7, "count/addBtn")

	local var_2_8 = arg_2_0._tf

	arg_2_0.subtractBtn = var_1.Find(var_2_8, "count/subtractBtn")

	local var_2_9 = arg_2_0.item

	arg_2_0.favoriteTF = var_1.Find(var_2_9, "favorite")
	setText = var_1

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_3.Find(var_2_10, "numberTitle")

	i18n = var_4

	var_1(var_2_11, var_4("ship_gift_cnt"))

	pressPersistTrigger = var_1

	local var_2_12 = arg_2_0.addBtn
	local var_2_13 = 0.5

	local function var_2_14(arg_3_0)
		if arg_2_0.selectCnt >= arg_2_0.maxCnt then
			return
		end

		arg_2_0.selectCnt = arg_2_0.selectCnt + 1

		local var_3_0 = arg_2_0
		local var_3_1 = var_1.emit

		ShipGiftItem = var_2_10004

		var_3_1(var_3_0, var_2_10004.REFRESH_USE_ITEM_CNT, arg_2_0.selectCnt)

		local var_3_2 = arg_2_0

		var_1.RefreshUseCnt(var_3_2)

		return
	end

	local var_2_15
	local var_2_16 = true
	local var_2_17 = true
	local var_2_18 = 0.1

	SFX_PANEL = var_1_10010

	var_1(var_2_12, var_2_13, var_2_14, var_2_15, var_2_16, var_2_17, var_2_18, var_1_10010)

	pressPersistTrigger = var_1

	local var_2_19 = arg_2_0.subtractBtn
	local var_2_20 = 0.5

	local function var_2_21(arg_4_0)
		if arg_2_0.selectCnt <= (arg_2_0.itemVO.count > 0 and 1 or 0) then
			return
		end

		arg_2_0.selectCnt = arg_2_0.selectCnt - 1

		local var_4_0 = arg_2_0
		local var_4_1 = var_1.emit

		ShipGiftItem = var_2_10004

		var_4_1(var_4_0, var_2_10004.REFRESH_USE_ITEM_CNT, arg_2_0.selectCnt)

		local var_4_2 = arg_2_0

		var_1.RefreshUseCnt(var_4_2)

		return
	end

	local var_2_22
	local var_2_23 = true
	local var_2_24 = true
	local var_2_25 = 0.1

	SFX_PANEL = var_1_10010

	var_1(var_2_19, var_2_20, var_2_21, var_2_22, var_2_23, var_2_24, var_2_25, var_1_10010)

	onButton = var_1

	local var_2_26 = arg_2_0
	local var_2_27 = arg_2_0.maxBtn

	local function var_2_28()
		arg_2_0.selectCnt = arg_2_0.maxCnt

		local var_5_0 = arg_2_0
		local var_5_1 = var_0.emit

		ShipGiftItem = var_2_10003

		var_5_1(var_5_0, var_2_10003.REFRESH_USE_ITEM_CNT, arg_2_0.selectCnt)

		local var_5_2 = arg_2_0

		var_0.RefreshUseCnt(var_5_2)

		return
	end

	SFX_PANEL = var_2_22

	var_1(var_2_26, var_2_27, var_2_28, var_2_22)

	onButton = var_1

	local var_2_29 = arg_2_0
	local var_2_30 = arg_2_0.item

	local function var_2_31()
		local var_6_0 = arg_2_0
		local var_6_1 = var_0.emit

		BaseUI = var_2_10003

		var_6_1(var_6_0, var_2_10003.ON_ITEM, arg_2_0.itemVO.id)

		return
	end

	SFX_PANEL = var_2_22

	var_1(var_2_29, var_2_30, var_2_31, var_2_22)

	onButton = var_1

	local var_2_32 = arg_2_0
	local var_2_33 = arg_2_0._tf

	local function var_2_34()
		if arg_2_0.selectIndex == arg_2_0.index then
			return
		end

		local var_7_0 = arg_2_0
		local var_7_1 = var_0.emit

		ShipGiftItem = var_2_10003

		var_7_1(var_7_0, var_2_10003.SELECT_ITEM, arg_2_0.index)

		return
	end

	SFX_PANEL = var_2_22

	var_1(var_2_32, var_2_33, var_2_34, var_2_22)

	return
end

function var_0_1.didEnter(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	arg_8_0:RefreshData(arg_8_1, arg_8_2, arg_8_3, arg_8_4)

	updateItem = var_6

	var_6(arg_8_0.item, arg_8_2)

	setText = var_6

	var_6(arg_8_0.nameText, arg_8_2:getConfig("name"))

	setText = var_6

	local var_8_0 = arg_8_0.valueText
	local var_8_1

	if not arg_8_2.count then
		var_8_1 = 0
	end

	var_6(var_8_0, var_8_1)

	setActive = var_6
	findTF = var_8_0

	var_6(var_8_0(arg_8_0.item, "icon_bg/count"), false)

	ShipGiftTools = var_6

	local var_8_2 = var_6.GetItemFavoriteState(arg_8_1, arg_8_2)

	GetSpriteFromAtlas = var_1_10007

	local var_8_3 = "energy"

	ShipGiftTools = var_10

	local var_8_4 = var_1_10007(var_8_3, var_10.GetItemIntimacySpriteName(arg_8_1, arg_8_2))

	setImageSprite = var_8

	var_8(arg_8_0.favoriteTF, var_8_4)
	arg_8_0:RefreshSelect(arg_8_5, arg_8_4)

	return
end

function var_0_1.RefreshData(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	arg_9_0.shipVO = arg_9_1
	arg_9_0.index = arg_9_3
	arg_9_0.itemVO = arg_9_2
	arg_9_0.selectCnt = arg_9_4
	ShipGiftTools = var_1_10005
	arg_9_0.maxCnt = var_1_10005.GetNeedMaxCnt(arg_9_1, arg_9_2)

	return
end

function var_0_1.RefreshSelect(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.index == arg_10_1

	arg_10_0.selectIndex = arg_10_1
	setActive = var_1_10004

	var_1_10004(arg_10_0.selectImg, var_10_0)

	setActive = var_1_10004

	var_1_10004(arg_10_0.countPanel, var_10_0)

	arg_10_0.selectCnt = arg_10_2

	if var_10_0 == true then
		arg_10_0:RefreshUseCnt()
	end

	return
end

function var_0_1.RefreshUI(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0:RefreshSelect(arg_11_1, arg_11_2)

	return
end

function var_0_1.RefreshUseCnt(arg_12_0)
	if arg_12_0.selectCnt >= arg_12_0.maxCnt then
		arg_12_0.selectCnt = arg_12_0.maxCnt
		setGray = var_1

		var_1(arg_12_0.addBtn, true)
	else
		setGray = var_1

		var_1(arg_12_0.addBtn, false)
	end

	if arg_12_0.selectCnt <= (arg_12_0.itemVO.count > 0 and 1 or 0) then
		setGray = var_1

		var_1(arg_12_0.subtractBtn, true)
	else
		setGray = var_1

		var_1(arg_12_0.subtractBtn, false)
	end

	setText = var_1

	var_1(arg_12_0.useCntText, arg_12_0.selectCnt)

	return
end

function var_0_1.willExit(arg_13_0)
	return
end

function var_0_1.Dispose(arg_14_0)
	arg_14_0:detach()

	return
end

return var_0_1
