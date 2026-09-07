local ChapterProxy = class("ChapterProxy", import(".NetProxy"))

ChapterProxy.CHAPTER_UPDATED = "ChapterProxy:CHAPTER_UPDATED"
ChapterProxy.CHAPTER_TIMESUP = "ChapterProxy:CHAPTER_TIMESUP"
ChapterProxy.CHAPTER_CELL_UPDATED = "ChapterProxy:CHAPTER_CELL_UPDATED"
ChapterProxy.CHAPTER_AUTO_FIGHT_FLAG_UPDATED = "CHAPTERPROXY:CHAPTER_AUTO_FIGHT_FLAG_UPDATED"
ChapterProxy.CHAPTER_SKIP_PRECOMBAT_UPDATED = "CHAPTERPROXY:CHAPTER_SKIP_PRECOMBAT_UPDATED"
ChapterProxy.CHAPTER_REMASTER_INFO_UPDATED = "CHAPTERPROXY:CHAPTER_REMASTER_INFO_UPDATED"
ChapterProxy.LAST_MAP_FOR_ACTIVITY = "last_map_for_activity"
ChapterProxy.LAST_MAP = "last_map"

function ChapterProxy:register()
	self:on(13001, function(arg_2_0)
		self.mapEliteFleetCache = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.fleet_list) do
			self.mapEliteFleetCache[iter_2_1.id] = Chapter.BuildEliteFleetInfo(iter_2_1)
		end

		for iter_2_2, iter_2_3 in ipairs(arg_2_0.chapter_list) do
			if not pg.chapter_template[iter_2_3.id] then
				errorMsg("chapter_template not exist: " .. iter_2_3.id)
			else
				local var_2_0 = Chapter.New(iter_2_3)

				var_2_0:setEliteFleetList(Clone(self.mapEliteFleetCache[var_2_0:getConfig("formation")]))
				self:updateChapter(var_2_0)
			end
		end

		if arg_2_0.react_chapter then
			self.remasterTickets = arg_2_0.react_chapter.count
			self.remasterDailyCount = arg_2_0.react_chapter.daily_count
			self.remasterTip = self.remasterDailyCount <= 0
		end

		return
	end)
	self:on(13000, function(arg_3_0)
		self.repairTimes = arg_3_0.daily_repair_count

		if arg_3_0.current_chapter then
			if arg_3_0.current_chapter.id > 0 then
				local var_3_0 = self:getChapterById(arg_3_0.current_chapter.id, true)

				var_3_0:update(arg_3_0.current_chapter)
				self:updateChapter(var_3_0)
			end
		end

		Map.lastMap = self:getLastMap(ChapterProxy.LAST_MAP)
		Map.lastMapForActivity = self:getLastMap(ChapterProxy.LAST_MAP_FOR_ACTIVITY)

		pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inChapter")
		pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inElite")
		pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inSupport")

		return
	end)

	self.timers = {}
	self.escortChallengeTimes = 0
	self.chaptersExtend = {}
	self.chapterStoryGroups = {}
	self.continuousData = {}

	self:buildMaps()
	self:buildRemasterInfo()

	return
end

function ChapterProxy:timeCall()
	return {
		[ProxyRegister.DayCall] = function(arg_5_0)
			self:resetRepairTimes()
			self:resetEscortChallengeTimes()

			for iter_5_0, iter_5_1 in pairs((self:getData())) do
				if iter_5_1.todayDefeatCount > 0 then
					iter_5_1.todayDefeatCount = 0

					self:updateChapter(iter_5_1)
				end
			end

			self:resetDailyCount()

			return
		end
	}
end

function ChapterProxy:OnBattleFinished(arg_6_1, arg_6_2)
	local var_6_0 = self:getActiveChapter()

	if var_6_0 then
		local var_6_1 = 0

		local function var_6_2()
			local var_7_0 = getProxy(ContextProxy)

			if not var_7_0 then
				return
			end

			if var_7_0:getCurrentContext().mediator == LevelMediator2 then
				var_6_1 = bit.bor(var_6_1, ChapterConst.DirtyAttachment, ChapterConst.DirtyStrategy)

				self:SetChapterAutoFlag(var_6_0.id, false)

				return
			end

			local var_7_1 = var_7_0:getContextByMediator(LevelMediator2)

			if not var_7_1 then
				return
			end

			var_7_1.data.StopAutoFightFlag = true

			return
		end

		if _.any(arg_6_1.ai_list, function(arg_8_0)
			return arg_8_0.item_type == ChapterConst.AttachOni
		end) then
			var_6_0:onOniEnter()
			var_6_2()
		end

		if _.any(arg_6_1.map_update, function(arg_9_0)
			return arg_9_0.item_type == ChapterConst.AttachBomb_Enemy
		end) then
			var_6_0:onBombEnemyEnter()
			var_6_2()
		end

		if #arg_6_1.map_update > 0 then
			_.each(arg_6_1.map_update, function(arg_10_0)
				if arg_10_0.item_type == ChapterConst.AttachStory and arg_10_0.item_data == ChapterConst.StoryTrigger then
					local var_10_0 = ChapterCell.Line2Name(arg_10_0.pos.row, arg_10_0.pos.column)
					local var_10_1 = var_6_0:GetChapterCellAttachemnts()

					if var_10_1[var_10_0] then
						if var_10_1[var_10_0].flag == ChapterConst.CellFlagTriggerActive and arg_10_0.item_flag == ChapterConst.CellFlagTriggerDisabled then
							if pg.map_event_template[var_10_1[var_10_0].attachmentId].gametip ~= "" then
								pg.TipsMgr.GetInstance():ShowTips(i18n(pg.map_event_template[var_10_1[var_10_0].attachmentId].gametip))
							end
						end

						var_10_1[var_10_0].attachment = arg_10_0.item_type
						var_10_1[var_10_0].attachmentId = arg_10_0.item_id
						var_10_1[var_10_0].flag = arg_10_0.item_flag
						var_10_1[var_10_0].data = arg_10_0.item_data
					else
						var_10_1[var_10_0] = ChapterCell.New(arg_10_0)
					end
				elseif arg_10_0.item_type ~= ChapterConst.AttachNone and arg_10_0.item_type ~= ChapterConst.AttachBorn and arg_10_0.item_type ~= ChapterConst.AttachBorn_Sub and arg_10_0.item_type ~= ChapterConst.AttachOni_Target and arg_10_0.item_type ~= ChapterConst.AttachOni then
					var_6_0:mergeChapterCell((ChapterCell.New(arg_10_0)))
				end

				return
			end)

			var_6_1 = bit.bor(var_6_1, ChapterConst.DirtyAttachment, ChapterConst.DirtyAutoAction)
		end

		if #arg_6_1.ai_list > 0 then
			_.each(arg_6_1.ai_list, function(arg_11_0)
				var_6_0:mergeChampion((ChapterChampionPackage.New(arg_11_0)))

				return
			end)

			var_6_1 = bit.bor(var_6_1, ChapterConst.DirtyChampion, ChapterConst.DirtyAutoAction)
		end

		if #arg_6_1.add_flag_list > 0 or #arg_6_1.del_flag_list > 0 then
			var_6_1 = bit.bor(var_6_1, ChapterConst.DirtyFleet, ChapterConst.DirtyStrategy, ChapterConst.DirtyCellFlag, ChapterConst.DirtyFloatItems, ChapterConst.DirtyAttachment, ChapterConst.DirtyWeather)

			self:updateExtraFlag(var_6_0, arg_6_1.add_flag_list, arg_6_1.del_flag_list)
		end

		if #arg_6_1.buff_list > 0 then
			var_6_0:UpdateBuffList(arg_6_1.buff_list)
		end

		if #arg_6_1.cell_flag_list > 0 then
			_.each(arg_6_1.cell_flag_list, function(arg_12_0)
				local var_12_0 = var_6_0:getChapterCell(arg_12_0.pos.row, arg_12_0.pos.column)

				if var_12_0 then
					var_12_0:updateFlagList(arg_12_0)
				else
					var_12_0 = ChapterCell.New(arg_12_0)
				end

				var_6_0:updateChapterCell(var_12_0)

				return
			end)

			var_6_1 = bit.bor(var_6_1, ChapterConst.DirtyCellFlag, ChapterConst.DirtyWeather)
		end

		self:updateChapter(var_6_0, var_6_1)

		if arg_6_2 then
			self:sendNotification(GAME.CHAPTER_OP_DONE, {
				type = ChapterConst.OpSkipBattle
			})
		end
	end

	return
