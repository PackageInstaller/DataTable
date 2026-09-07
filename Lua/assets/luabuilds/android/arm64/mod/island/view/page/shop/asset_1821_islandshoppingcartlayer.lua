local IslandShoppingCartLayer = class("IslandShoppingCartLayer", import("...base.IslandBasePage"))

function IslandShoppingCartLayer:getUIName()
	return "IslandShoppingCartUI"
end

function IslandShoppingCartLayer:OnLoaded()
	self.panel = self._tf:Find("panel")
	self.closeBtn = self.panel:Find("closeBtn")
	self.commodityList = self.panel:Find("commodityList/Viewport/Content")
	self.cancelBtn = self.panel:Find("cancelBtn")
	self.buyBtn = self.panel:Find("buyBtn")
	self.consumeIcon = self.buyBtn:Find("consume/icon")
	self.consumeCount = self.buyBtn:Find("consume/count")

	setText(self.panel:Find("title"), i18n("island_3Dshop_buy_confirm"))
	setText(self.cancelBtn:Find("text"), i18n("island_3Dshop_buy_return"))
	setText(self.buyBtn:Find("text"), i18n("island_3Dshop_buy"))

	for iter_2_0 = 1, 3 do
		setText(self.commodityList:Find("commodity" .. iter_2_0 .. "/normal/cost"), i18n("island_3Dshop_buy_price"))
		setText(self.commodityList:Find("commodity" .. iter_2_0 .. "/normal/have"), i18n("island_3Dshop_buy_have"))
	end

	return
end

function IslandShoppingCartLayer:OnInit()
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("bg"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.cancelBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function IslandShoppingCartLayer:SetUp(arg_7_1)
	local var_7_0
	local var_7_1
	local var_7_2 = 0

	if #arg_7_1[1]:GetItems() == 1 then
		for iter_7_0 = 1, 3 do
			local var_7_3 = self.commodityList:Find("commodity" .. iter_7_0)

			setActive(var_7_3:Find("normal"), iter_7_0 <= #arg_7_1)
			setActive(var_7_3:Find("nothing"), iter_7_0 > #arg_7_1)

			if iter_7_0 <= #arg_7_1 then
				GetImageSpriteFromAtlasAsync(arg_7_1[iter_7_0]:GetIcon(), "", var_7_3:Find("normal/IslandItemTpl/icon_bg/icon"))
				setText(var_7_3:Find("normal/name"), arg_7_1[iter_7_0]:GetName())
				setActive(var_7_3:Find("normal/count"), false)

				if #arg_7_1[iter_7_0]:GetItems() == 1 then
					if arg_7_1[iter_7_0]:GetItems()[1][1] == DROP_TYPE_ISLAND_FURNITURE then
						for iter_7_1, iter_7_2 in ipairs((getProxy(IslandProxy):GetIsland():GetAgoraAgency():GetFurnitures())) do
							if iter_7_2.id == arg_7_1[iter_7_0]:GetItems()[1][2] then
								break
							end
						end

						setActive(var_7_3:Find("normal/count"), true)
						setText(var_7_3:Find("normal/count"), i18n("island_3Dshop_no_have", 0))
					elseif arg_7_1[iter_7_0]:GetItems()[1][1] == DROP_TYPE_ISLAND_DRESS then
						local var_7_5 = arg_7_1[iter_7_0]:GetItems()[1][2]

						if pg.island_dress_template[var_7_5].belongto == 2 then
							local var_7_6 = getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetOwnDressCountByDressId(var_7_5)

							setActive(var_7_3:Find("normal/count"), true)
							setText(var_7_3:Find("normal/count"), i18n("island_3Dshop_no_have", var_7_6))
						end
					end
				end

				local var_7_7 = arg_7_1[iter_7_0]:GetResourceConsume()

				GetImageSpriteFromAtlasAsync(Drop.New({
					type = var_7_7[1],
					id = var_7_7[2]
				}):getIcon(), "", var_7_3:Find("normal/consumeIcon"))
				setText(var_7_3:Find("normal/consumeNum"), var_7_7[3])

				var_7_0 = var_7_7[1]
				var_7_1 = var_7_7[2]
				var_7_2 = var_7_2 + var_7_7[3]

				setActive(var_7_3:Find("normal/cost"), true)
				setActive(var_7_3:Find("normal/consumeIcon"), true)
				setActive(var_7_3:Find("normal/have"), false)
			end
		end
	elseif arg_7_1[1]:GetItems()[1][1] == DROP_TYPE_ISLAND_DRESS then
		local var_7_8 = arg_7_1[1]:GetDisplayItems()

		for iter_7_3 = 1, 3 do
			local var_7_9 = self.commodityList:Find("commodity" .. iter_7_3)

			setActive(var_7_9:Find("normal"), iter_7_3 <= #var_7_8)
			setActive(var_7_9:Find("nothing"), iter_7_3 > #var_7_8)

			if iter_7_3 <= #var_7_8 then
				GetImageSpriteFromAtlasAsync(Drop.New({
					type = DROP_TYPE_ISLAND_DRESS,
					id = var_7_8[iter_7_3][2]
				}):getIcon(), "", var_7_9:Find("normal/IslandItemTpl/icon_bg/icon"))
				setText(var_7_9:Find("normal/name"), pg.island_dress_template[var_7_8[iter_7_3][2]].name)
				setActive(var_7_9:Find("normal/count"), false)

				local var_7_10 = 0

				if pg.island_dress_template[var_7_8[iter_7_3][2]].belongto == 1 then
					var_7_10 = getProxy(IslandProxy):GetIsland():GetDressUpAgency():CheckOwnDress(var_7_8[iter_7_3][2]) and 1 or 0
				elseif pg.island_dress_template[var_7_8[iter_7_3][2]].belongto == 2 then
					var_7_10 = getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetOwnDressCountByDressId(var_7_8[iter_7_3][2])
				end

				setText(var_7_9:Find("normal/consumeNum"), var_7_10)
				setActive(var_7_9:Find("normal/cost"), false)
				setActive(var_7_9:Find("normal/consumeIcon"), false)
				setActive(var_7_9:Find("normal/have"), true)
			end
		end

		local var_7_11 = arg_7_1[1]:GetResourceConsume()

		var_7_0 = var_7_11[1]
		var_7_1 = var_7_11[2]
		var_7_2 = var_7_11[3]
	end

	GetImageSpriteFromAtlasAsync(Drop.New({
		type = var_7_0,
		id = var_7_1
	}):getIcon(), "", self.consumeIcon)
	setText(self.consumeCount, var_7_2)
	onButton(self, self.buyBtn, function()
		local var_8_0 = {}

		for iter_8_0, iter_8_1 in ipairs(arg_7_1) do
			table.insert(var_8_0, {
				value2 = 1,
				key = iter_8_1.shopId,
				value1 = iter_8_1.id
			})
		end

		self:emit(IslandMediator.BUY_COMMODITY, var_8_0)

		return
	end, SFX_PANEL)

	return
end

function IslandShoppingCartLayer:Refresh()
	self:SetUp(self.commodities)

	return
end

function IslandShoppingCartLayer:OnShow(arg_10_1)
	self:BlurPanel(self._tf)

	self.commodities = arg_10_1

	self:SetUp(self.commodities)

	return
end

function IslandShoppingCartLayer:OnHide()
	self:UnOverlayPanel(self._tf, self._parentTf)

	return
end

function IslandShoppingCartLayer:OnDestroy()
	return
end

return IslandShoppingCartLayer
