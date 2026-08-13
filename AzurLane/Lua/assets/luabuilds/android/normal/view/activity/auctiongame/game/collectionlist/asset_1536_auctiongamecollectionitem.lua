class = var_0_10000

local var_0_0 = "AuctionGameCollectionItem"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BasePanel"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_1.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_1.Init(arg_2_0)
	return
end

function var_0_1.didEnter(arg_3_0, arg_3_1)
	if arg_3_0.id == arg_3_1 then
		return
	end

	arg_3_0.id = arg_3_1
	pg = var_2

	local var_3_0 = var_2.auction_collection[arg_3_1]

	setScrollText = var_1_10003

	var_1_10003(arg_3_0.uiNameText, var_3_0.name)

	setText = var_1_10003

	local var_3_1 = arg_3_0.uiPriceText

	StringHelper = var_5

	var_1_10003(var_3_1, var_5.ForamtNumber(var_3_0.value))

	local var_3_2 = arg_3_0.uiIconImage

	var_3_2.sprite = nil
	setActive = var_3_2

	var_3_2(arg_3_0.uiIconImage, false)

	LoadSpriteAsync = var_3_2

	var_3_2(var_3_0.icon, function(arg_4_0)
		IsNil = var_2_10001

		if not var_2_10001(arg_3_0.uiIconImage) then
			local var_4_0 = arg_3_0.uiIconImage

			var_4_0.sprite = arg_4_0
			setActive = var_4_0

			var_4_0(arg_3_0.uiIconImage, true)
		end

		return
	end)

	LoadSpriteAtlasAsync = var_3_2

	local var_3_3 = "ui/auctiongameui_atlas"

	string = var_5

	var_3_2(var_3_3, var_5.format("rarity%s", var_3_0.rarity), function(arg_5_0)
		IsNil = var_2_10001

		if not var_2_10001(arg_3_0.uiRarityImage) then
			arg_3_0.uiRarityImage.sprite = arg_5_0
		end

		return
	end)

	local var_3_4 = var_3_0.contour[1]
	local var_3_5 = var_3_0.contour[2]

	for iter_3_0 = 1, 9 do
		math = var_1_10009
		var_1_10009 = var_1_10009.ceil(iter_3_0 / 3) <= var_3_5 and (iter_3_0 - 1) % 3 + 1 <= var_3_4
		setActive = var_10
		string = var_1_10011

		var_10(arg_3_0[var_1_10011.format("uiContourItem%s", iter_3_0)], var_1_10009)
	end

	return
end

function var_0_1.ShowLockState(arg_6_0)
	getProxy = var_1_10001
	AuctionGameBaseProxy = var_1_10002

	local var_6_0 = var_1_10001(var_1_10002)
	local var_6_1 = var_1.GetUnlockCollectionList(var_6_0)

	table = var_6_0

	local var_6_2 = var_6_0.keyof(var_6_1, arg_6_0.id) ~= nil

	setActive = var_4

	var_4(arg_6_0.uiLockGo, not var_6_2)

	return
end

function var_0_1.willExit(arg_7_0)
	arg_7_0:detach()

	return
end

return var_0_1
