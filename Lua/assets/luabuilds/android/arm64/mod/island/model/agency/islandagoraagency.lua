local var_0_0 = class("IslandAgoraAgency", import(".IslandBaseAgency"))

var_0_0.ADD_FURNITURE = "IslandAgoraAgency:ADD_FURNITURE"
var_0_0.AGORA_UPGRADE = "IslandAgoraAgency:AGORA_UPGRADE"
var_0_0.ADD_THEME = "IslandAgoraAgency:ADD_THEME"
var_0_0.DEL_THEME = "IslandAgoraAgency:DEL_THEME"
var_0_0.PLACEMENT_UPDATE = "IslandAgoraAgency:PLACEMENT_UPDATE"

function var_0_0.OnInit(arg_1_0, arg_1_1)
	arg_1_0.level = arg_1_1.agora_level or 1
	arg_1_0.maxLevel = table.getCount(IslandConst.AGORA_LEVEL_2_SIZE)
	arg_1_0.furnitures = {}
	arg_1_0.themes = {}
	arg_1_0.systemThemes = {}
	arg_1_0.isUpdateThemes = false

	for iter_1_0, iter_1_1 in ipairs(pg.island_furniture_theme.all) do
		local var_1_0, var_1_1 = pcall(function()
			return require("Mod.Island.Agora.theme.theme_" .. iter_1_1)
		end)

		if not var_1_0 then
			var_1_1 = {
				id = iter_1_1,
				placed_data = {}
			}
		end

		local var_1_2 = IslandTheme.New(var_1_1)

		var_1_2:SetName(pg.island_furniture_theme[iter_1_1].name)
		table.insert(arg_1_0.systemThemes, var_1_2)
	end

	arg_1_0.placedData = IslandTheme.New(arg_1_1)
	arg_1_0.capacityList = {
		pg.island_set.island_build_capacity.key_value_int
	}
	arg_1_0.consumeList = {}

	for iter_1_2, iter_1_3 in ipairs(pg.island_set.island_build_expansion.key_value_varchar) do
		table.insert(arg_1_0.capacityList, iter_1_3[3])
		table.insert(arg_1_0.consumeList, iter_1_3[2])
	end

	return
end

function var_0_0.InitPrivateData(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1.furniture_list) do
		table.insert({}, IslandFurniture.New(iter_3_1))
	end

	if pg.island_set.island_pre_placement.key_value_varchar[1] then
		local var_3_0 = pg.island_set.island_pre_placement.key_value_varchar[1][1]

		if _.all({}, function(arg_4_0)
			return arg_4_0.id ~= var_3_0
		end) then
			table.insert({}, IslandFurniture.New({
				count = 1,
				id = pg.island_set.island_pre_placement.key_value_varchar[1][1]
			}))
		end
	end

	if pg.island_set.island_pre_placement.key_value_varchar[2] then
		local var_3_1 = pg.island_set.island_pre_placement.key_value_varchar[2][1]

		if _.all({}, function(arg_5_0)
			return arg_5_0.id ~= var_3_1
		end) then
			table.insert({}, IslandFurniture.New({
				count = 1,
				id = pg.island_set.island_pre_placement.key_value_varchar[2][1]
			}))
		end
	end

	arg_3_0.furnitures = {}

	return
end

function var_0_0.RawAddFurniture(arg_6_0, arg_6_1, arg_6_2)
	assert(isa(arg_6_1, IslandFurniture), "IslandAgoraAgency:AddFurniture: furniture must be IslandFurniture")

	local var_6_0 = _.detect(arg_6_0.furnitures, function(arg_7_0)
		return arg_7_0.id == arg_6_1.id
	end)

	if var_6_0 then
		var_6_0.count = var_6_0.count + 1
	else
		table.insert(arg_6_0.furnitures, arg_6_1)
	end

	return
end

