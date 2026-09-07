local AuctionGameStoreItem = class("AuctionGameStoreItem", import("view.base.BasePanel"))

function AuctionGameStoreItem:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject

	AuctionGameStoreItem.super.Ctor(self, self._go)

	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()

	return
end

function AuctionGameStoreItem:Init()
	setActive(self.uiCoutourGo, false)
	setActive(self.uiRarityGo, false)
	setActive(self.uiIconImage, false)
	setActive(self.uiPosGo, false)
	onButton(self, self.uiBtn, function()
		if pg.NewGuideMgr.GetInstance():IsBusy() then
			return
		end

		self:OnClickItem()

		return
	end, SFX_PANEL)

	self.contourList = UIItemList.New(self.uiContourParent, self.uiContourItem)

	self.contourList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			-- block empty
		end

		return
	end)

	return
end

function AuctionGameStoreItem:didEnter(arg_5_1)
	self:ShowSize(arg_5_1)

	self._tf.name = arg_5_1.uid

	if arg_5_1.id and arg_5_1.id ~= 0 then
		if self.data and self.data.id == arg_5_1.id then
			return
		end

		setActive(self.uiIconImage, false)
		setActive(self.uiPosGo, false)
		self:HideContour()
		self:ShowRarity(arg_5_1)

		local var_5_0 = AuctionGameTools.GetRevealItemEffectName(arg_5_1.id)

		PoolMgr.GetInstance():GetPrefab(var_5_0, "", true, function(arg_6_0)
			if not IsNil(self._go) then
				self.effectGo = arg_6_0

				setParent(arg_6_0, self._tf)
				setActive(arg_6_0, true)
				LoadSpriteAsync(pg.auction_collection[arg_5_1.id].icon, function(arg_7_0)
					if not IsNil(self.uiIconImage) then
						self.uiIconImage.sprite = arg_7_0

						setActive(self.uiIconImage, true)
					end

					return
				end)
				setActive(self._go, true)
			else
				PoolMgr.GetInstance():ReturnPrefab(var_5_0, "", arg_6_0, true)
			end

			return
		end)
	else
		setActive(self.uiPosGo, false)

		if arg_5_1.showRarity then
			self:ShowRarity(arg_5_1)
			self:HideContour()
		elseif arg_5_1.showContour then
			self:ShowContour(arg_5_1)
		end

		if not arg_5_1.showContour and not arg_5_1.showRarity and arg_5_1.showPos then
			setActive(self.uiPosGo, true)
		end

		setActive(self._go, true)
	end

	self.data = arg_5_1

	return
end

function AuctionGameStoreItem:OnClickItem()
	if self.data == nil then
		return
	end

	if self.data.id and self.data.id ~= 0 then
		self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = AuctionGameCollectionInfoLayer,
			mediator = AuctionGameCollectionInfoMediator,
			data = {
				id = self.data.id
			}
		}))
	else
		self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = AuctionGameCollectionListLayer,
			mediator = AuctionGameCollectionListMediator,
			data = {
				rarityIndex = self.data.rarity,
				contour = (self.data.showContour or nil) and self.data.contour
			}
		}))
	end

	return
end

function AuctionGameStoreItem:ShowSize(arg_9_1)
	if arg_9_1.contour then
		self.uiItemTf.sizeDelta = Vector2(arg_9_1.contour[1] * AuctionGameConst.CELL_WIDTH, arg_9_1.contour[2] * AuctionGameConst.CELL_HEIGHT)
	end

	return
end

function AuctionGameStoreItem:ShowRarity(arg_10_1)
	setActive(self.uiRarityGo, true)

	if arg_10_1.showContour then
		setActive(self.uiRarityImage, true)
		setActive(self.uiRarityContourImage, false)
		LoadSpriteAtlasAsync("ui/auctiongameui_atlas", string.format("main_cell_item_rarity_%s", arg_10_1.rarity), function(arg_11_0)
			if not IsNil(self.uiRarityImage) then
				self.uiRarityImage.sprite = arg_11_0
			end

			return
		end)
	else
		setActive(self.uiRarityImage, false)
		setActive(self.uiRarityContourImage, true)
		LoadSpriteAtlasAsync("ui/auctiongameui_atlas", string.format("main_cell_item_contour_rarity_%s", arg_10_1.rarity), function(arg_12_0)
			if not IsNil(self.uiRarityContourImage) then
				self.uiRarityContourImage.sprite = arg_12_0
			end

			return
		end)
	end

	LoadSpriteAtlasAsync("ui/auctiongameui_atlas", string.format("main_cell_item_frame_rarity_%s", arg_10_1.rarity), function(arg_13_0)
		if not IsNil(self.uiRarityFrameImage) then
			self.uiRarityFrameImage.sprite = arg_13_0
		end

		return
	end)

	return
end

function AuctionGameStoreItem:ShowContour(arg_14_1)
	setActive(self.uiCoutourGo, true)
	self.contourList:align(arg_14_1.contour[1] * arg_14_1.contour[2])

	return
end

function AuctionGameStoreItem:HideContour()
	setActive(self.uiCoutourGo, false)

	return
end

function AuctionGameStoreItem:SetPosition(arg_16_1)
	self.uiItemTf.localPosition = arg_16_1

	return
end

function AuctionGameStoreItem:willExit()
	self:detach()

	if self.effectGo then
		PoolMgr.GetInstance():ReturnPrefab(AuctionGameTools.GetRevealItemEffectName(self.data.id), "", self.effectGo, true)
	end

	Object.Destroy(self._go)

	return
end

return AuctionGameStoreItem
