local DreamlandData = class("DreamlandData")

DreamlandData.OP_GET_MAP_AWARD = 1
DreamlandData.OP_GET_EXPLORE_AWARD = 2
DreamlandData.OP_RECORD_EXPLORE = 3
DreamlandData.EXPLORE_TYPE_ONCE = 1
DreamlandData.EXPLORE_TYPE_HOLD = 2
DreamlandData.EXPLORE_SUBTYPE_4RAN_NORMAL = 1
DreamlandData.EXPLORE_SUBTYPE_3SEC = 2
DreamlandData.EXPLORE_SUBTYPE_3RAN_ACTION = 3
DreamlandData.EXPLORE_SUBTYPE_2RAN_ACTION = 4
DreamlandData.EXPLORE_SUBTYPE_EFFECT = 5
DreamlandData.EXPLORE_SUBTYPE_UNION = 6

function DreamlandData:Ctor(arg_1_1, arg_1_2)
	self.stories = _.map(pg.activity_dreamland_event.all, function(arg_2_0)
		return pg.activity_dreamland_event[arg_2_0]
	end)
	self.mapIds = pg.activity_dreamland_map.all
	self.exploreGroups = pg.activity_dreamland_explore.get_id_list_by_group
	self.exploreIds = pg.activity_dreamland_explore.all
	self.exploreRecords = {}
	self.mapAwards = {}
	self.exploreAwards = {}
	self.activityId = nil
	self.springShipIds = {}
	self.springSlotLockList = {}
	self.springMaxCnt = 0
	self.springAddition = 0

	self:UpdateActivityData(arg_1_1)
	self:UpdateSpringActivityData(arg_1_2)

	return
end

function DreamlandData:UpdateSpringActivityData(arg_3_1)
	self.springShipIds = _.map(arg_3_1:GetShipIds(), function(arg_4_0)
		if getProxy(BayProxy):RawGetShipById(arg_4_0) then
			return arg_4_0
		else
			return 0
		end

		return
	end)
	self.springMaxCnt = arg_3_1:GetSlotCount()
	self.springAddition = arg_3_1:GetEnergyRecoverAddition()

	self:UpdateSpringSlotLockList()

	return
end

function DreamlandData:UpdateSpringSlotLockList()
	local var_5_0 = 0

	for iter_5_0, iter_5_1 in ipairs((self:FindUnlockMaps())) do
		var_5_0 = var_5_0 + iter_5_1.character_num
	end

	for iter_5_2 = 1, self.springMaxCnt do
		self.springSlotLockList[iter_5_2] = var_5_0 < iter_5_2
	end

	return
end

function DreamlandData:GetUnlockSpringCnt()
	local var_6_0 = 0

	for iter_6_0, iter_6_1 in pairs(self.springSlotLockList) do
		if not iter_6_1 then
			var_6_0 = var_6_0 + 1
		end
	end

	return var_6_0
end

function DreamlandData:GetHotSpringAddition()
	return self.springAddition * 10
end

function DreamlandData:GetHotSpringData()
	return self.springShipIds
end

function DreamlandData:GetHotSpringMaxCnt()
	return self.springMaxCnt
end

function DreamlandData:IsLockSpringSlot(arg_10_1)
	return self.springSlotLockList[arg_10_1]
end

function DreamlandData:GetAllSpringShip()
	local var_11_0 = {}
	local var_11_1 = getProxy(BayProxy)

	for iter_11_0, iter_11_1 in ipairs((self:GetHotSpringData())) do
		if iter_11_1 > 0 then
			local var_11_2 = var_11_1:RawGetShipById(iter_11_1)

			if var_11_2 then
				local var_11_3 = self:GetMapIdBySpringSlot(iter_11_0)

				var_11_0[var_11_3] = var_11_0[var_11_3] or {}

				table.insert(var_11_0[var_11_3], var_11_2)
			end
		end
	end

	return var_11_0
end