end

function ChapterProxy:setEliteCache(arg_13_1)
	self.mapEliteFleetCache = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		self.mapEliteFleetCache[iter_13_1.id] = Chapter.BuildEliteFleetInfo(iter_13_1)
	end

	pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inElite")
	pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inSupport")

	for iter_13_2, iter_13_3 in pairs(self.data) do
		iter_13_3:setEliteFleetList(Clone(self.mapEliteFleetCache[iter_13_3:getConfig("formation")]))
		self:updateChapter(iter_13_3)
	end

	return
end

function ChapterProxy:buildMaps()
	self:initChapters()
	self:buildBaseMaps()
	self:buildRemasterMaps()

	return
end

function ChapterProxy:initChapters()
	ChapterProxy.MapToChapters = table.shallowCopy(pg.chapter_template.get_id_list_by_map)

	for iter_15_0, iter_15_1 in pairs(pg.story_group.get_id_list_by_map) do
		ChapterProxy.MapToChapters[iter_15_0] = ChapterProxy.MapToChapters[iter_15_0] or {}

		table.insertto(ChapterProxy.MapToChapters[iter_15_0], iter_15_1)
	end

	ChapterProxy.FormationToChapters = pg.chapter_template.get_id_list_by_formation

	return
end

function ChapterProxy:buildBaseMaps()
	ChapterProxy.ActToMaps = {}
	ChapterProxy.TypeToMaps = {}

	local var_16_0 = {}

	for iter_16_0, iter_16_1 in ipairs(pg.expedition_data_by_map.all) do
		local var_16_1 = Map.New({
			id = iter_16_1,
			chapterIds = ChapterProxy.MapToChapters[iter_16_1]
		})

		var_16_0[iter_16_1] = var_16_1

		local var_16_2 = var_16_1:getConfig("on_activity")

		if var_16_2 ~= 0 then
			ChapterProxy.ActToMaps[var_16_2] = ChapterProxy.ActToMaps[var_16_2] or {}

			table.insert(ChapterProxy.ActToMaps[var_16_2], var_16_1.id)
		end

		local var_16_3 = var_16_1:getMapType()

		ChapterProxy.TypeToMaps[var_16_3] = ChapterProxy.TypeToMaps[var_16_3] or {}

		table.insert(ChapterProxy.TypeToMaps[var_16_3], var_16_1.id)
	end

	self.baseMaps = var_16_0

	return
end

function ChapterProxy:buildRemasterMaps()
	ChapterProxy.RemasterToMaps = {}

	local var_17_0 = {}

	_.each(BossRushChapterRemasterHelper.GetAllNonActivityIds(), function(arg_18_0)
		_.each(pg.re_map_template[arg_18_0].config_data, function(arg_19_0)
			local var_19_0 = self.baseMaps[pg.chapter_template[arg_19_0].map]

			assert(not var_17_0[self.baseMaps[pg.chapter_template[arg_19_0].map].id] or var_17_0[var_19_0.id] == arg_18_0, "remaster chapter error:" .. arg_19_0)

			if not var_17_0[var_19_0.id] then
				var_17_0[var_19_0.id] = arg_18_0

				var_19_0:setRemaster(arg_18_0)

				ChapterProxy.RemasterToMaps[arg_18_0] = ChapterProxy.RemasterToMaps[arg_18_0] or {}

				table.insert(ChapterProxy.RemasterToMaps[arg_18_0], var_19_0.id)
			end

			return
		end)

		return
	end)

	return
end

function ChapterProxy:IsChapterInRemaster(arg_20_1)
	return _.detect(BossRushChapterRemasterHelper.GetAllNonActivityIds(), function(arg_21_0)
		return _.any(pg.re_map_template[arg_21_0].config_data, function(arg_22_0)
			return arg_22_0 == arg_20_1
		end)
	end)
end

function ChapterProxy:getMaxEscortChallengeTimes()
	local var_23_0 = getProxy(ActivityProxy):getActivityParameter("escort_daily_count")

	var_23_0 = var_23_0 or 0

	return var_23_0
end

function ChapterProxy:getEscortChapterIds()
	local var_24_0 = getProxy(ActivityProxy):getActivityParameter("escort_exp_id")

	var_24_0 = var_24_0 or {}

	return var_24_0
end

