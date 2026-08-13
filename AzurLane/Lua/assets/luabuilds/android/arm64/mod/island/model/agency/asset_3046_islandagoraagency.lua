class = var_0_10000

local var_0_0 = "IslandAgoraAgency"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandBaseAgency"))

var_0_1.ADD_FURNITURE = "IslandAgoraAgency:ADD_FURNITURE"
var_0_1.AGORA_UPGRADE = "IslandAgoraAgency:AGORA_UPGRADE"
var_0_1.ADD_THEME = "IslandAgoraAgency:ADD_THEME"
var_0_1.DEL_THEME = "IslandAgoraAgency:DEL_THEME"
var_0_1.PLACEMENT_UPDATE = "IslandAgoraAgency:PLACEMENT_UPDATE"

function var_0_1.OnInit(arg_1_0, arg_1_1)
	local var_1_0

	if not arg_1_1.agora_level then
		var_1_0 = 1
	end

	arg_1_0.level = var_1_0
	table = var_1_0

	local var_1_1 = var_1_0.getCount

	IslandConst = var_1_10004
	arg_1_0.maxLevel = var_1_1(var_1_10004.AGORA_LEVEL_2_SIZE)
	arg_1_0.furnitures = {}
	arg_1_0.themes = {}
	arg_1_0.systemThemes = {}
	arg_1_0.isUpdateThemes = false
	ipairs = var_2
	pg = var_4

	for iter_1_0, iter_1_1 in var_2(var_4.island_furniture_theme.all) do
		pg = var_1_10007
		var_1_10007 = var_1_10007.island_furniture_theme[iter_1_1]
		pcall = var_1_10008

		local var_1_2

		var_1_10008, var_1_2 = var_1_10008(function()
			require = var_2_10000

			return var_2_10000("Mod.Island.Agora.theme.theme_" .. iter_1_1)
		end)

		if not var_1_10008 then
			var_1_2 = {
				id = iter_1_1,
				placed_data = {}
			}
		end

		IslandTheme = var_10

		local var_1_3 = var_10.New(var_1_2)

		var_10.SetName(var_1_3, var_1_10007.name)

		table = var_11

		var_11.insert(arg_1_0.systemThemes, var_10)
	end

	IslandTheme = var_2
	arg_1_0.placedData = var_2.New(arg_1_1)

	local var_1_4 = {}

	pg = var_3
	var_1_4[1] = var_3.island_set.island_build_capacity.key_value_int
	arg_1_0.capacityList = var_1_4
	arg_1_0.consumeList = {}
	ipairs = var_2
	pg = var_4

	for iter_1_2, iter_1_3 in var_2(var_4.island_set.island_build_expansion.key_value_varchar) do
		table = var_1_10007

		var_1_10007.insert(arg_1_0.capacityList, iter_1_3[3])

		table = var_1_10007

		var_1_10007.insert(arg_1_0.consumeList, iter_1_3[2])
	end

	return
end

function var_0_1.InitPrivateData(arg_3_0, arg_3_1)
	local var_3_0 = {}

	ipairs = var_1_10003

	for iter_3_0, iter_3_1 in var_1_10003(arg_3_1.furniture_list) do
		table = var_1_10008
		var_1_10008 = var_1_10008.insert

		local var_3_1 = var_3_0

		IslandFurniture = var_1_10011

		var_1_10008(var_3_1, var_1_10011.New(iter_3_1))
	end

	pg = var_3

	local var_3_3

	if var_3.island_set.island_pre_placement.key_value_varchar[1] then
		local var_3_2 = var_3[1][1]

		_ = var_3_3

		if var_3_3.all(var_3_0, function(arg_4_0)
			return arg_4_0.id ~= var_3_2
		end) then
			table = var_3_3
			var_3_3 = var_3_3.insert

			local var_3_4 = var_3_0

			IslandFurniture = var_8

			var_3_3(var_3_4, var_8.New({
				count = 1,
				id = var_3_2
			}))
		end
	end

	if var_3[2] then
		local var_3_5 = var_3[2][1]

		_ = var_3_3

		if var_3_3.all(var_3_0, function(arg_5_0)
			return arg_5_0.id ~= var_3_5
		end) then
			table = var_5

			local var_3_6 = var_5.insert
			local var_3_7 = var_3_0

			IslandFurniture = var_8

			var_3_6(var_3_7, var_8.New({
				count = 1,
				id = var_3_5
			}))
		end
	end

	arg_3_0.furnitures = var_3_0

	return
