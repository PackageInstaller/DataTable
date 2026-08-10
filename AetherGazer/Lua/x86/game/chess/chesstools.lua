local var_0_0 = require("cjson")
local var_0_1 = {
	{
		1,
		1
	},
	{
		0,
		1
	},
	{
		-1,
		0
	},
	{
		-1,
		-1
	},
	{
		0,
		-1
	},
	{
		1,
		0
	}
}
local var_0_2 = {
	IsInteract = function(arg_1_0, arg_1_1)
		local var_1_0 = arg_1_1 == 0 and arg_1_0 or arg_1_0 * 10 + arg_1_1

		if WarchessHexCfg[var_1_0] then
			return WarchessHexCfg[var_1_0].interact == 1
		end

		return WarchessHexCfg[arg_1_0].interact == 1
	end,
	IsMove = function(arg_2_0, arg_2_1)
		local var_2_0 = arg_2_1 == 0 and arg_2_0 or arg_2_0 * 10 + arg_2_1

		if WarchessHexCfg[var_2_0] then
			return WarchessHexCfg[var_2_0].move ~= 0
		end

		return WarchessHexCfg[arg_2_0].move ~= 0
	end,
	WayFindingWeight = function(arg_3_0, arg_3_1)
		local var_3_0 = arg_3_1 == 0 and arg_3_0 or arg_3_0 * 10 + arg_3_1

		if WarchessHexCfg[var_3_0] then
			return WarchessHexCfg[var_3_0].move
		end

		return WarchessHexCfg[arg_3_0].move
	end,
	IsWalkEvent = function(arg_4_0, arg_4_1)
		local var_4_0 = arg_4_1 == 0 and arg_4_0 or arg_4_0 * 10 + arg_4_1

		if WarchessHexCfg[var_4_0] then
			return WarchessHexCfg[var_4_0].interact == 2
		end

		return WarchessHexCfg[arg_4_0].interact == 2
	end,
	IsStoneInteract = function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_5_1 == 0 and arg_5_0 or arg_5_0 * 10 + arg_5_1

		if var_5_0 == ChessConst.HOLE_GRID_ID and arg_5_2 == 2 then
			return false
		end

		if WarchessHexCfg[var_5_0] then
			return WarchessHexCfg[var_5_0].stonecaninteract == 1
		end

		return WarchessHexCfg[arg_5_0].stonecaninteract == 1
	end,
	IsExplode = function(arg_6_0)
		local var_6_0 = arg_6_0.typeID
		local var_6_1 = arg_6_0.status
		local var_6_2 = var_6_1 == 0 and var_6_0 or var_6_0 * 10 + var_6_1

		if WarchessHexCfg[var_6_2].explode == 1 then
			return true
		end

		return false
	end
}

function var_0_2.IsBreakAuto(arg_7_0)
	local var_7_0 = var_0_2.ParseParameter(arg_7_0)
	local var_7_1 = arg_7_0.typeID
	local var_7_2 = arg_7_0.status
	local var_7_3 = var_7_2 == 0 and var_7_1 or var_7_1 * 10 + var_7_2

	if WarchessHexCfg[var_7_3].interact ~= 2 then
		return false
	end

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		if iter_7_1.eventID == 10402 then
			return true
		end
	end

	return false
end

function var_0_2.LoadMap(arg_8_0)
	local var_8_0
	local var_8_1 = AssetEx.LoadText("Map/Chess/JsonMap/" .. arg_8_0 .. ".json")

	return (var_0_0.decode(var_8_1))
end

function var_0_2.GetPosViaDir(arg_9_0, arg_9_1, arg_9_2)
	return arg_9_0 + var_0_1[arg_9_2 + 1][1], arg_9_1 + var_0_1[arg_9_2 + 1][2]
end

