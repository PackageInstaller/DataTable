local var_0_0 = class("ChapterOpRoutine", pm.SimpleCommand)

function var_0_0.initData(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.op = arg_1_1
	arg_1_0.data = arg_1_2
	arg_1_0.chapter = arg_1_3
	arg_1_0.items = {}
	arg_1_0.fullpath = nil
	arg_1_0.flag = 0
	arg_1_0.extraFlag = 0

	return
end

function var_0_0.doDropUpdate(arg_2_0)
	arg_2_0.items = PlayerConst.addTranDrop(arg_2_0.data.drop_list)

	table.insertto(arg_2_0.items, underscore.map(PlayerConst.addTranDrop(arg_2_0.data.extra_drop_list), function(arg_3_0)
		arg_3_0.riraty = true

		return arg_3_0
	end))

	return
end

function var_0_0.doMapUpdate(arg_4_0)
	local var_4_0 = arg_4_0.flag
	local var_4_1 = arg_4_0.extraFlag
	local var_4_2 = arg_4_0.chapter

	if #arg_4_0.data.map_update > 0 then
		_.each(arg_4_0.data.map_update, function(arg_5_0)
			if arg_5_0.item_type == ChapterConst.AttachStory and arg_5_0.item_data == ChapterConst.StoryTrigger then
				local var_5_0 = ChapterCell.Line2Name(arg_5_0.pos.row, arg_5_0.pos.column)
				local var_5_1 = var_4_2:GetChapterCellAttachemnts()

				if var_5_1[var_5_0] then
					if var_5_1[var_5_0].flag == ChapterConst.CellFlagTriggerActive and arg_5_0.item_flag == ChapterConst.CellFlagTriggerDisabled then
						if pg.map_event_template[var_5_1[var_5_0].attachmentId].gametip ~= "" then
							pg.TipsMgr.GetInstance():ShowTips(i18n(pg.map_event_template[var_5_1[var_5_0].attachmentId].gametip))
						end
					end

					var_5_1[var_5_0].attachment = arg_5_0.item_type
					var_5_1[var_5_0].attachmentId = arg_5_0.item_id
					var_5_1[var_5_0].flag = arg_5_0.item_flag
					var_5_1[var_5_0].data = arg_5_0.item_data
				else
					var_5_1[var_5_0] = ChapterCell.New(arg_5_0)
				end
			elseif arg_5_0.item_type ~= ChapterConst.AttachNone and arg_5_0.item_type ~= ChapterConst.AttachBorn and arg_5_0.item_type ~= ChapterConst.AttachBorn_Sub then
				var_4_2:mergeChapterCell((ChapterCell.New(arg_5_0)))
			end

			return
		end)

		var_4_0 = bit.bor(var_4_0, ChapterConst.DirtyAttachment)
		var_4_1 = bit.bor(var_4_1, ChapterConst.DirtyAutoAction)
	end

	arg_4_0.flag = var_4_0
	arg_4_0.extraFlag = var_4_1

	return
end

function var_0_0.doCellFlagUpdate(arg_6_0)
	local var_6_0 = arg_6_0.flag
	local var_6_1 = arg_6_0.chapter

	if #arg_6_0.data.cell_flag_list > 0 then
		_.each(arg_6_0.data.cell_flag_list, function(arg_7_0)
			local var_7_0 = var_6_1:getChapterCell(arg_7_0.pos.row, arg_7_0.pos.column)

			if var_7_0 then
				var_7_0:updateFlagList(arg_7_0)
			else
				var_7_0 = ChapterCell.New(arg_7_0)
			end

			arg_6_0.chapter:updateChapterCell(var_7_0)

			return
		end)

		var_6_0 = bit.bor(var_6_0, ChapterConst.DirtyCellFlag)
	end

	arg_6_0.flag = var_6_0

	return
end

function var_0_0.doAIUpdate(arg_8_0)
	local var_8_0 = arg_8_0.flag
	local var_8_1 = arg_8_0.extraFlag
	local var_8_2 = arg_8_0.chapter

	if #arg_8_0.data.ai_list > 0 then
		_.each(arg_8_0.data.ai_list, function(arg_9_0)
			var_8_2:mergeChampion((ChapterChampionPackage.New(arg_9_0)))

			return
		end)

		var_8_0 = bit.bor(var_8_0, ChapterConst.DirtyChampion)
		var_8_1 = bit.bor(var_8_1, ChapterConst.DirtyAutoAction)
	end

	arg_8_0.flag = var_8_0
	arg_8_0.extraFlag = var_8_1

	return
end

function var_0_0.doShipUpdate(arg_10_0)
	local var_10_0 = arg_10_0.flag
	local var_10_1 = arg_10_0.chapter

	if #arg_10_0.data.ship_update > 0 then
		_.each(arg_10_0.data.ship_update, function(arg_11_0)
			var_10_1:updateFleetShipHp(arg_11_0.id, arg_11_0.hp_rant)

			var_10_0 = bit.bor(var_10_0, ChapterConst.DirtyStrategy)

			return
		end)

		var_10_0 = bit.bor(var_10_0, ChapterConst.DirtyFleet)
	end

	arg_10_0.flag = var_10_0

	return
end

function var_0_0.doBuffUpdate(arg_12_0)
	arg_12_0.chapter:UpdateBuffList(arg_12_0.data.buff_list)

	return
end

function var_0_0.doExtraFlagUpdate(arg_13_0)
	if #arg_13_0.data.add_flag_list > 0 or #arg_13_0.data.del_flag_list > 0 then
		getProxy(ChapterProxy):updateExtraFlag(arg_13_0.chapter, arg_13_0.data.add_flag_list, arg_13_0.data.del_flag_list)

		arg_13_0.flag = bit.bor(arg_13_0.flag, ChapterConst.DirtyFleet, ChapterConst.DirtyStrategy, ChapterConst.DirtyCellFlag, ChapterConst.DirtyFloatItems, ChapterConst.DirtyAttachment)
	end

	return
end

function var_0_0.doRetreat(arg_14_0)
	local var_14_0 = arg_14_0.flag

	if arg_14_0.op.id then
		if #arg_14_0.chapter.fleets > 0 then
			arg_14_0.chapter:retreatFleet(arg_14_0.op.id)

			var_14_0 = bit.bor(var_14_0, ChapterConst.DirtyFleet, ChapterConst.DirtyAttachment, ChapterConst.DirtyChampion, ChapterConst.DirtyStrategy)
		end
	else
		arg_14_0.chapter:retreat(arg_14_0.op.win)
	end

	arg_14_0.flag = var_14_0

	return
end

function var_0_0.doMove(arg_15_0)
	local var_15_0 = arg_15_0.extraFlag
	local var_15_1

	if #arg_15_0.data.move_path > 0 then
		var_15_1 = _.map(_.rest(arg_15_0.data.move_path, 1), function(arg_16_0)
			return {
				row = arg_16_0.row,
				column = arg_16_0.column
			}
		end)
		arg_15_0.chapter.moveStep = arg_15_0.chapter.moveStep + #arg_15_0.data.move_path
		var_15_0 = bit.bor(var_15_0, ChapterConst.DirtyAutoAction, ChapterConst.DirtyWeather)
	end

	arg_15_0.fullpath = var_15_1

	arg_15_0.chapter:IncreaseRound()

	arg_15_0.extraFlag = var_15_0

	return
end

function var_0_0.doOpenBox(arg_17_0)
	local var_17_1 = arg_17_0.chapter.fleet.line
	local var_17_2 = arg_17_0.chapter:getChapterCell(arg_17_0.chapter.fleet.line.row, arg_17_0.chapter.fleet.line.column)

	var_17_2.flag = ChapterConst.CellFlagDisabled

	local var_17_3 = bit.bor(arg_17_0.flag, ChapterConst.DirtyAttachment)

	assert(pg.box_data_template[var_17_2.attachmentId], "box_data_template not exist: " .. var_17_2.attachmentId)

	if pg.box_data_template[var_17_2.attachmentId].type == ChapterConst.BoxStrategy then
		arg_17_0.chapter.fleet:achievedStrategy(pg.box_data_template[var_17_2.attachmentId].effect_id, pg.box_data_template[var_17_2.attachmentId].effect_arg)
		table.insert(arg_17_0.items, Drop.New({
			type = DROP_TYPE_STRATEGY,
			id = pg.box_data_template[var_17_2.attachmentId].effect_id,
			count = pg.box_data_template[var_17_2.attachmentId].effect_arg
		}))

		var_17_3 = bit.bor(var_17_3, ChapterConst.DirtyStrategy)
	elseif pg.box_data_template[var_17_2.attachmentId].type == ChapterConst.BoxSupply then
		local var_17_4, var_17_5 = var_17_0:getFleetAmmo(arg_17_0.chapter.fleet)

		arg_17_0.chapter.fleet.restAmmo = arg_17_0.chapter.fleet.restAmmo + math.min(var_17_4 - var_17_5, pg.box_data_template[var_17_2.attachmentId].effect_id)
		var_17_3 = bit.bor(var_17_3, ChapterConst.DirtyFleet)

		pg.TipsMgr.GetInstance():ShowTips(i18n("level_ammo_supply_p1", pg.box_data_template[var_17_2.attachmentId].effect_id))
	end

	var_17_0:clearChapterCell(var_17_1.row, var_17_1.column)

	arg_17_0.flag = var_17_3
	arg_17_0.extraFlag = bit.bor(arg_17_0.extraFlag, ChapterConst.DirtyAutoAction)

	return
end

function var_0_0.doPlayStory(arg_18_0)
	local var_18_0 = arg_18_0.chapter:getChapterCell(arg_18_0.chapter.fleet.line.row, arg_18_0.chapter.fleet.line.column)

	var_18_0.flag = ChapterConst.CellFlagDisabled

	arg_18_0.chapter:updateChapterCell(var_18_0)

	arg_18_0.flag = bit.bor(arg_18_0.flag, ChapterConst.DirtyAttachment)

	return
end

function var_0_0.doAmbush(arg_19_0)
	if arg_19_0.op.arg1 == 1 then
		local var_19_0 = arg_19_0.chapter:getChapterCell(arg_19_0.chapter.fleet.line.row, arg_19_0.chapter.fleet.line.column)

		if var_19_0.flag == ChapterConst.CellFlagAmbush then
			arg_19_0.chapter:clearChapterCell(arg_19_0.chapter.fleet.line.row, arg_19_0.chapter.fleet.line.column)
		end

		local var_19_1 = pg.TipsMgr.GetInstance()
		local var_19_2 = var_19_0.flag == ChapterConst.CellFlagActive and i18n("chapter_tip_aovid_failed") or i18n("chapter_tip_aovid_succeed")

		var_19_1:ShowTips(var_19_2)
	end

	return
end

function var_0_0.doStrategy(arg_20_0)
	local var_20_0 = arg_20_0.flag
	local var_20_1 = arg_20_0.op
	local var_20_2 = arg_20_0.chapter
	local var_20_3 = pg.strategy_data_template[arg_20_0.op.arg1]

	if pg.strategy_data_template[arg_20_0.op.arg1].type == ChapterConst.StgTypeForm then
		for iter_20_0, iter_20_1 in ipairs(var_20_2.fleet.stgIds) do
			if pg.strategy_data_template[iter_20_1].type == ChapterConst.StgTypeForm then
				var_20_2.fleet.stgIds[iter_20_0] = var_20_3.id
			end
		end

		PlayerPrefs.SetInt("team_formation_" .. var_20_2.fleet.id, var_20_3.id)
		pg.TipsMgr.GetInstance():ShowTips(i18n("chapter_tip_change", var_20_3.name))
	elseif var_20_3.type == ChapterConst.StgTypeConsume then
		var_20_2.fleet:consumeOneStrategy(var_20_3.id)

		if var_20_3.id == ChapterConst.StrategyRepair or var_20_3.id == ChapterConst.StrategyExchange then
			pg.TipsMgr.GetInstance():ShowTips(i18n("chapter_tip_use", var_20_3.name))
		end

		if var_20_3.id == ChapterConst.StrategyExchange then
			local var_20_4 = var_20_2:getFleetById(var_20_1.id)
			local var_20_5 = var_20_2:getFleetById(var_20_1.arg2)

			var_20_4.line, var_20_5.line = var_20_2:getFleetById(var_20_1.arg2).line, var_20_2:getFleetById(var_20_1.id).line
			var_20_0 = bit.bor(var_20_0, ChapterConst.DirtyFleet)
		end
	elseif var_20_3.type == ChapterConst.StgTypeBindSupportConsume then
		var_20_2:getChapterSupportFleet():consumeOneStrategy(var_20_3.id)
	end

	arg_20_0.flag = bit.bor(var_20_0, ChapterConst.DirtyStrategy)

	return
end

function var_0_0.doRepair(arg_21_0)
	local var_21_0 = getProxy(ChapterProxy)

	var_21_0.repairTimes = var_21_0.repairTimes + 1

	local var_21_1, var_21_2, var_21_3 = ChapterConst.GetRepairParams()

	if var_21_1 < var_21_0.repairTimes then
		local var_21_4 = getProxy(PlayerProxy)
		local var_21_5 = var_21_4:getData()

		var_21_5:consume({
			gem = var_21_3
		})
		var_21_4:updatePlayer(var_21_5)
	end

	return
end

function var_0_0.doSupply(arg_22_0)
	local var_22_0, var_22_1 = arg_22_0.chapter:getFleetAmmo(arg_22_0.chapter.fleet)
	local var_22_2 = arg_22_0.chapter:getChapterCell(arg_22_0.chapter.fleet.line.row, arg_22_0.chapter.fleet.line.column)
	local var_22_3 = math.min(var_22_2.attachmentId, var_22_0 - var_22_1)

	var_22_2.attachmentId = var_22_2.attachmentId - var_22_3
	arg_22_0.chapter.fleet.restAmmo = arg_22_0.chapter.fleet.restAmmo + var_22_3

	arg_22_0.chapter:updateChapterCell(var_22_2)

	if var_22_2.attachmentId > 20 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("level_ammo_supply_p1", var_22_3))
	elseif var_22_2.attachmentId > 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("level_ammo_supply", var_22_3, var_22_2.attachmentId))
	else
		pg.TipsMgr.GetInstance():ShowTips(i18n("level_ammo_empty", var_22_3))
	end

	arg_22_0.flag = bit.bor(arg_22_0.flag, ChapterConst.DirtyAttachment, ChapterConst.DirtyFleet)

	return
