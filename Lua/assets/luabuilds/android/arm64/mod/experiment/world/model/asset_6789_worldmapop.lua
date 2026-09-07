local WorldMapOp = class("WorldMapOp", import("...BaseEntity"))

WorldMapOp.Fields = {
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

function WorldMapOp:Apply()
	assert(not self.applied, "current op has been applied.")

	self.applied = true

	local var_1_0 = getProxy(WorldProxy)
	local var_1_1 = nowWorld()
	local var_1_2 = var_1_1:GetActiveMap()

	if self.op == WorldConst.OpReqMoveFleet then
		var_1_1:IncRound()
	elseif self.op == WorldConst.OpReqRound then
		var_1_1:IncRound()
	elseif self.op == WorldConst.OpReqEvent then
		local var_1_3 = var_1_2:GetFleet(self.id)
		local var_1_4 = self.effect
		local var_1_5 = self.effect.effect_paramater

		if self.effect.effect_type == WorldMapAttachment.EffectEventTeleport or self.effect.effect_type == WorldMapAttachment.EffectEventTeleportBack then
			assert((self.destMapId or nil) and self.destMapId > 0)
			var_1_0:NetUpdateActiveMap(self.entranceId, self.destMapId, self.destGridId)
		elseif self.effect.effect_type == WorldMapAttachment.EffectEventShipBuff then
			local var_1_7 = var_1_5[1]

			_.each(var_1_3:GetShips(true), function(arg_2_0)
				arg_2_0:AddBuff(var_1_7, 1)

				return
			end)
		elseif self.effect.effect_type == WorldMapAttachment.EffectEventAchieveCarry then
			_.each(var_1_5, function(arg_3_0)
				local var_3_0 = WorldCarryItem.New()

				var_3_0:Setup(arg_3_0)
				var_1_3:AddCarry(var_3_0)

				return
			end)
		elseif self.effect.effect_type == WorldMapAttachment.EffectEventConsumeCarry then
			_.each(var_1_5[1] or {}, function(arg_4_0)
				var_1_3:RemoveCarry(arg_4_0)

				return
			end)
		elseif self.effect.effect_type == WorldMapAttachment.EffectEventConsumeItem then
			var_1_1:GetInventoryProxy():RemoveItem(var_1_5[1], var_1_5[2])
		elseif self.effect.effect_type == WorldMapAttachment.EffectEventDropTreasure then
			var_1_1.treasureCount = var_1_1.treasureCount + 1
		elseif self.effect.effect_type == WorldMapAttachment.EffectEventFOV then
			var_1_2:EventEffectOpenFOV(var_1_4)
		elseif self.effect.effect_type == WorldMapAttachment.EffectEventProgress then
			var_1_1:UpdateProgress((math.max(var_1_1:GetProgress(), var_1_5[1])))
		elseif self.effect.effect_type == WorldMapAttachment.EffectEventDeleteTask then
			local var_1_9 = var_1_1:GetTaskProxy()

			for iter_1_0, iter_1_1 in ipairs(var_1_5) do
				var_1_9:deleteTask(iter_1_1)
			end
		elseif self.effect.effect_type == WorldMapAttachment.EffectEventGlobalBuff then
			var_1_1:AddGlobalBuff(var_1_5[1], var_1_5[2])
		elseif self.effect.effect_type == WorldMapAttachment.EffectEventMapClearFlag then
			var_1_2:UpdateClearFlag(var_1_5[1] == 1)
		elseif self.effect.effect_type == WorldMapAttachment.EffectEventBrokenClean then
			for iter_1_2, iter_1_3 in ipairs(var_1_1:GetShips()) do
				if iter_1_3:IsBroken() then
					iter_1_3:RemoveBuff(WorldConst.BrokenBuffId)
				end
			end
		elseif self.effect.effect_type == WorldMapAttachment.EffectEventCatSalvage then
			-- block empty
		elseif self.effect.effect_type == WorldMapAttachment.EffectEventAddWorldBossFreeCount then
			nowWorld():GetBossProxy():AddSummonFree(1)
		end

		if #var_1_4.sound_effects > 0 then
			pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:" .. var_1_4.sound_effects)
		end
	elseif self.op == WorldConst.OpReqDiscover then
		_.each(self.locations, function(arg_5_0)
			var_1_2:GetCell(arg_5_0.row, arg_5_0.column):UpdateDiscovered(true)

			return
		end)
		_.each(self.hiddenAttachments, function(arg_6_0)
			arg_6_0:UpdateLurk(false)

			return
		end)
	elseif self.op == WorldConst.OpReqTransport then
		assert(self.destMapId and self.destMapId > 0)
		var_1_0:NetUpdateActiveMap(self.entranceId, self.destMapId, self.destGridId)

		local var_1_11 = var_1_1:TreasureMap2ItemId(self.destMapId, self.entranceId)

		if var_1_11 then
			var_1_1:GetInventoryProxy():RemoveItem(var_1_11, 1)
		end
	elseif self.op == WorldConst.OpReqSub then
		var_1_1:ResetSubmarine()
		var_1_1:UpdateSubmarineSupport(true)

		local var_1_12 = var_1_1:GetActiveMap()
	elseif self.op == WorldConst.OpReqPressingMap then
		var_1_1:FlagMapPressingAward(self.arg1)
		var_1_1:GetAtlas():AddPressingMap(self.arg1)

		local var_1_13 = var_1_1:GetMap(self.arg1)

		if not var_1_13.visionFlag then
			if nowWorld():IsMapVisioned(self.arg1) then
				var_1_13:UpdateVisionFlag(true)
			end
		end
	elseif self.op == WorldConst.OpReqJumpOut then
		assert(self.destMapId and self.destMapId > 0)

		local var_1_15 = var_1_1:GetInventoryProxy()

		_.each(pg.world_chapter_template_reset[var_1_2.gid].reset_item, function(arg_7_0)
			var_1_15:RemoveItem(arg_7_0)

			return
		end)
		var_1_0:NetUpdateActiveMap(self.entranceId, self.destMapId, self.destGridId)

		var_1_2 = var_1_1:GetActiveMap()
	elseif self.op == WorldConst.OpReqEnterPort then
		-- block empty
	elseif self.op == WorldConst.OpReqCatSalvage then
		var_1_2:GetFleet(self.id):UpdateCatSalvage(0, nil, 0)
	elseif self.op == WorldConst.OpReqSkipBattle then
		var_1_2:WriteBack(true, {
			statistics = {},
			hpDropInfo = {}
		})
	elseif self.op == WorldConst.OpActionFleetMove then
		var_1_2:UpdateFleetLocation(self.id, self.path[#self.path].row, self.path[#self.path].column)

		var_1_1.stepCount = var_1_1.stepCount + #self.path
	elseif self.op == WorldConst.OpActionMoveStep then
		self:ApplyAttachmentUpdate()
		_.each(self.hiddenCells, function(arg_8_0)
			arg_8_0:UpdateDiscovered(true)

			return
		end)

		local var_1_16 = var_1_2:GetFleet(self.id)
		local var_1_17 = var_1_2:GetCell(var_1_16.row, var_1_16.column):GetEventAttachment()

		if var_1_17 and var_1_17:IsTriggered() then
			var_1_17.triggered = false
		end

		if self.updateCarryItems and #self.updateCarryItems > 0 then
			local var_1_18 = var_1_16:GetCarries()

			assert(#var_1_18 == #self.updateCarryItems)

			for iter_1_4, iter_1_5 in ipairs(var_1_18) do
				iter_1_5:UpdateOffset(self.updateCarryItems[iter_1_4].offsetRow, self.updateCarryItems[iter_1_4].offsetColumn)
			end

			WPool:ReturnArray(self.updateCarryItems)

			self.updateCarryItems = nil
		end

		var_1_2:UpdateFleetLocation(self.id, self.pos.row, self.pos.column)
		_.each(self.hiddenAttachments, function(arg_9_0)
			arg_9_0:UpdateLurk(false)

			return
		end)
	elseif self.op == WorldConst.OpActionAttachmentMove then
		assert(#self.path > 0)

		local var_1_19 = self.attachment:Clone()

		var_1_2:GetCell(self.attachment.row, self.attachment.column):RemoveAttachment(self.attachment)

		local var_1_20 = var_1_2:GetCell(self.path[#self.path].row, self.path[#self.path].column)

		assert(var_1_20, "dest cell not exist: " .. self.path[#self.path].row .. ", " .. self.path[#self.path].column)

		var_1_19.row = self.path[#self.path].row
		var_1_19.column = self.path[#self.path].column

		var_1_20:AddAttachment(var_1_19)
	elseif self.op == WorldConst.OpActionEventOp then
		if self.effect.effect_type == WorldMapAttachment.EffectEventFOV then
			var_1_2:EventEffectOpenFOV(self.effect)
		end

		self.attachment:UpdateDataOp(self.attachment.dataop - 1)
	elseif self.op == WorldConst.OpActionTaskGoto then
		if self.effect.effect_type == WorldMapAttachment.EffectEventFOV then
			var_1_2:EventEffectOpenFOV(self.effect)
		end
	end

	if self.childOps then
		_.each(self.childOps, function(arg_10_0)
			if not arg_10_0.applied then
				arg_10_0:Apply()
			end

			return
		end)
	end

	if self.stepOps then
		_.each(self.stepOps, function(arg_11_0)
			if not arg_11_0.applied then
				arg_11_0:Apply()
			end

			return
		end)
	end

	self:ApplyAttachmentUpdate()
	self:ApplyNetUpdate()

	if self.callbacksWhenApplied then
		_.each(self.callbacksWhenApplied, function(arg_12_0)
			arg_12_0()

			return
		end)
	end

	return
end

function WorldMapOp:ApplyAttachmentUpdate()
	local var_13_0 = nowWorld():GetActiveMap()

	if self.updateAttachmentCells then
		getProxy(WorldProxy):UpdateMapAttachmentCells(var_13_0.id, self.updateAttachmentCells)

		for iter_13_0, iter_13_1 in pairs(self.updateAttachmentCells) do
			local var_13_1 = var_13_0:GetCell(iter_13_1.pos.row, iter_13_1.pos.column)

			_.each(iter_13_1.attachmentList, function(arg_14_0)
				if not var_13_1:ContainsAttachment(arg_14_0) then
					WPool:Return(arg_14_0)
				end

				return
			end)
		end

		self.updateAttachmentCells = nil
	end

	return
end

function WorldMapOp:ApplyNetUpdate()
	local var_15_0 = getProxy(WorldProxy)
	local var_15_1 = nowWorld()
	local var_15_2 = var_15_1:GetActiveMap()

	if self.staminaUpdate then
		var_15_1.staminaMgr:ChangeStamina(self.staminaUpdate[1], self.staminaUpdate[2])

		self.staminaUpdate = nil
	end

	if self.shipUpdates and #self.shipUpdates > 0 then
		var_15_0:ApplyShipUpdate(self.shipUpdates)
		WPool:ReturnArray(self.shipUpdates)

		self.shipUpdates = nil
	end

	if self.fleetAttachUpdates and #self.fleetAttachUpdates > 0 then
		var_15_0:ApplyFleetAttachUpdate(var_15_2.id, self.fleetAttachUpdates)
		WPool:ReturnArray(self.fleetAttachUpdates)

		self.fleetAttachUpdates = nil
	end

	if self.fleetUpdates and #self.fleetUpdates > 0 then
		var_15_0:ApplyFleetUpdate(var_15_2.id, self.fleetUpdates)
		WPool:ReturnArray(self.fleetUpdates)

		self.fleetUpdates = nil
	end

	if self.terrainUpdates and #self.terrainUpdates > 0 then
		var_15_0:ApplyTerrainUpdate(var_15_2.id, self.terrainUpdates)
		WPool:ReturnArray(self.terrainUpdates)

		self.terrainUpdates = nil
	end

	if self.salvageUpdates and #self.salvageUpdates > 0 then
		var_15_0:ApplySalvageUpdate(self.salvageUpdates)
		WPool:ReturnArray(self.salvageUpdates)

		self.salvageUpdates = nil
	end

	return
end

function WorldMapOp:AddCallbackWhenApplied(arg_16_1)
	self.callbacksWhenApplied = self.callbacksWhenApplied or {}

	table.insert(self.callbacksWhenApplied, arg_16_1)

	return
end

return WorldMapOp
