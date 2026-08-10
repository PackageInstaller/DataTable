local var_0_0 = singletonClass("WarChessData")
local var_0_1 = 0
local var_0_2 = {}
local var_0_3
local var_0_4
local var_0_5
local var_0_6 = {}
local var_0_7 = false
local var_0_8 = {}
local var_0_9
local var_0_10 = {}
local var_0_11 = {}
local var_0_12
local var_0_13 = {}
local var_0_14
local var_0_15 = {}
local var_0_16 = false

function var_0_0.Init(arg_1_0)
	var_0_2 = {}
	var_0_3 = nil
	var_0_6 = {}
	var_0_1 = 0
	var_0_10 = {}
	var_0_11 = {}
	var_0_12 = nil
	var_0_5 = 0
	var_0_13 = {}
	var_0_14 = nil
	var_0_15 = {}
	arg_1_0.teamData_ = {}
	arg_1_0.activiteList_ = {}
	var_0_16 = false
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.activity_id

	if arg_2_1.chapter ~= 0 then
		var_2_0 = WarchessLevelCfg[arg_2_1.chapter].type
	end

	var_0_2[var_2_0] = arg_2_1.chapter

	local var_2_1 = cleanProtoTable(arg_2_1.chapter_info)

	for iter_2_0, iter_2_1 in ipairs(var_2_1) do
		if not var_0_6[iter_2_1.chapter_id] then
			var_0_6[iter_2_1.chapter_id] = {}
			var_0_6[iter_2_1.chapter_id].box = {}
		end

		var_0_6[iter_2_1.chapter_id].id = iter_2_1.chapter_id

		local var_2_2 = cleanProtoTable(iter_2_1.box)

		for iter_2_2, iter_2_3 in ipairs(var_2_2) do
			var_0_6[iter_2_1.chapter_id].box[iter_2_3.id] = iter_2_3.num
		end
	end
end

function var_0_0.InitRedPoint(arg_3_0)
	for iter_3_0, iter_3_1 in pairs(WarchessLevelCfg.all) do
		local var_3_0 = WarchessLevelCfg[iter_3_1]

		if var_3_0.tag ~= 0 then
			local var_3_1 = string.format("%s_%s_%s", RedPointConst.WAR_CHESS, var_3_0.tag, iter_3_1)

			if arg_3_0:GetChessLevelIsLock(iter_3_1) then
				manager.redPoint:setTip(var_3_1, 0)
			elseif not RedPointData:GetIsRedPointOpen(RedPointConst.WARCHESS_RANGE + iter_3_1) then
				manager.redPoint:setTip(var_3_1, 1)
			else
				manager.redPoint:setTip(var_3_1, 0)
			end
		end
	end
end

function var_0_0.GetChessLevelIsLock(arg_4_0, arg_4_1)
	local var_4_0 = WarchessLevelCfg[arg_4_1]
	local var_4_1 = var_4_0.unlock_level

	if var_4_1 ~= 0 and ChessTools.GetChapterProgress(var_4_1) < var_4_0.success_progress then
		return true
	end

	local var_4_2 = WarchessLevelCfg[arg_4_1].unlock_condition

	if var_4_2 ~= "" then
		if var_4_2[1] == 1 then
			local var_4_3 = StoryStageActivityData:GetStageData(var_4_2[2][1])[var_4_2[2][2]]

			if var_4_3 and var_4_3.clear_times >= 1 then
				-- block empty
			else
				return true
			end
		elseif var_4_2[1] == 2 then
			return not ChapterTools.IsClearStage(var_4_2[2][2])
		end
	end

	return false
end

function var_0_0.InitChessTime(arg_5_0, arg_5_1)
	arg_5_0.activiteList_ = clone(arg_5_1)
end

function var_0_0.GetChessTime(arg_6_0, arg_6_1)
	return arg_6_0.activiteList_[arg_6_1]
end

