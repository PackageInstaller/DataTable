local IslandDropHelper = class("IslandDropHelper")

function IslandDropHelper:AddItems(arg_1_1)
	local var_1_1 = {}
	local var_1_2 = {}
	local var_1_3 = {}
	local var_1_4 = {}
	local var_1_5 = {}
	local var_1_6 = {}
	local var_1_7 = {}
	local var_1_8 = {}
	local var_1_9 = {}
	local var_1_10 = {}
	local var_1_11 = {}
	local var_1_12 = {}
	local var_1_13 = {}
	local var_1_14 = {}

	for iter_1_0, iter_1_1 in ipairs(self.drop_list or {}) do
		if iter_1_1.type == DROP_TYPE_ISLAND_ITEM then
			table.insert(var_1_1, iter_1_1)
		elseif iter_1_1.type == DROP_TYPE_ISLAND_OVERFLOWITEM then
			table.insert(var_1_2, iter_1_1)
		elseif iter_1_1.type == DROP_TYPE_ISLAND_ABILITY then
			table.insert(var_1_3, iter_1_1)
		elseif iter_1_1.type == DROP_TYPE_ISLAND_INVITATION then
			table.insert(var_1_5, iter_1_1)
		elseif iter_1_1.type == VIRTUAL_DROP_TYPE_ISLAND_SEASON_PT then
			if iter_1_1.count > 0 then
				table.insert(var_1_14, iter_1_1)
			end
		elseif iter_1_1.type == DROP_TYPE_ISLAND_FURNITURE then
			table.insert(var_1_6, iter_1_1)
		elseif iter_1_1.type == DROP_TYPE_ISLAND_DRESS then
			table.insert(var_1_7, iter_1_1)
		elseif iter_1_1.type == DROP_TYPE_ISLAND_SKIN then
			table.insert(var_1_8, iter_1_1)
		elseif iter_1_1.type == DROP_TYPE_ISLAND_ACTION then
			table.insert(var_1_9, iter_1_1)
		elseif iter_1_1.type == DROP_TYPE_ISLAND_CARD_DIY then
			table.insert(var_1_10, iter_1_1)
		elseif iter_1_1.type == DROP_TYPE_ISLAND_SPEEDUP_TICKET then
			table.insert(var_1_11, iter_1_1)
		elseif iter_1_1.type == DROP_TYPE_TIMESTAMP then
			table.insert(var_1_12, iter_1_1)
		elseif iter_1_1.type == DROP_TYPE_ISLAND_COLLECTION then
			table.insert(var_1_13, iter_1_1)
		else
			table.insert(var_1_4, iter_1_1)
		end
	end

	local var_1_15 = IslandDropHelper.AddIslandItems(var_1_1)
	local var_1_16 = IslandDropHelper.AddShipInvitations(var_1_5)
	local var_1_17 = IslandDropHelper.AddVirtualDrops(var_1_14)
	local var_1_18 = IslandDropHelper.AddIslandFurnitureDrops(var_1_6)
	local var_1_19 = IslandDropHelper.AddIslandDressDrops(var_1_7)
	local var_1_20 = IslandDropHelper.AddIslandSkinDrops(var_1_8)
	local var_1_21 = IslandDropHelper.AddIslandActionDrops(var_1_9)
	local var_1_22 = IslandDropHelper.AddIslandCardDiyDrops(var_1_10)
	local var_1_23 = IslandDropHelper.AddIslandTicketDrops(var_1_11, (IslandDropHelper.GetIslandTimestamps(var_1_12)))
	local var_1_24 = IslandDropHelper.AddIslandCollectDrops(var_1_13)

	if #var_1_16 > 0 then
		for iter_1_2, iter_1_3 in ipairs(var_1_16) do
			table.insert(var_1_15, iter_1_3)
		end
	end

	if #var_1_17 > 0 then
		for iter_1_4, iter_1_5 in ipairs(var_1_17) do
			table.insert(var_1_15, iter_1_5)
		end
	end

	if #var_1_18 > 0 then
		for iter_1_6, iter_1_7 in ipairs(var_1_18) do
			table.insert(var_1_15, iter_1_7)
		end
	end

	if #var_1_19 > 0 then
		for iter_1_8, iter_1_9 in ipairs(var_1_19) do
			if pg.island_dress_template[iter_1_9.id].is_hide ~= 1 then
				table.insert(var_1_15, iter_1_9)
			end
		end
	end

	if #var_1_20 > 0 then
		for iter_1_10, iter_1_11 in ipairs(var_1_20) do
			table.insert(var_1_15, iter_1_11)
		end
	end

	if #var_1_21 > 0 then
		for iter_1_12, iter_1_13 in ipairs(var_1_21) do
			table.insert(var_1_15, iter_1_13)
		end
	end

	if #var_1_22 > 0 then
		for iter_1_14, iter_1_15 in ipairs(var_1_22) do
			table.insert(var_1_15, iter_1_15)
		end
	end

	if #var_1_23 > 0 then
		for iter_1_16, iter_1_17 in ipairs(var_1_23) do
			table.insert(var_1_15, iter_1_17)
		end
	end

	if #var_1_24 > 0 then
		for iter_1_18, iter_1_19 in ipairs(var_1_24) do
			table.insert(var_1_15, iter_1_19)
		end
	end

	if arg_1_1 and arg_1_1 > 0 then
		IslandDropHelper.AddIslandExp(arg_1_1)
	end

	return {
		awards = var_1_15,
		overflowAwards = IslandDropHelper.AddIslandOverFlowItems(var_1_2),
		abilitys = IslandDropHelper.AddIslandAbility(var_1_3),
		exp = arg_1_1,
		drops = IslandDropHelper.AddPlayerItems(var_1_4)
	}
