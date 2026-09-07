local Chapter = import(".Chapter")

function Chapter:update(arg_1_1)
	assert(arg_1_1.id == self.id, "章节ID不一致, 无法更新数据")

	self.active = true
	self.dueTime = arg_1_1.time
	self.activeTime = arg_1_1.start_time
	self.loopFlag = arg_1_1.loop_flag
	self.modelCount = arg_1_1.model_act_count
	self.roundIndex = arg_1_1.round
	self.subAutoAttack = arg_1_1.is_submarine_auto_attack
	self.barriers = 0
	self.pathFinder = OrientedPathFinding.New({}, ChapterConst.MaxRow, ChapterConst.MaxColumn)
	self.wallAssets = {}

	if self:getConfig("wall_prefab") and #self:getConfig("wall_prefab") > 0 then
		for iter_1_0, iter_1_1 in ipairs(self:getConfig("wall_prefab")) do
			self.wallAssets[iter_1_1[1] .. "_" .. iter_1_1[2]] = iter_1_1
		end
	end

	self.winConditions = {}

	local var_1_0 = self:getConfig("win_condition")

	assert(var_1_0, "Assure Chapter's WIN Conditions is not empty")

	for iter_1_2, iter_1_3 in pairs(var_1_0) do
		table.insert(self.winConditions, {
			type = iter_1_3[1],
			param = iter_1_3[2]
		})
	end

	self.loseConditions = {}

	local var_1_1 = self:getConfig("lose_condition")

	assert(var_1_1, "Assure Chapter's LOSE Conditions is not empty")

	for iter_1_4, iter_1_5 in pairs(var_1_1) do
		table.insert(self.loseConditions, {
			type = iter_1_5[1],
			param = iter_1_5[2]
		})
	end

	self.theme = ChapterTheme.New(self:getConfig("theme"))

	local var_1_2 = self:getConfig("float_items")
	local var_1_3 = self:getConfig("grids")

	self.cells = {}
	self.cellAttachments = {}

	local function var_1_4(arg_2_0)
		local var_2_0 = ChapterCell.Line2Name(arg_2_0.pos.row, arg_2_0.pos.column)

		if arg_2_0.item_type == ChapterConst.AttachStory and arg_2_0.item_data == ChapterConst.StoryTrigger then
			if self.cellAttachments[var_2_0] then
				warning("Multi Cell Attachemnts in one cell " .. arg_2_0.pos.row .. " " .. arg_2_0.pos.column)
			end

			self.cellAttachments[var_2_0] = ChapterCell.New(arg_2_0)
			arg_2_0 = {
				item_id = 0,
				item_data = 0,
				item_flag = 0,
				pos = {
					row = arg_2_0.pos.row,
					column = arg_2_0.pos.column
				},
				item_type = ChapterConst.AttachNone
			}
		end

		if not self.cells[var_2_0] or self.cells[var_2_0].attachment == ChapterConst.AttachNone then
			local var_2_1 = ChapterCell.New(arg_2_0)

			if var_2_1.attachment == ChapterConst.AttachOni_Target or var_2_1.attachment == ChapterConst.AttachOni then
				var_2_1.attachment = ChapterConst.AttachNone
			end

			local var_2_2 = _.detect(var_1_2, function(arg_3_0)
				return arg_3_0[1] == var_2_1.row and arg_3_0[2] == var_2_1.column
			end)

			if var_2_2 then
				var_2_1.item = var_2_2[3]
				var_2_1.itemOffset = Vector2(var_2_2[4], var_2_2[5])
			end

			self.cells[var_2_0] = var_2_1

			return var_2_1
		end

		return
	end

	_.each(arg_1_1.cell_list, function(arg_4_0)
		var_1_4(arg_4_0)

		return
	end)
	_.each(var_1_3, function(arg_5_0)
		(self.cells[ChapterCell.Line2Name(arg_5_0[1], arg_5_0[2])] or var_1_4({
			pos = {
				row = arg_5_0[1],
				column = arg_5_0[2]
			},
			item_type = ChapterConst.AttachNone
		})):SetWalkable(arg_5_0[3])

		return
	end)

	self.cellsCount = #underscore.values(self.cells)

	if self:IsFogStage() then
		self.fleetVisibleStore = {}
		self.cellsVisibleCount = 0

		for iter_1_6, iter_1_7 in pairs(self.cells) do
			iter_1_7:InitVisible()
		end
	end

	self.indexMin, self.indexMax = Vector2(ChapterConst.MaxRow, ChapterConst.MaxColumn), Vector2(-ChapterConst.MaxRow, -ChapterConst.MaxColumn)

	_.each(var_1_3, function(arg_6_0)
		self.indexMin.x = math.min(self.indexMin.x, arg_6_0[1])
		self.indexMin.y = math.min(self.indexMin.y, arg_6_0[2])
		self.indexMax.x = math.max(self.indexMax.x, arg_6_0[1])
		self.indexMax.y = math.max(self.indexMax.y, arg_6_0[2])

		return
	end)
	_.each(arg_1_1.cell_flag_list or {}, function(arg_7_0)
		local var_7_0 = ChapterCell.Line2Name(arg_7_0.pos.row, arg_7_0.pos.column)

		assert(self.cells[var_7_0], "Attach cellFlaglist On NIL Cell " .. var_7_0)

		if self.cells[var_7_0] then
			self.cells[var_7_0]:updateFlagList(arg_7_0)
		end

		return
	end)

	self.buff_list = {}

	if arg_1_1.buff_list then
		for iter_1_8, iter_1_9 in ipairs(arg_1_1.buff_list) do
			self.buff_list[iter_1_8] = iter_1_9
		end
	end

	self.operationBuffList = {}

	for iter_1_10, iter_1_11 in ipairs(arg_1_1.operation_buff) do
		self.operationBuffList[#self.operationBuffList + 1] = iter_1_11
	end

	local var_1_5 = self:getNpcShipByType()

	self.fleets = {}

	for iter_1_12, iter_1_13 in pairs({
		[FleetType.Normal] = arg_1_1.main_group_list,
		[FleetType.Submarine] = arg_1_1.submarine_group_list,
		[FleetType.Support] = arg_1_1.support_group_list
	}) do
		for iter_1_14, iter_1_15 in ipairs(iter_1_13) do
			local var_1_6 = ChapterFleet.New(setmetatable({
				fleetType = iter_1_12
			}, {
				__index = iter_1_15
			}), var_1_5)

			var_1_6:setup(self)
			table.insert(self.fleets, var_1_6)
		end
	end

	table.sort(self.fleets, CompareFuncs({
		function(arg_8_0)
			return arg_8_0.id
		end
	}))

	if arg_1_1.escort_list then
		for iter_1_16, iter_1_17 in ipairs(arg_1_1.escort_list) do
			self.fleets[#self.fleets + 1] = ChapterTransportFleet.New(iter_1_17, #self.fleets + 1)
		end
	end

	self.findex = 0
	self.findex = self:getNextValidIndex()

	if self.findex == 0 then
		self.findex = 1
	end

	self.champions = {}

	if arg_1_1.ai_list then
		for iter_1_18, iter_1_19 in ipairs(arg_1_1.ai_list) do
			if iter_1_19.item_flag ~= 1 then
				self:mergeChampion(ChapterChampionPackage.New(iter_1_19), true)
			end
		end
	end

	self.airDominanceStatus = nil
	self.extraFlagList = {}

	for iter_1_20, iter_1_21 in ipairs(arg_1_1.extra_flag_list) do
		table.insert(self.extraFlagList, iter_1_21)
	end

	self.defeatEnemies = arg_1_1.kill_count or 0
	self.BaseHP = arg_1_1.chapter_hp or 0
	self.orignalShipCount = arg_1_1.init_ship_count or 0
	self.combo = arg_1_1.continuous_kill_count or 0
	self.scoreHistory = {}

	for iter_1_22 = ys.Battle.BattleConst.BattleScore.D, ys.Battle.BattleConst.BattleScore.S do
		self.scoreHistory[iter_1_22] = 0
	end

	if arg_1_1.battle_statistics then
		for iter_1_23, iter_1_24 in ipairs(arg_1_1.battle_statistics) do
			self.scoreHistory[iter_1_24.id] = iter_1_24.count
		end
	end

	local var_1_7 = {}

	if arg_1_1.chapter_strategy_list then
		for iter_1_25, iter_1_26 in ipairs(arg_1_1.chapter_strategy_list) do
			var_1_7[iter_1_26.id] = iter_1_26.count
		end
	end

	self.strategies = var_1_7
	self.duties = {}

	if #arg_1_1.fleet_duties > 0 then
		_.each(arg_1_1.fleet_duties, function(arg_9_0)
			self.duties[arg_9_0.key] = arg_9_0.value

			return
		end)
	end

	self.moveStep = arg_1_1.move_step_count or 0
	self.activateAmbush = not self:isLoop() and self:GetWillActiveAmbush()

	return
end

function Chapter:retreat(arg_10_1, arg_10_2, arg_10_3)
	if arg_10_1 then
		self.todayDefeatCount = self.todayDefeatCount + 1

		self:updateTodayDefeatCount()

		if arg_10_2 == 1 and arg_10_3 and arg_10_3 > 0 then
			getProxy(ChapterAutoProxy):UpdateRecord(ChapterAutoProxy.TYPE.SLG, self.id, arg_10_3)
		end
	end

	return
end

function Chapter.CleanLevelData(arg_11_0)
	arg_11_0.active = false
	arg_11_0.loopFlag = 0
	arg_11_0.activeTime = nil
	arg_11_0.dueTime = nil
	arg_11_0.cells = nil
	arg_11_0.fleets = nil
	arg_11_0.findex = nil
	arg_11_0.champions = nil
	arg_11_0.cellAttachments = nil
	arg_11_0.round = nil
	arg_11_0.airDominanceStatus = nil
	arg_11_0.winConditions, arg_11_0.loseConditions = nil
	arg_11_0.theme = nil
	arg_11_0.buff_list = nil
	arg_11_0.operationBuffList = nil
	arg_11_0.modelCount = nil
	arg_11_0.roundIndex = nil
	arg_11_0.subAutoAttack = nil
	arg_11_0.barriers = nil
	arg_11_0.pathFinder = nil
	arg_11_0.wallAssets = nil
	arg_11_0.strategies = nil
	arg_11_0.duties = nil
	arg_11_0.indexMin, arg_11_0.indexMax = nil
	arg_11_0.extraFlagList = nil
	arg_11_0.defeatEnemies = nil
	arg_11_0.BaseHP = nil
	arg_11_0.orignalShipCount = nil
	arg_11_0.combo = nil
	arg_11_0.scoreHistory = nil

	return
end

function Chapter.__index(arg_12_0, arg_12_1)
	if arg_12_1 == "fleet" then
		local var_12_0 = rawget(arg_12_0, "fleets")

		if not var_12_0 then
			return nil
		end

		return var_12_0[rawget(arg_12_0, "findex")]
	end

	return rawget(arg_12_0, arg_12_1) or Chapter[arg_12_1]
end

function Chapter:GetActiveFleet()
	if not self.fleets then
		return nil
	end

	return self.fleets[self.findex]
end

function Chapter:getFleetById(arg_14_1)
	return _.detect(self.fleets, function(arg_15_0)
		return arg_15_0.id == arg_14_1
	end)
end

function Chapter:getChapterSupportFleet()
	return table.Find(self.fleets, function(arg_17_0, arg_17_1)
		return arg_17_1:getFleetType() == FleetType.Support
	end)
end

function Chapter:getFleetByShipVO(arg_18_1)
	local var_18_0

	for iter_18_0, iter_18_1 in ipairs(self.fleets) do
		if iter_18_1:getShip(arg_18_1.id) then
			var_18_0 = iter_18_1

			break
		end
	end

	return var_18_0
end

function Chapter:getRound()
	return self.roundIndex % 2
end

function Chapter:getRoundNum()
	return math.floor(self.roundIndex / 2)
end

function Chapter:IncreaseRound()
	self.roundIndex = self.roundIndex + 1

	return
end

function Chapter:existMoveLimit()
	return self:getConfig("is_limit_move") == 1 or self:existOni() or self:isPlayingWithBombEnemy()
end

function Chapter:getChapterCell(arg_23_1, arg_23_2)
	return Clone(self.cells[ChapterCell.Line2Name(arg_23_1, arg_23_2)])
end

function Chapter:GetRawChapterCell(arg_24_1, arg_24_2)
	return self.cells[ChapterCell.Line2Name(arg_24_1, arg_24_2)]
end

function Chapter:FilterCell(arg_25_1)
	return table.Checkout(self.cells, arg_25_1)
end

function Chapter:findChapterCell(arg_26_1, arg_26_2)
	for iter_26_0, iter_26_1 in pairs(self.cells) do
		if iter_26_1.attachment == arg_26_1 and (not arg_26_2 or iter_26_1.attachmentId == arg_26_2) then
			return iter_26_1
		end
	end

	return nil
end

function Chapter:findChapterCells(arg_27_1, arg_27_2)
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in pairs(self.cells) do
		if iter_27_1.attachment == arg_27_1 and (not arg_27_2 or iter_27_1.attachmentId == arg_27_2) then
			table.insert(var_27_0, iter_27_1)
		end
	end

	return var_27_0
end

function Chapter:GetBossCell()
	return table.Find(self.cells, function(arg_29_0, arg_29_1)
		return ChapterConst.IsBossCell(arg_29_1)
	end)
end

function Chapter:mergeChapterCell(arg_30_1, arg_30_2)
	local var_30_0 = self.cells[ChapterCell.Line2Name(arg_30_1.row, arg_30_1.column)]

	if var_30_0 then
		var_30_0.attachment = arg_30_1.attachment
		var_30_0.attachmentId = arg_30_1.attachmentId
		var_30_0.flag = arg_30_1.flag
		var_30_0.data = arg_30_1.data
		arg_30_1 = var_30_0
	end

	if not arg_30_2 and (var_30_0 == nil or var_30_0.attachment ~= arg_30_1.attachment or var_30_0.attachmentId ~= arg_30_1.attachmentId) and ChapterConst.NeedMarkAsLurk(arg_30_1) then
		arg_30_1.trait = ChapterConst.TraitLurk
	end

	if ChapterConst.IsBossCell(arg_30_1) then
		local var_30_1 = self:getChampionIndex(arg_30_1.row, arg_30_1.column)

		if var_30_1 then
			table.remove(self.champions, var_30_1)
		end
	end

	self:updateChapterCell(arg_30_1)

	return
end

function Chapter:updateChapterCell(arg_31_1)
	self.cells[ChapterCell.Line2Name(arg_31_1.row, arg_31_1.column)] = Clone(arg_31_1)

	return
end

function Chapter:clearChapterCell(arg_32_1, arg_32_2)
	local var_32_0 = self.cells[ChapterCell.Line2Name(arg_32_1, arg_32_2)]

	var_32_0.attachment = ChapterConst.AttachNone
	var_32_0.attachmentId = 0
	var_32_0.flag = ChapterConst.CellFlagActive
	var_32_0.data = 0
	var_32_0.trait = ChapterConst.TraitNone

	return
end

function Chapter:GetChapterCellAttachemnts()
	return self.cellAttachments
end

function Chapter:GetRawChapterAttachemnt(arg_34_1, arg_34_2)
	return self.cellAttachments[ChapterCell.Line2Name(arg_34_1, arg_34_2)]
end

function Chapter:getShips()
	local var_35_0 = {}

	_.each(self.fleets, function(arg_36_0)
		_.each(arg_36_0:getShips(true), function(arg_37_0)
			table.insert(var_35_0, Clone(arg_37_0))

			return
		end)

		return
	end)

	return var_35_0
end

function Chapter:getNextValidIndex()
	for iter_38_0 = self.findex + 1, #self.fleets do
		if self.fleets[iter_38_0]:getFleetType() == FleetType.Normal and self.fleets[iter_38_0]:isValid() then
			return iter_38_0
		end
	end

	for iter_38_1 = 1, self.findex - 1 do
		if self.fleets[iter_38_1]:getFleetType() == FleetType.Normal and self.fleets[iter_38_1]:isValid() then
			return iter_38_1
		end
	end

	return 0
end

function Chapter:getAmbushRate(arg_39_1, arg_39_2)
	local var_39_0 = self:getConfig("investigation_ratio")
	local var_39_1 = var_39_0 / (var_39_0 + arg_39_1:getInvestSums()) / 4
	local var_39_2 = _.detect(self:getConfig("ambush_ratio_extra"), function(arg_40_0)
		return arg_40_0[1] == arg_39_2.row and arg_40_0[2] == arg_39_2.column
	end)
	local var_39_3 = _.detect(self:getConfig("ambush_ratio_extra"), function(arg_41_0)
		return #arg_41_0 == 1
	end)
	local var_39_4 = 0.05 + var_39_1 * math.max(arg_39_1.step - 1, 0) + ((var_39_2 and var_39_2[3] / 16 or 0) + ((var_39_3 or nil) and (var_39_3[1] / 16 or 0)))

	if (var_39_2 and var_39_2[3] / 16 or 0) + ((var_39_3 or nil) and (var_39_3[1] / 16 or 0)) == 0 then
		var_39_4 = var_39_4 - arg_39_1:getEquipAmbushRateReduce()
	end

	return (math.clamp(var_39_4, 0, 1))
end

function Chapter:getAmbushDodge(arg_42_1)
	local var_42_0 = arg_42_1.line
	local var_42_1 = arg_42_1:getDodgeSums()
	local var_42_2 = var_42_1 / (var_42_1 + self:getConfig("avoid_ratio"))
	local var_42_3 = _.detect(self:getConfig("ambush_ratio_extra"), function(arg_43_0)
		return arg_43_0[1] == var_42_0.row and arg_43_0[2] == var_42_0.column
	end)

	if (var_42_3 and var_42_3[3] / 16 or 0) == 0 then
		var_42_2 = var_42_2 + arg_42_1:getEquipDodgeRateUp()
	end

	return (math.clamp(var_42_2, 0, 1))
end

function Chapter:inWartime()
	return self.dueTime and pg.TimeMgr.GetInstance():GetServerTime() < self.dueTime
end

function Chapter:inActTime()
	local var_45_0 = self:GetBindActID()

	if var_45_0 == 0 then
		return true
	end

	local var_45_1 = var_45_0 and getProxy(ActivityProxy):getActivityById(var_45_0)

	return var_45_1 and not var_45_1:isEnd()
end

function Chapter:getRemainTime()
	return (self.dueTime or nil) and (math.max(self.dueTime - pg.TimeMgr.GetInstance():GetServerTime() - 1, 0) or 0)
end

function Chapter:getStartTime()
	return math.max(self.dueTime - self:getConfig("time"), 0)
end

function Chapter:GetWillActiveAmbush()
	if not self:existAmbush() then
		return false
	end

	local var_48_0 = self:getConfig("avoid_require")

	return not _.any(self.fleets, function(arg_49_0)
		return arg_49_0:getFleetType() == FleetType.Normal and arg_49_0:getInvestSums(true) >= var_48_0
	end)
end

function Chapter:findPath(arg_50_1, arg_50_2, arg_50_3)
	local var_50_0 = {}

	for iter_50_0 = 0, ChapterConst.MaxRow - 1 do
		var_50_0[iter_50_0] = var_50_0[iter_50_0] or {}

		for iter_50_1 = 0, ChapterConst.MaxColumn - 1 do
			var_50_0[iter_50_0][iter_50_1] = var_50_0[iter_50_0][iter_50_1] or {}

			local var_50_1 = PathFinding.PrioForbidden
			local var_50_2 = ChapterConst.ForbiddenAll
			local var_50_3 = self.cells[ChapterCell.Line2Name(iter_50_0, iter_50_1)]

			if var_50_3 and var_50_3:IsWalkable() then
				var_50_1 = PathFinding.PrioNormal

				if self:considerAsObstacle(arg_50_1, var_50_3.row, var_50_3.column) then
					var_50_1 = PathFinding.PrioObstacle
				end

				var_50_2 = arg_50_1 == ChapterConst.SubjectPlayer and var_50_3.forbiddenDirections or ChapterConst.ForbiddenNone
			end

			var_50_0[iter_50_0][iter_50_1].forbiddens = var_50_2
			var_50_0[iter_50_0][iter_50_1].priority = var_50_1
		end
	end

	if arg_50_1 == ChapterConst.SubjectPlayer then
		for iter_50_2, iter_50_3 in ipairs((self:getCoastalGunArea())) do
			var_50_0[iter_50_3.row][iter_50_3.column].priority = math.max(var_50_0[iter_50_3.row][iter_50_3.column].priority, PathFinding.PrioObstacle)
		end
	end

	local var_50_4 = var_50_0[arg_50_3.row] and var_50_0[arg_50_3.row][arg_50_3.column]

	if var_50_4 then
		if self:considerAsStayPoint(arg_50_1, arg_50_3.row, arg_50_3.column) then
			var_50_4.priority = PathFinding.PrioNormal or PathFinding.PrioObstacle
		end
	end

	self.pathFinder.cells = var_50_0

	return self.pathFinder:Find(arg_50_2, arg_50_3)
end

function Chapter:FindBossPath(arg_51_1, arg_51_2)
	local var_51_0 = {}

	for iter_51_0 = 0, ChapterConst.MaxRow - 1 do
		var_51_0[iter_51_0] = var_51_0[iter_51_0] or {}

		for iter_51_1 = 0, ChapterConst.MaxColumn - 1 do
			var_51_0[iter_51_0][iter_51_1] = var_51_0[iter_51_0][iter_51_1] or {}

			local var_51_1 = PathFinding.PrioForbidden
			local var_51_2 = ChapterConst.ForbiddenAll
			local var_51_3
			local var_51_4 = self.cells[ChapterCell.Line2Name(iter_51_0, iter_51_1)]

			if var_51_4 and var_51_4:IsWalkable() then
				var_51_1 = PathFinding.PrioNormal

				if self:considerAsObstacle(ChapterConst.SubjectPlayer, var_51_4.row, var_51_4.column) then
					var_51_1 = PathFinding.PrioObstacle
				end

				local var_51_5 = self:GetEnemy(var_51_4.row, var_51_4.column)

				if var_51_5 then
					var_51_1 = PathFinding.PrioNormal
					var_51_3 = not ChapterConst.IsBossCell(var_51_5)
				end

				var_51_2 = var_51_4.forbiddenDirections
			end

			var_51_0[iter_51_0][iter_51_1].forbiddens = var_51_2
			var_51_0[iter_51_0][iter_51_1].priority = var_51_1
			var_51_0[iter_51_0][iter_51_1].isEnemy = var_51_3
		end
	end

	for iter_51_2, iter_51_3 in ipairs((self:getCoastalGunArea())) do
		var_51_0[iter_51_3.row][iter_51_3.column].priority = math.max(var_51_0[iter_51_3.row][iter_51_3.column].priority, PathFinding.PrioObstacle)
	end

	local var_51_6 = var_51_0[arg_51_2.row] and var_51_0[arg_51_2.row][arg_51_2.column]

	if var_51_6 then
		if self:considerAsStayPoint(ChapterConst.SubjectPlayer, arg_51_2.row, arg_51_2.column) then
			var_51_6.priority = PathFinding.PrioNormal or PathFinding.PrioObstacle
		end
	end

	return OrientedWeightPathFinding.StaticFind(var_51_0, ChapterConst.MaxRow, ChapterConst.MaxColumn, arg_51_1, arg_51_2)
end

function Chapter:getWaveCount()
	local var_52_0 = 0

	for iter_52_0, iter_52_1 in pairs(self.cells) do
		if iter_52_1.attachment == ChapterConst.AttachEnemy and underscore.detect(self:getConfig("grids"), function(arg_53_0)
			if arg_53_0[1] == iter_52_1.row and arg_53_0[2] == iter_52_1.column and (arg_53_0[4] == ChapterConst.AttachElite or arg_53_0[4] == ChapterConst.AttachEnemy) then
				return true
			end

			return false
		end) then
			var_52_0 = var_52_0 + 1
		end
	end

	local var_52_1 = 0

	if pg.chapter_group_refresh[self.id] then
		repeat
			local var_52_2 = false

			for iter_52_2, iter_52_3 in ipairs(pg.chapter_group_refresh[self.id].enemy_refresh) do
				var_52_1 = var_52_1 + (iter_52_3[1] or 0)
				var_52_2 = var_52_2 or tobool(iter_52_3[1])
			end

			if var_52_0 <= var_52_1 then
				return 1
			end
		until not var_52_2
	else
		local var_52_5 = self:getConfig("elite_refresh")

		for iter_52_4, iter_52_5 in pairs((self:getConfig("enemy_refresh"))) do
			var_52_1 = var_52_1 + iter_52_5

			if iter_52_4 <= #var_52_5 then
				var_52_1 = var_52_1 + var_52_5[iter_52_4]
			end

			if var_52_0 <= var_52_1 then
				return iter_52_4
			end
		end
	end

	return 1
end

function Chapter:IsFinalBossRefreshed()
	return tobool(self:findChapterCell(ChapterConst.AttachBoss))
end

function Chapter:getFleetAmmo(arg_55_1)
	local var_55_0 = arg_55_1:getShipAmmo()
	local var_55_1 = arg_55_1:getFleetType()

	if var_55_1 == FleetType.Normal then
		var_55_0 = var_55_0 + self:getConfig("ammo_total")
	elseif var_55_1 == FleetType.Submarine then
		var_55_0 = var_55_0 + self:getConfig("ammo_submarine")
	else
		assert(false, "invalide operation.")
	end

	return var_55_0, arg_55_1.restAmmo
end

function Chapter:GetInteractableStrategies()
	local var_56_0 = _.filter(self.fleet:getStrategies(), function(arg_57_0)
		return pg.strategy_data_template[arg_57_0.id] and pg.strategy_data_template[arg_57_0.id].type ~= ChapterConst.StgTypeBindFleetPassive
	end)

	table.insert(var_56_0, 1, {
		id = self.fleet:getFormationStg()
	})

	if self:GetSubmarineFleet() then
		table.insert(var_56_0, 3, {
			id = ChapterConst.StrategyHuntingRange
		})
		table.insert(var_56_0, 4, {
			id = ChapterConst.StrategySubAutoAttack
		})
		table.insert(var_56_0, 5, {
			id = ChapterConst.StrategySubTeleport
		})
	end

	local var_56_1 = self:getChapterSupportFleet()

	if var_56_1 then
		table.insertto(var_56_0, _.filter(var_56_1:getStrategies(), function(arg_58_0)
			return pg.strategy_data_template[arg_58_0.id] and pg.strategy_data_template[arg_58_0.id].type == ChapterConst.StgTypeBindSupportConsume
		end))
	end

	if #self.strategies > 0 then
		for iter_56_0, iter_56_1 in pairs(self.strategies) do
			table.insert(var_56_0, {
				id = iter_56_0,
				count = iter_56_1
			})
		end
	end

	return var_56_0
end

function Chapter:getFleetStates(arg_59_1)
	local var_59_0 = {}
	local var_59_1, var_59_2 = self:getFleetAmmo(arg_59_1)

	if var_59_2 >= ChapterConst.AmmoRich then
		table.insert(var_59_0, ChapterConst.StrategyAmmoRich)
	elseif var_59_2 <= ChapterConst.AmmoPoor then
		table.insert(var_59_0, ChapterConst.StrategyAmmoPoor)
	end

	table.insertto(var_59_0, underscore.map(underscore.filter(arg_59_1:getStrategies(), function(arg_60_0)
		return pg.strategy_data_template[arg_60_0.id] and pg.strategy_data_template[arg_60_0.id].type == ChapterConst.StgTypeBindFleetPassive and arg_60_0.count > 0
	end), function(arg_61_0)
		return arg_61_0.id
	end))
	table.insertto(var_59_0, arg_59_1.stgIds)

	for iter_59_0, iter_59_1 in ipairs((self:getConfig("chapter_strategy"))) do
		table.insert(var_59_0, iter_59_1)
	end

	if self:IsFogStage() then
		table.insert(var_59_0, self:GetFogStageStrategy())
	end

	if OPEN_AIR_DOMINANCE and self:getConfig("air_dominance") > 0 then
		table.insert(var_59_0, self:getAirDominanceStg())
	end

	for iter_59_2, iter_59_3 in ipairs(self:getExtraFlags()) do
		table.insert(var_59_0, ChapterConst.Status2Stg[iter_59_3])
	end

	local var_59_3 = self:getOperationBuffDescStg()

	if var_59_3 then
		table.insert(var_59_0, var_59_3)
	end

	underscore.each(self.buff_list, function(arg_62_0)
		if ChapterConst.Buff2Stg[arg_62_0] then
			table.insert(var_59_0, ChapterConst.Buff2Stg[arg_62_0])
		end

		return
	end)

	local var_59_4 = getProxy(ActivityProxy):getActivityById(ActivityConst.YUMIA_EXPEDITION_BUFF_ACT_ID)

	if var_59_4 and not var_59_4:isEnd() then
		local var_59_5, var_59_6 = unpack(getGameset("yumia_buff_mapping")[2])
		local var_59_7 = {}

		for iter_59_4 = 1, #var_59_5 do
			var_59_7[var_59_5[iter_59_4]] = var_59_6[iter_59_4]
		end

		local var_59_8 = underscore.filter(var_59_4:GetBuffList(), function(arg_63_0)
			return arg_63_0:isActivate() and arg_63_0:checkChaper(self.id)
		end)

		table.sort(var_59_8, CompareFuncs({
			function(arg_64_0)
				return arg_64_0.id
			end
		}))
		underscore.each(var_59_8, function(arg_65_0)
			if var_59_7[arg_65_0.id] then
				table.insert(var_59_0, var_59_7[arg_65_0.id])
			end

			return
		end)
	end

	return var_59_0
end

function Chapter:GetShowingStrategies()
	return (_.filter(self:getFleetStates(self.fleet), function(arg_67_0)
		return pg.strategy_data_template[arg_67_0] and pg.strategy_data_template[arg_67_0].icon ~= ""
	end))
end

function Chapter:getAirDominanceStg()
	local var_68_0, var_68_1 = self:getAirDominanceValue()

	return ChapterConst.AirDominance[var_68_1].StgId
end

function Chapter:getAirDominanceValue()
	local var_69_0 = 0
	local var_69_1 = 0

	for iter_69_0, iter_69_1 in pairs(self.fleets) do
		if iter_69_1:isValid() and (iter_69_1:getFleetType() == FleetType.Normal or iter_69_1:getFleetType() == FleetType.Submarine) then
			var_69_0 = var_69_0 + iter_69_1:getFleetAirDominanceValue()
			var_69_1 = var_69_1 + iter_69_1:getAntiAircraftSums()
		end
	end

	return var_69_0, calcAirDominanceStatus(var_69_0, self:getConfig("air_dominance"), var_69_1), self.airDominanceStatus
end

function Chapter.setAirDominanceStatus(arg_70_0, arg_70_1)
	arg_70_0.airDominanceStatus = arg_70_1

	return
end

function Chapter:updateExtraFlags(arg_71_1, arg_71_2)
	local var_71_0 = false

	for iter_71_0, iter_71_1 in ipairs(arg_71_2) do
		for iter_71_2, iter_71_3 in ipairs(self.extraFlagList) do
			if iter_71_3 == iter_71_1 then
				table.remove(self.extraFlagList, iter_71_2)

				var_71_0 = true

				break
			end
		end
	end

	for iter_71_4, iter_71_5 in ipairs(arg_71_1) do
		if not table.contains(self.extraFlagList, iter_71_5) then
			table.insert(self.extraFlagList, 1, iter_71_5)

			var_71_0 = true
		end
	end

	return var_71_0
end

function Chapter:getExtraFlags()
	return self.extraFlagList
end

function Chapter:UpdateBuffList(arg_73_1)
	if not arg_73_1 then
		return
	end

	for iter_73_0, iter_73_1 in ipairs(arg_73_1) do
		if not _.include(self.buff_list, iter_73_1) then
			table.insert(self.buff_list, iter_73_1)
		end
	end

	return
end

function Chapter:getFleetBattleBuffs(arg_74_1)
	local var_74_0 = table.shallowCopy(self.buff_list)

	_.each(self:getFleetStates(arg_74_1), function(arg_75_0)
		if pg.strategy_data_template[arg_75_0].buff_id == 0 then
			return
		end

		if pg.strategy_data_template[arg_75_0].buff_type == ChapterConst.StrategyBuffTypeOnlyBoss then
			local var_75_0 = self:GetEnemy(arg_74_1.line.row, arg_74_1.line.column)

			if var_75_0 and not ChapterConst.IsBossCell(var_75_0) then
				return
			end
		end

		table.insert(var_74_0, pg.strategy_data_template[arg_75_0].buff_id)

		return
	end)
	table.insertto(var_74_0, self:GetCellEventByKey("attach_buff", arg_74_1.line.row, arg_74_1.line.column) or {})
	_.each(self:GetWeather(), function(arg_76_0)
		if type(pg.weather_data_template[arg_76_0].effect_args) == "table" and pg.weather_data_template[arg_76_0].effect_args.buff and pg.weather_data_template[arg_76_0].effect_args.buff > 0 then
			table.insert(var_74_0, pg.weather_data_template[arg_76_0].effect_args.buff)
		end

		return
	end)

	return var_74_0, (self:buildBattleBuffList(arg_74_1))
end

function Chapter:GetStageFlags()
	return self:GetCellEventByKey("stage_flags", self.fleet.line.row, self.fleet.line.column) or {}
end

function Chapter:GetCellEventByKey(arg_78_1, arg_78_2, arg_78_3)
	arg_78_2 = arg_78_2 or self.fleet.line.row
	arg_78_3 = arg_78_3 or self.fleet.line.column

	local var_78_0 = self.cells[ChapterCell.Line2Name(arg_78_2, arg_78_3)]

	if not var_78_0 then
		return
	end

	return Chapter.GetEventTemplateByKey(arg_78_1, var_78_0.attachmentId)
end

function Chapter.GetEventTemplateByKey(arg_79_0, arg_79_1)
	if not pg.map_event_template[arg_79_1] then
		return
	end

	local var_79_0

	for iter_79_0, iter_79_1 in ipairs(pg.map_event_template[arg_79_1].effect) do
		if iter_79_1[1] == arg_79_0 then
			for iter_79_2 = 2, #iter_79_1 do
				var_79_0 = var_79_0 or {}

				table.insert(var_79_0, iter_79_1[iter_79_2])
			end
		end
	end

	return var_79_0
end

function Chapter:buildBattleBuffList(arg_80_1)
	local var_80_0 = {}
	local var_80_1, var_80_2 = self:triggerSkill(arg_80_1, FleetSkill.TypeBattleBuff)

	if var_80_1 and #var_80_1 > 0 then
		local var_80_3 = {}

		for iter_80_0, iter_80_1 in ipairs(var_80_1) do
			local var_80_4 = arg_80_1:findCommanderBySkillId(var_80_2[iter_80_0].id)

			var_80_3[var_80_4] = var_80_3[var_80_4] or {}

			table.insert(var_80_3[var_80_4], iter_80_1)
		end

		for iter_80_2, iter_80_3 in pairs(var_80_3) do
			table.insert(var_80_0, {
				iter_80_2,
				iter_80_3
			})
		end
	end

	for iter_80_4, iter_80_5 in pairs((arg_80_1:getCommanders())) do
		for iter_80_6, iter_80_7 in ipairs((iter_80_5:getTalents())) do
			local var_80_5 = iter_80_7:getBuffsAddition()

			if #var_80_5 > 0 then
				local var_80_6

				for iter_80_8, iter_80_9 in ipairs(var_80_0) do
					if iter_80_9[1] == iter_80_5 then
						var_80_6 = iter_80_9[2]

						break
					end
				end

				if not var_80_6 then
					var_80_6 = {}

					table.insert(var_80_0, {
						iter_80_5,
						var_80_6
					})
				end

				for iter_80_10, iter_80_11 in ipairs(var_80_5) do
					table.insert(var_80_6, iter_80_11)
				end
			end
		end
	end

	return var_80_0
end

function Chapter:updateFleetShipHp(arg_81_1, arg_81_2)
	for iter_81_0, iter_81_1 in ipairs(self.fleets) do
		iter_81_1:updateShipHp(arg_81_1, arg_81_2)

		if iter_81_1.id ~= self.fleet.id then
			iter_81_1:clearShipHpChange()
		end
	end

	return
end

function Chapter:getDragExtend()
	local var_82_0 = 99999999
	local var_82_1 = 99999999
	local var_82_2 = 0
	local var_82_3 = 0

	for iter_82_0, iter_82_1 in pairs(self.cells) do
		if var_82_0 > iter_82_1.row then
			var_82_0 = iter_82_1.row
		end

		if var_82_2 < iter_82_1.row then
			var_82_2 = iter_82_1.row
		end

		if var_82_1 > iter_82_1.column then
			var_82_1 = iter_82_1.column
		end

		if var_82_3 < iter_82_1.column then
			var_82_3 = iter_82_1.column
		end
	end

	return math.max(((var_82_3 + var_82_1) * 0.5 - var_82_1 + 1) * (self.theme.cellSize + self.theme.cellSpace).x, 0), math.max((var_82_3 - (var_82_3 + var_82_1) * 0.5 + 1) * (self.theme.cellSize + self.theme.cellSpace).x, 0), math.max(((var_82_2 + var_82_0) * 0.5 - var_82_0 + 1) * (self.theme.cellSize + self.theme.cellSpace).y, 0), (math.max((var_82_2 - (var_82_2 + var_82_0) * 0.5 + 1) * (self.theme.cellSize + self.theme.cellSpace).y, 0))
end

function Chapter:getPoisonArea(arg_83_1)
	local var_83_0 = {}

	for iter_83_0, iter_83_1 in pairs(self.cells) do
		if iter_83_1:checkHadFlag(ChapterConst.FlagPoison) then
			local var_83_1 = math.floor((iter_83_1.column - self.indexMin.y) * (self.theme.cellSize + self.theme.cellSpace).x * arg_83_1)
			local var_83_2 = math.floor((iter_83_1.row - self.indexMin.x) * (self.theme.cellSize + self.theme.cellSpace).y * arg_83_1)

			var_83_0[iter_83_0] = {
				x = var_83_1,
				y = var_83_2,
				w = math.ceil((iter_83_1.column - self.indexMin.y + 1) * (self.theme.cellSize + self.theme.cellSpace).x * arg_83_1) - var_83_1,
				h = math.ceil((iter_83_1.row - self.indexMin.x + 1) * (self.theme.cellSize + self.theme.cellSpace).y * arg_83_1) - var_83_2
			}
		end
	end

	return var_83_0
end

function Chapter:selectFleets(arg_84_1)
	local var_84_0 = Clone(arg_84_1) or {}
	local var_84_1 = getProxy(FleetProxy):GetRegularFleets()

	for iter_84_0 = #var_84_0, 1, -1 do
		if not var_84_1[var_84_0[iter_84_0]] or not var_84_1[var_84_0[iter_84_0]]:isUnlock() or var_84_1[var_84_0[iter_84_0]]:isLegalToFight() ~= true then
			table.remove(var_84_0, iter_84_0)
		end
	end

	local var_84_2 = {
		[FleetType.Normal] = _.filter(var_84_0, function(arg_85_0)
			return var_84_1[arg_85_0]:getFleetType() == FleetType.Normal
		end),
		[FleetType.Submarine] = _.filter(var_84_0, function(arg_86_0)
			return var_84_1[arg_86_0]:getFleetType() == FleetType.Submarine
		end)
	}
	local var_84_3 = self:getConfig("group_num")
	local var_84_4 = self:getConfig("submarine_num")

	for iter_84_1 = #var_84_2[FleetType.Normal], var_84_3 + 1, -1 do
		table.remove(var_84_2[FleetType.Normal], iter_84_1)
	end

	for iter_84_2 = #var_84_2[FleetType.Submarine], var_84_4 + 1, -1 do
		table.remove(var_84_2[FleetType.Submarine], iter_84_2)
	end

	for iter_84_3, iter_84_4 in pairs(var_84_2) do
		if #iter_84_4 == 0 then
			local var_84_5 = 0

			if iter_84_3 == FleetType.Normal then
				var_84_5 = var_84_3
			elseif iter_84_3 == FleetType.Submarine then
				var_84_5 = var_84_4
			end

			for iter_84_5, iter_84_6 in pairs(var_84_1) do
				if var_84_5 <= #iter_84_4 then
					break
				end

				if iter_84_6 and iter_84_6:getFleetType() == iter_84_3 and iter_84_6:isUnlock() and iter_84_6:isLegalToFight() == true then
					table.insert(iter_84_4, iter_84_5)
				end
			end
		end
	end

	local var_84_6 = {}

	for iter_84_7, iter_84_8 in ipairs(var_84_2) do
		for iter_84_9, iter_84_10 in ipairs(iter_84_8) do
			table.insert(var_84_6, iter_84_10)
		end
	end

	return var_84_6
end

function Chapter:GetDefaultFleetIndex()
	return self:selectFleets((getProxy(ChapterProxy):GetLastFleetIndex()))
end

function Chapter:getMaxColumnByRow(arg_88_1)
	local var_88_0 = -1

	for iter_88_0, iter_88_1 in pairs(self.cells) do
		if iter_88_1.row == arg_88_1 then
			var_88_0 = math.max(var_88_0, iter_88_1.column)
		end
	end

	return var_88_0
end

function Chapter:getFleet(arg_89_1, arg_89_2, arg_89_3)
	return _.detect(self.fleets, function(arg_90_0)
		return arg_90_0.line.row == arg_89_2 and arg_90_0.line.column == arg_89_3 and (not arg_89_1 or arg_90_0:getFleetType() == arg_89_1) and arg_90_0:isValid()
	end) or _.detect(self.fleets, function(arg_91_0)
		return arg_91_0.line.row == arg_89_2 and arg_91_0.line.column == arg_89_3 and (not arg_89_1 or arg_91_0:getFleetType() == arg_89_1)
	end)
end

function Chapter:getFleetIndex(arg_92_1, arg_92_2, arg_92_3)
	local var_92_0 = self:getFleet(arg_92_1, arg_92_2, arg_92_3)

	if var_92_0 then
		return table.indexof(self.fleets, var_92_0)
	end

	return
end

function Chapter:getOni()
	return _.detect(self.champions, function(arg_94_0)
		return arg_94_0.attachment == ChapterConst.AttachOni
	end)
end

function Chapter:getChampion(arg_95_1, arg_95_2)
	return (_.detect(self.champions, function(arg_96_0)
		return arg_96_0.row == arg_95_1 and arg_96_0.column == arg_95_2
	end))
end

function Chapter:getChampionIndex(arg_97_1, arg_97_2)
	local var_97_0 = self:getChampion(arg_97_1, arg_97_2)

	if not var_97_0 then
		return
	end

	return table.indexof(self.champions, var_97_0)
end

function Chapter.getChampionVisibility(arg_98_0, arg_98_1, arg_98_2, arg_98_3)
	assert(arg_98_1, "chapter champion not exist.")

	return arg_98_1.flag == ChapterConst.CellFlagActive
end

function Chapter:mergeChampion(arg_99_1, arg_99_2)
	local var_99_0 = self:getChampionIndex(arg_99_1.row, arg_99_1.column)

	if var_99_0 then
		self.champions[var_99_0] = arg_99_1

		return true
	else
		if not arg_99_2 then
			arg_99_1.trait = ChapterConst.TraitLurk
		end

		table.insert(self.champions, arg_99_1)

		return false
	end

	return
end

function Chapter:RemoveChampion(arg_100_1)
	local var_100_0 = table.indexof(self.champions, arg_100_1)

	if var_100_0 then
		table.remove(self.champions, var_100_0)
	end

	return
end

function Chapter:considerAsObstacle(arg_101_1, arg_101_2, arg_101_3)
	local var_101_0 = self:getChapterCell(arg_101_2, arg_101_3)

	if not var_101_0 or not var_101_0:IsWalkable() then
		return true
	end

	if self:existBarrier(arg_101_2, arg_101_3) then
		return true
	end

	if arg_101_1 == ChapterConst.SubjectPlayer then
		if var_101_0.flag == ChapterConst.CellFlagActive then
			if ChapterConst.IsEnemyAttach(var_101_0.attachment) then
				return true
			end

			if var_101_0.attachment == ChapterConst.AttachBox then
				assert(pg.box_data_template[var_101_0.attachmentId], "box_data_template not exist: " .. var_101_0.attachmentId)

				if pg.box_data_template[var_101_0.attachmentId].type == ChapterConst.BoxTorpedo then
					return true
				end
			end

			if var_101_0.attachment == ChapterConst.AttachStory then
				return true
			end
		end

		if self:existVisibleChampion(arg_101_2, arg_101_3) then
			return true
		end
	elseif arg_101_1 == ChapterConst.SubjectChampion and self:existFleet(FleetType.Normal, arg_101_2, arg_101_3) then
		return true
	end

	return false
end

function Chapter:considerAsStayPoint(arg_102_1, arg_102_2, arg_102_3)
	local var_102_0 = self:getChapterCell(arg_102_2, arg_102_3)

	if not var_102_0 or not var_102_0:IsWalkable() then
		return false
	end

	if self:existBarrier(arg_102_2, arg_102_3) then
		return false
	end

	if arg_102_1 == ChapterConst.SubjectPlayer then
		if var_102_0.flag == ChapterConst.CellFlagActive and var_102_0.attachment == ChapterConst.AttachStory then
			return true
		end

		if var_102_0.attachment == ChapterConst.AttachLandbase and pg.land_based_template[var_102_0.attachmentId] and pg.land_based_template[var_102_0.attachmentId].type == ChapterConst.LBHarbor then
			return false
		end

		if self:existFleet(FleetType.Normal, arg_102_2, arg_102_3) then
			return false
		end

		if self:existOni(arg_102_2, arg_102_3) then
			return false
		end

		if self:existBombEnemy(arg_102_2, arg_102_3) then
			return false
		end
	elseif arg_102_1 == ChapterConst.SubjectChampion then
		if var_102_0.flag ~= ChapterConst.CellFlagDisabled and var_102_0.attachment ~= ChapterConst.AttachNone then
			return false
		end

		local var_102_1 = self:getChampion(arg_102_2, arg_102_3)

		if var_102_1 and var_102_1.flag ~= ChapterConst.CellFlagDisabled then
			return false
		end
	end

	return true
end

function Chapter:existAny(arg_103_1, arg_103_2)
	local var_103_0 = self:getChapterCell(arg_103_1, arg_103_2)

	if var_103_0.attachment ~= ChapterConst.AttachNone and var_103_0.flag == ChapterConst.CellFlagActive then
		return true
	end

	if self:existFleet(nil, arg_103_1, arg_103_2) then
		return true
	end

	local var_103_1 = self:getChampion(arg_103_1, arg_103_2)

	if var_103_1 and var_103_1.flag ~= ChapterConst.CellFlagDisabled then
		return true
	end

	return
end

function Chapter:existBarrier(arg_104_1, arg_104_2)
	local var_104_0 = self:getChapterCell(arg_104_1, arg_104_2)

	if var_104_0.attachment == ChapterConst.AttachBox and var_104_0.flag == ChapterConst.CellFlagActive and pg.box_data_template[var_104_0.attachmentId].type == ChapterConst.BoxBarrier then
		return true
	end

	if var_104_0.attachment == ChapterConst.AttachStory and var_104_0.flag == ChapterConst.CellFlagTriggerActive and pg.map_event_template[var_104_0.attachmentId].type == ChapterConst.StoryObstacle then
		return true
	end

	local var_104_1 = self:getChampion(arg_104_1, arg_104_2)

	if var_104_1 and var_104_1.flag ~= ChapterConst.CellFlagDisabled then
		if pg.expedition_data_template[var_104_1.attachmentId] and pg.expedition_data_template[var_104_1.attachmentId].type == ChapterConst.ExpeditionTypeUnTouchable then
			return true
		end
	end

	return false
end

function Chapter:GetEnemy(arg_105_1, arg_105_2)
	local var_105_0 = self:getChapterCell(arg_105_1, arg_105_2)

	if var_105_0 and var_105_0.flag == ChapterConst.CellFlagActive and ChapterConst.IsEnemyAttach(var_105_0.attachment) then
		return var_105_0
	end

	local var_105_1 = self:getChampion(arg_105_1, arg_105_2)

	if var_105_1 and var_105_1.flag ~= ChapterConst.CellFlagDisabled then
		return var_105_1
	end

	return
end

function Chapter:existEnemy(arg_106_1, arg_106_2, arg_106_3)
	if arg_106_1 == ChapterConst.SubjectPlayer then
		local var_106_0 = self:GetEnemy(arg_106_2, arg_106_3)

		if var_106_0 then
			return true, isa(var_106_0, ChapterCell) and var_106_0.attachment or ChapterConst.AttachChampion
		end
	elseif arg_106_1 == ChapterConst.SubjectChampion and (self:existFleet(FleetType.Normal, arg_106_2, arg_106_3) or self:existFleet(FleetType.Transport, arg_106_2, arg_106_3)) then
		return true
	end

	return
end

function Chapter:existFleet(arg_107_1, arg_107_2, arg_107_3)
	if _.any(self.fleets, function(arg_108_0)
		return arg_108_0.line.row == arg_107_2 and arg_108_0.line.column == arg_107_3 and (not arg_107_1 or arg_108_0:getFleetType() == arg_107_1) and arg_108_0:isValid()
	end) then
		return true
	end

	return
end

function Chapter:existVisibleChampion(arg_109_1, arg_109_2)
	local var_109_0 = self:getChampion(arg_109_1, arg_109_2)

	return var_109_0 and self:getChampionVisibility(var_109_0)
end

function Chapter:existAlly(arg_110_1)
	return _.any(self.fleets, function(arg_111_0)
		return arg_111_0.id ~= arg_110_1.id and arg_111_0.line.row == arg_110_1.line.row and arg_111_0.line.column == arg_110_1.line.column and arg_111_0:isValid()
	end)
end

function Chapter:existOni(arg_112_1, arg_112_2)
	return _.any(self.champions, function(arg_113_0)
		return arg_113_0.attachment == ChapterConst.AttachOni and arg_113_0.flag == ChapterConst.CellFlagActive and (not arg_112_1 or arg_112_1 == arg_113_0.row) and (not arg_112_2 or arg_112_2 == arg_113_0.column)
	end)
end

function Chapter:existBombEnemy(arg_114_1, arg_114_2)
	if arg_114_1 and arg_114_2 then
		local var_114_0 = self:getChapterCell(arg_114_1, arg_114_2)

		return var_114_0.attachment == ChapterConst.AttachBomb_Enemy and var_114_0.flag == ChapterConst.CellFlagActive
	end

	for iter_114_0, iter_114_1 in pairs(self.cells) do
		if iter_114_1.attachment == ChapterConst.AttachBomb_Enemy and iter_114_1.flag == ChapterConst.CellFlagActive and (not arg_114_1 or arg_114_1 == iter_114_1.row) and (not arg_114_2 or arg_114_2 == iter_114_1.column) then
			return true
		end
	end

	return false
end

function Chapter:isPlayingWithBombEnemy()
	for iter_115_0, iter_115_1 in pairs(self.cells) do
		if iter_115_1.attachment == ChapterConst.AttachBomb_Enemy then
			return true
		end
	end

	return false
end

function Chapter:existCoastalGunNoMatterLiveOrDead()
	for iter_116_0, iter_116_1 in pairs(self.cells) do
		if iter_116_1.attachment == ChapterConst.AttachLandbase then
			assert(pg.land_based_template[iter_116_1.attachmentId], "land_based_template not exist: " .. iter_116_1.attachmentId)

			if pg.land_based_template[iter_116_1.attachmentId].type == ChapterConst.LBCoastalGun then
				return true
			end
		end
	end

	return false
end

local var_0_1 = {
	{
		1,
		0
	},
	{
		-1,
		0
	},
	{
		0,
		1
	},
	{
		0,
		-1
	}
}

function Chapter:calcWalkableCells(arg_117_1, arg_117_2, arg_117_3, arg_117_4)
	local var_117_0 = {}

	for iter_117_0 = 0, ChapterConst.MaxRow - 1 do
		var_117_0[iter_117_0] = var_117_0[iter_117_0] or {}

		for iter_117_1 = 0, ChapterConst.MaxColumn - 1 do
			local var_117_1 = self.cells[ChapterCell.Line2Name(iter_117_0, iter_117_1)]

			var_117_0[iter_117_0][iter_117_1] = var_117_1 and var_117_1:IsWalkable()
		end
	end

	local var_117_2 = {}

	if arg_117_1 == ChapterConst.SubjectPlayer then
		for iter_117_2, iter_117_3 in ipairs((self:getCoastalGunArea())) do
			var_117_2[iter_117_3.row .. "_" .. iter_117_3.column] = true
		end
	end

	local var_117_3 = {}
	local var_117_4 = self:GetRawChapterCell(arg_117_2, arg_117_3)

	if not var_117_4 then
		return var_117_3
	end

	local var_117_5 = {
		{
			step = 0,
			row = arg_117_2,
			column = arg_117_3,
			forbiddens = var_117_4.forbiddenDirections
		}
	}
	local var_117_6 = {}

	while #var_117_5 > 0 do
		local var_117_7 = table.remove(var_117_5, 1)

		table.insert(var_117_6, var_117_7)
		_.each(var_0_1, function(arg_118_0)
			local var_118_0 = {
				row = var_117_7.row + arg_118_0[1],
				column = var_117_7.column + arg_118_0[2],
				step = var_117_7.step + 1
			}
			local var_118_1 = self:GetRawChapterCell(var_118_0.row, var_118_0.column)

			if not var_118_1 then
				return
			end

			var_118_0.forbiddens = var_118_1.forbiddenDirections

			if var_118_0.step <= arg_117_4 and not OrientedPathFinding.IsDirectionForbidden(var_117_7, arg_118_0[1], arg_118_0[2]) then
				if not (_.any(var_117_5, function(arg_119_0)
					return arg_119_0.row == var_118_0.row and arg_119_0.column == var_118_0.column
				end) or _.any(var_117_6, function(arg_120_0)
					return arg_120_0.row == var_118_0.row and arg_120_0.column == var_118_0.column
				end)) and var_117_0[var_118_0.row][var_118_0.column] then
					table.insert(var_117_3, var_118_0)

					if not self:existEnemy(arg_117_1, var_118_0.row, var_118_0.column) and not self:existBarrier(var_118_0.row, var_118_0.column) and not var_117_2[var_118_0.row .. "_" .. var_118_0.column] then
						table.insert(var_117_5, var_118_0)
					end
				end
			end

			return
		end)
	end

	var_117_3 = _.filter(var_117_3, function(arg_121_0)
		return arg_121_0.row == arg_117_2 and arg_121_0.column == arg_117_3 or self:considerAsStayPoint(arg_117_1, arg_121_0.row, arg_121_0.column)
	end)

	return var_117_3
end

function Chapter:calcAreaCells(arg_122_1, arg_122_2, arg_122_3, arg_122_4)
	local var_122_0 = {}

	for iter_122_0 = 0, ChapterConst.MaxRow - 1 do
		var_122_0[iter_122_0] = var_122_0[iter_122_0] or {}

		for iter_122_1 = 0, ChapterConst.MaxColumn - 1 do
			local var_122_1 = self.cells[ChapterCell.Line2Name(iter_122_0, iter_122_1)]

			var_122_0[iter_122_0][iter_122_1] = var_122_1 and var_122_1:IsWalkable()
		end
	end

	local var_122_2 = {}
	local var_122_3 = {
		{
			step = 0,
			row = arg_122_1,
			column = arg_122_2
		}
	}
	local var_122_4 = {}

	while #var_122_3 > 0 do
		local var_122_5 = table.remove(var_122_3, 1)

		table.insert(var_122_4, var_122_5)
		_.each(var_0_1, function(arg_123_0)
			local var_123_0 = {
				row = var_122_5.row + arg_123_0[1],
				column = var_122_5.column + arg_123_0[2],
				step = var_122_5.step + 1
			}

			if var_123_0.row >= 0 and var_123_0.row < ChapterConst.MaxRow and var_123_0.column >= 0 and var_123_0.column < ChapterConst.MaxColumn and var_123_0.step <= arg_122_4 then
				if not (_.any(var_122_3, function(arg_124_0)
					return arg_124_0.row == var_123_0.row and arg_124_0.column == var_123_0.column
				end) or _.any(var_122_4, function(arg_125_0)
					return arg_125_0.row == var_123_0.row and arg_125_0.column == var_123_0.column
				end)) then
					table.insert(var_122_3, var_123_0)

					if var_122_0[var_123_0.row][var_123_0.column] and var_123_0.step >= arg_122_3 then
						table.insert(var_122_2, var_123_0)
					end
				end
			end

			return
		end)
	end

	return var_122_2
end

function Chapter:calcSquareBarrierCells(arg_126_1, arg_126_2, arg_126_3)
	local var_126_0 = {}

	for iter_126_0 = -arg_126_3, arg_126_3 do
		for iter_126_1 = -arg_126_3, arg_126_3 do
			local var_126_1 = self:getChapterCell(arg_126_1 + iter_126_0, arg_126_2 + iter_126_1)

			if var_126_1 and var_126_1:IsWalkable() and (self:existBarrier(arg_126_1 + iter_126_0, arg_126_2 + iter_126_1) or not self:existAny(arg_126_1 + iter_126_0, arg_126_2 + iter_126_1)) then
				table.insert(var_126_0, {
					row = arg_126_1 + iter_126_0,
					column = arg_126_2 + iter_126_1
				})
			end
		end
	end

	return var_126_0
end

function Chapter:checkAnyInteractive()
	local var_127_0 = self:getChapterCell(self.fleet.line.row, self.fleet.line.column)
	local var_127_1 = false

	if self.fleet:getFleetType() == FleetType.Normal then
		if self:existEnemy(ChapterConst.SubjectPlayer, var_127_0.row, var_127_0.column) then
			if self:getRound() == ChapterConst.RoundPlayer then
				var_127_1 = true
			end
		elseif var_127_0.attachment == ChapterConst.AttachAmbush or var_127_0.attachment == ChapterConst.AttachBox then
			if var_127_0.flag ~= ChapterConst.CellFlagDisabled then
				var_127_1 = true
			end
		elseif var_127_0.attachment == ChapterConst.AttachStory then
			var_127_1 = var_127_0.flag == ChapterConst.CellFlagActive
		elseif var_127_0.attachment == ChapterConst.AttachSupply and var_127_0.attachmentId > 0 then
			local var_127_2, var_127_3 = self:getFleetAmmo(self.fleet)

			if var_127_3 < var_127_2 then
				var_127_1 = true
			end
		elseif var_127_0.attachment == ChapterConst.AttachBox and var_127_0.flag ~= ChapterConst.CellFlagDisabled then
			var_127_1 = true
		end
	end

	return var_127_1
end

function Chapter.getQuadCellPic(arg_128_0, arg_128_1)
	local var_128_0

	if arg_128_1.trait == ChapterConst.TraitLurk then
		-- block empty
	elseif arg_128_1.flag == ChapterConst.CellFlagActive and ChapterConst.IsEnemyAttach(arg_128_1.attachment) and arg_128_1.flag == ChapterConst.CellFlagActive then
		var_128_0 = "cell_enemy"
	elseif arg_128_1.attachment == ChapterConst.AttachBox and arg_128_1.flag == ChapterConst.CellFlagActive then
		assert(pg.box_data_template[arg_128_1.attachmentId], "box_data_template not exist: " .. arg_128_1.attachmentId)

		if pg.box_data_template[arg_128_1.attachmentId].type == ChapterConst.BoxDrop or pg.box_data_template[arg_128_1.attachmentId].type == ChapterConst.BoxStrategy or pg.box_data_template[arg_128_1.attachmentId].type == ChapterConst.BoxSupply or pg.box_data_template[arg_128_1.attachmentId].type == ChapterConst.BoxEnemy then
			var_128_0 = "cell_box"
		elseif pg.box_data_template[arg_128_1.attachmentId].type == ChapterConst.BoxTorpedo then
			var_128_0 = "cell_enemy"
		elseif pg.box_data_template[arg_128_1.attachmentId].type == ChapterConst.BoxBarrier then
			var_128_0 = "cell_green"
		end
	elseif arg_128_1.attachment == ChapterConst.AttachStory then
		if arg_128_1.flag == ChapterConst.CellFlagTriggerActive then
			var_128_0 = pg.map_event_template[arg_128_1.attachmentId].grid_color and #pg.map_event_template[arg_128_1.attachmentId].grid_color > 0 and pg.map_event_template[arg_128_1.attachmentId].grid_color or nil
		end
	elseif arg_128_1.attachment == ChapterConst.AttachSupply and arg_128_1.attachmentId > 0 then
		var_128_0 = "cell_box"
	elseif arg_128_1.attachment == ChapterConst.AttachTransport_Target then
		var_128_0 = "cell_box"
	elseif arg_128_1.attachment == ChapterConst.AttachLandbase then
		if pg.land_based_template[arg_128_1.attachmentId] and (pg.land_based_template[arg_128_1.attachmentId].type == ChapterConst.LBHarbor or pg.land_based_template[arg_128_1.attachmentId].type == ChapterConst.LBDock) then
			var_128_0 = "cell_box"
		end
	end

	return var_128_0
end

function Chapter.getMapShip(arg_129_0, arg_129_1)
	local var_129_0

	if arg_129_1:isValid() then
		var_129_0 = _.detect(arg_129_1:getShips(false), function(arg_130_0)
			return arg_130_0.isNpc and arg_130_0.hpRant > 0
		end)

		if not var_129_0 then
			local var_129_1 = arg_129_1:getFleetType()

			if var_129_1 == FleetType.Normal then
				var_129_0 = arg_129_1:getShipsByTeam(TeamType.Main, false)[1]
			elseif var_129_1 == FleetType.Submarine then
				var_129_0 = arg_129_1:getShipsByTeam(TeamType.Submarine, false)[1]
			end
		end
	end

	return var_129_0
end

function Chapter.getStrikeAnimShip(arg_131_0, arg_131_1, arg_131_2)
	return underscore.detect(arg_131_1:getShips(false), function(arg_132_0)
		return arg_132_0:GetMapStrikeAnim() == arg_131_2
	end)
end

function Chapter:GetSubmarineFleet()
	return table.Find(self.fleets, function(arg_134_0, arg_134_1)
		return arg_134_1:getFleetType() == FleetType.Submarine and arg_134_1:isValid()
	end)
end

function Chapter:getStageCell(arg_135_1, arg_135_2)
	local var_135_0 = self:getChampion(arg_135_1, arg_135_2)

	if var_135_0 and var_135_0.flag ~= ChapterConst.CellFlagDisabled then
		return var_135_0
	end

	local var_135_1 = self:getChapterCell(arg_135_1, arg_135_2)

	if var_135_1 and var_135_1.flag ~= ChapterConst.CellFlagDisabled then
		return var_135_1
	end

	return
end

function Chapter:getStageId(arg_136_1, arg_136_2)
	local var_136_0 = self:getChampion(arg_136_1, arg_136_2)

	if var_136_0 and var_136_0.flag ~= ChapterConst.CellFlagDisabled then
		return var_136_0.id
	end

	local var_136_1 = self:getChapterCell(arg_136_1, arg_136_2)

	if var_136_1 and var_136_1.flag ~= ChapterConst.CellFlagDisabled then
		return var_136_1.attachmentId
	end

	return
end

function Chapter.getStageExtraAwards(arg_137_0)
	return
end

function Chapter:GetExtraCostRate()
	local var_138_0 = 1
	local var_138_1 = {}

	for iter_138_0, iter_138_1 in ipairs(self.operationBuffList) do
		var_138_1[#var_138_1 + 1] = pg.benefit_buff_template[iter_138_1]

		if pg.benefit_buff_template[iter_138_1].benefit_type == Chapter.OPERATION_BUFF_TYPE_COST then
			var_138_0 = var_138_0 + pg.benefit_buff_template[iter_138_1].benefit_effect * 0.01
		end
	end

	return math.max(1, var_138_0), var_138_1
end

function Chapter:getFleetCost(arg_139_1, arg_139_2)
	if self:getPlayType() == ChapterConst.TypeExtra then
		return {
			gold = 0,
			oil = 0
		}, {
			gold = 0,
			oil = 0
		}
	end

	local var_139_0, var_139_1 = arg_139_1:getCost()

	var_139_1.oil = math.clamp(self:GetLimitOilCost(arg_139_1:getFleetType() == FleetType.Submarine, arg_139_2) - var_139_0.oil, 0, var_139_1.oil)

	local var_139_2 = self:GetExtraCostRate()

	for iter_139_0, iter_139_1 in ipairs({
		var_139_0,
		var_139_1
	}) do
		for iter_139_2, iter_139_3 in pairs(iter_139_1) do
			iter_139_1[iter_139_2] = iter_139_1[iter_139_2] * var_139_2
		end
	end

	return var_139_0, var_139_1
end

function Chapter:isOverFleetCost(arg_140_1, arg_140_2)
	local var_140_0 = self:GetLimitOilCost(arg_140_1:getFleetType() == FleetType.Submarine, arg_140_2)
	local var_140_1 = 0

	for iter_140_0, iter_140_1 in ipairs({
		arg_140_1:getCost()
	}) do
		var_140_1 = var_140_1 + iter_140_1.oil
	end

	local var_140_2 = self:GetExtraCostRate()

	return var_140_0 < var_140_1, var_140_0 * var_140_2, var_140_1 * var_140_2
end

function Chapter:writeBack(arg_141_1, arg_141_2)
	local var_141_0 = self.fleet

	local function var_141_1(arg_142_0)
		if not arg_141_2.statistics[arg_142_0.id] then
			return
		end

		arg_142_0.hpRant = arg_141_2.statistics[arg_142_0.id].bp

		return
	end

	for iter_141_0, iter_141_1 in pairs(self.fleet.ships) do
		var_141_1(iter_141_1)
	end

	self.fleet:ResortShips()

	if not arg_141_2.skipAmmo then
		self.fleet.restAmmo = math.max(self.fleet.restAmmo - 1, 0)
	end

	_.each(_.filter(self.fleet:getStrategies(), function(arg_143_0)
		return pg.strategy_data_template[arg_143_0.id] and pg.strategy_data_template[arg_143_0.id].type == ChapterConst.StgTypeBindFleetPassive and arg_143_0.count > 0
	end), function(arg_144_0)
		var_141_0:consumeOneStrategy(arg_144_0.id)

		return
	end)

	if arg_141_2.statistics.submarineAid then
		local var_141_2 = self:GetSubmarineFleet()

		if var_141_2 and not var_141_2:inHuntingRange(self.fleet.line.row, self.fleet.line.column) then
			var_141_2:consumeOneStrategy(ChapterConst.StrategyCallSubOutofRange)
		end

		if var_141_2 then
			for iter_141_2, iter_141_3 in pairs(var_141_2.ships) do
				var_141_1(iter_141_3)
			end

			var_141_2.restAmmo = math.max(var_141_2.restAmmo - 1, 0)
		end
	end

	self:UpdateComboHistory(arg_141_2.statistics._battleScore)

	if arg_141_1 then
		local var_141_3
		local var_141_4
		local var_141_5 = self:getChampion(self.fleet.line.row, self.fleet.line.column)

		if var_141_5 then
			var_141_5:Iter()

			var_141_3 = var_141_5.attachment
			var_141_4 = var_141_5.attachmentId

			if var_141_5.flag == ChapterConst.CellFlagDisabled then
				self:RemoveChampion(var_141_5)
			end
		else
			local var_141_6 = self:getChapterCell(self.fleet.line.row, self.fleet.line.column)

			var_141_3 = var_141_6.attachment
			var_141_4 = var_141_6.attachmentId

			if var_141_6.attachment == ChapterConst.AttachEnemy or var_141_3 == ChapterConst.AttachBoss then
				var_141_6.flag = ChapterConst.CellFlagDisabled

				self:updateChapterCell(var_141_6)
			else
				self:clearChapterCell(var_141_6.row, var_141_6.column)
			end
		end

		assert(var_141_3, "attachment can not be nil.")

		if var_141_3 == ChapterConst.AttachEnemy or var_141_3 == ChapterConst.AttachElite or var_141_3 == ChapterConst.AttachChampion then
			if not var_141_5 or var_141_5.flag == ChapterConst.CellFlagDisabled then
				local var_141_7 = _.detect(self.achieves, function(arg_145_0)
					return arg_145_0.type == ChapterConst.AchieveType2
				end)

				if var_141_7 then
					var_141_7.count = var_141_7.count + 1
				end
			end
		elseif var_141_3 == ChapterConst.AttachBoss then
			local var_141_8 = _.detect(self.achieves, function(arg_146_0)
				return arg_146_0.type == ChapterConst.AchieveType1
			end)

			if var_141_8 then
				var_141_8.count = var_141_8.count + 1
			end
		end

		if self:CheckChapterWin() then
			pg.TrackerMgr.GetInstance():Tracking(TRACKING_KILL_BOSS)
		end

		if var_141_5 and var_141_5.flag == ChapterConst.CellFlagDisabled or (arg_141_2.system ~= SYSTEM_SCENARIO_SUB_STRIKE or false) and var_141_3 ~= ChapterConst.AttachBox then
			self.fleet.defeatEnemies = self.fleet.defeatEnemies + 1

			if var_141_3 ~= ChapterConst.AttachAmbush and self:IsFogStage() then
				self.fleet.visibleLevel = self.fleet.visibleLevel + 1

				self.fleet:UpdateVisible()
			end

			self.defeatEnemies = self.defeatEnemies + 1

			if not self:isLoop() and pg.expedition_data_template[var_141_4] and pg.expedition_data_template[var_141_4].type == ChapterConst.ExpeditionTypeMulBoss then
				local var_141_10 = self.fleet:GetStatusStrategy()

				_.each(pg.chapter_model_multistageboss[self.id].guild_buff, function(arg_147_0)
					if not table.contains(var_141_10, arg_147_0) then
						table.insert(var_141_10, arg_147_0)
					end

					return
				end)

				local var_141_11 = self:getNextValidIndex()

				if var_141_11 > 0 then
					var_141_10 = self.fleets[var_141_11]:GetStatusStrategy()

					_.each(pg.chapter_model_multistageboss[self.id].guild_buff, function(arg_148_0)
						table.removebyvalue(var_141_10, arg_148_0)

						return
					end)
				end
			end

			getProxy(ChapterProxy):RecordLastDefeatedEnemy(self.id, {
				score = arg_141_2.statistics._battleScore,
				line = {
					row = self.fleet.line.row,
					column = self.fleet.line.column
				},
				attachment = var_141_3,
				attachmentId = var_141_4
			})
		end
	end

	return
end

function Chapter:CleanCurrentEnemy()
	local var_149_0 = self:getChampion(self.fleet.line.row, self.fleet.line.column)

	if var_149_0 then
		var_149_0:Iter()

		if var_149_0.flag == ChapterConst.CellFlagDisabled then
			self:RemoveChampion(var_149_0)
		end

		return
	end

	if self:getChapterCell(self.fleet.line.row, self.fleet.line.column).attachment == ChapterConst.AttachEnemy then
		self:clearChapterCell(self.fleet.line.row, self.fleet.line.column)

		return
	end

	return
end

function Chapter:UpdateProgressAfterSkipBattle()
	self:writeBack(true, {
		skipAmmo = true,
		statistics = {
			_battleScore = ys.Battle.BattleConst.BattleScore.S
		}
	})

	return
end

function Chapter:UpdateProgressOnRetreat()
	_.each(self.achieves, function(arg_152_0)
		if arg_152_0.type == ChapterConst.AchieveType3 then
			if _.all(_.values(self.cells), function(arg_153_0)
				if arg_153_0.attachment == ChapterConst.AttachEnemy or arg_153_0.attachment == ChapterConst.AttachElite or arg_153_0.attachment == ChapterConst.AttachBox and pg.box_data_template[arg_153_0.attachmentId].type == ChapterConst.BoxEnemy then
					return arg_153_0.flag == ChapterConst.CellFlagDisabled
				end

				return true
			end) and _.all(self.champions, function(arg_154_0)
				return arg_154_0.flag == ChapterConst.CellFlagDisabled
			end) then
				arg_152_0.count = arg_152_0.count + 1
			end
		elseif arg_152_0.type == ChapterConst.AchieveType4 then
			if self.orignalShipCount <= arg_152_0.config then
				arg_152_0.count = arg_152_0.count + 1
			end
		elseif arg_152_0.type == ChapterConst.AchieveType5 then
			if not _.any(self:getShips(), function(arg_155_0)
				return arg_155_0:getShipType() == arg_152_0.config
			end) then
				arg_152_0.count = arg_152_0.count + 1
			end
		elseif arg_152_0.type == ChapterConst.AchieveType6 then
			arg_152_0.count = math.max(((self.scoreHistory[0] or 0) + (self.scoreHistory[1] or 0) <= 0 or nil) and (self.combo or 0), arg_152_0.count or 0)
		end

		return
	end)

	if self.progress == 100 then
		self.passCount = self.passCount + 1
	end

	local var_151_0 = self.progress
	local var_151_1 = math.min(self.progress + self:getConfig("progress_boss"), 100)

	self.progress = var_151_1

	if var_151_0 < 100 and var_151_1 >= 100 then
		getProxy(ChapterProxy):RecordJustClearChapters(self.id, true)
	end

	self.defeatCount = self.defeatCount + 1

	local var_151_2 = getProxy(ChapterProxy):getMapById(self:getConfig("map")):getMapType()

	if var_151_2 == Map.ELITE then
		pg.TrackerMgr.GetInstance():Tracking(TRACKING_HARD_CHAPTER, self.id)
	elseif var_151_2 == Map.SCENARIO then
		if self.progress == 100 and self.passCount == 0 then
			pg.TrackerMgr.GetInstance():Tracking(TRACKING_HIGHEST_CHAPTER, self.id)
		end

		if self.defeatCount == 1 then
			if self.id == 304 then
				pg.TrackerMgr.GetInstance():Tracking(TRACKING_FIRST_PASS_3_4)
			elseif self.id == 20 then
				pg.TrackerMgr.GetInstance():Tracking(TRACKING_FIRST_PASS_4_4)
			elseif self.id == 504 then
				pg.TrackerMgr.GetInstance():Tracking(TRACKING_FIRST_PASS_5_4)
			elseif self.id == 604 then
				pg.TrackerMgr.GetInstance():Tracking(TRACKING_FIRST_PASS_6_4)
			elseif self.id == 1204 then
				pg.TrackerMgr.GetInstance():Tracking(TRACKING_FIRST_PASS_12_4)
			elseif self.id == 21 then
				pg.TrackerMgr.GetInstance():Tracking(TRACKING_FIRST_PASS_13_1)
			elseif self.id == 22 then
				pg.TrackerMgr.GetInstance():Tracking(TRACKING_FIRST_PASS_13_2)
			elseif self.id == 23 then
				pg.TrackerMgr.GetInstance():Tracking(TRACKING_FIRST_PASS_13_3)
			elseif self.id == 24 then
				pg.TrackerMgr.GetInstance():Tracking(TRACKING_FIRST_PASS_13_4)
			end
		end
	end

	return
end

function Chapter:UpdateComboHistory(arg_156_1)
	getProxy(ChapterProxy):RecordComboHistory(self.id, {
		scoreHistory = Clone(self.scoreHistory),
		combo = Clone(self.combo)
	})

	self.scoreHistory = self.scoreHistory or {}
	self.scoreHistory[arg_156_1] = (self.scoreHistory[arg_156_1] or 0) + 1
	self.combo = arg_156_1 <= ys.Battle.BattleConst.BattleScore.C and 0 or (self.combo or 0) + 1

	return
end

function Chapter:GetWinConditions()
	return self.winConditions
end

function Chapter:GetLoseConditions()
	return self.loseConditions
end

function Chapter:CheckChapterWin()
	local var_159_0 = false

	for iter_159_0, iter_159_1 in pairs((self:GetWinConditions())) do
		if iter_159_1.type == 1 then
			local var_159_1 = 0

			_.each(self:findChapterCells(ChapterConst.AttachBoss), function(arg_160_0)
				if arg_160_0 and arg_160_0.flag == ChapterConst.CellFlagDisabled then
					var_159_1 = var_159_1 + 1
				end

				return
			end)

			var_159_0 = var_159_0 or 0 >= iter_159_1.param
		elseif iter_159_1.type == 2 then
			var_159_0 = var_159_0 or self:GetDefeatCount() >= iter_159_1.param
		elseif iter_159_1.type == 3 then
			var_159_0 = var_159_0 or self:CheckTransportState() == 1
		elseif iter_159_1.type == 4 then
			var_159_0 = var_159_0 or self:getRoundNum() > iter_159_1.param
		elseif iter_159_1.type == 5 then
			local var_159_2 = iter_159_1.param

			var_159_0 = var_159_0 or not (_.any(self.champions, function(arg_161_0)
				local var_161_0 = arg_161_0.attachmentId == var_159_2

				for iter_161_0, iter_161_1 in pairs(arg_161_0.idList) do
					var_161_0 = var_161_0 or iter_161_1 == var_159_2
				end

				return var_161_0 and arg_161_0.flag ~= ChapterConst.CellFlagDisabled
			end) or _.any(self.cells, function(arg_162_0)
				return arg_162_0.attachmentId == var_159_2 and arg_162_0.flag ~= ChapterConst.CellFlagDisabled
			end))
		elseif iter_159_1.type == 6 then
			local var_159_3 = iter_159_1.param

			var_159_0 = var_159_0 or _.any(self.fleets, function(arg_163_0)
				return arg_163_0:getFleetType() == FleetType.Normal and arg_163_0:isValid() and arg_163_0.line.row == var_159_3[1] and arg_163_0.line.column == var_159_3[2]
			end)
		end

		if var_159_0 then
			break
		end
	end

	return var_159_0, ChapterConst.ReasonVictory
end

function Chapter:CheckChapterLose()
	local var_164_0 = false
	local var_164_1 = ChapterConst.ReasonDefeat

	for iter_164_0, iter_164_1 in pairs((self:GetLoseConditions())) do
		if iter_164_1.type == 1 then
			var_164_0 = var_164_0 or not _.any(self.fleets, function(arg_165_0)
				return arg_165_0:getFleetType() == FleetType.Normal and arg_165_0:isValid()
			end)
		elseif iter_164_1.type == 2 then
			var_164_0 = var_164_0 or self.BaseHP <= 0
			var_164_1 = var_164_0 and ChapterConst.ReasonDefeatDefense or var_164_1
		end

		if var_164_0 then
			break
		end
	end

	if self:getPlayType() == ChapterConst.TypeTransport then
		var_164_0 = var_164_0 or self:CheckTransportState() == -1
	end

	return var_164_0, var_164_1
end

function Chapter:CheckChapterWillWin()
	if self:existOni() or self:isPlayingWithBombEnemy() then
		return true
	end

	if self:CheckChapterWin() then
		return true
	end

	return
end

function Chapter.triggerSkill(arg_167_0, arg_167_1, arg_167_2)
	local var_167_0 = _.filter(arg_167_1:findSkills(arg_167_2), function(arg_168_0)
		return _.any(arg_168_0:GetTriggers(), function(arg_169_0)
			return arg_169_0[1] == FleetSkill.TriggerInSubTeam and arg_169_0[2] == 1
		end) == (arg_167_1:getFleetType() == FleetType.Submarine) and _.all(arg_168_0:GetTriggers(), function(arg_170_0)
			return arg_167_0:triggerCheck(arg_167_1, arg_168_0, arg_170_0)
		end)
	end)

	return _.reduce(var_167_0, nil, function(arg_171_0, arg_171_1)
		local var_171_0 = arg_171_1:GetType()
		local var_171_1 = arg_171_1:GetArgs()

		if var_171_0 == FleetSkill.TypeMoveSpeed or var_171_0 == FleetSkill.TypeHuntingLv or var_171_0 == FleetSkill.TypeTorpedoPowerUp then
			return (arg_171_0 or 0) + var_171_1[1]
		elseif var_171_0 == FleetSkill.TypeAmbushDodge or var_171_0 == FleetSkill.TypeAirStrikeDodge then
			return math.max(arg_171_0 or 0, var_171_1[1])
		elseif var_171_0 == FleetSkill.TypeAttack or var_171_0 == FleetSkill.TypeStrategy then
			arg_171_0 = arg_171_0 or {}

			table.insert(arg_171_0, var_171_1)

			return arg_171_0
		elseif var_171_0 == FleetSkill.TypeBattleBuff then
			arg_171_0 = arg_171_0 or {}

			table.insert(arg_171_0, var_171_1[1])

			return arg_171_0
		end

		return
	end), var_167_0
end

function Chapter:triggerCheck(arg_172_1, arg_172_2, arg_172_3)
	if arg_172_3[1] == FleetSkill.TriggerDDHead then
		local var_172_0 = arg_172_1:getShipsByTeam(TeamType.Vanguard, false)

		return #var_172_0 > 0 and ShipType.IsTypeQuZhu(var_172_0[1]:getShipType())
	elseif arg_172_3[1] == FleetSkill.TriggerVanCount then
		local var_172_1 = arg_172_1:getShipsByTeam(TeamType.Vanguard, false)

		return #var_172_1 >= arg_172_3[2] and #var_172_1 <= arg_172_3[3]
	elseif arg_172_3[1] == FleetSkill.TriggerShipCount then
		local var_172_2 = _.filter(arg_172_1:getShips(false), function(arg_173_0)
			return table.contains(arg_172_3[2], arg_173_0:getShipType())
		end)

		return #var_172_2 >= arg_172_3[3] and #var_172_2 <= arg_172_3[4]
	elseif arg_172_3[1] == FleetSkill.TriggerAroundEnemy then
		local var_172_3 = {
			row = arg_172_1.line.row,
			column = arg_172_1.line.column
		}

		return _.any(_.values(self.cells), function(arg_174_0)
			local var_174_0 = self:GetEnemy(arg_174_0.row, arg_174_0.column)

			if not var_174_0 then
				return
			end

			local var_174_1 = pg.expedition_data_template[var_174_0.attachmentId]

			if not pg.expedition_data_template[var_174_0.attachmentId] then
				return
			end

			local var_174_2 = var_174_1.type

			return ManhattonDist(var_172_3, {
				row = arg_174_0.row,
				column = arg_174_0.column
			}) <= arg_172_3[2] and (type(arg_172_3[3]) == "number" and arg_172_3[3] == var_174_2 or type(arg_172_3[3]) == "table" and table.contains(arg_172_3[3], var_174_2))
		end)
	elseif arg_172_3[1] == FleetSkill.TriggerNekoPos then
		local var_172_4 = arg_172_1:findCommanderBySkillId(arg_172_2.id)

		for iter_172_0, iter_172_1 in pairs(arg_172_1:getCommanders()) do
			if var_172_4.id == iter_172_1.id and iter_172_0 == arg_172_3[2] then
				return true
			end
		end
	elseif arg_172_3[1] == FleetSkill.TriggerAroundLand then
		local var_172_5 = {
			row = arg_172_1.line.row,
			column = arg_172_1.line.column
		}

		return _.any(_.values(self.cells), function(arg_175_0)
			return not arg_175_0:IsWalkable() and ManhattonDist(var_172_5, {
				row = arg_175_0.row,
				column = arg_175_0.column
			}) <= arg_172_3[2]
		end)
	elseif arg_172_3[1] == FleetSkill.TriggerAroundCombatAlly then
		local var_172_6 = {
			row = arg_172_1.line.row,
			column = arg_172_1.line.column
		}

		return _.any(self.fleets, function(arg_176_0)
			return arg_172_1.id ~= arg_176_0.id and arg_176_0:getFleetType() == FleetType.Normal and self:existEnemy(ChapterConst.SubjectPlayer, arg_176_0.line.row, arg_176_0.line.column) and ManhattonDist(var_172_6, {
				row = arg_176_0.line.row,
				column = arg_176_0.line.column
			}) <= arg_172_3[2]
		end)
	elseif arg_172_3[1] == FleetSkill.TriggerInSubTeam then
		return true
	else
		assert(false, "invalid trigger type: " .. arg_172_3[1])
	end

	return
end

local var_0_2 = {
	{
		1,
		0
	},
	{
		-1,
		0
	},
	{
		0,
		1
	},
	{
		0,
		-1
	}
}

function Chapter:checkOniState()
	local var_177_0 = self:getOni()

	assert(var_177_0, "oni not exist.")

	if _.all(var_0_2, function(arg_178_0)
		local var_178_0 = {
			var_177_0.row + arg_178_0[1],
			var_177_0.column + arg_178_0[2]
		}

		if self:existFleet(FleetType.Normal, var_178_0[1], var_178_0[2]) then
			return true
		end

		local var_178_1 = self:getChapterCell(var_178_0[1], var_178_0[2])

		if not var_178_1 or not var_178_1:IsWalkable() then
			return true
		end

		if self:existBarrier(var_178_1.row, var_178_1.column) then
			return true
		end

		return
	end) then
		return 1
	end

	if _.any(self:getOniChapterInfo().escape_grids, function(arg_179_0)
		return arg_179_0[1] == var_177_0.row and arg_179_0[2] == var_177_0.column
	end) then
		return 2
	end

	return
end

function Chapter:onOniEnter()
	for iter_180_0, iter_180_1 in pairs(self.cells) do
		iter_180_1.attachment = ChapterConst.AttachNone
		iter_180_1.attachmentId = nil
		iter_180_1.flag = nil
		iter_180_1.data = nil
	end

	self.champions = {}
	self.modelCount = self:getOniChapterInfo().special_item
	self.roundIndex = 0

	return
end

function Chapter:onBombEnemyEnter()
	for iter_181_0, iter_181_1 in pairs(self.cells) do
		iter_181_1.attachment = ChapterConst.AttachNone
		iter_181_1.attachmentId = nil
		iter_181_1.flag = nil
		iter_181_1.data = nil
	end

	self.champions = {}
	self.modelCount = 0
	self.roundIndex = 0

	return
end

function Chapter:clearSubmarineFleet()
	for iter_182_0 = #self.fleets, 1, -1 do
		if self.fleets[iter_182_0]:getFleetType() == FleetType.Submarine then
			table.remove(self.fleets, iter_182_0)
		end
	end

	return
end

function Chapter:getSpAppearStory()
	if self:existOni() then
		for iter_183_0, iter_183_1 in ipairs(self.champions) do
			if iter_183_1.trait == ChapterConst.TraitLurk and iter_183_1.attachment == ChapterConst.AttachOni then
				local var_183_0 = iter_183_1:getConfig("appear_story")

				if var_183_0 and #var_183_0 > 0 then
					return var_183_0
				end
			end
		end
	elseif self:isPlayingWithBombEnemy() then
		for iter_183_2, iter_183_3 in pairs(self.cells) do
			if iter_183_3.attachment == ChapterConst.AttachBomb_Enemy and iter_183_3.trait == ChapterConst.TraitLurk then
				if pg.specialunit_template[iter_183_3.attachmentId].appear_story and #pg.specialunit_template[iter_183_3.attachmentId].appear_story > 0 then
					return pg.specialunit_template[iter_183_3.attachmentId].appear_story
				end
			end
		end
	end

	return
end

function Chapter:getSpAppearGuide()
	if self:existOni() then
		for iter_184_0, iter_184_1 in ipairs(self.champions) do
			if iter_184_1.trait == ChapterConst.TraitLurk and iter_184_1.attachment == ChapterConst.AttachOni then
				local var_184_0 = iter_184_1:getConfig("appear_guide")

				if var_184_0 and #var_184_0 > 0 then
					return var_184_0
				end
			end
		end
	elseif self:isPlayingWithBombEnemy() then
		for iter_184_2, iter_184_3 in pairs(self.cells) do
			if iter_184_3.attachment == ChapterConst.AttachBomb_Enemy and iter_184_3.trait == ChapterConst.TraitLurk then
				if pg.specialunit_template[iter_184_3.attachmentId].appear_guide and #pg.specialunit_template[iter_184_3.attachmentId].appear_guide > 0 then
					return pg.specialunit_template[iter_184_3.attachmentId].appear_guide
				end
			end
		end
	end

	return
end

function Chapter:CheckTransportState()
	local var_185_0 = _.detect(self.fleets, function(arg_186_0)
		return arg_186_0:getFleetType() == FleetType.Transport
	end)

	if not var_185_0 then
		return -1
	end

	local var_185_1 = self:findChapterCell(ChapterConst.AttachTransport_Target)

	assert(var_185_0, "transport fleet not exist.")
	assert(var_185_1, "transport target not exist.")

	if not var_185_0:isValid() then
		return -1
	elseif var_185_0.line.row == var_185_1.row and var_185_0.line.column == var_185_1.column and not self:existEnemy(ChapterConst.SubjectPlayer, var_185_1.row, var_185_1.column) then
		return 1
	else
		return 0
	end

	return
end

function Chapter:getCoastalGunArea()
	local var_187_0 = {}

	for iter_187_0, iter_187_1 in pairs(self.cells) do
		if iter_187_1.attachment == ChapterConst.AttachLandbase and iter_187_1.flag ~= ChapterConst.CellFlagDisabled then
			if pg.land_based_template[iter_187_1.attachmentId].type == ChapterConst.LBCoastalGun then
				local var_187_1 = {
					math.abs(pg.land_based_template[iter_187_1.attachmentId].function_args[1]),
					math.abs(pg.land_based_template[iter_187_1.attachmentId].function_args[2])
				}
				local var_187_2 = {
					Mathf.Sign(pg.land_based_template[iter_187_1.attachmentId].function_args[1]),
					Mathf.Sign(pg.land_based_template[iter_187_1.attachmentId].function_args[2])
				}

				for iter_187_2 = 1, math.max(var_187_1[1], var_187_1[2]) do
					table.insert(var_187_0, {
						row = iter_187_1.row + math.min(var_187_1[1], iter_187_2) * var_187_2[1],
						column = iter_187_1.column + math.min(var_187_1[2], iter_187_2) * var_187_2[2]
					})
				end
			end
		end
	end

	return var_187_0
end

function Chapter:GetAntiAirGunArea()
	local var_188_0 = {}
	local var_188_1 = {}

	for iter_188_0, iter_188_1 in pairs(self.cells) do
		if iter_188_1.attachment == ChapterConst.AttachLandbase and iter_188_1.flag ~= ChapterConst.CellFlagDisabled then
			if pg.land_based_template[iter_188_1.attachmentId].type == ChapterConst.LBAntiAir then
				local var_188_2 = math.abs(pg.land_based_template[iter_188_1.attachmentId].function_args[1])

				local function var_188_3(arg_189_0, arg_189_1)
					return ChapterConst.MaxColumn * arg_189_0 + arg_189_1
				end

				local var_188_4 = {}
				local var_188_5 = {}

				if var_188_2 > 0 then
					var_188_4[var_188_3(iter_188_1.row, iter_188_1.column)] = iter_188_1
				end

				while next(var_188_4) do
					local var_188_6 = next(var_188_4)

					var_188_4[var_188_6] = nil

					if var_188_2 >= math.abs(var_188_4[var_188_6].row - iter_188_1.row) and var_188_2 >= math.abs(var_188_4[var_188_6].column - iter_188_1.column) then
						var_188_5[var_188_6] = var_188_4[var_188_6]

						for iter_188_2 = 1, #var_0_2 do
							local var_188_7 = var_188_3(var_188_4[var_188_6].row + var_0_2[iter_188_2][1], var_188_4[var_188_6].column + var_0_2[iter_188_2][2])

							if not var_188_5[var_188_7] then
								var_188_4[var_188_7] = {
									row = var_188_4[var_188_6].row + var_0_2[iter_188_2][1],
									column = var_188_4[var_188_6].column + var_0_2[iter_188_2][2]
								}
							end
						end
					end
				end

				for iter_188_3, iter_188_4 in pairs(var_188_5) do
					var_188_1[iter_188_3] = iter_188_4
				end
			end
		end
	end

	for iter_188_5, iter_188_6 in pairs(var_188_1) do
		table.insert(var_188_0, iter_188_6)
	end

	return var_188_0
end

function Chapter:GetDefeatCount()
	return self.defeatEnemies
end

function Chapter:ExistDivingChampion()
	return _.any(self.champions, function(arg_192_0)
		return arg_192_0.flag == ChapterConst.CellFlagDiving
	end)
end

function Chapter:IsSkipPrecombat()
	local var_193_0 = self:isLoop()

	var_193_0 = var_193_0 and getProxy(ChapterProxy):GetSkipPrecombat()

	return var_193_0
end

function Chapter:CanActivateAutoFight()
	return pg.chapter_template_loop[self.id] and pg.chapter_template_loop[self.id].fightauto == 1 and self:isLoop() and AutoBotCommand.autoBotSatisfied() and not self:existOni() and not self:existBombEnemy()
end

function Chapter:IsAutoFight()
	local var_195_0 = self:CanActivateAutoFight()

	if var_195_0 then
		var_195_0 = getProxy(ChapterProxy):GetChapterAutoFlag(self.id) == 1
	end

	return var_195_0
end

function Chapter:getOperationBuffDescStg()
	for iter_196_0, iter_196_1 in ipairs(self.operationBuffList) do
		if pg.benefit_buff_template[iter_196_1].benefit_type == Chapter.OPERATION_BUFF_TYPE_DESC then
			return iter_196_1
		end
	end

	return
end

function Chapter:GetOperationDesc()
	local var_197_0 = ""

	for iter_197_0, iter_197_1 in ipairs(self.operationBuffList) do
		if pg.benefit_buff_template[iter_197_1].benefit_type == Chapter.OPERATION_BUFF_TYPE_DESC then
			var_197_0 = pg.benefit_buff_template[iter_197_1].desc

			break
		end
	end

	return var_197_0
end

function Chapter:GetOperationBuffList()
	return self.operationBuffList
end

function Chapter:GetAllEnemies(arg_199_1)
	local var_199_0 = {}

	for iter_199_0, iter_199_1 in pairs(self.cells) do
		if ChapterConst.IsEnemyAttach(iter_199_1.attachment) and (arg_199_1 or iter_199_1.flag ~= ChapterConst.CellFlagDisabled) then
			table.insert(var_199_0, iter_199_1)
		end
	end

	for iter_199_2, iter_199_3 in pairs(self.champions) do
		if arg_199_1 or iter_199_3.flag ~= ChapterConst.CellFlagDisabled then
			table.insert(var_199_0, iter_199_3)
		end
	end

	return var_199_0
end

function Chapter:GetFleetOfDuty(arg_200_1)
	local var_200_0

	for iter_200_0, iter_200_1 in ipairs(self.fleets) do
		if iter_200_1:isValid() and iter_200_1:getFleetType() == FleetType.Normal then
			local var_200_1 = self.duties[iter_200_1.id] or 0

			if var_200_1 == ChapterFleet.DUTY_KILLALL or var_200_1 == ChapterFleet.DUTY_KILLBOSS and tobool(arg_200_1) or var_200_1 == ChapterFleet.DUTY_CLEANPATH and not tobool(arg_200_1) then
				return iter_200_1
			end

			var_200_0 = iter_200_1
		end
	end

	return var_200_0
end

function Chapter:GetBuffOfLinkAct()
	if self:getPlayType() == ChapterConst.TypeDOALink then
		local var_201_0 = pg.gameset.doa_fever_buff.description

		return _.detect(self.buff_list, function(arg_202_0)
			return table.contains(var_201_0, arg_202_0)
		end)
	end

	return
end

function Chapter:GetAttachmentStories()
	local var_203_0 = 0
	local var_203_1

	for iter_203_0, iter_203_1 in pairs(self.cellAttachments) do
		local var_203_2 = Chapter.GetEventTemplateByKey("mult_story", iter_203_1.attachmentId)

		if var_203_2 then
			assert(not var_203_1 or table.equal(var_203_1, var_203_2[1]), "Not the same Config of Mult_story ID: " .. iter_203_1.attachmentId)

			var_203_1 = var_203_1 or var_203_2[1]

			if self.cells[iter_203_0] and self.cells[iter_203_0].flag == ChapterConst.CellFlagDisabled then
				var_203_0 = var_203_0 + 1
			end
		end
	end

	return var_203_1, var_203_0
end

function Chapter:GetWeather(arg_204_1, arg_204_2)
	arg_204_1 = arg_204_1 or self.fleet.line.row
	arg_204_2 = arg_204_2 or self.fleet.line.column

	local var_204_0 = self.cells[ChapterCell.Line2Name(arg_204_1, arg_204_2)]

	return var_204_0 and var_204_0:GetWeatherFlagList() or {}
end

function Chapter:getDisplayEnemyCount()
	local var_205_0 = 0

	local function var_205_1(arg_206_0)
		if arg_206_0.flag ~= ChapterConst.CellFlagDisabled then
			var_205_0 = var_205_0 + 1
		end

		return
	end

	local var_205_2 = {
		[ChapterConst.AttachEnemy] = var_205_1,
		[ChapterConst.AttachElite] = var_205_1,
		[ChapterConst.AttachBox] = function(arg_207_0)
			if pg.box_data_template[arg_207_0.attachmentId].type == ChapterConst.BoxEnemy then
				var_205_1(arg_207_0)
			end

			return
		end
	}

	for iter_205_0, iter_205_1 in pairs(self.cells) do
		switch(iter_205_1.attachment, var_205_2, nil, iter_205_1)
	end

	for iter_205_2, iter_205_3 in ipairs(self.champions) do
		var_205_1(iter_205_3)
	end

	return 0
end

function Chapter:getNearestEnemyCell()
	local function var_208_0(arg_209_0, arg_209_1)
		return (arg_209_0.row - arg_209_1.row) * (arg_209_0.row - arg_209_1.row) + (arg_209_0.column - arg_209_1.column) * (arg_209_0.column - arg_209_1.column)
	end

	local var_208_1

	local function var_208_2(arg_210_0)
		if arg_210_0.flag ~= ChapterConst.CellFlagDisabled and (not var_208_1 or var_208_0(self.fleet.line, arg_210_0) < var_208_0(self.fleet.line, var_208_1)) then
			var_208_1 = arg_210_0
		end

		return
	end

	local var_208_3 = {
		[ChapterConst.AttachEnemy] = var_208_2,
		[ChapterConst.AttachElite] = var_208_2,
		[ChapterConst.AttachBox] = function(arg_211_0)
			if pg.box_data_template[arg_211_0.attachmentId].type == ChapterConst.BoxEnemy then
				var_208_2(arg_211_0)
			end

			return
		end
	}

	for iter_208_0, iter_208_1 in pairs(self.cells) do
		switch(iter_208_1.attachment, var_208_3, nil, iter_208_1)
	end

	for iter_208_2, iter_208_3 in ipairs(self.champions) do
		var_208_2(iter_208_3)
	end

	return nil
end

function Chapter:GetRegularFleetIds()
	return (_.map(_.filter(self.fleets, function(arg_213_0)
		local var_213_0 = arg_213_0:getFleetType()

		return var_213_0 == FleetType.Normal or var_213_0 == FleetType.Submarine
	end), function(arg_214_0)
		return arg_214_0.fleetId
	end))
end

function Chapter:NeedSupportSubmarineStage()
	return self:IsSupportSubmarineStage() and not table.contains(self:getExtraFlags(), ChapterConst.StatusSupportSubmarineFinish)
end

function Chapter:UpdateCellsVisible(arg_216_1, arg_216_2)
	if not self:IsFogStage() then
		return
	end

	local var_216_0 = {}

	if self.fleetVisibleStore[arg_216_1.id] then
		for iter_216_0, iter_216_1 in ipairs(self.fleetVisibleStore[arg_216_1.id]) do
			var_216_0[iter_216_1] = defaultValue(var_216_0[iter_216_1], 0) - 1
		end
	end

	self.fleetVisibleStore[arg_216_1.id] = arg_216_1.isRetreat and {} or underscore(arg_216_1:GetVisibleRange(arg_216_2)):chain():map(function(arg_217_0)
		return ChapterCell.Line2Name(arg_217_0.row, arg_217_0.column)
	end):filter(function(arg_218_0)
		return tobool(self.cells[arg_218_0])
	end):value()

	for iter_216_2, iter_216_3 in ipairs(self.fleetVisibleStore[arg_216_1.id]) do
		var_216_0[iter_216_3] = defaultValue(var_216_0[iter_216_3], 0) + 1
	end

	local var_216_1 = {}

	for iter_216_4, iter_216_5 in pairs(var_216_0) do
		local var_216_2 = self.cells[iter_216_4]:IsVisible()

		if iter_216_5 < 0 then
			self.cells[iter_216_4]:UpdateVisible(arg_216_1.id, false)
		elseif iter_216_5 > 0 then
			self.cells[iter_216_4]:UpdateVisible(arg_216_1.id, true)
		end

		if var_216_2 ~= self.cells[iter_216_4]:IsVisible() then
			self.cellsVisibleCount = self.cellsVisibleCount + (var_216_2 and -1 or 1)

			table.insert(var_216_1, iter_216_4)
		end
	end

	return var_216_1
end

function Chapter:GetFogStageStrategy()
	local var_219_0

	for iter_219_0, iter_219_1 in ipairs(self:getConfigMiscArg("fog_visible_buff")) do
		local var_219_1, var_219_2 = unpack(iter_219_1)

		var_219_0 = var_219_2

		if self.cellsVisibleCount * 100 / self.cellsCount <= var_219_1 then
			break
		end
	end

	return var_219_0
end

function Chapter:retreatFleet(arg_220_1)
	local var_220_0

	for iter_220_0, iter_220_1 in ipairs(self.fleets) do
		if iter_220_1.id == arg_220_1 then
			var_220_0 = table.remove(self.fleets, iter_220_0)

			break
		end
	end

	if var_220_0 and var_220_0:getFleetType() == FleetType.Normal then
		self.findex = 1
	end

	var_220_0.isRetreat = true

	var_220_0:UpdateVisible()

	return
end

return Chapter