function var_0_2.ParseParameter(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0

	if arg_10_1 then
		if type(arg_10_0.paramList) ~= "table" or #arg_10_0.paramList <= 0 then
			return {}
		end

		var_10_0 = arg_10_0.paramList[1]
	else
		if arg_10_0.paramList.Length <= 0 then
			return {}
		end

		var_10_0 = arg_10_0.paramList[0]
	end

	if not WarchessEventPoolCfg[var_10_0] or not var_10_0 then
		return {}
	end

	local var_10_1

	if not arg_10_2 then
		var_10_1 = WarchessEventPoolCfg[var_10_0].event_group
	else
		var_10_1 = WarchessEventPoolCfg[var_10_0].event_group_second
	end

	if not var_10_1 or var_10_1 == "" then
		return {}
	end

	return var_0_2.ParseEventPollCfg(var_10_1)
end

function var_0_2.ParseEventPollCfg(arg_11_0)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_0) do
		var_11_0[iter_11_0] = {}
		var_11_0[iter_11_0].params = {}

		for iter_11_2 = 1, #iter_11_1 do
			if iter_11_2 == 1 then
				var_11_0[iter_11_0].eventID = iter_11_1[iter_11_2]
			else
				var_11_0[iter_11_0].params[#var_11_0[iter_11_0].params + 1] = iter_11_1[iter_11_2]
			end
		end
	end

	return var_11_0
end

function var_0_2.ParseToEvents(arg_12_0, arg_12_1)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(arg_12_0) do
		if ChessEventConfig[iter_12_1.eventID][arg_12_1] then
			var_12_0[#var_12_0 + 1] = iter_12_1.eventID
		elseif arg_12_1 ~= ChessConst.TIMING_CLICK and ChessEventConfig[iter_12_1.eventID][ChessConst.TIMING_ALL] then
			var_12_0[#var_12_0 + 1] = iter_12_1.eventID
		end
	end

	return var_12_0
end

function var_0_2.IsSavingEvent(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(ChessConst.EVENT) do
		if not ChessEventConfig[arg_13_0] then
			-- block empty
		end

		if ChessEventConfig[arg_13_0][iter_13_1] then
			return true
		end
	end

	return false
end

function var_0_2.GetProgress(arg_14_0)
	local var_14_0 = WarChessData:GetBoxNum(arg_14_0, ChessConst.BOX.SMALL)
	local var_14_1 = WarChessData:GetBoxNum(arg_14_0, ChessConst.BOX.BIG)
	local var_14_2 = var_14_0 * WarchessLevelCfg[arg_14_0].sbox_progress
	local var_14_3 = var_14_1 * WarchessLevelCfg[arg_14_0].lbox_progress

	return var_14_2 + var_14_3 > 100 and 100 or var_14_2 + var_14_3
end

function var_0_2.IsFinish(arg_15_0)
	return WarchessLevelCfg[arg_15_0].success_progress <= var_0_2.GetProgress(arg_15_0)
end

function var_0_2.TwoDToOneD(arg_16_0, arg_16_1)
	return arg_16_1 * 1000 + arg_16_0
end

function var_0_2.OneDToTwoD(arg_17_0)
	local var_17_0
	local var_17_1
	local var_17_2 = math.fmod(arg_17_0, 1000)
	local var_17_3 = math.floor(arg_17_0 / 1000)

	return var_17_2, var_17_3
end

function var_0_2.GetExtendID(arg_18_0, arg_18_1)
	local var_18_0
	local var_18_1 = table.keyof(arg_18_0, arg_18_1)

	if #arg_18_0 <= 1 then
		var_18_0 = arg_18_0[1]
	elseif not var_18_1 then
		var_18_0 = arg_18_0[1]
	else
		local var_18_2 = math.fmod(var_18_1 + 1, #arg_18_0 + 1)

		if var_18_2 == 0 then
			var_18_2 = var_18_2 + 1
		end

		var_18_0 = arg_18_0[var_18_2]
	end

	return var_18_0
end

function var_0_2.GetWarChessItemSprite(arg_19_0)
	return getSprite("Atlas/WarChess_BattleAtlas", WarchessItemCfg[arg_19_0].icon)
end

function var_0_2.GetChapterProgress(arg_20_0)
	if WarchessLevelCfg[arg_20_0] == nil then
		return 0
	end

	local var_20_0 = WarChessData:GetBoxNum(arg_20_0, ChessConst.BOX.SMALL)
	local var_20_1 = WarChessData:GetBoxNum(arg_20_0, ChessConst.BOX.BIG)
	local var_20_2 = var_20_0 * WarchessLevelCfg[arg_20_0].sbox_progress
	local var_20_3 = var_20_1 * WarchessLevelCfg[arg_20_0].lbox_progress

	return var_20_2 + var_20_3 > 100 and 100 or var_20_2 + var_20_3
end

function var_0_2.EnterChessMap(arg_21_0, arg_21_1)
	local var_21_0

	if not arg_21_1 then
		var_21_0 = ChapterClientCfg[arg_21_0].chapter_list[1]
	else
		var_21_0 = arg_21_0
	end

	if not WarchessLevelCfg[var_21_0] then
		-- block empty
	end

	local var_21_1 = WarchessLevelCfg[var_21_0].type
	local var_21_2 = WarChessData:GetCurrentChapter(var_21_1)

	if var_21_2 == 0 or var_21_2 ~= var_21_0 then
		WarChessData:AboutToStart()
	end

	local function var_21_3()
		WarChessData:SetRedPoint(var_21_0)

		local var_22_0, var_22_1 = gameContext:GetLastHistoryAndParams()

		WarChessData:SetTemporaryData("url", var_22_0)
		WarChessData:SetTemporaryData("urlParams", var_22_1)

		local var_22_2 = getStoryViaStageID(var_21_0, manager.story.BEFORE)

		if var_22_2 and not manager.story:IsStoryPlayed(var_22_2) then
			manager.story:StartStoryOnEnterChessMap(var_22_2, function()
				PlayerAction.ChangeStoryList(var_22_2)
				WarChessAction.RequireWarChessInfo(var_21_0)
			end)
		else
			WarChessAction.RequireWarChessInfo(var_21_0)
		end
	end

	if var_21_2 == 0 then
		var_21_3()

		return
	end

	local var_21_4
	local var_21_5

	if var_21_2 ~= 0 then
		local var_21_6

		if ChapterClientCfg[var_21_2] then
			local var_21_7 = ChapterClientCfg[var_21_2]

			var_21_4 = GetTips("CHESS_NAME_" .. WarchessLevelCfg[var_21_2].tag)
			var_21_5 = var_21_7.name
		else
			var_21_5 = WarchessLevelCfg[var_21_2].name_level
		end
	end

	if var_21_2 ~= var_21_0 then
		ShowMessageBox({
			isTop = true,
			title = GetTips("PROMPT"),
			content = string.format(GetTips("OPEN_NEW_WARCHESS"), GetI18NText(var_21_4), GetI18NText(var_21_5), GetI18NText(var_21_4), GetI18NText(var_21_5)),
			OkCallback = function()
				var_21_3()
			end,
			CancelCallback = function()
				return
			end
		})
	else
		var_21_3()
	end
end

function var_0_2.IsShowMessage(arg_26_0, arg_26_1)
	local var_26_0 = WarchessEventPoolCfg[arg_26_0].click_form

	if var_26_0 == "" then
		return var_26_0
	end

	for iter_26_0, iter_26_1 in ipairs(var_26_0) do
		if iter_26_1[1] == arg_26_1 then
			return {
				iter_26_1[2],
				iter_26_1[3]
			}
		end
	end

	return ""
end

function var_0_2.CantReach(arg_27_0, arg_27_1)
	ShowTips("CANNOT_GO")
	TimeTools.StartAfterSeconds(1.2, function(arg_28_0, arg_28_1)
		if manager.ChessManager then
			manager.ChessManager:SetGridSelectOutline(arg_28_0, arg_28_1, false)
		end
	end, {
		arg_27_0,
		arg_27_1
	})
end

function var_0_2.IsInRange(arg_29_0, arg_29_1, arg_29_2)
	return arg_29_0 >= -arg_29_2 and arg_29_0 <= arg_29_2 and arg_29_1 >= math.max(-arg_29_2, arg_29_0 - arg_29_2) and arg_29_1 <= math.min(arg_29_2, arg_29_0 + arg_29_2)
end

function var_0_2.PhraseArea(arg_30_0)
	local var_30_0 = {}

	for iter_30_0, iter_30_1 in ipairs(arg_30_0) do
		local var_30_1 = iter_30_1[1]

		if var_30_1 == 1 then
			local var_30_2 = iter_30_1[2]
			local var_30_3 = iter_30_1[3]
			local var_30_4 = iter_30_1[4]

			for iter_30_2 = -var_30_4, var_30_4 do
				for iter_30_3 = math.max(-var_30_4, iter_30_2 - var_30_4), math.min(var_30_4, iter_30_2 + var_30_4) do
					var_30_0[var_0_2.TwoDToOneD(iter_30_2 + var_30_2, iter_30_3 + var_30_3)] = true
				end
			end
		elseif var_30_1 == 2 then
			local var_30_5 = iter_30_1[2]
			local var_30_6 = iter_30_1[3]
			local var_30_7 = iter_30_1[4]
			local var_30_8 = iter_30_1[5]

			var_30_0[var_0_2.TwoDToOneD(var_30_5, var_30_6)] = true
			var_30_0[var_0_2.TwoDToOneD(var_30_5, var_30_8)] = true
			var_30_0[var_0_2.TwoDToOneD(var_30_7, var_30_6)] = true
			var_30_0[var_0_2.TwoDToOneD(var_30_7, var_30_8)] = true
		elseif var_30_1 == 3 then
			for iter_30_4 = 2, #iter_30_1, 2 do
				local var_30_9 = iter_30_1[iter_30_4]
				local var_30_10 = iter_30_1[iter_30_4 + 1]

				var_30_0[var_0_2.TwoDToOneD(var_30_9, var_30_10)] = true
			end
		end
	end

	return var_30_0
end

function var_0_2.DoSpecialEvent(arg_31_0, arg_31_1)
	local var_31_0 = WarchessSpecialEventCfg[arg_31_0].param

	;(ChessSpecialEventConfig[arg_31_0][arg_31_1] or ChessSpecialEventConfig[arg_31_0][ChessConst.TIMING_ALL])(unpack(var_31_0))
end

function var_0_2.CreateChessData(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	return {
		tag = 0,
		pos = {
			x = arg_32_0,
			z = arg_32_1
		},
		direction = (arg_32_2[arg_32_3].rotationY or 0) / 60,
		status = arg_32_2[arg_32_3].status,
		attribute = {}
	}
end

function var_0_2.CheckCanEnterMutiBattle(arg_33_0, arg_33_1)
	for iter_33_0 = 1, arg_33_0 do
		local var_33_0 = ReserveParams.New(ReserveConst.RESERVE_TYPE.MULTI_CHESS, arg_33_1, iter_33_0)
		local var_33_1 = ReserveTools.GetHeroList(var_33_0)

		if #var_33_1 == 0 or var_33_1[1] == 0 then
			return false
		end
	end

	return true
end

function var_0_2.CreateChessDataViaJson(arg_34_0)
	local var_34_0 = Chess.GridData.New()

	var_34_0.paramList = arg_34_0.paramList
	var_34_0.prefab = arg_34_0.prefab
	var_34_0.rotationY = arg_34_0.rotationY
	var_34_0.status = arg_34_0.status
	var_34_0.typeID = arg_34_0.typeID
	var_34_0.x = arg_34_0.x
	var_34_0.z = arg_34_0.z

	return var_34_0
end

function var_0_2.CreateStack()
	local var_35_0 = {}
	local var_35_1 = 1
	local var_35_2 = {
		__index = function(arg_36_0, arg_36_1)
			if arg_36_1 == "push" then
				return function(arg_37_0)
					var_35_0[var_35_1] = arg_37_0
					var_35_1 = var_35_1 + 1
				end
			end

			if arg_36_1 == "pop" then
				return function()
					var_35_1 = var_35_1 - 1

					local var_38_0 = var_35_0[var_35_1]

					var_35_0[var_35_1] = nil

					return var_38_0
				end
			end

			return rawget(var_35_0, arg_36_1)
		end,
		__newindex = function(arg_39_0, arg_39_1, arg_39_2)
			rawset(var_35_0, arg_39_1, arg_39_2)
		end,
		__pairs = function()
			return function(arg_41_0, arg_41_1)
				local var_41_0, var_41_1 = next(var_35_0, arg_41_1)

				return var_41_0, var_41_1
			end
		end,
		__len = function()
			return #var_35_0
		end
	}

	setmetatable(var_35_0, var_35_2)

	return var_35_0
end

function var_0_2.GetExtendIDByStoneStatus(arg_43_0)
	if arg_43_0 == 1 then
		return WarChessData:GetCacheExtendID("stone_1")
	else
		return WarChessData:GetCacheExtendID("stone_2")
	end
end

function var_0_2.GetStoneNextState(arg_44_0, arg_44_1)
	if arg_44_0 == arg_44_1[1] then
		return arg_44_1[2]
	else
		return arg_44_1[1]
	end
end

return var_0_2