function DreamlandData:GetMapIdBySpringSlot(arg_12_1)
	local var_12_0 = 0

	for iter_12_0, iter_12_1 in ipairs((self:FindUnlockMaps())) do
		var_12_0 = var_12_0 + iter_12_1.character_num

		if arg_12_1 >= 0 + 1 and arg_12_1 <= var_12_0 then
			return iter_12_1.id
		end
	end

	return -1
end

function DreamlandData:MapId2MapGraph(arg_13_1)
	local var_13_0 = "DreamlandMapGraph" .. arg_13_1

	if not _G["DreamlandMapGraph" .. arg_13_1] then
		local var_13_1 = pcall(function()
			_G[var_13_0] = import("view.activity.Dreamland.graph." .. var_13_0)

			return
		end)
	end

	return _G["DreamlandMapGraph" .. arg_13_1]
end

function DreamlandData:UpdateActivityData(arg_15_1)
	self.activityId = arg_15_1.id

	for iter_15_0, iter_15_1 in ipairs(arg_15_1.data1_list) do
		self.mapAwards[iter_15_1] = true
	end

	for iter_15_2, iter_15_3 in ipairs(arg_15_1.data2_list) do
		self.exploreAwards[iter_15_3] = true
	end

	for iter_15_4, iter_15_5 in ipairs(arg_15_1.data3_list) do
		self.exploreRecords[iter_15_5] = true
	end

	return
end

function DreamlandData:GetActivityId()
	return self.activityId
end

function DreamlandData:ShouldShowChatTip(arg_17_1)
	return not self:IsRecordExplore(arg_17_1)
end

function DreamlandData:IsRecordExplore(arg_18_1)
	local var_18_0 = self.exploreGroups[self:FindExploreObj(arg_18_1).group] or {}

	return #var_18_0 > 0 and _.any(var_18_0, function(arg_19_0)
		return self.exploreRecords[arg_19_0] == true
	end)
end

local function var_0_1(arg_20_0)
	return pg.NewStoryMgr.GetInstance():IsPlayed(pg.activity_dreamland_event[arg_20_0].story)
end

function DreamlandData:FindPlayableStory()
	return (_.detect(self.stories, function(arg_22_0)
		return not var_0_1(arg_22_0.id)
	end))
end

function DreamlandData:GetAllMapId()
	return self.mapIds
end

function DreamlandData:IsUnlockMap(arg_24_1)
	return _.any(self:FindUnlockMaps(), function(arg_25_0)
		return arg_25_0.id == arg_24_1
	end)
end

function DreamlandData:IsUnlockAll()
	return _.all(self:GetAllMapId(), function(arg_27_0)
		return self:IsUnlockMap(arg_27_0)
	end)
end

function DreamlandData:IsReceiveMapAward(arg_28_1)
	return self.mapAwards[arg_28_1] == true
end

function DreamlandData:FindMap(arg_29_1)
	return pg.activity_dreamland_map[arg_29_1]
end

function DreamlandData:FindUnlockMaps()
	local var_30_0 = {}

	for iter_30_0, iter_30_1 in pairs(self.mapIds) do
		if var_0_1(pg.activity_dreamland_map[iter_30_1].unlock_condition) then
			table.insert(var_30_0, pg.activity_dreamland_map[iter_30_1])
		end
	end

	return var_30_0
end

function DreamlandData:IsFirstEvent()
	return _.all(self.stories, function(arg_32_0)
		return not var_0_1(arg_32_0.id)
	end)
end

function DreamlandData:IsLastEvent()
	local var_33_0 = 0

	for iter_33_0, iter_33_1 in ipairs(self.stories) do
		if not var_0_1(iter_33_1.id) then
			var_33_0 = var_33_0 + 1
		end
	end

	return var_33_0 == 1
end

function DreamlandData:IsFinishAllEvent()
	return _.all(self.stories, function(arg_35_0)
		return var_0_1(arg_35_0.id)
	end)
end