end

function var_0_1.RawAddFurniture(arg_6_0, arg_6_1, arg_6_2)
	assert = var_1_10003
	isa = var_1_10005

	local var_6_0 = arg_6_1

	IslandFurniture = var_1_10008

	var_1_10003(var_1_10005(var_6_0, var_1_10008), "IslandAgoraAgency:AddFurniture: furniture must be IslandFurniture")

	_ = var_1_10003

	if var_1_10003.detect(arg_6_0.furnitures, function(arg_7_0)
		return arg_7_0.id == arg_6_1.id
	end) then
		var_3.count = var_3.count + 1
	else
		table = var_1_10004

		var_1_10004.insert(arg_6_0.furnitures, arg_6_1)
	end

	return
end

function var_0_1.AddFurniture(arg_8_0, arg_8_1, arg_8_2)
	assert = var_1_10003
	isa = var_1_10005

	local var_8_0 = arg_8_1

	IslandFurniture = var_1_10008

	var_1_10003(var_1_10005(var_8_0, var_1_10008), "IslandAgoraAgency:AddFurniture: furniture must be IslandFurniture")

	_ = var_1_10003

	if not var_1_10003.detect(arg_8_0.furnitures, function(arg_9_0)
		return arg_9_0.id == arg_8_1.id
	end) then
		arg_8_1:SetNew(true)
	end

	pg = var_1_10004

	local var_8_1 = var_1_10004.GameTrackerMgr.GetInstance()
	local var_8_2 = var_4.Record

	GameTrackerBuilder = var_8_0

	var_8_2(var_8_1, var_8_0.BuildIslandFurnitureAdd(arg_8_1.id, arg_8_2 or ""))

	if var_3 then
		var_8_2 = var_3.count

		local var_8_3

		if not arg_8_1.count then
			var_8_3 = 1
		end

		var_3.count = var_8_2 + var_8_3
		var_8_1 = arg_8_0

		arg_8_0.DispatchEvent(var_8_1, var_0_1.ADD_FURNITURE, var_3)
	else
		IslandAchievementHelper = var_8_2

		local var_8_4 = var_8_2.UpdateRecordWithAdd

		IslandAchievementType = var_8_1

		var_8_4(var_8_1.FURNITURE, 0, 1)

		pg = var_8_4

		local var_8_5 = var_8_4.island_furniture_template[arg_8_1.id].type

		IslandAchievementHelper = var_5

		local var_8_6 = var_5.UpdateRecordWithAdd

		IslandAchievementType = var_7

		var_8_6(var_7.FURNITURE, var_8_5, 1)

		table = var_8_6

		var_8_6.insert(arg_8_0.furnitures, arg_8_1)
		arg_8_0:DispatchEvent(var_0_1.ADD_FURNITURE, arg_8_1)
	end

	return
end

function var_0_1.ClearNew(arg_10_0, arg_10_1)
	ipairs = var_1_10002

	for iter_10_0, iter_10_1 in var_1_10002(arg_10_0.furnitures) do
		if iter_10_1.configId == arg_10_1 then
			iter_10_1:SetNew(false)
		end
	end

	return
end

function var_0_1.ClearAllNew(arg_11_0)
	ipairs = var_1_10001

	for iter_11_0, iter_11_1 in var_1_10001(arg_11_0.furnitures) do
		iter_11_1:SetNew(false)
	end

	return
