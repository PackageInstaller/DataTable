local IslandRestaurantPage = class("IslandRestaurantPage", import("...base.IslandBasePage"))

IslandRestaurantPage.MAX_ASSISTANT_CNT = 2
IslandRestaurantPage.MAX_SHELF_CNT = 5

local var_0_1 = Vector3(-210, 50)
local var_0_2 = pg.island_item_data_template
local var_0_3 = pg.island_set

function IslandRestaurantPage:getUIName()
	return "IslandRestaurantUI"
end

function IslandRestaurantPage:OnLoaded()
	setText(self._tf:Find("top/title/Text"), i18n("island_manage_title"))

	self.rankTF = self._tf:Find("rank")
	self.rankIcon = self.rankTF:Find("icon")
	self.rankSlider = self.rankTF:Find("exp")
	self.rankText = self.rankTF:Find("exp/progress")
	self.eventContainer = self._tf:Find("content/event_container")
	self.eventTitleTF = self.eventContainer:Find("event/title")
	self.eventDescTF = self.eventContainer:Find("event/desc/Text")

	setText(self.eventContainer:Find("event/desc/effect"), "")

	self.itemsList = UIItemList.New(self._tf:Find("content/event_container/event/items"), self._tf:Find("content/event_container/event/items/tpl"))
	self.additionList = UIItemList.New(self._tf:Find("content/event_container/event/addition"), self._tf:Find("content/event_container/event/addition/tpl"))
	self.windowContainer = self._tf:Find("content/window_container")

	local var_2_0 = self.windowContainer:Find("window")

	self.nameTF = var_2_0:Find("name/Text")
	self.nameEnTF = var_2_0:Find("name_en/Text")

	local var_2_1 = var_2_0:Find("left/content")

	self.shipUIList = UIItemList.New(var_2_1, var_2_1:Find("tpl"))

	setText(var_2_1:Find("tpl/empty/Image/Text"), i18n("island_manage_sel_worker"))
	setText(var_2_1:Find("tpl/lock/Image/Text"), i18n("island_manage_upgrade_worker_level"))
	setText(var_2_1:Find("tpl/ship/skill/invalid/Text"), i18n("island_manage_skill_cant_use"))

	self.commoditiesTF = var_2_0:Find("right/commodities")
	self.commoditiesEmptyTF = var_2_0:Find("right/commodities_empty")

	setText(self.commoditiesEmptyTF, i18n("island_manage_stock_out"))

	self.scrollRect = self.commoditiesTF:GetComponent("LScrollRect")
	self.detailPanel = var_2_0:Find("right/detail")
	self.detailNameTF = self.detailPanel:Find("dot/name")
	self.detailPriceTF = self.detailPanel:Find("price/value")
	self.detailDescTF = self.detailPanel:Find("desc")
	self.detailEffectTF = self.detailPanel:Find("effect/Text")
	self.shelfsTF = var_2_0:Find("right/shelfs")

	setText(self.shelfsTF:Find("infos/tip"), i18n("island_manage_item_select"))

	self.extraCapacityTF = self.shelfsTF:Find("infos/capacity")

	setText(self.extraCapacityTF:Find("name"), i18n("island_manage_capacity"))

	self.extraCapacityEffectTF = self.extraCapacityTF:Find("effect")
	self.shelfUIList = UIItemList.New(self.shelfsTF:Find("content"), self.shelfsTF:Find("content/tpl"))

	local var_2_2 = var_2_0:Find("estimate")

	setText(var_2_2:Find("Text"), i18n("island_manage_predict_saleroom"))
	setText(var_2_2:Find("count/Text"), i18n("island_manage_cnt"))
	setText(var_2_2:Find("sales/Text"), i18n("island_manage_saleroom") .. ":")

	self.estimateCntTF = var_2_2:Find("count/value")
	self.estimateSalesTF = var_2_2:Find("sales/value")
	self.buffInfoBtn = var_2_2:Find("info")
	self.buffInfoPanel = var_2_2:Find("info_panel")

	setText(self.buffInfoPanel:Find("Text"), i18n("island_manage_addition"))

	self.buffInfoUIList = UIItemList.New(self.buffInfoPanel:Find("effects"), self.buffInfoPanel:Find("effects/tpl"))
	self.buffInfoEmptyTF = self.buffInfoPanel:Find("empty")

	setText(self.buffInfoEmptyTF:Find("Text"), i18n("island_manage_no_addition"))
	setText(self.buffInfoPanel:Find("tips"), i18n("island_manage_buff_tip"))

	self.btnsTF = var_2_0:Find("btns")
	self.openBtn = self.btnsTF:Find("prepare/open"), setText(self.btnsTF:Find("prepare/auto/Text"), i18n("island_manage_auto_work"))

	setText(self.btnsTF:Find("prepare/open/Text"), i18n("island_manage_start_work"))
	setText(self.btnsTF:Find("opening/Text"), i18n("island_manage_working"))
	setText(self.btnsTF:Find("close/Text"), i18n("island_manage_result"))
	setText(self.btnsTF:Find("end/Text"), i18n("island_manage_end_daily_work"))
	setText(self._tf:Find("content/event_container/event/title/Text"), i18n("island_post_event_addition_label"))

	self.ticketBtn = self.btnsTF:Find("opening/ticket")

	return
