local var_0_0 = class("AuctionGameStoreItem", import("view.base.BasePanel"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_0.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	setActive(arg_2_0.uiCoutourGo, false)
	setActive(arg_2_0.uiRarityGo, false)
	setActive(arg_2_0.uiIconImage, false)
	setActive(arg_2_0.uiPosGo, false)
	onButton(arg_2_0, arg_2_0.uiBtn, function()
		if pg.NewGuideMgr.GetInstance():IsBusy() then
			return
		end

		arg_2_0:OnClickItem()

		return
	end, SFX_PANEL)

	arg_2_0.contourList = UIItemList.New(arg_2_0.uiContourParent, arg_2_0.uiContourItem)

	arg_2_0.contourList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			-- block empty
		end

		return
	end)

	return
end

function var_0_0.didEnter(arg_5_0, arg_5_1)
	arg_5_0:ShowSize(arg_5_1)

	arg_5_0._tf.name = arg_5_1.uid

	if arg_5_1.id and arg_5_1.id ~= 0 then
		if arg_5_0.data and arg_5_0.data.id == arg_5_1.id then
			return
		end

		setActive(arg_5_0.uiIconImage, false)
		setActive(arg_5_0.uiPosGo, false)
		arg_5_0:HideContour()
		arg_5_0:ShowRarity(arg_5_1)
		PoolMgr.GetInstance():GetPrefab(AuctionGameTools.GetRevealItemEffectName(arg_5_1.id), "", true, function(arg_6_0)
			if not IsNil(arg_5_0._go) then
				arg_5_0.effectGo = arg_6_0

				setParent(arg_6_0, arg_5_0._tf)
				setActive(arg_6_0, true)
				LoadSpriteAsync(pg.auction_collection[arg_5_1.id].icon, function(arg_7_0)
					if not IsNil(arg_5_0.uiIconImage) then
						arg_5_0.uiIconImage.sprite = arg_7_0

						setActive(arg_5_0.uiIconImage, true)
					end

					return
				end)
				setActive(arg_5_0._go, true)
			else
				PoolMgr.GetInstance():ReturnPrefab(var_0, "", arg_6_0, true)
			end

			return
		end)
	else
		setActive(arg_5_0.uiPosGo, false)

		if arg_5_1.showRarity then
			arg_5_0:ShowRarity(arg_5_1)
			arg_5_0:HideContour()
		elseif arg_5_1.showContour then
			arg_5_0:ShowContour(arg_5_1)
		end

		if not arg_5_1.showContour and not arg_5_1.showRarity and arg_5_1.showPos then
			setActive(arg_5_0.uiPosGo, true)
		end

		setActive(arg_5_0._go, true)
	end

	arg_5_0.data = arg_5_1

	return
end

function var_0_0.OnClickItem(arg_8_0)
	if arg_8_0.data == nil then
		return
	end

	if arg_8_0.data.id and arg_8_0.data.id ~= 0 then
		arg_8_0:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = AuctionGameCollectionInfoLayer,
			mediator = AuctionGameCollectionInfoMediator,
			data = {
				id = arg_8_0.data.id
			}
		}))
	else
		local var_8_0

		if arg_8_0.data.showContour then
			var_8_0 = arg_8_0.data.contour
		end

		arg_8_0:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = AuctionGameCollectionListLayer,
			mediator = AuctionGameCollectionListMediator,
			data = {
				rarityIndex = arg_8_0.data.rarity,
				contour = var_8_0
			}
		}))
	end

	return
end

function var_0_0.ShowSize(arg_9_0, arg_9_1)
	if arg_9_1.contour then
		arg_9_0.uiItemTf.sizeDelta = Vector2(arg_9_1.contour[1] * AuctionGameConst.CELL_WIDTH, arg_9_1.contour[2] * AuctionGameConst.CELL_HEIGHT)
	end

	return
end

function var_0_0.ShowRarity(arg_10_0, arg_10_1)
	setActive(arg_10_0.uiRarityGo, true)

	if arg_10_1.showContour then
		setActive(arg_10_0.uiRarityImage, true)
		setActive(arg_10_0.uiRarityContourImage, false)
		LoadSpriteAtlasAsync("ui/auctiongameui_atlas", string.format("main_cell_item_rarity_%s", arg_10_1.rarity), function(arg_11_0)
			if not IsNil(arg_10_0.uiRarityImage) then
				arg_10_0.uiRarityImage.sprite = arg_11_0
			end

			return
		end)
	else
		setActive(arg_10_0.uiRarityImage, false)
		setActive(arg_10_0.uiRarityContourImage, true)
		LoadSpriteAtlasAsync("ui/auctiongameui_atlas", string.format("main_cell_item_contour_rarity_%s", arg_10_1.rarity), function(arg_12_0)
			if not IsNil(arg_10_0.uiRarityContourImage) then
				arg_10_0.uiRarityContourImage.sprite = arg_12_0
			end

			return
		end)
	end

	LoadSpriteAtlasAsync("ui/auctiongameui_atlas", string.format("main_cell_item_frame_rarity_%s", arg_10_1.rarity), function(arg_13_0)
		if not IsNil(arg_10_0.uiRarityFrameImage) then
			arg_10_0.uiRarityFrameImage.sprite = arg_13_0
		end

		return
	end)

	return
end

function var_0_0.ShowContour(arg_14_0, arg_14_1)
	setActive(arg_14_0.uiCoutourGo, true)
	arg_14_0.contourList:align(arg_14_1.contour[1] * arg_14_1.contour[2])

	return
end

function var_0_0.HideContour(arg_15_0)
	setActive(arg_15_0.uiCoutourGo, false)

	return
end

function var_0_0.SetPosition(arg_16_0, arg_16_1)
	arg_16_0.uiItemTf.localPosition = arg_16_1

	return
end

function var_0_0.willExit(arg_17_0)
	arg_17_0:detach()

	if arg_17_0.effectGo then
		PoolMgr.GetInstance():ReturnPrefab(AuctionGameTools.GetRevealItemEffectName(arg_17_0.data.id), "", arg_17_0.effectGo, true)
	end

	Object.Destroy(arg_17_0._go)

	return
end

return var_0_0
