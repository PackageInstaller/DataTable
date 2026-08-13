local var_0_0 = {}

PaintingfilteConst = PaintingfilteConst

function var_0.GetStandardTimeConfig(arg_1_0)
	local var_1_0 = {}

	local function var_1_1(arg_2_0)
		ipairs = var_2_10001

		for iter_2_0, iter_2_1 in var_2_10001(arg_2_0) do
			type = var_2_10006

			if var_2_10006(iter_2_1) == "table" and #iter_2_1 == 2 then
				table = var_2_10006

				var_2_10006.insert(var_1_0, iter_2_1)
			end
		end

		return
	end

	local function var_1_2(arg_3_0)
		ipairs = var_2_10001

		for iter_3_0, iter_3_1 in var_2_10001(arg_3_0) do
			type = var_2_10006

			if var_2_10006(iter_3_1) == "table" then
				type = var_2_10006

				if var_2_10006(iter_3_1[1]) == "string" then
					type = var_2_10006

					if var_2_10006(iter_3_1[2]) == "table" then
						var_1_1(iter_3_1)
					end
				end
			end
		end

		return
	end

	if #arg_1_0 == 2 then
		type = var_4

		if var_4(arg_1_0[1][1]) == "string" then
			type = var_4

			if var_4(arg_1_0[2][1]) == "string" then
				var_1_2(arg_1_0)

				goto label_1_0
			end
		end
	end

	var_1_1(arg_1_0)

	::label_1_0::

	return var_1_0
end

function var_0.IsTwoTimeCross(arg_4_0, arg_4_1)
	pg = var_1_10002

	local var_4_0 = var_1_10002.TimeMgr.GetInstance()
	local var_4_1 = var_2.parseTimeFromConfig(var_4_0, arg_4_0[1])
	local var_4_2 = var_2:parseTimeFromConfig(arg_4_0[2])
	local var_4_3 = var_2:parseTimeFromConfig(arg_4_1[1])
	local var_4_4 = var_2:parseTimeFromConfig(arg_4_1[2])

	if var_4_2 <= var_4_3 or var_4_4 <= var_4_1 then
		return false
	else
		return true
	end

	return
end

function var_0.IsActMatchTime(arg_5_0)
	pg = var_1_10001

	local var_5_0 = var_1_10001.activity_template[arg_5_0].type
	local var_5_1 = var_1.time

	type = var_1_10004

	if var_1_10004(var_5_1) == "string" and var_5_1 == "always" then
		return true
	else
		type = var_4

		if var_4(var_5_1) == "table" then
			local var_5_2 = var_0.GetStandardTimeConfig(var_5_1)
			local var_5_3 = var_0.GetfilteTime()

			if var_0.IsTwoTimeCross(var_5_3, var_5_2) then
				return true
			end
		end
	end

	return
end

function var_0.IsBuildActMatch(arg_6_0)
	pg = var_1_10001

	local var_6_0

	if var_1_10001.activity_template[arg_6_0].type ~= 1 then
		pg = var_1

		if var_1.activity_template[arg_6_0].type ~= 85 then
			var_6_0 = false

			goto label_6_0
		end
	end

	var_6_0 = true

	::label_6_0::

	if var_6_0 then
		return (var_0.IsActMatchTime(arg_6_0))
	else
		return false
	end

	return
end

function var_0.IsNormalShopMatch(arg_7_0)
	pg = var_1_10001

	local var_7_0 = var_1_10001.shop_template[arg_7_0].genre
	local var_7_1 = var_1.time

	if var_7_0 == "skin_shop" then
		type = var_1_10004

		if var_1_10004(var_7_1) == "string" and var_7_1 == "always" then
			return true
		else
			type = var_4

			if var_4(var_7_1) == "table" then
				local var_7_2 = var_0.GetStandardTimeConfig(var_7_1)
				local var_7_3 = var_0.GetfilteTime()

				if var_0.IsTwoTimeCross(var_7_3, var_7_2) then
					return true
				end
			end
		end
	end

	return false