end

function IslandRestaurantPage:OnInit()
	onButton(self, self._tf:Find("top/title/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.island_help_manage.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("top/back"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.rankTF, function()
		self:OpenPage(IslandRestaurantRankPage, self.restId)

		return
	end, SFX_PANEL)
	onButton(self, self.btnsTF:Find("prepare/auto"), function()
		if not self.isOperable then
			return
		end

		self:OnAutoSelect()

		return
	end, SFX_PANEL)
	onButton(self, self.openBtn, function()
		local var_8_0 = {}

		for iter_8_0, iter_8_1 in ipairs(self.assistantsData) do
			var_8_0[iter_8_1.id] = self.selectedShipIds[iter_8_0]
		end

		self:emit(IslandMediator.OPEN_RESTAURANT, {
			restId = self.restId,
			ships = var_8_0,
			commodities = self.selectedDic,
			estimateData = {
				trade_id = self.restId,
				sell_num_min = self.totalMinCnt,
				sell_num_max = self.totalMaxCnt,
				sell_money_min = self.totalMinSales,
				sell_money_max = self.totalMaxSales
			}
		})

		return
	end, SFX_PANEL)
	onButton(self, self.btnsTF:Find("close"), function()
		self:emit(IslandMediator.CLOSE_RESTAURANT, self.restId, self.isPost)

		return
	end, SFX_PANEL)
	onButton(self, self.buffInfoBtn, function()
		if isActive(self.buffInfoPanel) then
			setActive(self.buffInfoPanel, false)
		else
			setActive(self.buffInfoPanel, true)
			self.buffInfoUIList:align(#self.buffInfos)
			setActive(self.buffInfoEmptyTF, #self.buffInfos == 0)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.ticketBtn, function()
		self:OpenPage(IslandTicketUsePage, IslandUseTicketCommand.TYPES.MANAGE, self.restId)

		return
	end, SFX_PANEL)
	self.shipUIList:make(function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0 == UIItemList.EventUpdate then
			self:UpdateShipItem(arg_12_1, arg_12_2)
		end

		return
	end)

	function self.scrollRect.onInitItem(arg_13_0)
		self:OnInitItem(arg_13_0)

		return
	end

	function self.scrollRect.onUpdateItem(arg_14_0, arg_14_1)
		self:OnUpdateItem(arg_14_0, arg_14_1)

		return
	end

	self.shelfUIList:make(function(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_0 == UIItemList.EventUpdate then
			self:UpdateShelfItem(arg_15_1, arg_15_2)
		end

		return
	end)
	self.buffInfoUIList:make(function(arg_16_0, arg_16_1, arg_16_2)
		if arg_16_0 == UIItemList.EventUpdate then
			setText(arg_16_2:Find("bg/name"), self.buffInfos[arg_16_1 + 1].name)
			setText(arg_16_2:Find("bg/effect"), self.buffInfos[arg_16_1 + 1].effect)
		end

		return
	end)

	self.priceFactor = var_0_3.island_manage_price_coefficient.key_value_int / 100
	self.argA = var_0_3.island_manage_sale_coefficient_a.key_value_int / 100
	self.argB = var_0_3.island_manage_sale_coefficient_b.key_value_int / 100
	self.argC = var_0_3.island_manage_sale_coefficient_c.key_value_int / 100
	self.saleConst = var_0_3.island_manage_sale_constant.key_value_int / 100
	self.maxAttrEffect = pg.island_chara_att[1].manage_effect / 16
	self.minSaleCnt = var_0_3.island_manage_sale_limit.key_value_int

	return
end

function IslandRestaurantPage:AddListeners()
	self:AddListener(GAME.ISLAND_OPEN_RESTAURANT_DONE, self.Flush)
	self:AddListener(GAME.ISLAND_CLOSE_RESTAURANT_DONE, self.Flush)
	self:AddListener(IslandManageAgecny.ON_DAILY_REFRESH, self.Flush)

	return
end

function IslandRestaurantPage:RemoveListeners()
	self:RemoveListener(GAME.ISLAND_OPEN_RESTAURANT_DONE, self.Flush)
	self:RemoveListener(GAME.ISLAND_CLOSE_RESTAURANT_DONE, self.Flush)
	self:RemoveListener(IslandManageAgecny.ON_DAILY_REFRESH, self.Flush)

	return
end

function IslandRestaurantPage:OnInitItem(arg_19_1)
	local var_19_0 = IslandFoodCard.New(arg_19_1)

	onButton(self, var_19_0._go, function()
		if isActive(self.detailPanel) then
			setActive(self.detailPanel, false)
		end

		if not self.isOperable then
			return
		end

		self:AddOnShelf(var_19_0)

		return
	end, SFX_PANEL)

	self.cards[arg_19_1] = var_19_0

	return
end

function IslandRestaurantPage:AddOnShelf(arg_21_1)
	if #self.shelfInfos >= self.shelfCnt then
		return
	end

	local var_21_0 = math.min(arg_21_1.item:GetCount(), self.baseCapacity + self.extraCapacity)

	self.selectedDic[arg_21_1.item.id] = var_21_0

	arg_21_1:UpdateSelectedCnt(var_21_0)
	self:FlushShelfs()
	self:FlushEstimate()

	return
end

function IslandRestaurantPage:ShowDetailPanel(arg_22_1, arg_22_2)
	setAnchoredPosition(self.detailPanel, arg_22_2 + var_0_1)
	setActive(self.detailPanel, true)
	setText(self.detailNameTF, arg_22_1:GetName())
	setText(self.detailPriceTF, (math.floor(arg_22_1:getConfig("order_price") * self.priceFactor)))
	setText(self.detailDescTF, arg_22_1:GetDesc())
	setText(self.detailEffectTF, i18n("island_manage_attr_effect") .. IslandShipAttr.ATTRS_CH[1] .. "、" .. IslandShipAttr.ToChinese((IslandShipAttr.GetAtrrName(arg_22_1:getConfig("sub_attribute")[1]))))

	return
end

function IslandRestaurantPage:OnUpdateItem(arg_23_1, arg_23_2)
	local var_23_0 = self.cards[arg_23_2]

	if not self.cards[arg_23_2] then
		self:OnInitItem(arg_23_2)

		var_23_0 = self.cards[arg_23_2]
	end

	local var_23_1 = self.displays[arg_23_1 + 1]

	if self.displays[arg_23_1 + 1] then
		var_23_0:Update(var_23_1, self.isOperable and (self.selectedDic and self.selectedDic[var_23_1.id] or nil) and (self.selectedDic[var_23_1.id] or 0) or 0, self.eventEffects[var_23_1.id], (self:GetAttrsFactorsRatio(var_23_1.id)))
	end

	local var_23_3 = self.detailPanel.parent:InverseTransformPoint(var_23_0._tf.position)

	GetOrAddComponent(var_23_0._go, typeof(UILongPressTrigger)).onLongPressed:AddListener(function()
		self:ShowDetailPanel(var_23_0.item, var_23_3)

		return
	end)

	return
end

function IslandRestaurantPage:UpdateCardWithItemId(arg_25_1)
	for iter_25_0, iter_25_1 in pairs(self.cards) do
		if iter_25_1.item.id == arg_25_1 then
			iter_25_1:UpdateSelectedCnt(self.selectedDic[arg_25_1] or 0)
		end
	end

	return
end

function IslandRestaurantPage:OnShow(arg_26_1, arg_26_2)
	self:BlurPanel()
	setActive(self.buffInfoPanel, false)

	self.restId = arg_26_1
	self.isPost = arg_26_2
	self.cards = {}

	self:Flush()

	return
end

function IslandRestaurantPage:OnEnable()
	self:Flush()

	return
end

function IslandRestaurantPage:Flush()
	self:FlushData()
	self:FlushName()
	self:FlushRank()
	self:FlushEvent()

	self.selectedShipIds = nil

	self:FlushAssistants()

	self.selectedDic = nil

	self:FlushCards()
	self:FlushShelfs()
	self:FlushEstimate()
	self:FlushBtns()

	return
end

function IslandRestaurantPage:FlushData()
	self.rest = getProxy(IslandProxy):GetIsland():GetManageAgency():GetRestaurant(self.restId)
	self.shelfCnt = self.rest:GetShelfCnt()
	self.assistantsData = self.rest:GetAssistants()
	self.baseCapacity = self.rest:GetBaseShelfCapacity()
	self.extraCapacity = 0
	self.isOperable = self.rest:GetStatus() == IslandRestaurant.STATUS.PREPARE

	return
end

function IslandRestaurantPage:FlushName()
	setText(self.nameTF, self.rest:getConfig("name"))
	setText(self.nameEnTF, self.rest:getConfig("name_en"))

	return
end

function IslandRestaurantPage:FlushRank()
	LoadImageSpriteAsync("island/islandrestaurant/" .. self.rest:GetRankIcon(), self.rankIcon)

	local var_31_0 = self.rest:GetSales()
	local var_31_1 = self.rest:GetCanUpgradeExp()

	setText(self.rankText, var_31_0 .. "/" .. var_31_1)
	setSlider(self.rankSlider, 0, 1, var_31_1 == 0 and 0 or var_31_0 / var_31_1)

	return
end

function IslandRestaurantPage:FlushEvent()
	self.eventId, self.eventEffects, self.eventInfluence = self.rest:GetEventInfo()

	setActive(self.eventContainer, self.eventId ~= 0)

	if self.eventId ~= 0 then
		setText(self.eventTitleTF, pg.island_manage_event[self.eventId].name)
		setText(self.eventDescTF, string.gsub(pg.island_manage_event[self.eventId].desc, "$1", self.rest:getConfig("name")))
		self:UpdateAddition(self.rest)
	end

	return
end

function IslandRestaurantPage:UpdateAddition(arg_33_1)
	local var_33_0 = self:WarpItemInfo(arg_33_1)

	self.itemsList:make(function(arg_34_0, arg_34_1, arg_34_2)
		if arg_34_0 == UIItemList.EventUpdate then
			updateCustomDrop(arg_34_2, (Drop.New({
				count = 0,
				type = DROP_TYPE_ISLAND_ITEM,
				id = var_33_0[arg_34_1 + 1].id
			})))
		end

		return
	end)
	self.itemsList:align(#var_33_0)

	local var_33_1 = self:WarpAdditionInfo(pg.island_manage_event[arg_33_1:GetEventInfo()])

	self.additionList:make(function(arg_35_0, arg_35_1, arg_35_2)
		if arg_35_0 == UIItemList.EventUpdate then
			setText(arg_35_2:Find("Text"), var_33_1[arg_35_1 + 1][1])
			setText(arg_35_2:Find("value"), "+" .. var_33_1[arg_35_1 + 1][2] .. "%")
		end

		return
	end)
	self.additionList:align(#var_33_1)

	return
end

function IslandRestaurantPage:WarpItemInfo(arg_36_1)
	local var_36_0 = {}
	local var_36_1, var_36_2 = arg_36_1:GetEventInfo()
	local var_36_3 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()

	for iter_36_0, iter_36_1 in ipairs(arg_36_1:getConfig("item_id")) do
		local var_36_4 = var_36_3:GetItemById(iter_36_1[1]) or IslandItem.New({
			id = iter_36_1[1]
		})

		if var_36_4 and var_36_2[var_36_4.id] then
			table.insert(var_36_0, var_36_4)
		end
	end

	return var_36_0
end

function IslandRestaurantPage:WarpAdditionInfo(arg_37_1)
	local var_37_0 = {}

	table.insert(var_37_0, {
		i18n("island_addition_influence"),
		arg_37_1.influence_bonus
	})
	table.insert(var_37_0, {
		i18n("island_addition_sale"),
		arg_37_1.event_effect[1][1]
	})

	return var_37_0
end

function IslandRestaurantPage:FlushAssistants()
	if not self.selectedShipIds then
		local var_38_0 = getProxy(IslandProxy):GetIsland():GetCharacterAgency()

		self.selectedShipIds = {}

		for iter_38_0, iter_38_1 in ipairs(self.assistantsData) do
			if iter_38_1.shipId ~= 0 then
				table.insert(self.selectedShipIds, iter_38_1.shipId)
			end
		end
	end

	self.selectedShips = {}

	local var_38_1 = getProxy(IslandProxy):GetIsland():GetCharacterAgency()

	for iter_38_2, iter_38_3 in ipairs(self.selectedShipIds) do
		table.insert(self.selectedShips, var_38_1:GetShipById(iter_38_3))
	end

	self.shipUIList:align(IslandRestaurantPage.MAX_ASSISTANT_CNT)

	self.extraPricePer = 0
	self.extraCapacity = 0
	self.buffInfos = {}

	for iter_38_4, iter_38_5 in ipairs((IslandBuffHelper.GetManageSellPriceBuffs(self.selectedShips, self.restId))) do
		local var_38_2 = iter_38_5:GetBuffEffect()[2]

		table.insert(self.buffInfos, {
			name = i18n("island_manage_saleroom"),
			effect = "+" .. var_38_2 .. "%"
		})

		self.extraPricePer = self.extraPricePer + var_38_2 / 100
	end

	for iter_38_6, iter_38_7 in ipairs((IslandBuffHelper.GetManageSellNumBuffs(self.selectedShips, self.restId))) do
		local var_38_3 = iter_38_7:GetBuffEffect()[2]

		table.insert(self.buffInfos, {
			name = i18n("island_manage_capacity"),
			effect = "+" .. var_38_3
		})

		self.extraCapacity = self.extraCapacity + var_38_3
	end

	if self.statusCheckTimer then
		self.statusCheckTimer:Stop()
	end

	if self.isOperable then
		self.shipStatus = IslandBuffHelper.GetManageStatus(self.selectedShips, self.restId)

		if #self.shipStatus > 0 then
			self.statusCheckTimer = Timer.New(function()
				if underscore.reduce(self.shipStatus, 0, function(arg_40_0, arg_40_1)
					return arg_40_0 + (arg_40_1:IsExpiration() and 1 or 0)
				end) > 0 then
					self:OnStatusExpired()
				end

				return
			end, 1, -1)

			self.statusCheckTimer:Start()
		end
	end

	setActive(self.extraCapacityTF, self.isOperable and self.extraCapacity > 0)
	setText(self.extraCapacityEffectTF, "+" .. self.extraCapacity)
	self.buffInfoUIList:align(#self.buffInfos)
	setActive(self.buffInfoEmptyTF, #self.buffInfos == 0)

	local var_38_4 = self.shelfInfos

	if self.shelfInfos then
		if #self.shelfInfos > 0 then
			var_38_4 = self.selectedShipIds and #self.selectedShipIds > 0
		end
	end

	setGray(self.openBtn, not var_38_4, true)
	setButtonEnabled(self.openBtn, var_38_4)

	return
end

function IslandRestaurantPage:GetEffectiveManangeSkill(arg_41_1)
	local var_41_0 = arg_41_1:GetSkill()

	return var_41_0:IsEffectiveInRest(self.restId) and var_41_0 or nil
end

function IslandRestaurantPage:GetEffectiveManangeUnlockSkill(arg_42_1)
	local var_42_0 = self:GetEffectiveManangeSkill(arg_42_1)

	return var_42_0 and var_42_0:IsUnlock() and var_42_0 or nil
end

function IslandRestaurantPage:UpdateShipItem(arg_43_1, arg_43_2)
	arg_43_2.name = arg_43_1 + 1

	local var_43_0 = arg_43_1 + 1 <= #self.assistantsData

	setActive(arg_43_2:Find("lock"), not (arg_43_1 + 1 <= #self.assistantsData))
	setActive(arg_43_2:Find("empty"), var_43_0 and not self.selectedShips[arg_43_1 + 1])
	setActive(arg_43_2:Find("ship"), var_43_0 and self.selectedShips[arg_43_1 + 1])
	onButton(self, arg_43_2, function()
		if not var_43_0 or not self.isOperable then
			return
		end

		self:OpenPage(IslandShipSelectPage, {
			showBenefits = true,
			showType = IslandSelectShipCard.SHOW_TYPE.RESTAURANT,
			restId = self.restId,
			selectNum = #self.assistantsData,
			selectedIds = Clone(self.selectedShipIds),
			attrType = IslandShipAttr.MANAGE_KEY,
			confirmFunc = function(arg_45_0)
				self:OnSelectedShipsDone(arg_45_0)

				return
			end,
			emptyInfoTitle = self.rest:getConfig("name")
		})

		return
	end, SFX_PANEL)

	if self.selectedShips[arg_43_1 + 1] then
		local var_43_1 = arg_43_2:Find("ship")

		setText(var_43_1:Find("name"), self.selectedShips[arg_43_1 + 1]:GetName())

		local var_43_2 = self:GetEffectiveManangeSkill(self.selectedShips[arg_43_1 + 1])

		setActive(var_43_1:Find("skill"), var_43_2 and var_43_2:IsUnlock())
		setActive(var_43_1:Find("skill_lock"), var_43_2 and not var_43_2:IsUnlock())
		GetImageSpriteFromAtlasAsync("ShipYardIcon/" .. IslandShip.StaticGetPrefab(self.selectedShips[arg_43_1 + 1].id), "", var_43_1:Find("icon"))

		local var_43_3 = var_43_1:Find("skill")

		if var_43_2 then
			if var_43_2:IsUnlock() then
				setActive(var_43_3:Find("effects"), true)
				setActive(var_43_3:Find("invalid"), false)
				LoadImageSpriteAsync("island/islandskillicon/" .. var_43_2:GetIcon(), var_43_3:Find("skill_icon"))
				setText(var_43_3:Find("skill_name"), var_43_2:GetName())

				local var_43_4 = IslandBuffHelper.GetAllShipManageBuffs(self.selectedShips[arg_43_1 + 1], self.restId)

				UIItemList.StaticAlign(var_43_3:Find("effects"), var_43_3:Find("effects/tpl"), #var_43_4, function(arg_46_0, arg_46_1, arg_46_2)
					if arg_46_0 == UIItemList.EventUpdate then
						local var_46_0 = var_43_4[arg_46_1 + 1]:GetBuffType()
						local var_46_1 = ""
						local var_46_2 = ""

						if var_46_0 == IslandBuffType.SHIP_MANAGE_SELL_PRICE then
							var_46_1 = i18n("island_manage_saleroom")
							var_46_2 = "+" .. var_43_4[arg_46_1 + 1]:GetBuffEffect()[2] .. "%"
						elseif var_46_0 == IslandBuffType.SHIP_MANAGE_SELL_NUM then
							var_46_1 = i18n("island_manage_capacity")
							var_46_2 = "+" .. var_43_4[arg_46_1 + 1]:GetBuffEffect()[2]
						end

						setText(arg_46_2:Find("name"), var_46_1)
						setText(arg_46_2:Find("effect"), var_46_2)
					end

					return
				end)
			else
				setText(var_43_1:Find("skill_lock/Image/Text"), i18n("island_need_star_1", self.selectedShips[arg_43_1 + 1]:GetSkillUnlockLevel()))
			end
		else
			local var_43_5 = self.selectedShips[arg_43_1 + 1]:GetSkill()

			setActive(var_43_1:Find("skill"), true)
			LoadImageSpriteAsync("island/islandskillicon/" .. var_43_5:GetIcon(), var_43_3:Find("skill_icon"))
			setText(var_43_3:Find("skill_name"), var_43_5:GetName())
			setActive(var_43_3:Find("effects"), false)
			setActive(var_43_3:Find("invalid"), true)
		end
	end

	return
end

function IslandRestaurantPage:FlushCards()
	self.displays = {}

	local var_47_0 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()

	for iter_47_0, iter_47_1 in ipairs(self.rest:getConfig("item_id")) do
		local var_47_1 = var_47_0:GetItemById(iter_47_1[1])

		if var_47_1 then
			table.insert(self.displays, var_47_1)
		end
	end

	setActive(self.commoditiesEmptyTF, #self.displays <= 0)
	setActive(self.commoditiesTF, #self.displays > 0)
	self:CaclAttrsFactors()

	if #self.displays > 0 then
		self:SortDisplays()
	end

	return
end

function IslandRestaurantPage:SortDisplays()
	table.sort(self.displays, CompareFuncs({
		function(arg_49_0)
			return -self.subAttrFactorsDic[arg_49_0.id]
		end,
		function(arg_50_0)
			return -arg_50_0:getConfig("order_price") * self.priceFactor
		end,
		function(arg_51_0)
			return arg_51_0.id
		end
	}))

	if self:isShowing() then
		self.scrollRect:SetTotalCount(#self.displays, -1)
	end

	return
end

function IslandRestaurantPage:CaclAttrsFactors()
	self.subAttrFactorsDic = {}
	self.mainAttrFactorsDic = {}

	for iter_52_0, iter_52_1 in ipairs(self.displays) do
		local var_52_0 = iter_52_1:getConfig("sub_attribute")[1]

		self.subAttrFactorsDic[iter_52_1.id] = var_52_0 and IslandRestaurantPage.CaclShipAttrFactors(self.selectedShips, var_52_0) or 0
		self.mainAttrFactorsDic[iter_52_1.id] = IslandRestaurantPage.CaclShipAttrFactors(self.selectedShips, IslandShipAttr.MANAGE_KEY)
	end

	return
end

function IslandRestaurantPage:GetSubAttrFactors(arg_53_1)
	if self.subAttrFactorsDic[arg_53_1] then
		return self.subAttrFactorsDic[arg_53_1]
	end

	self.subAttrFactorsDic[arg_53_1] = var_0_2[arg_53_1].sub_attribute[1] and IslandRestaurantPage.CaclShipAttrFactors(self.selectedShips, var_0_2[arg_53_1].sub_attribute[1]) or 0

	return self.subAttrFactorsDic[arg_53_1]
end

function IslandRestaurantPage:GetMainAttrFactors(arg_54_1)
	if self.mainAttrFactorsDic[arg_54_1] then
		return self.mainAttrFactorsDic[arg_54_1]
	end

	self.mainAttrFactorsDic[arg_54_1] = IslandRestaurantPage.CaclShipAttrFactors(self.selectedShips, IslandShipAttr.MANAGE_KEY)

	return self.mainAttrFactorsDic[arg_54_1]
end

function IslandRestaurantPage:GetAttrsFactorsRatio(arg_55_1)
	return #self.assistantsData * (self.maxAttrEffect + self.maxAttrEffect * (var_0_2[arg_55_1].sub_attribute[2] / 100)) == 0 and 0 or (self:GetMainAttrFactors(arg_55_1) + self:GetSubAttrFactors(arg_55_1) * (var_0_2[arg_55_1].sub_attribute[2] / 100)) / (#self.assistantsData * (self.maxAttrEffect + self.maxAttrEffect * (var_0_2[arg_55_1].sub_attribute[2] / 100)))
end

function IslandRestaurantPage:FlushShelfs()
	if not self.selectedDic then
		self.selectedDic = {}

		for iter_56_0, iter_56_1 in ipairs(self.rest:GetCommondities()) do
			self.selectedDic[iter_56_1.id] = iter_56_1.num
		end
	end

	self.shelfInfos = {}

	for iter_56_2, iter_56_3 in pairs(self.selectedDic) do
		table.insert(self.shelfInfos, {
			id = iter_56_2,
			num = iter_56_3
		})
	end

	self.shelfUIList:align(IslandRestaurantPage.MAX_SHELF_CNT)

	local var_56_0 = self.shelfInfos

	if self.shelfInfos then
		if #self.shelfInfos > 0 then
			var_56_0 = self.selectedShipIds and #self.selectedShipIds > 0
		end
	end

	setGray(self.openBtn, not var_56_0, true)
	setButtonEnabled(self.openBtn, var_56_0)

	return
end

function IslandRestaurantPage:UpdateShelfItem(arg_57_1, arg_57_2)
	arg_57_2.name = arg_57_1 + 1

	local var_57_0 = arg_57_1 + 1 <= self.shelfCnt

	setActive(arg_57_2:Find("lock"), not (arg_57_1 + 1 <= self.shelfCnt))

	local var_57_1 = self.shelfInfos[arg_57_1 + 1]

	setActive(arg_57_2:Find("empty"), var_57_0 and not var_57_1)
	setActive(arg_57_2:Find("commodity"), var_57_0 and var_57_1)

	if var_57_1 then
		local var_57_2 = arg_57_2:Find("commodity")

		LoadImageSpriteAsync("island/" .. var_0_2[var_57_1.id].icon, var_57_2:Find("bg/icon"))

		local var_57_3 = self.baseCapacity + self.extraCapacity

		if self.isOperable then
			setText(var_57_2:Find("count/Text"), var_57_1.num .. "/" .. (self.extraCapacity > 0 and setColorStr(var_57_3, "#7BF59DFF") or var_57_3))
		else
			setText(var_57_2:Find("count/Text"), var_57_1.num)
		end

		setActive(var_57_2:Find("event"), self.eventEffects[var_57_1.id])
		setFillAmount(var_57_2:Find("bg/silder/bar"), (self:GetAttrsFactorsRatio(var_57_1.id)))
		setActive(var_57_2:Find("reduce"), self.isOperable)
		onButton(self, var_57_2:Find("reduce"), function()
			if not self.isOperable then
				return
			end

			self:ReduceShelfCnt(var_57_1.id, 1)
			self:FlushEstimate()

			return
		end, SFX_PANEL)

		if var_57_3 < var_57_1.num then
			self:ReduceShelfCnt(var_57_1.id, var_57_1.num - var_57_3)
			self:FlushEstimate()
		end
	end

	return
end

function IslandRestaurantPage:ReduceShelfCnt(arg_59_1, arg_59_2)
	self.selectedDic[arg_59_1] = self.selectedDic[arg_59_1] - arg_59_2

	if self.selectedDic[arg_59_1] <= 0 then
		self.selectedDic[arg_59_1] = nil
	end

	self:UpdateCardWithItemId(arg_59_1)
	self:FlushShelfs()

	return
end

function IslandRestaurantPage:FlushEstimate()
	local var_60_0 = self.rest:GetStatus()

	if var_60_0 == IslandRestaurant.STATUS.OPENING or var_60_0 == IslandRestaurant.STATUS.CLOSE then
		local var_60_1 = self.rest:GetEstimateData()

		setText(self.estimateCntTF, var_60_1.cntMin .. "-" .. var_60_1.cntMax)
		setText(self.estimateSalesTF, var_60_1.salesMin .. "-" .. var_60_1.salesMax)
	else
		local var_60_2, var_60_3 = self.rest:GetRandomSaleCntBound()

		self.totalMinCnt, self.totalMaxCnt, self.totalMinSales, self.totalMaxSales = 0, 0, 0, 0

		for iter_60_0, iter_60_1 in pairs(self.selectedDic) do
			local var_60_4 = self:CaclBaseSaleCnt(iter_60_0)
			local var_60_5 = math.min(iter_60_1, math.max(self.minSaleCnt, var_60_4 + var_60_2))
			local var_60_6 = math.min(iter_60_1, math.max(self.minSaleCnt, var_60_4 + var_60_3))

			self.totalMinSales = self.totalMinSales + self:CaclGroupPrice(iter_60_0, var_60_5)
			self.totalMaxSales = self.totalMaxSales + self:CaclGroupPrice(iter_60_0, var_60_6)
			self.totalMinCnt = self.totalMinCnt + var_60_5
			self.totalMaxCnt = self.totalMaxCnt + var_60_6
		end

		setText(self.estimateCntTF, self.totalMinCnt .. "-" .. self.totalMaxCnt)
		setText(self.estimateSalesTF, self.totalMinSales .. "-" .. self.totalMaxSales)
	end

	return
end

function IslandRestaurantPage:CaclBaseSaleCnt(arg_61_1)
	return math.floor((var_0_2[arg_61_1].manage_influence / 100 + ((self.eventEffects[arg_61_1] or nil) and (self.eventInfluence or 0))) * (self.argA + self:GetMainAttrFactors(arg_61_1)) * (self.argB + self:GetSubAttrFactors(arg_61_1) * (var_0_2[arg_61_1].sub_attribute[2] / 100)) * (self.argC + self.rest:GetRankFactor()) / self.saleConst)
end

function IslandRestaurantPage:CaclGroupPrice(arg_62_1, arg_62_2)
	return math.floor(var_0_2[arg_62_1].order_price * self.priceFactor * arg_62_2 * (1 + (self.eventEffects[arg_62_1] or 0) + self.extraPricePer))
end

function IslandRestaurantPage:OnStatusExpired()
	self:FlushAssistants()
	self:FlushCards()
	self:FlushShelfs()
	self:FlushEstimate()

	return
end

function IslandRestaurantPage:OnSelectedShipsDone(arg_64_1)
	self.selectedShipIds = arg_64_1

	self:FlushAssistants()
	self:FlushCards()
	self:FlushShelfs()
	self:FlushEstimate()

	return
end

function IslandRestaurantPage:OnAutoSelect()
	self.selectedShipIds = self:GetAutoShipIds()

	self:FlushAssistants()
	self:FlushCards()

	self.selectedDic = {}

	for iter_65_0 = 1, self.shelfCnt do
		if self.displays[iter_65_0] then
			self.selectedDic[self.displays[iter_65_0].id] = math.min(self.displays[iter_65_0]:GetCount(), self.baseCapacity + self.extraCapacity)
		end
	end

	self.scrollRect:SetTotalCount(#self.displays, -1)
	self:FlushShelfs()
	self:FlushEstimate()

	return
end

function IslandRestaurantPage:GetAutoShipIds()
	local var_66_0 = underscore.select(getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShips(), function(arg_67_0)
		return arg_67_0:IsDelegable()
	end)

	table.sort(var_66_0, CompareFuncs({
		function(arg_68_0)
			return self:GetEffectiveManangeUnlockSkill(arg_68_0) and 0 or 1
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

	local var_66_1 = {}

	for iter_66_0 = 1, #self.assistantsData do
		if var_66_0[iter_66_0] then
			table.insert(var_66_1, var_66_0[iter_66_0].id)
		end
	end

	if #var_66_1 == 0 and #self.assistantsData > 0 then
		table.insert(var_66_1, IslandCharacterAgency.NPC_CONFIG_ID)
	end

	return var_66_1
end

function IslandRestaurantPage:FlushBtns()
	local var_74_0 = self.rest:GetStatus()

	eachChild(self.btnsTF, function(arg_75_0)
		setActive(arg_75_0, arg_75_0.name == var_74_0)

		return
	end)

	if var_74_0 == IslandRestaurant.STATUS.OPENING then
		if not self.timer then
			self:StartTimer()
			self:UpdateTime()
		end
	else
		self:StopTimer()
	end

	setActive(self.buffInfoBtn, self.isOperable)

	return
end

function IslandRestaurantPage:UpdateTime()
	local var_76_0 = pg.TimeMgr.GetInstance()
	local var_76_1 = self.rest:GetEndTime() - var_76_0:GetServerTime()

	setText(self.btnsTF:Find("opening/time"), var_76_0:DescCDTime(var_76_1))

	if var_76_1 <= 0 then
		self:FlushBtns()
	end

	return
end

function IslandRestaurantPage:StartTimer()
	self.timer = Timer.New(function()
		self:UpdateTime()

		return
	end, 1, -1)

	self.timer:Start()

	return
end

function IslandRestaurantPage:StopTimer()
	if self.timer ~= nil then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function IslandRestaurantPage:OnHide()
	self:StopTimer()

	if self.statusCheckTimer then
		self.statusCheckTimer:Stop()

		self.statusCheckTimer = nil
	end

	self:UnBlurPanel()

	return
end

function IslandRestaurantPage:OnDisable()
	self:OnHide()

	return
end

function IslandRestaurantPage:OnDestroy()
	ClearLScrollrect(self.scrollRect)
	self:OnHide()

	return
end

function IslandRestaurantPage:CaclShipAttrFactors(arg_83_1)
	local var_83_0 = 0

	for iter_83_0, iter_83_1 in ipairs(self) do
		var_83_0 = var_83_0 + pg.island_chara_att[iter_83_1:GetAttrGrade(IslandShipAttr.GetAtrrName(arg_83_1))].manage_effect / 16
	end

	return var_83_0
end

return IslandRestaurantPage
