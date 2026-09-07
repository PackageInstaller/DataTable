PaintingfilteConst = {}

local var_0_0 = PaintingfilteConst

function PaintingfilteConst:GetStandardTimeConfig()
	local var_1_0 = {}

	local function var_1_1(arg_2_0)
		for iter_2_0, iter_2_1 in ipairs(arg_2_0) do
			if type(iter_2_1) == "table" and #iter_2_1 == 2 then
				table.insert(var_1_0, iter_2_1)
			end
		end

		return
	end

	if #self == 2 and type(self[1][1]) == "string" and type(self[2][1]) == "string" then
		(function(arg_3_0)
			for iter_3_0, iter_3_1 in ipairs(arg_3_0) do
				if type(iter_3_1) == "table" and type(iter_3_1[1]) == "string" and type(iter_3_1[2]) == "table" then
					var_1_1(iter_3_1)
				end
			end

			return
		end)(self)
	else
		var_1_1(self)
	end

	return var_1_0
end

function PaintingfilteConst:IsTwoTimeCross(arg_4_1)
	local var_4_0 = pg.TimeMgr.GetInstance()

	if var_4_0:parseTimeFromConfig(self[2]) <= var_4_0:parseTimeFromConfig(arg_4_1[1]) or var_4_0:parseTimeFromConfig(arg_4_1[2]) <= var_4_0:parseTimeFromConfig(self[1]) then
		return false
	else
		return true
	end

	return
end

function PaintingfilteConst.IsActMatchTime(arg_5_0)
	if type(pg.activity_template[arg_5_0].time) == "string" and pg.activity_template[arg_5_0].time == "always" then
		return true
	elseif type(pg.activity_template[arg_5_0].time) == "table" and var_0_0.IsTwoTimeCross(var_0_0.GetfilteTime(), (var_0_0.GetStandardTimeConfig(pg.activity_template[arg_5_0].time))) then
		return true
	end

	return
end

function PaintingfilteConst.IsBuildActMatch(arg_6_0)
	if pg.activity_template[arg_6_0].type == 1 or pg.activity_template[arg_6_0].type == 85 then
		return (var_0_0.IsActMatchTime(arg_6_0))
	else
		return false
	end

	return
end

function PaintingfilteConst.IsNormalShopMatch(arg_7_0)
	if pg.shop_template[arg_7_0].genre == "skin_shop" then
		if type(pg.shop_template[arg_7_0].time) == "string" and pg.shop_template[arg_7_0].time == "always" then
			return true
		elseif type(pg.shop_template[arg_7_0].time) == "table" and var_0_0.IsTwoTimeCross(var_0_0.GetfilteTime(), (var_0_0.GetStandardTimeConfig(pg.shop_template[arg_7_0].time))) then
			return true
		end
	end

	return false
end

function PaintingfilteConst.IsActShopMatch(arg_8_0)
	if pg.activity_shop_extra[arg_8_0].commodity_type == DROP_TYPE_SKIN then
		if type(pg.activity_shop_extra[arg_8_0].time) == "string" and pg.activity_shop_extra[arg_8_0].time == "always" then
			return true
		elseif type(pg.activity_shop_extra[arg_8_0].time) == "table" and var_0_0.IsTwoTimeCross(var_0_0.GetfilteTime(), (var_0_0.GetStandardTimeConfig(pg.activity_shop_extra[arg_8_0].time))) then
			return true
		end
	end

	return false
end

function PaintingfilteConst.GetfilteTime()
	return pg.painting_filte_config.time
end

function PaintingfilteConst.GetConstPoolIndexList()
	return pg.painting_filte_config.pool_id_list
end

