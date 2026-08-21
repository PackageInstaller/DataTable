local var_0_0 = class("WorldMapOp", import("...BaseEntity"))

var_0_0.Fields = {
	terrainUpdates = "table",
	fleetUpdates = "table",
	drops = "table",
	callbacksWhenApplied = "table",
	destMapId = "number",
	salvageUpdates = "table",
	hiddenAttachments = "table",
	path = "table",
	duration = "number",
	depth = "number",
	updateAttachmentCells = "table",
	childOps = "table",
	arg1 = "number",
	anim = "string",
	arg2 = "number",
	effect = "table",
	applied = "boolean",
	skipDisplay = "boolean",
	op = "number",
	id = "number",
	trap = "number",
	routine = "function",
	updateCarryItems = "table",
	entranceId = "number",
	pos = "table",
	hiddenCells = "table",
	stepOps = "table",
	locations = "table",
	staminaUpdate = "table",
	attachment = "table",
	shipUpdates = "table",
	fleetAttachUpdates = "table",
	sign = "table",
	destGridId = "number"
}

function var_0_0.Apply(arg_1_0)
	assert(not arg_1_0.applied, "current op has been applied.")

	arg_1_0.applied = true

	local var_1_0 = getProxy(WorldProxy)
	local var_1_1 = nowWorld()
	local var_1_2 = var_1_1:GetActiveMap()

	if arg_1_0.op == WorldConst.OpReqMoveFleet then
		var_1_1:IncRound()
	elseif arg_1_0.op == WorldConst.OpReqRound then
		var_1_1:IncRound()
	elseif arg_1_0.op == WorldConst.OpReqEvent then
		local var_1_3 = var_1_2:GetFleet(arg_1_0.id)
		local var_1_4 = arg_1_0.effect
		local var_1_5 = arg_1_0.effect.effect_paramater

		if arg_1_0.effect.effect_type == WorldMapAttachment.EffectEventTeleport or arg_1_0.effect.effect_type == WorldMapAttachment.EffectEventTeleportBack then
			local var_1_7 = arg_1_0.destMapId and arg_1_0.destMapId > 0

			var_1_6(var_1_7)
			var_1_0:NetUpdateActiveMap(arg_1_0.entranceId, arg_1_0.destMapId, arg_1_0.destGridId)
		elseif arg_1_0.effect.effect_type == WorldMapAttachment.EffectEventShipBuff then
			local var_1_8 = var_1_5[1]

			_.each(var_1_2:GetFleet(arg_1_0.id):GetShips(true), function(arg_2_0)
				arg_2_0:AddBuff(var_1_8, 1)

				return
			end)
		elseif arg_1_0.effect.effect_type == WorldMapAttachment.EffectEventAchieveCarry then
			_.each(var_1_5, function(arg_3_0)
				local var_3_0 = WorldCarryItem.New()

				var_3_0:Setup(arg_3_0)
				var_1_3:AddCarry(var_3_0)

				return
			end)
		elseif arg_1_0.effect.effect_type == WorldMapAttachment.EffectEventConsumeCarry then
			local var_1_9 = var_1_5[1] or {}

			_.each(var_1_9, function(arg_4_0)
				var_1_3:RemoveCarry(arg_4_0)

				return
			end)
		elseif arg_1_0.effect.effect_type == WorldMapAttachment.EffectEventConsumeItem then
			var_1_1:GetInventoryProxy():RemoveItem(var_1_5[1], var_1_5[2])
		elseif arg_1_0.effect.effect_type == WorldMapAttachment.EffectEventDropTreasure then
			var_1_1.treasureCount = var_1_1.treasureCount + 1
		elseif arg_1_0.effect.effect_type == WorldMapAttachment.EffectEventFOV then
			var_1_2:EventEffectOpenFOV(var_1_4)
		elseif arg_1_0.effect.effect_type == WorldMapAttachment.EffectEventProgress then
			var_1_1:UpdateProgress((math.max(var_1_1:GetProgress(), var_1_5[1])))
		elseif arg_1_0.effect.effect_type == WorldMapAttachment.EffectEventDeleteTask then
			local var_1_10 = var_1_1:GetTaskProxy()

			for iter_1_0, iter_1_1 in ipairs(var_1_5) do
				var_1_10:deleteTask(iter_1_1)
			end
		elseif arg_1_0.effect.effect_type == WorldMapAttachment.EffectEventGlobalBuff then
			var_1_1:AddGlobalBuff(var_1_5[1], var_1_5[2])
		elseif arg_1_0.effect.effect_type == WorldMapAttachment.EffectEventMapClearFlag then
			var_1_2:UpdateClearFlag(var_1_5[1] == 1)
		elseif arg_1_0.effect.effect_type == WorldMapAttachment.EffectEventBrokenClean then
			for iter_1_2, iter_1_3 in ipairs(var_1_1:GetShips()) do
				if iter_1_3:IsBroken() then
					iter_1_3:RemoveBuff(WorldConst.BrokenBuffId)
				end
			end
		elseif arg_1_0.effect.effect_type == WorldMapAttachment.EffectEventCatSalvage then
			-- block empty
		elseif arg_1_0.effect.effect_type == WorldMapAttachment.EffectEventAddWorldBossFreeCount then
			nowWorld():GetBossProxy():AddSummonFree(1)
		end

		if #var_1_4.sound_effects > 0 then
			pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:" .. var_1_4.sound_effects)
		end
	elseif arg_1_0.op == WorldConst.OpReqDiscover then
		_.each(arg_1_0.locations, function(arg_5_0)
			var_1_2:GetCell(arg_5_0.row, arg_5_0.column):UpdateDiscovered(true)

			return
		end)
		_.each(arg_1_0.hiddenAttachments, function(arg_6_0)
			arg_6_0:UpdateLurk(false)

			return
		end)
	elseif arg_1_0.op == WorldConst.OpReqTransport then
		local var_1_11 = arg_1_0.destMapId and arg_1_0.destMapId > 0

		assert(var_1_11)
		var_1_0:NetUpdateActiveMap(arg_1_0.entranceId, arg_1_0.destMapId, arg_1_0.destGridId)

		local var_1_12 = var_1_1:TreasureMap2ItemId(arg_1_0.destMapId, arg_1_0.entranceId)

		if var_1_12 then
			var_1_1:GetInventoryProxy():RemoveItem(var_1_12, 1)
		end
	elseif arg_1_0.op == WorldConst.OpReqSub then
		var_1_1:ResetSubmarine()
		var_1_1:UpdateSubmarineSupport(true)

		local var_1_13 = var_1_1:GetActiveMap()
	elseif arg_1_0.op == WorldConst.OpReqPressingMap then
		var_1_1:FlagMapPressingAward(arg_1_0.arg1)
		var_1_1:GetAtlas():AddPressingMap(arg_1_0.arg1)

		local var_1_14 = var_1_1:GetMap(arg_1_0.arg1)

		if not var_1_14.visionFlag then
			if nowWorld():IsMapVisioned(arg_1_0.arg1) then
				var_1_14:UpdateVisionFlag(true)
			end
		end
	elseif arg_1_0.op == WorldConst.OpReqJumpOut then
		local var_1_15 = arg_1_0.destMapId and arg_1_0.destMapId > 0

		assert(var_1_15)

		local var_1_16 = var_1_1:GetInventoryProxy()

		_.each(pg.world_chapter_template_reset[var_1_2.gid].reset_item, function(arg_7_0)
			var_1_16:RemoveItem(arg_7_0)

			return
		end)
		var_1_0:NetUpdateActiveMap(arg_1_0.entranceId, arg_1_0.destMapId, arg_1_0.destGridId)

		var_1_2 = var_1_1:GetActiveMap()
	elseif arg_1_0.op == WorldConst.OpReqEnterPort then
		-- block empty
	elseif arg_1_0.op == WorldConst.OpReqCatSalvage then
		var_1_2:GetFleet(arg_1_0.id):UpdateCatSalvage(0, nil, 0)
	elseif arg_1_0.op == WorldConst.OpReqSkipBattle then
		var_1_2:WriteBack(true, {
			statistics = {},
			hpDropInfo = {}
		})
	elseif arg_1_0.op == WorldConst.OpActionFleetMove then
		var_1_2:UpdateFleetLocation(arg_1_0.id, arg_1_0.path[#arg_1_0.path].row, arg_1_0.path[#arg_1_0.path].column)

		var_1_1.stepCount = var_1_1.stepCount + #arg_1_0.path
	elseif arg_1_0.op == WorldConst.OpActionMoveStep then
		arg_1_0:ApplyAttachmentUpdate()
		_.each(arg_1_0.hiddenCells, function(arg_8_0)
			arg_8_0:UpdateDiscovered(true)

			return
		end)

		local var_1_17 = var_1_2:GetFleet(arg_1_0.id)
		local var_1_18 = var_1_2:GetCell(var_1_17.row, var_1_17.column):GetEventAttachment()

		if var_1_18 and var_1_18:IsTriggered() then
			var_1_18.triggered = false
		end

		if arg_1_0.updateCarryItems and #arg_1_0.updateCarryItems > 0 then
			local var_1_19 = var_1_17:GetCarries()

			assert(#var_1_19 == #arg_1_0.updateCarryItems)

			for iter_1_4, iter_1_5 in ipairs(var_1_19) do
				iter_1_5:UpdateOffset(arg_1_0.updateCarryItems[iter_1_4].offsetRow, arg_1_0.updateCarryItems[iter_1_4].offsetColumn)
			end

			WPool:ReturnArray(arg_1_0.updateCarryItems)

			arg_1_0.updateCarryItems = nil
		end

		var_1_2:UpdateFleetLocation(arg_1_0.id, arg_1_0.pos.row, arg_1_0.pos.column)
		_.each(arg_1_0.hiddenAttachments, function(arg_9_0)
			arg_9_0:UpdateLurk(false)

			return
		end)
	elseif arg_1_0.op == WorldConst.OpActionAttachmentMove then
		assert(#arg_1_0.path > 0)

		local var_1_20 = arg_1_0.attachment:Clone()

		var_1_2:GetCell(arg_1_0.attachment.row, arg_1_0.attachment.column):RemoveAttachment(arg_1_0.attachment)

		local var_1_21 = var_1_2:GetCell(arg_1_0.path[#arg_1_0.path].row, arg_1_0.path[#arg_1_0.path].column)

		assert(var_1_21, "dest cell not exist: " .. arg_1_0.path[#arg_1_0.path].row .. ", " .. arg_1_0.path[#arg_1_0.path].column)

		var_1_20.row = arg_1_0.path[#arg_1_0.path].row
		var_1_20.column = arg_1_0.path[#arg_1_0.path].column

		var_1_21:AddAttachment(var_1_20)
	elseif arg_1_0.op == WorldConst.OpActionEventOp then
		if arg_1_0.effect.effect_type == WorldMapAttachment.EffectEventFOV then
			var_1_2:EventEffectOpenFOV(arg_1_0.effect)
		end

		arg_1_0.attachment:UpdateDataOp(arg_1_0.attachment.dataop - 1)
	elseif arg_1_0.op == WorldConst.OpActionTaskGoto then
		if arg_1_0.effect.effect_type == WorldMapAttachment.EffectEventFOV then
			var_1_2:EventEffectOpenFOV(arg_1_0.effect)
		end
	end

	if arg_1_0.childOps then
		_.each(arg_1_0.childOps, function(arg_10_0)
			if not arg_10_0.applied then
				arg_10_0:Apply()
			end

			return
		end)
	end

	if arg_1_0.stepOps then
		_.each(arg_1_0.stepOps, function(arg_11_0)
			if not arg_11_0.applied then
				arg_11_0:Apply()
			end

			return
		end)
	end

	arg_1_0:ApplyAttachmentUpdate()
	arg_1_0:ApplyNetUpdate()

	if arg_1_0.callbacksWhenApplied then
		_.each(arg_1_0.callbacksWhenApplied, function(arg_12_0)
			arg_12_0()

			return
		end)
	end

	return
end

function var_0_0.ApplyAttachmentUpdate(arg_13_0)
	local var_13_0 = nowWorld():GetActiveMap()

	if arg_13_0.updateAttachmentCells then
		getProxy(WorldProxy):UpdateMapAttachmentCells(var_13_0.id, arg_13_0.updateAttachmentCells)

		for iter_13_0, iter_13_1 in pairs(arg_13_0.updateAttachmentCells) do
			local var_13_1 = var_13_0:GetCell(iter_13_1.pos.row, iter_13_1.pos.column)

			_.each(iter_13_1.attachmentList, function(arg_14_0)
				if not var_13_1:ContainsAttachment(arg_14_0) then
					WPool:Return(arg_14_0)
				end

				return
			end)
		end

		arg_13_0.updateAttachmentCells = nil
	end

	return
end

function var_0_0.ApplyNetUpdate(arg_15_0)
	local var_15_0 = getProxy(WorldProxy)
	local var_15_1 = nowWorld()
	local var_15_2 = var_15_1:GetActiveMap()

	if arg_15_0.staminaUpdate then
		var_15_1.staminaMgr:ChangeStamina(arg_15_0.staminaUpdate[1], arg_15_0.staminaUpdate[2])

		arg_15_0.staminaUpdate = nil
	end

	if arg_15_0.shipUpdates and #arg_15_0.shipUpdates > 0 then
		var_15_0:ApplyShipUpdate(arg_15_0.shipUpdates)
		WPool:ReturnArray(arg_15_0.shipUpdates)

		arg_15_0.shipUpdates = nil
	end

	if arg_15_0.fleetAttachUpdates and #arg_15_0.fleetAttachUpdates > 0 then
		var_15_0:ApplyFleetAttachUpdate(var_15_2.id, arg_15_0.fleetAttachUpdates)
		WPool:ReturnArray(arg_15_0.fleetAttachUpdates)

		arg_15_0.fleetAttachUpdates = nil
	end

	if arg_15_0.fleetUpdates and #arg_15_0.fleetUpdates > 0 then
		var_15_0:ApplyFleetUpdate(var_15_2.id, arg_15_0.fleetUpdates)
		WPool:ReturnArray(arg_15_0.fleetUpdates)

		arg_15_0.fleetUpdates = nil
	end

	if arg_15_0.terrainUpdates and #arg_15_0.terrainUpdates > 0 then
		var_15_0:ApplyTerrainUpdate(var_15_2.id, arg_15_0.terrainUpdates)
		WPool:ReturnArray(arg_15_0.terrainUpdates)

		arg_15_0.terrainUpdates = nil
	end

	if arg_15_0.salvageUpdates and #arg_15_0.salvageUpdates > 0 then
		var_15_0:ApplySalvageUpdate(arg_15_0.salvageUpdates)
		WPool:ReturnArray(arg_15_0.salvageUpdates)

		arg_15_0.salvageUpdates = nil
	end

	return
end

function var_0_0.AddCallbackWhenApplied(arg_16_0, arg_16_1)
	arg_16_0.callbacksWhenApplied = arg_16_0.callbacksWhenApplied or {}

	table.insert(arg_16_0.callbacksWhenApplied, arg_16_1)

	return
end

return var_0_0