end

function var_0_1.GetSystemThemes(arg_12_0)
	return arg_12_0.systemThemes
end

function var_0_1.AddTheme(arg_13_0, arg_13_1)
	table = var_1_10002

	var_1_10002.insert(arg_13_0.themes, arg_13_1)
	arg_13_0:DispatchEvent(var_0_1.ADD_THEME, arg_13_1)

	return
end

function var_0_1.DelTheme(arg_14_0, arg_14_1)
	_ = var_1_10002

	if var_1_10002.detect(arg_14_0.themes, function(arg_15_0)
		return arg_15_0.id == arg_14_1
	end) then
		table = var_1_10003

		var_1_10003.removebyvalue(arg_14_0.themes, var_2)
		arg_14_0:DispatchEvent(var_0_1.DEL_THEME, arg_14_1)
	end

	return
end

function var_0_1.GetThemes(arg_16_0)
	return arg_16_0.themes
end

function var_0_1.SetThemes(arg_17_0, arg_17_1)
	arg_17_0.themes = arg_17_1
	ipairs = var_1_10002

	for iter_17_0, iter_17_1 in var_1_10002(arg_17_0.themes) do
		arg_17_0:DispatchEvent(var_0_1.ADD_THEME, iter_17_1)
	end

	arg_17_0.isUpdateThemes = true

	return
end

function var_0_1.IsUpdateThemes(arg_18_0)
	return arg_18_0.isUpdateThemes
end

function var_0_1.GetFurnitures(arg_19_0)
	return arg_19_0.furnitures
end

function var_0_1.GetFurnituresByType(arg_20_0, arg_20_1)
	underscore = var_1_10002

	return var_1_10002.select(arg_20_0.furnitures, function(arg_21_0)
		pg = var_2_10001

		return var_2_10001.island_furniture_template[arg_21_0.id].type == arg_20_1
	end)
end

function var_0_1.GetPlacedData(arg_22_0)
	return arg_22_0.placedData
end

function var_0_1.GetCapacity(arg_23_0)
	local var_23_0

	if not arg_23_0.capacityList[arg_23_0.level] then
		var_23_0 = 0
	end

	return var_23_0
end

function var_0_1.GetNextCapacity(arg_24_0)
	if not arg_24_0:CanUpgrade() then
		return arg_24_0:GetCapacity()
	end

	local var_24_0

	if not arg_24_0.capacityList[arg_24_0.level + 1] then
		var_24_0 = 0
	end

	return var_24_0
end

function var_0_1.GetLevel(arg_25_0)
	return arg_25_0.level
end

function var_0_1.CanUpgrade(arg_26_0)
	return arg_26_0.level < arg_26_0.maxLevel
end

function var_0_1.GetUpgradeConsume(arg_27_0)
	if not arg_27_0:CanUpgrade() then
		return nil
	end

	local var_27_0

	if not arg_27_0.consumeList[arg_27_0.level] then
		var_27_0 = {}
	end

	Drop = var_2

	return var_2.New({
		type = var_27_0[1],
		id = var_27_0[2],
		count = var_27_0[3]
	})
end

function var_0_1.Upgrade(arg_28_0)
	arg_28_0.level = arg_28_0.level + 1

	local var_28_0 = arg_28_0:GetCapacity()

	arg_28_0:DispatchEvent(var_0_1.AGORA_UPGRADE, arg_28_0.level, var_28_0)

	return
end

function var_0_1.UpdatePlacedData(arg_29_0, arg_29_1, arg_29_2)
	IslandTheme = var_1_10003
	arg_29_0.placedData = var_1_10003.New({
		placed_data = arg_29_1
	})

	if not arg_29_2 then
		arg_29_0:DispatchEvent(var_0_1.PLACEMENT_UPDATE, arg_29_0.placedData)
	end

	return
end

return var_0_1
