local IslandAgoraAgency = class("IslandAgoraAgency", import(".IslandBaseAgency"))

IslandAgoraAgency.ADD_FURNITURE = "IslandAgoraAgency:ADD_FURNITURE"
IslandAgoraAgency.AGORA_UPGRADE = "IslandAgoraAgency:AGORA_UPGRADE"
IslandAgoraAgency.ADD_THEME = "IslandAgoraAgency:ADD_THEME"
IslandAgoraAgency.DEL_THEME = "IslandAgoraAgency:DEL_THEME"
IslandAgoraAgency.PLACEMENT_UPDATE = "IslandAgoraAgency:PLACEMENT_UPDATE"

function IslandAgoraAgency:OnInit(arg_1_1)
	self.level = arg_1_1.agora_level or 1
	self.maxLevel = table.getCount(IslandConst.AGORA_LEVEL_2_SIZE)
	self.furnitures = {}
	self.themes = {}
	self.systemThemes = {}
	self.isUpdateThemes = false

	for iter_1_0, iter_1_1 in ipairs(pg.island_furniture_theme.all) do
		local var_1_0, var_1_1 = pcall(function()
			return require("Mod.Island.Agora.theme.theme_" .. iter_1_1)
		end)
		local var_1_2 = IslandTheme.New((not var_1_0 or nil) and {
			id = iter_1_1,
			placed_data = {}
		})

		var_1_2:SetName(pg.island_furniture_theme[iter_1_1].name)
		table.insert(self.systemThemes, var_1_2)
	end

	self.placedData = IslandTheme.New(arg_1_1)
	self.capacityList = {
		pg.island_set.island_build_capacity.key_value_int
	}
	self.consumeList = {}

	for iter_1_2, iter_1_3 in ipairs(pg.island_set.island_build_expansion.key_value_varchar) do
		table.insert(self.capacityList, iter_1_3[3])
		table.insert(self.consumeList, iter_1_3[2])
	end

	return
end

function IslandAgoraAgency:InitPrivateData(arg_3_1)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.furniture_list) do
		table.insert(var_3_0, IslandFurniture.New(iter_3_1))
	end

	if pg.island_set.island_pre_placement.key_value_varchar[1] then
		local var_3_1 = pg.island_set.island_pre_placement.key_value_varchar[1][1]

		if _.all(var_3_0, function(arg_4_0)
			return arg_4_0.id ~= var_3_1
		end) then
			table.insert(var_3_0, IslandFurniture.New({
				count = 1,
				id = pg.island_set.island_pre_placement.key_value_varchar[1][1]
			}))
		end
	end

	if pg.island_set.island_pre_placement.key_value_varchar[2] then
		local var_3_2 = pg.island_set.island_pre_placement.key_value_varchar[2][1]

		if _.all(var_3_0, function(arg_5_0)
			return arg_5_0.id ~= var_3_2
		end) then
			table.insert(var_3_0, IslandFurniture.New({
				count = 1,
				id = pg.island_set.island_pre_placement.key_value_varchar[2][1]
			}))
		end
	end

	self.furnitures = var_3_0

	return
end

function IslandAgoraAgency:RawAddFurniture(arg_6_1, arg_6_2)
	assert(isa(arg_6_1, IslandFurniture), "IslandAgoraAgency:AddFurniture: furniture must be IslandFurniture")

	local var_6_0 = _.detect(self.furnitures, function(arg_7_0)
		return arg_7_0.id == arg_6_1.id
	end)

	if var_6_0 then
		var_6_0.count = var_6_0.count + 1
	else
		table.insert(self.furnitures, arg_6_1)
	end

	return
end

