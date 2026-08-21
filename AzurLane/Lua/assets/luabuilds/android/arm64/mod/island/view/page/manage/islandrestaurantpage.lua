local var_0_0 = class("IslandRestaurantPage", import("...base.IslandBasePage"))

var_0_0.MAX_ASSISTANT_CNT = 2
var_0_0.MAX_SHELF_CNT = 5

local var_0_1 = Vector3(-210, 50)
local var_0_2 = pg.island_item_data_template
local var_0_3 = pg.island_set

function var_0_0.getUIName(arg_1_0)
	return "IslandRestaurantUI"
end

function var_0_0.OnLoaded(arg_2_0)
	setText(arg_2_0._tf:Find("top/title/Text"), i18n("island_manage_title"))

	arg_2_0.rankTF = arg_2_0._tf:Find("rank")
	arg_2_0.rankIcon = arg_2_0.rankTF:Find("icon")
	arg_2_0.rankSlider = arg_2_0.rankTF:Find("exp")
	arg_2_0.rankText = arg_2_0.rankTF:Find("exp/progress")
	arg_2_0.eventContainer = arg_2_0._tf:Find("content/event_container")
	arg_2_0.eventTitleTF = arg_2_0.eventContainer:Find("event/title")
	arg_2_0.eventDescTF = arg_2_0.eventContainer:Find("event/desc/Text")

	setText(arg_2_0.eventContainer:Find("event/desc/effect"), "")

	arg_2_0.itemsList = UIItemList.New(arg_2_0._tf:Find("content/event_container/event/items"), arg_2_0._tf:Find("content/event_container/event/items/tpl"))
	arg_2_0.additionList = UIItemList.New(arg_2_0._tf:Find("content/event_container/event/addition"), arg_2_0._tf:Find("content/event_container/event/addition/tpl"))
	arg_2_0.windowContainer = arg_2_0._tf:Find("content/window_container")

	local var_2_0 = arg_2_0.windowContainer:Find("window")

	arg_2_0.nameTF = var_2_0:Find("name/Text")
	arg_2_0.nameEnTF = var_2_0:Find("name_en/Text")

	local var_2_1 = var_2_0:Find("left/content")

	arg_2_0.shipUIList = UIItemList.New(var_2_1, var_2_1:Find("tpl"))

	setText(var_2_1:Find("tpl/empty/Image/Text"), i18n("island_manage_sel_worker"))
	setText(var_2_1:Find("tpl/lock/Image/Text"), i18n("island_manage_upgrade_worker_level"))
	setText(var_2_1:Find("tpl/ship/skill/invalid/Text"), i18n("island_manage_skill_cant_use"))

	arg_2_0.commoditiesTF = var_2_0:Find("right/commodities")
	arg_2_0.commoditiesEmptyTF = var_2_0:Find("right/commodities_empty")

	setText(arg_2_0.commoditiesEmptyTF, i18n("island_manage_stock_out"))

	arg_2_0.scrollRect = arg_2_0.commoditiesTF:GetComponent("LScrollRect")
	arg_2_0.detailPanel = var_2_0:Find("right/detail")
	arg_2_0.detailNameTF = arg_2_0.detailPanel:Find("dot/name")
	arg_2_0.detailPriceTF = arg_2_0.detailPanel:Find("price/value")
	arg_2_0.detailDescTF = arg_2_0.detailPanel:Find("desc")
	arg_2_0.detailEffectTF = arg_2_0.detailPanel:Find("effect/Text")
	arg_2_0.shelfsTF = var_2_0:Find("right/shelfs")

	setText(arg_2_0.shelfsTF:Find("infos/tip"), i18n("island_manage_item_select"))

	arg_2_0.extraCapacityTF = arg_2_0.shelfsTF:Find("infos/capacity")

	setText(arg_2_0.extraCapacityTF:Find("name"), i18n("island_manage_capacity"))

	arg_2_0.extraCapacityEffectTF = arg_2_0.extraCapacityTF:Find("effect")
	arg_2_0.shelfUIList = UIItemList.New(arg_2_0.shelfsTF:Find("content"), arg_2_0.shelfsTF:Find("content/tpl"))

	local var_2_2 = var_2_0:Find("estimate")

	setText(var_2_2:Find("Text"), i18n("island_manage_predict_saleroom"))
	setText(var_2_2:Find("count/Text"), i18n("island_manage_cnt"))
	setText(var_2_2:Find("sales/Text"), i18n("island_manage_saleroom") .. ":")

	arg_2_0.estimateCntTF = var_2_2:Find("count/value")
	arg_2_0.estimateSalesTF = var_2_2:Find("sales/value")
	arg_2_0.buffInfoBtn = var_2_2:Find("info")
	arg_2_0.buffInfoPanel = var_2_2:Find("info_panel")

	setText(arg_2_0.buffInfoPanel:Find("Text"), i18n("island_manage_addition"))

	arg_2_0.buffInfoUIList = UIItemList.New(arg_2_0.buffInfoPanel:Find("effects"), arg_2_0.buffInfoPanel:Find("effects/tpl"))
	arg_2_0.buffInfoEmptyTF = arg_2_0.buffInfoPanel:Find("empty")

	setText(arg_2_0.buffInfoEmptyTF:Find("Text"), i18n("island_manage_no_addition"))
	setText(arg_2_0.buffInfoPanel:Find("tips"), i18n("island_manage_buff_tip"))

	arg_2_0.btnsTF = var_2_0:Find("btns")
	arg_2_0.openBtn = arg_2_0.btnsTF:Find("prepare/open"), setText(arg_2_0.btnsTF:Find("prepare/auto/Text"), i18n("island_manage_auto_work"))

	setText(arg_2_0.btnsTF:Find("prepare/open/Text"), i18n("island_manage_start_work"))
	setText(arg_2_0.btnsTF:Find("opening/Text"), i18n("island_manage_working"))
	setText(arg_2_0.btnsTF:Find("close/Text"), i18n("island_manage_result"))
	setText(arg_2_0.btnsTF:Find("end/Text"), i18n("island_manage_end_daily_work"))
	setText(arg_2_0._tf:Find("content/event_container/event/title/Text"), i18n("island_post_event_addition_label"))

	arg_2_0.ticketBtn = arg_2_0.btnsTF:Find("opening/ticket")

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf:Find("top/title/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.island_help_manage.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf:Find("top/back"), function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.rankTF, function()
		arg_3_0:OpenPage(IslandRestaurantRankPage, arg_3_0.restId)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.btnsTF:Find("prepare/auto"), function()
		if not arg_3_0.isOperable then
			return
		end

		arg_3_0:OnAutoSelect()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.openBtn, function()
		for iter_8_0, iter_8_1 in ipairs(arg_3_0.assistantsData) do
			({})[iter_8_1.id] = arg_3_0.selectedShipIds[iter_8_0]
		end

		arg_3_0:emit(IslandMediator.OPEN_RESTAURANT, {
			restId = arg_3_0.restId,
			ships = {},
			commodities = arg_3_0.selectedDic,
			estimateData = {
				trade_id = arg_3_0.restId,
				sell_num_min = arg_3_0.totalMinCnt,
				sell_num_max = arg_3_0.totalMaxCnt,
				sell_money_min = arg_3_0.totalMinSales,
				sell_money_max = arg_3_0.totalMaxSales
			}
		})

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.btnsTF:Find("close"), function()
		arg_3_0:emit(IslandMediator.CLOSE_RESTAURANT, arg_3_0.restId, arg_3_0.isPost)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.buffInfoBtn, function()
		if isActive(arg_3_0.buffInfoPanel) then
			setActive(arg_3_0.buffInfoPanel, false)
		else
			setActive(arg_3_0.buffInfoPanel, true)
			arg_3_0.buffInfoUIList:align(#arg_3_0.buffInfos)
			setActive(arg_3_0.buffInfoEmptyTF, #arg_3_0.buffInfos == 0)
		end

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.ticketBtn, function()
		arg_3_0:OpenPage(IslandTicketUsePage, IslandUseTicketCommand.TYPES.MANAGE, arg_3_0.restId)

		return
	end, SFX_PANEL)
	arg_3_0.shipUIList:make(function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0 == UIItemList.EventUpdate then
			arg_3_0:UpdateShipItem(arg_12_1, arg_12_2)
		end

		return
	end)

	function arg_3_0.scrollRect.onInitItem(arg_13_0)
		arg_3_0:OnInitItem(arg_13_0)

		return
	end

	function arg_3_0.scrollRect.onUpdateItem(arg_14_0, arg_14_1)
		arg_3_0:OnUpdateItem(arg_14_0, arg_14_1)

		return
	end

	arg_3_0.shelfUIList:make(function(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_0 == UIItemList.EventUpdate then
			arg_3_0:UpdateShelfItem(arg_15_1, arg_15_2)
		end

		return
	end)
	arg_3_0.buffInfoUIList:make(function(arg_16_0, arg_16_1, arg_16_2)
		if arg_16_0 == UIItemList.EventUpdate then
			setText(arg_16_2:Find("bg/name"), arg_3_0.buffInfos[arg_16_1 + 1].name)
			setText(arg_16_2:Find("bg/effect"), arg_3_0.buffInfos[arg_16_1 + 1].effect)
		end

		return
	end)

	arg_3_0.priceFactor = var_0_3.island_manage_price_coefficient.key_value_int / 100
	arg_3_0.argA = var_0_3.island_manage_sale_coefficient_a.key_value_int / 100
	arg_3_0.argB = var_0_3.island_manage_sale_coefficient_b.key_value_int / 100
	arg_3_0.argC = var_0_3.island_manage_sale_coefficient_c.key_value_int / 100
	arg_3_0.saleConst = var_0_3.island_manage_sale_constant.key_value_int / 100
	arg_3_0.maxAttrEffect = pg.island_chara_att[1].manage_effect / 16
	arg_3_0.minSaleCnt = var_0_3.island_manage_sale_limit.key_value_int

	return
end

function var_0_0.AddListeners(arg_17_0)
	arg_17_0:AddListener(GAME.ISLAND_OPEN_RESTAURANT_DONE, arg_17_0.Flush)
	arg_17_0:AddListener(GAME.ISLAND_CLOSE_RESTAURANT_DONE, arg_17_0.Flush)
	arg_17_0:AddListener(IslandManageAgecny.ON_DAILY_REFRESH, arg_17_0.Flush)

	return
end

function var_0_0.RemoveListeners(arg_18_0)
	arg_18_0:RemoveListener(GAME.ISLAND_OPEN_RESTAURANT_DONE, arg_18_0.Flush)
	arg_18_0:RemoveListener(GAME.ISLAND_CLOSE_RESTAURANT_DONE, arg_18_0.Flush)
	arg_18_0:RemoveListener(IslandManageAgecny.ON_DAILY_REFRESH, arg_18_0.Flush)

	return
end

function var_0_0.OnInitItem(arg_19_0, arg_19_1)
	local var_19_0 = IslandFoodCard.New(arg_19_1)

	onButton(arg_19_0, var_19_0._go, function()
		if isActive(arg_19_0.detailPanel) then
			setActive(arg_19_0.detailPanel, false)
		end

		if not arg_19_0.isOperable then
			return
		end

		arg_19_0:AddOnShelf(var_19_0)

		return
	end, SFX_PANEL)

	arg_19_0.cards[arg_19_1] = var_19_0

	return
end

function var_0_0.AddOnShelf(arg_21_0, arg_21_1)
	if #arg_21_0.shelfInfos >= arg_21_0.shelfCnt then
		return
	end

	local var_21_0 = math.min(arg_21_1.item:GetCount(), arg_21_0.baseCapacity + arg_21_0.extraCapacity)

	arg_21_0.selectedDic[arg_21_1.item.id] = var_21_0

	arg_21_1:UpdateSelectedCnt(var_21_0)
	arg_21_0:FlushShelfs()
	arg_21_0:FlushEstimate()

	return
end

function var_0_0.ShowDetailPanel(arg_22_0, arg_22_1, arg_22_2)
	setAnchoredPosition(arg_22_0.detailPanel, arg_22_2 + var_0_1)
	setActive(arg_22_0.detailPanel, true)
	setText(arg_22_0.detailNameTF, arg_22_1:GetName())
	setText(arg_22_0.detailPriceTF, (math.floor(arg_22_1:getConfig("order_price") * arg_22_0.priceFactor)))
	setText(arg_22_0.detailDescTF, arg_22_1:GetDesc())
	setText(arg_22_0.detailEffectTF, i18n("island_manage_attr_effect") .. IslandShipAttr.ATTRS_CH[1] .. "、" .. IslandShipAttr.ToChinese((IslandShipAttr.GetAtrrName(arg_22_1:getConfig("sub_attribute")[1]))))

	return
end

function var_0_0.OnUpdateItem(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0.cards[arg_23_2]

	if not arg_23_0.cards[arg_23_2] then
		arg_23_0:OnInitItem(arg_23_2)

		var_23_0 = arg_23_0.cards[arg_23_2]
	end

	local var_23_1 = arg_23_0.displays[arg_23_1 + 1]

	if arg_23_0.displays[arg_23_1 + 1] then
		local var_23_2 = arg_23_0:GetAttrsFactorsRatio(var_23_1.id)

		if arg_23_0.selectedDic and arg_23_0.selectedDic[var_23_1.id] then
			local var_23_3 = arg_23_0.selectedDic[var_23_1.id] or 0

			var_23_0:Update(var_23_1, arg_23_0.isOperable and var_23_3 or 0, arg_23_0.eventEffects[var_23_1.id], var_23_2)

			local var_23_4 = arg_23_0.detailPanel.parent:InverseTransformPoint(var_23_0._tf.position)

			GetOrAddComponent(var_23_0._go, typeof(UILongPressTrigger)).onLongPressed:AddListener(function()
				arg_23_0:ShowDetailPanel(var_23_0.item, var_23_4)

				return
			end)

			return
		end
	end
end

function var_0_0.UpdateCardWithItemId(arg_25_0, arg_25_1)
	for iter_25_0, iter_25_1 in pairs(arg_25_0.cards) do
		if iter_25_1.item.id == arg_25_1 then
			local var_25_1 = arg_25_0.selectedDic[arg_25_1] or 0

			iter_25_1:UpdateSelectedCnt(var_25_1)
		end
	end

	return
end

function var_0_0.OnShow(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0:BlurPanel()
	setActive(arg_26_0.buffInfoPanel, false)

	arg_26_0.restId = arg_26_1
	arg_26_0.isPost = arg_26_2
	arg_26_0.cards = {}

	arg_26_0:Flush()

	return
end

function var_0_0.OnEnable(arg_27_0)
	arg_27_0:Flush()

	return
end

function var_0_0.Flush(arg_28_0)
	arg_28_0:FlushData()
	arg_28_0:FlushName()
	arg_28_0:FlushRank()
	arg_28_0:FlushEvent()

	arg_28_0.selectedShipIds = nil

	arg_28_0:FlushAssistants()

	arg_28_0.selectedDic = nil

	arg_28_0:FlushCards()
	arg_28_0:FlushShelfs()
	arg_28_0:FlushEstimate()
	arg_28_0:FlushBtns()

	return
end

function var_0_0.FlushData(arg_29_0)
	arg_29_0.rest = getProxy(IslandProxy):GetIsland():GetManageAgency():GetRestaurant(arg_29_0.restId)
	arg_29_0.shelfCnt = arg_29_0.rest:GetShelfCnt()
	arg_29_0.assistantsData = arg_29_0.rest:GetAssistants()
	arg_29_0.baseCapacity = arg_29_0.rest:GetBaseShelfCapacity()
	arg_29_0.extraCapacity = 0
	arg_29_0.isOperable = arg_29_0.rest:GetStatus() == IslandRestaurant.STATUS.PREPARE

	return
end

function var_0_0.FlushName(arg_30_0)
	setText(arg_30_0.nameTF, arg_30_0.rest:getConfig("name"))
	setText(arg_30_0.nameEnTF, arg_30_0.rest:getConfig("name_en"))

	return
end

function var_0_0.FlushRank(arg_31_0)
	LoadImageSpriteAsync("island/islandrestaurant/" .. arg_31_0.rest:GetRankIcon(), arg_31_0.rankIcon)

	local var_31_0 = arg_31_0.rest:GetSales()
	local var_31_1 = arg_31_0.rest:GetCanUpgradeExp()

	setText(arg_31_0.rankText, var_31_0 .. "/" .. var_31_1)
	setSlider(arg_31_0.rankSlider, 0, 1, var_31_1 == 0 and 0 or var_31_0 / var_31_1)

	return
end

function var_0_0.FlushEvent(arg_32_0)
	arg_32_0.eventId, arg_32_0.eventEffects, arg_32_0.eventInfluence = arg_32_0.rest:GetEventInfo()

	setActive(arg_32_0.eventContainer, arg_32_0.eventId ~= 0)

	if arg_32_0.eventId ~= 0 then
		setText(arg_32_0.eventTitleTF, pg.island_manage_event[arg_32_0.eventId].name)
		setText(arg_32_0.eventDescTF, string.gsub(pg.island_manage_event[arg_32_0.eventId].desc, "$1", arg_32_0.rest:getConfig("name")))
		arg_32_0:UpdateAddition(arg_32_0.rest)
	end

	return
end

function var_0_0.UpdateAddition(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0:WarpItemInfo(arg_33_1)

	arg_33_0.itemsList:make(function(arg_34_0, arg_34_1, arg_34_2)
		if arg_34_0 == UIItemList.EventUpdate then
			updateCustomDrop(arg_34_2, (Drop.New({
				count = 0,
				type = DROP_TYPE_ISLAND_ITEM,
				id = var_33_0[arg_34_1 + 1].id
			})))
		end

		return
	end)
	arg_33_0.itemsList:align(#arg_33_0:WarpItemInfo(arg_33_1))

	local var_33_1 = arg_33_0:WarpAdditionInfo(pg.island_manage_event[arg_33_1:GetEventInfo()])

	arg_33_0.additionList:make(function(arg_35_0, arg_35_1, arg_35_2)
		if arg_35_0 == UIItemList.EventUpdate then
			setText(arg_35_2:Find("Text"), var_33_1[arg_35_1 + 1][1])
			setText(arg_35_2:Find("value"), "+" .. var_33_1[arg_35_1 + 1][2] .. "%")
		end

		return
	end)
	arg_33_0.additionList:align(#arg_33_0:WarpAdditionInfo(pg.island_manage_event[arg_33_1:GetEventInfo()]))

	return
end

function var_0_0.WarpItemInfo(arg_36_0, arg_36_1)
	local var_36_0, var_36_1 = arg_36_1:GetEventInfo()
	local var_36_2 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()

	for iter_36_0, iter_36_1 in ipairs(arg_36_1:getConfig("item_id")) do
		local var_36_3 = var_36_2:GetItemById(iter_36_1[1]) or IslandItem.New({
			id = iter_36_1[1]
		})

		if var_36_3 and var_36_1[var_36_3.id] then
			table.insert({}, var_36_3)
		end
	end

	return {}
end

function var_0_0.WarpAdditionInfo(arg_37_0, arg_37_1)
	table.insert({}, {
		i18n("island_addition_influence"),
		arg_37_1.influence_bonus
	})
	table.insert({}, {
		i18n("island_addition_sale"),
		arg_37_1.event_effect[1][1]
	})

	return {}
end

function var_0_0.FlushAssistants(arg_38_0)
	if not arg_38_0.selectedShipIds then
		local var_38_0 = getProxy(IslandProxy):GetIsland():GetCharacterAgency()

		arg_38_0.selectedShipIds = {}

		for iter_38_0, iter_38_1 in ipairs(arg_38_0.assistantsData) do
			if iter_38_1.shipId ~= 0 then
				table.insert(arg_38_0.selectedShipIds, iter_38_1.shipId)
			end
		end
	end

	arg_38_0.selectedShips = {}

	local var_38_1 = getProxy(IslandProxy):GetIsland():GetCharacterAgency()

	for iter_38_2, iter_38_3 in ipairs(arg_38_0.selectedShipIds) do
		table.insert(arg_38_0.selectedShips, var_38_1:GetShipById(iter_38_3))
	end

	arg_38_0.shipUIList:align(var_0_0.MAX_ASSISTANT_CNT)

	arg_38_0.extraPricePer = 0
	arg_38_0.extraCapacity = 0
	arg_38_0.buffInfos = {}

	for iter_38_4, iter_38_5 in ipairs((IslandBuffHelper.GetManageSellPriceBuffs(arg_38_0.selectedShips, arg_38_0.restId))) do
		local var_38_2 = iter_38_5:GetBuffEffect()[2]

		table.insert(arg_38_0.buffInfos, {
			name = i18n("island_manage_saleroom"),
			effect = "+" .. var_38_2 .. "%"
		})

		arg_38_0.extraPricePer = arg_38_0.extraPricePer + var_38_2 / 100
	end

	for iter_38_6, iter_38_7 in ipairs((IslandBuffHelper.GetManageSellNumBuffs(arg_38_0.selectedShips, arg_38_0.restId))) do
		local var_38_3 = iter_38_7:GetBuffEffect()[2]

		table.insert(arg_38_0.buffInfos, {
			name = i18n("island_manage_capacity"),
			effect = "+" .. var_38_3
		})

		arg_38_0.extraCapacity = arg_38_0.extraCapacity + var_38_3
	end

	if arg_38_0.statusCheckTimer then
		arg_38_0.statusCheckTimer:Stop()
	end

	if arg_38_0.isOperable then
		arg_38_0.shipStatus = IslandBuffHelper.GetManageStatus(arg_38_0.selectedShips, arg_38_0.restId)

		if #arg_38_0.shipStatus > 0 then
			arg_38_0.statusCheckTimer = Timer.New(function()
				if underscore.reduce(arg_38_0.shipStatus, 0, function(arg_40_0, arg_40_1)
					return arg_40_0 + (arg_40_1:IsExpiration() and 1 or 0)
				end) > 0 then
					arg_38_0:OnStatusExpired()
				end

				return
			end, 1, -1)

			arg_38_0.statusCheckTimer:Start()
		end
	end

	local var_38_5 = arg_38_0.isOperable and arg_38_0.extraCapacity > 0

	var_38_4(arg_38_0.extraCapacityTF, var_38_5)
	setText(arg_38_0.extraCapacityEffectTF, "+" .. arg_38_0.extraCapacity)
	arg_38_0.buffInfoUIList:align(#arg_38_0.buffInfos)
	setActive(arg_38_0.buffInfoEmptyTF, #arg_38_0.buffInfos == 0)

	local var_38_6 = arg_38_0.shelfInfos

	if arg_38_0.shelfInfos then
		if #arg_38_0.shelfInfos > 0 then
			var_38_6 = arg_38_0.selectedShipIds and #arg_38_0.selectedShipIds > 0

			setGray(arg_38_0.openBtn, not var_38_6, true)
			setButtonEnabled(arg_38_0.openBtn, var_38_6)

			return
		end
	end
end

function var_0_0.GetEffectiveManangeSkill(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_1:GetSkill()

	return var_41_0:IsEffectiveInRest(arg_41_0.restId) and var_41_0 or nil
end

function var_0_0.GetEffectiveManangeUnlockSkill(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_0:GetEffectiveManangeSkill(arg_42_1)

	return var_42_0 and var_42_0:IsUnlock() and var_42_0 or nil
end

function var_0_0.UpdateShipItem(arg_43_0, arg_43_1, arg_43_2)
	arg_43_2.name = arg_43_1 + 1

	local var_43_0 = arg_43_1 + 1 <= #arg_43_0.assistantsData

	setActive(arg_43_2:Find("lock"), not (arg_43_1 + 1 <= #arg_43_0.assistantsData))
	setActive(arg_43_2:Find("empty"), var_43_0 and not arg_43_0.selectedShips[arg_43_1 + 1])
	setActive(arg_43_2:Find("ship"), var_43_0 and arg_43_0.selectedShips[arg_43_1 + 1])
	onButton(arg_43_0, arg_43_2, function()
		if not var_43_0 or not arg_43_0.isOperable then
			return
		end

		arg_43_0:OpenPage(IslandShipSelectPage, {
			showBenefits = true,
			showType = IslandSelectShipCard.SHOW_TYPE.RESTAURANT,
			restId = arg_43_0.restId,
			selectNum = #arg_43_0.assistantsData,
			selectedIds = Clone(arg_43_0.selectedShipIds),
			attrType = IslandShipAttr.MANAGE_KEY,
			confirmFunc = function(arg_45_0)
				arg_43_0:OnSelectedShipsDone(arg_45_0)

				return
			end,
			emptyInfoTitle = arg_43_0.rest:getConfig("name")
		})

		return
	end, SFX_PANEL)

	if arg_43_0.selectedShips[arg_43_1 + 1] then
		local var_43_1 = arg_43_2:Find("ship")

		setText(var_43_1:Find("name"), arg_43_0.selectedShips[arg_43_1 + 1]:GetName())

		local var_43_2 = arg_43_0:GetEffectiveManangeSkill(arg_43_0.selectedShips[arg_43_1 + 1])

		setActive(var_43_1:Find("skill"), var_43_2 and var_43_2:IsUnlock())
		setActive(var_43_1:Find("skill_lock"), var_43_2 and not var_43_2:IsUnlock())
		GetImageSpriteFromAtlasAsync("ShipYardIcon/" .. IslandShip.StaticGetPrefab(arg_43_0.selectedShips[arg_43_1 + 1].id), "", var_43_1:Find("icon"))

		local var_43_3 = var_43_1:Find("skill")

		if var_43_2 then
			if var_43_2:IsUnlock() then
				setActive(var_43_3:Find("effects"), true)
				setActive(var_43_3:Find("invalid"), false)
				LoadImageSpriteAsync("island/islandskillicon/" .. var_43_2:GetIcon(), var_43_3:Find("skill_icon"))
				setText(var_43_3:Find("skill_name"), var_43_2:GetName())
				UIItemList.StaticAlign(var_43_3:Find("effects"), var_43_3:Find("effects/tpl"), #IslandBuffHelper.GetAllShipManageBuffs(arg_43_0.selectedShips[arg_43_1 + 1], arg_43_0.restId), function(arg_46_0, arg_46_1, arg_46_2)
					if arg_46_0 == UIItemList.EventUpdate then
						local var_46_0 = var_0[arg_46_1 + 1]:GetBuffType()
						local var_46_1 = ""
						local var_46_2 = ""

						if var_46_0 == IslandBuffType.SHIP_MANAGE_SELL_PRICE then
							var_46_1 = i18n("island_manage_saleroom")
							var_46_2 = "+" .. var_0[arg_46_1 + 1]:GetBuffEffect()[2] .. "%"
						elseif var_46_0 == IslandBuffType.SHIP_MANAGE_SELL_NUM then
							var_46_1 = i18n("island_manage_capacity")
							var_46_2 = "+" .. var_0[arg_46_1 + 1]:GetBuffEffect()[2]
						end

						setText(arg_46_2:Find("name"), var_46_1)
						setText(arg_46_2:Find("effect"), var_46_2)
					end

					return
				end)
			else
				setText(var_43_1:Find("skill_lock/Image/Text"), i18n("island_need_star_1", arg_43_0.selectedShips[arg_43_1 + 1]:GetSkillUnlockLevel()))
			end
		else
			local var_43_4 = arg_43_0.selectedShips[arg_43_1 + 1]:GetSkill()

			setActive(var_43_1:Find("skill"), true)
			LoadImageSpriteAsync("island/islandskillicon/" .. var_43_4:GetIcon(), var_43_3:Find("skill_icon"))
			setText(var_43_3:Find("skill_name"), var_43_4:GetName())
			setActive(var_43_3:Find("effects"), false)
			setActive(var_43_3:Find("invalid"), true)
		end
	end

	return
end

function var_0_0.FlushCards(arg_47_0)
	arg_47_0.displays = {}

	local var_47_0 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()

	for iter_47_0, iter_47_1 in ipairs(arg_47_0.rest:getConfig("item_id")) do
		local var_47_1 = var_47_0:GetItemById(iter_47_1[1])

		if var_47_1 then
			table.insert(arg_47_0.displays, var_47_1)
		end
	end

	setActive(arg_47_0.commoditiesEmptyTF, #arg_47_0.displays <= 0)
	setActive(arg_47_0.commoditiesTF, #arg_47_0.displays > 0)
	arg_47_0:CaclAttrsFactors()

	if #arg_47_0.displays > 0 then
		arg_47_0:SortDisplays()
	end

	return
end

function var_0_0.SortDisplays(arg_48_0)
	table.sort(arg_48_0.displays, CompareFuncs({
		function(arg_49_0)
			return -arg_48_0.subAttrFactorsDic[arg_49_0.id]
		end,
		function(arg_50_0)
			return -arg_50_0:getConfig("order_price") * arg_48_0.priceFactor
		end,
		function(arg_51_0)
			return arg_51_0.id
		end
	}))

	if arg_48_0:isShowing() then
		arg_48_0.scrollRect:SetTotalCount(#arg_48_0.displays, -1)
	end

	return
end

function var_0_0.CaclAttrsFactors(arg_52_0)
	arg_52_0.subAttrFactorsDic = {}
	arg_52_0.mainAttrFactorsDic = {}

	for iter_52_0, iter_52_1 in ipairs(arg_52_0.displays) do
		local var_52_0 = iter_52_1:getConfig("sub_attribute")[1]
		local var_52_1 = arg_52_0.subAttrFactorsDic

		var_52_1[iter_52_1.id] = var_52_0 and var_0_0.CaclShipAttrFactors(arg_52_0.selectedShips, var_52_0) or 0
		arg_52_0.mainAttrFactorsDic[iter_52_1.id] = var_0_0.CaclShipAttrFactors(arg_52_0.selectedShips, IslandShipAttr.MANAGE_KEY)
	end

	return
end

function var_0_0.GetSubAttrFactors(arg_53_0, arg_53_1)
	if arg_53_0.subAttrFactorsDic[arg_53_1] then
		return arg_53_0.subAttrFactorsDic[arg_53_1]
	end

	local var_53_0 = var_0_2[arg_53_1].sub_attribute[1]
	local var_53_1 = arg_53_0.subAttrFactorsDic

	var_53_1[arg_53_1] = var_0_2[arg_53_1].sub_attribute[1] and var_0_0.CaclShipAttrFactors(arg_53_0.selectedShips, var_53_0) or 0

	return arg_53_0.subAttrFactorsDic[arg_53_1]
end

function var_0_0.GetMainAttrFactors(arg_54_0, arg_54_1)
	if arg_54_0.mainAttrFactorsDic[arg_54_1] then
		return arg_54_0.mainAttrFactorsDic[arg_54_1]
	end

	arg_54_0.mainAttrFactorsDic[arg_54_1] = var_0_0.CaclShipAttrFactors(arg_54_0.selectedShips, IslandShipAttr.MANAGE_KEY)

	return arg_54_0.mainAttrFactorsDic[arg_54_1]
end

function var_0_0.GetAttrsFactorsRatio(arg_55_0, arg_55_1)
	local var_55_0 = arg_55_0:GetMainAttrFactors(arg_55_1) + arg_55_0:GetSubAttrFactors(arg_55_1) * (var_0_2[arg_55_1].sub_attribute[2] / 100)
	local var_55_1 = #arg_55_0.assistantsData * (arg_55_0.maxAttrEffect + arg_55_0.maxAttrEffect * (var_0_2[arg_55_1].sub_attribute[2] / 100))

	return #arg_55_0.assistantsData * (arg_55_0.maxAttrEffect + arg_55_0.maxAttrEffect * (var_0_2[arg_55_1].sub_attribute[2] / 100)) == 0 and 0 or var_55_0 / var_55_1
end

function var_0_0.FlushShelfs(arg_56_0)
	if not arg_56_0.selectedDic then
		arg_56_0.selectedDic = {}

		for iter_56_0, iter_56_1 in ipairs(arg_56_0.rest:GetCommondities()) do
			arg_56_0.selectedDic[iter_56_1.id] = iter_56_1.num
		end
	end

	arg_56_0.shelfInfos = {}

	for iter_56_2, iter_56_3 in pairs(arg_56_0.selectedDic) do
		table.insert(arg_56_0.shelfInfos, {
			id = iter_56_2,
			num = iter_56_3
		})
	end

	arg_56_0.shelfUIList:align(var_0_0.MAX_SHELF_CNT)

	local var_56_0 = arg_56_0.shelfInfos

	if arg_56_0.shelfInfos then
		if #arg_56_0.shelfInfos > 0 then
			var_56_0 = arg_56_0.selectedShipIds and #arg_56_0.selectedShipIds > 0

			setGray(arg_56_0.openBtn, not var_56_0, true)
			setButtonEnabled(arg_56_0.openBtn, var_56_0)

			return
		end
	end
end

function var_0_0.UpdateShelfItem(arg_57_0, arg_57_1, arg_57_2)
	arg_57_2.name = arg_57_1 + 1

	local var_57_0 = arg_57_1 + 1 <= arg_57_0.shelfCnt

	setActive(arg_57_2:Find("lock"), not (arg_57_1 + 1 <= arg_57_0.shelfCnt))

	local var_57_1 = arg_57_0.shelfInfos[arg_57_1 + 1]

	setActive(arg_57_2:Find("empty"), var_57_0 and not var_57_1)
	setActive(arg_57_2:Find("commodity"), var_57_0 and var_57_1)

	if var_57_1 then
		local var_57_2 = arg_57_2:Find("commodity")

		LoadImageSpriteAsync("island/" .. var_0_2[var_57_1.id].icon, var_57_2:Find("bg/icon"))

		local var_57_3 = arg_57_0.baseCapacity + arg_57_0.extraCapacity

		if arg_57_0.isOperable then
			local var_57_4 = arg_57_0.extraCapacity > 0 and setColorStr(var_57_3, "#7BF59DFF") or var_57_3

			setText(var_57_2:Find("count/Text"), var_57_1.num .. "/" .. var_57_4)
		else
			setText(var_57_2:Find("count/Text"), var_57_1.num)
		end

		setActive(var_57_2:Find("event"), arg_57_0.eventEffects[var_57_1.id])
		setFillAmount(var_57_2:Find("bg/silder/bar"), (arg_57_0:GetAttrsFactorsRatio(var_57_1.id)))
		setActive(var_57_2:Find("reduce"), arg_57_0.isOperable)
		onButton(arg_57_0, var_57_2:Find("reduce"), function()
			if not arg_57_0.isOperable then
				return
			end

			arg_57_0:ReduceShelfCnt(var_57_1.id, 1)
			arg_57_0:FlushEstimate()

			return
		end, SFX_PANEL)

		if var_57_3 < var_57_1.num then
			arg_57_0:ReduceShelfCnt(var_57_1.id, var_57_1.num - var_57_3)
			arg_57_0:FlushEstimate()
		end
	end

	return
end

function var_0_0.ReduceShelfCnt(arg_59_0, arg_59_1, arg_59_2)
	arg_59_0.selectedDic[arg_59_1] = arg_59_0.selectedDic[arg_59_1] - arg_59_2

	if arg_59_0.selectedDic[arg_59_1] <= 0 then
		arg_59_0.selectedDic[arg_59_1] = nil
	end

	arg_59_0:UpdateCardWithItemId(arg_59_1)
	arg_59_0:FlushShelfs()

	return
end

function var_0_0.FlushEstimate(arg_60_0)
	local var_60_0 = arg_60_0.rest:GetStatus()

	if var_60_0 == IslandRestaurant.STATUS.OPENING or var_60_0 == IslandRestaurant.STATUS.CLOSE then
		local var_60_1 = arg_60_0.rest:GetEstimateData()

		setText(arg_60_0.estimateCntTF, var_60_1.cntMin .. "-" .. var_60_1.cntMax)
		setText(arg_60_0.estimateSalesTF, var_60_1.salesMin .. "-" .. var_60_1.salesMax)
	else
		local var_60_2, var_60_3 = arg_60_0.rest:GetRandomSaleCntBound()

		arg_60_0.totalMinCnt, arg_60_0.totalMaxCnt, arg_60_0.totalMinSales, arg_60_0.totalMaxSales = 0, 0, 0, 0

		for iter_60_0, iter_60_1 in pairs(arg_60_0.selectedDic) do
			local var_60_4 = arg_60_0:CaclBaseSaleCnt(iter_60_0)
			local var_60_5 = math.min(iter_60_1, math.max(arg_60_0.minSaleCnt, var_60_4 + var_60_2))
			local var_60_6 = math.min(iter_60_1, math.max(arg_60_0.minSaleCnt, var_60_4 + var_60_3))

			arg_60_0.totalMinSales = arg_60_0.totalMinSales + arg_60_0:CaclGroupPrice(iter_60_0, var_60_5)
			arg_60_0.totalMaxSales = arg_60_0.totalMaxSales + arg_60_0:CaclGroupPrice(iter_60_0, var_60_6)
			arg_60_0.totalMinCnt = arg_60_0.totalMinCnt + var_60_5
			arg_60_0.totalMaxCnt = arg_60_0.totalMaxCnt + var_60_6
		end

		setText(arg_60_0.estimateCntTF, arg_60_0.totalMinCnt .. "-" .. arg_60_0.totalMaxCnt)
		setText(arg_60_0.estimateSalesTF, arg_60_0.totalMinSales .. "-" .. arg_60_0.totalMaxSales)
	end

	return
end

function var_0_0.CaclBaseSaleCnt(arg_61_0, arg_61_1)
	local var_61_0 = var_0_2[arg_61_1].manage_influence / 100

	if arg_61_0.eventEffects[arg_61_1] then
		local var_61_1 = arg_61_0.eventInfluence or 0

		return math.floor((var_61_0 + var_61_1) * (arg_61_0.argA + arg_61_0:GetMainAttrFactors(arg_61_1)) * (arg_61_0.argB + arg_61_0:GetSubAttrFactors(arg_61_1) * (var_0_2[arg_61_1].sub_attribute[2] / 100)) * (arg_61_0.argC + arg_61_0.rest:GetRankFactor()) / arg_61_0.saleConst)
	end
end

function var_0_0.CaclGroupPrice(arg_62_0, arg_62_1, arg_62_2)
	local var_62_0 = arg_62_0.eventEffects[arg_62_1] or 0

	return math.floor(var_0_2[arg_62_1].order_price * arg_62_0.priceFactor * arg_62_2 * (1 + var_62_0 + arg_62_0.extraPricePer))
end

function var_0_0.OnStatusExpired(arg_63_0)
	arg_63_0:FlushAssistants()
	arg_63_0:FlushCards()
	arg_63_0:FlushShelfs()
	arg_63_0:FlushEstimate()

	return
end

function var_0_0.OnSelectedShipsDone(arg_64_0, arg_64_1)
	arg_64_0.selectedShipIds = arg_64_1

	arg_64_0:FlushAssistants()
	arg_64_0:FlushCards()
	arg_64_0:FlushShelfs()
	arg_64_0:FlushEstimate()

	return
end

function var_0_0.OnAutoSelect(arg_65_0)
	arg_65_0.selectedShipIds = arg_65_0:GetAutoShipIds()

	arg_65_0:FlushAssistants()
	arg_65_0:FlushCards()

	arg_65_0.selectedDic = {}

	for iter_65_0 = 1, arg_65_0.shelfCnt do
		if arg_65_0.displays[iter_65_0] then
			arg_65_0.selectedDic[arg_65_0.displays[iter_65_0].id] = math.min(arg_65_0.displays[iter_65_0]:GetCount(), arg_65_0.baseCapacity + arg_65_0.extraCapacity)
		end
	end

	arg_65_0.scrollRect:SetTotalCount(#arg_65_0.displays, -1)
	arg_65_0:FlushShelfs()
	arg_65_0:FlushEstimate()

	return
end

function var_0_0.GetAutoShipIds(arg_66_0)
	local var_66_0 = underscore.select(getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShips(), function(arg_67_0)
		return arg_67_0:IsDelegable()
	end)

	table.sort(var_66_0, CompareFuncs({
		function(arg_68_0)
			return arg_66_0:GetEffectiveManangeUnlockSkill(arg_68_0) and 0 or 1
		end,
		function(arg_69_0)
			return -underscore.reduce(IslandBuffHelper.GetShipBuffsByType({
				arg_69_0
			}, IslandBuffType.SHIP_MANAGE_SELL_PRICE), 0, function(arg_70_0, arg_70_1)
				return arg_70_0 + arg_70_1:GetBuffEffect()[2]
			end)
		end,
		function(arg_71_0)
			return -underscore.reduce(IslandBuffHelper.GetShipBuffsByType({
				arg_71_0
			}, IslandBuffType.SHIP_MANAGE_SELL_NUM), 0, function(arg_72_0, arg_72_1)
				return arg_72_0 + arg_72_1:GetBuffEffect()[2]
			end)
		end,
		function(arg_73_0)
			return arg_73_0.id
		end
	}))

	for iter_66_0 = 1, #arg_66_0.assistantsData do
		if var_66_0[iter_66_0] then
			table.insert({}, var_66_0[iter_66_0].id)
		end
	end

	if #{} == 0 and #arg_66_0.assistantsData > 0 then
		table.insert({}, IslandCharacterAgency.NPC_CONFIG_ID)
	end

	return {}
end

function var_0_0.FlushBtns(arg_74_0)
	local var_74_0 = arg_74_0.rest:GetStatus()

	eachChild(arg_74_0.btnsTF, function(arg_75_0)
		setActive(arg_75_0, arg_75_0.name == var_74_0)

		return
	end)

	if arg_74_0.rest:GetStatus() == IslandRestaurant.STATUS.OPENING then
		if not arg_74_0.timer then
			arg_74_0:StartTimer()
			arg_74_0:UpdateTime()
		end
	else
		arg_74_0:StopTimer()
	end

	setActive(arg_74_0.buffInfoBtn, arg_74_0.isOperable)

	return
end

function var_0_0.UpdateTime(arg_76_0)
	local var_76_0 = pg.TimeMgr.GetInstance()
	local var_76_1 = arg_76_0.rest:GetEndTime() - var_76_0:GetServerTime()

	setText(arg_76_0.btnsTF:Find("opening/time"), var_76_0:DescCDTime(var_76_1))

	if var_76_1 <= 0 then
		arg_76_0:FlushBtns()
	end

	return
end

function var_0_0.StartTimer(arg_77_0)
	arg_77_0.timer = Timer.New(function()
		arg_77_0:UpdateTime()

		return
	end, 1, -1)

	arg_77_0.timer:Start()

	return
end

function var_0_0.StopTimer(arg_79_0)
	if arg_79_0.timer ~= nil then
		arg_79_0.timer:Stop()

		arg_79_0.timer = nil
	end

	return
end

function var_0_0.OnHide(arg_80_0)
	arg_80_0:StopTimer()

	if arg_80_0.statusCheckTimer then
		arg_80_0.statusCheckTimer:Stop()

		arg_80_0.statusCheckTimer = nil
	end

	arg_80_0:UnBlurPanel()

	return
end

function var_0_0.OnDisable(arg_81_0)
	arg_81_0:OnHide()

	return
end

function var_0_0.OnDestroy(arg_82_0)
	ClearLScrollrect(arg_82_0.scrollRect)
	arg_82_0:OnHide()

	return
end

function var_0_0.CaclShipAttrFactors(arg_83_0, arg_83_1)
	local var_83_0 = 0

	for iter_83_0, iter_83_1 in ipairs(arg_83_0) do
		var_83_0 = var_83_0 + pg.island_chara_att[iter_83_1:GetAttrGrade(IslandShipAttr.GetAtrrName(arg_83_1))].manage_effect / 16
	end

	return var_83_0
end

return var_0_0