function var_0_0.GetChapterInfo(arg_7_0, arg_7_1)
	if not var_0_6[arg_7_1] then
		var_0_6[arg_7_1] = {
			box = {},
			id = arg_7_1
		}
	end

	return var_0_6[arg_7_1]
end

function var_0_0.ModifyData(arg_8_0, arg_8_1)
	return
end

function var_0_0.SetWarChessData(arg_9_0, arg_9_1, arg_9_2)
	var_0_3 = WarchessLevelCfg[arg_9_1].type
	var_0_2[var_0_3] = arg_9_1
	var_0_10 = {}
	var_0_10.mapId = arg_9_1
	var_0_10.bronPos = {
		x = arg_9_2.pos.x,
		z = arg_9_2.pos.z
	}
	var_0_10.bag = {
		item = {},
		artifact = {}
	}
	var_0_10.hp_list = {}
	var_0_10.event_list = {}
	var_0_10.global_event = {}
	var_0_10.direction = arg_9_2.direction
	var_0_10.eventInfo = {}
	var_0_10.log = {}

	local var_9_0 = cleanProtoTable(arg_9_2.bag.artifact)
	local var_9_1 = cleanProtoTable(arg_9_2.bag.item)
	local var_9_2 = cleanProtoTable(arg_9_2.log)
	local var_9_3 = cleanProtoTable(arg_9_2.hp_list)

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		var_0_10.bag.item[iter_9_1.type] = iter_9_1.num
	end

	for iter_9_2, iter_9_3 in ipairs(var_9_0) do
		var_0_10.bag.artifact[iter_9_3] = 1
	end

	for iter_9_4, iter_9_5 in ipairs(var_9_2) do
		var_0_10.log[iter_9_4] = {
			index = iter_9_5.index,
			tag = iter_9_5.tag,
			log = iter_9_5.log
		}
	end

	for iter_9_6, iter_9_7 in ipairs(arg_9_2.event_list) do
		local var_9_4 = WarchessGlobalCfg[iter_9_7.id]

		if not var_9_4 then
			error("服务端下发了客户端不存在的全局事件 id:" .. iter_9_7.id)
		end

		if var_9_4.type == ChessConst.GLOBAL.EVENT then
			var_0_10.event_list[var_9_4.params[1]] = iter_9_7.progress
		end

		arg_9_0:SetGlobalEventProgress(var_9_4.type, iter_9_7.id, iter_9_7.progress or 0)
	end

	for iter_9_8, iter_9_9 in ipairs(var_9_3) do
		var_0_10.hp_list[iter_9_9.id] = iter_9_9.hp
	end

	local var_9_5 = {}

	for iter_9_10, iter_9_11 in ipairs(arg_9_2.map) do
		var_9_5[ChessTools.TwoDToOneD(iter_9_11.pos.x, iter_9_11.pos.z)] = {
			tag = iter_9_11.tag,
			pos = {
				x = iter_9_11.pos.x,
				z = iter_9_11.pos.z
			},
			status = iter_9_11.state or 0,
			attribute = cleanProtoTable(iter_9_11.attribute),
			direction = (iter_9_11.rotation or 0) / 60
		}
	end

	var_0_10.mapChangeInfo = var_9_5
	var_0_10.is_fog = arg_9_2.is_fog

	if var_0_10.is_fog then
		var_0_10.fogInfo = WarChessTools.DecodeFogInfo(arg_9_2.fog)
	else
		var_0_10.fogInfo = {}

		for iter_9_12 = 1, arg_9_2.fog[1] do
			for iter_9_13 = 1, arg_9_2.fog[2] do
				table.insert(var_0_10.fogInfo, true)
			end
		end
	end

	if arg_9_2.guide_pos and arg_9_2.guide_pos[1] then
		var_0_10.guidePos = {
			arg_9_2.guide_pos[1],
			arg_9_2.guide_pos[2]
		}
	else
		var_0_10.guidePos = nil
	end

	var_0_10.direction = arg_9_2.direction

	local var_9_6 = {}

	for iter_9_14, iter_9_15 in ipairs(arg_9_2.event_info) do
		local var_9_7 = iter_9_15.event_id

		if not var_9_6[var_9_7] then
			var_9_6[var_9_7] = {}
		end

		for iter_9_16, iter_9_17 in ipairs(iter_9_15.pos_list) do
			local var_9_8 = ChessTools.TwoDToOneD(iter_9_17.pos.x, iter_9_17.pos.z)

			if not var_9_6[var_9_7][var_9_8] then
				var_9_6[var_9_7][var_9_8] = {}
			end

			table.insert(var_9_6[var_9_7][var_9_8], iter_9_17.tag)
		end
	end

	var_0_10.eventInfo = var_9_6

	if arg_9_2.extra_gameplay and arg_9_2.extra_gameplay.ocean_gameplay then
		local var_9_9 = arg_9_2.extra_gameplay.ocean_gameplay

		if not var_0_10.extra_gameplay then
			var_0_10.extra_gameplay = {}
		end

		var_0_10.extra_gameplay.research_vessel_hp = var_9_9.research_vessel_hp
		var_0_10.extra_gameplay.detector_pos = cleanProtoTable(var_9_9.detector_pos)
		var_0_10.extra_gameplay.boss_pos = cleanProtoTable(var_9_9.boss_pos)
	end