end

function IslandDropHelper:GetIslandTimestamps()
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(self) do
		var_2_0[pg.island_drop_time_set[iter_2_1.id].drop_type] = var_2_0[pg.island_drop_time_set[iter_2_1.id].drop_type] or {}
		var_2_0[pg.island_drop_time_set[iter_2_1.id].drop_type][pg.island_drop_time_set[iter_2_1.id].link_id] = iter_2_1.number
	end

	return var_2_0
end

function IslandDropHelper:AddIslandExp()
	getProxy(IslandProxy):GetIsland():AddExp(self)

	return
end

function IslandDropHelper:AddIslandItems()
	local var_4_0 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()
	local var_4_1 = {}

	for iter_4_0, iter_4_1 in ipairs(self) do
		var_4_0:AddItem((IslandItem.New(iter_4_1)))

		local var_4_3 = {
			type = DROP_TYPE_ISLAND_ITEM,
			id = iter_4_1.id
		}

		var_4_3.count = iter_4_1.number or iter_4_1.num or iter_4_1.count

		table.insert(var_4_1, Drop.New(var_4_3))
	end

	return var_4_1
end

function IslandDropHelper:AddIslandOverFlowItems()
	local var_5_0 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()
	local var_5_1 = {}

	for iter_5_0, iter_5_1 in ipairs(self) do
		var_5_0:AddOverFlowItem((IslandItem.New(iter_5_1)))

		local var_5_3 = {
			type = DROP_TYPE_ISLAND_ITEM,
			id = iter_5_1.id
		}

		var_5_3.count = iter_5_1.number or iter_5_1.num or iter_5_1.count

		table.insert(var_5_1, Drop.New(var_5_3))
	end

	return var_5_1
end

function IslandDropHelper:AddIslandAbility()
	local var_6_0 = getProxy(IslandProxy):GetIsland():GetAblityAgency()
	local var_6_1 = {}

	for iter_6_0, iter_6_1 in ipairs(self) do
		if not var_6_0:HasAbility(iter_6_1.id) then
			var_6_0:AddAblity(iter_6_1.id)
			IslandDropHelper.HandleIslandShopAbility(iter_6_1.id)
			IslandDropHelper.HandleIslandAbilityByType(iter_6_1.id)
			table.insert(var_6_1, Drop.New({
				count = 1,
				type = DROP_TYPE_ISLAND_ABILITY,
				id = iter_6_1.id
			}))
		end
	end

	return var_6_1
