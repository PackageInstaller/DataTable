local ChapterOpRoutine = class("ChapterOpRoutine", pm.SimpleCommand)

function ChapterOpRoutine:initData(arg_1_1, arg_1_2, arg_1_3)
	self.op = arg_1_1
	self.data = arg_1_2
	self.chapter = arg_1_3
	self.items = {}
	self.fullpath = nil
	self.flag = 0
	self.extraFlag = 0

	return
end

function ChapterOpRoutine:doDropUpdate()
	self.items = PlayerConst.addTranDrop(self.data.drop_list)

	table.insertto(self.items, underscore.map(PlayerConst.addTranDrop(self.data.extra_drop_list), function(arg_3_0)
		arg_3_0.riraty = true

		return arg_3_0
	end))

	return
end

function ChapterOpRoutine:doMapUpdate()
	local var_4_0 = self.flag
	local var_4_1 = self.extraFlag
	local var_4_2 = self.chapter

	if #self.data.map_update > 0 then
		_.each(self.data.map_update, function(arg_5_0)
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

	self.flag = var_4_0
	self.extraFlag = var_4_1

	return
end

function ChapterOpRoutine:doCellFlagUpdate()
	local var_6_0 = self.flag
	local var_6_1 = self.chapter

	if #self.data.cell_flag_list > 0 then
		_.each(self.data.cell_flag_list, function(arg_7_0)
			local var_7_0 = var_6_1:getChapterCell(arg_7_0.pos.row, arg_7_0.pos.column)

			if var_7_0 then
				var_7_0:updateFlagList(arg_7_0)
			else
				var_7_0 = ChapterCell.New(arg_7_0)
			end

			self.chapter:updateChapterCell(var_7_0)

			return
		end)

		var_6_0 = bit.bor(var_6_0, ChapterConst.DirtyCellFlag)
	end

	self.flag = var_6_0

	return
end

function ChapterOpRoutine:doAIUpdate()
	local var_8_0 = self.flag
	local var_8_1 = self.extraFlag
	local var_8_2 = self.chapter

	if #self.data.ai_list > 0 then
		_.each(self.data.ai_list, function(arg_9_0)
			var_8_2:mergeChampion((ChapterChampionPackage.New(arg_9_0)))

			return
		end)

		var_8_0 = bit.bor(var_8_0, ChapterConst.DirtyChampion)
		var_8_1 = bit.bor(var_8_1, ChapterConst.DirtyAutoAction)
	end

	self.flag = var_8_0
	self.extraFlag = var_8_1

	return
end

function ChapterOpRoutine:doShipUpdate()
	local var_10_0 = self.flag
	local var_10_1 = self.chapter

	if #self.data.ship_update > 0 then
		_.each(self.data.ship_update, function(arg_11_0)
			var_10_1:updateFleetShipHp(arg_11_0.id, arg_11_0.hp_rant)

			var_10_0 = bit.bor(var_10_0, ChapterConst.DirtyStrategy)

			return
		end)

		var_10_0 = bit.bor(var_10_0, ChapterConst.DirtyFleet)
	end

	self.flag = var_10_0

	return
end

function ChapterOpRoutine:doBuffUpdate()
	self.chapter:UpdateBuffList(self.data.buff_list)

	return
end

function ChapterOpRoutine:doExtraFlagUpdate()
	if #self.data.add_flag_list > 0 or #self.data.del_flag_list > 0 then
		getProxy(ChapterProxy):updateExtraFlag(self.chapter, self.data.add_flag_list, self.data.del_flag_list)

		self.flag = bit.bor(self.flag, ChapterConst.DirtyFleet, ChapterConst.DirtyStrategy, ChapterConst.DirtyCellFlag, ChapterConst.DirtyFloatItems, ChapterConst.DirtyAttachment)
	end

	return
end

function ChapterOpRoutine:doRetreat(arg_14_1)
	local var_14_0 = self.flag

	if self.op.id then
		if #self.chapter.fleets > 0 then
			self.chapter:retreatFleet(self.op.id)

			var_14_0 = bit.bor(var_14_0, ChapterConst.DirtyFleet, ChapterConst.DirtyAttachment, ChapterConst.DirtyChampion, ChapterConst.DirtyStrategy)
		end
	else
		self.chapter:retreat(self.op.win, self.op.arg1, arg_14_1)
	end

	self.flag = var_14_0

	return
end

function ChapterOpRoutine:doMove()
	local var_15_0 = self.extraFlag
	local var_15_1

	if #self.data.move_path > 0 then
		var_15_1 = _.map(_.rest(self.data.move_path, 1), function(arg_16_0)
			return {
				row = arg_16_0.row,
				column = arg_16_0.column
			}
		end)
		self.chapter.moveStep = self.chapter.moveStep + #self.data.move_path
		var_15_0 = bit.bor(var_15_0, ChapterConst.DirtyAutoAction, ChapterConst.DirtyWeather)
	end

	self.fullpath = var_15_1

	self.chapter:IncreaseRound()

	self.extraFlag = var_15_0

	return
end

function ChapterOpRoutine:doOpenBox()
	local var_17_0 = self.chapter
	local var_17_1 = self.chapter.fleet.line
	local var_17_2 = self.chapter:getChapterCell(self.chapter.fleet.line.row, self.chapter.fleet.line.column)

	var_17_2.flag = ChapterConst.CellFlagDisabled

	local var_17_3 = bit.bor(self.flag, ChapterConst.DirtyAttachment)

	assert(pg.box_data_template[var_17_2.attachmentId], "box_data_template not exist: " .. var_17_2.attachmentId)

	if pg.box_data_template[var_17_2.attachmentId].type == ChapterConst.BoxStrategy then
		self.chapter.fleet:achievedStrategy(pg.box_data_template[var_17_2.attachmentId].effect_id, pg.box_data_template[var_17_2.attachmentId].effect_arg)
		table.insert(self.items, Drop.New({
			type = DROP_TYPE_STRATEGY,
			id = pg.box_data_template[var_17_2.attachmentId].effect_id,
			count = pg.box_data_template[var_17_2.attachmentId].effect_arg
		}))

		var_17_3 = bit.bor(var_17_3, ChapterConst.DirtyStrategy)
	elseif pg.box_data_template[var_17_2.attachmentId].type == ChapterConst.BoxSupply then
		local var_17_4, var_17_5 = var_17_0:getFleetAmmo(self.chapter.fleet)

		self.chapter.fleet.restAmmo = self.chapter.fleet.restAmmo + math.min(var_17_4 - var_17_5, pg.box_data_template[var_17_2.attachmentId].effect_id)
		var_17_3 = bit.bor(var_17_3, ChapterConst.DirtyFleet)

		pg.TipsMgr.GetInstance():ShowTips(i18n("level_ammo_supply_p1", pg.box_data_template[var_17_2.attachmentId].effect_id))
	end

	var_17_0:clearChapterCell(var_17_1.row, var_17_1.column)

	self.flag = var_17_3
	self.extraFlag = bit.bor(self.extraFlag, ChapterConst.DirtyAutoAction)

	return
end

function ChapterOpRoutine:doPlayStory()
	local var_18_0 = self.chapter:getChapterCell(self.chapter.fleet.line.row, self.chapter.fleet.line.column)

	var_18_0.flag = ChapterConst.CellFlagDisabled

	self.chapter:updateChapterCell(var_18_0)

	self.flag = bit.bor(self.flag, ChapterConst.DirtyAttachment)

	return
end

function ChapterOpRoutine:doAmbush()
	if self.op.arg1 == 1 then
		local var_19_0 = self.chapter:getChapterCell(self.chapter.fleet.line.row, self.chapter.fleet.line.column)

		if var_19_0.flag == ChapterConst.CellFlagAmbush then
			self.chapter:clearChapterCell(self.chapter.fleet.line.row, self.chapter.fleet.line.column)
		end

		pg.TipsMgr.GetInstance():ShowTips(var_19_0.flag == ChapterConst.CellFlagActive and i18n("chapter_tip_aovid_failed") or i18n("chapter_tip_aovid_succeed"))
	end

	return
end

function ChapterOpRoutine:doStrategy()
	local var_20_0 = self.flag
	local var_20_1 = self.op
	local var_20_2 = self.chapter
	local var_20_3 = pg.strategy_data_template[self.op.arg1]

	if pg.strategy_data_template[self.op.arg1].type == ChapterConst.StgTypeForm then
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
			var_20_2:getFleetById(var_20_1.id).line, var_20_2:getFleetById(var_20_1.arg2).line = var_20_2:getFleetById(var_20_1.arg2).line, var_20_2:getFleetById(var_20_1.id).line
			var_20_0 = bit.bor(var_20_0, ChapterConst.DirtyFleet)
		end
	elseif var_20_3.type == ChapterConst.StgTypeBindSupportConsume then
		var_20_2:getChapterSupportFleet():consumeOneStrategy(var_20_3.id)
	end

	self.flag = bit.bor(var_20_0, ChapterConst.DirtyStrategy)

	return
end

function ChapterOpRoutine:doRepair()
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

function ChapterOpRoutine:doSupply()
	local var_22_0, var_22_1 = self.chapter:getFleetAmmo(self.chapter.fleet)
	local var_22_2 = self.chapter:getChapterCell(self.chapter.fleet.line.row, self.chapter.fleet.line.column)
	local var_22_3 = math.min(var_22_2.attachmentId, var_22_0 - var_22_1)

	var_22_2.attachmentId = var_22_2.attachmentId - var_22_3
	self.chapter.fleet.restAmmo = self.chapter.fleet.restAmmo + var_22_3

	self.chapter:updateChapterCell(var_22_2)

	if var_22_2.attachmentId > 20 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("level_ammo_supply_p1", var_22_3))
	elseif var_22_2.attachmentId > 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("level_ammo_supply", var_22_3, var_22_2.attachmentId))
	else
		pg.TipsMgr.GetInstance():ShowTips(i18n("level_ammo_empty", var_22_3))
	end

	self.flag = bit.bor(self.flag, ChapterConst.DirtyAttachment, ChapterConst.DirtyFleet)

	return
