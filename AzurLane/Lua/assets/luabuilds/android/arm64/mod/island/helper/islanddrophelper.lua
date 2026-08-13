class = var_0_10000

local var_0_0 = var_0_10000("IslandDropHelper")

function var_0_0.AddItems(arg_1_0, arg_1_1)
	local var_1_0

	if not arg_1_0.drop_list then
		var_1_0 = {}
	end

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

	ipairs = var_1_10017

	for iter_1_0, iter_1_1 in var_1_10017(var_1_0) do
		local var_1_15 = iter_1_1.type

		DROP_TYPE_ISLAND_ITEM = var_1_10023

		if var_1_15 == var_1_10023 then
			table = var_1_15

			var_1_15.insert(var_1_1, iter_1_1)
		else
			local var_1_16 = iter_1_1.type

			DROP_TYPE_ISLAND_OVERFLOWITEM = var_1_10023

			if var_1_16 == var_1_10023 then
				table = var_1_16

				var_1_16.insert(var_1_2, iter_1_1)
			else
				local var_1_17 = iter_1_1.type

				DROP_TYPE_ISLAND_ABILITY = var_1_10023

				if var_1_17 == var_1_10023 then
					table = var_1_17

					var_1_17.insert(var_1_3, iter_1_1)
				else
					local var_1_18 = iter_1_1.type

					DROP_TYPE_ISLAND_INVITATION = var_1_10023

					if var_1_18 == var_1_10023 then
						table = var_1_18

						var_1_18.insert(var_1_5, iter_1_1)
					else
						local var_1_19 = iter_1_1.type

						VIRTUAL_DROP_TYPE_ISLAND_SEASON_PT = var_1_10023

						if var_1_19 == var_1_10023 then
							local var_1_20 = iter_1_1.count

							if 0 < var_1_20 then
								table = var_1_20

								var_1_20.insert(var_1_14, iter_1_1)
							end
						else
							local var_1_21 = iter_1_1.type

							DROP_TYPE_ISLAND_FURNITURE = var_1_10023

							if var_1_21 == var_1_10023 then
								table = var_1_21

								var_1_21.insert(var_1_6, iter_1_1)
							else
								local var_1_22 = iter_1_1.type

								DROP_TYPE_ISLAND_DRESS = var_1_10023

								if var_1_22 == var_1_10023 then
									table = var_1_22

									var_1_22.insert(var_1_7, iter_1_1)
								else
									local var_1_23 = iter_1_1.type

									DROP_TYPE_ISLAND_SKIN = var_1_10023

									if var_1_23 == var_1_10023 then
										table = var_1_23

										var_1_23.insert(var_1_8, iter_1_1)
									else
										local var_1_24 = iter_1_1.type

										DROP_TYPE_ISLAND_ACTION = var_1_10023

										if var_1_24 == var_1_10023 then
											table = var_1_24

											var_1_24.insert(var_1_9, iter_1_1)
										else
											local var_1_25 = iter_1_1.type

											DROP_TYPE_ISLAND_CARD_DIY = var_1_10023

											if var_1_25 == var_1_10023 then
												table = var_1_25

												var_1_25.insert(var_1_10, iter_1_1)
											else
												local var_1_26 = iter_1_1.type

												DROP_TYPE_ISLAND_SPEEDUP_TICKET = var_1_10023

												if var_1_26 == var_1_10023 then
													table = var_1_26

													var_1_26.insert(var_1_11, iter_1_1)
												else
													local var_1_27 = iter_1_1.type

													DROP_TYPE_TIMESTAMP = var_1_10023

													if var_1_27 == var_1_10023 then
														table = var_1_27

														var_1_27.insert(var_1_12, iter_1_1)
													else
														local var_1_28 = iter_1_1.type

														DROP_TYPE_ISLAND_COLLECTION = var_1_10023

														if var_1_28 == var_1_10023 then
															table = var_1_28

															var_1_28.insert(var_1_13, iter_1_1)
														else
															table = var_1_28

															var_1_28.insert(var_1_4, iter_1_1)
														end
													end
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end

	local var_1_29 = var_0_0.GetIslandTimestamps(var_1_12)
	local var_1_30 = var_0_0.AddIslandItems(var_1_1)
	local var_1_31 = var_0_0.AddIslandOverFlowItems(var_1_2)
	local var_1_32 = var_0_0.AddIslandAbility(var_1_3)
	local var_1_33 = var_0_0.AddPlayerItems(var_1_4)
	local var_1_34 = var_0_0.AddShipInvitations(var_1_5)
	local var_1_35 = var_0_0.AddVirtualDrops(var_1_14)
	local var_1_36 = var_0_0.AddIslandFurnitureDrops(var_1_6)
	local var_1_37 = var_0_0.AddIslandDressDrops(var_1_7)
	local var_1_38 = var_0_0.AddIslandSkinDrops(var_1_8)
	local var_1_39 = var_0_0.AddIslandActionDrops(var_1_9)
	local var_1_40 = var_0_0.AddIslandCardDiyDrops(var_1_10)
	local var_1_41 = var_0_0.AddIslandTicketDrops(var_1_11, var_1_29)
	local var_1_42 = var_0_0.AddIslandCollectDrops(var_1_13)

	if #var_1_34 > 0 then
		ipairs = var_31

		for iter_1_2, iter_1_3 in var_31(var_1_34) do
			table = var_1_10036

			var_1_10036.insert(var_1_30, iter_1_3)
		end
	end

	if #var_1_35 > 0 then
		ipairs = var_31

		for iter_1_4, iter_1_5 in var_31(var_1_35) do
			table = var_1_10036

			var_1_10036.insert(var_1_30, iter_1_5)
		end
	end

	if #var_1_36 > 0 then
		ipairs = var_31

		for iter_1_6, iter_1_7 in var_31(var_1_36) do
			table = var_1_10036

			var_1_10036.insert(var_1_30, iter_1_7)
		end
	end

	if #var_1_37 > 0 then
		ipairs = var_31

		for iter_1_8, iter_1_9 in var_31(var_1_37) do
			pg = var_1_10036

			if var_1_10036.island_dress_template[iter_1_9.id].is_hide ~= 1 then
				table = var_1_10036

				var_1_10036.insert(var_1_30, iter_1_9)
			end
		end
	end

	if #var_1_38 > 0 then
		ipairs = var_31

		for iter_1_10, iter_1_11 in var_31(var_1_38) do
			table = var_1_10036

			var_1_10036.insert(var_1_30, iter_1_11)
		end
	end

	if #var_1_39 > 0 then
		ipairs = var_31

		for iter_1_12, iter_1_13 in var_31(var_1_39) do
			table = var_1_10036

			var_1_10036.insert(var_1_30, iter_1_13)
		end
	end

	if #var_1_40 > 0 then
		ipairs = var_31

		for iter_1_14, iter_1_15 in var_31(var_1_40) do
			table = var_1_10036

			var_1_10036.insert(var_1_30, iter_1_15)
		end
	end

	if #var_1_41 > 0 then
		ipairs = var_31

		for iter_1_16, iter_1_17 in var_31(var_1_41) do
			table = var_1_10036

			var_1_10036.insert(var_1_30, iter_1_17)
		end
	end

	if #var_1_42 > 0 then
		ipairs = var_31

		for iter_1_18, iter_1_19 in var_31(var_1_42) do
			table = var_1_10036

			var_1_10036.insert(var_1_30, iter_1_19)
		end
	end

	if arg_1_1 and arg_1_1 > 0 then
		var_0_0.AddIslandExp(arg_1_1)
	end

	return {
		awards = var_1_30,
		overflowAwards = var_1_31,
		abilitys = var_1_32,
		exp = arg_1_1,
		drops = var_1_33
	}