end

function var_0_0.doSubState(arg_23_0)
	arg_23_0.chapter.subAutoAttack = arg_23_0.op.arg1
	arg_23_0.flag = bit.bor(arg_23_0.flag, ChapterConst.DirtyStrategy)

	return
end

function var_0_0.doCollectAI(arg_24_0)
	arg_24_0.aiActs = arg_24_0.aiActs or {}

	if arg_24_0.data.submarine_act_list then
		_.each(arg_24_0.data.submarine_act_list, function(arg_25_0)
			table.insert(arg_24_0.aiActs, SubAIAction.New(arg_25_0))

			return
		end)
	end

	if arg_24_0.data.escort_act_list then
		_.each(arg_24_0.data.escort_act_list, function(arg_26_0)
			table.insert(arg_24_0.aiActs, TransportAIAction.New(arg_26_0))

			return
		end)
	end

	_.each(arg_24_0.data.ai_act_list, function(arg_27_0)
		local var_27_0

		if arg_27_0.act_type == ChapterConst.ActType_TargetDown then
			if arg_24_0.op.type == ChapterConst.OpStrategy then
				if arg_24_0.op.arg1 == ChapterConst.StrategyMissileStrike then
					var_27_0 = ChapterMissileExplodeAction.New(arg_27_0)
				elseif arg_24_0.op.arg1 == ChapterConst.StrategyAirSupport then
					var_27_0 = ChapterAirSupportAIAction.New(arg_27_0)
				end

				var_27_0:SetTargetLine({
					row = arg_24_0.op.arg2,
					column = arg_24_0.op.arg3
				})
			else
				var_27_0 = ChapterMissileExplodeAction.New(arg_27_0)
			end
		elseif arg_27_0.act_type == ChapterConst.ActType_Expel then
			var_27_0 = ChapterExpelAIAction.New(arg_27_0)

			var_27_0:SetTargetLine({
				row = arg_24_0.op.arg2,
				column = arg_24_0.op.arg3
			}, {
				row = arg_24_0.op.arg4,
				column = arg_24_0.op.arg5
			})
		else
			var_27_0 = ChapterAIAction.New(arg_27_0)
		end

		table.insert(arg_24_0.aiActs, var_27_0)

		return
	end)
	_.each(arg_24_0.data.fleet_act_list, function(arg_28_0)
		table.insert(arg_24_0.aiActs, FleetAIAction.New(arg_28_0))

		return
	end)

	return
