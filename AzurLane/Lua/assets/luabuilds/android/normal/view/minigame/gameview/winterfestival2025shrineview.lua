class = var_0_10000

local var_0_0 = "WinterFestival2025ShrineView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".Shrine2022View"))

WinterFestival2025ShrineSelectShipView = var_0_0
var_0_1.SHRINE_SELECT_SHIP_VIEW_CLS = var_0_0
WinterFestival2025ShrineShipWordView = var_0_0
var_0_1.SHRINE_SHIP_WORD_VIEW_CLS = var_0_0
WinterFestival2025ShrineSelectBuffView = var_0_0
var_0_1.SHRINE_SELECT_BUFF_VIEW_CLS = var_0_0

function var_0_1.getUIName(arg_1_0)
	return "WinterFestival2025ShrineUI"
end

function var_0_1.setUIData(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "Res")

	getImageSprite = var_2_0

	local var_2_2 = var_2_0(var_2_1:Find("CurBuff1"))

	getImageSprite = var_3

	local var_2_3 = var_3(var_2_1:Find("CurBuff2"))

	getImageSprite = var_4

	local var_2_4 = var_4(var_2_1:Find("CurBuff3"))

	arg_2_0.curBuffSpriteList = {
		var_2_2,
		var_2_3,
		var_2_4
	}
	arg_2_0.shipCardSpriteList = {}

	for iter_2_0 = 1, 7 do
		getImageSprite = var_1_10009
		var_1_10009 = var_1_10009(var_2_1:Find("ShipCard" .. iter_2_0))
		table = var_10

		var_10.insert(arg_2_0.shipCardSpriteList, var_1_10009)
	end

	arg_2_0.shipNameSpriteList = {}

	for iter_2_1 = 1, 7 do
		getImageSprite = var_1_10009
		var_1_10009 = var_1_10009(var_2_1:Find("ShipName" .. iter_2_1))
		table = var_10

		var_10.insert(arg_2_0.shipNameSpriteList, var_1_10009)
	end

	local var_2_5 = {}

	Ship = var_6
	var_2_5[1] = var_6.getShipName(19)
	Ship = var_6
	var_2_5[2] = var_6.getShipName(105141)
	Ship = var_6
	var_2_5[3] = var_6.getShipName(702051)
	Ship = var_6
	var_2_5[4] = var_6.getShipName(607021)
	Ship = var_6
	var_2_5[5] = var_6.getShipName(9)
	Ship = var_6
	var_2_5[6] = var_6.getShipName(19)
	Ship = var_6
	var_2_5[7] = var_6.getShipName(407011)
	arg_2_0.shipNameTextList = var_2_5
	arg_2_0.curBuffPosStart = 217
	arg_2_0.curBuffPosEnd = -130
	setText = var_5

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_6.Find(var_2_6, "Data/Count2")

	i18n = var_2_6

	var_5(var_2_7, var_2_6("winterwish_20251225_tip1"))

	setText = var_5

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_6.Find(var_2_8, "Data/Count/Tip")

	i18n = var_2_8

	var_5(var_2_9, var_2_8("winterwish_20251225_tip2"))

	local var_2_10 = arg_2_0._tf

	arg_2_0.countText = var_5.Find(var_2_10, "Data/Count/Text")

	local var_2_11 = arg_2_0._tf

	arg_2_0.countText2 = var_5.Find(var_2_11, "Data/Count2/BG/Text")

	return
end

function var_0_1.updateShipCardUI(arg_3_0, arg_3_1, arg_3_2)
	var_0_1.super.updateShipCardUI(arg_3_0, arg_3_1, arg_3_2)

	local var_3_0 = arg_3_1
	local var_3_1 = arg_3_1.Find(var_3_0, "NameMask/NameText")

	setScrollText = var_3_0

	var_3_0(var_3_1, arg_3_0.shipNameTextList[arg_3_2])

	return
end

return var_0_1