end

function IslandDropHelper:HandleIslandShopAbility()
	local var_7_0 = IslandAblityAgency.GetEffect(self)

	if IslandAblityAgency.IsShopTypeNormal(self) then
		if pg.island_shop_normal_template[var_7_0] then
			local var_7_1 = true

			for iter_7_0, iter_7_1 in ipairs(pg.island_shop_normal_template[var_7_0].unlock == "" and {} or pg.island_shop_normal_template[var_7_0].unlock) do
				if not getProxy(IslandProxy):GetIsland():GetAblityAgency():HasAbility(iter_7_1) then
					var_7_1 = false

					break
				end
			end

			if var_7_1 then
				getProxy(IslandProxy):GetIsland():GetShopAgency():RefreshShopData(var_7_0)
			end
		end
	elseif IslandAblityAgency.IsShopTypeTemporary(self) then
		getProxy(IslandProxy):GetIsland():GetShopAgency():RefreshShopData(var_7_0)
	end

	return
end

function IslandDropHelper:HandleIslandAbilityByType()
	local var_8_0 = getProxy(IslandProxy):GetIsland()
	local var_8_1 = IslandAblityAgency.GetEffect(self)

	switch(IslandAblityAgency.GetAblityType(self), {
		[IslandAblityAgency.TYPE_SLOT] = function()
			var_8_0:GetBuildingAgency():InitSlotDataByAbility(self)

			return
		end,
		[IslandAblityAgency.TYPE_RESTAURANT] = function()
			var_8_0:GetManageAgency():UnlockNewRestaurant(var_8_1)

			return
		end,
		[IslandAblityAgency.TYPE_ASSISTANT] = function()
			var_8_0:GetManageAgency():UnlockNewAssistant(var_8_1)

			return
		end,
		[IslandAblityAgency.TYPE_ANIMAL] = function()
			var_8_0:GetBuildingAgency():InitBuildAnimalDataByAbility(var_8_1)

			return
		end,
		[IslandAblityAgency.TYPE_RECOVER_CAMP] = function()
			local var_13_0 = var_8_0:GetBuildingAgency()
			local var_13_1 = var_13_0:GetBuilding(IslandProductConst.FellingPlaceId):GetBuildingCollectData()
			local var_13_2 = pg.TimeMgr.GetInstance():GetZeroTimeStamp((pg.TimeMgr.GetInstance().GetServerTime(var_13_0))) + var_8_1

			if var_13_2 < var_13_1:GetNextRecoverTimes() then
				var_13_1:UpdateCollectRefreshtTime(var_13_2)
			end

			return
		end,
		[IslandAblityAgency.TYPE_RECOVER_ORE] = function()
			local var_14_0 = var_8_0:GetBuildingAgency()
			local var_14_1 = var_14_0:GetBuilding(IslandProductConst.MinePlaceId):GetBuildingCollectData()
			local var_14_2 = pg.TimeMgr.GetInstance():GetZeroTimeStamp((pg.TimeMgr.GetInstance().GetServerTime(var_14_0))) + var_8_1

			if var_14_2 < var_14_1:GetNextRecoverTimes() then
				var_14_1:UpdateCollectRefreshtTime(var_14_2)
			end

			return
		end,
		[IslandAblityAgency.TYPE_FISHING_ROD] = function()
			var_8_0:GetFishingAgency():UpdateFishRodId(var_8_1)

			return
		end
	})

	return
end

function IslandDropHelper:AddPlayerItems()
	return PlayerConst.addTranDrop(self)
end