end

function var_0_0.GetIslandTimestamps(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.island_drop_time_set
	local var_2_1 = {}

	ipairs = var_1_10003

	for iter_2_0, iter_2_1 in var_1_10003(arg_2_0) do
		local var_2_2 = var_2_0[iter_2_1.id].drop_type
		local var_2_3 = var_8.link_id
		local var_2_4 = iter_2_1.number

		if not var_2_1[var_2_2] then
			var_2_1[var_2_2] = {}
		end

		var_2_1[var_2_2][var_2_3] = var_2_4
	end

	return var_2_1
end

function var_0_0.AddIslandExp(arg_3_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_3_0 = var_1_10001(var_1_10003)
	local var_3_1 = var_1.GetIsland(var_3_0)

	var_1.AddExp(var_3_1, arg_3_0)

	return
end

function var_0_0.AddIslandItems(arg_4_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_4_0 = var_1_10001(var_1_10003)
	local var_4_1 = var_1.GetIsland(var_4_0)
	local var_4_2 = var_1.GetInventoryAgency(var_4_1)
	local var_4_3 = {}

	ipairs = var_4_1

	for iter_4_0, iter_4_1 in var_4_1(arg_4_0) do
		IslandItem = var_1_10008
		var_1_10008 = var_1_10008.New(iter_4_1)

		var_4_2:AddItem(var_1_10008)

		table = var_9

		local var_4_4 = var_9.insert
		local var_4_5 = var_4_3

		Drop = var_12

		local var_4_6 = var_12.New
		local var_4_7 = {}

		DROP_TYPE_ISLAND_ITEM = var_1_10015
		var_4_7.type = var_1_10015
		var_4_7.id = iter_4_1.id

		if not iter_4_1.number and not iter_4_1.num then
			var_1_10015 = iter_4_1.count
		end

		var_4_7.count = var_1_10015

		var_4_4(var_4_5, var_4_6(var_4_7))
	end

	return var_4_3
end

function var_0_0.AddIslandOverFlowItems(arg_5_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_5_0 = var_1_10001(var_1_10003)
	local var_5_1 = var_1.GetIsland(var_5_0)
	local var_5_2 = var_1.GetInventoryAgency(var_5_1)
	local var_5_3 = {}

	ipairs = var_5_1

	for iter_5_0, iter_5_1 in var_5_1(arg_5_0) do
		IslandItem = var_1_10008
		var_1_10008 = var_1_10008.New(iter_5_1)

		var_5_2:AddOverFlowItem(var_1_10008)

		table = var_9

		local var_5_4 = var_9.insert
		local var_5_5 = var_5_3

		Drop = var_12

		local var_5_6 = var_12.New
		local var_5_7 = {}

		DROP_TYPE_ISLAND_ITEM = var_1_10015
		var_5_7.type = var_1_10015
		var_5_7.id = iter_5_1.id

		if not iter_5_1.number and not iter_5_1.num then
			var_1_10015 = iter_5_1.count
		end

		var_5_7.count = var_1_10015

		var_5_4(var_5_5, var_5_6(var_5_7))
	end

	return var_5_3
end

function var_0_0.AddIslandAbility(arg_6_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_6_0 = var_1_10001(var_1_10003)
	local var_6_1 = var_1.GetIsland(var_6_0)
	local var_6_2 = var_1.GetAblityAgency(var_6_1)
	local var_6_3 = {}

	ipairs = var_6_1

	for iter_6_0, iter_6_1 in var_6_1(arg_6_0) do
		if not var_6_2:HasAbility(iter_6_1.id) then
			var_6_2:AddAblity(iter_6_1.id)
			var_0_0.HandleIslandShopAbility(iter_6_1.id)
			var_0_0.HandleIslandAbilityByType(iter_6_1.id)

			table = var_8

			local var_6_4 = var_8.insert
			local var_6_5 = var_6_3

			Drop = var_11

			local var_6_6 = var_11.New
			local var_6_7 = {
				count = 1
			}

			DROP_TYPE_ISLAND_ABILITY = var_1_10014
			var_6_7.type = var_1_10014
			var_6_7.id = iter_6_1.id

			var_6_4(var_6_5, var_6_6(var_6_7))
		end
	end

	return var_6_3
end

function var_0_0.HandleIslandShopAbility(arg_7_0)
	IslandAblityAgency = var_1_10001

	local var_7_0 = var_1_10001.GetEffect(arg_7_0)

	IslandAblityAgency = var_1_10002

	if var_1_10002.IsShopTypeNormal(arg_7_0) then
		pg = var_2

		if var_2.island_shop_normal_template[var_7_0] then
			local var_7_1

			if var_2.unlock ~= "" or not {} then
				var_7_1 = var_2.unlock
			end

			local var_7_2 = true

			ipairs = var_1_10005

			for iter_7_0, iter_7_1 in var_1_10005(var_7_1) do
				getProxy = var_1_10010
				IslandProxy = var_1_10012
				var_1_10012 = var_1_10010(var_1_10012)
				var_1_10012 = var_1_10010.GetIsland(var_1_10012)
				var_1_10012 = var_1_10010.GetAblityAgency(var_1_10012)

				if not var_1_10010.HasAbility(var_1_10012, iter_7_1) then
					var_7_2 = false

					break
				end
			end

			if var_7_2 then
				getProxy = var_5
				IslandProxy = var_7

				local var_7_3 = var_5(var_7)
				local var_7_4 = var_5.GetIsland(var_7_3)
				local var_7_5 = var_5.GetShopAgency(var_7_4)

				var_5.RefreshShopData(var_7_5, var_7_0)
			end
		end
	else
		IslandAblityAgency = var_2

		if var_2.IsShopTypeTemporary(arg_7_0) then
			getProxy = var_2
			IslandProxy = var_4

			local var_7_6 = var_2(var_4)
			local var_7_7 = var_2.GetIsland(var_7_6)
			local var_7_8 = var_2.GetShopAgency(var_7_7)

			var_2.RefreshShopData(var_7_8, var_7_0)
		end
	end

	return
end

function var_0_0.HandleIslandAbilityByType(arg_8_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_8_0 = var_1_10001(var_1_10003)
	local var_8_1 = var_1.GetIsland(var_8_0)

	IslandAblityAgency = var_1_10002

	local var_8_2 = var_1_10002.GetEffect(arg_8_0)

	switch = var_8_0
	IslandAblityAgency = var_1_10005

	local var_8_3 = var_1_10005.GetAblityType(arg_8_0)
	local var_8_4 = {}

	IslandAblityAgency = var_7
	var_8_4[var_7.TYPE_SLOT] = function()
		local var_9_0 = var_8_1
		local var_9_1 = var_0.GetBuildingAgency(var_9_0)

		var_0.InitSlotDataByAbility(var_9_1, arg_8_0)

		return
	end
	IslandAblityAgency = var_7
	var_8_4[var_7.TYPE_RESTAURANT] = function()
		local var_10_0 = var_8_1
		local var_10_1 = var_0.GetManageAgency(var_10_0)

		var_0.UnlockNewRestaurant(var_10_1, var_8_2)

		return
	end
	IslandAblityAgency = var_7
	var_8_4[var_7.TYPE_ASSISTANT] = function()
		local var_11_0 = var_8_1
		local var_11_1 = var_0.GetManageAgency(var_11_0)

		var_0.UnlockNewAssistant(var_11_1, var_8_2)

		return
	end
	IslandAblityAgency = var_7
	var_8_4[var_7.TYPE_ANIMAL] = function()
		local var_12_0 = var_8_1
		local var_12_1 = var_0.GetBuildingAgency(var_12_0)

		var_0.InitBuildAnimalDataByAbility(var_12_1, var_8_2)

		return
	end
	IslandAblityAgency = var_7
	var_8_4[var_7.TYPE_RECOVER_CAMP] = function()
		local var_13_0 = var_8_1
		local var_13_1 = var_0.GetBuildingAgency(var_13_0)
		local var_13_2 = var_0.GetBuilding

		IslandProductConst = var_2_10003

		local var_13_3 = var_13_2(var_13_1, var_2_10003.FellingPlaceId)
		local var_13_4 = var_0.GetBuildingCollectData(var_13_3)

		pg = var_13_1

		local var_13_5 = var_13_1.TimeMgr.GetInstance()
		local var_13_6 = var_2.GetServerTime(var_13_5)

		pg = var_13_3

		local var_13_7 = var_13_3.TimeMgr.GetInstance()

		if var_3.GetZeroTimeStamp(var_13_7, var_13_6) + var_8_2 < var_13_4:GetNextRecoverTimes() then
			var_13_4:UpdateCollectRefreshtTime(var_4)
		end

		return
	end
	IslandAblityAgency = var_7
	var_8_4[var_7.TYPE_RECOVER_ORE] = function()
		local var_14_0 = var_8_1
		local var_14_1 = var_0.GetBuildingAgency(var_14_0)
		local var_14_2 = var_0.GetBuilding

		IslandProductConst = var_2_10003

		local var_14_3 = var_14_2(var_14_1, var_2_10003.MinePlaceId)
		local var_14_4 = var_0.GetBuildingCollectData(var_14_3)

		pg = var_14_1

		local var_14_5 = var_14_1.TimeMgr.GetInstance()
		local var_14_6 = var_2.GetServerTime(var_14_5)

		pg = var_14_3

		local var_14_7 = var_14_3.TimeMgr.GetInstance()

		if var_3.GetZeroTimeStamp(var_14_7, var_14_6) + var_8_2 < var_14_4:GetNextRecoverTimes() then
			var_14_4:UpdateCollectRefreshtTime(var_4)
		end

		return
	end
	IslandAblityAgency = var_7
	var_8_4[var_7.TYPE_FISHING_ROD] = function()
		local var_15_0 = var_8_1
		local var_15_1 = var_0.GetFishingAgency(var_15_0)

		var_0.UpdateFishRodId(var_15_1, var_8_2)

		return
	end

	var_8_0(var_8_3, var_8_4)

	return
end

function var_0_0.AddPlayerItems(arg_16_0)
	PlayerConst = var_1_10001

	return var_1_10001.addTranDrop(arg_16_0)
end

function var_0_0.AddShipInvitations(arg_17_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_17_0 = var_1_10001(var_1_10003)
	local var_17_1 = var_1.GetIsland(var_17_0)
	local var_17_2 = var_1.GetCharacterAgency(var_17_1)
	local var_17_3 = {}

	ipairs = var_17_1

	for iter_17_0, iter_17_1 in var_17_1(arg_17_0) do
		var_17_2:AddInvite(iter_17_1.id)

		table = var_8

		local var_17_4 = var_8.insert
		local var_17_5 = var_17_3

		Drop = var_11

		local var_17_6 = var_11.New
		local var_17_7 = {}

		DROP_TYPE_ISLAND_INVITATION = var_1_10014
		var_17_7.type = var_1_10014
		var_17_7.id = iter_17_1.id

		if not iter_17_1.number and not iter_17_1.num then
			var_1_10014 = iter_17_1.count
		end

		var_17_7.count = var_1_10014

		var_17_4(var_17_5, var_17_6(var_17_7))
	end

	return var_17_3
end

function var_0_0.AddVirtualDrops(arg_18_0)
	local var_18_0 = {}

	ipairs = var_1_10002

	for iter_18_0, iter_18_1 in var_1_10002(arg_18_0) do
		switch = var_1_10007

		local var_18_1 = iter_18_1.type
		local var_18_2 = {}

		VIRTUAL_DROP_TYPE_ISLAND_SEASON_PT = var_1_10011
		var_18_2[var_1_10011] = function()
			Drop = var_2_10000

			local var_19_0 = var_2_10000.New
			local var_19_1 = {
				type = iter_18_1.type,
				id = iter_18_1.id
			}
			local var_19_2

			if not iter_18_1.number and not iter_18_1.num then
				var_19_2 = iter_18_1.count
			end

			var_19_1.count = var_19_2

			local var_19_3 = var_19_0(var_19_1)

			table = var_2_10001

			var_2_10001.insert(var_18_0, var_19_3)

			getProxy = var_1
			IslandProxy = var_3

			local var_19_4 = var_1(var_3)
			local var_19_5 = var_1.GetIsland(var_19_4)
			local var_19_6 = var_1.GetSeasonAgency(var_19_5)

			var_1.AddPt(var_19_6, var_19_3.count)

			return
		end

		var_1_10007(var_18_1, var_18_2)
	end

	return var_18_0
end

function var_0_0.AddIslandFurnitureDrops(arg_20_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_20_0 = var_1_10001(var_1_10003)
	local var_20_1 = var_1.GetIsland(var_20_0)
	local var_20_2 = var_1.GetAgoraAgency(var_20_1)
	local var_20_3 = {}

	ipairs = var_20_1

	for iter_20_0, iter_20_1 in var_20_1(arg_20_0) do
		IslandFurniture = var_1_10008
		var_1_10008 = var_1_10008.New

		local var_20_4 = {
			id = iter_20_1.id
		}
		local var_20_5

		if not iter_20_1.number and not iter_20_1.num then
			var_20_5 = iter_20_1.count
		end

		var_20_4.count = var_20_5

		local var_20_6 = var_1_10008(var_20_4)
		local var_20_7 = var_1_10008.SetTime

		pg = var_1_10012

		local var_20_8 = var_1_10012.TimeMgr
		local var_20_9 = var_1_10012.GetInstance(var_20_8)

		var_20_7(var_20_6, var_1_10012.GetServerTime(var_20_9))

		local var_20_10 = var_20_2

		var_20_2.AddFurniture(var_20_10, var_1_10008)

		IslandTaskHelper = var_9

		local var_20_11 = var_9.UpdateRuntimeTaskByTargetType

		IslandTaskTargetType = var_20_10

		var_20_11(var_20_10.FURNITURE)

		table = var_20_11

		local var_20_12 = var_20_11.insert
		local var_20_13 = var_20_3

		Drop = var_1_10012
		var_1_10012 = var_1_10012.New

		local var_20_14 = {}

		DROP_TYPE_ISLAND_FURNITURE = var_1_10015
		var_20_14.type = var_1_10015
		var_20_14.id = iter_20_1.id

		if not iter_20_1.number and not iter_20_1.num then
			var_1_10015 = iter_20_1.count
		end

		var_20_14.count = var_1_10015

		var_20_12(var_20_13, var_1_10012(var_20_14))
	end

	return var_20_3
end

function var_0_0.AddIslandDressDrops(arg_21_0)
	local var_21_0 = {}

	getProxy = var_1_10002
	IslandProxy = var_1_10004

	local var_21_1 = var_1_10002(var_1_10004)
	local var_21_2 = var_2.GetIsland(var_21_1)

	ipairs = var_1_10003

	for iter_21_0, iter_21_1 in var_1_10003(arg_21_0) do
		pg = var_1_10008

		if var_1_10008.island_dress_template[iter_21_1.id].belongto == 1 then
			var_1_10012 = var_21_2:GetDressUpAgency()

			var_9.AddDressByDressId(var_1_10012, iter_21_1.id)

			IslandTaskHelper = var_10

			local var_21_3 = var_10.UpdateRuntimeTaskByTargetType

			IslandTaskTargetType = var_1_10012

			var_21_3(var_1_10012.COMMANDER_DRESS)

			IslandTaskHelper = var_21_3

			local var_21_4 = var_21_3.UpdateRuntimeTaskByTargetType

			IslandTaskTargetType = var_1_10012

			var_21_4(var_1_10012.COMMANDER_DRESS_ID)

			IslandAchievementHelper = var_21_4

			local var_21_5 = var_21_4.UpdateRecordWithAdd

			IslandAchievementType = var_1_10012

			var_21_5(var_1_10012.COMMANDER_DRESS_TYPE, var_1_10008.type, 1)
		else
			var_1_10012 = var_21_2:GetCharacterAgency()

			local var_21_6 = not var_9.ExistDressId(var_1_10012, iter_21_1.id)
			local var_21_7 = var_9

			var_9.AddDressItem(var_21_7, iter_21_1.id, iter_21_1.number, true)

			IslandTaskHelper = var_11

			local var_21_8 = var_11.UpdateRuntimeTaskByTargetType

			IslandTaskTargetType = var_21_7

			var_21_8(var_21_7.SHIP_DRESS_ID)

			if var_21_6 then
				IslandTaskHelper = var_21_8

				local var_21_9 = var_21_8.UpdateRuntimeTaskByTargetType

				IslandTaskTargetType = var_13

				var_21_9(var_13.SHIP_DRESS)

				IslandAchievementHelper = var_21_9

				local var_21_10 = var_21_9.UpdateRecordWithAdd

				IslandAchievementType = var_13

				var_21_10(var_13.SHIP_DRESS_TYPE, var_1_10008.type, 1)
			end
		end

		table = var_9

		local var_21_11 = var_9.insert
		local var_21_12 = var_21_0

		Drop = var_1_10012
		var_1_10012 = var_1_10012.New

		local var_21_13 = {}

		DROP_TYPE_ISLAND_DRESS = var_1_10015
		var_21_13.type = var_1_10015
		var_21_13.id = iter_21_1.id

		if not iter_21_1.number and not iter_21_1.num then
			var_1_10015 = iter_21_1.count
		end

		var_21_13.count = var_1_10015

		var_21_11(var_21_12, var_1_10012(var_21_13))

		pg = var_21_11

		local var_21_14 = var_21_11.GameTrackerMgr.GetInstance()
		local var_21_15 = var_9.Record

		GameTrackerBuilder = var_1_10012

		var_21_15(var_21_14, var_1_10012.BuildIslandGetDress(var_1_10008.belongto, iter_21_1.id))
	end

	return var_21_0
end

function var_0_0.AddIslandSkinDrops(arg_22_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_22_0 = var_1_10001(var_1_10003)
	local var_22_1 = var_1.GetIsland(var_22_0)
	local var_22_2 = var_1.GetCharacterAgency(var_22_1)
	local var_22_3 = {}

	ipairs = var_22_1

	for iter_22_0, iter_22_1 in var_22_1(arg_22_0) do
		var_22_2:AddSkin(iter_22_1.id)

		table = var_9

		local var_22_4 = var_9.insert
		local var_22_5 = var_22_3

		Drop = var_12

		local var_22_6 = var_12.New
		local var_22_7 = {}

		DROP_TYPE_ISLAND_SKIN = var_1_10015
		var_22_7.type = var_1_10015
		var_22_7.id = iter_22_1.id

		if not iter_22_1.number and not iter_22_1.num then
			var_1_10015 = iter_22_1.count
		end

		var_22_7.count = var_1_10015

		var_22_4(var_22_5, var_22_6(var_22_7))
	end

	if #arg_22_0 > 0 then
		IslandTaskHelper = var_4

		local var_22_8 = var_4.UpdateRuntimeTaskByTargetType

		IslandTaskTargetType = var_6

		var_22_8(var_6.SHIP_SKIN)

		IslandAchievementHelper = var_22_8

		local var_22_9 = var_22_8.UpdateRecordWithAdd

		IslandAchievementType = var_6

		var_22_9(var_6.SHIP_SKIN, 0, #arg_22_0)
	end

	return var_22_3
end

function var_0_0.AddIslandActionDrops(arg_23_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_23_0 = var_1_10001(var_1_10003)
	local var_23_1 = var_1.GetIsland(var_23_0)
	local var_23_2 = var_1.GetActionAgency(var_23_1)
	local var_23_3 = {}

	ipairs = var_23_1

	for iter_23_0, iter_23_1 in var_23_1(arg_23_0) do
		local var_23_4 = var_23_2

		var_23_2.AddAction(var_23_4, iter_23_1.id)

		IslandTaskHelper = var_8

		local var_23_5 = var_8.UpdateRuntimeTaskByTargetType

		IslandTaskTargetType = var_23_4

		var_23_5(var_23_4.ACTION)

		IslandAchievementHelper = var_23_5

		local var_23_6 = var_23_5.UpdateRecordWithAdd

		IslandTaskTargetType = var_10

		var_23_6(var_10.ACTION, 0, 1)

		table = var_23_6

		local var_23_7 = var_23_6.insert
		local var_23_8 = var_23_3

		Drop = var_11

		local var_23_9 = var_11.New
		local var_23_10 = {}

		DROP_TYPE_ISLAND_ACTION = var_1_10014
		var_23_10.type = var_1_10014
		var_23_10.id = iter_23_1.id

		if not iter_23_1.number and not iter_23_1.num then
			var_1_10014 = iter_23_1.count
		end

		var_23_10.count = var_1_10014

		var_23_7(var_23_8, var_23_9(var_23_10))
	end

	return var_23_3
end

function var_0_0.AddIslandCardDiyDrops(arg_24_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_24_0 = var_1_10001(var_1_10003)
	local var_24_1 = var_1.GetIsland(var_24_0)
	local var_24_2 = var_1.GetCardDiyAgency(var_24_1)
	local var_24_3 = {}

	ipairs = var_24_1

	for iter_24_0, iter_24_1 in var_24_1(arg_24_0) do
		var_24_2:AddCardDiy(iter_24_1)

		table = var_8

		local var_24_4 = var_8.insert
		local var_24_5 = var_24_3

		Drop = var_11

		local var_24_6 = var_11.New
		local var_24_7 = {}

		DROP_TYPE_ISLAND_CARD_DIY = var_1_10014
		var_24_7.type = var_1_10014
		var_24_7.id = iter_24_1.id

		if not iter_24_1.number and not iter_24_1.num then
			var_1_10014 = iter_24_1.count
		end

		var_24_7.count = var_1_10014

		var_24_4(var_24_5, var_24_6(var_24_7))
	end

	return var_24_3
end

function var_0_0.AddIslandTicketDrops(arg_25_0, arg_25_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10004

	local var_25_0 = var_1_10002(var_1_10004)
	local var_25_1 = var_2.GetIsland(var_25_0)
	local var_25_2 = var_2.GetTicketAgency(var_25_1)
	local var_25_3 = {}

	ipairs = var_25_1

	for iter_25_0, iter_25_1 in var_25_1(arg_25_0) do
		DROP_TYPE_ISLAND_SPEEDUP_TICKET = var_1_10009
		var_1_10009 = arg_25_1[var_1_10009][iter_25_1.id]
		IslandTicket = var_10

		local var_25_4 = var_10.GetEndTimeById(iter_25_1.id, var_1_10009)
		local var_25_5

		if not iter_25_1.number and not iter_25_1.num then
			var_25_5 = iter_25_1.count
		end

		var_25_2:AddTicket(iter_25_1.id, var_25_4, var_25_5)

		table = var_12

		local var_25_6 = var_12.insert
		local var_25_7 = var_25_3

		Drop = var_15

		local var_25_8 = var_15.New
		local var_25_9 = {}

		DROP_TYPE_ISLAND_SPEEDUP_TICKET = var_1_10018
		var_25_9.type = var_1_10018
		var_25_9.id = iter_25_1.id
		var_25_9.count = var_25_5

		var_25_6(var_25_7, var_25_8(var_25_9))
	end

	return var_25_3
end

function var_0_0.AddIslandCollectDrops(arg_26_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_26_0 = var_1_10001(var_1_10003)
	local var_26_1 = var_1.GetIsland(var_26_0)
	local var_26_2 = var_1.GetWildCollectAgency(var_26_1)
	local var_26_3 = {}

	ipairs = var_26_1

	for iter_26_0, iter_26_1 in var_26_1(arg_26_0) do
		var_26_2:AddFinishCollectData(iter_26_1.id)

		table = var_8

		local var_26_4 = var_8.insert
		local var_26_5 = var_26_3

		Drop = var_11

		local var_26_6 = var_11.New
		local var_26_7 = {}

		DROP_TYPE_ISLAND_COLLECTION = var_1_10014
		var_26_7.type = var_1_10014
		var_26_7.id = iter_26_1.id

		if not iter_26_1.number and not iter_26_1.num then
			var_1_10014 = iter_26_1.count
		end

		var_26_7.count = var_1_10014

		var_26_4(var_26_5, var_26_6(var_26_7))
	end

	return var_26_3
end

return var_0_0
