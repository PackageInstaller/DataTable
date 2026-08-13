class = var_0_10000

local var_0_0 = "WinterFestival2025ShrineSelectShipView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".Shrine2022SelectShipView"))

function var_0_1.getUIName(arg_1_0)
	return "WinterFestival2025ShrineSelectShipUI"
end

function var_0_1.setUIData(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "Res")

	arg_2_0.shipCardSpriteList = {}

	for iter_2_0 = 1, 7 do
		getImageSprite = var_1_10006
		var_1_10006 = var_1_10006(var_2_1:Find("ShipCard" .. iter_2_0))
		table = var_1_10007

		var_1_10007.insert(arg_2_0.shipCardSpriteList, var_1_10006)
	end

	arg_2_0.shipNameSpriteList = {}

	for iter_2_1 = 1, 7 do
		getImageSprite = var_1_10006
		var_1_10006 = var_1_10006(var_2_1:Find("ShipName" .. iter_2_1))
		table = var_1_10007

		var_1_10007.insert(arg_2_0.shipNameSpriteList, var_1_10006)
	end

	local var_2_2 = {}

	Ship = var_3
	var_2_2[1] = var_3.getShipName(19)
	Ship = var_3
	var_2_2[2] = var_3.getShipName(105141)
	Ship = var_3
	var_2_2[3] = var_3.getShipName(702051)
	Ship = var_3
	var_2_2[4] = var_3.getShipName(607021)
	Ship = var_3
	var_2_2[5] = var_3.getShipName(9)
	Ship = var_3
	var_2_2[6] = var_3.getShipName(19)
	Ship = var_3
	var_2_2[7] = var_3.getShipName(407011)
	arg_2_0.shipNameTextList = var_2_2
	arg_2_0.cardPosList = {
		{
			x = -75.5,
			y = 290
		},
		{
			x = -75.5,
			y = 67.5
		},
		{
			x = -75.5,
			y = -155
		},
		{
			x = -75.5,
			y = -377.5
		},
		{
			x = 82,
			y = 290
		},
		{
			x = 82,
			y = 67.5
		},
		{
			x = 82,
			y = -155
		}
	}
	arg_2_0.confirmPosList = {
		{
			x = -372,
			y = 15
		},
		{
			x = -75,
			y = 15
		},
		{
			x = 226,
			y = 15
		},
		{
			x = 523,
			y = 15
		},
		{
			x = -224,
			y = -350
		},
		{
			x = 80,
			y = -350
		},
		{
			x = 380,
			y = -350
		}
	}

	return
end

function var_0_1.updateShipCardUI(arg_3_0, arg_3_1, arg_3_2)
	setImageSprite = var_1_10003

	var_1_10003(arg_3_1, arg_3_0.shipCardSpriteList[arg_3_2], true)

	local var_3_0 = arg_3_1
	local var_3_1 = arg_3_1.Find(var_3_0, "Name")

	setActive = var_1_10004

	var_1_10004(var_3_1, false)

	local var_3_2 = arg_3_1:Find("NameMask/Name_Text")

	setScrollText = var_3_0

	var_3_0(var_3_2, arg_3_0.shipNameTextList[arg_3_2])

	setLocalPosition = var_3_0

	var_3_0(arg_3_1, arg_3_0.cardPosList[arg_3_2])

	local var_3_3 = arg_3_1
	local var_3_4 = arg_3_1.Find(var_3_3, "Selected")
	local var_3_5 = arg_3_0:isSelected(arg_3_2)

	setActive = var_3_3

	var_3_3(var_3_4, var_3_5)

	setActive = var_3_3

	var_3_3(var_3_2, not var_3_5)

	GetComponent = var_3_3
	var_3_3(arg_3_1, "Toggle").enabled = not var_3_5

	return
end

return var_0_1