end

function var_0_0.doBarrier(arg_29_0)
	local var_29_0 = arg_29_0.chapter
	local var_29_1 = arg_29_0.chapter:getChapterCell(arg_29_0.op.arg1, arg_29_0.op.arg2)

	assert(var_29_1, "cell not exist: " .. arg_29_0.op.arg1 .. ", " .. arg_29_0.op.arg2)

	local var_29_2 = _.detect(pg.box_data_template.all, function(arg_30_0)
		return pg.box_data_template[arg_30_0].type == ChapterConst.BoxBarrier
	end)

	if var_29_1.attachment ~= ChapterConst.AttachBox or var_29_1.attachmentId ~= var_29_2 then
		var_29_1.attachment = ChapterConst.AttachBox
		var_29_1.attachmentId = var_29_2
		var_29_1.flag = ChapterConst.CellFlagDisabled
	end

	var_29_0.modelCount = var_29_0.modelCount + (var_29_1.flag == ChapterConst.CellFlagDisabled and -1 or 1)
	var_29_1.flag = 1 - var_29_1.flag

	var_29_0:updateChapterCell(var_29_1)

	arg_29_0.flag = bit.bor(arg_29_0.flag, ChapterConst.DirtyAttachment, ChapterConst.DirtyStrategy)

	return