function IslandDropHelper:AddShipInvitations()
	local var_17_0 = getProxy(IslandProxy):GetIsland():GetCharacterAgency()
	local var_17_1 = {}

	for iter_17_0, iter_17_1 in ipairs(self) do
		var_17_0:AddInvite(iter_17_1.id)

		local var_17_3 = {
			type = DROP_TYPE_ISLAND_INVITATION,
			id = iter_17_1.id
		}

		var_17_3.count = iter_17_1.number or iter_17_1.num or iter_17_1.count

		table.insert(var_17_1, Drop.New(var_17_3))
	end

	return var_17_1
end

function IslandDropHelper:AddVirtualDrops()
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in ipairs(self) do
		switch(iter_18_1.type, {
			[VIRTUAL_DROP_TYPE_ISLAND_SEASON_PT] = function()
				local var_19_0 = {
					type = iter_18_1.type,
					id = iter_18_1.id
				}

				var_19_0.count = iter_18_1.number or iter_18_1.num or iter_18_1.count

				local var_19_1 = Drop.New(var_19_0)

				table.insert(var_18_0, var_19_1)
				getProxy(IslandProxy):GetIsland():GetSeasonAgency():AddPt(var_19_1.count)

				return
			end
		})
	end

	return var_18_0
end

function IslandDropHelper:AddIslandFurnitureDrops()
	local var_20_0 = getProxy(IslandProxy):GetIsland():GetAgoraAgency()
	local var_20_1 = {}

	for iter_20_0, iter_20_1 in ipairs(self) do
		local var_20_2 = {
			id = iter_20_1.id
		}

		var_20_2.count = iter_20_1.number or iter_20_1.num or iter_20_1.count

		local var_20_3 = IslandFurniture.New(var_20_2)

		var_20_3:SetTime(pg.TimeMgr:GetInstance():GetServerTime())
		var_20_0:AddFurniture(var_20_3)
		IslandTaskHelper.UpdateRuntimeTaskByTargetType(IslandTaskTargetType.FURNITURE)

		local var_20_5 = {
			type = DROP_TYPE_ISLAND_FURNITURE,
			id = iter_20_1.id
		}

		var_20_5.count = iter_20_1.number or iter_20_1.num or iter_20_1.count

		table.insert(var_20_1, Drop.New(var_20_5))
	end

	return var_20_1
end

function IslandDropHelper:AddIslandDressDrops()
	local var_21_0 = {}
	local var_21_1 = getProxy(IslandProxy):GetIsland()

	for iter_21_0, iter_21_1 in ipairs(self) do
		local var_21_2 = pg.island_dress_template[iter_21_1.id]

		if pg.island_dress_template[iter_21_1.id].belongto == 1 then
			var_21_1:GetDressUpAgency():AddDressByDressId(iter_21_1.id)
			IslandTaskHelper.UpdateRuntimeTaskByTargetType(IslandTaskTargetType.COMMANDER_DRESS)
			IslandTaskHelper.UpdateRuntimeTaskByTargetType(IslandTaskTargetType.COMMANDER_DRESS_ID)
			IslandAchievementHelper.UpdateRecordWithAdd(IslandAchievementType.COMMANDER_DRESS_TYPE, var_21_2.type, 1)
		else
			local var_21_3 = var_21_1:GetCharacterAgency()
			local var_21_4 = not var_21_3:ExistDressId(iter_21_1.id)

			var_21_3:AddDressItem(iter_21_1.id, iter_21_1.number, true)
			IslandTaskHelper.UpdateRuntimeTaskByTargetType(IslandTaskTargetType.SHIP_DRESS_ID)

			if var_21_4 then
				IslandTaskHelper.UpdateRuntimeTaskByTargetType(IslandTaskTargetType.SHIP_DRESS)
				IslandAchievementHelper.UpdateRecordWithAdd(IslandAchievementType.SHIP_DRESS_TYPE, var_21_2.type, 1)
			end
		end

		local var_21_6 = {
			type = DROP_TYPE_ISLAND_DRESS,
			id = iter_21_1.id
		}

		var_21_6.count = iter_21_1.number or iter_21_1.num or iter_21_1.count

		table.insert(var_21_0, Drop.New(var_21_6))
		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandGetDress(var_21_2.belongto, iter_21_1.id))
	end

	return var_21_0