function ChapterProxy:resetEscortChallengeTimes()
	self.escortChallengeTimes = 0

	return
end

function ChapterProxy:addChapterListener(arg_26_1)
	if not arg_26_1.dueTime or not self.timers then
		return
	end

	if self.timers[arg_26_1.id] then
		self.timers[arg_26_1.id]:Stop()

		self.timers[arg_26_1.id] = nil
	end

	local var_26_0 = arg_26_1.dueTime - pg.TimeMgr.GetInstance():GetServerTime()

	local function var_26_1()
		self.data[arg_26_1.id].dueTime = nil

		self.data[arg_26_1.id]:display("times'up")
		self:sendNotification(ChapterProxy.CHAPTER_UPDATED, {
			dirty = 0,
			chapter = self.data[arg_26_1.id]:clone()
		})
		self:sendNotification(ChapterProxy.CHAPTER_TIMESUP)

		return
	end

	if var_26_0 > 0 then
		self.timers[arg_26_1.id] = Timer.New(function()
			var_26_1()
			self.timers[arg_26_1.id]:Stop()

			self.timers[arg_26_1.id] = nil

			return
		end, var_26_0, 1)

		self.timers[arg_26_1.id]:Start()
	else
		var_26_1()
	end

	return
end

function ChapterProxy:removeChapterListener(arg_29_1)
	if self.timers[arg_29_1] then
		self.timers[arg_29_1]:Stop()

		self.timers[arg_29_1] = nil
	end

	return
end

function ChapterProxy:remove()
	for iter_30_0, iter_30_1 in pairs(self.timers) do
		iter_30_1:Stop()
	end

	self.timers = nil

	return
end

function ChapterProxy:GetRawChapterById(arg_31_1)
	return self.data[arg_31_1]
end

function ChapterProxy:getChapterById(arg_32_1, arg_32_2)
	local var_32_0 = self.data[arg_32_1]

	if not self.data[arg_32_1] then
		assert(pg.chapter_template[arg_32_1], "Not Exist Chapter ID: " .. (arg_32_1 or "NIL"))

		var_32_0 = Chapter.New({
			id = arg_32_1
		})

		if var_32_0:getConfig("type") == Chapter.CustomFleet or var_32_0:GetSupportFleetMaxCount() > 0 then
			var_32_0:setEliteFleetList(Clone(self.mapEliteFleetCache[var_32_0:getConfig("formation")]))
		end

		self.data[arg_32_1] = var_32_0
	end

	return arg_32_2 and var_32_0 or var_32_0:clone()
end

function ChapterProxy:GetChapterItemById(arg_33_1)
	if Chapter:bindConfigTable()[arg_33_1] then
		return self:getChapterById(arg_33_1, true)
	elseif ChapterStoryGroup:bindConfigTable()[arg_33_1] then
		local var_33_0 = self.chapterStoryGroups[arg_33_1]

		if not self.chapterStoryGroups[arg_33_1] then
			var_33_0 = ChapterStoryGroup.New({
				configId = arg_33_1
			})
			self.chapterStoryGroups[arg_33_1] = var_33_0
		end

		return var_33_0
	end

	return
end

function ChapterProxy:updateChapter(arg_34_1, arg_34_2)
	assert(isa(arg_34_1, Chapter), "should be an instance of Chapter")

	self.data[arg_34_1.id] = arg_34_1

	if self.data[arg_34_1.id] then
		self:removeChapterListener(self.data[arg_34_1.id].id)
	end

	self:addChapterListener(arg_34_1)

	if getProxy(PlayerProxy):getInited() then
		self.facade:sendNotification(ChapterProxy.CHAPTER_UPDATED, {
			chapter = arg_34_1:clone(),
			dirty = defaultValue(arg_34_2, 0)
		})
	end

	if arg_34_1.active and arg_34_1.fleet then
		arg_34_1.fleet:clearShipHpChange()
	end

	if tobool(checkExist(self.data[arg_34_1.id], {
		"active"
	})) ~= tobool(arg_34_1.active) then
		pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inChapter")
	end

	return
end

function ChapterProxy:getMapById(arg_35_1)
	return self.baseMaps[arg_35_1]
end

function ChapterProxy:getNormalMaps()
	local var_36_0 = {}

	for iter_36_0, iter_36_1 in ipairs(self.baseMaps) do
		table.insert(var_36_0, iter_36_1)
	end

	return var_36_0
end

function ChapterProxy:getMapsByType(arg_37_1)
	if ChapterProxy.TypeToMaps[arg_37_1] then
		return _.map(ChapterProxy.TypeToMaps[arg_37_1], function(arg_38_0)
			return self:getMapById(arg_38_0)
		end)
	else
		return {}
	end

	return
end

function ChapterProxy:getMapsByActId(arg_39_1)
	if ChapterProxy.ActToMaps[arg_39_1] then
		return underscore.map(ChapterProxy.ActToMaps[arg_39_1], function(arg_40_0)
			return self:getMapById(arg_40_0)
		end)
	else
		return {}
	end

	return
end

function ChapterProxy:getRemasterMaps(arg_41_1)
	if ChapterProxy.RemasterToMaps[arg_41_1] then
		return underscore.map(ChapterProxy.RemasterToMaps[arg_41_1], function(arg_42_0)
			return self:getMapById(arg_42_0)
		end)
	else
		return {}
	end

	return
end

function ChapterProxy:getMapsByActivities(arg_43_1)
	local var_43_0 = getProxy(ActivityProxy)
	local var_43_1

	if arg_43_1 then
		var_43_1 = var_43_0:getActivityById(arg_43_1)
	else
		local var_43_2 = var_43_0:getActivitiesByType(ActivityConst.ACTIVITY_TYPE_ZPROJECT)

		table.sort(var_43_2, CompareFuncs({
			function(arg_44_0)
				return defaultValue(arg_44_0:GetConfigClientSetting("order"), 1)
			end
		}))

		var_43_1 = var_43_2[1]
	end

	if not var_43_1 then
		return {}
	end

	local var_43_3 = pg.expedition_data_by_map[pg.chapter_template[var_43_1:getConfig("config_data")[1]].map].on_activity

	if getProxy(ActivityProxy):IsActivityNotEnd(var_43_3) then
		return self:getMapsByActId(var_43_3)
	else
		return {}
	end

	return
end