end

function var_0_0.doRequest(arg_31_0)
	if #arg_31_0.data.move_path > 0 then
		arg_31_0.chapter.fleet.line = {
			row = arg_31_0.data.move_path[#arg_31_0.data.move_path].row,
			column = arg_31_0.data.move_path[#arg_31_0.data.move_path].column
		}
	end

	arg_31_0.flag = -1

	return
end

function var_0_0.doSkipBattle(arg_32_0)
	arg_32_0.flag = bit.bor(arg_32_0.flag, ChapterConst.DirtyStrategy, ChapterConst.DirtyAttachment, ChapterConst.DirtyAchieve, ChapterConst.DirtyFleet, ChapterConst.DirtyChampion)

	return
end

function var_0_0.doTeleportSub(arg_33_0)
	arg_33_0.fullpath = {
		_.detect(arg_33_0.chapter.fleets, function(arg_34_0)
			return arg_34_0.id == var_0.id
		end).startPos,
		{
			row = arg_33_0.op.arg1,
			column = arg_33_0.op.arg2
		}
	}

	return
end

function var_0_0.doEnemyRound(arg_35_0)
	arg_35_0.chapter:IncreaseRound()

	if arg_35_0.chapter:getPlayType() == ChapterConst.TypeDefence then
		arg_35_0.flag = bit.bor(arg_35_0.flag, ChapterConst.DirtyAttachment)
	end

	arg_35_0.extraFlag = bit.bor(arg_35_0.extraFlag, ChapterConst.DirtyAutoAction)

	return
end

function var_0_0.doTeleportByPortal(arg_36_0)
	local var_36_0 = arg_36_0.fullpath and arg_36_0.fullpath[#arg_36_0.fullpath]

	if not var_36_0 then
		return
	end

	local var_36_2

	if arg_36_0.op.type == ChapterConst.OpMove then
		var_36_2 = var_36_1:GetCellEventByKey("jump", var_36_0.row, var_36_0.column)
	elseif arg_36_0.op.type == ChapterConst.OpSubTeleport then
		var_36_2 = var_36_1:GetCellEventByKey("jumpsub", var_36_0.row, var_36_0.column)
	end

	if not var_36_2 then
		return
	end

	local var_36_3 = {
		row = var_36_2[1],
		column = var_36_2[2]
	}

	if arg_36_0.op.type == ChapterConst.OpMove and var_36_1:getFleet(FleetType.Normal, var_36_3.row, var_36_3.column) then
		return
	end

	arg_36_0.teleportPaths = arg_36_0.teleportPaths or {}

	table.insert(arg_36_0.teleportPaths, {
		row = var_36_0.row,
		column = var_36_0.column
	})
	table.insert(arg_36_0.teleportPaths, var_36_3)

	return
end

function var_0_0.doCollectCommonAction(arg_37_0)
	arg_37_0.aiActs = arg_37_0.aiActs or {}

	table.insert(arg_37_0.aiActs, ChapterCommonAction.New(arg_37_0))

	return
end

function var_0_0.AddBoxAction(arg_38_0)
	local var_38_0 = arg_38_0.chapter:getChapterCell(arg_38_0.chapter.fleet.line.row, arg_38_0.chapter.fleet.line.column)

	assert(pg.box_data_template[var_38_0.attachmentId], "box_data_template not exist: " .. var_38_0.attachmentId)

	if pg.box_data_template[var_38_0.attachmentId].type == ChapterConst.BoxStrategy then
		table.insert(arg_38_0.items, Drop.New({
			type = DROP_TYPE_STRATEGY,
			id = pg.box_data_template[var_38_0.attachmentId].effect_id,
			count = pg.box_data_template[var_38_0.attachmentId].effect_arg
		}))
	end

	arg_38_0.aiActs = arg_38_0.aiActs or {}

	table.insert(arg_38_0.aiActs, ChapterBoxAction.New(arg_38_0))

	return
end

return var_0_0