function var_0_0.AddFurniture(arg_8_0, arg_8_1, arg_8_2)
	assert(isa(arg_8_1, IslandFurniture), "IslandAgoraAgency:AddFurniture: furniture must be IslandFurniture")

	local var_8_0 = _.detect(arg_8_0.furnitures, function(arg_9_0)
		return arg_9_0.id == arg_8_1.id
	end)

	if not var_8_0 then
		arg_8_1:SetNew(true)
	end

	pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandFurnitureAdd(arg_8_1.id, arg_8_2 or ""))

	if var_8_0 then
		local var_8_1 = arg_8_1.count or 1

		var_8_0.count = var_8_0.count + var_8_1

		arg_8_0:DispatchEvent(var_0_0.ADD_FURNITURE, var_8_0)
	else
		IslandAchievementHelper.UpdateRecordWithAdd(IslandAchievementType.FURNITURE, 0, 1)
		IslandAchievementHelper.UpdateRecordWithAdd(IslandAchievementType.FURNITURE, pg.island_furniture_template[arg_8_1.id].type, 1)
		table.insert(arg_8_0.furnitures, arg_8_1)
		arg_8_0:DispatchEvent(var_0_0.ADD_FURNITURE, arg_8_1)
	end

	return
end

function var_0_0.ClearNew(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.furnitures) do
		if iter_10_1.configId == arg_10_1 then
			iter_10_1:SetNew(false)
		end
	end

	return
end

function var_0_0.ClearAllNew(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0.furnitures) do
		iter_11_1:SetNew(false)
	end

	return
end

function var_0_0.GetSystemThemes(arg_12_0)
	return arg_12_0.systemThemes
end

function var_0_0.AddTheme(arg_13_0, arg_13_1)
	table.insert(arg_13_0.themes, arg_13_1)
	arg_13_0:DispatchEvent(var_0_0.ADD_THEME, arg_13_1)

	return
end

function var_0_0.DelTheme(arg_14_0, arg_14_1)
	local var_14_0 = _.detect(arg_14_0.themes, function(arg_15_0)
		return arg_15_0.id == arg_14_1
	end)

	if var_14_0 then
		table.removebyvalue(arg_14_0.themes, var_14_0)
		arg_14_0:DispatchEvent(var_0_0.DEL_THEME, arg_14_1)
	end

	return
end

function var_0_0.GetThemes(arg_16_0)
	return arg_16_0.themes
end

function var_0_0.SetThemes(arg_17_0, arg_17_1)
	arg_17_0.themes = arg_17_1

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.themes) do
		arg_17_0:DispatchEvent(var_0_0.ADD_THEME, iter_17_1)
	end

	arg_17_0.isUpdateThemes = true

	return
end

function var_0_0.IsUpdateThemes(arg_18_0)
	return arg_18_0.isUpdateThemes
end

function var_0_0.GetFurnitures(arg_19_0)
	return arg_19_0.furnitures
end

function var_0_0.GetFurnituresByType(arg_20_0, arg_20_1)
	return underscore.select(arg_20_0.furnitures, function(arg_21_0)
		return pg.island_furniture_template[arg_21_0.id].type == arg_20_1
	end)
end

function var_0_0.GetPlacedData(arg_22_0)
	return arg_22_0.placedData
end

function var_0_0.GetCapacity(arg_23_0)
	return arg_23_0.capacityList[arg_23_0.level] or 0
end

function var_0_0.GetNextCapacity(arg_24_0)
	if not arg_24_0:CanUpgrade() then
		return arg_24_0:GetCapacity()
	end

	return arg_24_0.capacityList[arg_24_0.level + 1] or 0
end

function var_0_0.GetLevel(arg_25_0)
	return arg_25_0.level
end

function var_0_0.CanUpgrade(arg_26_0)
	return arg_26_0.level < arg_26_0.maxLevel
end

function var_0_0.GetUpgradeConsume(arg_27_0)
	if not arg_27_0:CanUpgrade() then
		return nil
	end

	local var_27_0 = arg_27_0.consumeList[arg_27_0.level] or {}

	return Drop.New({
		type = var_27_0[1],
		id = var_27_0[2],
		count = var_27_0[3]
	})
end

function var_0_0.Upgrade(arg_28_0)
	arg_28_0.level = arg_28_0.level + 1

	arg_28_0:DispatchEvent(var_0_0.AGORA_UPGRADE, arg_28_0.level, (arg_28_0:GetCapacity()))

	return
end

function var_0_0.UpdatePlacedData(arg_29_0, arg_29_1, arg_29_2)
	arg_29_0.placedData = IslandTheme.New({
		placed_data = arg_29_1
	})

	if not arg_29_2 then
		arg_29_0:DispatchEvent(var_0_0.PLACEMENT_UPDATE, arg_29_0.placedData)
	end

	return
end

return var_0_0
