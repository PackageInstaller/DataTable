local var_0_0 = class("ChargeItemShopView", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "ChargeItemShopUI"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initUI()
	arg_2_0:Show()

	return
end

function var_0_0.OnDestroy(arg_3_0)
	arg_3_0:unBlurView()

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.cardList) do
		iter_3_1:Dispose()
	end

	return
end

function var_0_0.initData(arg_4_0)
	arg_4_0.itemGoodsVOList = {}
	arg_4_0.player = getProxy(PlayerProxy):getData()
	arg_4_0.packageSortList = {
		0
	}
	arg_4_0.selectedPackageType = nil
	arg_4_0.prevBtn = nil

	arg_4_0:updateData()

	return
end

function var_0_0.initUI(arg_5_0)
	arg_5_0.contextTF = arg_5_0._tf:Find("scroll")
	arg_5_0.lScrollRect = GetComponent(arg_5_0.contextTF, "LScrollRect")
	arg_5_0.scrollContent = arg_5_0._tf:Find("scroll/content")
	arg_5_0.scrollRectTF = GetComponent(arg_5_0.scrollContent, typeof(RectTransform))
	arg_5_0.layoutGroup = GetComponent(arg_5_0.scrollContent, typeof(GridLayoutGroup))

	local var_5_0 = math.floor(arg_5_0.scrollRectTF.rect.width / arg_5_0.layoutGroup.cellSize.x)
	local var_5_1 = arg_5_0.scrollRectTF.rect.width % arg_5_0.layoutGroup.cellSize.x / var_5_0

	if arg_5_0.scrollRectTF.rect.width % arg_5_0.layoutGroup.cellSize.x / var_5_0 < 12 then
		var_5_1 = (arg_5_0.scrollRectTF.rect.width - arg_5_0.layoutGroup.cellSize.x * (var_5_0 - 1)) / (var_5_0 - 1)
	end

	arg_5_0.layoutGroup.spacing = Vector2(var_5_1, var_5_1)
	arg_5_0.layoutGroup.padding.left = var_5_1 / 2
	arg_5_0.cardTable = {}
	arg_5_0.cardList = {}

	arg_5_0:initScrollRect()
	arg_5_0:initToggleList()
	arg_5_0:updateToggleList()
	arg_5_0:updateScrollRect()
	triggerButton(arg_5_0._tf:Find("toggleGroup"):GetChild(0))
	arg_5_0:blurView()

	return
end

