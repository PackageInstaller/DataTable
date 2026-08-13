class = var_0_10000

local var_0_0 = "AuctionGameStoreItem"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BasePanel"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_1.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_1.Init(arg_2_0)
	setActive = var_1_10001

	var_1_10001(arg_2_0.uiCoutourGo, false)

	setActive = var_1_10001

	var_1_10001(arg_2_0.uiRarityGo, false)

	setActive = var_1_10001

	var_1_10001(arg_2_0.uiIconImage, false)

	setActive = var_1_10001

	var_1_10001(arg_2_0.uiPosGo, false)

	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.uiBtn

	local function var_2_2()
		pg = var_2_10000

		local var_3_0 = var_2_10000.NewGuideMgr.GetInstance()

		if var_0.IsBusy(var_3_0) then
			return
		end

		local var_3_1 = arg_2_0

		var_0.OnClickItem(var_3_1)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_2_0, var_2_1, var_2_2, var_1_10006)

	UIItemList = var_1_10001
	arg_2_0.contourList = var_1_10001.New(arg_2_0.uiContourParent, arg_2_0.uiContourItem)

	local var_2_3 = arg_2_0.contourList

	var_1.make(var_2_3, function(arg_4_0, arg_4_1, arg_4_2)
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventUpdate then
			-- block empty
		end

		return
	end)

	return
end

function var_0_1.didEnter(arg_5_0, arg_5_1)
	arg_5_0:ShowSize(arg_5_1)

	arg_5_0._tf.name = arg_5_1.uid

	local var_5_0

	if arg_5_1.id and arg_5_1.id ~= 0 then
		if arg_5_0.data and arg_5_0.data.id == arg_5_1.id then
			return
		end

		setActive = var_5_0

		var_5_0(arg_5_0.uiIconImage, false)

		setActive = var_5_0

		var_5_0(arg_5_0.uiPosGo, false)
		arg_5_0:HideContour()
		arg_5_0:ShowRarity(arg_5_1)

		AuctionGameTools = var_5_0
		var_5_0 = var_5_0.GetRevealItemEffectName(arg_5_1.id)
		PoolMgr = var_3

		local var_5_1 = var_3.GetInstance()

		var_3.GetPrefab(var_5_1, var_5_0, "", true, function(arg_6_0)
			IsNil = var_2_10001

			local var_6_0

			if not var_2_10001(arg_5_0._go) then
				var_6_0 = arg_5_0
				var_6_0.effectGo = arg_6_0
				setParent = var_6_0

				var_6_0(arg_6_0, arg_5_0._tf)

				setActive = var_6_0

				var_6_0(arg_6_0, true)

				pg = var_6_0
				var_6_0 = var_6_0.auction_collection[arg_5_1.id].icon
				LoadSpriteAsync = var_2

				var_2(var_6_0, function(arg_7_0)
					IsNil = var_3_10001

					if not var_3_10001(arg_5_0.uiIconImage) then
						local var_7_0 = arg_5_0.uiIconImage

						var_7_0.sprite = arg_7_0
						setActive = var_7_0

						var_7_0(arg_5_0.uiIconImage, true)
					end

					return
				end)

				setActive = var_2

				var_2(arg_5_0._go, true)
			else
				PoolMgr = var_6_0

				local var_6_1 = var_6_0.GetInstance()

				var_1.ReturnPrefab(var_6_1, var_5_0, "", arg_6_0, true)
			end

			return
		end)
	else
		setActive = var_5_0

		var_5_0(arg_5_0.uiPosGo, false)

		if arg_5_1.showRarity then
			arg_5_0:ShowRarity(arg_5_1)
			arg_5_0:HideContour()
		elseif arg_5_1.showContour then
			arg_5_0:ShowContour(arg_5_1)
		end

		if not arg_5_1.showContour and not arg_5_1.showRarity and arg_5_1.showPos then
			setActive = var_2

			var_2(arg_5_0.uiPosGo, true)
		end

		setActive = var_2

		var_2(arg_5_0._go, true)
	end

	arg_5_0.data = arg_5_1

	return
end