end

function IslandDropHelper:AddIslandSkinDrops()
	local var_22_0 = getProxy(IslandProxy):GetIsland():GetCharacterAgency()
	local var_22_1 = {}

	for iter_22_0, iter_22_1 in ipairs(self) do
		var_22_0:AddSkin(iter_22_1.id)

		local var_22_3 = {
			type = DROP_TYPE_ISLAND_SKIN,
			id = iter_22_1.id
		}

		var_22_3.count = iter_22_1.number or iter_22_1.num or iter_22_1.count

		table.insert(var_22_1, Drop.New(var_22_3))
	end

	if #self > 0 then
		IslandTaskHelper.UpdateRuntimeTaskByTargetType(IslandTaskTargetType.SHIP_SKIN)
		IslandAchievementHelper.UpdateRecordWithAdd(IslandAchievementType.SHIP_SKIN, 0, #self)
	end

	return var_22_1
end

function IslandDropHelper:AddIslandActionDrops()
	local var_23_0 = getProxy(IslandProxy):GetIsland():GetActionAgency()
	local var_23_1 = {}

	for iter_23_0, iter_23_1 in ipairs(self) do
		var_23_0:AddAction(iter_23_1.id)
		IslandTaskHelper.UpdateRuntimeTaskByTargetType(IslandTaskTargetType.ACTION)
		IslandAchievementHelper.UpdateRecordWithAdd(IslandTaskTargetType.ACTION, 0, 1)

		local var_23_3 = {
			type = DROP_TYPE_ISLAND_ACTION,
			id = iter_23_1.id
		}

		var_23_3.count = iter_23_1.number or iter_23_1.num or iter_23_1.count

		table.insert(var_23_1, Drop.New(var_23_3))
	end

	return var_23_1
end

function IslandDropHelper:AddIslandCardDiyDrops()
	local var_24_0 = getProxy(IslandProxy):GetIsland():GetCardDiyAgency()
	local var_24_1 = {}

	for iter_24_0, iter_24_1 in ipairs(self) do
		var_24_0:AddCardDiy(iter_24_1)

		local var_24_3 = {
			type = DROP_TYPE_ISLAND_CARD_DIY,
			id = iter_24_1.id
		}

		var_24_3.count = iter_24_1.number or iter_24_1.num or iter_24_1.count

		table.insert(var_24_1, Drop.New(var_24_3))
	end

	return var_24_1
end

function IslandDropHelper:AddIslandTicketDrops(arg_25_1)
	local var_25_0 = getProxy(IslandProxy):GetIsland():GetTicketAgency()
	local var_25_1 = {}

	for iter_25_0, iter_25_1 in ipairs(self) do
		local var_25_2 = iter_25_1.number or iter_25_1.num or iter_25_1.count

		var_25_0:AddTicket(iter_25_1.id, IslandTicket.GetEndTimeById(iter_25_1.id, arg_25_1[DROP_TYPE_ISLAND_SPEEDUP_TICKET][iter_25_1.id]), var_25_2)
		table.insert(var_25_1, Drop.New({
			type = DROP_TYPE_ISLAND_SPEEDUP_TICKET,
			id = iter_25_1.id,
			count = var_25_2
		}))
	end

	return var_25_1
end

function IslandDropHelper:AddIslandCollectDrops()
	local var_26_0 = getProxy(IslandProxy):GetIsland():GetWildCollectAgency()
	local var_26_1 = {}

	for iter_26_0, iter_26_1 in ipairs(self) do
		var_26_0:AddFinishCollectData(iter_26_1.id)

		local var_26_3 = {
			type = DROP_TYPE_ISLAND_COLLECTION,
			id = iter_26_1.id
		}

		var_26_3.count = iter_26_1.number or iter_26_1.num or iter_26_1.count

		table.insert(var_26_1, Drop.New(var_26_3))
	end

	return var_26_1
end

return IslandDropHelper
