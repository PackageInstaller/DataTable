local var_0_0 = class("IslandSeasonShopPanel", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "IslandSeasonShopPanel"
end

function var_0_0.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf:Find("content")

	arg_2_0.lockTF = var_2_0:Find("view/lock")

	setText(var_2_0:Find("view/content/tpl/sellOut/Text"), i18n("common_sale_out"))

	arg_2_0.resCntTxt = var_2_0:Find("res/Text"):GetComponent(typeof(Text))
	arg_2_0.goodUIList = UIItemList.New(var_2_0:Find("view/content"), var_2_0:Find("view/content/tpl"))

	local var_2_1 = var_2_0:Find("toggles")

	arg_2_0.togglesUIList = UIItemList.New(var_2_1, var_2_1:Find("tpl"))

	return
end

function var_0_0.OnInit(arg_3_0)
	arg_3_0.shopIds = arg_3_0.contextData.season:getConfig("shop_id")

	arg_3_0.togglesUIList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventInit then
			local function var_4_0()
				setActive(arg_4_2:Find("red"), IslandSeasonRedDotHelper.TipShopShowPhase(arg_4_1 + 1))

				return
			end

			arg_4_2.name = arg_4_1 + 1

			setText(arg_4_2:Find("unsel/Text"), i18n("island_season_shop_stage" .. arg_4_1 + 1))
			setText(arg_4_2:Find("sel/Text"), i18n("island_season_shop_stage" .. arg_4_1 + 1))
			onToggle(arg_3_0, arg_4_2, function(arg_6_0)
				if arg_6_0 then
					arg_3_0.showPhase = arg_4_1 + 1

					arg_3_0:Flush()
					var_4_0()
				end

				return
			end, SFX_PANEL)
			;(function()
				setActive(arg_4_2:Find("red"), IslandSeasonRedDotHelper.TipShopShowPhase(arg_4_1 + 1))

				return
			end)()
		end

		return
	end)
	arg_3_0.togglesUIList:align(#arg_3_0.shopIds)
	arg_3_0.goodUIList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			arg_3_0:UpdateGood(arg_7_1, arg_7_2)
		end

		return
	end)

	return
end

function var_0_0.Show(arg_8_0)
	var_0_0.super.Show(arg_8_0)

	arg_8_0.showPhase = 1

	triggerToggle(arg_8_0.togglesUIList.container:GetChild(0), true)
	IslandGuideChecker.CheckGuide("ISLAND_GUIDE_18")

	return
end

function var_0_0.UpdateGood(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.displaysGoods[arg_9_1 + 1]

	arg_9_2.name = arg_9_0.displaysGoods[arg_9_1 + 1].id

	IslandShopPage.StaticUpdateCommodityTpl(arg_9_2, arg_9_0.displaysGoods[arg_9_1 + 1])
	setActive(arg_9_2:Find("notInTime"), not arg_9_0.displayShop:IsInTime())

	if isActive(arg_9_2:Find("sellOut")) or isActive(arg_9_2:Find("hold")) or isActive(arg_9_2:Find("notInTime")) then
		removeOnButton(arg_9_2)
	else
		onButton(arg_9_0, arg_9_2, function()
			arg_9_0.contextData.openBuyLayer(arg_9_0.displayShop.id, var_9_0)

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.Flush(arg_11_0)
	arg_11_0.inventoryAgency = getProxy(IslandProxy):GetIsland():GetInventoryAgency()
	arg_11_0.shops = getProxy(IslandProxy):GetIsland():GetShopAgency():GetSeasonShops()

	local var_11_0 = arg_11_0.showPhase or 1
	local var_11_1 = arg_11_0.shopIds[var_11_0]

	arg_11_0.displayShop = arg_11_0.shops[var_11_1]

	IslandSeasonRedDotHelper.UpdateEnterShopPhase(arg_11_0.showPhase)
	arg_11_0:emit(IslandSeasonPage.UPDATE_REDDOT, IslandSeasonPage.PAGE_SHOP)

	local var_11_2 = pg.TimeMgr.GetInstance()
	local var_11_3 = arg_11_0.displayShop:GetExistTime()
	local var_11_4 = var_11_2:inTime(var_11_3)

	setActive(arg_11_0.lockTF, not var_11_4)

	if not var_11_4 then
		setText(arg_11_0.lockTF:Find("layout/Text"), var_11_2:DescDateFromConfig(var_11_3[1]) .. "~" .. var_11_2:DescDateFromConfig(var_11_3[2]))
	end

	arg_11_0.displaysGoods = arg_11_0.displayShop:GetCommodities()

	IslandShopPage.SortShopCommodities(arg_11_0.displaysGoods)
	arg_11_0.goodUIList:align(#arg_11_0.displaysGoods)
	setActive(arg_11_0.lockTF, not arg_11_0.displayShop:IsInTime())

	arg_11_0.resCntTxt.text = arg_11_0.inventoryAgency:GetOwnCount(IslandItem.GOLD_ID)

	return
end

function var_0_0.OnDestroy(arg_12_0)
	return
end

return var_0_0
