local var_0_0 = singletonClass("ChapterV2MapData")

function var_0_0.Init(arg_1_0)
	arg_1_0.eventCompleted_ = {}
	arg_1_0.visibleEvents_ = {}
	arg_1_0.trackInfo_ = {}
	arg_1_0.locationActiveTag_ = {}
end

function var_0_0:InitData(arg_2_1)
	self.eventCompleted_ = {}
	self.visibleEvents_ = {}
	self.trackInfo_ = {}

	self:UpdateData(arg_2_1)
end

function var_0_0:UpdateData(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1.event_list) do
		self.eventCompleted_[iter_3_1] = true
	end

	arg_3_1.now_location = tonumber(arg_3_1.now_location)

	local var_3_0 = ChapterV2MapTools.GetMapIdByLocation(arg_3_1.now_location)

	self:SetLastMapId(var_3_0)
	self:SetCurrentMapId(var_3_0)
	self:SetLastLocationId(arg_3_1.now_location)

	local var_3_1 = {}

	for iter_3_2, iter_3_3 in ipairs(arg_3_1.backtrack_list) do
		var_3_1[ChapterV2MapTools.GetChapterClientIDByMap(iter_3_3.map_id)] = ChapterV2MapEventCfg[iter_3_3.start_event].time_stamp
	end

	for iter_3_4, iter_3_5 in pairs(var_3_1) do
		for iter_3_6, iter_3_7 in ipairs((ChapterV2MapTools.GetMapIDListByChapterClientID(iter_3_4))) do
			self.trackInfo_[iter_3_7] = {
				location = 0,
				eventCompleted_ = {}
			}

			for iter_3_8, iter_3_9 in ipairs((ChapterV2MapTools.GetCachedMapSortedEvents(iter_3_7))) do
				if ChapterV2MapData:IsEventCompleted(iter_3_9) and iter_3_5 > ChapterV2MapEventCfg[iter_3_9].time_stamp then
					self.trackInfo_[iter_3_7].eventCompleted_[iter_3_9] = true
				end
			end
		end
	end

	local var_3_2 = ChapterV2MapTools.GetNextEvent(var_3_0)

	if var_3_2 ~= 0 then
		self:SetCurrentLocationId(ChapterV2MapEventCfg[var_3_2].location)
	end

	self:UpdateTrackData()
	ChapterV2MapTools.UpdateAllLocationDynamicTags()
end

function var_0_0:FinishEvent(arg_4_1)
	self.eventCompleted_[arg_4_1] = true

	ChapterV2MapTools.OnEventCompleted(arg_4_1)
end

function var_0_0:IsEventCompleted(arg_5_1)
	return self.eventCompleted_[arg_5_1]
end

function var_0_0:GetCurrentLocationId(arg_6_1)
	arg_6_1 = arg_6_1 or self.currentMapId_

	if not self.trackInfo_[arg_6_1] then
		if arg_6_1 == self:GetLastMapId() then
			return self:GetLastLocationId()
		end

		return 0
	end

	return self.trackInfo_[arg_6_1].location
end

function var_0_0:SetCurrentLocationId(arg_7_1)
	if arg_7_1 == 0 then
		arg_7_1 = self:GetLastLocationId()
	end

	local var_7_0 = ChapterV2MapTools.GetMapIdByLocation(arg_7_1)

	if var_7_0 == self:GetLastMapId() then
		if self.trackInfo_[var_7_0] then
			self.trackInfo_[var_7_0].location = self:GetLastLocationId()
		end

		return
	end

	self.trackInfo_[var_7_0].location = arg_7_1
end

function var_0_0:GetLastMapId()
	return self.lastMapId_
end

function var_0_0.SetLastMapId(arg_9_0, arg_9_1)
	arg_9_0.lastMapId_ = arg_9_1
end

function var_0_0.GetMapCurrentRole(arg_10_0, arg_10_1)
	return (ChapterV2MapCfg[arg_10_1].switch_chara[1] and ChapterV2MapTools.IsEventCompleted(ChapterV2MapCfg[arg_10_1].switch_chara[1][1]) or nil) and ChapterV2MapCfg[arg_10_1].switch_chara[1][2] or 0