function ChapterProxy:getLastUnlockMap()
	local var_45_0

	for iter_45_0, iter_45_1 in ipairs(self:getNormalMaps()) do
		if not iter_45_1:isUnlock() then
			break
		end

		var_45_0 = iter_45_1
	end

	return var_45_0
end

function ChapterProxy:updateExtraFlag(arg_46_1, arg_46_2, arg_46_3, arg_46_4)
	local var_46_0 = underscore.to_array(arg_46_1:getExtraFlags())

	if not arg_46_4 and not arg_46_1:updateExtraFlags(arg_46_2, arg_46_3) then
		return
	end

	local var_46_1 = {}

	for iter_46_0, iter_46_1 in ipairs(arg_46_1:getExtraFlags()) do
		if not table.contains(var_46_0, iter_46_1) then
			table.insert(var_46_1, iter_46_1)
		end
	end

	self:SetExtendChapterData(arg_46_1.id, "extraFlagUpdate", var_46_1)

	return true
end

function ChapterProxy:extraFlagUpdated(arg_47_1)
	self:RemoveExtendChapterData(arg_47_1, "extraFlagUpdate")

	return
end

function ChapterProxy:getUpdatedExtraFlags(arg_48_1)
	return self:GetExtendChapterData(arg_48_1, "extraFlagUpdate")
end

function ChapterProxy:SetExtendChapterData(arg_49_1, arg_49_2, arg_49_3)
	assert(arg_49_1, "Missing Chapter ID")

	self.chaptersExtend[arg_49_1] = self.chaptersExtend[arg_49_1] or {}
	self.chaptersExtend[arg_49_1][arg_49_2] = arg_49_3

	return
end

function ChapterProxy:AddExtendChapterDataArray(arg_50_1, arg_50_2, arg_50_3, arg_50_4)
	assert(arg_50_1, "Missing Chapter ID")

	self.chaptersExtend[arg_50_1] = self.chaptersExtend[arg_50_1] or {}

	if type(self.chaptersExtend[arg_50_1][arg_50_2]) ~= "table" then
		assert(self.chaptersExtend[arg_50_1][arg_50_2] == nil, "Changing NonEmpty ExtendData " .. arg_50_2 .. " to Table ID: " .. arg_50_1)

		self.chaptersExtend[arg_50_1][arg_50_2] = {}
	end

	arg_50_4 = arg_50_4 or #self.chaptersExtend[arg_50_1][arg_50_2] + 1
	self.chaptersExtend[arg_50_1][arg_50_2][arg_50_4] = arg_50_3

	return
end

function ChapterProxy:AddExtendChapterDataTable(arg_51_1, arg_51_2, arg_51_3, arg_51_4)
	assert(arg_51_1, "Missing Chapter ID")

	self.chaptersExtend[arg_51_1] = self.chaptersExtend[arg_51_1] or {}

	if type(self.chaptersExtend[arg_51_1][arg_51_2]) ~= "table" then
		assert(self.chaptersExtend[arg_51_1][arg_51_2] == nil, "Changing NonEmpty ExtendData " .. arg_51_2 .. " to Table ID: " .. arg_51_1)

		self.chaptersExtend[arg_51_1][arg_51_2] = {}
	end

	assert(arg_51_3, "Missing Index on Set HashData")

	self.chaptersExtend[arg_51_1][arg_51_2][arg_51_3] = arg_51_4

	return
end

function ChapterProxy:GetExtendChapterData(arg_52_1, arg_52_2)
	assert(arg_52_1, "Missing Chapter ID")
	assert(arg_52_2, "Requesting Empty key")

	if not arg_52_2 or not self.chaptersExtend[arg_52_1] then
		return
	end

	return self.chaptersExtend[arg_52_1][arg_52_2]
end

function ChapterProxy:RemoveExtendChapterData(arg_53_1, arg_53_2)
	assert(arg_53_1, "Missing Chapter ID")

	if not arg_53_2 or not self.chaptersExtend[arg_53_1] then
		return
	end

	self.chaptersExtend[arg_53_1][arg_53_2] = nil

	if next(self.chaptersExtend[arg_53_1]) then
		return
	end

	self:RemoveExtendChapter(arg_53_1)

	return
end

function ChapterProxy:GetExtendChapter(arg_54_1)
	assert(arg_54_1, "Missing Chapter ID")

	return self.chaptersExtend[arg_54_1]
end

function ChapterProxy:RemoveExtendChapter(arg_55_1)
	assert(arg_55_1, "Missing Chapter ID")

	if not self.chaptersExtend[arg_55_1] then
		return
	end

	self.chaptersExtend[arg_55_1] = nil

	return
end

function ChapterProxy:duplicateEliteFleet(arg_56_1)
	if arg_56_1:getConfig("type") ~= Chapter.CustomFleet and arg_56_1:GetSupportFleetMaxCount() == 0 then
		return
	end

	local var_56_0 = arg_56_1:getConfig("formation")

	self.mapEliteFleetCache[var_56_0] = Clone(arg_56_1.eliteFleetList)

	pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inElite")
	pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inSupport")

	for iter_56_0, iter_56_1 in ipairs(ChapterProxy.FormationToChapters[var_56_0]) do
		local var_56_1 = self:getChapterById(iter_56_1, true)

		if var_56_1.configId ~= arg_56_1.configId then
			var_56_1:setEliteFleetList(Clone(arg_56_1.eliteFleetList))
			self:updateChapter(var_56_1)
		end
	end

	return
end

function ChapterProxy:RemoveUnitFromSupportFleet(arg_57_1)
	self:sendNotification(GAME.REMOVE_ELITE_TARGET_SHIP, {
		shipId = arg_57_1.id
	})

	return
end

function ChapterProxy:getActiveChapter(arg_58_1)
	for iter_58_0, iter_58_1 in pairs(self.data) do
		if iter_58_1.active then
			return arg_58_1 and iter_58_1 or iter_58_1:clone()
		end
	end

	return
end

function ChapterProxy:GetLastNormalMap()
	local var_59_0 = Map.lastMap and self:getMapById(Map.lastMap)

	if var_59_0 and var_59_0:isUnlock() and var_59_0:getMapType() == Map.SCENARIO then
		return Map.lastMap
	end

	return self:getLastUnlockMap().id
end