function var_0_0.initScrollRect(arg_6_0)
	arg_6_0.cardTable = {}
	arg_6_0.cardList = {}

	function arg_6_0.lScrollRect.onInitItem(arg_7_0)
		local var_7_0 = ChargeGoodsCard.New(arg_7_0)

		table.insert(arg_6_0.cardList, var_7_0)
		onButton(arg_6_0, var_7_0.tf, function()
			if var_7_0.goodsVO:isLevelLimit(arg_6_0.player.level) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("charge_level_limit"))

				return
			end

			local var_8_0 = var_7_0.goodsVO:getConfig("effect_args")
			local var_8_1 = {}
			local var_8_2

			if var_8_0 == "ship_bag_size" then
				if arg_6_0.player:getMaxShipBagExcludeGuild() >= Player.MAX_SHIP_BAG then
					pg.TipsMgr.GetInstance():ShowTips(i18n("charge_ship_bag_max"))

					return
				end

				var_8_1 = {
					count = 1,
					type = DROP_TYPE_ITEM,
					id = Goods.SHIP_BAG_SIZE_ITEM
				}
				var_8_2 = ({
					count = 1,
					type = DROP_TYPE_ITEM,
					id = Goods.SHIP_BAG_SIZE_ITEM
				}).id
			elseif var_8_0 == "equip_bag_size" then
				if arg_6_0.player:getMaxEquipmentBagExcludeGuild() >= Player.MAX_EQUIP_BAG then
					pg.TipsMgr.GetInstance():ShowTips(i18n("charge_equip_bag_max"))

					return
				end

				var_8_1 = {
					count = 1,
					type = DROP_TYPE_ITEM,
					id = Goods.EQUIP_BAG_SIZE_ITEM
				}
				var_8_2 = ({
					count = 1,
					type = DROP_TYPE_ITEM,
					id = Goods.EQUIP_BAG_SIZE_ITEM
				}).id
			elseif var_8_0 == "commander_bag_size" then
				if arg_6_0.player.commanderBagMax >= Player.MAX_COMMANDER_BAG then
					pg.TipsMgr.GetInstance():ShowTips(i18n("charge_commander_bag_max"))

					return
				end

				var_8_1 = {
					count = 1,
					type = DROP_TYPE_ITEM,
					id = Goods.COMMANDER_BAG_SIZE_ITEM
				}
				var_8_2 = ({
					count = 1,
					type = DROP_TYPE_ITEM,
					id = Goods.COMMANDER_BAG_SIZE_ITEM
				}).id
			elseif var_8_0 == "spweapon_bag_size" then
				if getProxy(EquipmentProxy):GetSpWeaponCapacity() >= EquipmentProxy.MAX_SPWEAPON_BAG then
					pg.TipsMgr.GetInstance():ShowTips(i18n("charge_equip_bag_max"))

					return
				end

				var_8_1 = {
					count = 1,
					type = DROP_TYPE_ITEM,
					id = Goods.SPWEAPON_BAG_SIZE_ITEM
				}
				var_8_2 = ({
					count = 1,
					type = DROP_TYPE_ITEM,
					id = Goods.SPWEAPON_BAG_SIZE_ITEM
				}).id
			else
				var_8_1 = {
					id = var_7_0.goodsVO:getConfig("effect_args")[1],
					type = var_7_0.goodsVO:getConfig("type"),
					count = var_7_0.goodsVO:getConfig("num")
				}
				var_8_2 = var_7_0.goodsVO:getConfig("type") == DROP_TYPE_RESOURCE and id2ItemId(var_8_1.id) or var_8_1.id
			end

			local var_8_3 = ChargeConst.getGroupLimit(arg_6_0.normalGroupList, var_7_0.goodsVO:getConfig("group"))
			local var_8_4 = var_7_0.goodsVO:IsGroupSale() and i18n("gem_shop_xinzhi_tip", var_8_3) or ""

			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				yesText = "text_buy",
				type = MSGBOX_TYPE_SINGLE_ITEM,
				drop = var_8_1,
				subIntro = var_8_4,
				onYes = function()
					if var_8_2 then
						pg.MsgboxMgr.GetInstance():ShowMsgBox({
							content = i18n("charge_scene_buy_confirm", var_7_0.goodsVO:GetPrice(), (Item.New({
								id = var_8_2
							}):getConfig("name"))),
							onYes = function()
								arg_6_0:emit(NewShopMainMediator.BUY_ITEM, var_7_0.goodsVO.id, 1)

								return
							end
						})
					end

					return
				end
			})

			return
		end)

		arg_6_0.cardTable[arg_7_0] = var_7_0

		return
	end

	function arg_6_0.lScrollRect.onUpdateItem(arg_11_0, arg_11_1)
		local var_11_0 = arg_6_0.cardTable[arg_11_1]

		if not arg_6_0.cardTable[arg_11_1] then
			var_0(arg_11_1)

			var_11_0 = arg_6_0.cardTable[arg_11_1]
		end

		var_11_0:update(arg_6_0.filterList[arg_11_0 + 1])
		var_11_0:setLevelMask(arg_6_0.player.level)
		var_11_0:setGroupMask((ChargeConst.getGroupLimit(arg_6_0.normalGroupList, var_11_1:getConfig("group"))))

		return
	end

	return
end

