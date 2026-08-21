local var_0_0 = class("WinterFestival2025ShrineView", import(".Shrine2022View"))

var_0_0.SHRINE_SELECT_SHIP_VIEW_CLS = WinterFestival2025ShrineSelectShipView
var_0_0.SHRINE_SHIP_WORD_VIEW_CLS = WinterFestival2025ShrineShipWordView
var_0_0.SHRINE_SELECT_BUFF_VIEW_CLS = WinterFestival2025ShrineSelectBuffView

function var_0_0.getUIName(arg_1_0)
	return "WinterFestival2025ShrineUI"
end

function var_0_0.setUIData(arg_2_0)
	local var_2_0 = arg_2_0._tf:Find("Res")

	arg_2_0.curBuffSpriteList = {
		getImageSprite(var_2_0:Find("CurBuff1")),
		getImageSprite(var_2_0:Find("CurBuff2")),
		(getImageSprite(var_2_0:Find("CurBuff3")))
	}
	arg_2_0.shipCardSpriteList = {}

	for iter_2_0 = 1, 7 do
		table.insert(arg_2_0.shipCardSpriteList, (getImageSprite(var_2_0:Find("ShipCard" .. iter_2_0))))
	end

	arg_2_0.shipNameSpriteList = {}

	for iter_2_1 = 1, 7 do
		table.insert(arg_2_0.shipNameSpriteList, (getImageSprite(var_2_0:Find("ShipName" .. iter_2_1))))
	end

	arg_2_0.shipNameTextList = {
		Ship.getShipName(19),
		Ship.getShipName(105141),
		Ship.getShipName(702051),
		Ship.getShipName(607021),
		Ship.getShipName(9),
		Ship.getShipName(19),
		Ship.getShipName(407011)
	}
	arg_2_0.curBuffPosStart = 217
	arg_2_0.curBuffPosEnd = -130

	setText(arg_2_0._tf:Find("Data/Count2"), i18n("winterwish_20251225_tip1"))
	setText(arg_2_0._tf:Find("Data/Count/Tip"), i18n("winterwish_20251225_tip2"))

	arg_2_0.countText = arg_2_0._tf:Find("Data/Count/Text")
	arg_2_0.countText2 = arg_2_0._tf:Find("Data/Count2/BG/Text")

	return
end

function var_0_0.updateShipCardUI(arg_3_0, arg_3_1, arg_3_2)
	var_0_0.super.updateShipCardUI(arg_3_0, arg_3_1, arg_3_2)
	setScrollText(arg_3_1:Find("NameMask/NameText"), arg_3_0.shipNameTextList[arg_3_2])

	return
end

return var_0_0