function ChapterProxy:getLastMapForActivity(arg_60_1)
	local var_60_1 = self:getActiveChapter()

	if nil then
		local var_60_2 = self:getMapById((nil):getConfig("map"))

		if var_60_2:isActivity() and not var_60_2:isRemaster() then
			return var_60_2.id, (nil).id
		end
	end

	local var_60_3 = Map.lastMapForActivity and self:getMapById(Map.lastMapForActivity)

	if var_60_3 and not var_60_3:isRemaster() and var_60_3:isUnlock() and (not arg_60_1 or var_60_3:getConfig("on_activity") == arg_60_1) then
		return Map.lastMapForActivity
	end

	if Map.lastMapForActivity then
		self:recordLastMap(ChapterProxy.LAST_MAP_FOR_ACTIVITY, 0)
	end

	return self:getActivityLastUnlockMap(arg_60_1)
end

function ChapterProxy:getActivityLastUnlockMap(arg_61_1)
	local var_61_0 = self:getMapsByActivities(arg_61_1)

	if not _.all(var_61_0, function(arg_62_0)
		return arg_62_0:getConfig("type") == Map.EVENT
	end) then
		for iter_61_0, iter_61_1 in ipairs({
			Map.ACTIVITY_EASY,
			Map.ACTIVITY_HARD
		}) do
			local var_61_1 = underscore.filter(var_61_0, function(arg_63_0)
				return arg_63_0:getMapType() == iter_61_1
			end)

			if #var_61_1 > 0 and underscore.any(var_61_1, function(arg_64_0)
				return not arg_64_0:isClearForActivity()
			end) then
				var_61_0 = var_61_1

				break
			end
		end
	end

	for iter_61_2 = #var_61_0, 1, -1 do
		if var_61_0[iter_61_2]:isUnlock() then
			return var_61_0[iter_61_2].id
		end
	end

	if #var_61_0 > 0 then
		return var_61_0[1].id
	end

	return
end

function ChapterProxy:updateActiveChapterShips()
	local var_65_0 = self:getActiveChapter(true)

	if var_65_0 then
		_.each(var_65_0.fleets, function(arg_66_0)
			arg_66_0:flushShips()

			return
		end)
		self:updateChapter(var_65_0, ChapterConst.DirtyFleet)
	end

	return
end

function ChapterProxy:resetRepairTimes()
	self.repairTimes = 0

	return
end