function var_0_1.OnClickItem(arg_8_0)
	if arg_8_0.data == nil then
		return
	end

	if var_1.id and var_1.id ~= 0 then
		local var_8_0 = arg_8_0
		local var_8_1 = arg_8_0.emit

		BaseUI = var_1_10005

		local var_8_2 = var_1_10005.ON_ADD_SUBLAYER

		Context = var_1_10006
		var_1_10006 = var_1_10006.New

		local var_8_3 = {}

		AuctionGameCollectionInfoLayer = var_1_10009
		var_8_3.viewComponent = var_1_10009
		AuctionGameCollectionInfoMediator = var_1_10009
		var_8_3.mediator = var_1_10009
		var_8_3.data = {
			id = var_1.id
		}

		var_8_1(var_8_0, var_8_2, var_1_10006(var_8_3))
	else
		local var_8_4

		if var_1.showContour then
			var_8_4 = var_1.contour
		end

		local var_8_5 = arg_8_0
		local var_8_6 = arg_8_0.emit

		BaseUI = var_1_10006

		local var_8_7 = var_1_10006.ON_ADD_SUBLAYER

		Context = var_1_10007

		local var_8_8 = var_1_10007.New
		local var_8_9 = {}

		AuctionGameCollectionListLayer = var_1_10010
		var_8_9.viewComponent = var_1_10010
		AuctionGameCollectionListMediator = var_1_10010
		var_8_9.mediator = var_1_10010
		var_8_9.data = {
			rarityIndex = var_1.rarity,
			contour = var_8_4
		}

		var_8_6(var_8_5, var_8_7, var_8_8(var_8_9))
	end

	return
end

function var_0_1.ShowSize(arg_9_0, arg_9_1)
	if arg_9_1.contour then
		local var_9_0 = arg_9_0.uiItemTf

		Vector2 = var_1_10003

		local var_9_1 = arg_9_1.contour[1]

		AuctionGameConst = var_1_10006

		local var_9_2 = var_9_1 * var_1_10006.CELL_WIDTH
		local var_9_3 = arg_9_1.contour[2]

		AuctionGameConst = var_1_10007
		var_9_0.sizeDelta = var_1_10003(var_9_2, var_9_3 * var_1_10007.CELL_HEIGHT)
	end

	return
end

function var_0_1.ShowRarity(arg_10_0, arg_10_1)
	setActive = var_1_10002

	var_1_10002(arg_10_0.uiRarityGo, true)

	if arg_10_1.showContour then
		setActive = var_2

		var_2(arg_10_0.uiRarityImage, true)

		setActive = var_2

		var_2(arg_10_0.uiRarityContourImage, false)

		LoadSpriteAtlasAsync = var_2

		local var_10_0 = "ui/auctiongameui_atlas"

		string = var_5

		var_2(var_10_0, var_5.format("main_cell_item_rarity_%s", arg_10_1.rarity), function(arg_11_0)
			IsNil = var_2_10001

			if not var_2_10001(arg_10_0.uiRarityImage) then
				arg_10_0.uiRarityImage.sprite = arg_11_0
			end

			return
		end)
	else
		setActive = var_2

		var_2(arg_10_0.uiRarityImage, false)

		setActive = var_2

		var_2(arg_10_0.uiRarityContourImage, true)

		LoadSpriteAtlasAsync = var_2

		local var_10_1 = "ui/auctiongameui_atlas"

		string = var_5

		var_2(var_10_1, var_5.format("main_cell_item_contour_rarity_%s", arg_10_1.rarity), function(arg_12_0)
			IsNil = var_2_10001

			if not var_2_10001(arg_10_0.uiRarityContourImage) then
				arg_10_0.uiRarityContourImage.sprite = arg_12_0
			end

			return
		end)
	end

	LoadSpriteAtlasAsync = var_2

	local var_10_2 = "ui/auctiongameui_atlas"

	string = var_5

	var_2(var_10_2, var_5.format("main_cell_item_frame_rarity_%s", arg_10_1.rarity), function(arg_13_0)
		IsNil = var_2_10001

		if not var_2_10001(arg_10_0.uiRarityFrameImage) then
			arg_10_0.uiRarityFrameImage.sprite = arg_13_0
		end

		return
	end)

	return
end

function var_0_1.ShowContour(arg_14_0, arg_14_1)
	setActive = var_1_10002

	var_1_10002(arg_14_0.uiCoutourGo, true)

	local var_14_0 = arg_14_0.contourList

	var_2.align(var_14_0, arg_14_1.contour[1] * arg_14_1.contour[2])

	return
end

function var_0_1.HideContour(arg_15_0)
	setActive = var_1_10001

	var_1_10001(arg_15_0.uiCoutourGo, false)

	return
end

function var_0_1.SetPosition(arg_16_0, arg_16_1)
	arg_16_0.uiItemTf.localPosition = arg_16_1

	return
end

function var_0_1.willExit(arg_17_0)
	arg_17_0:detach()

	local var_17_1

	if arg_17_0.effectGo then
		PoolMgr = var_17_1

		local var_17_0 = var_17_1.GetInstance()

		var_17_1 = var_17_1.ReturnPrefab
		AuctionGameTools = var_1_10004

		var_17_1(var_17_0, var_1_10004.GetRevealItemEffectName(arg_17_0.data.id), "", arg_17_0.effectGo, true)
	end

	Object = var_17_1

	var_17_1.Destroy(arg_17_0._go)

	return
end

return var_0_1