function IslandAgoraAgency:AddFurniture(arg_8_1, arg_8_2)
	assert(isa(arg_8_1, IslandFurniture), "IslandAgoraAgency:AddFurniture: furniture must be IslandFurniture")

	local var_8_0 = _.detect(self.furnitures, function(arg_9_0)
		return arg_9_0.id == arg_8_1.id
	end)

	if not var_8_0 then
		arg_8_1:SetNew(true)
	end

	pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandFurnitureAdd(arg_8_1.id, arg_8_2 or ""))

	if var_8_0 then
		var_8_0.count = var_8_0.count + (arg_8_1.count or 1)

		self:DispatchEvent(IslandAgoraAgency.ADD_FURNITURE, var_8_0)
	else
		IslandAchievementHelper.UpdateRecordWithAdd(IslandAchievementType.FURNITURE, 0, 1)
		IslandAchievementHelper.UpdateRecordWithAdd(IslandAchievementType.FURNITURE, pg.island_furniture_template[arg_8_1.id].type, 1)
		table.insert(self.furnitures, arg_8_1)
		self:DispatchEvent(IslandAgoraAgency.ADD_FURNITURE, arg_8_1)
	end

	return
end

function IslandAgoraAgency:ClearNew(arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(self.furnitures) do
		if iter_10_1.configId == arg_10_1 then
			iter_10_1:SetNew(false)
		end
	end

	return
end

function IslandAgoraAgency:ClearAllNew()
	for iter_11_0, iter_11_1 in ipairs(self.furnitures) do
		iter_11_1:SetNew(false)
	end

	return
end

function IslandAgoraAgency:GetSystemThemes()
	return self.systemThemes
end

function IslandAgoraAgency:AddTheme(arg_13_1)
	table.insert(self.themes, arg_13_1)
	self:DispatchEvent(IslandAgoraAgency.ADD_THEME, arg_13_1)

	return
end

function IslandAgoraAgency:DelTheme(arg_14_1)
	local var_14_0 = _.detect(self.themes, function(arg_15_0)
		return arg_15_0.id == arg_14_1
	end)

	if var_14_0 then
		table.removebyvalue(self.themes, var_14_0)
		self:DispatchEvent(IslandAgoraAgency.DEL_THEME, arg_14_1)
	end

	return
end

function IslandAgoraAgency:GetThemes()
	return self.themes
end

function IslandAgoraAgency:SetThemes(arg_17_1)
	self.themes = arg_17_1

	for iter_17_0, iter_17_1 in ipairs(self.themes) do
		self:DispatchEvent(IslandAgoraAgency.ADD_THEME, iter_17_1)
	end

	self.isUpdateThemes = true

	return
end

function IslandAgoraAgency:IsUpdateThemes()
	return self.isUpdateThemes
end

function IslandAgoraAgency:GetFurnitures()
	return self.furnitures
end

function IslandAgoraAgency:GetFurnituresByType(arg_20_1)
	return underscore.select(self.furnitures, function(arg_21_0)
		return pg.island_furniture_template[arg_21_0.id].type == arg_20_1
	end)
end

function IslandAgoraAgency:GetPlacedData()
	return self.placedData
end

function IslandAgoraAgency:GetCapacity()
	return self.capacityList[self.level] or 0
end

function IslandAgoraAgency:GetNextCapacity()
	if not self:CanUpgrade() then
		return self:GetCapacity()
	end

	return self.capacityList[self.level + 1] or 0
end

function IslandAgoraAgency:GetLevel()
	return self.level
end

function IslandAgoraAgency:CanUpgrade()
	return self.level < self.maxLevel
end

function IslandAgoraAgency:GetUpgradeConsume()
	if not self:CanUpgrade() then
		return nil
	end

	local var_27_0 = self.consumeList[self.level] or {}

	return Drop.New({
		type = var_27_0[1],
		id = var_27_0[2],
		count = var_27_0[3]
	})
end

function IslandAgoraAgency:Upgrade()
	self.level = self.level + 1

	self:DispatchEvent(IslandAgoraAgency.AGORA_UPGRADE, self.level, (self:GetCapacity()))

	return
end

function IslandAgoraAgency:UpdatePlacedData(arg_29_1, arg_29_2)
	self.placedData = IslandTheme.New({
		placed_data = arg_29_1
	})

	if not arg_29_2 then
		self:DispatchEvent(IslandAgoraAgency.PLACEMENT_UPDATE, self.placedData)
	end

	return
end

return IslandAgoraAgency