function PaintingfilteConst:IsPoolWeightConfigMatch(arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		if self[iter_11_1] > 0 then
			return true
		end
	end

	return false
end

function PaintingfilteConst.GetBuildActIDList()
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(pg.activity_template.all) do
		if var_0_0.IsBuildActMatch(iter_12_1) then
			table.insert(var_12_0, iter_12_1)
		end
	end

	return var_12_0
end

function PaintingfilteConst.GetActPoolIndexList()
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs((var_0_0.GetBuildActIDList())) do
		if not table.contains(var_13_0, pg.activity_template[iter_13_1].config_id) then
			table.insert(var_13_0, pg.activity_template[iter_13_1].config_id)
		end
	end

	return var_13_0
end

function PaintingfilteConst.GetShipConfigIDListByPoolList(arg_14_0)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in pairs(pg.ship_data_create) do
		if var_0_0.IsPoolWeightConfigMatch(iter_14_1.weight_group, arg_14_0) and not table.contains(var_14_0, iter_14_0) then
			table.insert(var_14_0, iter_14_0)
		end
	end

	return var_14_0
end

function PaintingfilteConst.GetLightPoolBlueDestroyerShipConfigIDList(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0 = arg_15_0 or 2
	arg_15_1 = arg_15_1 or 3
	arg_15_2 = arg_15_2 or 1

	local var_15_0 = {}

	if type(arg_15_0) ~= "number" or type(arg_15_1) ~= "number" or type(arg_15_2) ~= "number" or type(pg.ship_data_create) ~= "table" or type(pg.ship_data_statistics) ~= "table" then
		return var_15_0
	end

	for iter_15_0, iter_15_1 in pairs(pg.ship_data_create) do
		if type(iter_15_0) == "number" and type(iter_15_1) == "table" then
			if type(iter_15_1[arg_15_0]) == "number" and iter_15_1[arg_15_0] > 0 and type(pg.ship_data_statistics[iter_15_0]) == "table" and pg.ship_data_statistics[iter_15_0].rarity == arg_15_1 and pg.ship_data_statistics[iter_15_0].type == arg_15_2 then
				table.insert(var_15_0, iter_15_0)
			end
		end
	end

	return var_15_0
end

function PaintingfilteConst.GetActID2MemoryMap()
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in ipairs(pg.memory_group.all) do
		if pg.memory_group[iter_16_1].link_event and pg.memory_group[iter_16_1].link_event > 0 then
			var_16_0[pg.memory_group[iter_16_1].link_event] = var_16_0[pg.memory_group[iter_16_1].link_event] or {}

			for iter_16_2, iter_16_3 in ipairs(pg.memory_group[iter_16_1].memories) do
				if not table.contains(var_16_0[pg.memory_group[iter_16_1].link_event], iter_16_3) then
					table.insert(var_16_0[pg.memory_group[iter_16_1].link_event], iter_16_3)
				end
			end
		end
	end

	return var_16_0
end

function PaintingfilteConst.GetActPoolShipConfigIDList()
	return var_0_0.GetShipConfigIDListByPoolList((var_0_0.GetActPoolIndexList()))
end

function PaintingfilteConst.GetConstPoolShipConfigIDList()
	return var_0_0.GetShipConfigIDListByPoolList((var_0_0.GetConstPoolIndexList()))
end

function PaintingfilteConst.GetCreateExchangeShipConfigIDList()
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in ipairs({
		10,
		11
	}) do
		for iter_19_2, iter_19_3 in ipairs((var_0_0.GetBuildActIDList())) do
			if pg.ship_data_create_exchange[iter_19_3] then
				for iter_19_4, iter_19_5 in ipairs(pg.ship_data_create_exchange[iter_19_3].exchange_ship_id) do
					if not table.contains(var_19_0, iter_19_5) then
						table.insert(var_19_0, iter_19_5)
					end
				end
			end
		end
	end

	return var_19_0
end

function PaintingfilteConst.GetNPCShipConfigIDList()
	local var_20_0 = {}

	for iter_20_0, iter_20_1 in ipairs(getGameset("act_npc_ship_id")[2]) do
		if var_0_0.IsActMatchTime(iter_20_1) then
			table.insert(var_20_0, pg.task_data_template[pg.activity_template[iter_20_1].config_data[1]].award_display[1][2])
		end
	end

	return var_20_0
end

function PaintingfilteConst.GetSkinIDFromNormalShopID(arg_21_0)
	local var_21_0 = pg.shop_template[arg_21_0].effect_args

	assert(#pg.shop_template[arg_21_0].effect_args == 1, "shop_template的effect_args字段,元素个数大于1,ID:", arg_21_0)

	return var_21_0[1]
end

function PaintingfilteConst.GetNormalShopSkinIDList()
	local var_22_0 = {}

	for iter_22_0, iter_22_1 in ipairs(pg.shop_template.get_id_list_by_genre[ShopArgs.SkinShop]) do
		if var_0_0.IsNormalShopMatch(iter_22_1) then
			local var_22_1 = var_0_0.GetSkinIDFromNormalShopID(iter_22_1)

			if not table.contains(var_22_0, var_22_1) then
				table.insert(var_22_0, var_22_1)
			end

			if ShipSkin.IsChangeSkin(var_22_1) then
				for iter_22_2, iter_22_3 in ipairs((ShipSkin.GetAllChangeSkinIds(var_22_1))) do
					if not table.contains(var_22_0, iter_22_3) then
						table.insert(var_22_0, iter_22_3)
					end
				end
			end
		end
	end

	warning("普通商店皮肤个数" .. #var_22_0)

	return var_22_0
end

function PaintingfilteConst.GetSkinIDFromActShopID(arg_23_0)
	return pg.activity_shop_extra[arg_23_0].commodity_id
end

function PaintingfilteConst.GetActShopSkinIDList()
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in ipairs(pg.activity_shop_extra.get_id_list_by_commodity_type[DROP_TYPE_SKIN]) do
		if var_0_0.IsActShopMatch(iter_24_1) then
			local var_24_1 = var_0_0.GetSkinIDFromActShopID(iter_24_1)

			if not table.contains(var_24_0, var_24_1) then
				table.insert(var_24_0, var_24_1)
			end

			if ShipSkin.IsChangeSkin(var_24_1) then
				for iter_24_2, iter_24_3 in ipairs((ShipSkin.GetAllChangeSkinIds(var_24_1))) do
					if not table.contains(var_24_0, iter_24_3) then
						table.insert(var_24_0, iter_24_3)
					end
				end
			end
		end
	end

	warning("活动商店皮肤个数" .. #var_24_0)

	return var_24_0
end

local function var_0_1(arg_25_0, arg_25_1)
	arg_25_1 = string.lower(arg_25_1)

	for iter_25_0, iter_25_1 in ipairs(pg.painting_filte_map[arg_25_1].res_list) do
		if not table.contains(arg_25_0, iter_25_1) then
			table.insert(arg_25_0, iter_25_1)
		end
	end

	return
end

local function var_0_2(arg_26_0, arg_26_1)
	var_0_1(arg_26_0, ShipGroup.getDefaultSkin(arg_26_1).painting)

	return
end

local function var_0_3(arg_27_0, arg_27_1)
	var_0_2(arg_27_0, (Ship.getGroupId({
		configId = arg_27_1
	})))

	return
end

local function var_0_4(arg_28_0, arg_28_1)
	var_0_1(arg_28_0, pg.ship_skin_template[arg_28_1].painting)

	return
end

function SpecialFilteForChange()
	local var_29_0 = {}

	local function var_29_1(arg_30_0)
		for iter_30_0, iter_30_1 in ipairs(arg_30_0) do
			var_0_3(var_29_0, iter_30_1)
		end

		return
	end

	local function var_29_2(arg_31_0)
		for iter_31_0, iter_31_1 in ipairs(arg_31_0) do
			var_0_4(var_29_0, iter_31_1)
		end

		return
	end

	if pg.painting_filte_config.current_act_pool == 1 then
		var_29_1((PaintingfilteConst.GetActPoolShipConfigIDList()))
	end

	var_29_1((PaintingfilteConst.GetConstPoolShipConfigIDList()))
	var_29_1((PaintingfilteConst.GetLightPoolBlueDestroyerShipConfigIDList()))
	var_29_1((PaintingfilteConst.GetNPCShipConfigIDList()))
	var_29_1((PaintingfilteConst.GetCreateExchangeShipConfigIDList()))

	if pg.painting_filte_config.current_sale_skin == 1 then
		local var_29_3 = PaintingfilteConst.GetNormalShopSkinIDList()

		warning("normalShopSkinIDList:" .. #var_29_3)
		var_29_2(var_29_3)

		local var_29_4 = PaintingfilteConst.GetActShopSkinIDList()

		warning("actShopSkinIDList:" .. #var_29_4)
		var_29_2(var_29_4)
	end

	for iter_29_0, iter_29_1 in ipairs(pg.secretary_special_ship.all) do
		var_0_1(var_29_0, pg.secretary_special_ship[iter_29_1].prefab)
	end

	return table.concat(var_29_0, ";")
end

function SpecialFilteForConst()
	local var_32_0 = {}

	;(function(arg_34_0)
		for iter_34_0, iter_34_1 in ipairs(arg_34_0) do
			var_0_4(var_32_0, iter_34_1)
		end

		return
	end)(pg.painting_filte_config.skin_id_list)

	return table.concat(var_32_0, ";")
end

function SpecialFilterForWorldStory(arg_35_0)
	return pg.NewStoryMgr.GetInstance():GetStoryPaintingsByNameList((arg_35_0:ToTable()))
end

function SpecialFilteForActStory()
	local var_36_0 = PaintingfilteConst.GetActID2MemoryMap()
	local var_36_1 = PaintingfilteConst.GetfilteTime()
	local var_36_2 = {}

	for iter_36_0, iter_36_1 in ipairs(pg.activity_template.all) do
		if var_36_0[iter_36_1] and PaintingfilteConst.IsActMatchTime(iter_36_1) then
			for iter_36_2, iter_36_3 in ipairs(var_36_0[iter_36_1]) do
				table.insert(var_36_2, iter_36_3)
			end
		end
	end

	local var_36_3 = {}

	for iter_36_4, iter_36_5 in ipairs(var_36_2) do
		for iter_36_6, iter_36_7 in ipairs(pg.memory_template[iter_36_5].unlock_pre) do
			table.insert(var_36_3, iter_36_7)
		end
	end

	return pg.NewStoryMgr.GetInstance():GetStoryPaintingsByNameList(var_36_3)
end

function SpecialFilteForShopSkinPrefab()
	local var_37_0 = {}

	for iter_37_0, iter_37_1 in ipairs(pg.activity_template.all) do
		if PaintingfilteConst.IsActMatchTime(iter_37_1) and pg.activity_template[iter_37_1].config_client and type(pg.activity_template[iter_37_1].config_client) == "table" and pg.activity_template[iter_37_1].config_client.painting then
			if type(pg.activity_template[iter_37_1].config_client.painting) == "string" then
				table.insert(var_37_0, pg.activity_template[iter_37_1].config_client.painting)
			end

			if type(pg.activity_template[iter_37_1].config_client.painting) == "table" then
				for iter_37_2, iter_37_3 in ipairs(pg.activity_template[iter_37_1].config_client.painting) do
					table.insert(var_37_0, iter_37_3)
				end
			end
		end
	end

	return table.concat(var_37_0, ";")
end

PLATFORM_CH = 1
PLATFORM_JP = 2
PLATFORM_KR = 3
PLATFORM_US = 4
PLATFORM_CHT = 5

function SetPlatform(arg_38_0)
	if arg_38_0 == "zh" then
		PLATFORM_CODE = PLATFORM_CH
	elseif arg_38_0 == "jp" then
		PLATFORM_CODE = PLATFORM_JP
	elseif arg_38_0 == "us" then
		PLATFORM_CODE = PLATFORM_US
	elseif arg_38_0 == "tw" then
		PLATFORM_CODE = PLATFORM_CHT
	elseif arg_38_0 == "kr" then
		PLATFORM_CODE = PLATFORM_KR
	else
		return false
	end

	return true
end

UnGamePlayState = true

return