function DreamlandData:UnlockMap2UnlockExploreObj(arg_36_1)
	local var_36_0 = {}

	for iter_36_0, iter_36_1 in ipairs(arg_36_1.explore) do
		for iter_36_2, iter_36_3 in ipairs(self.exploreGroups[iter_36_1] or {}) do
			table.insert(var_36_0, pg.activity_dreamland_explore[iter_36_3])
		end
	end

	return var_36_0
end

function DreamlandData:FindCanInteractionExploreObj()
	local var_37_0 = {}

	for iter_37_0, iter_37_1 in ipairs((self:FindUnlockMaps())) do
		for iter_37_2, iter_37_3 in ipairs(self:UnlockMap2UnlockExploreObj(iter_37_1)) do
			table.insert(var_37_0, iter_37_3)
		end
	end

	return var_37_0
end

function DreamlandData:GetExploreSubType(arg_38_1)
	for iter_38_0, iter_38_1 in ipairs(self.exploreIds) do
		local var_38_0 = self:FindExploreObj(iter_38_1)

		if var_38_0.pic == arg_38_1 then
			return var_38_0.sub_type[1]
		end
	end

	if arg_38_1 == "mengleyuan_qiqiu" then
		return DreamlandData.EXPLORE_SUBTYPE_4RAN_NORMAL
	end

	return 0
end

function DreamlandData:IsFinishMapExplore(arg_39_1)
	return _.all(self:FindMap(arg_39_1).explore, function(arg_40_0)
		local var_40_0 = self.exploreGroups[arg_40_0] or {}

		return #var_40_0 > 0 and _.any(var_40_0, function(arg_41_0)
			return self.exploreRecords[arg_41_0] == true
		end)
	end)
end

function DreamlandData:IsReceiveExploreAward(arg_42_1)
	return self.exploreAwards[arg_42_1] == true
end

function DreamlandData:FindExploreObj(arg_43_1)
	return pg.activity_dreamland_explore[arg_43_1]
end

function DreamlandData:FindMapIdByExploreId(arg_44_1)
	for iter_44_0, iter_44_1 in ipairs((self:FindUnlockMaps())) do
		if _.any(self:UnlockMap2UnlockExploreObj(iter_44_1), function(arg_45_0)
			return arg_45_0.id == arg_44_1
		end) then
			return iter_44_1.id
		end
	end

	return nil
end

function DreamlandData:GetMainExploreInMap(arg_46_1)
	local var_46_0 = {}

	for iter_46_0, iter_46_1 in ipairs(arg_46_1.explore) do
		if self.exploreGroups[iter_46_1][1] ~= nil then
			table.insert(var_46_0, self.exploreGroups[iter_46_1][1])
		end
	end

	return var_46_0
end

function DreamlandData:ExistAnyMapAward()
	return _.any(self:GetAllMapId(), function(arg_48_0)
		return self:IsUnlockMap(arg_48_0) and not self:IsReceiveMapAward(arg_48_0)
	end)
end

local var_0_2 = "DREAMLAND_KEY"

function DreamlandData:FirstTimeExplore()
	return PlayerPrefs.GetInt(var_0_2 .. getProxy(PlayerProxy):getRawData().id, 0) == 0 and #self:FindUnlockMaps() > 0 and table.getCount(self.exploreAwards) == 0
end

function DreamlandData:ExistAnyExploreAward()
	return _.any(self:GetAllMapId(), function(arg_51_0)
		return self:IsFinishMapExplore(arg_51_0) and not self:IsReceiveExploreAward(arg_51_0)
	end) or self:FirstTimeExplore()
end

function DreamlandData:MarkExploreState()
	if self:FirstTimeExplore() then
		PlayerPrefs.SetInt(var_0_2 .. getProxy(PlayerProxy):getRawData().id, 1)
		PlayerPrefs.Save()

		return true
	end

	return false
end

function DreamlandData:ExistAnyMapOrExploreAward()
	return self:ExistAnyMapAward() or self:ExistAnyExploreAward() or self:IsFirstEvent()
end

return DreamlandData