end

function var_0_0.ChangeFogInfo(arg_10_0, arg_10_1)
	for iter_10_0 = 0, arg_10_1.Count - 1 do
		var_0_10.fogInfo[arg_10_1[iter_10_0]] = true
	end
end

function var_0_0.GetCurrentWarChessMapData(arg_11_0)
	return var_0_10
end

function var_0_0.SetCurrentIndex(arg_12_0, arg_12_1, arg_12_2)
	if var_0_10.bronPos.x == arg_12_1 and var_0_10.bronPos.z == arg_12_2 then
		return false
	end

	var_0_10.bronPos = {
		x = arg_12_1,
		z = arg_12_2
	}

	return true
end

function var_0_0.GetCurrentIndex(arg_13_0)
	return var_0_10.bronPos
end

function var_0_0.SetBattleIndex(arg_14_0, arg_14_1)
	var_0_1 = arg_14_1
end

function var_0_0.GetBattleIndex(arg_15_0)
	return var_0_1
end

function var_0_0.GetItemData(arg_16_0)
	return var_0_10.bag.item
end

function var_0_0.GetArtifactData(arg_17_0)
	return var_0_10.bag.artifact
end

function var_0_0.ModifyItemData(arg_18_0, arg_18_1, arg_18_2)
	if var_0_10.bag.item[arg_18_1] == nil then
		var_0_10.bag.item[arg_18_1] = 0
	end

	if arg_18_2 > 0 and WarchessObjectCfg[arg_18_1].max ~= 0 then
		var_0_10.bag.item[arg_18_1] = math.min(WarchessObjectCfg[arg_18_1].max, var_0_10.bag.item[arg_18_1] + arg_18_2)
	else
		var_0_10.bag.item[arg_18_1] = var_0_10.bag.item[arg_18_1] + arg_18_2
	end

	if arg_18_2 > 0 then
		local var_18_0 = arg_18_0:GetGlobalEventList()[ChessConst.GLOBAL.KEY] or {}

		for iter_18_0, iter_18_1 in pairs(var_18_0) do
			if arg_18_1 == WarchessGlobalCfg[iter_18_0].params[1] then
				arg_18_0:SetGlobalEventProgress(ChessConst.GLOBAL.KEY, iter_18_0, iter_18_1 + arg_18_2)
			end
		end
	end

	if var_0_10.bag.item[arg_18_1] == 0 then
		var_0_10.bag.item[arg_18_1] = nil
	end

	if arg_18_1 == ChessConst.BULLET then
		manager.notify:CallUpdateFunc(GET_BULLET, true)
	end
