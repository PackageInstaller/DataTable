local var_0_0 = class("IslandShoppingCartLayer", import("...base.IslandBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandShoppingCartUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.panel = arg_2_0._tf:Find("panel")
	arg_2_0.closeBtn = arg_2_0.panel:Find("closeBtn")
	arg_2_0.commodityList = arg_2_0.panel:Find("commodityList/Viewport/Content")
	arg_2_0.cancelBtn = arg_2_0.panel:Find("cancelBtn")
	arg_2_0.buyBtn = arg_2_0.panel:Find("buyBtn")
	arg_2_0.consumeIcon = arg_2_0.buyBtn:Find("consume/icon")
	arg_2_0.consumeCount = arg_2_0.buyBtn:Find("consume/count")

	setText(arg_2_0.panel:Find("title"), i18n("island_3Dshop_buy_confirm"))
	setText(arg_2_0.cancelBtn:Find("text"), i18n("island_3Dshop_buy_return"))
	setText(arg_2_0.buyBtn:Find("text"), i18n("island_3Dshop_buy"))

	for iter_2_0 = 1, 3 do
		setText(arg_2_0.commodityList:Find("commodity" .. iter_2_0 .. "/normal/cost"), i18n("island_3Dshop_buy_price"))
		setText(arg_2_0.commodityList:Find("commodity" .. iter_2_0 .. "/normal/have"), i18n("island_3Dshop_buy_have"))
	end

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf:Find("bg"), function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.cancelBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.SetUp(arg_7_0, arg_7_1)
	local var_7_0
	local var_7_1
	local var_7_2 = 0

	if #arg_7_1[1]:GetItems() == 1 then
		for iter_7_0 = 1, 3 do
			local var_7_3 = arg_7_0.commodityList:Find("commodity" .. iter_7_0)

			setActive(var_7_3:Find("normal"), iter_7_0 <= #arg_7_1)
			setActive(var_7_3:Find("nothing"), iter_7_0 > #arg_7_1)

			if iter_7_0 <= #arg_7_1 then
				GetImageSpriteFromAtlasAsync(arg_7_1[iter_7_0]:GetIcon(), "", var_7_3:Find("normal/IslandItemTpl/icon_bg/icon"))
				setText(var_7_3:Find("normal/name"), arg_7_1[iter_7_0]:GetName())
				setActive(var_7_3:Find("normal/count"), false)

				if #arg_7_1[iter_7_0]:GetItems() == 1 then
					local var_7_4 = 0

					if arg_7_1[iter_7_0]:GetItems()[1][1] == DROP_TYPE_ISLAND_FURNITURE then
						local var_7_5 = getProxy(IslandProxy):GetIsland():GetAgoraAgency()

						for iter_7_1, iter_7_2 in ipairs((var_7_5:GetFurnitures())) do
							if iter_7_2.id == arg_7_1[iter_7_0]:GetItems()[1][2] then
								var_7_4 = iter_7_2.count

								break
							end
						end

						setActive(var_7_3:Find("normal/count"), true)
						setText(var_7_3:Find("normal/count"), i18n("island_3Dshop_no_have", var_7_4))
					elseif arg_7_1[iter_7_0]:GetItems()[1][1] == DROP_TYPE_ISLAND_DRESS then
						local var_7_6 = arg_7_1[iter_7_0]:GetItems()[1][2]

						if pg.island_dress_template[var_7_6].belongto == 2 then
							local var_7_7 = getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetOwnDressCountByDressId(var_7_6)

							setActive(var_7_3:Find("normal/count"), true)
							setText(var_7_3:Find("normal/count"), i18n("island_3Dshop_no_have", var_7_7))
						end
					end
				end

				local var_7_8 = arg_7_1[iter_7_0]:GetResourceConsume()
				local var_7_9 = Drop.New({
					type = var_7_8[1],
					id = var_7_8[2]
				}):getIcon()

				GetImageSpriteFromAtlasAsync(var_7_9, "", var_7_3:Find("normal/consumeIcon"))
				setText(var_7_3:Find("normal/consumeNum"), var_7_8[3])

				var_7_0 = var_7_8[1]
				var_7_1 = var_7_8[2]
				var_7_2 = var_7_2 + var_7_8[3]

				setActive(var_7_3:Find("normal/cost"), true)
				setActive(var_7_3:Find("normal/consumeIcon"), true)
				setActive(var_7_3:Find("normal/have"), false)
			end
		end
	elseif arg_7_1[1]:GetItems()[1][1] == DROP_TYPE_ISLAND_DRESS then
		local var_7_10 = arg_7_1[1]:GetDisplayItems()

		for iter_7_3 = 1, 3 do
			local var_7_11 = arg_7_0.commodityList:Find("commodity" .. iter_7_3)

			setActive(var_7_11:Find("normal"), iter_7_3 <= #var_7_10)
			setActive(var_7_11:Find("nothing"), iter_7_3 > #var_7_10)

			if iter_7_3 <= #var_7_10 then
				local var_7_12 = Drop.New({
					type = DROP_TYPE_ISLAND_DRESS,
					id = var_7_10[iter_7_3][2]
				}):getIcon()

				GetImageSpriteFromAtlasAsync(var_7_12, "", var_7_11:Find("normal/IslandItemTpl/icon_bg/icon"))
				setText(var_7_11:Find("normal/name"), pg.island_dress_template[var_7_10[iter_7_3][2]].name)
				setActive(var_7_11:Find("normal/count"), false)

				local var_7_13 = 0

				if pg.island_dress_template[var_7_10[iter_7_3][2]].belongto == 1 then
					local var_7_14 = getProxy(IslandProxy):GetIsland():GetDressUpAgency()

					var_7_13 = var_7_14:CheckOwnDress(var_7_10[iter_7_3][2]) and 1 or 0
				elseif pg.island_dress_template[var_7_10[iter_7_3][2]].belongto == 2 then
					var_7_13 = getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetOwnDressCountByDressId(var_7_10[iter_7_3][2])
				end

				setText(var_7_11:Find("normal/consumeNum"), var_7_13)
				setActive(var_7_11:Find("normal/cost"), false)
				setActive(var_7_11:Find("normal/consumeIcon"), false)
				setActive(var_7_11:Find("normal/have"), true)
			end
		end

		local var_7_15 = arg_7_1[1]:GetResourceConsume()

		var_7_0 = var_7_15[1]
		var_7_1 = var_7_15[2]
		var_7_2 = var_7_15[3]
	end

	GetImageSpriteFromAtlasAsync(Drop.New({
		type = var_7_0,
		id = var_7_1
	}):getIcon(), "", arg_7_0.consumeIcon)
	setText(arg_7_0.consumeCount, var_7_2)
	onButton(arg_7_0, arg_7_0.buyBtn, function()
		for iter_8_0, iter_8_1 in ipairs(arg_7_1) do
			table.insert({}, {
				value2 = 1,
				key = iter_8_1.shopId,
				value1 = iter_8_1.id
			})
		end

		arg_7_0:emit(IslandMediator.BUY_COMMODITY, {})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Refresh(arg_9_0)
	arg_9_0:SetUp(arg_9_0.commodities)

	return
end

function var_0_0.OnShow(arg_10_0, arg_10_1)
	arg_10_0:BlurPanel(arg_10_0._tf)

	arg_10_0.commodities = arg_10_1

	arg_10_0:SetUp(arg_10_0.commodities)

	return
end

function var_0_0.OnHide(arg_11_0)
	arg_11_0:UnOverlayPanel(arg_11_0._tf, arg_11_0._parentTf)

	return
end

function var_0_0.OnDestroy(arg_12_0)
	return
end

return var_0_0
