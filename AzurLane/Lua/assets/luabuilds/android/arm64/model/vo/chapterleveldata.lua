import = var_0_10000

local var_0_0 = var_0_10000(".Chapter")

function var_0_0.update(arg_1_0, arg_1_1)
	assert = var_1_10002

	var_1_10002(arg_1_1.id == arg_1_0.id, "章节ID不一致, 无法更新数据")

	arg_1_0.active = true
	arg_1_0.dueTime = arg_1_1.time
	arg_1_0.loopFlag = arg_1_1.loop_flag
	arg_1_0.modelCount = arg_1_1.model_act_count
	arg_1_0.roundIndex = arg_1_1.round
	arg_1_0.subAutoAttack = arg_1_1.is_submarine_auto_attack
	arg_1_0.barriers = 0
	OrientedPathFinding = var_2

	local var_1_0 = var_2.New
	local var_1_1 = {}

	ChapterConst = var_5

	local var_1_2 = var_5.MaxRow

	ChapterConst = var_1_10006
	arg_1_0.pathFinder = var_1_0(var_1_1, var_1_2, var_1_10006.MaxColumn)
	arg_1_0.wallAssets = {}

	if arg_1_0:getConfig("wall_prefab") then
		local var_1_3 = #arg_1_0:getConfig("wall_prefab")

		if 0 < var_1_3 then
			ipairs = var_1_3

			for iter_1_0, iter_1_1 in var_1_3(arg_1_0:getConfig("wall_prefab")) do
				arg_1_0.wallAssets[iter_1_1[1] .. "_" .. iter_1_1[2]] = iter_1_1
			end
		end
	end

	arg_1_0.winConditions = {}

	local var_1_4 = arg_1_0:getConfig("win_condition")

	assert = var_1_10003

	var_1_10003(var_1_4, "Assure Chapter's WIN Conditions is not empty")

	pairs = var_1_10003

	for iter_1_2, iter_1_3 in var_1_10003(var_1_4) do
		table = var_1_10008

		var_1_10008.insert(arg_1_0.winConditions, {
			type = iter_1_3[1],
			param = iter_1_3[2]
		})
	end

	arg_1_0.loseConditions = {}

	local var_1_5 = arg_1_0:getConfig("lose_condition")

	assert = var_4

	var_4(var_1_5, "Assure Chapter's LOSE Conditions is not empty")

	pairs = var_4

	for iter_1_4, iter_1_5 in var_4(var_1_5) do
		table = var_1_10009

		var_1_10009.insert(arg_1_0.loseConditions, {
			type = iter_1_5[1],
			param = iter_1_5[2]
		})
	end

	ChapterTheme = var_4
	arg_1_0.theme = var_4.New(arg_1_0:getConfig("theme"))

	local var_1_6 = arg_1_1.cell_list
	local var_1_7 = arg_1_1.cell_flag_list
	local var_1_8 = arg_1_0:getConfig("float_items")
	local var_1_9 = arg_1_0
	local var_1_10 = arg_1_0.getConfig(var_1_9, "grids")

	arg_1_0.cells = {}
	arg_1_0.cellAttachments = {}

	local function var_1_11(arg_2_0)
		ChapterCell = var_2_10001

		local var_2_0 = var_2_10001.Line2Name(arg_2_0.pos.row, arg_2_0.pos.column)
		local var_2_1 = arg_2_0.item_type

		ChapterConst = var_3

		if var_2_1 == var_3.AttachStory then
			local var_2_2 = arg_2_0.item_data

			ChapterConst = var_3

			if var_2_2 == var_3.StoryTrigger then
				if arg_1_0.cellAttachments[var_2_0] then
					warning = var_2

					var_2("Multi Cell Attachemnts in one cell " .. arg_2_0.pos.row .. " " .. arg_2_0.pos.column)
				end

				local var_2_3 = arg_1_0.cellAttachments

				ChapterCell = var_3
				var_2_3[var_2_0] = var_3.New(arg_2_0)

				local var_2_4 = {
					item_id = 0,
					item_data = 0,
					item_flag = 0,
					pos = {
						row = arg_2_0.pos.row,
						column = arg_2_0.pos.column
					}
				}

				ChapterConst = var_3
				var_2_4.item_type = var_3.AttachNone
				arg_2_0 = var_2_4
			end
		end

		if arg_1_0.cells[var_2_0] then
			local var_2_5 = arg_1_0.cells[var_2_0].attachment

			ChapterConst = var_3

			if var_2_5 == var_3.AttachNone then
				ChapterCell = var_2_5

				local var_2_6 = var_2_5.New(arg_2_0).attachment

				ChapterConst = var_4

				if var_2_6 ~= var_4.AttachOni_Target then
					var_2_6 = var_2.attachment
					ChapterConst = var_4

					if var_2_6 == var_4.AttachOni then
						ChapterConst = var_2_6
						var_2.attachment = var_2_6.AttachNone
					end

					_ = var_2_6

					if var_2_6.detect(var_1_8, function(arg_3_0)
						return arg_3_0[1] == var_0.row and arg_3_0[2] == var_0.column
					end) then
						var_2.item = var_3[3]
						Vector2 = var_4
						var_2.itemOffset = var_4(var_3[4], var_3[5])
					end

					arg_1_0.cells[var_2_0] = var_2

					do return var_2 end
					return
				end
			end
		end
	end

	_ = var_1_9

	var_1_9.each(var_1_6, function(arg_4_0)
		var_1_11(arg_4_0)

		return
	end)

	_ = var_9

	var_9.each(var_1_10, function(arg_5_0)
		ChapterCell = var_2_10001

		local var_5_0 = var_2_10001.Line2Name(arg_5_0[1], arg_5_0[2])
		local var_5_3

		if not arg_1_0.cells[var_5_0] then
			local var_5_1 = var_1_11
			local var_5_2 = {
				pos = {
					row = arg_5_0[1],
					column = arg_5_0[2]
				}
			}

			ChapterConst = var_6
			var_5_2.item_type = var_6.AttachNone
			var_5_3 = var_5_1(var_5_2)
		end

		var_5_3:SetWalkable(arg_5_0[3])

		return
	end)

	underscore = var_9
	arg_1_0.cellsCount = #var_9.values(arg_1_0.cells)

	local var_1_12 = arg_1_0

	if arg_1_0.IsFogStage(var_1_12) then
		arg_1_0.fleetVisibleStore = {}
		arg_1_0.cellsVisibleCount = 0
		pairs = var_9

		for iter_1_6, iter_1_7 in var_9(arg_1_0.cells) do
			iter_1_7:InitVisible()
		end
	end

	Vector2 = var_9
	ChapterConst = var_1_12

	local var_1_13 = var_1_12.MaxRow

	ChapterConst = iter_1_6

	local var_1_14 = var_9(var_1_13, iter_1_6.MaxColumn)

	Vector2 = var_10
	ChapterConst = var_12

	local var_1_15 = -var_12.MaxRow

	ChapterConst = iter_1_7
	arg_1_0.indexMax = var_10(var_1_15, -iter_1_7.MaxColumn)
	arg_1_0.indexMin = var_1_14
	_ = var_1_14

	var_1_14.each(var_1_10, function(arg_6_0)
		local var_6_0 = arg_1_0.indexMin

		math = var_2_10002
		var_6_0.x = var_2_10002.min(arg_1_0.indexMin.x, arg_6_0[1])

		local var_6_1 = arg_1_0.indexMin

		math = var_2
		var_6_1.y = var_2.min(arg_1_0.indexMin.y, arg_6_0[2])

		local var_6_2 = arg_1_0.indexMax

		math = var_2
		var_6_2.x = var_2.max(arg_1_0.indexMax.x, arg_6_0[1])

		local var_6_3 = arg_1_0.indexMax

		math = var_2
		var_6_3.y = var_2.max(arg_1_0.indexMax.y, arg_6_0[2])

		return
	end)

	_ = var_9

	var_9.each(var_1_7 or {}, function(arg_7_0)
		ChapterCell = var_2_10001

		local var_7_0 = var_2_10001.Line2Name(arg_7_0.pos.row, arg_7_0.pos.column)
		local var_7_1 = arg_1_0.cells[var_7_0]

		assert = var_3

		var_3(var_7_1, "Attach cellFlaglist On NIL Cell " .. var_7_0)

		if var_7_1 then
			var_7_1:updateFlagList(arg_7_0)
		end

		return
	end)

	arg_1_0.buff_list = {}

	if arg_1_1.buff_list then
		ipairs = var_9

		for iter_1_8, iter_1_9 in var_9(arg_1_1.buff_list) do
			arg_1_0.buff_list[iter_1_8] = iter_1_9
		end
	end

	arg_1_0.operationBuffList = {}
	ipairs = var_9

	for iter_1_10, iter_1_11 in var_9(arg_1_1.operation_buff) do
		arg_1_0.operationBuffList[#arg_1_0.operationBuffList + 1] = iter_1_11
	end

	local var_1_16 = arg_1_0:getNpcShipByType()

	arg_1_0.fleets = {}
	pairs = var_10

	local var_1_17 = {}

	FleetType = iter_1_11
	var_1_17[iter_1_11.Normal] = arg_1_1.main_group_list
	FleetType = var_13
	var_1_17[var_13.Submarine] = arg_1_1.submarine_group_list
	FleetType = var_13
	var_1_17[var_13.Support] = arg_1_1.support_group_list

	for iter_1_12, iter_1_13 in var_10(var_1_17) do
		ipairs = var_1_10015

		for iter_1_14, iter_1_15 in var_1_10015(iter_1_13) do
			ChapterFleet = var_1_10020
			var_1_10020 = var_1_10020.New
			setmetatable = var_1_10022

			local var_1_18 = var_1_10020(var_1_10022({
				fleetType = iter_1_12
			}, {
				__index = iter_1_15
			}), var_1_16)

			var_1_10020.setup(var_1_18, arg_1_0)

			table = var_21

			var_21.insert(arg_1_0.fleets, var_1_10020)
		end
	end

	table = var_10

	local var_1_19 = var_10.sort
	local var_1_20 = arg_1_0.fleets

	CompareFuncs = iter_1_12

	var_1_19(var_1_20, iter_1_12({
		function(arg_8_0)
			return arg_8_0.id
		end
	}))

	if arg_1_1.escort_list then
		ipairs = var_10

		for iter_1_16, iter_1_17 in var_10(arg_1_1.escort_list) do
			local var_1_21 = arg_1_0.fleets
			local var_1_22 = #arg_1_0.fleets + 1

			ChapterTransportFleet = var_1_10017
			var_1_21[var_1_22] = var_1_10017.New(iter_1_17, #arg_1_0.fleets + 1)
		end
	end

	arg_1_0.findex = 0
	arg_1_0.findex = arg_1_0:getNextValidIndex()

	if arg_1_0.findex == 0 then
		arg_1_0.findex = 1
	end

	arg_1_0.champions = {}

	if arg_1_1.ai_list then
		ipairs = var_10

		for iter_1_18, iter_1_19 in var_10(arg_1_1.ai_list) do
			if iter_1_19.item_flag ~= 1 then
				ChapterChampionPackage = var_1_21
				var_1_21 = var_1_21.New(iter_1_19)

				arg_1_0:mergeChampion(var_1_21, true)
			end
		end
	end

	arg_1_0.airDominanceStatus = nil
	arg_1_0.extraFlagList = {}
	ipairs = var_10

	for iter_1_20, iter_1_21 in var_10(arg_1_1.extra_flag_list) do
		table = var_1_21

		var_1_21.insert(arg_1_0.extraFlagList, iter_1_21)
	end

	local var_1_23

	if not arg_1_1.kill_count then
		var_1_23 = 0
	end

	arg_1_0.defeatEnemies = var_1_23

	local var_1_24

	if not arg_1_1.chapter_hp then
		var_1_24 = 0
	end

	arg_1_0.BaseHP = var_1_24

	local var_1_25

	if not arg_1_1.init_ship_count then
		var_1_25 = 0
	end

	arg_1_0.orignalShipCount = var_1_25

	local var_1_26

	if not arg_1_1.continuous_kill_count then
		var_1_26 = 0
	end

	arg_1_0.combo = var_1_26
	arg_1_0.scoreHistory = {}
	ys = var_10

	local var_1_27 = var_10.Battle.BattleConst.BattleScore.D

	ys = var_11

	for iter_1_22 = var_1_27, var_11.Battle.BattleConst.BattleScore.S do
		arg_1_0.scoreHistory[iter_1_22] = 0
	end

	if arg_1_1.battle_statistics then
		ipairs = var_10

		for iter_1_23, iter_1_24 in var_10(arg_1_1.battle_statistics) do
			arg_1_0.scoreHistory[iter_1_24.id] = iter_1_24.count
		end
	end

	local var_1_28 = {}

	if arg_1_1.chapter_strategy_list then
		ipairs = var_11

		for iter_1_25, iter_1_26 in var_11(arg_1_1.chapter_strategy_list) do
			var_1_28[iter_1_26.id] = iter_1_26.count
		end
	end

	arg_1_0.strategies = var_1_28
	arg_1_0.duties = {}

	if #arg_1_1.fleet_duties > 0 then
		_ = var_11

		var_11.each(arg_1_1.fleet_duties, function(arg_9_0)
			arg_1_0.duties[arg_9_0.key] = arg_9_0.value

			return
		end)
	end

	local var_1_29

	if not arg_1_1.move_step_count then
		var_1_29 = 0
	end

	arg_1_0.moveStep = var_1_29
	arg_1_0.activateAmbush = not arg_1_0:isLoop() and arg_1_0:GetWillActiveAmbush()

	return
end

function var_0_0.retreat(arg_10_0, arg_10_1)
	if arg_10_1 then
		arg_10_0.todayDefeatCount = arg_10_0.todayDefeatCount + 1

		arg_10_0:updateTodayDefeatCount()
	end

	return
end

function var_0_0.CleanLevelData(arg_11_0)
	arg_11_0.active = false
	arg_11_0.loopFlag = 0
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

function var_0_0.__index(arg_12_0, arg_12_1)
	if arg_12_1 == "fleet" then
		rawget = var_1_10002

		if not var_1_10002(arg_12_0, "fleets") then
			return nil
		end

		rawget = var_1_10003

		return var_1_10002[var_1_10003(arg_12_0, "findex")]
	end

	rawget = var_1_10002

	local var_12_0

	if not var_1_10002(arg_12_0, arg_12_1) then
		var_12_0 = var_0_0[arg_12_1]
	end

	return var_12_0
end

function var_0_0.GetActiveFleet(arg_13_0)
	if not arg_13_0.fleets then
		return nil
	end

	return arg_13_0.fleets[arg_13_0.findex]
end

function var_0_0.getFleetById(arg_14_0, arg_14_1)
	_ = var_1_10002

	return var_1_10002.detect(arg_14_0.fleets, function(arg_15_0)
		return arg_15_0.id == arg_14_1
	end)
end

function var_0_0.getChapterSupportFleet(arg_16_0)
	table = var_1_10001

	return var_1_10001.Find(arg_16_0.fleets, function(arg_17_0, arg_17_1)
		local var_17_0 = arg_17_1:getFleetType()

		FleetType = var_2_10003

		return var_17_0 == var_2_10003.Support
	end)
end

function var_0_0.getFleetByShipVO(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1.id
	local var_18_1

	ipairs = var_1_10004

	for iter_18_0, iter_18_1 in var_1_10004(arg_18_0.fleets) do
		if iter_18_1:getShip(var_18_0) then
			var_18_1 = iter_18_1

			break
		end
	end

	return var_18_1
end

function var_0_0.getRound(arg_19_0)
	return arg_19_0.roundIndex % 2
end

function var_0_0.getRoundNum(arg_20_0)
	math = var_1_10001

	return var_1_10001.floor(arg_20_0.roundIndex / 2)
end

function var_0_0.IncreaseRound(arg_21_0)
	arg_21_0.roundIndex = arg_21_0.roundIndex + 1

	return
end

function var_0_0.existMoveLimit(arg_22_0)
	if arg_22_0:getConfig("is_limit_move") ~= 1 then
		if not arg_22_0:existOni() then
			local var_22_0 = arg_22_0:isPlayingWithBombEnemy()
		end

		if false then
			var_22_0 = false
		end
	else
		var_22_0 = true
	end

	return var_22_0
end

function var_0_0.getChapterCell(arg_23_0, arg_23_1, arg_23_2)
	ChapterCell = var_1_10003

	local var_23_0 = var_1_10003.Line2Name(arg_23_1, arg_23_2)

	Clone = var_1_10004

	return var_1_10004(arg_23_0.cells[var_23_0])
end

function var_0_0.GetRawChapterCell(arg_24_0, arg_24_1, arg_24_2)
	ChapterCell = var_1_10003

	local var_24_0 = var_1_10003.Line2Name(arg_24_1, arg_24_2)

	return arg_24_0.cells[var_24_0]
end

function var_0_0.FilterCell(arg_25_0, arg_25_1)
	table = var_1_10002

	return var_1_10002.Checkout(arg_25_0.cells, arg_25_1)
end

function var_0_0.findChapterCell(arg_26_0, arg_26_1, arg_26_2)
	pairs = var_1_10003

	for iter_26_0, iter_26_1 in var_1_10003(arg_26_0.cells) do
		if iter_26_1.attachment == arg_26_1 and (not arg_26_2 or iter_26_1.attachmentId == arg_26_2) then
			return iter_26_1
		end
	end

	return nil
end

function var_0_0.findChapterCells(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = {}

	pairs = var_1_10004

	for iter_27_0, iter_27_1 in var_1_10004(arg_27_0.cells) do
		if iter_27_1.attachment == arg_27_1 and (not arg_27_2 or iter_27_1.attachmentId == arg_27_2) then
			table = var_9

			var_9.insert(var_27_0, iter_27_1)
		end
	end

	return var_27_0
end

function var_0_0.GetBossCell(arg_28_0)
	table = var_1_10001

	return var_1_10001.Find(arg_28_0.cells, function(arg_29_0, arg_29_1)
		ChapterConst = var_2_10002

		return var_2_10002.IsBossCell(arg_29_1)
	end)
end

function var_0_0.mergeChapterCell(arg_30_0, arg_30_1, arg_30_2)
	ChapterCell = var_1_10003

	local var_30_0 = var_1_10003.Line2Name(arg_30_1.row, arg_30_1.column)
	local var_30_1 = arg_30_0.cells[var_30_0] == nil or var_4.attachment ~= arg_30_1.attachment or var_4.attachmentId ~= arg_30_1.attachmentId

	if var_4 then
		var_4.attachment = arg_30_1.attachment
		var_4.attachmentId = arg_30_1.attachmentId
		var_4.flag = arg_30_1.flag
		var_4.data = arg_30_1.data
		arg_30_1 = var_4
	end

	if not arg_30_2 and var_30_1 then
		ChapterConst = var_6

		if var_6.NeedMarkAsLurk(arg_30_1) then
			ChapterConst = var_6
			arg_30_1.trait = var_6.TraitLurk
		end
	end

	ChapterConst = var_6

	if var_6.IsBossCell(arg_30_1) and arg_30_0:getChampionIndex(arg_30_1.row, arg_30_1.column) then
		table = var_1_10007

		var_1_10007.remove(arg_30_0.champions, var_6)
	end

	arg_30_0:updateChapterCell(arg_30_1)

	return
end

function var_0_0.updateChapterCell(arg_31_0, arg_31_1)
	ChapterCell = var_1_10002

	local var_31_0 = var_1_10002.Line2Name(arg_31_1.row, arg_31_1.column)
	local var_31_1 = arg_31_0.cells

	Clone = var_4
	var_31_1[var_31_0] = var_4(arg_31_1)

	return
end

function var_0_0.clearChapterCell(arg_32_0, arg_32_1, arg_32_2)
	ChapterCell = var_1_10003

	local var_32_0 = var_1_10003.Line2Name(arg_32_1, arg_32_2)
	local var_32_1 = arg_32_0.cells[var_32_0]

	ChapterConst = var_5
	var_32_1.attachment = var_5.AttachNone
	var_32_1.attachmentId = 0
	ChapterConst = var_5
	var_32_1.flag = var_5.CellFlagActive
	var_32_1.data = 0
	ChapterConst = var_5
	var_32_1.trait = var_5.TraitNone

	return
end

function var_0_0.GetChapterCellAttachemnts(arg_33_0)
	return arg_33_0.cellAttachments
end

function var_0_0.GetRawChapterAttachemnt(arg_34_0, arg_34_1, arg_34_2)
	ChapterCell = var_1_10003

	local var_34_0 = var_1_10003.Line2Name(arg_34_1, arg_34_2)

	return arg_34_0.cellAttachments[var_34_0]
end

function var_0_0.getShips(arg_35_0)
	local var_35_0 = {}

	_ = var_1_10002

	var_1_10002.each(arg_35_0.fleets, function(arg_36_0)
		local var_36_0 = arg_36_0:getShips(true)

		_ = var_2_10002

		var_2_10002.each(var_36_0, function(arg_37_0)
			table = var_3_10001

			local var_37_0 = var_3_10001.insert
			local var_37_1 = var_35_0

			Clone = var_3_10004

			var_37_0(var_37_1, var_3_10004(arg_37_0))

			return
		end)

		return
	end)

	return var_35_0
end

function var_0_0.getNextValidIndex(arg_38_0)
	for iter_38_0 = arg_38_0.findex + 1, #arg_38_0.fleets do
		local var_38_0 = arg_38_0.fleets[iter_38_0]
		local var_38_1 = var_5.getFleetType(var_38_0)

		FleetType = var_1_10006

		if var_38_1 == var_1_10006.Normal then
			local var_38_2 = arg_38_0.fleets[iter_38_0]

			if var_5.isValid(var_38_2) then
				return iter_38_0
			end
		end
	end

	for iter_38_1 = 1, arg_38_0.findex - 1 do
		local var_38_3 = arg_38_0.fleets[iter_38_1]
		local var_38_4 = var_5.getFleetType(var_38_3)

		FleetType = var_1_10006

		if var_38_4 == var_1_10006.Normal then
			local var_38_5 = arg_38_0.fleets[iter_38_1]

			if var_5.isValid(var_38_5) then
				return iter_38_1
			end
		end
	end

	return 0
end

function var_0_0.getAmbushRate(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = arg_39_1:getInvestSums()
	local var_39_1 = arg_39_0
	local var_39_2 = var_4 / (arg_39_0.getConfig(var_39_1, "investigation_ratio") + var_39_0) / 4

	_ = var_39_1

	local var_39_3 = var_39_1.detect(arg_39_0:getConfig("ambush_ratio_extra"), function(arg_40_0)
		return arg_40_0[1] == arg_39_2.row and arg_40_0[2] == arg_39_2.column
	end)

	_ = var_7

	local var_39_4 = var_7.detect(arg_39_0:getConfig("ambush_ratio_extra"), function(arg_41_0)
		return #arg_41_0 == 1
	end)
	local var_39_5

	var_39_5 = var_39_3 and var_39_3[3] / 16 or 0

	local var_39_6

	if not var_39_4 or not (var_39_4[1] / 16) then
		var_39_6 = 0
	end

	local var_39_7 = var_39_5 + var_39_6

	math = var_39_6

	local var_39_8 = 0.05 + var_39_2 * var_39_6.max(arg_39_1.step - 1, 0) + var_39_7

	if var_39_7 == 0 then
		var_39_8 = var_39_8 - arg_39_1:getEquipAmbushRateReduce()
	end

	math = var_9

	return (var_9.clamp(var_39_8, 0, 1))
end

function var_0_0.getAmbushDodge(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_1.line
	local var_42_1 = arg_42_1:getDodgeSums()
	local var_42_2 = arg_42_0
	local var_42_3 = var_42_1 / (var_42_1 + arg_42_0.getConfig(var_42_2, "avoid_ratio"))

	_ = var_42_2

	local var_42_4

	var_42_4 = var_42_2.detect(arg_42_0:getConfig("ambush_ratio_extra"), function(arg_43_0)
		return arg_43_0[1] == var_42_0.row and arg_43_0[2] == var_42_0.column
	end) and var_6[3] / 16 or 0

	if var_42_4 == 0 then
		var_42_3 = var_42_3 + arg_42_1:getEquipDodgeRateUp()
	end

	math = var_7

	return (var_7.clamp(var_42_3, 0, 1))
end

function var_0_0.inWartime(arg_44_0)
	local var_44_1

	if arg_44_0.dueTime then
		pg = var_44_1

		local var_44_0 = var_44_1.TimeMgr.GetInstance()

		var_44_1 = var_44_1.GetServerTime(var_44_0) < arg_44_0.dueTime
	end

	return var_44_1
end

function var_0_0.inActTime(arg_45_0)
	if arg_45_0:GetBindActID() == 0 then
		return true
	end

	if var_1 then
		::label_45_0::

		getProxy = var_1_10002
		ActivityProxy = var_1_10004

		local var_45_0 = var_1_10002(var_1_10004)

		var_1_10002 = var_1_10002.getActivityById(var_45_0, var_1)
	end

	return var_1_10002 and not var_1_10002:isEnd()
end

function var_0_0.getRemainTime(arg_46_0)
	if arg_46_0.dueTime then
		math = var_1

		local var_46_0 = var_1.max
		local var_46_1 = arg_46_0.dueTime

		pg = var_1_10004

		local var_46_2 = var_1_10004.TimeMgr.GetInstance()
		local var_46_3

		if not var_46_0(var_46_1 - var_4.GetServerTime(var_46_2) - 1, 0) then
			var_46_3 = 0
		end

		return var_46_3
	end
end

function var_0_0.getStartTime(arg_47_0)
	math = var_1_10001

	return var_1_10001.max(arg_47_0.dueTime - arg_47_0:getConfig("time"), 0)
end

function var_0_0.GetWillActiveAmbush(arg_48_0)
	if not arg_48_0:existAmbush() then
		return false
	end

	local var_48_0 = arg_48_0:getConfig("avoid_require")

	_ = var_1_10002

	return not var_1_10002.any(arg_48_0.fleets, function(arg_49_0)
		local var_49_0 = arg_49_0:getFleetType()

		FleetType = var_2_10002

		return var_49_0 == var_2_10002.Normal and arg_49_0:getInvestSums(true) >= var_48_0
	end)
end

function var_0_0.findPath(arg_50_0, arg_50_1, arg_50_2, arg_50_3)
	local var_50_0 = {}
	local var_50_1 = 0

	ChapterConst = var_1_10006

	for iter_50_0 = var_50_1, var_1_10006.MaxRow - 1 do
		local var_50_2

		if not var_50_0[iter_50_0] then
			var_50_2 = {}
		end

		var_50_0[iter_50_0] = var_50_2

		local var_50_3 = 0

		ChapterConst = var_1_10010

		for iter_50_1 = var_50_3, var_1_10010.MaxColumn - 1 do
			local var_50_4 = var_50_0[iter_50_0]
			local var_50_5

			if not var_50_0[iter_50_0][iter_50_1] then
				var_50_5 = {}
			end

			var_50_4[iter_50_1] = var_50_5
			PathFinding = var_50_4

			local var_50_6 = var_50_4.PrioForbidden

			ChapterConst = var_50_5

			local var_50_7 = var_50_5.ForbiddenAll

			ChapterCell = var_1_10015
			var_1_10015 = var_1_10015.Line2Name(iter_50_0, iter_50_1)

			if arg_50_0.cells[var_1_10015] and var_16:IsWalkable() then
				PathFinding = var_17
				var_50_6 = var_17.PrioNormal

				if arg_50_0:considerAsObstacle(arg_50_1, var_16.row, var_16.column) then
					PathFinding = var_17
					var_50_6 = var_17.PrioObstacle
				end

				ChapterConst = var_17

				if arg_50_1 == var_17.SubjectPlayer then
					var_50_7 = var_16.forbiddenDirections
				else
					ChapterConst = var_17
					var_50_7 = var_17.ForbiddenNone
				end
			end

			var_50_0[iter_50_0][iter_50_1].forbiddens = var_50_7
			var_50_0[iter_50_0][iter_50_1].priority = var_50_6
		end
	end

	ChapterConst = var_50_1

	local var_50_8

	if arg_50_1 == var_50_1.SubjectPlayer then
		var_50_8 = arg_50_0

		local var_50_9 = arg_50_0.getCoastalGunArea(var_50_8)

		ipairs = var_6

		for iter_50_2, iter_50_3 in var_6(var_50_9) do
			local var_50_10 = var_50_0[iter_50_3.row][iter_50_3.column]

			math = var_12

			local var_50_11 = var_12.max
			local var_50_12 = var_50_0[iter_50_3.row][iter_50_3.column].priority

			PathFinding = var_15
			var_50_10.priority = var_50_11(var_50_12, var_15.PrioObstacle)
		end
	end

	local var_50_13

	if var_50_0[arg_50_3.row] then
		var_50_13 = var_50_0[arg_50_3.row][arg_50_3.column]
	end

	if var_50_13 then
		if arg_50_0:considerAsStayPoint(arg_50_1, arg_50_3.row, arg_50_3.column) then
			PathFinding = var_50_8

			if not var_50_8.PrioNormal then
				PathFinding = var_50_8
				var_50_8 = var_50_8.PrioObstacle
			end

			var_50_13.priority = var_50_8
			arg_50_0.pathFinder.cells = var_50_0

			local var_50_14 = arg_50_0.pathFinder

			return var_6.Find(var_50_14, arg_50_2, arg_50_3)
		end
	end
end

function var_0_0.FindBossPath(arg_51_0, arg_51_1, arg_51_2)
	ChapterConst = var_1_10003

	local var_51_0 = var_1_10003.SubjectPlayer
	local var_51_1 = {}
	local var_51_2 = 0

	ChapterConst = var_1_10006

	for iter_51_0 = var_51_2, var_1_10006.MaxRow - 1 do
		local var_51_3

		if not var_51_1[iter_51_0] then
			var_51_3 = {}
		end

		var_51_1[iter_51_0] = var_51_3

		local var_51_4 = 0

		ChapterConst = var_1_10010

		for iter_51_1 = var_51_4, var_1_10010.MaxColumn - 1 do
			local var_51_5 = var_51_1[iter_51_0]
			local var_51_6

			if not var_51_1[iter_51_0][iter_51_1] then
				var_51_6 = {}
			end

			var_51_5[iter_51_1] = var_51_6
			PathFinding = var_51_5

			local var_51_7 = var_51_5.PrioForbidden

			ChapterConst = var_51_6

			local var_51_8 = var_51_6.ForbiddenAll
			local var_51_9

			ChapterCell = var_1_10016
			var_1_10016 = var_1_10016.Line2Name(iter_51_0, iter_51_1)

			if arg_51_0.cells[var_1_10016] and var_17:IsWalkable() then
				PathFinding = var_18
				var_51_7 = var_18.PrioNormal

				if arg_51_0:considerAsObstacle(var_51_0, var_17.row, var_17.column) then
					PathFinding = var_18
					var_51_7 = var_18.PrioObstacle
				end

				if arg_51_0:GetEnemy(var_17.row, var_17.column) then
					PathFinding = var_19
					var_51_7 = var_19.PrioNormal
					ChapterConst = var_19
					var_51_9 = not var_19.IsBossCell(var_18)
				end

				var_51_8 = var_17.forbiddenDirections
			end

			var_51_1[iter_51_0][iter_51_1].forbiddens = var_51_8
			var_51_1[iter_51_0][iter_51_1].priority = var_51_7
			var_51_1[iter_51_0][iter_51_1].isEnemy = var_51_9
		end
	end

	local var_51_10 = arg_51_0:getCoastalGunArea()

	ipairs = var_6

	for iter_51_2, iter_51_3 in var_6(var_51_10) do
		var_1_10011 = var_51_1[iter_51_3.row][iter_51_3.column]
		math = var_12

		local var_51_11 = var_12.max
		local var_51_12 = var_51_1[iter_51_3.row][iter_51_3.column].priority

		PathFinding = var_15
		var_1_10011.priority = var_51_11(var_51_12, var_15.PrioObstacle)
	end

	local var_51_13

	if var_51_1[arg_51_2.row] then
		var_51_13 = var_51_1[arg_51_2.row][arg_51_2.column]
	end

	if var_51_13 then
		if arg_51_0:considerAsStayPoint(var_51_0, arg_51_2.row, arg_51_2.column) then
			PathFinding = var_51_14

			local var_51_14

			if not var_51_14.PrioNormal then
				PathFinding = var_51_14
				var_51_14 = var_51_14.PrioObstacle
			end

			var_51_13.priority = var_51_14
			OrientedWeightPathFinding = var_7

			local var_51_15 = var_7.StaticFind
			local var_51_16 = var_51_1

			ChapterConst = iter_51_3

			local var_51_17 = iter_51_3.MaxRow

			ChapterConst = var_1_10011

			return var_51_15(var_51_16, var_51_17, var_1_10011.MaxColumn, arg_51_1, arg_51_2)
		end
	end
end

function var_0_0.getWaveCount(arg_52_0)
	local var_52_0 = 0

	pairs = var_1_10002

	for iter_52_0, iter_52_1 in var_1_10002(arg_52_0.cells) do
		local var_52_1 = iter_52_1.attachment

		ChapterConst = var_1_10008

		if var_52_1 == var_1_10008.AttachEnemy then
			underscore = var_52_1

			if var_52_1.detect(arg_52_0:getConfig("grids"), function(arg_53_0)
				if arg_53_0[1] == iter_52_1.row and arg_53_0[2] == iter_52_1.column then
					local var_53_0 = arg_53_0[4]

					ChapterConst = var_2

					if var_53_0 ~= var_2.AttachElite then
						local var_53_1 = arg_53_0[4]

						ChapterConst = var_2

						if var_53_1 == var_2.AttachEnemy then
							return true
						end

						return false
					end
				end
			end) then
				var_52_0 = var_52_0 + 1
			end
		end
	end

	local var_52_2 = 0

	pg = var_3

	if var_3.chapter_group_refresh[arg_52_0.id] then
		local var_52_3 = 1

		repeat
			local var_52_4 = false

			ipairs = iter_52_1

			for iter_52_2, iter_52_3 in iter_52_1(var_3.enemy_refresh) do
				local var_52_5

				if not iter_52_3[var_52_3] then
					var_52_5 = 0
				end

				var_52_2 = var_52_2 + var_52_5

				if not var_52_4 then
					tobool = var_52_5
					var_52_4 = var_52_5(iter_52_3[var_52_3])
				end
			end

			if var_52_0 <= var_52_2 then
				return var_52_3
			end

			var_52_3 = var_52_3 + 1
		until not var_52_4
	else
		local var_52_6 = arg_52_0
		local var_52_7 = arg_52_0.getConfig(var_52_6, "enemy_refresh")
		local var_52_8 = arg_52_0:getConfig("elite_refresh")

		pairs = var_52_6

		for iter_52_4, iter_52_5 in var_52_6(var_52_7) do
			var_52_2 = var_52_2 + iter_52_5

			if iter_52_4 <= #var_52_8 then
				var_52_2 = var_52_2 + var_52_8[iter_52_4]
			end

			if var_52_0 <= var_52_2 then
				return iter_52_4
			end
		end
	end

	return 1
end

function var_0_0.IsFinalBossRefreshed(arg_54_0)
	tobool = var_1_10001

	local var_54_0 = arg_54_0
	local var_54_1 = arg_54_0.findChapterCell

	ChapterConst = var_1_10006

	return var_1_10001(var_54_1(var_54_0, var_1_10006.AttachBoss))
end

function var_0_0.getFleetAmmo(arg_55_0, arg_55_1)
	local var_55_0 = arg_55_1
	local var_55_1 = arg_55_1.getShipAmmo(var_55_0)
	local var_55_2 = arg_55_1:getFleetType()

	FleetType = var_55_0

	if var_55_2 == var_55_0.Normal then
		var_55_1 = var_55_1 + arg_55_0:getConfig("ammo_total")
	else
		FleetType = var_4

		if var_55_2 == var_4.Submarine then
			var_55_1 = var_55_1 + arg_55_0:getConfig("ammo_submarine")
		else
			assert = var_4

			var_4(false, "invalide operation.")
		end
	end

	local var_55_3 = arg_55_1.restAmmo

	return var_55_1, var_55_3
end

function var_0_0.GetInteractableStrategies(arg_56_0)
	local var_56_0 = arg_56_0.fleet
	local var_56_1 = var_1.getStrategies(var_56_0)

	_ = var_1_10002

	local var_56_2 = var_1_10002.filter(var_56_1, function(arg_57_0)
		pg = var_2_10001

		local var_57_0

		if var_2_10001.strategy_data_template[arg_57_0.id] then
			::label_57_0::

			var_57_0 = var_1.type
			ChapterConst = var_2_10003
			var_57_0 = var_57_0 ~= var_2_10003.StgTypeBindFleetPassive
		end

		return var_57_0
	end)
	local var_56_3 = arg_56_0.fleet
	local var_56_4 = var_2.getFormationStg(var_56_3)

	table = var_56_0

	var_56_0.insert(var_56_2, 1, {
		id = var_56_4
	})

	local var_56_5 = arg_56_0

	if arg_56_0.GetSubmarineFleet(var_56_5) then
		table = var_56_3

		local var_56_6 = var_56_3.insert
		local var_56_7 = var_56_2
		local var_56_8 = 3

		var_1_10008 = {}
		ChapterConst = var_1_10009
		var_1_10008.id = var_1_10009.StrategyHuntingRange

		var_56_6(var_56_7, var_56_8, var_1_10008)

		table = var_56_6

		local var_56_9 = var_56_6.insert
		local var_56_10 = var_56_2
		local var_56_11 = 4

		var_1_10008 = {}
		ChapterConst = var_9
		var_1_10008.id = var_9.StrategySubAutoAttack

		var_56_9(var_56_10, var_56_11, var_1_10008)

		table = var_56_9

		local var_56_12 = var_56_9.insert
		local var_56_13 = var_56_2
		local var_56_14 = 5

		var_1_10008 = {}
		ChapterConst = var_9
		var_1_10008.id = var_9.StrategySubTeleport

		var_56_12(var_56_13, var_56_14, var_1_10008)
	end

	if arg_56_0:getChapterSupportFleet() then
		table = var_56_5

		local var_56_15 = var_56_5.insertto
		local var_56_16 = var_56_2

		_ = var_1_10008

		var_56_15(var_56_16, var_1_10008.filter(var_4:getStrategies(), function(arg_58_0)
			pg = var_2_10001

			local var_58_0

			if var_2_10001.strategy_data_template[arg_58_0.id] then
				::label_58_0::

				var_58_0 = var_1.type
				ChapterConst = var_2_10003
				var_58_0 = var_58_0 == var_2_10003.StgTypeBindSupportConsume
			end

			return var_58_0
		end))
	end

	if #arg_56_0.strategies > 0 then
		pairs = var_5

		for iter_56_0, iter_56_1 in var_5(arg_56_0.strategies) do
			table = var_1_10010

			var_1_10010.insert(var_56_2, {
				id = iter_56_0,
				count = iter_56_1
			})
		end
	end

	return var_56_2
end

function var_0_0.getFleetStates(arg_59_0, arg_59_1)
	local var_59_0 = {}
	local var_59_1 = arg_59_0
	local var_59_2, var_59_3 = arg_59_0.getFleetAmmo(var_59_1, arg_59_1)

	ChapterConst = var_59_1

	local var_59_4

	if var_59_1.AmmoRich <= var_59_3 then
		table = var_59_4
		var_59_4 = var_59_4.insert

		local var_59_5 = var_59_0

		ChapterConst = var_1_10008

		var_59_4(var_59_5, var_1_10008.StrategyAmmoRich)
	else
		ChapterConst = var_59_4

		if var_59_3 <= var_59_4.AmmoPoor then
			table = var_59_4
			var_59_4 = var_59_4.insert

			local var_59_6 = var_59_0

			ChapterConst = var_1_10008

			var_59_4(var_59_6, var_1_10008.StrategyAmmoPoor)
		end
	end

	underscore = var_59_4

	local var_59_7 = var_59_4.filter
	local var_59_8 = arg_59_1
	local var_59_9 = var_59_7(arg_59_1.getStrategies(var_59_8), function(arg_60_0)
		pg = var_2_10001

		local var_60_0

		if var_2_10001.strategy_data_template[arg_60_0.id] then
			::label_60_0::

			var_60_0 = var_1.type
			ChapterConst = var_2_10003
			var_60_0 = var_60_0 == var_2_10003.StgTypeBindFleetPassive and arg_60_0.count > 0
		end

		return var_60_0
	end)

	table = var_6

	local var_59_10 = var_6.insertto
	local var_59_11 = var_59_0

	underscore = var_59_8

	var_59_10(var_59_11, var_59_8.map(var_59_9, function(arg_61_0)
		return arg_61_0.id
	end))

	table = var_59_10

	var_59_10.insertto(var_59_0, arg_59_1.stgIds)

	local var_59_12 = arg_59_0:getConfig("chapter_strategy")

	ipairs = var_7

	for iter_59_0, iter_59_1 in var_7(var_59_12) do
		table = var_59_15

		var_59_15.insert(var_59_0, iter_59_1)
	end

	local var_59_13, var_59_15

	if arg_59_0:IsFogStage() then
		table = var_59_13
		var_59_13 = var_59_13.insert

		local var_59_14 = var_59_0

		var_59_15 = arg_59_0

		var_59_13(var_59_14, arg_59_0.GetFogStageStrategy(var_59_15))
	end

	OPEN_AIR_DOMINANCE = var_59_13

	if var_59_13 and arg_59_0:getConfig("air_dominance") > 0 then
		table = var_59_13
		var_59_13 = var_59_13.insert

		local var_59_16 = var_59_0

		var_59_15 = arg_59_0

		var_59_13(var_59_16, arg_59_0.getAirDominanceStg(var_59_15))
	end

	ipairs = var_59_13

	for iter_59_2, iter_59_3 in var_59_13(arg_59_0:getExtraFlags()) do
		table = var_59_15
		var_59_15 = var_59_15.insert

		local var_59_17 = var_59_0

		ChapterConst = var_1_10015

		var_59_15(var_59_17, var_1_10015.Status2Stg[iter_59_3])
	end

	if arg_59_0:getOperationBuffDescStg() then
		table = var_8

		var_8.insert(var_59_0, var_7)
	end

	underscore = var_8

	var_8.each(arg_59_0.buff_list, function(arg_62_0)
		ChapterConst = var_2_10001

		if var_2_10001.Buff2Stg[arg_62_0] then
			table = var_1

			local var_62_0 = var_1.insert
			local var_62_1 = var_59_0

			ChapterConst = var_2_10004

			var_62_0(var_62_1, var_2_10004.Buff2Stg[arg_62_0])
		end

		return
	end)

	getProxy = var_8
	ActivityProxy = var_10

	local var_59_18 = var_8(var_10)
	local var_59_19 = var_8.getActivityById

	ActivityConst = var_11

	if var_59_19(var_59_18, var_11.YUMIA_EXPEDITION_BUFF_ACT_ID) then
		local var_59_20 = var_8

		if not var_8.isEnd(var_59_20) then
			unpack = var_9
			getGameset = var_59_20

			local var_59_21, var_59_22 = var_9(var_59_20("yumia_buff_mapping")[2])
			local var_59_23 = {}

			for iter_59_4 = 1, #var_59_21 do
				var_59_23[var_59_21[iter_59_4]] = var_59_22[iter_59_4]
			end

			underscore = var_12

			local var_59_24 = var_12.filter
			local var_59_25 = var_8
			local var_59_26 = var_59_24(var_8.GetBuffList(var_59_25), function(arg_63_0)
				local var_63_0

				if arg_63_0:isActivate() then
					var_63_0 = arg_63_0:checkChaper(arg_59_0.id)
				end

				return var_63_0
			end)

			table = var_13

			local var_59_27 = var_13.sort
			local var_59_28 = var_59_26

			CompareFuncs = var_59_25

			var_59_27(var_59_28, var_59_25({
				function(arg_64_0)
					return arg_64_0.id
				end
			}))

			underscore = var_59_27

			var_59_27.each(var_59_26, function(arg_65_0)
				if var_59_23[arg_65_0.id] then
					table = var_1

					var_1.insert(var_59_0, var_59_23[arg_65_0.id])
				end

				return
			end)
		end
	end

	return var_59_0
end

function var_0_0.GetShowingStrategies(arg_66_0)
	local var_66_0 = arg_66_0.fleet
	local var_66_1 = arg_66_0:getFleetStates(var_66_0)

	_ = var_1_10003

	return (var_1_10003.filter(var_66_1, function(arg_67_0)
		pg = var_2_10001

		return var_2_10001.strategy_data_template[arg_67_0] and var_1.icon ~= ""
	end))
end

function var_0_0.getAirDominanceStg(arg_68_0)
	local var_68_0 = arg_68_0
	local var_68_1, var_68_2 = arg_68_0.getAirDominanceValue(var_68_0)

	ChapterConst = var_68_0

	return var_68_0.AirDominance[var_68_2].StgId
end

function var_0_0.getAirDominanceValue(arg_69_0)
	local var_69_0 = 0
	local var_69_1 = 0

	pairs = var_1_10003

	for iter_69_0, iter_69_1 in var_1_10003(arg_69_0.fleets) do
		if iter_69_1:isValid() then
			local var_69_2 = iter_69_1:getFleetType()

			FleetType = var_1_10009

			if var_69_2 ~= var_1_10009.Normal then
				local var_69_3 = iter_69_1:getFleetType()

				FleetType = var_1_10009

				if var_69_3 == var_1_10009.Submarine then
					var_69_0 = var_69_0 + iter_69_1:getFleetAirDominanceValue()
					var_69_1 = var_69_1 + iter_69_1:getAntiAircraftSums()
				end
			end
		end
	end

	local var_69_4 = var_69_0

	calcAirDominanceStatus = var_4

	return var_69_4, var_4(var_69_0, arg_69_0:getConfig("air_dominance"), var_69_1), arg_69_0.airDominanceStatus
end

function var_0_0.setAirDominanceStatus(arg_70_0, arg_70_1)
	arg_70_0.airDominanceStatus = arg_70_1

	return
end

function var_0_0.updateExtraFlags(arg_71_0, arg_71_1, arg_71_2)
	local var_71_0 = false

	ipairs = var_1_10004

	for iter_71_0, iter_71_1 in var_1_10004(arg_71_2) do
		ipairs = var_1_10009

		for iter_71_2, iter_71_3 in var_1_10009(arg_71_0.extraFlagList) do
			if iter_71_3 == iter_71_1 then
				table = var_1_10014

				var_1_10014.remove(arg_71_0.extraFlagList, iter_71_2)

				var_71_0 = true

				break
			end
		end
	end

	ipairs = var_4

	for iter_71_4, iter_71_5 in var_4(arg_71_1) do
		table = var_1_10009

		if not var_1_10009.contains(arg_71_0.extraFlagList, iter_71_5) then
			table = var_1_10009

			var_1_10009.insert(arg_71_0.extraFlagList, 1, iter_71_5)

			var_71_0 = true
		end
	end

	return var_71_0
end

function var_0_0.getExtraFlags(arg_72_0)
	return arg_72_0.extraFlagList
end

function var_0_0.UpdateBuffList(arg_73_0, arg_73_1)
	if not arg_73_1 then
		return
	end

	ipairs = var_1_10002

	for iter_73_0, iter_73_1 in var_1_10002(arg_73_1) do
		_ = var_1_10007

		if not var_1_10007.include(arg_73_0.buff_list, iter_73_1) then
			table = var_1_10007

			var_1_10007.insert(arg_73_0.buff_list, iter_73_1)
		end
	end

	return
end

function var_0_0.getFleetBattleBuffs(arg_74_0, arg_74_1)
	table = var_1_10002

	local var_74_0 = var_1_10002.shallowCopy(arg_74_0.buff_list)

	_ = var_1_10003

	var_1_10003.each(arg_74_0:getFleetStates(arg_74_1), function(arg_75_0)
		pg = var_2_10001

		if var_2_10001.strategy_data_template[arg_75_0].buff_id == 0 then
			return
		end

		local var_75_0 = var_1.buff_type

		ChapterConst = var_2_10004

		if var_75_0 == var_2_10004.StrategyBuffTypeOnlyBoss then
			local var_75_1 = arg_74_0

			if var_75_0.GetEnemy(var_75_1, arg_74_1.line.row, arg_74_1.line.column) then
				ChapterConst = var_4

				if not var_4.IsBossCell(var_75_0) then
					return
				end
			end
		end

		table = var_75_0

		var_75_0.insert(var_74_0, var_2)

		return
	end)

	table = var_3

	local var_74_1 = var_3.insertto
	local var_74_2 = var_74_0
	local var_74_3

	if not arg_74_0:GetCellEventByKey("attach_buff", arg_74_1.line.row, arg_74_1.line.column) then
		var_74_3 = {}
	end

	var_74_1(var_74_2, var_74_3)

	_ = var_74_1

	var_74_1.each(arg_74_0:GetWeather(), function(arg_76_0)
		pg = var_2_10001

		local var_76_0 = var_2_10001.weather_data_template[arg_76_0].effect_args

		type = var_2_10002

		if var_2_10002(var_76_0) == "table" and var_76_0.buff and var_76_0.buff > 0 then
			table = var_2

			var_2.insert(var_74_0, var_76_0.buff)
		end

		return
	end)

	local var_74_4 = arg_74_0:buildBattleBuffList(arg_74_1)

	return var_74_0, var_74_4
end

function var_0_0.GetStageFlags(arg_77_0)
	local var_77_0 = arg_77_0.fleet.line.row
	local var_77_1 = arg_77_0.fleet.line.column
	local var_77_2

	if not arg_77_0:GetCellEventByKey("stage_flags", var_77_0, var_77_1) then
		var_77_2 = {}
	end

	return var_77_2
end

function var_0_0.GetCellEventByKey(arg_78_0, arg_78_1, arg_78_2, arg_78_3)
	arg_78_2 = arg_78_2 or arg_78_0.fleet.line.row
	arg_78_3 = arg_78_3 or arg_78_0.fleet.line.column
	ChapterCell = var_1_10004

	local var_78_0 = var_1_10004.Line2Name(arg_78_2, arg_78_3)

	if not arg_78_0.cells[var_78_0] then
		return
	end

	return var_0_0.GetEventTemplateByKey(arg_78_1, var_5.attachmentId)
end

function var_0_0.GetEventTemplateByKey(arg_79_0, arg_79_1)
	pg = var_1_10002

	if not var_1_10002.map_event_template[arg_79_1] then
		return
	end

	local var_79_0

	ipairs = var_1_10004

	for iter_79_0, iter_79_1 in var_1_10004(var_2.effect) do
		if iter_79_1[1] == arg_79_0 then
			for iter_79_2 = 2, #iter_79_1 do
				var_79_0 = var_79_0 or {}
				table = var_1_10013

				var_1_10013.insert(var_79_0, iter_79_1[iter_79_2])
			end
		end
	end

	return var_79_0
end

function var_0_0.buildBattleBuffList(arg_80_0, arg_80_1)
	local var_80_0 = {}
	local var_80_1 = arg_80_0
	local var_80_2 = arg_80_0.triggerSkill
	local var_80_3 = arg_80_1

	FleetSkill = var_1_10007

	local var_80_4, var_80_5 = var_80_2(var_80_1, var_80_3, var_1_10007.TypeBattleBuff)

	if var_80_4 then
		local var_80_6 = #var_80_4

		if 0 < var_80_6 then
			local var_80_7 = {}

			ipairs = var_80_3

			for iter_80_0, iter_80_1 in var_80_3(var_80_4) do
				var_1_10011 = var_80_5[iter_80_0]

				local var_80_8

				if not var_80_7[arg_80_1:findCommanderBySkillId(var_1_10011.id)] then
					var_80_8 = {}
				end

				var_80_7[var_1_10012] = var_80_8
				table = var_80_8

				var_80_8.insert(var_80_7[var_1_10012], iter_80_1)
			end

			pairs = var_80_3

			for iter_80_2, iter_80_3 in var_80_3(var_80_7) do
				table = var_1_10011

				var_1_10011.insert(var_80_0, {
					iter_80_2,
					iter_80_3
				})
			end
		end
	end

	local var_80_9 = arg_80_1:getCommanders()

	pairs = var_80_3

	for iter_80_4, iter_80_5 in var_80_3(var_80_9) do
		local var_80_10 = iter_80_5:getTalents()

		ipairs = var_1_10012

		for iter_80_6, iter_80_7 in var_1_10012(var_80_10) do
			local var_80_11 = #iter_80_7:getBuffsAddition()

			if 0 < var_80_11 then
				local var_80_12

				ipairs = var_19

				for iter_80_8, iter_80_9 in var_19(var_80_0) do
					if iter_80_9[1] == iter_80_5 then
						var_80_12 = iter_80_9[2]

						break
					end
				end

				if not var_80_12 then
					var_80_12 = {}
					table = var_19

					var_19.insert(var_80_0, {
						iter_80_5,
						var_80_12
					})
				end

				ipairs = var_19

				for iter_80_10, iter_80_11 in var_19(var_17) do
					table = var_1_10024

					var_1_10024.insert(var_80_12, iter_80_11)
				end
			end
		end
	end

	return var_80_0
end

function var_0_0.updateFleetShipHp(arg_81_0, arg_81_1, arg_81_2)
	ipairs = var_1_10003

	for iter_81_0, iter_81_1 in var_1_10003(arg_81_0.fleets) do
		iter_81_1:updateShipHp(arg_81_1, arg_81_2)

		if iter_81_1.id ~= arg_81_0.fleet.id then
			iter_81_1:clearShipHpChange()
		end
	end

	return
end

function var_0_0.getDragExtend(arg_82_0)
	local var_82_0 = arg_82_0.theme
	local var_82_1 = 99999999
	local var_82_2 = 99999999
	local var_82_3 = 0
	local var_82_4 = 0

	pairs = var_1_10006

	for iter_82_0, iter_82_1 in var_1_10006(arg_82_0.cells) do
		if var_82_1 > iter_82_1.row then
			var_82_1 = iter_82_1.row
		end

		if var_82_3 < iter_82_1.row then
			var_82_3 = iter_82_1.row
		end

		if var_82_2 > iter_82_1.column then
			var_82_2 = iter_82_1.column
		end

		if var_82_4 < iter_82_1.column then
			var_82_4 = iter_82_1.column
		end
	end

	local var_82_5 = (var_82_4 + var_82_2) * 0.5
	local var_82_6 = (var_82_3 + var_82_1) * 0.5
	local var_82_7 = var_82_0.cellSize + var_82_0.cellSpace

	math = var_9

	local var_82_8 = var_9.max((var_82_4 - var_82_5 + 1) * var_82_7.x, 0)

	math = iter_82_1

	local var_82_9 = iter_82_1.max((var_82_5 - var_82_2 + 1) * var_82_7.x, 0)

	math = var_11

	local var_82_10 = var_11.max((var_82_6 - var_82_1 + 1) * var_82_7.y, 0)

	math = var_12

	local var_82_11 = var_12.max((var_82_3 - var_82_6 + 1) * var_82_7.y, 0)

	return var_82_9, var_82_8, var_82_10, var_82_11
end

function var_0_0.getPoisonArea(arg_83_0, arg_83_1)
	local var_83_0 = {}
	local var_83_1 = arg_83_0.theme.cellSize + arg_83_0.theme.cellSpace

	pairs = var_4

	for iter_83_0, iter_83_1 in var_4(arg_83_0.cells) do
		local var_83_2 = iter_83_1
		local var_83_3 = iter_83_1.checkHadFlag

		ChapterConst = var_1_10012

		if var_83_3(var_83_2, var_1_10012.FlagPoison) then
			math = var_9

			local var_83_4 = var_9.floor((iter_83_1.column - arg_83_0.indexMin.y) * var_83_1.x * arg_83_1)

			math = var_1_10010
			var_1_10010 = var_1_10010.ceil((iter_83_1.column - arg_83_0.indexMin.y + 1) * var_83_1.x * arg_83_1)
			math = var_11

			local var_83_5 = var_11.floor((iter_83_1.row - arg_83_0.indexMin.x) * var_83_1.y * arg_83_1)

			math = var_1_10012
			var_1_10012 = var_1_10012.ceil((iter_83_1.row - arg_83_0.indexMin.x + 1) * var_83_1.y * arg_83_1)

			local var_83_6 = var_1_10010 - var_83_4
			local var_83_7 = var_1_10012 - var_83_5

			var_83_0[iter_83_0] = {
				x = var_83_4,
				y = var_83_5,
				w = var_83_6,
				h = var_83_7
			}
		end
	end

	return var_83_0
end

function var_0_0.selectFleets(arg_84_0, arg_84_1)
	Clone = var_1_10002

	local var_84_0

	if not var_1_10002(arg_84_1) then
		var_84_0 = {}
	end

	getProxy = var_1_10003
	FleetProxy = var_1_10005

	local var_84_1 = var_1_10003(var_1_10005)
	local var_84_2 = var_3.GetRegularFleets(var_84_1)

	for iter_84_0 = #var_84_0, 1, -1 do
		if var_84_2[var_84_0[iter_84_0]] then
			var_1_10011 = var_8

			if var_8.isUnlock(var_1_10011) then
				var_1_10011 = var_8

				if var_8.isLegalToFight(var_1_10011) ~= true then
					table = var_1_10009

					var_1_10009.remove(var_84_0, iter_84_0)
				end
			end
		end
	end

	local var_84_3 = {}

	FleetType = var_5

	local var_84_4 = var_5.Normal

	_ = var_6
	var_84_3[var_84_4] = var_6.filter(var_84_0, function(arg_85_0)
		local var_85_0 = var_84_2[arg_85_0]
		local var_85_1 = var_1.getFleetType(var_85_0)

		FleetType = var_2_10002

		return var_85_1 == var_2_10002.Normal
	end)
	FleetType = var_84_4

	local var_84_5 = var_84_4.Submarine

	_ = var_6
	var_84_3[var_84_5] = var_6.filter(var_84_0, function(arg_86_0)
		local var_86_0 = var_84_2[arg_86_0]
		local var_86_1 = var_1.getFleetType(var_86_0)

		FleetType = var_2_10002

		return var_86_1 == var_2_10002.Submarine
	end)

	local var_84_6 = arg_84_0
	local var_84_7 = arg_84_0.getConfig(var_84_6, "group_num")
	local var_84_8 = arg_84_0:getConfig("submarine_num")

	FleetType = var_84_6

	for iter_84_1 = #var_84_3[var_84_6.Normal], var_84_7 + 1, -1 do
		table = var_1_10011
		var_1_10011 = var_1_10011.remove
		FleetType = var_1_10013

		var_1_10011(var_84_3[var_1_10013.Normal], iter_84_1)
	end

	FleetType = var_7

	for iter_84_2 = #var_84_3[var_7.Submarine], var_84_8 + 1, -1 do
		table = var_1_10011
		var_1_10011 = var_1_10011.remove
		FleetType = var_1_10013

		var_1_10011(var_84_3[var_1_10013.Submarine], iter_84_2)
	end

	pairs = var_7

	for iter_84_3, iter_84_4 in var_7(var_84_3) do
		if #iter_84_4 == 0 then
			var_1_10012 = 0
			FleetType = var_1_10013

			if iter_84_3 == var_1_10013.Normal then
				var_1_10012 = var_84_7
			else
				FleetType = var_1_10013

				if iter_84_3 == var_1_10013.Submarine then
					var_1_10012 = var_84_8
				end
			end

			pairs = var_1_10013

			for iter_84_5, iter_84_6 in var_1_10013(var_84_2) do
				if var_1_10012 <= #iter_84_4 then
					break
				end

				if iter_84_6 and iter_84_6:getFleetType() == iter_84_3 and iter_84_6:isUnlock() and iter_84_6:isLegalToFight() == true then
					table = var_18

					var_18.insert(iter_84_4, iter_84_5)
				end
			end
		end
	end

	local var_84_9 = {}

	ipairs = var_7

	for iter_84_7, iter_84_8 in var_7(var_84_3) do
		ipairs = var_1_10012

		for iter_84_9, iter_84_10 in var_1_10012(iter_84_8) do
			table = iter_84_6

			iter_84_6.insert(var_84_9, iter_84_10)
		end
	end

	return var_84_9
end

function var_0_0.GetDefaultFleetIndex(arg_87_0)
	getProxy = var_1_10001
	ChapterProxy = var_1_10003

	local var_87_0 = var_1_10001(var_1_10003)
	local var_87_1 = var_1.GetLastFleetIndex(var_87_0)

	return arg_87_0:selectFleets(var_87_1)
end

function var_0_0.getMaxColumnByRow(arg_88_0, arg_88_1)
	local var_88_0 = -1

	pairs = var_1_10003

	for iter_88_0, iter_88_1 in var_1_10003(arg_88_0.cells) do
		if iter_88_1.row == arg_88_1 then
			math = var_8
			var_88_0 = var_8.max(var_88_0, iter_88_1.column)
		end
	end

	return var_88_0
end

function var_0_0.getFleet(arg_89_0, arg_89_1, arg_89_2, arg_89_3)
	_ = var_1_10004

	local var_89_0

	if not var_1_10004.detect(arg_89_0.fleets, function(arg_90_0)
		return arg_90_0.line.row == arg_89_2 and arg_90_0.line.column == arg_89_3 and (not arg_89_1 or arg_90_0:getFleetType() == arg_89_1) and arg_90_0:isValid()
	end) then
		_ = var_1_10005
		var_89_0 = var_1_10005.detect(arg_89_0.fleets, function(arg_91_0)
			return arg_91_0.line.row == arg_89_2 and arg_91_0.line.column == arg_89_3 and (not arg_89_1 or arg_91_0:getFleetType() == arg_89_1)
		end)
	end

	return var_89_0
end

function var_0_0.getFleetIndex(arg_92_0, arg_92_1, arg_92_2, arg_92_3)
	if arg_92_0:getFleet(arg_92_1, arg_92_2, arg_92_3) then
		table = var_1_10005

		return var_1_10005.indexof(arg_92_0.fleets, var_4)
	end

	return
end

function var_0_0.getOni(arg_93_0)
	_ = var_1_10001

	return var_1_10001.detect(arg_93_0.champions, function(arg_94_0)
		local var_94_0 = arg_94_0.attachment

		ChapterConst = var_2_10002

		return var_94_0 == var_2_10002.AttachOni
	end)
end

function var_0_0.getChampion(arg_95_0, arg_95_1, arg_95_2)
	_ = var_1_10003

	return (var_1_10003.detect(arg_95_0.champions, function(arg_96_0)
		return arg_96_0.row == arg_95_1 and arg_96_0.column == arg_95_2
	end))
end

function var_0_0.getChampionIndex(arg_97_0, arg_97_1, arg_97_2)
	if not arg_97_0:getChampion(arg_97_1, arg_97_2) then
		return
	end

	table = var_1_10004

	return var_1_10004.indexof(arg_97_0.champions, var_3)
end

function var_0_0.getChampionVisibility(arg_98_0, arg_98_1, arg_98_2, arg_98_3)
	assert = var_1_10004

	var_1_10004(arg_98_1, "chapter champion not exist.")

	local var_98_0 = arg_98_1.flag

	ChapterConst = var_1_10005

	return var_98_0 == var_1_10005.CellFlagActive
end

function var_0_0.mergeChampion(arg_99_0, arg_99_1, arg_99_2)
	if arg_99_0:getChampionIndex(arg_99_1.row, arg_99_1.column) then
		var_1_10004 = arg_99_0.champions
		var_1_10004[var_3] = arg_99_1

		return true
	else
		if not arg_99_2 then
			ChapterConst = var_1_10004
			arg_99_1.trait = var_1_10004.TraitLurk
		end

		table = var_1_10004

		var_1_10004.insert(arg_99_0.champions, arg_99_1)

		return false
	end

	return
end

function var_0_0.RemoveChampion(arg_100_0, arg_100_1)
	table = var_1_10002

	if var_1_10002.indexof(arg_100_0.champions, arg_100_1) then
		table = var_1_10003

		var_1_10003.remove(arg_100_0.champions, var_2)
	end

	return
end

function var_0_0.considerAsObstacle(arg_101_0, arg_101_1, arg_101_2, arg_101_3)
	local var_101_0 = arg_101_0

	if not arg_101_0.getChapterCell(var_101_0, arg_101_2, arg_101_3) or not var_4:IsWalkable() then
		return true
	end

	if arg_101_0:existBarrier(arg_101_2, arg_101_3) then
		return true
	end

	ChapterConst = var_5

	local var_101_1

	if arg_101_1 == var_5.SubjectPlayer then
		var_101_1 = var_4.flag
		ChapterConst = var_101_0

		if var_101_1 == var_101_0.CellFlagActive then
			ChapterConst = var_101_1

			if var_101_1.IsEnemyAttach(var_4.attachment) then
				return true
			end

			var_101_1 = var_4.attachment
			ChapterConst = var_6

			local var_101_2

			if var_101_1 == var_6.AttachBox then
				pg = var_101_1
				var_101_1 = var_101_1.box_data_template[var_4.attachmentId]
				assert = var_101_2

				var_101_2(var_101_1, "box_data_template not exist: " .. var_4.attachmentId)

				var_101_2 = var_101_1.type
				ChapterConst = var_7

				if var_101_2 == var_7.BoxTorpedo then
					return true
				end
			end

			var_101_1 = var_4.attachment
			ChapterConst = var_101_2

			if var_101_1 == var_101_2.AttachStory then
				return true
			end
		end

		if arg_101_0:existVisibleChampion(arg_101_2, arg_101_3) then
			return true
		end
	else
		ChapterConst = var_101_1

		if arg_101_1 == var_101_1.SubjectChampion then
			local var_101_3 = arg_101_0
			local var_101_4 = arg_101_0.existFleet

			FleetType = var_8

			if var_101_4(var_101_3, var_8.Normal, arg_101_2, arg_101_3) then
				return true
			end
		end
	end

	return false
end

function var_0_0.considerAsStayPoint(arg_102_0, arg_102_1, arg_102_2, arg_102_3)
	local var_102_0 = arg_102_0

	if not arg_102_0.getChapterCell(var_102_0, arg_102_2, arg_102_3) or not var_4:IsWalkable() then
		return false
	end

	if arg_102_0:existBarrier(arg_102_2, arg_102_3) then
		return false
	end

	ChapterConst = var_5

	local var_102_1

	if arg_102_1 == var_5.SubjectPlayer then
		var_102_1 = var_4.flag
		ChapterConst = var_102_0

		if var_102_1 == var_102_0.CellFlagActive then
			var_102_1 = var_4.attachment
			ChapterConst = var_102_0

			if var_102_1 == var_102_0.AttachStory then
				return true
			end
		end

		var_102_1 = var_4.attachment
		ChapterConst = var_102_0

		if var_102_1 == var_102_0.AttachLandbase then
			pg = var_102_1

			if var_102_1.land_based_template[var_4.attachmentId] then
				pg = var_102_1
				var_102_1 = var_102_1.land_based_template[var_4.attachmentId].type
				ChapterConst = var_102_0

				if var_102_1 == var_102_0.LBHarbor then
					return false
				end
			end
		end

		local var_102_2 = arg_102_0

		var_102_1 = arg_102_0.existFleet
		FleetType = var_8

		if var_102_1(var_102_2, var_8.Normal, arg_102_2, arg_102_3) then
			return false
		end

		if arg_102_0:existOni(arg_102_2, arg_102_3) then
			return false
		end

		if arg_102_0:existBombEnemy(arg_102_2, arg_102_3) then
			return false
		end
	else
		ChapterConst = var_102_1

		if arg_102_1 == var_102_1.SubjectChampion then
			local var_102_3 = var_4.flag

			ChapterConst = var_102_0

			if var_102_3 ~= var_102_0.CellFlagDisabled then
				local var_102_4 = var_4.attachment

				ChapterConst = var_6

				if var_102_4 ~= var_6.AttachNone then
					return false
				end
			end

			local var_102_5 = arg_102_0

			if arg_102_0.getChampion(var_102_5, arg_102_2, arg_102_3) then
				local var_102_6 = var_5.flag

				ChapterConst = var_102_5

				if var_102_6 ~= var_102_5.CellFlagDisabled then
					return false
				end
			end
		end
	end

	return true
end

function var_0_0.existAny(arg_103_0, arg_103_1, arg_103_2)
	local var_103_0 = arg_103_0
	local var_103_1 = arg_103_0.getChapterCell(var_103_0, arg_103_1, arg_103_2).attachment

	ChapterConst = var_103_0

	if var_103_1 ~= var_103_0.AttachNone then
		local var_103_2 = var_3.flag

		ChapterConst = var_5

		if var_103_2 == var_5.CellFlagActive then
			return true
		end
	end

	if arg_103_0:existFleet(nil, arg_103_1, arg_103_2) then
		return true
	end

	local var_103_3 = arg_103_0

	if arg_103_0.getChampion(var_103_3, arg_103_1, arg_103_2) then
		local var_103_4 = var_4.flag

		ChapterConst = var_103_3

		if var_103_4 ~= var_103_3.CellFlagDisabled then
			return true
		end
	end

	return
end

function var_0_0.existBarrier(arg_104_0, arg_104_1, arg_104_2)
	local var_104_0 = arg_104_0
	local var_104_1 = arg_104_0.getChapterCell(var_104_0, arg_104_1, arg_104_2).attachment

	ChapterConst = var_104_0

	if var_104_1 == var_104_0.AttachBox then
		local var_104_2 = var_3.flag

		ChapterConst = var_5

		if var_104_2 == var_5.CellFlagActive then
			pg = var_104_2

			local var_104_3 = var_104_2.box_data_template[var_3.attachmentId].type

			ChapterConst = var_5

			if var_104_3 == var_5.BoxBarrier then
				return true
			end
		end
	end

	local var_104_4 = var_3.attachment

	ChapterConst = var_5

	if var_104_4 == var_5.AttachStory then
		local var_104_5 = var_3.flag

		ChapterConst = var_5

		if var_104_5 == var_5.CellFlagTriggerActive then
			pg = var_104_5

			local var_104_6 = var_104_5.map_event_template[var_3.attachmentId].type

			ChapterConst = var_5

			if var_104_6 == var_5.StoryObstacle then
				return true
			end
		end
	end

	local var_104_7 = arg_104_0

	if arg_104_0.getChampion(var_104_7, arg_104_1, arg_104_2) then
		local var_104_8 = var_4.flag

		ChapterConst = var_104_7

		if var_104_8 ~= var_104_7.CellFlagDisabled then
			pg = var_104_8

			if var_104_8.expedition_data_template[var_4.attachmentId] then
				local var_104_9 = var_5.type

				ChapterConst = var_7

				if var_104_9 == var_7.ExpeditionTypeUnTouchable then
					return true
				end
			end
		end
	end

	return false
end

function var_0_0.GetEnemy(arg_105_0, arg_105_1, arg_105_2)
	local var_105_0 = arg_105_0

	if arg_105_0.getChapterCell(var_105_0, arg_105_1, arg_105_2) then
		local var_105_1 = var_3.flag

		ChapterConst = var_105_0

		if var_105_1 == var_105_0.CellFlagActive then
			ChapterConst = var_105_1

			if var_105_1.IsEnemyAttach(var_3.attachment) then
				return var_3
			end
		end
	end

	local var_105_2 = arg_105_0

	if arg_105_0.getChampion(var_105_2, arg_105_1, arg_105_2) then
		local var_105_3 = var_4.flag

		ChapterConst = var_105_2

		if var_105_3 ~= var_105_2.CellFlagDisabled then
			return var_4
		end
	end

	return
end

function var_0_0.existEnemy(arg_106_0, arg_106_1, arg_106_2, arg_106_3)
	ChapterConst = var_1_10004

	if arg_106_1 == var_1_10004.SubjectPlayer then
		local var_106_0 = arg_106_0

		if arg_106_0.GetEnemy(var_106_0, arg_106_2, arg_106_3) then
			local var_106_1

			isa = var_106_0

			local var_106_2 = var_4

			ChapterCell = var_1_10009

			if var_106_0(var_106_2, var_1_10009) then
				var_106_1 = var_4.attachment
			else
				ChapterConst = var_6
				var_106_1 = var_6.AttachChampion
			end

			return true, var_106_1
		end

		goto label_106_0
	end

	ChapterConst = var_4

	if arg_106_1 == var_4.SubjectChampion then
		local var_106_3 = arg_106_0
		local var_106_4 = arg_106_0.existFleet

		FleetType = var_1_10007

		if not var_106_4(var_106_3, var_1_10007.Normal, arg_106_2, arg_106_3) then
			do
				local var_106_5 = arg_106_0
				local var_106_6 = arg_106_0.existFleet

				FleetType = var_7

				if var_106_6(var_106_5, var_7.Transport, arg_106_2, arg_106_3) then
					return true
				end
			end

			::label_106_0::

			return
		end
	end
end

function var_0_0.existFleet(arg_107_0, arg_107_1, arg_107_2, arg_107_3)
	_ = var_1_10004

	if var_1_10004.any(arg_107_0.fleets, function(arg_108_0)
		return arg_108_0.line.row == arg_107_2 and arg_108_0.line.column == arg_107_3 and (not arg_107_1 or arg_108_0:getFleetType() == arg_107_1) and arg_108_0:isValid()
	end) then
		return true
	end

	return
end

function var_0_0.existVisibleChampion(arg_109_0, arg_109_1, arg_109_2)
	return arg_109_0:getChampion(arg_109_1, arg_109_2) and arg_109_0:getChampionVisibility(var_3)
end

function var_0_0.existAlly(arg_110_0, arg_110_1)
	_ = var_1_10002

	return var_1_10002.any(arg_110_0.fleets, function(arg_111_0)
		return arg_111_0.id ~= arg_110_1.id and arg_111_0.line.row == arg_110_1.line.row and arg_111_0.line.column == arg_110_1.line.column and arg_111_0:isValid()
	end)
end

function var_0_0.existOni(arg_112_0, arg_112_1, arg_112_2)
	_ = var_1_10003

	return var_1_10003.any(arg_112_0.champions, function(arg_113_0)
		local var_113_0 = arg_113_0.attachment

		ChapterConst = var_2_10002

		if var_113_0 == var_2_10002.AttachOni then
			local var_113_1 = arg_113_0.flag

			ChapterConst = var_2

			local var_113_2

			if var_113_1 ~= var_2.CellFlagActive or arg_112_1 and arg_112_1 ~= arg_113_0.row or arg_112_2 and arg_112_2 ~= arg_113_0.column then
				var_113_2 = false
			else
				var_113_2 = true
			end

			return var_113_2
		end
	end)
end

function var_0_0.existBombEnemy(arg_114_0, arg_114_1, arg_114_2)
	if arg_114_1 and arg_114_2 then
		local var_114_0 = arg_114_0
		local var_114_1 = arg_114_0.getChapterCell(var_114_0, arg_114_1, arg_114_2).attachment

		ChapterConst = var_114_0

		if var_114_1 == var_114_0.AttachBomb_Enemy then
			local var_114_2 = var_1_10003.flag

			ChapterConst = var_5

			local var_114_3

			if var_114_2 ~= var_5.CellFlagActive then
				var_114_3 = false
			else
				var_114_3 = true
			end

			do return var_114_3 end

			pairs = var_1_10003

			for iter_114_0, iter_114_1 in var_1_10003(arg_114_0.cells) do
				local var_114_4 = iter_114_1.attachment

				ChapterConst = var_1_10009

				if var_114_4 == var_1_10009.AttachBomb_Enemy then
					local var_114_5 = iter_114_1.flag

					ChapterConst = var_1_10009

					if var_114_5 == var_1_10009.CellFlagActive and (not arg_114_1 or arg_114_1 == iter_114_1.row) and (not arg_114_2 or arg_114_2 == iter_114_1.column) then
						return true
					end
				end
			end

			return false
		end
	end
end

function var_0_0.isPlayingWithBombEnemy(arg_115_0)
	pairs = var_1_10001

	for iter_115_0, iter_115_1 in var_1_10001(arg_115_0.cells) do
		local var_115_0 = iter_115_1.attachment

		ChapterConst = var_1_10007

		if var_115_0 == var_1_10007.AttachBomb_Enemy then
			return true
		end
	end

	return false
end

function var_0_0.existCoastalGunNoMatterLiveOrDead(arg_116_0)
	pairs = var_1_10001

	for iter_116_0, iter_116_1 in var_1_10001(arg_116_0.cells) do
		local var_116_0 = iter_116_1.attachment

		ChapterConst = var_1_10007

		if var_116_0 == var_1_10007.AttachLandbase then
			pg = var_116_0

			local var_116_1 = var_116_0.land_based_template[iter_116_1.attachmentId]

			assert = var_1_10007

			var_1_10007(var_116_1, "land_based_template not exist: " .. iter_116_1.attachmentId)

			var_1_10007 = var_116_1.type
			ChapterConst = var_1_10008

			if var_1_10007 == var_1_10008.LBCoastalGun then
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

function var_0_0.calcWalkableCells(arg_117_0, arg_117_1, arg_117_2, arg_117_3, arg_117_4)
	local var_117_0 = {}
	local var_117_1 = 0

	ChapterConst = var_1_10007

	for iter_117_0 = var_117_1, var_1_10007.MaxRow - 1 do
		if not var_117_0[iter_117_0] then
			var_117_0[iter_117_0] = {}
		end

		local var_117_2 = 0

		ChapterConst = var_1_10011

		for iter_117_1 = var_117_2, var_1_10011.MaxColumn - 1 do
			ChapterCell = var_1_10014
			var_1_10014 = var_1_10014.Line2Name(iter_117_0, iter_117_1)

			local var_117_3 = arg_117_0.cells[var_1_10014]

			var_117_0[iter_117_0][iter_117_1] = var_117_3 and var_117_3:IsWalkable()
		end
	end

	local var_117_4 = {}

	ChapterConst = var_7

	if arg_117_1 == var_7.SubjectPlayer then
		local var_117_5 = arg_117_0:getCoastalGunArea()

		ipairs = var_8

		for iter_117_2, iter_117_3 in var_8(var_117_5) do
			var_117_4[iter_117_3.row .. "_" .. iter_117_3.column] = true
		end
	end

	local var_117_6 = {}

	if not arg_117_0:GetRawChapterCell(arg_117_2, arg_117_3) then
		return var_117_6
	end

	local var_117_7 = {
		{
			step = 0,
			row = arg_117_2,
			column = arg_117_3,
			forbiddens = var_8.forbiddenDirections
		}
	}
	local var_117_8 = {}

	::label_117_0::

	local var_117_9 = #var_117_7

	if 0 < var_117_9 then
		repeat
			table = var_117_9
			var_117_9 = var_117_9.remove(var_117_7, 1)
			table = var_12

			var_12.insert(var_117_8, var_117_9)

			_ = var_12

			var_12.each(var_0_1, function(arg_118_0)
				local var_118_0 = {
					row = var_117_9.row + arg_118_0[1],
					column = var_117_9.column + arg_118_0[2],
					step = var_117_9.step + 1
				}
				local var_118_1 = arg_117_0

				if not var_2.GetRawChapterCell(var_118_1, var_118_0.row, var_118_0.column) then
					return
				end

				var_118_0.forbiddens = var_2.forbiddenDirections

				if var_118_0.step <= arg_117_4 then
					OrientedPathFinding = var_3

					if not var_3.IsDirectionForbidden(var_117_9, arg_118_0[1], arg_118_0[2]) then
						_ = var_3

						local var_118_2

						if not var_3.any(var_117_7, function(arg_119_0)
							return arg_119_0.row == var_118_0.row and arg_119_0.column == var_118_0.column
						end) then
							_ = var_118_2
							var_118_2 = var_118_2.any(var_117_8, function(arg_120_0)
								return arg_120_0.row == var_118_0.row and arg_120_0.column == var_118_0.column
							end)
						end

						if not var_118_2 and var_117_0[var_118_0.row][var_118_0.column] then
							table = var_4

							var_4.insert(var_117_6, var_118_0)

							local var_118_3 = arg_117_0

							if not var_4.existEnemy(var_118_3, arg_117_1, var_118_0.row, var_118_0.column) then
								local var_118_4 = arg_117_0

								if not var_4.existBarrier(var_118_4, var_118_0.row, var_118_0.column) and not var_117_4[var_118_0.row .. "_" .. var_118_0.column] then
									table = var_4

									var_4.insert(var_117_7, var_118_0)
								end
							end
						end
					end
				end

				return
			end)

			goto label_117_0
		until true
	end

	_ = var_117_9

	return (var_117_9.filter(var_117_6, function(arg_121_0)
		local var_121_1

		if arg_121_0.row ~= arg_117_2 or arg_121_0.column ~= arg_117_3 then
			local var_121_0 = arg_117_0

			var_121_1 = var_1.considerAsStayPoint(var_121_0, arg_117_1, arg_121_0.row, arg_121_0.column)

			if false then
				var_121_1 = false
			end
		else
			var_121_1 = true
		end

		return var_121_1
	end))
end

function var_0_0.calcAreaCells(arg_122_0, arg_122_1, arg_122_2, arg_122_3, arg_122_4)
	local var_122_0 = {}
	local var_122_1 = 0

	ChapterConst = var_1_10007

	for iter_122_0 = var_122_1, var_1_10007.MaxRow - 1 do
		if not var_122_0[iter_122_0] then
			var_122_0[iter_122_0] = {}
		end

		local var_122_2 = 0

		ChapterConst = var_1_10011

		for iter_122_1 = var_122_2, var_1_10011.MaxColumn - 1 do
			ChapterCell = var_1_10014
			var_1_10014 = var_1_10014.Line2Name(iter_122_0, iter_122_1)

			local var_122_3 = arg_122_0.cells[var_1_10014]

			var_122_0[iter_122_0][iter_122_1] = var_122_3 and var_122_3:IsWalkable()
		end
	end

	local var_122_4 = {}
	local var_122_5 = {
		{
			step = 0,
			row = arg_122_1,
			column = arg_122_2
		}
	}
	local var_122_6 = {}

	::label_122_0::

	local var_122_7 = #var_122_5

	if 0 < var_122_7 then
		repeat
			table = var_122_7
			var_122_7 = var_122_7.remove(var_122_5, 1)
			table = var_10

			var_10.insert(var_122_6, var_122_7)

			_ = var_10

			var_10.each(var_0_1, function(arg_123_0)
				local var_123_0 = ({
					row = var_122_7.row + arg_123_0[1],
					column = var_122_7.column + arg_123_0[2],
					step = var_122_7.step + 1
				}).row

				if 0 <= var_123_0 then
					local var_123_1 = var_1.row

					ChapterConst = var_3

					if var_123_1 < var_3.MaxRow then
						local var_123_2 = var_1.column

						if 0 <= var_123_2 then
							local var_123_3 = var_1.column

							ChapterConst = var_3

							if var_123_3 < var_3.MaxColumn and var_1.step <= arg_122_4 then
								_ = var_2

								local var_123_4

								if not var_2.any(var_122_5, function(arg_124_0)
									return arg_124_0.row == var_0.row and arg_124_0.column == var_0.column
								end) then
									_ = var_123_4
									var_123_4 = var_123_4.any(var_122_6, function(arg_125_0)
										return arg_125_0.row == var_0.row and arg_125_0.column == var_0.column
									end)
								end

								if not var_123_4 then
									table = var_3

									var_3.insert(var_122_5, var_1)

									if var_122_0[var_1.row][var_1.column] and var_1.step >= arg_122_3 then
										table = var_3

										var_3.insert(var_122_4, var_1)
									end
								end
							end
						end
					end
				end

				return
			end)

			goto label_122_0
		until true
	end

	return var_122_4
end

function var_0_0.calcSquareBarrierCells(arg_126_0, arg_126_1, arg_126_2, arg_126_3)
	local var_126_0 = {}

	for iter_126_0 = -arg_126_3, arg_126_3 do
		for iter_126_1 = -arg_126_3, arg_126_3 do
			local var_126_1 = arg_126_1 + iter_126_0
			local var_126_2 = arg_126_2 + iter_126_1

			if arg_126_0:getChapterCell(var_126_1, var_126_2) and var_15:IsWalkable() and (arg_126_0:existBarrier(var_126_1, var_126_2) or not arg_126_0:existAny(var_126_1, var_126_2)) then
				table = var_16

				var_16.insert(var_126_0, {
					row = var_126_1,
					column = var_126_2
				})
			end
		end
	end

	return var_126_0
end

function var_0_0.checkAnyInteractive(arg_127_0)
	local var_127_0 = arg_127_0.fleet.line
	local var_127_1 = arg_127_0:getChapterCell(var_127_0.row, var_127_0.column)
	local var_127_2 = false
	local var_127_3 = arg_127_0.fleet
	local var_127_4 = var_4.getFleetType(var_127_3)

	FleetType = var_5

	if var_127_4 == var_5.Normal then
		local var_127_5 = arg_127_0
		local var_127_6 = arg_127_0.existEnemy

		ChapterConst = var_1_10007

		if var_127_6(var_127_5, var_1_10007.SubjectPlayer, var_127_1.row, var_127_1.column) then
			local var_127_7 = arg_127_0:getRound()

			ChapterConst = var_5

			if var_127_7 == var_5.RoundPlayer then
				var_127_2 = true
			end

			goto label_127_0
		end

		local var_127_8 = var_127_1.attachment

		ChapterConst = var_5

		if var_127_8 ~= var_5.AttachAmbush then
			do
				local var_127_9 = var_127_1.attachment

				ChapterConst = var_5

				if var_127_9 == var_5.AttachBox then
					local var_127_10 = var_127_1.flag

					ChapterConst = var_5

					if var_127_10 ~= var_5.CellFlagDisabled then
						var_127_2 = true
					end
				else
					local var_127_11 = var_127_1.attachment

					ChapterConst = var_5

					if var_127_11 == var_5.AttachStory then
						local var_127_12 = var_127_1.flag

						ChapterConst = var_5
						var_127_2 = var_127_12 == var_5.CellFlagActive
					else
						local var_127_13 = var_127_1.attachment

						ChapterConst = var_5

						local var_127_16

						if var_127_13 == var_5.AttachSupply then
							local var_127_14 = var_127_1.attachmentId

							if 0 < var_127_14 then
								local var_127_15

								var_127_15, var_127_16 = arg_127_0:getFleetAmmo(arg_127_0.fleet)

								if var_127_16 < var_127_15 then
									var_127_2 = true
								end

								goto label_127_0
							end
						end

						local var_127_17 = var_127_1.attachment

						ChapterConst = var_127_16

						if var_127_17 == var_127_16.AttachBox then
							local var_127_18 = var_127_1.flag

							ChapterConst = var_5

							if var_127_18 ~= var_5.CellFlagDisabled then
								var_127_2 = true
							end
						end
					end
				end
			end

			::label_127_0::

			return var_127_2
		end
	end
end

function var_0_0.getQuadCellPic(arg_128_0, arg_128_1)
	local var_128_0
	local var_128_1 = arg_128_1.trait

	ChapterConst = var_1_10004

	if var_128_1 == var_1_10004.TraitLurk then
		goto label_128_1
	end

	local var_128_2 = arg_128_1.flag

	ChapterConst = var_4

	if var_128_2 == var_4.CellFlagActive then
		ChapterConst = var_128_2

		if var_128_2.IsEnemyAttach(arg_128_1.attachment) then
			local var_128_3 = arg_128_1.flag

			ChapterConst = var_4

			if var_128_3 == var_4.CellFlagActive then
				var_128_0 = "cell_enemy"

				goto label_128_1
			end
		end
	end

	local var_128_4 = arg_128_1.attachment

	ChapterConst = var_4

	if var_128_4 == var_4.AttachBox then
		local var_128_5 = arg_128_1.flag

		ChapterConst = var_128_7

		if var_128_5 == var_128_7.CellFlagActive then
			pg = var_128_5

			local var_128_6 = var_128_5.box_data_template[arg_128_1.attachmentId]

			assert = var_128_7

			var_128_7(var_128_6, "box_data_template not exist: " .. arg_128_1.attachmentId)

			local var_128_7 = var_128_6.type

			ChapterConst = var_1_10005

			if var_128_7 ~= var_1_10005.BoxDrop then
				var_128_7 = var_128_6.type
				ChapterConst = var_1_10005

				if var_128_7 ~= var_1_10005.BoxStrategy then
					var_128_7 = var_128_6.type
					ChapterConst = var_1_10005

					if var_128_7 ~= var_1_10005.BoxSupply then
						var_128_7 = var_128_6.type
						ChapterConst = var_1_10005

						if var_128_7 == var_1_10005.BoxEnemy then
							var_128_0 = "cell_box"
						else
							var_128_7 = var_128_6.type
							ChapterConst = var_1_10005

							if var_128_7 == var_1_10005.BoxTorpedo then
								var_128_0 = "cell_enemy"
							else
								var_128_7 = var_128_6.type
								ChapterConst = var_1_10005

								if var_128_7 == var_1_10005.BoxBarrier then
									var_128_0 = "cell_green"
								end
							end
						end

						goto label_128_1

						local var_128_8 = arg_128_1.attachment

						ChapterConst = var_128_7

						if var_128_8 == var_128_7.AttachStory then
							local var_128_9 = arg_128_1.flag

							ChapterConst = var_128_10

							if var_128_9 == var_128_10.CellFlagTriggerActive then
								pg = var_128_9

								if var_128_9.map_event_template[arg_128_1.attachmentId].grid_color then
									local var_128_10 = #var_3

									if not (0 < var_128_10) or not var_3 then
										::label_128_0::

										var_128_0 = nil
									end

									goto label_128_1

									local var_128_11 = arg_128_1.attachment

									ChapterConst = var_128_10

									if var_128_11 == var_128_10.AttachSupply then
										local var_128_12 = arg_128_1.attachmentId

										if 0 < var_128_12 then
											var_128_0 = "cell_box"

											goto label_128_1
										end
									end

									local var_128_13 = arg_128_1.attachment

									ChapterConst = var_4

									if var_128_13 == var_4.AttachTransport_Target then
										var_128_0 = "cell_box"

										goto label_128_1
									end

									local var_128_14 = arg_128_1.attachment

									ChapterConst = var_4

									if var_128_14 == var_4.AttachLandbase then
										pg = var_128_14

										if var_128_14.land_based_template[arg_128_1.attachmentId] then
											local var_128_15 = var_3.type

											ChapterConst = var_1_10005

											if var_128_15 ~= var_1_10005.LBHarbor then
												do
													local var_128_16 = var_3.type

													ChapterConst = var_5

													if var_128_16 == var_5.LBDock then
														var_128_0 = "cell_box"
													end
												end

												::label_128_1::

												return var_128_0
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

function var_0_0.getMapShip(arg_129_0, arg_129_1)
	local var_129_0

	if arg_129_1:isValid() then
		_ = var_3

		local var_129_1 = var_3.detect
		local var_129_2 = arg_129_1

		if not var_129_1(arg_129_1.getShips(var_129_2, false), function(arg_130_0)
			local var_130_0

			if arg_130_0.isNpc then
				var_130_0 = arg_130_0.hpRant > 0
			end

			return var_130_0
		end) then
			local var_129_3 = arg_129_1:getFleetType()

			FleetType = var_1_10004

			local var_129_5

			if var_129_3 == var_1_10004.Normal then
				local var_129_4 = arg_129_1

				var_129_5 = arg_129_1.getShipsByTeam
				TeamType = var_129_2
				var_129_0 = var_129_5(var_129_4, var_129_2.Main, false)[1]
			else
				FleetType = var_129_5

				if var_129_3 == var_129_5.Submarine then
					local var_129_6 = arg_129_1
					local var_129_7 = arg_129_1.getShipsByTeam

					TeamType = var_129_2
					var_129_0 = var_129_7(var_129_6, var_129_2.Submarine, false)[1]
				end
			end
		end
	end

	return var_129_0
end

function var_0_0.getStrikeAnimShip(arg_131_0, arg_131_1, arg_131_2)
	underscore = var_1_10003

	return var_1_10003.detect(arg_131_1:getShips(false), function(arg_132_0)
		return arg_132_0:GetMapStrikeAnim() == arg_131_2
	end)
end

function var_0_0.GetSubmarineFleet(arg_133_0)
	table = var_1_10001

	return var_1_10001.Find(arg_133_0.fleets, function(arg_134_0, arg_134_1)
		local var_134_0 = arg_134_1:getFleetType()

		FleetType = var_2_10003

		return var_134_0 == var_2_10003.Submarine and arg_134_1:isValid()
	end)
end

function var_0_0.getStageCell(arg_135_0, arg_135_1, arg_135_2)
	local var_135_0 = arg_135_0

	if arg_135_0.getChampion(var_135_0, arg_135_1, arg_135_2) then
		local var_135_1 = var_3.flag

		ChapterConst = var_135_0

		if var_135_1 ~= var_135_0.CellFlagDisabled then
			return var_3
		end
	end

	local var_135_2 = arg_135_0

	if arg_135_0.getChapterCell(var_135_2, arg_135_1, arg_135_2) then
		local var_135_3 = var_4.flag

		ChapterConst = var_135_2

		if var_135_3 ~= var_135_2.CellFlagDisabled then
			return var_4
		end
	end

	return
end

function var_0_0.getStageId(arg_136_0, arg_136_1, arg_136_2)
	local var_136_0 = arg_136_0

	if arg_136_0.getChampion(var_136_0, arg_136_1, arg_136_2) then
		local var_136_1 = var_3.flag

		ChapterConst = var_136_0

		if var_136_1 ~= var_136_0.CellFlagDisabled then
			return var_3.id
		end
	end

	local var_136_2 = arg_136_0

	if arg_136_0.getChapterCell(var_136_2, arg_136_1, arg_136_2) then
		local var_136_3 = var_4.flag

		ChapterConst = var_136_2

		if var_136_3 ~= var_136_2.CellFlagDisabled then
			return var_4.attachmentId
		end
	end

	return
end

function var_0_0.getStageExtraAwards(arg_137_0)
	return
end

function var_0_0.GetExtraCostRate(arg_138_0)
	local var_138_0 = 1
	local var_138_1 = {}

	ipairs = var_1_10003

	for iter_138_0, iter_138_1 in var_1_10003(arg_138_0.operationBuffList) do
		pg = var_1_10008
		var_1_10008 = var_1_10008.benefit_buff_template[iter_138_1]
		var_138_1[#var_138_1 + 1] = var_1_10008

		if var_1_10008.benefit_type == var_0_0.OPERATION_BUFF_TYPE_COST then
			var_138_0 = var_138_0 + var_1_10008.benefit_effect * 0.01
		end
	end

	math = var_3

	return var_3.max(1, var_138_0), var_138_1
end

function var_0_0.getFleetCost(arg_139_0, arg_139_1, arg_139_2)
	local var_139_0 = arg_139_0:getPlayType()

	ChapterConst = var_1_10004

	if var_139_0 == var_1_10004.TypeExtra then
		return {
			gold = 0,
			oil = 0
		}, {
			gold = 0,
			oil = 0
		}
	end

	local var_139_1, var_139_2 = arg_139_1:getCost()
	local var_139_3 = arg_139_0
	local var_139_4 = arg_139_0.GetLimitOilCost
	local var_139_5 = arg_139_1:getFleetType()

	FleetType = var_1_10009

	local var_139_6 = var_139_4(var_139_3, var_139_5 == var_1_10009.Submarine, arg_139_2)

	math = var_1_10006
	var_139_2.oil = var_1_10006.clamp(var_139_6 - var_139_1.oil, 0, var_139_2.oil)

	local var_139_7 = arg_139_0:GetExtraCostRate()

	ipairs = var_139_3

	for iter_139_0, iter_139_1 in var_139_3({
		var_139_1,
		var_139_2
	}) do
		pairs = var_1_10012

		for iter_139_2, iter_139_3 in var_1_10012(iter_139_1) do
			iter_139_1[iter_139_2] = iter_139_1[iter_139_2] * var_139_7
		end
	end

	return var_139_1, var_139_2
end

function var_0_0.isOverFleetCost(arg_140_0, arg_140_1, arg_140_2)
	local var_140_0 = arg_140_0
	local var_140_1 = arg_140_0.GetLimitOilCost
	local var_140_2 = arg_140_1:getFleetType()

	FleetType = var_1_10007

	local var_140_3 = var_140_1(var_140_0, var_140_2 == var_1_10007.Submarine, arg_140_2)
	local var_140_4 = 0

	ipairs = var_140_0

	for iter_140_0, iter_140_1 in var_140_0({
		arg_140_1:getCost()
	}) do
		var_140_4 = var_140_4 + iter_140_1.oil
	end

	local var_140_5 = arg_140_0:GetExtraCostRate()

	return var_140_3 < var_140_4, var_140_3 * var_140_5, var_140_4 * var_140_5
end

function var_0_0.writeBack(arg_141_0, arg_141_1, arg_141_2)
	local var_141_0 = arg_141_0.fleet

	local function var_141_1(arg_142_0)
		if not arg_141_2.statistics[arg_142_0.id] then
			return
		end

		arg_142_0.hpRant = var_1.bp

		return
	end

	pairs = var_1_10005

	for iter_141_0, iter_141_1 in var_1_10005(var_141_0.ships) do
		var_141_1(iter_141_1)
	end

	var_141_0:ResortShips()

	if not arg_141_2.skipAmmo then
		math = var_5
		var_141_0.restAmmo = var_5.max(var_141_0.restAmmo - 1, 0)
	end

	_ = var_5

	local var_141_2 = var_5.filter(var_141_0:getStrategies(), function(arg_143_0)
		pg = var_2_10001

		local var_143_0

		if var_2_10001.strategy_data_template[arg_143_0.id] then
			::label_143_0::

			var_143_0 = var_1.type
			ChapterConst = var_2_10003
			var_143_0 = var_143_0 == var_2_10003.StgTypeBindFleetPassive and arg_143_0.count > 0
		end

		return var_143_0
	end)

	_ = var_6

	var_6.each(var_141_2, function(arg_144_0)
		local var_144_0 = var_141_0

		var_1.consumeOneStrategy(var_144_0, arg_144_0.id)

		return
	end)

	if arg_141_2.statistics.submarineAid then
		local var_141_4

		if arg_141_0:GetSubmarineFleet() and not var_6:inHuntingRange(var_141_0.line.row, var_141_0.line.column) then
			local var_141_3 = var_6

			var_141_4 = var_6.consumeOneStrategy
			ChapterConst = var_10

			var_141_4(var_141_3, var_10.StrategyCallSubOutofRange)
		end

		if var_6 then
			pairs = var_141_4

			for iter_141_2, iter_141_3 in var_141_4(var_6.ships) do
				var_141_1(iter_141_3)
			end

			math = var_7
			var_6.restAmmo = var_7.max(var_6.restAmmo - 1, 0)
		end
	end

	arg_141_0:UpdateComboHistory(arg_141_2.statistics._battleScore)

	if arg_141_1 then
		local var_141_5
		local var_141_6
		local var_141_7 = arg_141_0
		local var_141_8

		if arg_141_0.getChampion(var_141_7, var_141_0.line.row, var_141_0.line.column) then
			var_8:Iter()

			var_141_5 = var_8.attachment
			var_141_6 = var_8.attachmentId
			var_141_8 = var_8.flag
			ChapterConst = var_141_7

			if var_141_8 == var_141_7.CellFlagDisabled then
				arg_141_0:RemoveChampion(var_8)
			end

			goto label_141_0
		end

		var_141_5 = arg_141_0:getChapterCell(var_141_0.line.row, var_141_0.line.column).attachment
		var_141_6 = var_141_8.attachmentId
		ChapterConst = var_141_7

		if var_141_5 ~= var_141_7.AttachEnemy then
			ChapterConst = var_141_7

			if var_141_5 == var_141_7.AttachBoss then
				ChapterConst = var_141_7
				var_141_8.flag = var_141_7.CellFlagDisabled

				arg_141_0:updateChapterCell(var_141_8)
			else
				arg_141_0:clearChapterCell(var_141_8.row, var_141_8.column)
			end

			::label_141_0::

			assert = var_141_8

			var_141_8(var_141_5, "attachment can not be nil.")

			ChapterConst = var_141_8

			if var_141_5 ~= var_141_8.AttachEnemy then
				ChapterConst = var_141_9

				if var_141_5 ~= var_141_9.AttachElite then
					ChapterConst = var_141_9

					if var_141_5 == var_141_9.AttachChampion then
						if var_8 then
							local var_141_9 = var_8.flag

							ChapterConst = var_141_7

							if var_141_9 == var_141_7.CellFlagDisabled then
								_ = var_141_9

								if var_141_9.detect(arg_141_0.achieves, function(arg_145_0)
									local var_145_0 = arg_145_0.type

									ChapterConst = var_2_10002

									return var_145_0 == var_2_10002.AchieveType2
								end) then
									var_141_9.count = var_141_9.count + 1
								end

								goto label_141_1

								ChapterConst = var_141_9

								if var_141_5 == var_141_9.AttachBoss then
									_ = var_9

									if var_9.detect(arg_141_0.achieves, function(arg_146_0)
										local var_146_0 = arg_146_0.type

										ChapterConst = var_2_10002

										return var_146_0 == var_2_10002.AchieveType1
									end) then
										var_9.count = var_9.count + 1
									end
								end
							end

							::label_141_1::

							local var_141_10 = arg_141_0

							if arg_141_0.CheckChapterWin(var_141_10) then
								pg = var_9
								var_141_10 = var_9.TrackerMgr.GetInstance()

								local var_141_11 = var_9.Tracking

								TRACKING_KILL_BOSS = var_141_15

								var_141_11(var_141_10, var_141_15)
							end

							local var_141_12 = false

							if var_8 then
								local var_141_13 = var_8.flag

								ChapterConst = var_141_10
								var_141_12 = var_141_13 == var_141_10.CellFlagDisabled
							else
								local var_141_14 = arg_141_2.system

								SYSTEM_SCENARIO_SUB_STRIKE = var_141_10

								if var_141_14 == var_141_10 then
									var_141_12 = false
								else
									ChapterConst = var_141_14
									var_141_12 = var_141_5 ~= var_141_14.AttachBox
								end
							end

							if var_141_12 then
								var_141_0.defeatEnemies = var_141_0.defeatEnemies + 1
								ChapterConst = var_10

								local var_141_15

								if var_141_5 ~= var_10.AttachAmbush then
									var_141_15 = arg_141_0

									if arg_141_0.IsFogStage(var_141_15) then
										var_141_0.visibleLevel = var_141_0.visibleLevel + 1
										var_141_15 = var_141_0

										var_141_0.UpdateVisible(var_141_15)
									end
								end

								arg_141_0.defeatEnemies = arg_141_0.defeatEnemies + 1
								pg = var_10

								local var_141_16 = var_10.expedition_data_template[var_141_6]
								local var_141_17 = arg_141_0
								local var_141_18

								if not arg_141_0.isLoop(var_141_17) and var_141_16 then
									var_141_18 = var_141_16.type
									ChapterConst = var_141_15

									if var_141_18 == var_141_15.ExpeditionTypeMulBoss then
										pg = var_141_18
										var_141_18 = var_141_18.chapter_model_multistageboss[arg_141_0.id].guild_buff

										local var_141_19 = var_141_0:GetStatusStrategy()

										_ = var_141_17

										var_141_17.each(var_141_18, function(arg_147_0)
											table = var_2_10001

											if not var_2_10001.contains(var_141_19, arg_147_0) then
												table = var_1

												var_1.insert(var_141_19, arg_147_0)
											end

											return
										end)

										if arg_141_0:getNextValidIndex() > 0 then
											local var_141_20 = arg_141_0.fleets[var_141_17]

											var_141_19 = var_14.GetStatusStrategy(var_141_20)
											_ = var_15

											var_15.each(var_141_18, function(arg_148_0)
												table = var_2_10001

												var_2_10001.removebyvalue(var_141_19, arg_148_0)

												return
											end)
										end
									end
								end

								getProxy = var_141_18
								ChapterProxy = var_141_17

								local var_141_21 = var_141_18(var_141_17)

								var_11.RecordLastDefeatedEnemy(var_141_21, arg_141_0.id, {
									score = arg_141_2.statistics._battleScore,
									line = {
										row = var_141_0.line.row,
										column = var_141_0.line.column
									},
									attachment = var_141_5,
									attachmentId = var_141_6
								})
							end

							return
						end
					end
				end
			end
		end
	end
end

function var_0_0.CleanCurrentEnemy(arg_149_0)
	local var_149_0 = arg_149_0.fleet.line
	local var_149_1

	if arg_149_0:getChampion(var_149_0.row, var_149_0.column) then
		var_3:Iter()

		local var_149_2 = var_3.flag

		ChapterConst = var_1_10005

		if var_149_2 == var_1_10005.CellFlagDisabled then
			arg_149_0:RemoveChampion(var_3)
		end

		return
	end

	local var_149_3 = arg_149_0:getChapterCell(var_149_0.row, var_149_0.column).attachment

	ChapterConst = var_1_10005

	if var_149_3 == var_1_10005.AttachEnemy then
		arg_149_0:clearChapterCell(var_149_0.row, var_149_0.column)

		return
	end

	return
end

function var_0_0.UpdateProgressAfterSkipBattle(arg_150_0)
	local var_150_0 = arg_150_0
	local var_150_1 = arg_150_0.writeBack
	local var_150_2 = true
	local var_150_3 = {
		skipAmmo = true
	}
	local var_150_4 = {}

	ys = var_1_10007
	var_150_4._battleScore = var_1_10007.Battle.BattleConst.BattleScore.S
	var_150_3.statistics = var_150_4

	var_150_1(var_150_0, var_150_2, var_150_3)

	return
end

function var_0_0.UpdateProgressOnRetreat(arg_151_0)
	_ = var_1_10001

	var_1_10001.each(arg_151_0.achieves, function(arg_152_0)
		local var_152_0 = arg_152_0.type

		ChapterConst = var_2_10002

		if var_152_0 == var_2_10002.AchieveType3 then
			_ = var_152_0

			local var_152_1 = var_152_0.all

			_ = var_2_10003

			if var_152_1(var_2_10003.values(arg_151_0.cells), function(arg_153_0)
				local var_153_0 = arg_153_0.attachment

				ChapterConst = var_3_10002

				if var_153_0 ~= var_3_10002.AttachEnemy then
					local var_153_1 = arg_153_0.attachment

					ChapterConst = var_2

					if var_153_1 ~= var_2.AttachElite then
						local var_153_2 = arg_153_0.attachment

						ChapterConst = var_2

						if var_153_2 == var_2.AttachBox then
							pg = var_153_2

							local var_153_3 = var_153_2.box_data_template[arg_153_0.attachmentId].type

							ChapterConst = var_2

							if var_153_3 == var_2.BoxEnemy then
								local var_153_4 = arg_153_0.flag

								ChapterConst = var_2

								return var_153_4 == var_2.CellFlagDisabled
							end
						end

						return true
					end
				end
			end) then
				_ = var_1

				if var_1.all(arg_151_0.champions, function(arg_154_0)
					local var_154_0 = arg_154_0.flag

					ChapterConst = var_3_10002

					return var_154_0 == var_3_10002.CellFlagDisabled
				end) then
					arg_152_0.count = arg_152_0.count + 1
				end
			end
		else
			local var_152_2 = arg_152_0.type

			ChapterConst = var_2

			if var_152_2 == var_2.AchieveType4 then
				if arg_151_0.orignalShipCount <= arg_152_0.config then
					arg_152_0.count = arg_152_0.count + 1
				end
			else
				local var_152_3 = arg_152_0.type

				ChapterConst = var_2

				if var_152_3 == var_2.AchieveType5 then
					_ = var_152_3

					local var_152_4 = var_152_3.any
					local var_152_5 = arg_151_0

					if not var_152_4(var_3.getShips(var_152_5), function(arg_155_0)
						return arg_155_0:getShipType() == arg_152_0.config
					end) then
						arg_152_0.count = arg_152_0.count + 1
					end
				else
					local var_152_6 = arg_152_0.type

					ChapterConst = var_2

					if var_152_6 == var_2.AchieveType6 then
						local var_152_7

						if not arg_151_0.scoreHistory[0] then
							var_152_7 = 0
						end

						local var_152_8

						if not arg_151_0.scoreHistory[1] then
							var_152_8 = 0
						end

						local var_152_9 = var_152_7 + var_152_8

						math = var_152_8

						local var_152_10 = var_152_8.max
						local var_152_11

						if not (var_152_9 <= 0) or not arg_151_0.combo then
							var_152_11 = 0
						end

						local var_152_12

						if not arg_152_0.count then
							var_152_12 = 0
						end

						arg_152_0.count = var_152_10(var_152_11, var_152_12)
					end
				end
			end
		end

		return
	end)

	if arg_151_0.progress == 100 then
		arg_151_0.passCount = arg_151_0.passCount + 1
	end

	local var_151_0 = arg_151_0.progress

	math = var_1_10002
	arg_151_0.progress = var_1_10002.min(arg_151_0.progress + arg_151_0:getConfig("progress_boss"), 100)

	local var_151_1

	if var_151_0 < 100 and 100 <= var_2 then
		getProxy = var_3
		ChapterProxy = var_151_1
		var_151_1 = var_3(var_151_1)

		var_3.RecordJustClearChapters(var_151_1, arg_151_0.id, true)
	end

	arg_151_0.defeatCount = arg_151_0.defeatCount + 1
	getProxy = var_3
	ChapterProxy = var_151_1

	local var_151_2 = var_3(var_151_1)
	local var_151_3 = var_3.getMapById
	local var_151_4 = arg_151_0
	local var_151_5 = var_151_3(var_151_2, arg_151_0.getConfig(var_151_4, "map"))
	local var_151_6 = var_3.getMapType(var_151_5)

	Map = var_151_2

	local var_151_8

	if var_151_6 == var_151_2.ELITE then
		pg = var_151_8

		local var_151_7 = var_151_8.TrackerMgr.GetInstance()

		var_151_8 = var_151_8.Tracking
		TRACKING_HARD_CHAPTER = var_151_4

		var_151_8(var_151_7, var_151_4, arg_151_0.id)
	else
		Map = var_151_8

		if var_151_6 == var_151_8.SCENARIO then
			if arg_151_0.progress == 100 and arg_151_0.passCount == 0 then
				pg = var_5

				local var_151_9 = var_5.TrackerMgr.GetInstance()
				local var_151_10 = var_5.Tracking

				TRACKING_HIGHEST_CHAPTER = var_151_4

				var_151_10(var_151_9, var_151_4, arg_151_0.id)
			end

			if arg_151_0.defeatCount == 1 then
				if arg_151_0.id == 304 then
					pg = var_5

					local var_151_11 = var_5.TrackerMgr.GetInstance()
					local var_151_12 = var_5.Tracking

					TRACKING_FIRST_PASS_3_4 = var_151_4

					var_151_12(var_151_11, var_151_4)
				elseif arg_151_0.id == 20 then
					pg = var_5

					local var_151_13 = var_5.TrackerMgr.GetInstance()
					local var_151_14 = var_5.Tracking

					TRACKING_FIRST_PASS_4_4 = var_151_4

					var_151_14(var_151_13, var_151_4)
				elseif arg_151_0.id == 504 then
					pg = var_5

					local var_151_15 = var_5.TrackerMgr.GetInstance()
					local var_151_16 = var_5.Tracking

					TRACKING_FIRST_PASS_5_4 = var_151_4

					var_151_16(var_151_15, var_151_4)
				elseif arg_151_0.id == 604 then
					pg = var_5

					local var_151_17 = var_5.TrackerMgr.GetInstance()
					local var_151_18 = var_5.Tracking

					TRACKING_FIRST_PASS_6_4 = var_151_4

					var_151_18(var_151_17, var_151_4)
				elseif arg_151_0.id == 1204 then
					pg = var_5

					local var_151_19 = var_5.TrackerMgr.GetInstance()
					local var_151_20 = var_5.Tracking

					TRACKING_FIRST_PASS_12_4 = var_151_4

					var_151_20(var_151_19, var_151_4)
				elseif arg_151_0.id == 21 then
					pg = var_5

					local var_151_21 = var_5.TrackerMgr.GetInstance()
					local var_151_22 = var_5.Tracking

					TRACKING_FIRST_PASS_13_1 = var_151_4

					var_151_22(var_151_21, var_151_4)
				elseif arg_151_0.id == 22 then
					pg = var_5

					local var_151_23 = var_5.TrackerMgr.GetInstance()
					local var_151_24 = var_5.Tracking

					TRACKING_FIRST_PASS_13_2 = var_151_4

					var_151_24(var_151_23, var_151_4)
				elseif arg_151_0.id == 23 then
					pg = var_5

					local var_151_25 = var_5.TrackerMgr.GetInstance()
					local var_151_26 = var_5.Tracking

					TRACKING_FIRST_PASS_13_3 = var_151_4

					var_151_26(var_151_25, var_151_4)
				elseif arg_151_0.id == 24 then
					pg = var_5

					local var_151_27 = var_5.TrackerMgr.GetInstance()
					local var_151_28 = var_5.Tracking

					TRACKING_FIRST_PASS_13_4 = var_151_4

					var_151_28(var_151_27, var_151_4)
				end
			end
		end
	end

	return
end

function var_0_0.UpdateComboHistory(arg_156_0, arg_156_1)
	getProxy = var_1_10002
	ChapterProxy = var_1_10004

	local var_156_0 = var_1_10002(var_1_10004)
	local var_156_1 = var_2.RecordComboHistory
	local var_156_2 = arg_156_0.id
	local var_156_3 = {}

	Clone = var_1_10007
	var_156_3.scoreHistory = var_1_10007(arg_156_0.scoreHistory)
	Clone = var_7
	var_156_3.combo = var_7(arg_156_0.combo)

	var_156_1(var_156_0, var_156_2, var_156_3)

	local var_156_4

	if not arg_156_0.scoreHistory then
		var_156_4 = {}
	end

	arg_156_0.scoreHistory = var_156_4

	local var_156_5 = arg_156_0.scoreHistory
	local var_156_6

	if not arg_156_0.scoreHistory[arg_156_1] then
		var_156_6 = 0
	end

	var_156_5[arg_156_1] = var_156_6 + 1
	ys = var_156_5

	if arg_156_1 <= var_156_5.Battle.BattleConst.BattleScore.C then
		arg_156_0.combo = 0
	else
		local var_156_7

		if not arg_156_0.combo then
			var_156_7 = 0
		end

		arg_156_0.combo = var_156_7 + 1
	end

	return
end

function var_0_0.GetWinConditions(arg_157_0)
	return arg_157_0.winConditions
end

function var_0_0.GetLoseConditions(arg_158_0)
	return arg_158_0.loseConditions
end

function var_0_0.CheckChapterWin(arg_159_0)
	local var_159_0 = arg_159_0
	local var_159_1 = arg_159_0.GetWinConditions(var_159_0)
	local var_159_2 = false

	ChapterConst = var_159_0

	local var_159_3 = var_159_0.ReasonVictory

	pairs = var_1_10004

	for iter_159_0, iter_159_1 in var_1_10004(var_159_1) do
		if iter_159_1.type == 1 then
			var_1_10011 = arg_159_0

			local var_159_4 = arg_159_0.findChapterCells

			ChapterConst = var_1_10012

			local var_159_5 = var_159_4(var_1_10011, var_1_10012.AttachBoss)

			var_1_10010 = 0
			_ = var_1_10011

			var_1_10011.each(var_159_5, function(arg_160_0)
				if arg_160_0 then
					local var_160_0 = arg_160_0.flag

					ChapterConst = var_2_10002

					if var_160_0 == var_2_10002.CellFlagDisabled then
						var_1_10010 = var_1_10010 + 1
					end
				end

				return
			end)

			var_159_2 = var_159_2 or iter_159_1.param <= var_1_10010
		elseif iter_159_1.type == 2 then
			if not var_159_2 then
				var_1_10011 = arg_159_0

				local var_159_6 = arg_159_0.GetDefeatCount(var_1_10011)

				var_159_2 = iter_159_1.param <= var_159_6
			end
		elseif iter_159_1.type == 3 then
			var_1_10011 = arg_159_0

			local var_159_7 = arg_159_0.CheckTransportState(var_1_10011)

			var_159_2 = var_159_2 or var_159_7 == 1
		elseif iter_159_1.type == 4 then
			if not var_159_2 then
				var_1_10011 = arg_159_0

				local var_159_8 = arg_159_0.getRoundNum(var_1_10011)

				var_159_2 = iter_159_1.param < var_159_8
			end
		elseif iter_159_1.type == 5 then
			local var_159_9 = iter_159_1.param

			_ = var_1_10010

			if not var_1_10010.any(arg_159_0.champions, function(arg_161_0)
				local var_161_0 = arg_161_0.attachmentId == var_159_9

				pairs = var_2

				for iter_161_0, iter_161_1 in var_2(arg_161_0.idList) do
					var_161_0 = var_161_0 or iter_161_1 == var_159_9
				end

				local var_161_1

				if var_161_0 then
					::label_161_0::

					var_161_1 = arg_161_0.flag
					ChapterConst = var_3
					var_161_1 = var_161_1 ~= var_3.CellFlagDisabled
				end

				return var_161_1
			end) then
				_ = var_1_10011
				var_1_10010 = var_1_10011.any(arg_159_0.cells, function(arg_162_0)
					local var_162_0

					if arg_162_0.attachmentId == var_159_9 then
						::label_162_0::

						var_162_0 = arg_162_0.flag
						ChapterConst = var_2_10003
						var_162_0 = var_162_0 ~= var_2_10003.CellFlagDisabled
					end

					return var_162_0
				end)
			end

			var_159_2 = var_159_2 or not var_1_10010
		elseif iter_159_1.type == 6 then
			local var_159_10 = iter_159_1.param

			_ = var_1_10010
			var_1_10010 = var_1_10010.any(arg_159_0.fleets, function(arg_163_0)
				local var_163_0 = arg_163_0:getFleetType()

				FleetType = var_2_10002

				if var_163_0 == var_2_10002.Normal then
					local var_163_1

					if arg_163_0:isValid() then
						if arg_163_0.line.row ~= var_159_10[1] or arg_163_0.line.column ~= var_159_10[2] then
							var_163_1 = false
						else
							var_163_1 = true
						end
					end

					return var_163_1
				end
			end)
			var_159_2 = var_159_2 or var_1_10010
		end

		if var_159_2 then
			break
		end
	end

	return var_159_2, var_159_3
end

function var_0_0.CheckChapterLose(arg_164_0)
	local var_164_0 = arg_164_0
	local var_164_1 = arg_164_0.GetLoseConditions(var_164_0)
	local var_164_2 = false

	ChapterConst = var_164_0

	local var_164_3 = var_164_0.ReasonDefeat

	pairs = var_1_10004

	for iter_164_0, iter_164_1 in var_1_10004(var_164_1) do
		if iter_164_1.type == 1 then
			_ = var_9

			local var_164_4 = var_9.any(arg_164_0.fleets, function(arg_165_0)
				local var_165_0 = arg_165_0:getFleetType()

				FleetType = var_2_10002

				return var_165_0 == var_2_10002.Normal and arg_165_0:isValid()
			end)

			var_164_2 = var_164_2 or not var_164_4
		elseif iter_164_1.type == 2 then
			var_164_2 = var_164_2 or arg_164_0.BaseHP <= 0

			if var_164_2 then
				ChapterConst = var_9
				var_164_3 = var_9.ReasonDefeatDefense or var_164_3
			end
		end

		if var_164_2 then
			break
		end
	end

	local var_164_5 = arg_164_0:getPlayType()

	ChapterConst = var_5

	if var_164_5 == var_5.TypeTransport then
		local var_164_6 = arg_164_0:CheckTransportState()

		var_164_2 = var_164_2 or var_164_6 == -1
	end

	return var_164_2, var_164_3
end

function var_0_0.CheckChapterWillWin(arg_166_0)
	if arg_166_0:existOni() or arg_166_0:isPlayingWithBombEnemy() then
		return true
	end

	if arg_166_0:CheckChapterWin() then
		return true
	end

	return
end

function var_0_0.triggerSkill(arg_167_0, arg_167_1, arg_167_2)
	_ = var_1_10003

	local var_167_0 = var_1_10003.filter(arg_167_1:findSkills(arg_167_2), function(arg_168_0)
		local var_168_0 = arg_168_0:GetTriggers()

		_ = var_2_10002

		local var_168_1 = var_2_10002.any(var_168_0, function(arg_169_0)
			local var_169_0 = arg_169_0[1]

			FleetSkill = var_3_10002

			return var_169_0 == var_3_10002.TriggerInSubTeam and arg_169_0[2] == 1
		end)
		local var_168_2 = arg_167_1
		local var_168_3 = var_3.getFleetType(var_168_2)

		FleetType = var_4

		local var_168_4

		if var_168_1 == (var_168_3 == var_4.Submarine) then
			_ = var_4
			var_168_4 = var_4.all(arg_168_0:GetTriggers(), function(arg_170_0)
				local var_170_0 = arg_167_0

				return var_1.triggerCheck(var_170_0, arg_167_1, arg_168_0, arg_170_0)
			end)
		else
			var_168_4 = false
		end

		if false then
			var_168_4 = true
		end

		return var_168_4
	end)

	_ = var_1_10004

	return var_1_10004.reduce(var_167_0, nil, function(arg_171_0, arg_171_1)
		local var_171_0 = arg_171_1
		local var_171_1 = arg_171_1.GetType(var_171_0)
		local var_171_2 = arg_171_1:GetArgs()

		FleetSkill = var_171_0

		if var_171_1 ~= var_171_0.TypeMoveSpeed then
			FleetSkill = var_171_3

			if var_171_1 ~= var_171_3.TypeHuntingLv then
				FleetSkill = var_171_3

				local var_171_3

				if var_171_1 == var_171_3.TypeTorpedoPowerUp then
					var_171_3 = arg_171_0 or 0

					do return var_171_3 + var_171_2[1] end

					goto label_171_0
				end

				FleetSkill = var_171_3

				if var_171_1 ~= var_171_3.TypeAmbushDodge then
					FleetSkill = var_4

					if var_171_1 == var_4.TypeAirStrikeDodge then
						math = var_4

						do return var_4.max(arg_171_0 or 0, var_171_2[1]) end

						goto label_171_0
					end

					FleetSkill = var_4

					if var_171_1 ~= var_4.TypeAttack then
						FleetSkill = var_4

						if var_171_1 == var_4.TypeStrategy then
							arg_171_0 = arg_171_0 or {}
							table = var_4

							var_4.insert(arg_171_0, var_171_2)

							return arg_171_0
						else
							FleetSkill = var_4

							if var_171_1 == var_4.TypeBattleBuff then
								arg_171_0 = arg_171_0 or {}
								table = var_4

								var_4.insert(arg_171_0, var_171_2[1])

								return arg_171_0
							end
						end

						::label_171_0::

						return
					end
				end
			end
		end
	end), var_167_0
end

function var_0_0.triggerCheck(arg_172_0, arg_172_1, arg_172_2, arg_172_3)
	local var_172_0 = arg_172_3[1]

	FleetSkill = var_1_10005

	local var_172_2

	if var_172_0 == var_1_10005.TriggerDDHead then
		local var_172_1 = arg_172_1

		var_172_2 = arg_172_1.getShipsByTeam
		TeamType = var_1_10008

		if #var_172_2(var_172_1, var_1_10008.Vanguard, false) > 0 then
			ShipType = var_1_10006
			var_1_10006 = var_1_10006.IsTypeQuZhu

			local var_172_3 = var_172_2[1]

			var_1_10006 = var_1_10006(var_1_10008.getShipType(var_172_3))
		else
			var_1_10006 = false
		end

		if false then
			var_1_10006 = true
		end

		return var_1_10006
	else
		FleetSkill = var_172_2

		local var_172_5

		if var_172_0 == var_172_2.TriggerVanCount then
			local var_172_4 = arg_172_1

			var_172_5 = arg_172_1.getShipsByTeam
			TeamType = var_1_10008
			var_1_10006 = #var_172_5(var_172_4, var_1_10008.Vanguard, false) >= arg_172_3[2] and #var_172_5 <= arg_172_3[3]

			return var_1_10006
		else
			FleetSkill = var_172_5

			if var_172_0 == var_172_5.TriggerShipCount then
				_ = var_5
				var_1_10006 = #var_5.filter(arg_172_1:getShips(false), function(arg_173_0)
					table = var_2_10001

					return var_2_10001.contains(arg_172_3[2], arg_173_0:getShipType())
				end) >= arg_172_3[3] and #var_5 <= arg_172_3[4]

				return var_1_10006
			else
				FleetSkill = var_5

				local var_172_6

				if var_172_0 == var_5.TriggerAroundEnemy then
					var_172_6 = {
						row = arg_172_1.line.row,
						column = arg_172_1.line.column
					}
					_ = var_1_10006
					var_1_10006 = var_1_10006.any
					_ = var_1_10008

					return var_1_10006(var_1_10008.values(arg_172_0.cells), function(arg_174_0)
						local var_174_0 = arg_172_0

						if not var_1.GetEnemy(var_174_0, arg_174_0.row, arg_174_0.column) then
							return
						end

						pg = var_2_10002

						if not var_2_10002.expedition_data_template[var_1.attachmentId] then
							return
						end

						local var_174_1 = var_2.type

						ManhattonDist = var_4

						if var_4(var_172_6, {
							row = arg_174_0.row,
							column = arg_174_0.column
						}) <= arg_172_3[2] then
							type = var_4

							local var_174_2

							if var_4(arg_172_3[3]) ~= "number" or arg_172_3[3] ~= var_174_1 then
								type = var_4

								if var_4(arg_172_3[3]) == "table" then
									table = var_4
									var_174_2 = var_4.contains(arg_172_3[3], var_174_1)

									goto label_174_0
								end

								var_174_2 = false
							else
								var_174_2 = true
							end

							::label_174_0::

							return var_174_2
						end
					end)
				else
					FleetSkill = var_172_6

					local var_172_7

					if var_172_0 == var_172_6.TriggerNekoPos then
						var_172_7 = arg_172_1:findCommanderBySkillId(arg_172_2.id)
						pairs = var_1_10006

						for iter_172_0, iter_172_1 in var_1_10006(arg_172_1:getCommanders()) do
							if var_172_7.id == iter_172_1.id and iter_172_0 == arg_172_3[2] then
								return true
							end
						end
					else
						FleetSkill = var_172_7

						local var_172_8

						if var_172_0 == var_172_7.TriggerAroundLand then
							var_172_8 = {
								row = arg_172_1.line.row,
								column = arg_172_1.line.column
							}
							_ = var_6

							local var_172_9 = var_6.any

							_ = var_1_10008

							return var_172_9(var_1_10008.values(arg_172_0.cells), function(arg_175_0)
								if not arg_175_0:IsWalkable() then
									ManhattonDist = var_1

									local var_175_0

									if not (var_1(var_172_8, {
										row = arg_175_0.row,
										column = arg_175_0.column
									}) <= arg_172_3[2]) then
										var_175_0 = false
									else
										var_175_0 = true
									end

									return var_175_0
								end
							end)
						else
							FleetSkill = var_172_8

							local var_172_10

							if var_172_0 == var_172_8.TriggerAroundCombatAlly then
								var_172_10 = {
									row = arg_172_1.line.row,
									column = arg_172_1.line.column
								}
								_ = var_6

								return var_6.any(arg_172_0.fleets, function(arg_176_0)
									if arg_172_1.id ~= arg_176_0.id then
										local var_176_0 = arg_176_0:getFleetType()

										FleetType = var_2

										if var_176_0 == var_2.Normal then
											local var_176_1 = arg_172_0

											var_176_0 = var_176_0.existEnemy
											ChapterConst = var_2_10004

											if var_176_0(var_176_1, var_2_10004.SubjectPlayer, arg_176_0.line.row, arg_176_0.line.column) then
												ManhattonDist = var_176_0

												if not (var_176_0(var_172_10, {
													row = arg_176_0.line.row,
													column = arg_176_0.line.column
												}) <= arg_172_3[2]) then
													var_176_0 = false
												else
													var_176_0 = true
												end
											end

											return var_176_0
										end
									end
								end)
							else
								FleetSkill = var_172_10

								if var_172_0 == var_172_10.TriggerInSubTeam then
									return true
								else
									assert = var_5

									var_5(false, "invalid trigger type: " .. var_172_0)
								end
							end
						end
					end
				end
			end
		end
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

function var_0_0.checkOniState(arg_177_0)
	local var_177_0 = arg_177_0
	local var_177_1 = arg_177_0.getOni(var_177_0)

	assert = var_1_10002

	var_1_10002(var_177_1, "oni not exist.")

	_ = var_1_10002

	if var_1_10002.all(var_0_2, function(arg_178_0)
		local var_178_0 = {
			var_177_1.row + arg_178_0[1],
			var_177_1.column + arg_178_0[2]
		}
		local var_178_1 = arg_177_0
		local var_178_2 = var_2.existFleet

		FleetType = var_2_10005

		if var_178_2(var_178_1, var_2_10005.Normal, var_178_0[1], var_178_0[2]) then
			return true
		end

		local var_178_3 = arg_177_0

		if not var_2.getChapterCell(var_178_3, var_178_0[1], var_178_0[2]) or not var_2:IsWalkable() then
			return true
		end

		local var_178_4 = arg_177_0

		if var_3.existBarrier(var_178_4, var_2.row, var_2.column) then
			return true
		end

		return
	end) then
		return 1
	end

	local var_177_2 = arg_177_0:getOniChapterInfo().escape_grids

	_ = var_177_0

	if var_177_0.any(var_177_2, function(arg_179_0)
		return arg_179_0[1] == var_177_1.row and arg_179_0[2] == var_177_1.column
	end) then
		return 2
	end

	return
end

function var_0_0.onOniEnter(arg_180_0)
	pairs = var_1_10001

	for iter_180_0, iter_180_1 in var_1_10001(arg_180_0.cells) do
		ChapterConst = var_1_10006
		iter_180_1.attachment = var_1_10006.AttachNone
		iter_180_1.attachmentId = nil
		iter_180_1.flag = nil
		iter_180_1.data = nil
	end

	arg_180_0.champions = {}
	arg_180_0.modelCount = arg_180_0:getOniChapterInfo().special_item
	arg_180_0.roundIndex = 0

	return
end

function var_0_0.onBombEnemyEnter(arg_181_0)
	pairs = var_1_10001

	for iter_181_0, iter_181_1 in var_1_10001(arg_181_0.cells) do
		ChapterConst = var_1_10006
		iter_181_1.attachment = var_1_10006.AttachNone
		iter_181_1.attachmentId = nil
		iter_181_1.flag = nil
		iter_181_1.data = nil
	end

	arg_181_0.champions = {}
	arg_181_0.modelCount = 0
	arg_181_0.roundIndex = 0

	return
end

function var_0_0.clearSubmarineFleet(arg_182_0)
	for iter_182_0 = #arg_182_0.fleets, 1, -1 do
		local var_182_0 = arg_182_0.fleets[iter_182_0]
		local var_182_1 = var_5.getFleetType(var_182_0)

		FleetType = var_1_10006

		if var_182_1 == var_1_10006.Submarine then
			table = var_182_1

			var_182_1.remove(arg_182_0.fleets, iter_182_0)
		end
	end

	return
end

function var_0_0.getSpAppearStory(arg_183_0)
	if arg_183_0:existOni() then
		ipairs = var_1

		for iter_183_0, iter_183_1 in var_1(arg_183_0.champions) do
			local var_183_0 = iter_183_1.trait

			ChapterConst = var_1_10007

			if var_183_0 == var_1_10007.TraitLurk then
				local var_183_1 = iter_183_1.attachment

				ChapterConst = var_1_10007

				if var_183_1 == var_1_10007.AttachOni and iter_183_1:getConfig("appear_story") and #var_6 > 0 then
					return var_6
				end
			end
		end
	elseif arg_183_0:isPlayingWithBombEnemy() then
		pairs = var_1

		for iter_183_2, iter_183_3 in var_1(arg_183_0.cells) do
			local var_183_2 = iter_183_3.attachment

			ChapterConst = var_1_10007

			if var_183_2 == var_1_10007.AttachBomb_Enemy then
				local var_183_3 = iter_183_3.trait

				ChapterConst = var_1_10007

				if var_183_3 == var_1_10007.TraitLurk then
					pg = var_183_3

					if var_183_3.specialunit_template[iter_183_3.attachmentId].appear_story and #var_6.appear_story > 0 then
						return var_6.appear_story
					end
				end
			end
		end
	end

	return
end

function var_0_0.getSpAppearGuide(arg_184_0)
	if arg_184_0:existOni() then
		ipairs = var_1

		for iter_184_0, iter_184_1 in var_1(arg_184_0.champions) do
			local var_184_0 = iter_184_1.trait

			ChapterConst = var_1_10007

			if var_184_0 == var_1_10007.TraitLurk then
				local var_184_1 = iter_184_1.attachment

				ChapterConst = var_1_10007

				if var_184_1 == var_1_10007.AttachOni and iter_184_1:getConfig("appear_guide") and #var_6 > 0 then
					return var_6
				end
			end
		end
	elseif arg_184_0:isPlayingWithBombEnemy() then
		pairs = var_1

		for iter_184_2, iter_184_3 in var_1(arg_184_0.cells) do
			local var_184_2 = iter_184_3.attachment

			ChapterConst = var_1_10007

			if var_184_2 == var_1_10007.AttachBomb_Enemy then
				local var_184_3 = iter_184_3.trait

				ChapterConst = var_1_10007

				if var_184_3 == var_1_10007.TraitLurk then
					pg = var_184_3

					if var_184_3.specialunit_template[iter_184_3.attachmentId].appear_guide and #var_6.appear_guide > 0 then
						return var_6.appear_guide
					end
				end
			end
		end
	end

	return
end

function var_0_0.CheckTransportState(arg_185_0)
	_ = var_1_10001

	if not var_1_10001.detect(arg_185_0.fleets, function(arg_186_0)
		local var_186_0 = arg_186_0:getFleetType()

		FleetType = var_2_10002

		return var_186_0 == var_2_10002.Transport
	end) then
		return -1
	end

	local var_185_0 = arg_185_0
	local var_185_1 = arg_185_0.findChapterCell

	ChapterConst = var_1_10005

	local var_185_2 = var_185_1(var_185_0, var_1_10005.AttachTransport_Target)

	assert = var_3

	var_3(var_1, "transport fleet not exist.")

	assert = var_3

	var_3(var_185_2, "transport target not exist.")

	if not var_1:isValid() then
		return -1
	else
		if var_1.line.row == var_185_2.row and var_1.line.column == var_185_2.column then
			local var_185_3 = arg_185_0
			local var_185_4 = arg_185_0.existEnemy

			ChapterConst = var_6

			if not var_185_4(var_185_3, var_6.SubjectPlayer, var_185_2.row, var_185_2.column) then
				do return 1 end

				goto label_185_0
			end
		end

		return 0
	end

	::label_185_0::

	return
end

function var_0_0.getCoastalGunArea(arg_187_0)
	local var_187_0 = {}

	pairs = var_1_10002

	for iter_187_0, iter_187_1 in var_1_10002(arg_187_0.cells) do
		local var_187_1 = iter_187_1.attachment

		ChapterConst = var_1_10008

		if var_187_1 == var_1_10008.AttachLandbase then
			local var_187_2 = iter_187_1.flag

			ChapterConst = var_1_10008

			if var_187_2 ~= var_1_10008.CellFlagDisabled then
				pg = var_187_2
				var_1_10008 = var_187_2.land_based_template[iter_187_1.attachmentId].type
				ChapterConst = var_1_10009

				if var_1_10008 == var_1_10009.LBCoastalGun then
					var_1_10008 = var_7.function_args
					var_1_10009 = {}
					math = var_1_10010
					var_1_10009[1] = var_1_10010.abs(var_1_10008[1])
					math = var_1_10010
					var_1_10009[2] = var_1_10010.abs(var_1_10008[2])
					var_1_10010 = {}
					Mathf = var_1_10011
					var_1_10010[1] = var_1_10011.Sign(var_1_10008[1])
					Mathf = var_1_10011
					var_1_10010[2] = var_1_10011.Sign(var_1_10008[2])
					math = var_1_10011
					var_1_10011 = var_1_10011.max(var_1_10009[1], var_1_10009[2])

					for iter_187_2 = 1, var_1_10011 do
						table = var_1_10016
						var_1_10016 = var_1_10016.insert

						local var_187_3 = var_187_0
						local var_187_4 = {}
						local var_187_5 = iter_187_1.row

						math = var_1_10021
						var_187_4.row = var_187_5 + var_1_10021.min(var_1_10009[1], iter_187_2) * var_1_10010[1]

						local var_187_6 = iter_187_1.column

						math = var_1_10021
						var_187_4.column = var_187_6 + var_1_10021.min(var_1_10009[2], iter_187_2) * var_1_10010[2]

						var_1_10016(var_187_3, var_187_4)
					end
				end
			end
		end
	end

	return var_187_0
end

function var_0_0.GetAntiAirGunArea(arg_188_0)
	local var_188_0 = {}
	local var_188_1 = {}

	pairs = var_1_10003

	for iter_188_0, iter_188_1 in var_1_10003(arg_188_0.cells) do
		var_1_10008 = iter_188_1.attachment
		ChapterConst = var_1_10009

		if var_1_10008 == var_1_10009.AttachLandbase then
			var_1_10008 = iter_188_1.flag
			ChapterConst = var_1_10009

			if var_1_10008 ~= var_1_10009.CellFlagDisabled then
				pg = var_1_10008
				var_1_10009 = var_1_10008.land_based_template[iter_188_1.attachmentId].type
				ChapterConst = var_1_10010

				if var_1_10009 == var_1_10010.LBAntiAir then
					var_1_10009 = var_1_10008.function_args
					math = var_1_10010
					var_1_10010 = var_1_10010.abs(var_1_10009[1])

					local function var_188_2(arg_189_0, arg_189_1)
						ChapterConst = var_2_10002

						return var_2_10002.MaxColumn * arg_189_0 + arg_189_1
					end

					local var_188_3 = {}
					local var_188_4 = {}

					if 0 < var_1_10010 then
						var_188_3[var_188_2(iter_188_1.row, iter_188_1.column)] = iter_188_1
					end

					::label_188_0::

					next = var_14

					if var_14(var_188_3) then
						repeat
							next = var_14

							local var_188_5 = var_188_3[var_14(var_188_3)]

							var_188_3[var_14] = nil
							math = var_16

							if var_16.abs(var_188_5.row - iter_188_1.row) <= var_1_10010 then
								math = var_16

								if var_1_10010 >= var_16.abs(var_188_5.column - iter_188_1.column) then
									var_188_4[var_14] = var_188_5

									for iter_188_2 = 1, #var_0_2 do
										local var_188_6 = var_188_5.row + var_0_2[iter_188_2][1]
										local var_188_7 = var_188_5.column + var_0_2[iter_188_2][2]

										if not var_188_4[var_188_2(var_188_6, var_188_7)] then
											var_188_3[var_22] = {
												row = var_188_6,
												column = var_188_7
											}
										end
									end
								end
							end

							goto label_188_0
						until true
					end

					pairs = var_14

					for iter_188_3, iter_188_4 in var_14(var_188_4) do
						var_188_1[iter_188_3] = iter_188_4
					end
				end
			end
		end
	end

	pairs = var_3

	for iter_188_5, iter_188_6 in var_3(var_188_1) do
		table = var_1_10008

		var_1_10008.insert(var_188_0, iter_188_6)
	end

	return var_188_0
end

function var_0_0.GetDefeatCount(arg_190_0)
	return arg_190_0.defeatEnemies
end

function var_0_0.ExistDivingChampion(arg_191_0)
	_ = var_1_10001

	return var_1_10001.any(arg_191_0.champions, function(arg_192_0)
		local var_192_0 = arg_192_0.flag

		ChapterConst = var_2_10002

		return var_192_0 == var_2_10002.CellFlagDiving
	end)
end

function var_0_0.IsSkipPrecombat(arg_193_0)
	local var_193_0 = arg_193_0
	local var_193_2

	if arg_193_0.isLoop(var_193_0) then
		getProxy = var_193_2
		ChapterProxy = var_193_0

		local var_193_1 = var_193_2(var_193_0)

		var_193_2 = var_193_2.GetSkipPrecombat(var_193_1)
	end

	return var_193_2
end

function var_0_0.CanActivateAutoFight(arg_194_0)
	pg = var_1_10001

	if var_1_10001.chapter_template_loop[arg_194_0.id] then
		::label_194_0::

		if var_1.fightauto == 1 then
			local var_194_0

			if arg_194_0:isLoop() then
				AutoBotCommand = var_194_0

				if var_194_0.autoBotSatisfied() then
					if not arg_194_0:existOni() then
						var_194_0 = not arg_194_0:existBombEnemy()

						goto label_194_1
					end

					var_194_0 = false

					if false then
						var_194_0 = true
					end
				end
			end

			::label_194_1::

			return var_194_0
		end
	end
end

function var_0_0.IsAutoFight(arg_195_0)
	local var_195_0 = arg_195_0
	local var_195_2

	if arg_195_0.CanActivateAutoFight(var_195_0) then
		getProxy = var_195_2
		ChapterProxy = var_195_0

		local var_195_1 = var_195_2(var_195_0)

		var_195_2 = var_195_2.GetChapterAutoFlag(var_195_1, arg_195_0.id) == 1
	end

	return var_195_2
end

function var_0_0.getOperationBuffDescStg(arg_196_0)
	ipairs = var_1_10001

	for iter_196_0, iter_196_1 in var_1_10001(arg_196_0.operationBuffList) do
		pg = var_1_10006

		local var_196_0 = var_1_10006.benefit_buff_template[iter_196_1].benefit_type

		Chapter = var_1_10008

		if var_196_0 == var_1_10008.OPERATION_BUFF_TYPE_DESC then
			return iter_196_1
		end
	end

	return
end

function var_0_0.GetOperationDesc(arg_197_0)
	local var_197_0 = ""

	ipairs = var_1_10002

	for iter_197_0, iter_197_1 in var_1_10002(arg_197_0.operationBuffList) do
		pg = var_1_10007

		if var_1_10007.benefit_buff_template[iter_197_1].benefit_type == var_0_0.OPERATION_BUFF_TYPE_DESC then
			var_197_0 = var_1_10007.desc

			break
		end
	end

	return var_197_0
end

function var_0_0.GetOperationBuffList(arg_198_0)
	return arg_198_0.operationBuffList
end

function var_0_0.GetAllEnemies(arg_199_0, arg_199_1)
	local var_199_0 = {}

	pairs = var_1_10003

	for iter_199_0, iter_199_1 in var_1_10003(arg_199_0.cells) do
		ChapterConst = var_1_10008

		if var_1_10008.IsEnemyAttach(iter_199_1.attachment) then
			if not arg_199_1 then
				var_1_10008 = iter_199_1.flag
				ChapterConst = var_1_10009

				if var_1_10008 ~= var_1_10009.CellFlagDisabled then
					table = var_1_10008

					var_1_10008.insert(var_199_0, iter_199_1)
				end
			end
		end
	end

	pairs = var_3

	for iter_199_2, iter_199_3 in var_3(arg_199_0.champions) do
		if not arg_199_1 then
			var_1_10008 = iter_199_3.flag
			ChapterConst = var_1_10009

			if var_1_10008 ~= var_1_10009.CellFlagDisabled then
				table = var_1_10008

				var_1_10008.insert(var_199_0, iter_199_3)
			end
		end
	end

	return var_199_0
end

function var_0_0.GetFleetOfDuty(arg_200_0, arg_200_1)
	local var_200_0

	ipairs = var_1_10003

	for iter_200_0, iter_200_1 in var_1_10003(arg_200_0.fleets) do
		if iter_200_1:isValid() then
			local var_200_1 = iter_200_1:getFleetType()

			FleetType = var_1_10009

			if var_200_1 == var_1_10009.Normal then
				local var_200_2

				if not arg_200_0.duties[iter_200_1.id] then
					var_200_2 = 0
				end

				ChapterFleet = var_1_10009

				if var_200_2 ~= var_1_10009.DUTY_KILLALL then
					ChapterFleet = var_1_10009

					if var_200_2 == var_1_10009.DUTY_KILLBOSS then
						tobool = var_1_10009

						if not var_1_10009(arg_200_1) then
							ChapterFleet = var_1_10009

							if var_200_2 == var_1_10009.DUTY_CLEANPATH then
								tobool = var_1_10009

								if not var_1_10009(arg_200_1) then
									return iter_200_1
								end
							end

							var_200_0 = iter_200_1
						end
					end
				end
			end
		end
	end

	return var_200_0
end

function var_0_0.GetBuffOfLinkAct(arg_201_0)
	local var_201_0 = arg_201_0:getPlayType()

	ChapterConst = var_1_10002

	if var_201_0 == var_1_10002.TypeDOALink then
		pg = var_201_0

		local var_201_1 = var_201_0.gameset.doa_fever_buff.description

		_ = var_2

		return var_2.detect(arg_201_0.buff_list, function(arg_202_0)
			table = var_2_10001

			return var_2_10001.contains(var_201_1, arg_202_0)
		end)
	end

	return
end

function var_0_0.GetAttachmentStories(arg_203_0)
	local var_203_0 = arg_203_0.cellAttachments
	local var_203_1 = 0
	local var_203_2

	pairs = var_1_10004

	for iter_203_0, iter_203_1 in var_1_10004(var_203_0) do
		if var_0_0.GetEventTemplateByKey("mult_story", iter_203_1.attachmentId) then
			assert = var_1_10010

			local var_203_3

			if var_203_2 then
				table = var_12
				var_203_3 = var_12.equal(var_203_2, var_9[1])

				if false then
					var_203_3 = false
				end
			else
				var_203_3 = true
			end

			var_1_10010(var_203_3, "Not the same Config of Mult_story ID: " .. iter_203_1.attachmentId)

			var_203_2 = var_203_2 or var_9[1]

			local var_203_4

			if arg_203_0.cells[iter_203_0] then
				::label_203_0::

				var_203_4 = var_1_10010.flag
				ChapterConst = var_203_3
				var_203_4 = var_203_4 == var_203_3.CellFlagDisabled
			end

			if var_203_4 then
				var_203_1 = var_203_1 + 1
			end
		end
	end

	return var_203_2, var_203_1
end

function var_0_0.GetWeather(arg_204_0, arg_204_1, arg_204_2)
	arg_204_1 = arg_204_1 or arg_204_0.fleet.line.row
	arg_204_2 = arg_204_2 or arg_204_0.fleet.line.column
	ChapterCell = var_1_10003

	local var_204_0 = var_1_10003.Line2Name(arg_204_1, arg_204_2)
	local var_204_1

	if not arg_204_0.cells[var_204_0] or not var_4:GetWeatherFlagList() then
		var_204_1 = {}
	end

	return var_204_1
end

function var_0_0.getDisplayEnemyCount(arg_205_0)
	local var_205_0 = 0

	local function var_205_1(arg_206_0)
		local var_206_0 = arg_206_0.flag

		ChapterConst = var_2_10002

		if var_206_0 ~= var_2_10002.CellFlagDisabled then
			var_205_0 = var_205_0 + 1
		end

		return
	end

	local var_205_2 = {}

	ChapterConst = var_1_10004
	var_205_2[var_1_10004.AttachEnemy] = var_205_1
	ChapterConst = var_4
	var_205_2[var_4.AttachElite] = var_205_1
	ChapterConst = var_4
	var_205_2[var_4.AttachBox] = function(arg_207_0)
		pg = var_2_10001

		local var_207_0 = var_2_10001.box_data_template[arg_207_0.attachmentId].type

		ChapterConst = var_2

		if var_207_0 == var_2.BoxEnemy then
			var_205_1(arg_207_0)
		end

		return
	end
	pairs = var_4

	for iter_205_0, iter_205_1 in var_4(arg_205_0.cells) do
		switch = var_1_10009

		var_1_10009(iter_205_1.attachment, var_205_2, nil, iter_205_1)
	end

	ipairs = var_4

	for iter_205_2, iter_205_3 in var_4(arg_205_0.champions) do
		var_205_1(iter_205_3)
	end

	return var_205_0
end

function var_0_0.getNearestEnemyCell(arg_208_0)
	local function var_208_0(arg_209_0, arg_209_1)
		return (arg_209_0.row - arg_209_1.row) * (arg_209_0.row - arg_209_1.row) + (arg_209_0.column - arg_209_1.column) * (arg_209_0.column - arg_209_1.column)
	end

	local var_208_1

	local function var_208_2(arg_210_0)
		local var_210_0 = arg_210_0.flag

		ChapterConst = var_2_10002

		if var_210_0 ~= var_2_10002.CellFlagDisabled and (not var_208_1 or var_208_0(arg_208_0.fleet.line, arg_210_0) < var_208_0(arg_208_0.fleet.line, var_208_1)) then
			var_208_1 = arg_210_0
		end

		return
	end

	local var_208_3 = {}

	ChapterConst = var_1_10005
	var_208_3[var_1_10005.AttachEnemy] = var_208_2
	ChapterConst = var_5
	var_208_3[var_5.AttachElite] = var_208_2
	ChapterConst = var_5
	var_208_3[var_5.AttachBox] = function(arg_211_0)
		pg = var_2_10001

		local var_211_0 = var_2_10001.box_data_template[arg_211_0.attachmentId].type

		ChapterConst = var_2

		if var_211_0 == var_2.BoxEnemy then
			var_208_2(arg_211_0)
		end

		return
	end
	pairs = var_5

	for iter_208_0, iter_208_1 in var_5(arg_208_0.cells) do
		switch = var_1_10010

		var_1_10010(iter_208_1.attachment, var_208_3, nil, iter_208_1)
	end

	ipairs = var_5

	for iter_208_2, iter_208_3 in var_5(arg_208_0.champions) do
		var_208_2(iter_208_3)
	end

	return var_208_1
end

function var_0_0.GetRegularFleetIds(arg_212_0)
	_ = var_1_10001

	local var_212_0 = var_1_10001.map

	_ = var_1_10003

	return (var_212_0(var_1_10003.filter(arg_212_0.fleets, function(arg_213_0)
		local var_213_0 = arg_213_0:getFleetType()

		FleetType = var_2_10002

		local var_213_1

		if var_213_0 ~= var_2_10002.Normal then
			FleetType = var_2

			if var_213_0 ~= var_2.Submarine then
				var_213_1 = false

				goto label_213_0
			end
		end

		var_213_1 = true

		::label_213_0::

		return var_213_1
	end), function(arg_214_0)
		return arg_214_0.fleetId
	end))
end

function var_0_0.NeedSupportSubmarineStage(arg_215_0)
	local var_215_0

	if arg_215_0:IsSupportSubmarineStage() then
		table = var_215_0
		var_215_0 = var_215_0.contains

		local var_215_1 = arg_215_0:getExtraFlags()

		ChapterConst = var_1_10004
		var_215_0 = not var_215_0(var_215_1, var_1_10004.StatusSupportSubmarineFinish)
	end

	return var_215_0
end

function var_0_0.UpdateCellsVisible(arg_216_0, arg_216_1, arg_216_2)
	if not arg_216_0:IsFogStage() then
		return
	end

	local var_216_0 = {}

	if arg_216_0.fleetVisibleStore[arg_216_1.id] then
		ipairs = var_4

		for iter_216_0, iter_216_1 in var_4(arg_216_0.fleetVisibleStore[arg_216_1.id]) do
			defaultValue = var_1_10009
			var_216_0[iter_216_1] = var_1_10009(var_216_0[iter_216_1], 0) - 1
		end
	end

	local var_216_1

	if arg_216_1.isRetreat then
		var_216_1 = arg_216_0.fleetVisibleStore
		var_216_1[arg_216_1.id] = {}
	else
		var_216_1 = arg_216_0.fleetVisibleStore

		local var_216_2 = arg_216_1.id

		underscore = var_1_10006

		local var_216_3 = var_1_10006(arg_216_1:GetVisibleRange(arg_216_2))
		local var_216_4 = var_6.chain(var_216_3)
		local var_216_5 = var_6.map(var_216_4, function(arg_217_0)
			ChapterCell = var_2_10001

			return var_2_10001.Line2Name(arg_217_0.row, arg_217_0.column)
		end)
		local var_216_6 = var_6.filter(var_216_5, function(arg_218_0)
			tobool = var_2_10001

			return var_2_10001(arg_216_0.cells[arg_218_0])
		end)

		var_216_1[var_216_2] = var_6.value(var_216_6)
	end

	ipairs = var_216_1

	for iter_216_2, iter_216_3 in var_216_1(arg_216_0.fleetVisibleStore[arg_216_1.id]) do
		defaultValue = var_1_10009
		var_216_0[iter_216_3] = var_1_10009(var_216_0[iter_216_3], 0) + 1
	end

	local var_216_7 = {}

	pairs = var_5

	for iter_216_4, iter_216_5 in var_5(var_216_0) do
		local var_216_8 = arg_216_0.cells[iter_216_4]
		local var_216_9 = var_10.IsVisible(var_216_8)

		if iter_216_5 < 0 then
			local var_216_10 = arg_216_0.cells[iter_216_4]

			var_11.UpdateVisible(var_216_10, arg_216_1.id, false)
		elseif iter_216_5 > 0 then
			local var_216_11 = arg_216_0.cells[iter_216_4]

			var_11.UpdateVisible(var_216_11, arg_216_1.id, true)
		end

		local var_216_12 = arg_216_0.cells[iter_216_4]

		if var_216_9 ~= var_11.IsVisible(var_216_12) then
			arg_216_0.cellsVisibleCount = arg_216_0.cellsVisibleCount + (var_216_9 and -1 or 1)
			table = var_11

			var_11.insert(var_216_7, iter_216_4)
		end
	end

	return var_216_7
end

function var_0_0.GetFogStageStrategy(arg_219_0)
	local var_219_0 = arg_219_0.cellsVisibleCount * 100 / arg_219_0.cellsCount
	local var_219_1

	ipairs = var_1_10003

	for iter_219_0, iter_219_1 in var_1_10003(arg_219_0:getConfigMiscArg("fog_visible_buff")) do
		unpack = var_219_2

		local var_219_2, var_219_3 = var_219_2(iter_219_1)

		var_219_1 = var_219_3

		if var_219_0 <= var_219_2 then
			break
		end
	end

	return var_219_1
end

function var_0_0.retreatFleet(arg_220_0, arg_220_1)
	local var_220_0

	ipairs = var_1_10003

	for iter_220_0, iter_220_1 in var_1_10003(arg_220_0.fleets) do
		if iter_220_1.id == arg_220_1 then
			table = var_8
			var_220_0 = var_8.remove(arg_220_0.fleets, iter_220_0)

			break
		end
	end

	if var_220_0 then
		local var_220_1 = var_220_0:getFleetType()

		FleetType = var_4

		if var_220_1 == var_4.Normal then
			arg_220_0.findex = 1
		end
	end

	var_220_0.isRetreat = true

	var_220_0:UpdateVisible()

	return
end

return var_0_0