end

function var_0_0.ModifyArtifactData(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_2 > 0 then
		var_0_10.bag.artifact[arg_19_1] = 1
	else
		var_0_10.bag.artifact[arg_19_1] = nil
	end
end

function var_0_0.AddAllHp(arg_20_0, arg_20_1)
	for iter_20_0, iter_20_1 in pairs(var_0_10.hp_list) do
		local var_20_0
		local var_20_1 = iter_20_1 == 0 and 0 or iter_20_1 + arg_20_1

		if var_20_1 > 10000 then
			var_20_1 = 10000
		end

		if var_20_1 < 0 then
			var_20_1 = 0
		end

		var_0_10.hp_list[iter_20_0] = var_20_1
	end
end

function var_0_0.ModifyHp(arg_21_0, arg_21_1, arg_21_2)
	var_0_10.hp_list[arg_21_1] = arg_21_2
end

function var_0_0.GetHeroHp(arg_22_0, arg_22_1)
	return var_0_10.hp_list[arg_22_1]
end

function var_0_0.GetHeroList(arg_23_0)
	return var_0_10.hp_list
end

function var_0_0.SetChapterClientID(arg_24_0, arg_24_1)
	var_0_4 = arg_24_1
end

function var_0_0.GetChapterClientID(arg_25_0)
	return var_0_4
end

function var_0_0.GetBoxNum(arg_26_0, arg_26_1, arg_26_2)
	return var_0_0:GetChapterInfo(arg_26_1).box[arg_26_2] or 0
end

function var_0_0.AddBoxNum(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = var_0_0:GetChapterInfo(arg_27_1)
	local var_27_1 = var_27_0.box[arg_27_2] or 0

	var_27_0.box[arg_27_2] = var_27_1 + 1

	manager.notify:Invoke(CHESS_BOX_OPEN, arg_27_1)
end

function var_0_0.GetLogs(arg_28_0)
	return var_0_10.log
end

function var_0_0.AddLog(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4)
	local var_29_0 = manager.ChessManager.map_.width
	local var_29_1 = {
		index = arg_29_2 * var_29_0 + arg_29_1 + 1,
		tag = arg_29_3,
		log = arg_29_4
	}

	for iter_29_0, iter_29_1 in ipairs(var_0_10.log) do
		if table.equal(iter_29_1, var_29_1, "all") then
			return
		end
	end

	var_0_10.log[#var_0_10.log + 1] = var_29_1
end

function var_0_0.SetExtendMap(arg_30_0, arg_30_1)
	var_0_11 = arg_30_1
end

function var_0_0.SetJsonMap(arg_31_0, arg_31_1)
	var_0_12 = arg_31_1
end

function var_0_0.GetJsonData(arg_32_0, arg_32_1, arg_32_2)
	return var_0_12[ChessTools.TwoDToOneD(arg_32_1, arg_32_2)]
end

function var_0_0.GetTypeIDViaExtendID(arg_33_0, arg_33_1)
	return var_0_11[arg_33_1].typeID
end

function var_0_0.ChangeGridLua(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	local var_34_0 = var_0_10.mapChangeInfo[ChessTools.TwoDToOneD(arg_34_1, arg_34_2)]

	if arg_34_3 ~= 0 then
		var_34_0 = ChessTools.CreateChessData(arg_34_1, arg_34_2, var_0_11, arg_34_3)
	else
		var_34_0 = ChessTools.CreateChessData(arg_34_1, arg_34_2, var_0_12, ChessTools.TwoDToOneD(arg_34_1, arg_34_2))
	end

	var_34_0.tag = arg_34_3
	var_0_10.mapChangeInfo[ChessTools.TwoDToOneD(arg_34_1, arg_34_2)] = var_34_0
end

function var_0_0.ChangeGridStatusLua(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	local var_35_0 = var_0_10.mapChangeInfo[ChessTools.TwoDToOneD(arg_35_1, arg_35_2)] or ChessTools.CreateChessData(arg_35_1, arg_35_2, var_0_12, ChessTools.TwoDToOneD(arg_35_1, arg_35_2))

	var_35_0.status = arg_35_3
	var_0_10.mapChangeInfo[ChessTools.TwoDToOneD(arg_35_1, arg_35_2)] = var_35_0
end

function var_0_0.ChangeGridDirection(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	local var_36_0 = var_0_10.mapChangeInfo[ChessTools.TwoDToOneD(arg_36_1, arg_36_2)] or ChessTools.CreateChessData(arg_36_1, arg_36_2, var_0_12, ChessTools.TwoDToOneD(arg_36_1, arg_36_2))

	var_36_0.direction = math.fmod(var_36_0.direction + arg_36_3, 6)
	var_0_10.mapChangeInfo[ChessTools.TwoDToOneD(arg_36_1, arg_36_2)] = var_36_0
end

function var_0_0.GetGridDirection(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = var_0_10.mapChangeInfo[ChessTools.TwoDToOneD(arg_37_1, arg_37_2)] or ChessTools.CreateChessData(arg_37_1, arg_37_2, var_0_12, ChessTools.TwoDToOneD(arg_37_1, arg_37_2))

	var_0_10.mapChangeInfo[ChessTools.TwoDToOneD(arg_37_1, arg_37_2)] = var_37_0

	return var_37_0.direction
end

function var_0_0.GetGridAttribute(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = ChessTools.TwoDToOneD(arg_38_1, arg_38_2)
	local var_38_1 = var_0_10.mapChangeInfo[var_38_0] or ChessTools.CreateChessData(arg_38_1, arg_38_2, var_0_12, var_38_0)

	var_0_10.mapChangeInfo[var_38_0] = var_38_1

	return var_0_10.mapChangeInfo[var_38_0].attribute
end

function var_0_0.SetGridAttribute(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	local var_39_0 = ChessTools.TwoDToOneD(arg_39_1, arg_39_2)
	local var_39_1 = var_0_10.mapChangeInfo[var_39_0] or ChessTools.CreateChessData(arg_39_1, arg_39_2, var_0_12, var_39_0)

	var_0_10.mapChangeInfo[var_39_0] = var_39_1
	var_0_10.mapChangeInfo[var_39_0].attribute = arg_39_3
end

function var_0_0.GetGridLua(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = var_0_10.mapChangeInfo[ChessTools.TwoDToOneD(arg_40_1, arg_40_2)]

	if not var_40_0 then
		return ChessTools.CreateChessData(arg_40_1, arg_40_2, var_0_12, ChessTools.TwoDToOneD(arg_40_1, arg_40_2))
	end

	return var_40_0
end

function var_0_0.GetCurrentChapter(arg_41_0, arg_41_1)
	arg_41_1 = arg_41_1 or var_0_3

	return var_0_2[arg_41_1] or 0
end

function var_0_0.SetCurrentChapter(arg_42_0, arg_42_1, arg_42_2)
	arg_42_2 = arg_42_2 or var_0_3
	var_0_2[arg_42_2] = arg_42_1
end

function var_0_0.RemoveCurrentActivity(arg_43_0)
	var_0_3 = 0
end

function var_0_0.GetCurrentActivity(arg_44_0)
	return var_0_3
end

function var_0_0.SetTemporaryData(arg_45_0, arg_45_1, arg_45_2)
	var_0_13[arg_45_1] = arg_45_2
end

function var_0_0.GetTemporaryData(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = var_0_13[arg_46_1]

	var_0_13[arg_46_1] = nil

	return var_46_0
end

function var_0_0.AboutToStart(arg_47_0)
	var_0_14 = true
end

function var_0_0.IsAboutToStart(arg_48_0)
	local var_48_0 = var_0_14

	var_0_14 = false

	return var_48_0
end

function var_0_0.ExecuteEventOneTime(arg_49_0, arg_49_1)
	var_0_10.event_list[arg_49_1] = (var_0_10.event_list[arg_49_1] or 0) + 1
end

function var_0_0.GetEventExecuteTime(arg_50_0, arg_50_1)
	return var_0_10.event_list[arg_50_1] or 0
end

function var_0_0.GetGlobalEventList(arg_51_0)
	return var_0_10.global_event
end

function var_0_0.SetGlobalEventProgress(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
	if not var_0_10.global_event[arg_52_1] then
		var_0_10.global_event[arg_52_1] = {}
	end

	var_0_10.global_event[arg_52_1][arg_52_2] = arg_52_3

	if arg_52_1 == ChessConst.GLOBAL.COUNT_STEP and manager.ChessManager and arg_52_3 >= 0 then
		manager.ChessManager:SetCountDown(arg_52_3)
	end
end

function var_0_0.GetGlobalEventProgress(arg_53_0, arg_53_1)
	local var_53_0 = WarchessGlobalCfg[arg_53_1].type

	if not var_0_10.global_event[var_53_0] then
		return nil
	end

	return var_0_10.global_event[var_53_0][arg_53_1]
end

function var_0_0.GetGlobalEventByType(arg_54_0, arg_54_1)
	return var_0_10.global_event[arg_54_1]
end

function var_0_0.ClearGlobalEvent(arg_55_0, arg_55_1, arg_55_2)
	if not var_0_10.global_event[arg_55_1] then
		return
	end

	var_0_10.global_event[arg_55_1][arg_55_2] = nil

	if table.length(var_0_10.global_event[arg_55_1]) == 0 then
		var_0_10.global_event[arg_55_1] = nil
	end

	if arg_55_1 == ChessConst.GLOBAL.COUNT_STEP and manager.ChessManager then
		manager.ChessManager:SetCountDown(false)
	end
end

function var_0_0.SetStartTime(arg_56_0, arg_56_1)
	var_0_5 = arg_56_1
end

function var_0_0.GetStartTime(arg_57_0)
	return var_0_5
end

function var_0_0.GetBulletNum(arg_58_0)
	return var_0_10.bag.item[ChessConst.BULLET] or 0
end

function var_0_0.SetButterFlyPos(arg_59_0, arg_59_1)
	var_0_10.guidePos = arg_59_1
end

function var_0_0.GetButterFlyPos(arg_60_0)
	return var_0_10.guidePos
end

function var_0_0.GetCharacterDirection(arg_61_0)
	return var_0_10.direction
end

function var_0_0.SetCharacterDirection(arg_62_0, arg_62_1)
	var_0_10.direction = arg_62_1
end

function var_0_0.GetBattleIsFinish(arg_63_0, arg_63_1, arg_63_2, arg_63_3)
	return arg_63_0:IsEventExecute(10201, arg_63_1, arg_63_2, arg_63_3)
end

function var_0_0.GetMutiBattleIsFinish(arg_64_0, arg_64_1, arg_64_2, arg_64_3)
	return arg_64_0:IsEventExecute(10207, arg_64_1, arg_64_2, arg_64_3)
end

function var_0_0.IsEventExecute(arg_65_0, arg_65_1, arg_65_2, arg_65_3, arg_65_4)
	local var_65_0 = var_0_10.eventInfo[arg_65_1]

	if not var_65_0 then
		return false
	end

	local var_65_1 = var_65_0[ChessTools.TwoDToOneD(arg_65_2, arg_65_3)]

	if not var_65_1 then
		return false
	end

	if not table.indexof(var_65_1, arg_65_4) then
		return false
	end

	return true
end

function var_0_0.SetEventExecute(arg_66_0, arg_66_1, arg_66_2, arg_66_3, arg_66_4)
	if not var_0_10.eventInfo[arg_66_1] then
		var_0_10.eventInfo[arg_66_1] = {}
	end

	local var_66_0 = ChessTools.TwoDToOneD(arg_66_2, arg_66_3)
	local var_66_1 = var_0_10.eventInfo[arg_66_1][var_66_0]

	if not var_66_1 then
		var_0_10.eventInfo[arg_66_1][var_66_0] = {}
		var_66_1 = var_0_10.eventInfo[arg_66_1][var_66_0]
	end

	if table.indexof(var_66_1, arg_66_4) then
		error("不应该存在两个相同的一次性事件")
	end

	table.insert(var_66_1, arg_66_4)
end

function var_0_0.SetRedPoint(arg_67_0, arg_67_1)
	local var_67_0 = string.format("%s_%s_%s", RedPointConst.WAR_CHESS, WarchessLevelCfg[arg_67_1].tag, arg_67_1)

	manager.redPoint:setTip(var_67_0, 0)
	RedPointAction.HandleRedPoint(RedPointConst.WARCHESS_RANGE + arg_67_1)
end

function var_0_0.GetStepCountDownNum(arg_68_0)
	local var_68_0 = var_0_10.global_event[ChessConst.GLOBAL.COUNT_STEP]

	if not var_68_0 then
		return 0
	end

	for iter_68_0, iter_68_1 in pairs(var_68_0) do
		return iter_68_1
	end
end

function var_0_0.GetShipHp(arg_69_0)
	return var_0_10.extra_gameplay.research_vessel_hp
end

function var_0_0.CostShipHp(arg_70_0, arg_70_1)
	var_0_10.extra_gameplay.research_vessel_hp = var_0_10.extra_gameplay.research_vessel_hp + arg_70_1

	manager.notify:CallUpdateFunc(SHIP_HP_CHANGE, arg_70_1)
end

function var_0_0.GetBossPos(arg_71_0)
	return var_0_10.extra_gameplay.boss_pos
end

function var_0_0.ModifyBossPos(arg_72_0, arg_72_1, arg_72_2)
	var_0_10.extra_gameplay.boss_pos = {
		arg_72_1,
		arg_72_2
	}
end

function var_0_0.GetDetectorPos(arg_73_0)
	return var_0_10.extra_gameplay.detector_pos
end

function var_0_0.SetDetectorPos(arg_74_0, arg_74_1, arg_74_2)
	var_0_10.extra_gameplay.detector_pos = {
		arg_74_1,
		arg_74_2
	}
end

function var_0_0.SetMutiBattleData(arg_75_0, arg_75_1, arg_75_2, arg_75_3)
	local var_75_0 = arg_75_0:GetMutiBattleDataWithoutType(arg_75_1) or {
		{},
		[2] = 0,
		[3] = 0
	}

	var_75_0[arg_75_2] = arg_75_3

	if arg_75_2 == 1 then
		for iter_75_0 = 1, 3 do
			local var_75_1 = arg_75_0:GetMutiBattleDataWithoutType(iter_75_0)

			if var_75_1 ~= var_75_0 and var_75_1 and var_75_1[1] then
				local var_75_2 = {
					{},
					var_75_1[2],
					var_75_1[3]
				}

				for iter_75_1, iter_75_2 in pairs(var_75_1[1]) do
					local var_75_3 = false

					for iter_75_3, iter_75_4 in pairs(var_75_0[1]) do
						if iter_75_4 == iter_75_2 then
							var_75_3 = true

							if ComboSkillCfg[var_75_2[3]] then
								for iter_75_5, iter_75_6 in pairs(ComboSkillCfg[var_75_2[3]].cooperate_role_ids) do
									if iter_75_4 == iter_75_6 then
										var_75_2[3] = 0
									end
								end
							end

							break
						end
					end

					if var_75_3 == false then
						table.insert(var_75_2[1], iter_75_2)
					end
				end

				for iter_75_7 = 1, 3 do
					if var_75_2[1][iter_75_7] == nil then
						var_75_2[1][iter_75_7] = 0
					end
				end

				arg_75_0.teamData_[iter_75_0] = var_75_2

				local var_75_4 = "team_" .. iter_75_0

				saveData("chessMutiBattleData", var_75_4, var_75_2)
			end
		end
	end

	local var_75_5 = "team_" .. arg_75_1

	saveData("chessMutiBattleData", var_75_5, var_75_0)
end

function var_0_0.GetMutiBattleData(arg_76_0, arg_76_1, arg_76_2)
	if arg_76_0.teamData_[arg_76_1] == nil then
		local var_76_0 = "team_" .. arg_76_1
		local var_76_1 = getData("chessMutiBattleData", var_76_0) or {
			{},
			[2] = 0,
			[3] = 0
		}

		arg_76_0.teamData_[arg_76_1] = var_76_1
	end

	return arg_76_0.teamData_[arg_76_1][arg_76_2]
end

function var_0_0.GetMutiBattleDataWithoutType(arg_77_0, arg_77_1)
	if arg_77_0.teamData_[arg_77_1] == nil then
		local var_77_0 = "team_" .. arg_77_1
		local var_77_1 = getData("chessMutiBattleData", var_77_0) or {
			{},
			[2] = 0,
			[3] = 0
		}

		arg_77_0.teamData_[arg_77_1] = var_77_1
	end

	return arg_77_0.teamData_[arg_77_1]
end

function var_0_0.SwapTeam(arg_78_0, arg_78_1, arg_78_2)
	local var_78_0
	local var_78_1 = deepClone(arg_78_0.teamData_[arg_78_1])

	arg_78_0.teamData_[arg_78_1] = arg_78_0.teamData_[arg_78_2]
	arg_78_0.teamData_[arg_78_2] = var_78_1

	local var_78_2
	local var_78_3 = "team_" .. arg_78_1
	local var_78_4 = "team_" .. arg_78_2

	saveData("chessMutiBattleData", var_78_3, arg_78_0.teamData_[arg_78_1])
	saveData("chessMutiBattleData", var_78_4, arg_78_0.teamData_[arg_78_2])
end

function var_0_0.SetCacheExtendID(arg_79_0, arg_79_1, arg_79_2)
	var_0_8[arg_79_1] = arg_79_2
end

function var_0_0.GetCacheExtendID(arg_80_0, arg_80_1)
	if var_0_8[arg_80_1] == nil then
		-- block empty
	end

	return var_0_8[arg_80_1]
end

function var_0_0.CacheGridData(arg_81_0, arg_81_1)
	var_0_7 = true
	var_0_9 = arg_81_1
end

function var_0_0.GetCacheGridData(arg_82_0)
	if var_0_9 == nil then
		-- block empty
	end

	return var_0_9
end

function var_0_0.ClearCacheGridData(arg_83_0)
	var_0_7 = false
	var_0_9 = nil
end

function var_0_0.GetMapChangeInfo(arg_84_0)
	return var_0_10.mapChangeInfo
end

function var_0_0.GetGridIsChanged(arg_85_0, arg_85_1, arg_85_2)
	local var_85_0 = ChessTools.TwoDToOneD(arg_85_1, arg_85_2)
	local var_85_1 = var_0_10.mapChangeInfo[var_85_0]

	if var_85_1 then
		if var_85_1.tag == 0 then
			return false
		else
			return true
		end
	else
		return false
	end
end

function var_0_0.GetStoneIsMoving(arg_86_0)
	return var_0_7
end

local var_0_17 = 0

function var_0_0.CacheViewPos(arg_87_0, arg_87_1)
	var_0_17 = arg_87_1
end

function var_0_0.GetViewPos(arg_88_0)
	return var_0_17
end

function var_0_0.GetIsGoingChess(arg_89_0)
	return var_0_16
end

function var_0_0.SetIsGoingWarChess(arg_90_0, arg_90_1)
	var_0_16 = arg_90_1
end

return var_0_0
