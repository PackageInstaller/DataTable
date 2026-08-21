local var_0_0 = class("WorldMapOpCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	assert(var_1_0.class == WorldMapOp, "command parameter should be type of WorldMapOp")

	;({
		act = var_1_0.op
	}).group_id = var_1_0.id or 0
	;({
		act = var_1_0.op
	}).act_arg_1 = var_1_0.arg1
	;({
		act = var_1_0.op
	}).act_arg_2 = var_1_0.arg2
	;({
		act = var_1_0.op
	}).pos_list = var_1_0.locations or {}

	pg.ConnectionMgr.GetInstance():Send(33103, {
		act = var_1_0.op
	}, 33104, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(WorldProxy)

			assert(nowWorld():GetActiveMap(), "active map not exist.")

			var_1_0.drops = PlayerConst.addTranDrop(arg_2_0.drop_list)
			var_1_0.updateAttachmentCells = var_2_0:NetBuildMapAttachmentCells(arg_2_0.pos_list)
			var_1_0.fleetAttachUpdates = var_2_0:NetBuildFleetAttachUpdate(arg_2_0.pos_list)
			var_1_0.terrainUpdates = var_2_0:NetBulidTerrainUpdate(arg_2_0.land_list)
			var_1_0.fleetUpdates = var_2_0:NetBuildFleetUpdate(arg_2_0.group_update)
			var_1_0.shipUpdates = var_2_0:NetBuildShipUpdate(arg_2_0.ship_update)
			var_1_0.salvageUpdates = var_2_0:NetBuildSalvageUpdate(arg_2_0.cmd_collection_list)

			WorldConst.DebugPrintAttachmentCell("Op is " .. var_1_0.op, var_1_0.updateAttachmentCells)
			var_2_0:NetUpdateAchievements(arg_2_0.target_list)

			if var_1_0.op == WorldConst.OpReqMoveFleet then
				arg_1_0:BuildFleetMove(arg_2_0.move_path, var_1_0)
			elseif var_1_0.op == WorldConst.OpReqRetreat then
				var_1_0.childOps = arg_1_0:BuildAIAction(arg_2_0)
			elseif var_1_0.op == WorldConst.OpReqEvent then
				if var_1_0.effect.effect_type == WorldMapAttachment.EffectEventTeleport or var_1_0.effect.effect_type == WorldMapAttachment.EffectEventTeleportBack then
					arg_1_0:BuildTransfer(arg_2_0, var_1_0)
				elseif var_1_0.effect.effect_type == WorldMapAttachment.EffectEventProgress then
					var_1_0.childOps = arg_1_0:BuildProgressAction(var_1_0.effect.effect_paramater[1])
				elseif var_1_0.effect.effect_type == WorldMapAttachment.EffectEventBlink1 or var_1_0.effect.effect_type == WorldMapAttachment.EffectEventBlink2 then
					var_1_0.childOps = arg_1_0:BuildBlinkAction(var_1_0.attachment, var_1_0.updateAttachmentCells)
				end
			elseif var_1_0.op == WorldConst.OpReqTransport then
				arg_1_0:BuildTransfer(arg_2_0, var_1_0)
			elseif var_1_0.op == WorldConst.OpReqJumpOut then
				arg_1_0:BuildTransfer(arg_2_0, var_1_0)
			elseif var_1_0.op == WorldConst.OpReqRound then
				var_1_0.childOps = arg_1_0:BuildAIAction(arg_2_0)
			elseif var_1_0.op == WorldConst.OpReqBox then
				-- block empty
			end
		else
			if arg_2_0.result == 2 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("world_stamina_not_enough"))
			elseif var_1_0.op == WorldConst.OpReqRetreat then
				pg.TipsMgr.GetInstance():ShowTips(i18n("no_way_to_escape"))
			else
				pg.TipsMgr.GetInstance():ShowTips(errorTip("world_map_op_error_", arg_2_0.result))
			end

			if var_1_0.op == WorldConst.OpReqEvent then
				WorldConst.Print(var_1_0.attachment:DebugPrint())
			end
		end

		arg_1_0:sendNotification(GAME.WORLD_MAP_OP_DONE, {
			result = arg_2_0.result,
			mapOp = var_1_0
		})

		return
	end)

	return
