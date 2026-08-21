local var_0_0 = class("IslandDropHelper")

function var_0_0.AddItems(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0.drop_list or {}
	local var_1_1 = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		if iter_1_1.type == DROP_TYPE_ISLAND_ITEM then
			table.insert(var_1_1, iter_1_1)
		elseif iter_1_1.type == DROP_TYPE_ISLAND_OVERFLOWITEM then
			table.insert({}, iter_1_1)
		elseif iter_1_1.type == DROP_TYPE_ISLAND_ABILITY then
			table.insert({}, iter_1_1)
		elseif iter_1_1.type == DROP_TYPE_ISLAND_INVITATION then
			table.insert({}, iter_1_1)
		elseif iter_1_1.type == VIRTUAL_DROP_TYPE_ISLAND_SEASON_PT then
			if iter_1_1.count > 0 then
				table.insert({}, iter_1_1)
			end
		elseif iter_1_1.type == DROP_TYPE_ISLAND_FURNITURE then
			table.insert({}, iter_1_1)
		elseif iter_1_1.type == DROP_TYPE_ISLAND_DRESS then
			table.insert({}, iter_1_1)
		elseif iter_1_1.type == DROP_TYPE_ISLAND_SKIN then
			table.insert({}, iter_1_1)
		elseif iter_1_1.type == DROP_TYPE_ISLAND_ACTION then
			table.insert({}, iter_1_1)
		elseif iter_1_1.type == DROP_TYPE_ISLAND_CARD_DIY then
			table.insert({}, iter_1_1)
		elseif iter_1_1.type == DROP_TYPE_ISLAND_SPEEDUP_TICKET then
			table.insert({}, iter_1_1)
		elseif iter_1_1.type == DROP_TYPE_TIMESTAMP then
			table.insert({}, iter_1_1)
		elseif iter_1_1.type == DROP_TYPE_ISLAND_COLLECTION then
			table.insert({}, iter_1_1)
		else
			table.insert({}, iter_1_1)
		end
	end

	local var_1_2 = var_0_0.AddIslandItems(var_1_1)
	local var_1_3 = var_0_0.AddShipInvitations({})
	local var_1_4 = var_0_0.AddVirtualDrops({})
	local var_1_5 = var_0_0.AddIslandFurnitureDrops({})
	local var_1_6 = var_0_0.AddIslandDressDrops({})
	local var_1_7 = var_0_0.AddIslandSkinDrops({})
	local var_1_8 = var_0_0.AddIslandActionDrops({})
	local var_1_9 = var_0_0.AddIslandCardDiyDrops({})
	local var_1_10 = var_0_0.AddIslandTicketDrops({}, (var_0_0.GetIslandTimestamps({})))
	local var_1_11 = var_0_0.AddIslandCollectDrops({})

	if #var_1_3 > 0 then
		for iter_1_2, iter_1_3 in ipairs(var_1_3) do
			table.insert(var_1_2, iter_1_3)
		end
	end

	if #var_1_4 > 0 then
		for iter_1_4, iter_1_5 in ipairs(var_1_4) do
			table.insert(var_1_2, iter_1_5)
		end
	end

	if #var_1_5 > 0 then
		for iter_1_6, iter_1_7 in ipairs(var_1_5) do
			table.insert(var_1_2, iter_1_7)
		end
	end

	if #var_1_6 > 0 then
		for iter_1_8, iter_1_9 in ipairs(var_1_6) do
			if pg.island_dress_template[iter_1_9.id].is_hide ~= 1 then
				table.insert(var_1_2, iter_1_9)
			end
		end
	end

	if #var_1_7 > 0 then
		for iter_1_10, iter_1_11 in ipairs(var_1_7) do
			table.insert(var_1_2, iter_1_11)
		end
	end

	if #var_1_8 > 0 then
		for iter_1_12, iter_1_13 in ipairs(var_1_8) do
			table.insert(var_1_2, iter_1_13)
		end
	end

	if #var_1_9 > 0 then
		for iter_1_14, iter_1_15 in ipairs(var_1_9) do
			table.insert(var_1_2, iter_1_15)
		end
	end

	if #var_1_10 > 0 then
		for iter_1_16, iter_1_17 in ipairs(var_1_10) do
			table.insert(var_1_2, iter_1_17)
		end
	end

	if #var_1_11 > 0 then
		for iter_1_18, iter_1_19 in ipairs(var_1_11) do
			table.insert(var_1_2, iter_1_19)
		end
	end

	if arg_1_1 and arg_1_1 > 0 then
		var_0_0.AddIslandExp(arg_1_1)
	end

	return {
		awards = var_1_2,
		overflowAwards = var_0_0.AddIslandOverFlowItems({}),
		abilitys = var_0_0.AddIslandAbility({}),
		exp = arg_1_1,
		drops = var_0_0.AddPlayerItems({})
	}
end

function var_0_0.GetIslandTimestamps(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0) do
		if not ({})[pg.island_drop_time_set[iter_2_1.id].drop_type] then
			({})[pg.island_drop_time_set[iter_2_1.id].drop_type] = {}
		end

		;({})[pg.island_drop_time_set[iter_2_1.id].drop_type][pg.island_drop_time_set[iter_2_1.id].link_id] = iter_2_1.number
	end

	return {}
end

function var_0_0.AddIslandExp(arg_3_0)
	getProxy(IslandProxy):GetIsland():AddExp(arg_3_0)

	return
end

function var_0_0.AddIslandItems(arg_4_0)
	local var_4_0 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()

	for iter_4_0, iter_4_1 in ipairs(arg_4_0) do
		var_4_0:AddItem((IslandItem.New(iter_4_1)))

		;({
			type = DROP_TYPE_ISLAND_ITEM,
			id = iter_4_1.id
		}).count = iter_4_1.number or iter_4_1.num or iter_4_1.count

		table.insert({}, Drop.New({
			type = DROP_TYPE_ISLAND_ITEM,
			id = iter_4_1.id
		}))
	end

	return {}
end

function var_0_0.AddIslandOverFlowItems(arg_5_0)
	local var_5_0 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()

	for iter_5_0, iter_5_1 in ipairs(arg_5_0) do
		var_5_0:AddOverFlowItem((IslandItem.New(iter_5_1)))

		;({
			type = DROP_TYPE_ISLAND_ITEM,
			id = iter_5_1.id
		}).count = iter_5_1.number or iter_5_1.num or iter_5_1.count

		table.insert({}, Drop.New({
			type = DROP_TYPE_ISLAND_ITEM,
			id = iter_5_1.id
		}))
	end

	return {}
end

function var_0_0.AddIslandAbility(arg_6_0)
	local var_6_0 = getProxy(IslandProxy):GetIsland():GetAblityAgency()

	for iter_6_0, iter_6_1 in ipairs(arg_6_0) do
		if not var_6_0:HasAbility(iter_6_1.id) then
			var_6_0:AddAblity(iter_6_1.id)
			var_0_0.HandleIslandShopAbility(iter_6_1.id)
			var_0_0.HandleIslandAbilityByType(iter_6_1.id)
			table.insert({}, Drop.New({
				count = 1,
				type = DROP_TYPE_ISLAND_ABILITY,
				id = iter_6_1.id
			}))
		end
	end

	return {}
end

function var_0_0.HandleIslandShopAbility(arg_7_0)
	local var_7_0 = IslandAblityAgency.GetEffect(arg_7_0)

	if IslandAblityAgency.IsShopTypeNormal(arg_7_0) then
		if pg.island_shop_normal_template[var_7_0] then
			if pg.island_shop_normal_template[var_7_0].unlock == "" then
				local var_7_1 = {}

				if not {} then
					var_7_1 = pg.island_shop_normal_template[var_7_0].unlock
				end

				local var_7_2 = true

				for iter_7_0, iter_7_1 in ipairs(var_7_1) do
					local var_7_3 = getProxy(IslandProxy):GetIsland():GetAblityAgency()

					if not var_7_3:HasAbility(iter_7_1) then
						var_7_2 = false

						break
					end
				end

				if var_7_2 then
					getProxy(IslandProxy):GetIsland():GetShopAgency():RefreshShopData(var_7_0)
				end

				goto label_7_0

				if IslandAblityAgency.IsShopTypeTemporary(arg_7_0) then
					getProxy(IslandProxy):GetIsland():GetShopAgency():RefreshShopData(var_7_0)
				end

				::label_7_0::

				return
			end
		end
	end
end

function var_0_0.HandleIslandAbilityByType(arg_8_0)
	local var_8_0 = getProxy(IslandProxy):GetIsland()
	local var_8_1 = IslandAblityAgency.GetEffect(arg_8_0)

	switch(IslandAblityAgency.GetAblityType(arg_8_0), {
		[IslandAblityAgency.TYPE_SLOT] = function()
			var_8_0:GetBuildingAgency():InitSlotDataByAbility(arg_8_0)

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
			local var_13_9000
			local var_13_0 = var_8_0:GetBuildingAgency()
			local var_13_1 = var_13_0.GetBuilding(var_13_9000, IslandProductConst.FellingPlaceId):GetBuildingCollectData()
			local var_13_2 = pg.TimeMgr.GetInstance():GetZeroTimeStamp((pg.TimeMgr.GetInstance().GetServerTime(var_13_0))) + var_8_1

			if var_13_2 < var_13_1:GetNextRecoverTimes() then
				var_13_1:UpdateCollectRefreshtTime(var_13_2)
			end

			return
		end,
		[IslandAblityAgency.TYPE_RECOVER_ORE] = function()
			local var_14_9000
			local var_14_0 = var_8_0:GetBuildingAgency()
			local var_14_1 = var_14_0.GetBuilding(var_14_9000, IslandProductConst.MinePlaceId):GetBuildingCollectData()
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

function var_0_0.AddPlayerItems(arg_16_0)
	return PlayerConst.addTranDrop(arg_16_0)
end

function var_0_0.AddShipInvitations(arg_17_0)
	local var_17_0 = getProxy(IslandProxy):GetIsland():GetCharacterAgency()

	for iter_17_0, iter_17_1 in ipairs(arg_17_0) do
		var_17_0:AddInvite(iter_17_1.id)

		;({
			type = DROP_TYPE_ISLAND_INVITATION,
			id = iter_17_1.id
		}).count = iter_17_1.number or iter_17_1.num or iter_17_1.count

		table.insert({}, Drop.New({
			type = DROP_TYPE_ISLAND_INVITATION,
			id = iter_17_1.id
		}))
	end

	return {}
end

function var_0_0.AddVirtualDrops(arg_18_0)
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in ipairs(arg_18_0) do
		switch(iter_18_1.type, {
			[VIRTUAL_DROP_TYPE_ISLAND_SEASON_PT] = function()
				({
					type = iter_18_1.type,
					id = iter_18_1.id
				}).count = iter_18_1.number or iter_18_1.num or iter_18_1.count

				local var_19_0 = Drop.New({
					type = iter_18_1.type,
					id = iter_18_1.id
				})

				table.insert(var_18_0, var_19_0)
				getProxy(IslandProxy):GetIsland():GetSeasonAgency():AddPt(var_19_0.count)

				return
			end
		})
	end

	return {}
end

function var_0_0.AddIslandFurnitureDrops(arg_20_0)
	local var_20_0 = getProxy(IslandProxy):GetIsland():GetAgoraAgency()

	for iter_20_0, iter_20_1 in ipairs(arg_20_0) do
		({
			id = iter_20_1.id
		}).count = iter_20_1.number or iter_20_1.num or iter_20_1.count

		local var_20_1 = IslandFurniture.New({
			id = iter_20_1.id
		})
		local var_20_2 = pg.TimeMgr:GetInstance()

		var_20_1:SetTime(var_20_2:GetServerTime())
		var_20_0:AddFurniture(var_20_1)
		IslandTaskHelper.UpdateRuntimeTaskByTargetType(IslandTaskTargetType.FURNITURE)

		;({
			type = DROP_TYPE_ISLAND_FURNITURE,
			id = iter_20_1.id
		}).count = iter_20_1.number or iter_20_1.num or iter_20_1.count

		table.insert({}, Drop.New({
			type = DROP_TYPE_ISLAND_FURNITURE,
			id = iter_20_1.id
		}))
	end

	return {}
end

function var_0_0.AddIslandDressDrops(arg_21_0)
	local var_21_0 = getProxy(IslandProxy):GetIsland()

	for iter_21_0, iter_21_1 in ipairs(arg_21_0) do
		local var_21_1 = pg.island_dress_template[iter_21_1.id]

		if pg.island_dress_template[iter_21_1.id].belongto == 1 then
			var_21_0:GetDressUpAgency():AddDressByDressId(iter_21_1.id)
			IslandTaskHelper.UpdateRuntimeTaskByTargetType(IslandTaskTargetType.COMMANDER_DRESS)
			IslandTaskHelper.UpdateRuntimeTaskByTargetType(IslandTaskTargetType.COMMANDER_DRESS_ID)
			IslandAchievementHelper.UpdateRecordWithAdd(IslandAchievementType.COMMANDER_DRESS_TYPE, var_21_1.type, 1)
		else
			local var_21_2 = var_21_0:GetCharacterAgency()
			local var_21_3 = not var_21_2:ExistDressId(iter_21_1.id)

			var_21_2:AddDressItem(iter_21_1.id, iter_21_1.number, true)
			IslandTaskHelper.UpdateRuntimeTaskByTargetType(IslandTaskTargetType.SHIP_DRESS_ID)

			if var_21_3 then
				IslandTaskHelper.UpdateRuntimeTaskByTargetType(IslandTaskTargetType.SHIP_DRESS)
				IslandAchievementHelper.UpdateRecordWithAdd(IslandAchievementType.SHIP_DRESS_TYPE, var_21_1.type, 1)
			end
		end

		;({
			type = DROP_TYPE_ISLAND_DRESS,
			id = iter_21_1.id
		}).count = iter_21_1.number or iter_21_1.num or iter_21_1.count

		var_21_4({}, Drop.New({
			type = DROP_TYPE_ISLAND_DRESS,
			id = iter_21_1.id
		}))
		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandGetDress(var_21_1.belongto, iter_21_1.id))
	end

	return {}
end

function var_0_0.AddIslandSkinDrops(arg_22_0)
	local var_22_0 = getProxy(IslandProxy):GetIsland():GetCharacterAgency()

	for iter_22_0, iter_22_1 in ipairs(arg_22_0) do
		var_22_0:AddSkin(iter_22_1.id)

		;({
			type = DROP_TYPE_ISLAND_SKIN,
			id = iter_22_1.id
		}).count = iter_22_1.number or iter_22_1.num or iter_22_1.count

		table.insert({}, Drop.New({
			type = DROP_TYPE_ISLAND_SKIN,
			id = iter_22_1.id
		}))
	end

	if #arg_22_0 > 0 then
		IslandTaskHelper.UpdateRuntimeTaskByTargetType(IslandTaskTargetType.SHIP_SKIN)
		IslandAchievementHelper.UpdateRecordWithAdd(IslandAchievementType.SHIP_SKIN, 0, #arg_22_0)
	end

	return {}
end

function var_0_0.AddIslandActionDrops(arg_23_0)
	local var_23_0 = getProxy(IslandProxy):GetIsland():GetActionAgency()

	for iter_23_0, iter_23_1 in ipairs(arg_23_0) do
		var_23_0:AddAction(iter_23_1.id)
		IslandTaskHelper.UpdateRuntimeTaskByTargetType(IslandTaskTargetType.ACTION)
		IslandAchievementHelper.UpdateRecordWithAdd(IslandTaskTargetType.ACTION, 0, 1)

		;({
			type = DROP_TYPE_ISLAND_ACTION,
			id = iter_23_1.id
		}).count = iter_23_1.number or iter_23_1.num or iter_23_1.count

		table.insert({}, Drop.New({
			type = DROP_TYPE_ISLAND_ACTION,
			id = iter_23_1.id
		}))
	end

	return {}
end

function var_0_0.AddIslandCardDiyDrops(arg_24_0)
	local var_24_0 = getProxy(IslandProxy):GetIsland():GetCardDiyAgency()

	for iter_24_0, iter_24_1 in ipairs(arg_24_0) do
		var_24_0:AddCardDiy(iter_24_1)

		;({
			type = DROP_TYPE_ISLAND_CARD_DIY,
			id = iter_24_1.id
		}).count = iter_24_1.number or iter_24_1.num or iter_24_1.count

		table.insert({}, Drop.New({
			type = DROP_TYPE_ISLAND_CARD_DIY,
			id = iter_24_1.id
		}))
	end

	return {}
end

function var_0_0.AddIslandTicketDrops(arg_25_0, arg_25_1)
	local var_25_0 = getProxy(IslandProxy):GetIsland():GetTicketAgency()

	for iter_25_0, iter_25_1 in ipairs(arg_25_0) do
		local var_25_1 = IslandTicket.GetEndTimeById(iter_25_1.id, arg_25_1[DROP_TYPE_ISLAND_SPEEDUP_TICKET][iter_25_1.id])
		local var_25_2 = iter_25_1.number or iter_25_1.num or iter_25_1.count

		var_25_0:AddTicket(iter_25_1.id, var_25_1, var_25_2)
		table.insert({}, Drop.New({
			type = DROP_TYPE_ISLAND_SPEEDUP_TICKET,
			id = iter_25_1.id,
			count = var_25_2
		}))
	end

	return {}
end

function var_0_0.AddIslandCollectDrops(arg_26_0)
	local var_26_0 = getProxy(IslandProxy):GetIsland():GetWildCollectAgency()

	for iter_26_0, iter_26_1 in ipairs(arg_26_0) do
		var_26_0:AddFinishCollectData(iter_26_1.id)

		;({
			type = DROP_TYPE_ISLAND_COLLECTION,
			id = iter_26_1.id
		}).count = iter_26_1.number or iter_26_1.num or iter_26_1.count

		table.insert({}, Drop.New({
			type = DROP_TYPE_ISLAND_COLLECTION,
			id = iter_26_1.id
		}))
	end

	return {}
end

return var_0_0