function ChapterProxy:getUseableEliteMap()
	local var_68_0 = {}

	for iter_68_0, iter_68_1 in ipairs(self:getMapsByType(Map.ELITE)) do
		if iter_68_1:isEliteEnabled() then
			var_68_0[#var_68_0 + 1] = iter_68_1
		end
	end

	return var_68_0
end

function ChapterProxy:getUseableMaxEliteMap()
	local var_69_0 = self:getUseableEliteMap()

	if #var_69_0 == 0 then
		return false
	else
		local var_69_1

		for iter_69_0, iter_69_1 in ipairs(var_69_0) do
			if not var_69_1 or var_69_1.id < iter_69_1.id then
				var_69_1 = iter_69_1
			end
		end

		return var_69_1
	end

	return
end

function ChapterProxy:getHigestClearChapterAndMap()
	local var_70_0 = self.baseMaps[1]

	for iter_70_0, iter_70_1 in ipairs(self:getNormalMaps()) do
		if not iter_70_1:isAnyChapterClear() then
			break
		end

		var_70_0 = iter_70_1
	end

	local var_70_1 = self:getChapterById(var_70_0.chapterIds[1])

	for iter_70_2, iter_70_3 in ipairs(var_70_0:getChapters()) do
		if not iter_70_3:isClear() then
			break
		end

		var_70_1 = iter_70_3
	end

	return var_70_1, var_70_0
end

function ChapterProxy:SortRecommendLimitation()
	table.sort(self, CompareFuncs({
		function(arg_72_0)
			if type(arg_72_0) == "number" then
				if arg_72_0 == 0 then
					return 1
				else
					return -arg_72_0
				end
			elseif type(arg_72_0) == "string" then
				return 0
			else
				assert(false)
			end

			return
		end
	}))

	return
end

function ChapterProxy:eliteFleetRecommend(arg_73_1, arg_73_2)
	local var_73_0 = {}

	for iter_73_0, iter_73_1 in ipairs(arg_73_1:getEliteFleetList()) do
		for iter_73_2, iter_73_3 in ipairs(iter_73_1) do
			var_73_0[#var_73_0 + 1] = iter_73_3
		end
	end

	local function var_73_1(arg_74_0, arg_74_1, arg_74_2, arg_74_3)
		arg_74_3 = arg_74_3 or "inElite"

		return self:FleetRecommend(arg_74_0, var_73_0, arg_74_2, arg_74_1, function(arg_75_0)
			return ShipStatus.ShipStatusCheck(arg_74_3, arg_75_0, nil, {
				[arg_74_3] = arg_73_1:getConfig("formation")
			})
		end)
	end

	local var_73_2, var_73_3 = arg_73_1:getEliteTeamByIndex(arg_73_2)

	table.insertto(var_73_2[TeamType.FormShips], switch(var_73_3, {
		[FleetType.Normal] = function()
			local var_76_0 = arg_73_1:getConfig("limitation")[arg_73_2]
			local var_76_1 = var_76_0 and Clone(var_76_0[1]) or {
				0,
				0,
				0
			}
			local var_76_2 = var_76_0 and Clone(var_76_0[2]) or {
				0,
				0,
				0
			}

			ChapterProxy.SortRecommendLimitation(var_76_1)
			ChapterProxy.SortRecommendLimitation(var_76_2)

			local var_76_3 = {}
			local var_76_4 = getProxy(BayProxy):getRawData()

			for iter_76_0, iter_76_1 in pairs({
				[TeamType.Main] = {
					var_76_1,
					ShipType.MainShipType
				},
				[TeamType.Vanguard] = {
					var_76_2,
					ShipType.VanguardShipType
				}
			}) do
				local var_76_5, var_76_6 = unpack(iter_76_1)

				table.insertto(var_76_3, var_73_1(underscore.filter(var_73_2[TeamType.FormShips], function(arg_77_0)
					return var_76_4[arg_77_0] and var_76_4[arg_77_0]:getTeamType() == iter_76_0
				end), var_76_5, var_76_6))
			end

			return var_76_3
		end,
		[FleetType.Submarine] = function()
			return var_73_1(var_73_2[TeamType.FormShips], {
				0,
				0,
				0
			}, ShipType.SubShipType)
		end,
		[FleetType.Support] = function()
			return var_73_1(var_73_2[TeamType.FormShips], arg_73_1:getConfigMiscArg("submarine_support") and {
				"qian",
				"qian",
				"qian"
			} or {
				"hang",
				"hang",
				"hang"
			}, ShipType.AllShipType, "inSupport")
		end
	}))

	return
end

function ChapterProxy:FleetRecommend(arg_80_1, arg_80_2, arg_80_3, arg_80_4, arg_80_5)
	arg_80_2 = table.shallowCopy(arg_80_2)

	local var_80_0 = getProxy(BayProxy)
	local var_80_1 = getProxy(BayProxy):getRawData()

	for iter_80_0, iter_80_1 in ipairs(arg_80_1) do
		local var_80_2 = var_80_1[iter_80_1]:getShipType()

		for iter_80_2, iter_80_3 in ipairs(arg_80_4) do
			if ShipType.ContainInLimitBundle(iter_80_3, var_80_2) then
				table.remove(arg_80_4, iter_80_2)

				break
			end
		end
	end

	local var_80_3 = {}

	local function var_80_4(arg_81_0)
		local var_81_0 = var_80_0:GetRecommendShip(underscore.filter(arg_80_3, function(arg_82_0)
			return ShipType.ContainInLimitBundle(arg_81_0, arg_82_0)
		end), arg_80_2, arg_80_5)

		if var_81_0 then
			arg_80_2[#arg_80_2 + 1] = var_81_0.id

			table.insert(var_80_3, var_81_0.id)
		end

		return
	end

	for iter_80_4, iter_80_5 in ipairs(arg_80_4) do
		var_80_4(iter_80_5)
	end

	return var_80_3
end

function ChapterProxy:isClear(arg_83_1)
	local var_83_0 = self:GetChapterItemById(arg_83_1)

	if not var_83_0 then
		return false
	end

	return var_83_0:isClear()
end

function ChapterProxy:recordLastMap(arg_84_1, arg_84_2)
	local var_84_0 = false

	if arg_84_1 == ChapterProxy.LAST_MAP_FOR_ACTIVITY and arg_84_2 ~= Map.lastMapForActivity then
		Map.lastMapForActivity = arg_84_2
		var_84_0 = true
	elseif arg_84_1 == ChapterProxy.LAST_MAP and arg_84_2 ~= Map.lastMap then
		Map.lastMap = arg_84_2
		var_84_0 = true
	end

	if var_84_0 then
		PlayerPrefs.SetInt(arg_84_1 .. getProxy(PlayerProxy):getRawData().id, arg_84_2)
		PlayerPrefs.Save()
	end

	return
end

function ChapterProxy:getLastMap(arg_85_1)
	local var_85_0 = PlayerPrefs.GetInt(arg_85_1 .. getProxy(PlayerProxy):getRawData().id)

	if var_85_0 ~= 0 then
		return var_85_0
	end

	return
end

function ChapterProxy:IsActivitySPChapterActive(arg_86_1)
	return _.any(_.reduce(self:getMapsByActivities(arg_86_1), {}, function(arg_87_0, arg_87_1)
		table.insertto(arg_87_0, _.select(arg_87_1:getChapters(), function(arg_88_0)
			return arg_88_0:IsSpChapter()
		end))

		return arg_87_0
	end), function(arg_89_0)
		return arg_89_0:isUnlock() and arg_89_0:isPlayerLVUnlock() and arg_89_0:enoughTimes2Start()
	end)
end

function ChapterProxy:getSubAidFlag(arg_90_1)
	local var_90_0 = false
	local var_90_1 = _.detect(self.fleets, function(arg_91_0)
		return arg_91_0:getFleetType() == FleetType.Submarine and arg_91_0:isValid()
	end)

	if var_90_1 then
		if var_90_1:inHuntingRange(self.fleet.line.row, self.fleet.line.column) then
			var_90_0 = true
		else
			local var_90_2 = _.detect(var_90_1:getStrategies(), function(arg_92_0)
				return arg_92_0.id == ChapterConst.StrategyCallSubOutofRange
			end)

			if var_90_2 and var_90_2.count > 0 then
				var_90_0 = true
			end
		end
	end

	if var_90_0 then
		local var_90_3, var_90_4 = self:getFleetCost(self.fleet, arg_90_1)
		local var_90_5, var_90_6 = self:getFleetAmmo(var_90_1)
		local var_90_7 = 0

		for iter_90_0, iter_90_1 in ipairs({
			self:getFleetCost(var_90_1, arg_90_1)
		}) do
			var_90_7 = var_90_7 + iter_90_1.oil
		end

		if var_90_6 <= 0 then
			return ys.Battle.BattleConst.SubAidFlag.AMMO_EMPTY
		elseif var_90_7 + var_90_4.oil >= getProxy(PlayerProxy):getRawData().oil then
			return ys.Battle.BattleConst.SubAidFlag.OIL_EMPTY
		else
			return true, var_90_1
		end
	else
		return ys.Battle.BattleConst.SubAidFlag.AID_EMPTY
	end

	return
end

function ChapterProxy:GetChapterAuraBuffs()
	local var_93_0 = {}

	for iter_93_0, iter_93_1 in ipairs(self.fleets) do
		if iter_93_1:getFleetType() ~= FleetType.Support then
			for iter_93_2, iter_93_3 in ipairs((iter_93_1:getMapAura())) do
				table.insert(var_93_0, iter_93_3)
			end
		end
	end

	return var_93_0
end

function ChapterProxy:GetChapterAidBuffs()
	local var_94_0 = {}

	for iter_94_0, iter_94_1 in ipairs(self.fleets) do
		if iter_94_1 ~= self.fleet and iter_94_1:getFleetType() ~= FleetType.Support then
			for iter_94_2, iter_94_3 in pairs((iter_94_1:getMapAid())) do
				var_94_0[iter_94_2] = iter_94_3
			end
		end
	end

	return var_94_0
end

function ChapterProxy:RecordComboHistory(arg_95_1, arg_95_2)
	if arg_95_2 ~= nil then
		self:SetExtendChapterData(arg_95_1, "comboHistoryBuffer", arg_95_2)
	else
		self:RemoveExtendChapterData(arg_95_1, "comboHistoryBuffer")
	end

	return
end

function ChapterProxy:GetComboHistory(arg_96_1)
	return self:GetExtendChapterData(arg_96_1, "comboHistoryBuffer")
end

function ChapterProxy:RecordJustClearChapters(arg_97_1, arg_97_2)
	if arg_97_2 ~= nil then
		self:SetExtendChapterData(arg_97_1, "justClearChapters", arg_97_2)
	else
		self:RemoveExtendChapterData(arg_97_1, "justClearChapters")
	end

	return
end

function ChapterProxy:GetJustClearChapters(arg_98_1)
	return self:GetExtendChapterData(arg_98_1, "justClearChapters")
end

function ChapterProxy:RecordLastDefeatedEnemy(arg_99_1, arg_99_2)
	if arg_99_2 ~= nil then
		self:SetExtendChapterData(arg_99_1, "defeatedEnemiesBuffer", arg_99_2)
	else
		self:RemoveExtendChapterData(arg_99_1, "defeatedEnemiesBuffer")
	end

	return
end

function ChapterProxy:GetLastDefeatedEnemy(arg_100_1)
	return self:GetExtendChapterData(arg_100_1, "defeatedEnemiesBuffer")
end

function ChapterProxy:ifShowRemasterTip()
	return self.remasterTip
end

function ChapterProxy:setRemasterTip(arg_102_1)
	self.remasterTip = arg_102_1

	return
end

function ChapterProxy:updateRemasterTicketsNum(arg_103_1)
	self.remasterTickets = arg_103_1

	return
end

function ChapterProxy:getRemasterTicketCost()
	return 5
end

function ChapterProxy:resetDailyCount()
	self.remasterDailyCount = 0

	return
end

function ChapterProxy:updateDailyCount()
	self.remasterDailyCount = self.remasterDailyCount + pg.gameset.reactivity_ticket_daily.key_value

	return
end

function ChapterProxy:GetSkipPrecombat()
	if self.skipPrecombat == nil then
		self.skipPrecombat = PlayerPrefs.GetInt("chapter_skip_precombat", 0)
	end

	return self.skipPrecombat > 0
end

function ChapterProxy:UpdateSkipPrecombat(arg_108_1)
	arg_108_1 = tobool(arg_108_1) and 1 or 0

	if arg_108_1 ~= self:GetSkipPrecombat() then
		PlayerPrefs.SetInt("chapter_skip_precombat", arg_108_1)

		self.skipPrecombat = arg_108_1

		self:sendNotification(ChapterProxy.CHAPTER_SKIP_PRECOMBAT_UPDATED, arg_108_1)
	end

	return
end

function ChapterProxy:GetChapterAutoFlag(arg_109_1)
	return self:GetExtendChapterData(arg_109_1, "AutoFightFlag")
end

function ChapterProxy:SetChapterAutoFlag(arg_110_1, arg_110_2, arg_110_3)
	arg_110_2 = tobool(arg_110_2)

	if arg_110_2 == (self:GetChapterAutoFlag(arg_110_1) == 1) then
		return
	end

	self:SetExtendChapterData(arg_110_1, "AutoFightFlag", arg_110_2 and 1 or 0)

	if arg_110_2 then
		self:UpdateSkipPrecombat(true)

		if AutoBotCommand.autoBotSatisfied() then
			PlayerPrefs.SetInt("autoBotIsAcitve" .. AutoBotCommand.GetAutoBotMark(), 1)
		end

		getProxy(MetaCharacterProxy):setMetaTacticsInfoOnStart()
		pg.BrightnessMgr.GetInstance():SetScreenNeverSleep(true)

		if not LOCK_BATTERY_SAVEMODE and PlayerPrefs.GetInt(AUTOFIGHT_BATTERY_SAVEMODE, 0) == 1 then
			if pg.BrightnessMgr.GetInstance():IsPermissionGranted() then
				pg.BrightnessMgr.GetInstance():EnterManualMode()

				if PlayerPrefs.GetInt(AUTOFIGHT_DOWN_FRAME, 0) == 1 then
					getProxy(SettingsProxy):RecordFrameRate()

					Application.targetFrameRate = 30
				end
			end
		end
	else
		self:StopContinuousOperation(SYSTEM_SCENARIO, arg_110_3)
		pg.BrightnessMgr.GetInstance():SetScreenNeverSleep(false)

		if not LOCK_BATTERY_SAVEMODE then
			pg.BrightnessMgr.GetInstance():ExitManualMode()
			getProxy(SettingsProxy):RestoreFrameRate()
		end
	end

	self.facade:sendNotification(ChapterProxy.CHAPTER_AUTO_FIGHT_FLAG_UPDATED, arg_110_2 and 1 or 0)
	self.facade:sendNotification(PlayerResUI.CHANGE_TOUCH_ABLE, not arg_110_2)

	return
end

function ChapterProxy:StopAutoFight(arg_111_1)
	local var_111_0 = self:getActiveChapter(true)

	if not var_111_0 then
		return
	end

	self:SetChapterAutoFlag(var_111_0.id, false, arg_111_1)

	return
end

function ChapterProxy:FinishAutoFight(arg_112_1)
	if self:GetChapterAutoFlag(arg_112_1) == 1 then
		pg.BrightnessMgr.GetInstance():SetScreenNeverSleep(false)

		if not LOCK_BATTERY_SAVEMODE then
			pg.BrightnessMgr.GetInstance():ExitManualMode()
			getProxy(SettingsProxy):RestoreFrameRate()
		end

		self.facade:sendNotification(PlayerResUI.CHANGE_TOUCH_ABLE, true)
	end

	local var_112_0 = self:GetExtendChapter(arg_112_1)

	self:RemoveExtendChapter(arg_112_1)

	return var_112_0
end

function ChapterProxy:buildRemasterInfo()
	self.remasterInfo = {}

	for iter_113_0, iter_113_1 in ipairs(pg.re_map_template.all) do
		local var_113_0 = pg.re_map_template[iter_113_1].activity_id or 0

		for iter_113_2, iter_113_3 in ipairs(pg.re_map_template[iter_113_1].drop_gain) do
			if #iter_113_3 > 0 then
				local var_113_1, var_113_2, var_113_3, var_113_4 = unpack(iter_113_3)

				self.remasterInfo[var_113_0] = defaultValue(self.remasterInfo[var_113_0], {})
				self.remasterInfo[var_113_0][var_113_1] = defaultValue(self.remasterInfo[var_113_0][var_113_1], {})
				self.remasterInfo[var_113_0][var_113_1][iter_113_2] = {
					count = 0,
					receive = false,
					max = var_113_4
				}
			end
		end
	end

	return
end

function ChapterProxy:checkRemasterInfomation()
	if not self.checkRemaster then
		self.checkRemaster = true

		self:sendNotification(GAME.CHAPTER_REMASTER_INFO_REQUEST)
	end

	return
end

function ChapterProxy:getRemasterInfo(arg_115_1, arg_115_2, arg_115_3)
	arg_115_1 = arg_115_1 or 0

	local var_115_0 = self.remasterInfo and self.remasterInfo[arg_115_1]

	if not var_115_0 then
		return nil
	end

	local var_115_1 = var_115_0[arg_115_2]

	if not var_115_0[arg_115_2] then
		return nil
	end

	if arg_115_3 then
		return var_115_1[arg_115_3]
	end

	return var_115_1
end

function ChapterProxy:addRemasterPassCount(arg_116_1, arg_116_2, arg_116_3)
	local var_116_0 = arg_116_3 or 1
	local var_116_1 = self:getRemasterInfo(arg_116_2, arg_116_1)

	if not var_116_1 then
		return
	end

	local var_116_2

	for iter_116_0, iter_116_1 in pairs(var_116_1) do
		if iter_116_1.count < iter_116_1.max then
			iter_116_1.count = iter_116_1.count + var_116_0
			var_116_2 = true
		end
	end

	if var_116_2 then
		self:sendNotification(ChapterProxy.CHAPTER_REMASTER_INFO_UPDATED)
	end

	return
end

function ChapterProxy:markRemasterPassReceive(arg_117_1, arg_117_2, arg_117_3)
	local var_117_0 = self:getRemasterInfo(arg_117_3, arg_117_1, arg_117_2)

	if not var_117_0 then
		return
	end

	if not var_117_0.receive then
		var_117_0.receive = true

		self:sendNotification(ChapterProxy.CHAPTER_REMASTER_INFO_UPDATED)
	end

	return
end

function ChapterProxy:anyRemasterAwardCanReceive()
	for iter_118_0, iter_118_1 in pairs(self.remasterInfo) do
		for iter_118_2, iter_118_3 in pairs(iter_118_1) do
			for iter_118_4, iter_118_5 in pairs(iter_118_3) do
				if not iter_118_5.receive and iter_118_5.count >= iter_118_5.max then
					return true
				end
			end
		end
	end

	return false
end

function ChapterProxy:AddActBossRewards(arg_119_1)
	self.actBossItems = self.actBossItems or {}

	table.insertto(self.actBossItems, arg_119_1)

	return
end

function ChapterProxy:PopActBossRewards()
	self.actBossItems = nil

	return self.actBossItems or {}
end

function ChapterProxy:AddBossSingleRewards(arg_121_1)
	self.bossSingleItems = self.bossSingleItems or {}

	table.insertto(self.bossSingleItems, arg_121_1)

	return
end

function ChapterProxy:PopBossSingleRewards()
	self.bossSingleItems = nil

	return self.bossSingleItems or {}
end

function ChapterProxy:WriteBackOnExitBattleResult()
	local var_123_0 = self:getActiveChapter()

	if var_123_0 then
		if var_123_0:existOni() then
			var_123_0:clearSubmarineFleet()
			self:updateChapter(var_123_0)
		elseif var_123_0:isPlayingWithBombEnemy() then
			var_123_0.fleets = {
				var_123_0.fleet
			}
			var_123_0.findex = 1

			self:updateChapter(var_123_0)
		end
	end

	return
end

function ChapterProxy:GetContinuousData(arg_124_1)
	return self.continuousData[arg_124_1]
end

function ChapterProxy:InitContinuousTime(arg_125_1, arg_125_2)
	self.continuousData[arg_125_1] = ContinuousOperationRuntimeData.New({
		system = arg_125_1,
		totalBattleTime = arg_125_2,
		battleTime = arg_125_2
	})

	return
end

function ChapterProxy:StopContinuousOperation(arg_126_1, arg_126_2)
	local var_126_0 = self:GetContinuousData(arg_126_1)

	if not var_126_0 or not var_126_0:IsActive() then
		return
	end

	if arg_126_2 == ChapterConst.AUTOFIGHT_STOP_REASON.MANUAL and arg_126_1 == SYSTEM_SCENARIO then
		pg.TipsMgr.GetInstance():ShowTips(i18n("multiple_sorties_stop"))
	end

	var_126_0:Stop(arg_126_2)

	return
end

function ChapterProxy:PopContinuousData(arg_127_1)
	self.continuousData[arg_127_1] = nil

	return self.continuousData[arg_127_1]
end

function ChapterProxy:SetLastFleetIndex(arg_128_1, arg_128_2)
	if arg_128_2 and self.lastFleetIndex then
		return
	end

	self.lastFleetIndex = arg_128_1

	return
end

function ChapterProxy:GetLastFleetIndex()
	return self.lastFleetIndex
end

function ChapterProxy:RemoveEliteFleetCommander(arg_130_1)
	local var_130_0 = {}

	for iter_130_0, iter_130_1 in ipairs(arg_130_1) do
		var_130_0[iter_130_1] = true
	end

	local var_130_1 = {}

	for iter_130_2, iter_130_3 in pairs(self.mapEliteFleetCache) do
		for iter_130_4, iter_130_5 in pairs(iter_130_3) do
			for iter_130_6, iter_130_7 in ipairs(iter_130_5) do
				for iter_130_8, iter_130_9 in ipairs(iter_130_7[TeamType.FormCommander]) do
					if var_130_0[iter_130_9] then
						iter_130_7[TeamType.FormCommander][iter_130_8] = 0
						var_130_1[iter_130_2] = true
					end
				end
			end
		end
	end

	for iter_130_10, iter_130_11 in pairs(self.data) do
		local var_130_2 = iter_130_11:getConfig("formation")

		if var_130_1[var_130_2] then
			iter_130_11:setEliteFleetList(Clone(self.mapEliteFleetCache[var_130_2]))
			self:updateChapter(iter_130_11)
		end
	end

	return
end

function ChapterProxy:GetAutoChapterId()
	local var_131_0 = getProxy(ChapterAutoProxy):GetCommissionList()

	if #var_131_0 == 0 then
		return nil
	end

	local var_131_1 = var_131_0[1]

	if var_131_0[1].type ~= ChapterAutoProxy.TYPE.SLG then
		return nil
	end

	return var_131_1.id
end

return ChapterProxy