end

function var_0_0.BuildAIAction(arg_3_0, arg_3_1)
	local var_3_0 = {}
	local var_3_1 = getProxy(WorldProxy)

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.ai_act_list) do
		local var_3_2 = {}

		var_3_2 = iter_3_1.type == WorldMapAttachment.TypeFleet and arg_3_0:BuildFleetAction(iter_3_1) or iter_3_1.type == WorldMapAttachment.TypeTrap and arg_3_0:BuildTrapAction(iter_3_1) or arg_3_0:BuildAttachmentAction(iter_3_1)
		var_3_2[#var_3_2].shipUpdates = var_3_1:NetBuildShipUpdate(iter_3_1.ship_update)
		var_3_2[#var_3_2].fleetAttachUpdates = var_3_1:NetBuildFleetAttachUpdate(iter_3_1.pos_list)
		var_3_0 = table.mergeArray(var_3_0, var_3_2)
	end

	return var_3_0
end

function var_0_0.BuildTransfer(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2.entranceId = arg_4_1.enter_map_id
	arg_4_2.destMapId = arg_4_1.id.random_id
	arg_4_2.destGridId = arg_4_1.id.template_id
	arg_4_2.staminaUpdate = {
		arg_4_1.action_power,
		arg_4_1.action_power_extra
	}

	return
end

function var_0_0.BuildFleetMove(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = {}

	if #arg_5_1 > 0 then
		local var_5_1 = nowWorld():GetActiveMap()
		local var_5_2 = var_5_1:GetFleet()

		arg_5_2.updateAttachmentCells = {}
		var_5_0 = table.mergeArray(var_5_0, arg_5_0:BuildFleetMoveAction(arg_5_1, var_5_1, var_5_2.id, var_5_2.row, var_5_2.column, arg_5_2.updateAttachmentCells, true))
	elseif arg_5_2.trap == WorldBuff.TrapVortex then
		local var_5_3 = WBank:Fetch(WorldMapOp)

		var_5_3.op = WorldConst.OpActionFleetAnim
		var_5_3.id = arg_5_2.id
		var_5_3.anim = WorldConst.ActionYun
		var_5_3.duration = 2

		table.insert(var_5_0, var_5_3)
	end

	arg_5_2.path = _.rest(arg_5_1, 1)
	arg_5_2.childOps = var_5_0

	return
end

function var_0_0.BuildFleetPath(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_0 = nowWorld():GetActiveMap()
	local var_6_1 = nowWorld():GetActiveMap():GetFleet(arg_6_3.id)

	_.each(arg_6_1, function(arg_7_0)
		arg_7_0.duration = arg_7_0.duration * var_6_1:GetStepDurationRate()

		return
	end)

	local var_6_2 = {}
	local var_6_3 = {}
	local var_6_4 = {}
	local var_6_5 = _.map(nowWorld():GetActiveMap():GetFleet(arg_6_3.id):GetCarries(), function(arg_8_0)
		return var_6_1:BuildCarryPath(arg_8_0, arg_6_2, arg_6_1)
	end)

	_.each(arg_6_1, function(arg_9_0)
		local var_9_0 = WBank:Fetch(WorldMapOp)

		var_9_0.op = WorldConst.OpActionMoveStep
		var_9_0.id = arg_6_3.id
		var_9_0.pos = {
			row = arg_9_0.row,
			column = arg_9_0.column
		}
		var_9_0.updateAttachmentCells = {}
		var_9_0.hiddenCells = {}
		var_9_0.hiddenAttachments = {}

		if #var_0 > 0 then
			var_9_0.updateCarryItems = {}

			for iter_9_0, iter_9_1 in ipairs(var_0) do
				local var_9_1 = WPool:Get(WorldCarryItem)

				var_9_1:Setup(iter_9_1.id)
				var_9_1:UpdateOffset(var_6_5[#var_9_0.updateCarryItems + 1][#var_6_2 + 1].row - arg_9_0.row, var_6_5[#var_9_0.updateCarryItems + 1][#var_6_2 + 1].column - arg_9_0.column)
				table.insert(var_9_0.updateCarryItems, var_9_1)
			end
		end

		local var_9_3 = var_6_0:GetFOVRange(var_6_1, arg_9_0.row, arg_9_0.column)

		for iter_9_2 = arg_9_0.row - var_9_3, arg_9_0.row + var_9_3 do
			for iter_9_3 = arg_9_0.column - var_9_3, arg_9_0.column + var_9_3 do
				local var_9_4 = var_6_0:GetCell(iter_9_2, iter_9_3)

				if var_9_4 and not var_9_4.discovered and WorldConst.InFOVRange(arg_9_0.row, arg_9_0.column, iter_9_2, iter_9_3, var_9_3) and not var_6_3[iter_9_2 .. "_" .. iter_9_3] then
					var_6_3[iter_9_2 .. "_" .. iter_9_3] = true

					table.insert(var_9_0.hiddenCells, var_9_4)
					table.insert(var_6_4, {
						row = var_9_4.row,
						column = var_9_4.column
					})
					_.each(var_9_4.attachments, function(arg_10_0)
						if arg_10_0:ShouldMarkAsLurk() then
							table.insert(var_9_0.hiddenAttachments, arg_10_0)
						end

						return
					end)

					local var_9_5 = WorldMapCell.GetName(var_9_4.row, var_9_4.column)

					if arg_6_4[var_9_5] then
						_.each(arg_6_4[var_9_5].attachmentList, function(arg_11_0)
							if arg_11_0:ShouldMarkAsLurk() then
								table.insert(var_9_0.hiddenAttachments, arg_11_0)
							end

							return
						end)

						var_9_0.updateAttachmentCells[var_9_5] = arg_6_4[var_9_5]
						arg_6_4[var_9_5] = nil
					end
				end
			end
		end

		table.insert(var_6_2, var_9_0)

		return
	end)

	arg_6_3.stepOps = {}
	arg_6_3.path = arg_6_1
	arg_6_3.pos = {
		row = arg_6_2.row,
		column = arg_6_2.column
	}
	arg_6_3.locations = {}

	return
end

function var_0_0.BuildFleetAction(arg_12_0, arg_12_1)
	local var_12_0 = nowWorld():GetActiveMap()
	local var_12_1 = var_12_0:FindFleet(arg_12_1.ai_pos.row, arg_12_1.ai_pos.column)

	assert(var_12_1, "fleet not exist at: " .. arg_12_1.ai_pos.column .. ", " .. arg_12_1.ai_pos.column)

	local var_12_2 = getProxy(WorldProxy):NetBuildMapAttachmentCells(arg_12_1.pos_list)
	local var_12_3

	if #arg_12_1.move_path > 0 then
		var_12_3 = arg_12_0:BuildFleetMoveAction(arg_12_1.move_path, var_12_0, var_12_1.id, var_12_1.row, var_12_1.column, var_12_2)
	else
		local var_12_4 = WBank:Fetch(WorldMapOp)

		var_12_4.op = WorldConst.OpActionUpdate
		var_12_4.updateAttachmentCells = var_12_2
		var_12_3 = {
			var_12_4
		}
	end

	return var_12_3
end

function var_0_0.BuildFleetMoveAction(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5, arg_13_6, arg_13_7)
	if arg_13_7 then
		local var_13_0 = WorldMapCell.TerrainNone or arg_13_2:GetCell(arg_13_4, arg_13_5):GetTerrain()
		local var_13_1 = arg_13_2:GetCell(arg_13_4, arg_13_5).terrainStrong
		local var_13_2 = {
			row = arg_13_4,
			column = arg_13_5
		}
		local var_13_3 = 0
		local var_13_4 = {}

		for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
			local var_13_5 = arg_13_2:GetCell(iter_13_1.row, iter_13_1.column)
			local var_13_6 = var_13_5:GetTerrain()

			table.insert(var_13_4, {
				row = iter_13_1.row,
				column = iter_13_1.column,
				terrain = var_13_0,
				duration = WorldConst.GetTerrainMoveStepDuration(var_13_0)
			})

			local var_13_7
			local var_13_8
			local var_13_9

			if var_13_0 == WorldMapCell.TerrainWind and var_13_3 + var_13_1 > #var_13_4 then
				var_13_7 = true
			elseif var_13_0 ~= var_13_6 then
				var_13_8 = true
			elseif var_13_6 == WorldMapCell.TerrainWind then
				var_13_9 = true
			end

			if iter_13_0 == #arg_13_1 or var_13_8 then
				var_13_3 = 0

				local var_13_10 = WBank:Fetch(WorldMapOp)

				var_13_10.op = WorldConst.OpActionFleetMove
				var_13_10.id = arg_13_3
				var_13_10.arg1 = iter_13_1.row
				var_13_10.arg2 = iter_13_1.column

				arg_13_0:BuildFleetPath(var_13_4, var_13_2, var_13_10, arg_13_6)

				if iter_13_0 == #arg_13_1 then
					var_13_10.updateAttachmentCells = arg_13_6
				end

				table.insert({}, var_13_10)

				var_13_2 = {
					row = iter_13_1.row,
					column = iter_13_1.column
				}
				var_13_4 = {}
			elseif var_13_9 then
				var_13_3 = var_13_3 + var_13_1
			end

			if var_13_7 then
				-- block empty
			else
				var_13_0 = var_13_6
				var_13_1 = var_13_5.terrainStrong
			end
		end

		return {}
	end
end

function var_0_0.BuildAttachmentAction(arg_14_0, arg_14_1)
	local var_14_0 = nowWorld():GetActiveMap():GetCell(arg_14_1.ai_pos.row, arg_14_1.ai_pos.column):FindAliveAttachment(WorldMapAttachment.TypeEnemyAI)

	assert(var_14_0, "attachment not exist at: " .. arg_14_1.ai_pos.row .. ", " .. arg_14_1.ai_pos.column)

	local var_14_1 = {}
	local var_14_2 = WBank:Fetch(WorldMapOp)

	var_14_2.op = WorldConst.OpActionCameraMove
	var_14_2.attachment = var_14_0

	table.insert(var_14_1, var_14_2)

	local var_14_3 = WBank:Fetch(WorldMapOp)

	var_14_3.updateAttachmentCells = getProxy(WorldProxy):NetBuildMapAttachmentCells(arg_14_1.pos_list)

	if #arg_14_1.move_path > 0 then
		var_14_3.op = WorldConst.OpActionAttachmentMove
		var_14_3.attachment = var_14_0

		arg_14_0:BuildAttachmentActionPath(arg_14_1.move_path, var_14_3)
	else
		var_14_3.op = WorldConst.OpActionUpdate
	end

	table.insert(var_14_1, var_14_3)

	return var_14_1
end

function var_0_0.BuildAttachmentActionPath(arg_15_0, arg_15_1, arg_15_2)
	assert(nowWorld():GetActiveMap(), "active map not exist.")

	arg_15_2.path = underscore.map(arg_15_1, function(arg_16_0)
		return {
			row = arg_16_0.row,
			column = arg_16_0.column,
			duration = WorldConst.GetTerrainMoveStepDuration(WorldMapCell.TerrainNone)
		}
	end)
	arg_15_2.pos = {
		row = arg_15_2.attachment.row,
		column = arg_15_2.attachment.column
	}

	return
end

function var_0_0.BuildTrapAction(arg_17_0, arg_17_1)
	local var_17_0 = nowWorld():GetActiveMap():GetCell(arg_17_1.ai_pos.row, arg_17_1.ai_pos.column):FindAliveAttachment(WorldMapAttachment.TypeTrap)

	assert(var_17_0, "attachment not exist at: " .. arg_17_1.ai_pos.row .. ", " .. arg_17_1.ai_pos.column)

	local var_17_1 = WBank:Fetch(WorldMapOp)

	var_17_1.op = WorldConst.OpActionCameraMove
	var_17_1.attachment = var_17_0

	table.insert({}, var_17_1)

	local var_17_2 = WBank:Fetch(WorldMapOp)

	var_17_2.op = WorldConst.OpActionTrapGravityAnim
	var_17_2.attachment = var_17_0

	table.insert({}, var_17_2)

	return {}
end

function var_0_0.BuildBlinkAction(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_1:GetSpEventType()
	local var_18_1 = arg_18_2[WorldMapCell.GetName(arg_18_1.row, arg_18_1.column)]
	local var_18_2

	for iter_18_0, iter_18_1 in pairs(arg_18_2) do
		if _.any(iter_18_1.attachmentList, function(arg_19_0)
			return arg_19_0.type == arg_18_1.type and arg_19_0.id == arg_18_1.id
		end) then
			var_18_2 = iter_18_1

			break
		end
	end

	if var_18_0 == WorldMapAttachment.SpEventHaibao then
		local var_18_3 = WBank:Fetch(WorldMapOp)

		var_18_3.op = WorldConst.OpActionAttachmentAnim
		var_18_3.attachment = arg_18_1
		var_18_3.anim = WorldConst.ActionVanish
		var_18_3.updateAttachmentCells = {
			[WorldMapCell.GetName(var_18_1.pos.row, var_18_1.pos.column)] = var_18_1,
			[WorldMapCell.GetName(var_18_2.pos.row, var_18_2.pos.column)] = var_18_2
		}
		arg_18_2[WorldMapCell.GetName(var_18_1.pos.row, var_18_1.pos.column)] = nil
		arg_18_2[WorldMapCell.GetName(var_18_2.pos.row, var_18_2.pos.column)] = nil

		table.insert({}, var_18_3)

		local var_18_4 = WBank:Fetch(WorldMapOp)

		var_18_4.op = WorldConst.OpActionAttachmentAnim
		var_18_4.attachment = _.detect(var_18_2.attachmentList, function(arg_20_0)
			return arg_20_0.type == arg_18_1.type and arg_20_0.id == arg_18_1.id
		end)
		var_18_4.anim = WorldConst.ActionAppear

		table.insert({}, var_18_4)
	elseif var_18_0 == WorldMapAttachment.SpEventFufen then
		local var_18_5, var_18_6 = nowWorld():GetActiveMap():FindAIPath({
			row = arg_18_1.row,
			column = arg_18_1.column
		}, {
			row = var_18_2.pos.row,
			column = var_18_2.pos.column
		})

		if var_18_5 < PathFinding.PrioObstacle then
			local var_18_7 = WBank:Fetch(WorldMapOp)

			var_18_7.op = WorldConst.OpActionAttachmentMove
			var_18_7.attachment = arg_18_1

			arg_18_0:BuildAttachmentActionPath(var_18_6, var_18_7)
			table.insert({}, var_18_7)
		end
	end

	return {}
end

function var_0_0.BuildProgressAction(arg_21_0, arg_21_1)
	local var_21_0 = {}
	local var_21_1 = nowWorld()
	local var_21_2 = var_21_1:GetRealm()

	if arg_21_1 > var_21_1:GetProgress() then
		_.each(WorldConst.FindStageTemplates(arg_21_1), function(arg_22_0)
			if arg_22_0 and #arg_22_0.stage_effect[var_21_2] > 0 then
				_.each(arg_22_0.stage_effect[var_21_2], function(arg_23_0)
					assert(pg.world_effect_data[arg_23_0], "world_effect_data not exist: " .. arg_23_0)

					local var_23_0 = WBank:Fetch(WorldMapOp)

					var_23_0.op = WorldConst.OpActionEventEffect
					var_23_0.effect = pg.world_effect_data[arg_23_0]

					table.insert(var_21_0, var_23_0)

					return
				end)
			end

			return
		end)
	end

	return {}
end

return var_0_0