end

function var_0_0:UpdateTrackData()
	if ChapterV2MapTools.IsMapInTracking(self.currentMapId_) then
		local var_11_0
		local var_11_1

		for iter_11_0, iter_11_1 in ipairs((ChapterV2MapTools.GetCachedMapSortedEvents(self.currentMapId_))) do
			if ChapterV2MapEventCfg[iter_11_1].type == ChapterV2MapConst.MapEventType.MAIN or ChapterV2MapEventCfg[iter_11_1].type == ChapterV2MapConst.MapEventType.SIDE then
				local var_11_2 = ChapterV2MapEventCfg[iter_11_1].time_stamp

				if self.trackInfo_[self.currentMapId_].eventCompleted_[iter_11_1] then
					if not var_11_0 or var_11_0 < var_11_2 then
						var_11_0 = var_11_2
					end
				elseif not var_11_1 or var_11_2 < var_11_1 then
					var_11_1 = var_11_2
				end
			end
		end

		if (var_11_1 or var_11_0 or 0) ~= 0 then
			ChapterV2MapData:PrepareDataBeforeTrack(self.currentMapId_, var_11_1 or var_11_0 or 0)
		else
			self:TimelineClear()
		end
	else
		self:TimelineClear()
	end
end

function var_0_0:IsMapInTracking(arg_12_1)
	return self.trackInfo_[arg_12_1] ~= nil
end

function var_0_0.PrepareDataBeforeTrack(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.trackingTime_ = arg_13_2
end

function var_0_0:IsEventCompletedTemp(arg_14_1)
	local var_14_0 = ChapterV2MapTools.GetMapIdByEvent(arg_14_1)

	if not self.trackInfo_[var_14_0] then
		return false
	end

	return self.trackInfo_[var_14_0].eventCompleted_[arg_14_1]
end

function var_0_0:IsEventVisible(arg_15_1)
	return self.visibleEvents_[arg_15_1]
end

function var_0_0.TimelineClear(arg_16_0)
	arg_16_0.trackingTime_ = nil
end

function var_0_0:TimelineGetTime()
	return self.trackingTime_
end

function var_0_0.TimelineSetTime(arg_18_0, arg_18_1)
	arg_18_0.trackingTime_ = arg_18_1
end

function var_0_0.SetAutoTrack(arg_19_0, arg_19_1)
	arg_19_0.autoTrack_ = arg_19_1
end

function var_0_0:IsAutoTrack()
	return self.autoTrack_
end

function var_0_0:GetCurrentMapId()
	return self.currentMapId_
end

function var_0_0.SetCurrentMapId(arg_22_0, arg_22_1)
	arg_22_0.currentMapId_ = arg_22_1
end

function var_0_0:GetLastLocationId(arg_23_1)
	return self.lastLocationId_
end

function var_0_0.SetLastLocationId(arg_24_0, arg_24_1)
	arg_24_0.lastLocationId_ = arg_24_1
end

function var_0_0.FinishBattleStage(arg_25_0, arg_25_1)
	return
end

function var_0_0:GetLocationActiveTagList(arg_26_1)
	return self.locationActiveTag_[arg_26_1] or {}
end

function var_0_0:SetLocationActiveTagList(arg_27_1, arg_27_2)
	self.locationActiveTag_[arg_27_1] = arg_27_2

	table.sort(arg_27_2, function(arg_28_0, arg_28_1)
		local var_28_0 = ChapterV2MapTagCfg[arg_28_0]
		local var_28_1 = ChapterV2MapTagCfg[arg_28_1]

		if not ChapterV2MapTagCfg[arg_28_0] then
			Debug.LogError("4.8存在没有的TagID" .. arg_28_0)
		end

		if not var_28_1 then
			Debug.LogError("4.8存在没有的TagID " .. arg_28_1)
		end

		if var_28_0.tag_behaviour == var_28_1.tag_behaviour then
			return var_28_0.tag_id < var_28_1.tag_id
		end

		return var_28_0.tag_behaviour < var_28_1.tag_behaviour
	end)
end

return var_0_0