end

function var_0.IsActShopMatch(arg_8_0)
	pg = var_1_10001

	local var_8_0 = var_1_10001.activity_shop_extra[arg_8_0].commodity_type
	local var_8_1 = var_1.time

	DROP_TYPE_SKIN = var_1_10004

	if var_8_0 == var_1_10004 then
		type = var_1_10004

		if var_1_10004(var_8_1) == "string" and var_8_1 == "always" then
			return true
		else
			type = var_4

			if var_4(var_8_1) == "table" then
				local var_8_2 = var_0.GetStandardTimeConfig(var_8_1)
				local var_8_3 = var_0.GetfilteTime()

				if var_0.IsTwoTimeCross(var_8_3, var_8_2) then
					return true
				end
			end
		end
	end

	return false
end

function var_0.GetfilteTime()
	pg = var_1_10000

	return var_1_10000.painting_filte_config.time
end

function var_0.GetConstPoolIndexList()
	pg = var_1_10000

	return var_1_10000.painting_filte_config.pool_id_list
end

function var_0.IsPoolWeightConfigMatch(arg_11_0, arg_11_1)
	ipairs = var_1_10002

	for iter_11_0, iter_11_1 in var_1_10002(arg_11_1) do
		if arg_11_0[iter_11_1] > 0 then
			return true
		end
	end

	return false
end

function var_0.GetBuildActIDList()
	local var_12_0 = {}

	ipairs = var_1_10001
	pg = var_1_10003

	for iter_12_0, iter_12_1 in var_1_10001(var_1_10003.activity_template.all) do
		if var_0.IsBuildActMatch(iter_12_1) then
			table = var_6

			var_6.insert(var_12_0, iter_12_1)
		end
	end

	return var_12_0
end

function var_0.GetActPoolIndexList()
	local var_13_0 = {}
	local var_13_1 = var_0.GetBuildActIDList()

	ipairs = var_1_10002

	for iter_13_0, iter_13_1 in var_1_10002(var_13_1) do
		pg = var_1_10007
		var_1_10007 = var_1_10007.activity_template[iter_13_1].config_id
		table = var_1_10008

		if not var_1_10008.contains(var_13_0, var_1_10007) then
			table = var_1_10008

			var_1_10008.insert(var_13_0, var_1_10007)
		end
	end

	return var_13_0
end

function var_0.GetShipConfigIDListByPoolList(arg_14_0)
	local var_14_0 = {}

	pairs = var_1_10002
	pg = var_1_10004

	for iter_14_0, iter_14_1 in var_1_10002(var_1_10004.ship_data_create) do
		local var_14_1 = iter_14_1.weight_group

		if var_0.IsPoolWeightConfigMatch(var_14_1, arg_14_0) then
			table = var_1_10009

			if not var_1_10009.contains(var_14_0, iter_14_0) then
				table = var_1_10009

				var_1_10009.insert(var_14_0, iter_14_0)
			end
		end
	end

	return var_14_0
end