end

function ChapterOpRoutine:doSubState()
	self.chapter.subAutoAttack = self.op.arg1
	self.flag = bit.bor(self.flag, ChapterConst.DirtyStrategy)

	return
end

function ChapterOpRoutine:doCollectAI()
	self.aiActs = self.aiActs or {}

	if self.data.submarine_act_list then
		_.each(self.data.submarine_act_list, function(arg_25_0)
			table.insert(self.aiActs, SubAIAction.New(arg_25_0))

			return
		end)
	end

	if self.data.escort_act_list then
		_.each(self.data.escort_act_list, function(arg_26_0)
			table.insert(self.aiActs, TransportAIAction.New(arg_26_0))

			return
		end)
	end

	_.each(self.data.ai_act_list, function(arg_27_0)
		local var_27_0

		if arg_27_0.act_type == ChapterConst.ActType_TargetDown then
			if self.op.type == ChapterConst.OpStrategy then
				if self.op.arg1 == ChapterConst.StrategyMissileStrike then
					var_27_0 = ChapterMissileExplodeAction.New(arg_27_0)
				elseif self.op.arg1 == ChapterConst.StrategyAirSupport then
					var_27_0 = ChapterAirSupportAIAction.New(arg_27_0)
				end

				var_27_0:SetTargetLine({
					row = self.op.arg2,
					column = self.op.arg3
				})
			else
				var_27_0 = ChapterMissileExplodeAction.New(arg_27_0)
			end
		elseif arg_27_0.act_type == ChapterConst.ActType_Expel then
			var_27_0 = ChapterExpelAIAction.New(arg_27_0)

			var_27_0:SetTargetLine({
				row = self.op.arg2,
				column = self.op.arg3
			}, {
				row = self.op.arg4,
				column = self.op.arg5
			})
		else
			var_27_0 = ChapterAIAction.New(arg_27_0)
		end

		table.insert(self.aiActs, var_27_0)

		return
	end)
	_.each(self.data.fleet_act_list, function(arg_28_0)
		table.insert(self.aiActs, FleetAIAction.New(arg_28_0))

		return
	end)

	return