function var_0_0.updateScrollRect(arg_12_0)
	arg_12_0.filterList = arg_12_0:getFilterList()
	arg_12_0.lScrollRect.enabled = true

	arg_12_0.lScrollRect:SetTotalCount(#arg_12_0.filterList, arg_12_0.lScrollRect.value)

	return
end

function var_0_0.updateToggleList(arg_13_0)
	arg_13_0.uiToggleList:align(#arg_13_0.packageSortList)

	return
end

function var_0_0.initToggleList(arg_14_0)
	arg_14_0.uiToggleList = UIItemList.New(arg_14_0._tf:Find("toggleGroup"), arg_14_0._tf:Find("toggleGroup/Toggle"))

	arg_14_0.uiToggleList:make(function(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_0 == UIItemList.EventInit then
			setText(arg_15_2:Find("selected/Label"), i18n(string.format("shop_package_sort_%s", arg_14_0.packageSortList[arg_15_1 + 1])))
			setText(arg_15_2:Find("selected/enText"), i18n(string.format("shop_package_sort_en_%s", arg_14_0.packageSortList[arg_15_1 + 1])))
			setText(arg_15_2:Find("unselected/Label"), i18n(string.format("shop_package_sort_%s", arg_14_0.packageSortList[arg_15_1 + 1])))
			setActive(arg_15_2:Find("unselected"), true)
			setActive(arg_15_2:Find("selected"), false)
		elseif arg_15_0 == UIItemList.EventUpdate then
			onButton(arg_14_0, arg_15_2, function()
				if arg_14_0.selectedPackageType == arg_14_0.packageSortList[arg_15_1 + 1] then
					return
				end

				setActive(arg_15_2:Find("unselected"), false)
				setActive(arg_15_2:Find("selected"), true)

				if arg_14_0.prevBtn then
					setActive(arg_14_0.prevBtn:Find("unselected"), true)
					setActive(arg_14_0.prevBtn:Find("selected"), false)
				end

				arg_14_0.prevBtn = arg_15_2
				arg_14_0.selectedPackageType = arg_14_0.packageSortList[arg_15_1 + 1]

				arg_14_0:updateScrollRect()

				return
			end, SFX_PANEL)
		end

		return
	end)

	return
end

function var_0_0.updateItemGoodsVOList(arg_17_0)
	arg_17_0.itemGoodsVOList = {}
	arg_17_0.packageSortList = {
		0
	}

	for iter_17_0, iter_17_1 in pairs(pg.shop_template.all) do
		if pg.shop_template[iter_17_1].genre == "gem_shop" then
			local var_17_0, var_17_1, var_17_2 = ChargeConst.getGoodsLimitInfo(iter_17_1)
			local var_17_3 = false

			if pg.shop_template[iter_17_1].effect_args == "ship_bag_size" and var_17_1 and var_17_2 then
				local var_17_4 = arg_17_0.player:getMaxShipBagExcludeGuild()

				if var_17_1 <= var_17_4 and var_17_4 <= var_17_2 then
					var_17_3 = true
				end
			elseif pg.shop_template[iter_17_1].effect_args == "equip_bag_max" and var_17_1 and var_17_2 then
				local var_17_5 = arg_17_0.player:getMaxEquipmentBag()

				if var_17_1 <= var_17_5 and var_17_5 <= var_17_2 then
					var_17_3 = true
				end
			elseif pg.shop_template[iter_17_1].effect_args == "commander_bag_size" and var_17_1 and var_17_2 then
				if var_17_1 <= arg_17_0.player.commanderBagMax and arg_17_0.player.commanderBagMax <= var_17_2 then
					var_17_3 = true
				end
			else
				var_17_3 = true
			end

			if var_17_3 == true then
				table.insert(arg_17_0.itemGoodsVOList, (Goods.Create({
					count = 0,
					shop_id = iter_17_1
				}, Goods.TYPE_MILITARY)))
			end
		end
	end

	for iter_17_2 = #arg_17_0.itemGoodsVOList, 1, -1 do
		if not arg_17_0.itemGoodsVOList[iter_17_2]:IsShowWhenGroupSale((ChargeConst.getGroupLimit(arg_17_0.normalGroupList, arg_17_0.itemGoodsVOList[iter_17_2]:getConfig("group")))) then
			table.remove(arg_17_0.itemGoodsVOList, iter_17_2)
		end
	end

	for iter_17_3, iter_17_4 in ipairs(arg_17_0.itemGoodsVOList) do
		if not table.contains(arg_17_0.packageSortList, pg.shop_template[iter_17_4.id].package_sort_id) then
			table.insert(arg_17_0.packageSortList, pg.shop_template[iter_17_4.id].package_sort_id)
		end
	end

	table.sort(arg_17_0.packageSortList, function(arg_18_0, arg_18_1)
		return arg_18_0 < arg_18_1
	end)

	return
end

function var_0_0.sortItemGoodsVOList(arg_19_0)
	table.sort(arg_19_0.itemGoodsVOList, function(arg_20_0, arg_20_1)
		local var_20_0 = arg_20_0:isLevelLimit(arg_19_0.player.level) and 1 or 0
		local var_20_1 = arg_20_1:isLevelLimit(arg_19_0.player.level) and 1 or 0
		local var_20_2 = arg_20_0:getConfig("order")
		local var_20_3 = arg_20_1:getConfig("order")

		if var_20_2 == var_20_3 then
			if var_20_0 == var_20_1 then
				return arg_20_0.id > arg_20_1.id
			end

			return var_20_0 < var_20_1
		else
			return var_20_2 < var_20_3
		end

		return
	end)

	return
end

function var_0_0.getFilterList(arg_21_0)
	if arg_21_0.selectedPackageType == 0 then
		return arg_21_0.itemGoodsVOList
	end

	local var_21_0 = {}

	for iter_21_0, iter_21_1 in ipairs(arg_21_0.itemGoodsVOList) do
		if iter_21_1:getConfig("package_sort_id") == arg_21_0.selectedPackageType then
			table.insert(var_21_0, iter_21_1)
		end
	end

	return var_21_0
end

function var_0_0.updateGoodsData(arg_22_0)
	arg_22_0.firstChargeIds = arg_22_0.contextData.firstChargeIds
	arg_22_0.chargedList = arg_22_0.contextData.chargedList
	arg_22_0.normalList = arg_22_0.contextData.normalList
	arg_22_0.normalGroupList = arg_22_0.contextData.normalGroupList

	return
end

function var_0_0.setGoodData(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	arg_23_0.firstChargeIds = arg_23_1
	arg_23_0.chargedList = arg_23_2
	arg_23_0.normalList = arg_23_3
	arg_23_0.normalGroupList = arg_23_4

	return
end

function var_0_0.updateData(arg_24_0)
	arg_24_0.player = getProxy(PlayerProxy):getData()

	arg_24_0:updateItemGoodsVOList()
	arg_24_0:sortItemGoodsVOList()

	return
end

function var_0_0.blurView(arg_25_0)
	arg_25_0:OverlayPanel(arg_25_0._tf, {
		pbList = {
			arg_25_0._tf:Find("bg")
		}
	})

	return
end

function var_0_0.unBlurView(arg_26_0)
	arg_26_0:UnOverlayPanel(arg_26_0._tf, arg_26_0._parentTf)

	return
end

function var_0_0.IsSupplyShop(arg_27_0)
	return false
end

function var_0_0.reUpdateAll(arg_28_0)
	arg_28_0:updateData()
	arg_28_0:updateScrollRect()

	return
end

function var_0_0.ShowPanel(arg_29_0, arg_29_1)
	setActive(arg_29_0._go, arg_29_1)

	return
end

return var_0_0