function var_0.GetLightPoolBlueDestroyerShipConfigIDList(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0 = arg_15_0 or 2
	arg_15_1 = arg_15_1 or 3
	arg_15_2 = arg_15_2 or 1

	local var_15_0 = {}

	type = var_1_10004

	if var_1_10004(arg_15_0) == "number" then
		type = var_4

		if var_4(arg_15_1) == "number" then
			type = var_4

			if var_4(arg_15_2) == "number" then
				type = var_4
				pg = var_6

				if var_4(var_6.ship_data_create) == "table" then
					type = var_4
					pg = var_6

					if var_4(var_6.ship_data_statistics) ~= "table" then
						return var_15_0
					end

					pairs = var_4
					pg = var_6

					for iter_15_0, iter_15_1 in var_4(var_6.ship_data_create) do
						type = var_1_10009

						if var_1_10009(iter_15_0) == "number" then
							type = var_1_10009

							if var_1_10009(iter_15_1) == "table" then
								var_1_10009 = iter_15_1[arg_15_0]
								pg = var_1_10010
								var_1_10010 = var_1_10010.ship_data_statistics[iter_15_0]
								type = var_11

								if var_11(var_1_10009) == "number" and 0 < var_1_10009 then
									type = var_11

									if var_11(var_1_10010) == "table" and var_1_10010.rarity == arg_15_1 and var_1_10010.type == arg_15_2 then
										table = var_11

										var_11.insert(var_15_0, iter_15_0)
									end
								end
							end
						end
					end

					return var_15_0
				end
			end
		end
	end
end

function var_0.GetActID2MemoryMap()
	local var_16_0 = {}

	ipairs = var_1_10001
	pg = var_1_10003

	for iter_16_0, iter_16_1 in var_1_10001(var_1_10003.memory_group.all) do
		pg = var_1_10006

		local var_16_1 = var_1_10006.memory_group[iter_16_1].link_event
		local var_16_2 = var_1_10006.memories

		if var_16_1 and var_16_1 > 0 then
			if not var_16_0[var_16_1] then
				var_16_0[var_16_1] = {}
			end

			ipairs = var_9

			for iter_16_2, iter_16_3 in var_9(var_16_2) do
				table = var_1_10014

				if not var_1_10014.contains(var_16_0[var_16_1], iter_16_3) then
					table = var_1_10014

					var_1_10014.insert(var_16_0[var_16_1], iter_16_3)
				end
			end
		end
	end

	return var_16_0
end

function var_0.GetActPoolShipConfigIDList()
	local var_17_0 = var_0.GetActPoolIndexList()

	return var_0.GetShipConfigIDListByPoolList(var_17_0)
end

function var_0.GetConstPoolShipConfigIDList()
	local var_18_0 = var_0.GetConstPoolIndexList()

	return var_0.GetShipConfigIDListByPoolList(var_18_0)
end

function var_0.GetCreateExchangeShipConfigIDList()
	local var_19_0 = {}
	local var_19_1 = {
		10,
		11
	}

	ipairs = var_1_10002

	for iter_19_0, iter_19_1 in var_1_10002(var_19_1) do
		local var_19_2 = var_0.GetBuildActIDList()

		ipairs = var_1_10008

		for iter_19_2, iter_19_3 in var_1_10008(var_19_2) do
			pg = var_1_10013

			if var_1_10013.ship_data_create_exchange[iter_19_3] then
				ipairs = var_1_10013
				pg = var_1_10015

				for iter_19_4, iter_19_5 in var_1_10013(var_1_10015.ship_data_create_exchange[iter_19_3].exchange_ship_id) do
					table = var_1_10018

					if not var_1_10018.contains(var_19_0, iter_19_5) then
						table = var_1_10018

						var_1_10018.insert(var_19_0, iter_19_5)
					end
				end
			end
		end
	end

	return var_19_0
end

function var_0.GetNPCShipConfigIDList()
	local var_20_0 = {}

	ipairs = var_1_10001
	getGameset = var_1_10003

	for iter_20_0, iter_20_1 in var_1_10001(var_1_10003("act_npc_ship_id")[2]) do
		if var_0.IsActMatchTime(iter_20_1) then
			pg = var_6

			local var_20_1 = var_6.activity_template[iter_20_1].config_data[1]

			pg = var_1_10007

			local var_20_2 = var_1_10007.task_data_template[var_20_1].award_display[1][2]

			table = var_1_10009

			var_1_10009.insert(var_20_0, var_20_2)
		end
	end

	return var_20_0
end

function var_0.GetSkinIDFromNormalShopID(arg_21_0)
	pg = var_1_10001

	local var_21_0 = var_1_10001.shop_template[arg_21_0].effect_args

	assert = var_1_10003

	var_1_10003(#var_21_0 == 1, "shop_template的effect_args字段,元素个数大于1,ID:", arg_21_0)

	return var_21_0[1]
end

function var_0.GetNormalShopSkinIDList()
	local var_22_0 = {}

	ipairs = var_1_10001
	pg = var_1_10003

	local var_22_1 = var_1_10003.shop_template.get_id_list_by_genre

	ShopArgs = var_1_10004

	for iter_22_0, iter_22_1 in var_1_10001(var_22_1[var_1_10004.SkinShop]) do
		if var_0.IsNormalShopMatch(iter_22_1) then
			local var_22_2 = var_0.GetSkinIDFromNormalShopID(iter_22_1)

			table = var_1_10007

			if not var_1_10007.contains(var_22_0, var_22_2) then
				table = var_1_10007

				var_1_10007.insert(var_22_0, var_22_2)
			end

			ShipSkin = var_1_10007

			if var_1_10007.IsChangeSkin(var_22_2) then
				ShipSkin = var_1_10007
				var_1_10007 = var_1_10007.GetAllChangeSkinIds(var_22_2)
				ipairs = var_8

				for iter_22_2, iter_22_3 in var_8(var_1_10007) do
					table = var_1_10013

					if not var_1_10013.contains(var_22_0, iter_22_3) then
						table = var_1_10013

						var_1_10013.insert(var_22_0, iter_22_3)
					end
				end
			end
		end
	end

	warning = var_1

	var_1("普通商店皮肤个数" .. #var_22_0)

	return var_22_0
end

function var_0.GetSkinIDFromActShopID(arg_23_0)
	pg = var_1_10001

	return var_1_10001.activity_shop_extra[arg_23_0].commodity_id
end

function var_0.GetActShopSkinIDList()
	local var_24_0 = {}

	ipairs = var_1_10001
	pg = var_1_10003

	local var_24_1 = var_1_10003.activity_shop_extra.get_id_list_by_commodity_type

	DROP_TYPE_SKIN = var_1_10004

	for iter_24_0, iter_24_1 in var_1_10001(var_24_1[var_1_10004]) do
		if var_0.IsActShopMatch(iter_24_1) then
			local var_24_2 = var_0.GetSkinIDFromActShopID(iter_24_1)

			table = var_1_10007

			if not var_1_10007.contains(var_24_0, var_24_2) then
				table = var_1_10007

				var_1_10007.insert(var_24_0, var_24_2)
			end

			ShipSkin = var_1_10007

			if var_1_10007.IsChangeSkin(var_24_2) then
				ShipSkin = var_1_10007
				var_1_10007 = var_1_10007.GetAllChangeSkinIds(var_24_2)
				ipairs = var_8

				for iter_24_2, iter_24_3 in var_8(var_1_10007) do
					table = var_1_10013

					if not var_1_10013.contains(var_24_0, iter_24_3) then
						table = var_1_10013

						var_1_10013.insert(var_24_0, iter_24_3)
					end
				end
			end
		end
	end

	warning = var_1

	var_1("活动商店皮肤个数" .. #var_24_0)

	return var_24_0
end

local function var_0_1(arg_25_0, arg_25_1)
	string = var_1_10002
	arg_25_1 = var_1_10002.lower(arg_25_1)
	pg = var_2

	local var_25_0 = var_2.painting_filte_map[arg_25_1].res_list

	ipairs = var_1_10003

	for iter_25_0, iter_25_1 in var_1_10003(var_25_0) do
		table = var_1_10008

		if not var_1_10008.contains(arg_25_0, iter_25_1) then
			table = var_1_10008

			var_1_10008.insert(arg_25_0, iter_25_1)
		end
	end

	return
end

local function var_0_2(arg_26_0, arg_26_1)
	ShipGroup = var_1_10002

	local var_26_0 = var_1_10002.getDefaultSkin(arg_26_1).painting

	var_0_1(arg_26_0, var_26_0)

	return
end

local function var_0_3(arg_27_0, arg_27_1)
	local var_27_0 = {
		configId = arg_27_1
	}

	Ship = var_1_10003

	local var_27_1 = var_1_10003.getGroupId(var_27_0)

	var_0_2(arg_27_0, var_27_1)

	return
end

local function var_0_4(arg_28_0, arg_28_1)
	pg = var_1_10002

	local var_28_0 = var_1_10002.ship_skin_template[arg_28_1].painting

	var_0_1(arg_28_0, var_28_0)

	return
end

local function var_0_5()
	local var_29_0 = {}

	local function var_29_1(arg_30_0)
		ipairs = var_2_10001

		for iter_30_0, iter_30_1 in var_2_10001(arg_30_0) do
			var_0_3(var_29_0, iter_30_1)
		end

		return
	end

	local function var_29_2(arg_31_0)
		ipairs = var_2_10001

		for iter_31_0, iter_31_1 in var_2_10001(arg_31_0) do
			var_0_4(var_29_0, iter_31_1)
		end

		return
	end

	pg = var_1_10003

	local var_29_3

	if var_1_10003.painting_filte_config.current_act_pool == 1 then
		PaintingfilteConst = var_29_3
		var_29_3 = var_29_3.GetActPoolShipConfigIDList()

		var_29_1(var_29_3)
	end

	PaintingfilteConst = var_29_3

	local var_29_4 = var_29_3.GetConstPoolShipConfigIDList()

	var_29_1(var_29_4)

	PaintingfilteConst = var_4

	local var_29_5 = var_4.GetLightPoolBlueDestroyerShipConfigIDList()

	var_29_1(var_29_5)

	PaintingfilteConst = var_5

	local var_29_6 = var_5.GetNPCShipConfigIDList()

	var_29_1(var_29_6)

	PaintingfilteConst = var_6

	local var_29_7 = var_6.GetCreateExchangeShipConfigIDList()

	var_29_1(var_29_7)

	pg = var_7

	local var_29_8

	if var_7.painting_filte_config.current_sale_skin == 1 then
		PaintingfilteConst = var_29_8
		var_29_8 = var_29_8.GetNormalShopSkinIDList()
		warning = var_8

		var_8("normalShopSkinIDList:" .. #var_29_8)
		var_29_2(var_29_8)

		PaintingfilteConst = var_8

		local var_29_9 = var_8.GetActShopSkinIDList()

		warning = var_9

		var_9("actShopSkinIDList:" .. #var_29_9)
		var_29_2(var_29_9)
	end

	ipairs = var_29_8
	pg = var_9

	for iter_29_0, iter_29_1 in var_29_8(var_9.secretary_special_ship.all) do
		pg = var_1_10012

		local var_29_10 = var_1_10012.secretary_special_ship[iter_29_1].prefab

		var_0_1(var_29_0, var_29_10)
	end

	table = var_7

	return var_7.concat(var_29_0, ";")
end

local var_0_6 = SpecialFilteForChange

local function var_0_7()
	local var_32_0 = {}

	local function var_32_1(arg_33_0)
		ipairs = var_2_10001

		for iter_33_0, iter_33_1 in var_2_10001(arg_33_0) do
			var_0_2(var_32_0, iter_33_1)
		end

		return
	end

	local function var_32_2(arg_34_0)
		ipairs = var_2_10001

		for iter_34_0, iter_34_1 in var_2_10001(arg_34_0) do
			var_0_4(var_32_0, iter_34_1)
		end

		return
	end

	pg = var_1_10003

	local var_32_3 = var_1_10003.painting_filte_config.skin_id_list

	var_32_2(var_32_3)

	table = var_4

	return var_4.concat(var_32_0, ";")
end

local var_0_8 = SpecialFilteForConst

local function var_0_9(arg_35_0)
	local var_35_0 = arg_35_0:ToTable()

	pg = var_1_10002

	local var_35_1 = var_1_10002.NewStoryMgr.GetInstance()

	return var_2.GetStoryPaintingsByNameList(var_35_1, var_35_0)
end

local var_0_10 = SpecialFilterForWorldStory

local function var_0_11()
	PaintingfilteConst = var_1_10000

	local var_36_0 = var_1_10000.GetActID2MemoryMap()

	PaintingfilteConst = var_1_10001

	local var_36_1 = var_1_10001.GetfilteTime()
	local var_36_2 = {}

	ipairs = var_1_10003
	pg = var_1_10005

	for iter_36_0, iter_36_1 in var_1_10003(var_1_10005.activity_template.all) do
		if var_36_0[iter_36_1] then
			PaintingfilteConst = var_8

			if var_8.IsActMatchTime(iter_36_1) then
				ipairs = var_8

				for iter_36_2, iter_36_3 in var_8(var_36_0[iter_36_1]) do
					table = var_1_10013

					var_1_10013.insert(var_36_2, iter_36_3)
				end
			end
		end
	end

	local var_36_3 = {}

	ipairs = var_4

	for iter_36_4, iter_36_5 in var_4(var_36_2) do
		pg = var_1_10009
		var_1_10009 = var_1_10009.memory_template[iter_36_5]
		ipairs = var_1_10010

		for iter_36_6, iter_36_7 in var_1_10010(var_1_10009.unlock_pre) do
			table = var_1_10015

			var_1_10015.insert(var_36_3, iter_36_7)
		end
	end

	pg = var_4

	local var_36_4 = var_4.NewStoryMgr.GetInstance()

	return var_4.GetStoryPaintingsByNameList(var_36_4, var_36_3)
end

local var_0_12 = SpecialFilteForActStory

local function var_0_13()
	local var_37_0 = {}

	ipairs = var_1_10001
	pg = var_1_10003

	for iter_37_0, iter_37_1 in var_1_10001(var_1_10003.activity_template.all) do
		pg = var_1_10006
		var_1_10006 = var_1_10006.activity_template[iter_37_1]
		PaintingfilteConst = var_1_10007

		if var_1_10007.IsActMatchTime(iter_37_1) and var_1_10006.config_client then
			type = var_8

			if var_8(var_1_10006.config_client) == "table" and var_1_10006.config_client.painting then
				type = var_8

				if var_8(var_1_10006.config_client.painting) == "string" then
					table = var_8

					var_8.insert(var_37_0, var_1_10006.config_client.painting)
				end

				type = var_8

				if var_8(var_1_10006.config_client.painting) == "table" then
					ipairs = var_8

					for iter_37_2, iter_37_3 in var_8(var_1_10006.config_client.painting) do
						table = var_1_10013

						var_1_10013.insert(var_37_0, iter_37_3)
					end
				end
			end
		end
	end

	table = var_1

	return var_1.concat(var_37_0, ";")
end

local var_0_14 = SpecialFilteForShopSkinPrefab
local var_0_15 = 1
local var_0_16 = PLATFORM_CH
local var_0_17 = 2
local var_0_18 = PLATFORM_JP
local var_0_19 = 3
local var_0_20 = PLATFORM_KR
local var_0_21 = 4
local var_0_22 = PLATFORM_US
local var_0_23 = 5
local var_0_24 = PLATFORM_CHT

local function var_0_25(arg_38_0)
	if arg_38_0 == "zh" then
		PLATFORM_CH = var_1_10001
		var_1_10001 = PLATFORM_CODE
	elseif arg_38_0 == "jp" then
		PLATFORM_JP = var_1_10001
		var_1_10001 = PLATFORM_CODE
	elseif arg_38_0 == "us" then
		PLATFORM_US = var_1_10001
		var_1_10001 = PLATFORM_CODE
	elseif arg_38_0 == "tw" then
		PLATFORM_CHT = var_1_10001
		var_1_10001 = PLATFORM_CODE
	elseif arg_38_0 == "kr" then
		PLATFORM_KR = var_1_10001

		local var_38_0 = PLATFORM_CODE
	else
		return false
	end

	return true
end

local var_0_26 = SetPlatform
local var_0_27 = true
local var_0_28 = UnGamePlayState

return