end

function ChapterOpRoutine:doBarrier()
	local var_29_0 = self.chapter
	local var_29_1 = self.chapter:getChapterCell(self.op.arg1, self.op.arg2)

	assert(var_29_1, "cell not exist: " .. self.op.arg1 .. ", " .. self.op.arg2)

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

	self.flag = bit.bor(self.flag, ChapterConst.DirtyAttachment, ChapterConst.DirtyStrategy)

	return
end

function ChapterOpRoutine:doRequest()
	if #self.data.move_path > 0 then
		self.chapter.fleet.line = {
			row = self.data.move_path[#self.data.move_path].row,
			column = self.data.move_path[#self.data.move_path].column
		}
	end

	self.flag = -1

	return
end

function ChapterOpRoutine:doSkipBattle()
	self.flag = bit.bor(self.flag, ChapterConst.DirtyStrategy, ChapterConst.DirtyAttachment, ChapterConst.DirtyAchieve, ChapterConst.DirtyFleet, ChapterConst.DirtyChampion)

	return
end

function ChapterOpRoutine:doTeleportSub()
	local var_33_0 = self.op

	self.fullpath = {
		_.detect(self.chapter.fleets, function(arg_34_0)
			return arg_34_0.id == var_33_0.id
		end).startPos,
		{
			row = self.op.arg1,
			column = self.op.arg2
		}
	}

	return
end

function ChapterOpRoutine:doEnemyRound()
	self.chapter:IncreaseRound()

	if self.chapter:getPlayType() == ChapterConst.TypeDefence then
		self.flag = bit.bor(self.flag, ChapterConst.DirtyAttachment)
	end

	self.extraFlag = bit.bor(self.extraFlag, ChapterConst.DirtyAutoAction)

	return
end

function ChapterOpRoutine:doTeleportByPortal()
	local var_36_0 = self.fullpath and self.fullpath[#self.fullpath]

	if not var_36_0 then
		return
	end

	local var_36_1 = self.chapter
	local var_36_2

	if self.op.type == ChapterConst.OpMove then
		var_36_2 = var_36_1:GetCellEventByKey("jump", var_36_0.row, var_36_0.column)
	elseif self.op.type == ChapterConst.OpSubTeleport then
		var_36_2 = var_36_1:GetCellEventByKey("jumpsub", var_36_0.row, var_36_0.column)
	end

	if not var_36_2 then
		return
	end

	local var_36_3 = {
		row = var_36_2[1],
		column = var_36_2[2]
	}

	if self.op.type == ChapterConst.OpMove and var_36_1:getFleet(FleetType.Normal, var_36_3.row, var_36_3.column) then
		return
	end

	self.teleportPaths = self.teleportPaths or {}

	table.insert(self.teleportPaths, {
		row = var_36_0.row,
		column = var_36_0.column
	})
	table.insert(self.teleportPaths, var_36_3)

	return
end

function ChapterOpRoutine:doCollectCommonAction()
	self.aiActs = self.aiActs or {}

	table.insert(self.aiActs, ChapterCommonAction.New(self))

	return
end

function ChapterOpRoutine:AddBoxAction()
	local var_38_0 = self.chapter:getChapterCell(self.chapter.fleet.line.row, self.chapter.fleet.line.column)

	assert(pg.box_data_template[var_38_0.attachmentId], "box_data_template not exist: " .. var_38_0.attachmentId)

	if pg.box_data_template[var_38_0.attachmentId].type == ChapterConst.BoxStrategy then
		table.insert(self.items, Drop.New({
			type = DROP_TYPE_STRATEGY,
			id = pg.box_data_template[var_38_0.attachmentId].effect_id,
			count = pg.box_data_template[var_38_0.attachmentId].effect_arg
		}))
	end

	self.aiActs = self.aiActs or {}

	table.insert(self.aiActs, ChapterBoxAction.New(self))

	return
end

return ChapterOpRoutine
