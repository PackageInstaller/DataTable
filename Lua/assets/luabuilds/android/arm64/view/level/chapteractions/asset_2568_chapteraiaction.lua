local ChapterAIAction = class("ChapterAIAction")

function ChapterAIAction:Ctor(arg_1_1)
	self.line = {
		row = arg_1_1.ai_pos.row,
		column = arg_1_1.ai_pos.column
	}
	self.stgId = arg_1_1.strategy_id

	if arg_1_1.target_pos then
		self.stgTarget = {
			row = arg_1_1.target_pos.row,
			column = arg_1_1.target_pos.column
		}
	end

	self.movePath = _.map(arg_1_1.move_path, function(arg_2_0)
		return {
			row = arg_2_0.row,
			column = arg_2_0.column
		}
	end)
	self.shipUpdate = _.map(arg_1_1.ship_update, function(arg_3_0)
		return {
			id = arg_3_0.id,
			hpRant = arg_3_0.hp_rant
		}
	end)
	self.cellUpdates = {}

	_.each(arg_1_1.map_update, function(arg_4_0)
		if arg_4_0.item_type ~= ChapterConst.AttachNone and arg_4_0.item_type ~= ChapterConst.AttachBorn and arg_4_0.item_type ~= ChapterConst.AttachBorn_Sub and (arg_4_0.item_type ~= ChapterConst.AttachStory or arg_4_0.item_data ~= ChapterConst.StoryTrigger) then
			table.insert(self.cellUpdates, arg_4_0.item_type == ChapterConst.AttachChampion and ChapterChampionPackage.New(arg_4_0) or ChapterCell.New(arg_4_0))
		end

		return
	end)

	self.actType = arg_1_1.act_type
	self.hp_del = arg_1_1.hp_del

	return
end

function ChapterAIAction:PlayAIAction(arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_1:getChapterCell(self.line.row, self.line.column)

	if var_5_0 and var_5_0.attachment == ChapterConst.AttachLandbase and not table.equal(self.stgTarget, {
		row = 9999,
		columns = 9999
	}) then
		if pg.land_based_template[var_5_0.attachmentId].type == ChapterConst.LBCoastalGun then
			arg_5_2.viewComponent:doPlayAnim("coastalgun", function(arg_6_0)
				setActive(arg_6_0, false)
				arg_5_3()

				return
			end)
		elseif pg.land_based_template[var_5_0.attachmentId].type == ChapterConst.LBHarbor then
			if not self.hp_del or self.hp_del <= 0 then
				arg_5_3()
			end

			arg_5_2.viewComponent.grid:PlayAttachmentEffect(var_5_0.row, var_5_0.column, "huoqiubaozha", Vector2.zero)
			arg_5_3()
		elseif pg.land_based_template[var_5_0.attachmentId].type == ChapterConst.LBDock then
			arg_5_3()
		elseif pg.land_based_template[var_5_0.attachmentId].type == ChapterConst.LBAntiAir then
			arg_5_2.viewComponent:doPlayAnim("AntiAirFire", function(arg_7_0)
				setActive(arg_7_0, false)
				arg_5_2.viewComponent.grid:PlayAttachmentEffect(self.stgTarget.row, self.stgTarget.column, "huoqiubaozha", Vector2.zero, arg_5_3)

				return
			end)
		else
			assert(false)
		end

		return
	end

	if self.stgId > 0 then
		if self.stgId == ChapterConst.StrategySonarDetect then
			local var_5_1 = {}

			_.each(self.cellUpdates, function(arg_8_0)
				if isa(arg_8_0, ChapterChampionPackage) then
					table.insert(var_5_1, arg_8_0)
				end

				return
			end)
			arg_5_2.viewComponent.grid:PlaySonarDetectAnim(var_5_1, arg_5_3)
		else
			assert(false)
		end

		return
	end

	local var_5_2 = arg_5_1:getChampion(self.line.row, self.line.column)
	local var_5_3 = arg_5_1:getChampionIndex(self.line.row, self.line.column)
	local var_5_4 = self.movePath[#self.movePath] or self.line

	if var_5_3 then
		seriesAsync({
			function(arg_9_0)
				if #self.movePath > 0 then
					arg_5_2.viewComponent.grid:moveChampion(var_5_3, self.movePath, Clone(self.movePath), arg_9_0)
				else
					arg_9_0()
				end

				return
			end,
			function(arg_10_0)
				if #self.shipUpdate > 0 then
					arg_5_2.viewComponent:doPlayEnemyAnim(var_5_2, "SubSairenTorpedoUI", arg_10_0)
				else
					arg_10_0()
				end

				return
			end,
			function(arg_11_0)
				local var_11_0 = false

				if self.actType == ChapterConst.ActType_SubmarineHunting and #self.cellUpdates > 0 then
					_.each(self.cellUpdates, function(arg_12_0)
						if var_5_4.row == arg_12_0.row and var_5_4.column == arg_12_0.column and isa(arg_12_0, ChapterChampionPackage) then
							self:TryPlayChampionSubAnim(arg_5_2, arg_12_0, var_5_2, arg_11_0)

							var_11_0 = true
						end

						return
					end)
				end

				if not false then
					arg_11_0()
				end

				return
			end,
			function(arg_13_0)
				arg_5_3()

				return
			end
		})

		return
	end

	assert(false)

	return
end

function ChapterAIAction:TryPlayChampionSubAnim(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	if arg_14_2.flag == ChapterConst.CellFlagDiving or arg_14_3.flag == ChapterConst.CellFlagDiving then
		if arg_14_2.flag ~= ChapterConst.CellFlagActive then
			if arg_14_3.flag == ChapterConst.CellFlagActive then
				arg_14_1.viewComponent.grid:PlayChampionSubmarineAnimation(arg_14_3, arg_14_2.flag == ChapterConst.CellFlagDiving, arg_14_4)

				return
			end
		end
	end

	arg_14_4()

	return
end

function ChapterAIAction:applyTo(arg_15_1, arg_15_2)
	local var_15_0 = arg_15_1:getChapterCell(self.line.row, self.line.column)

	if var_15_0 and var_15_0.attachment == ChapterConst.AttachLandbase and not table.equal(self.stgTarget, {
		row = 9999,
		column = 9999
	}) then
		if pg.land_based_template[var_15_0.attachmentId].type == ChapterConst.LBCoastalGun then
			return self:applyToCoastalGun(arg_15_1, var_15_0, arg_15_2)
		elseif pg.land_based_template[var_15_0.attachmentId].type == ChapterConst.LBHarbor then
			return self:applyToHarbor(arg_15_1, var_15_0, arg_15_2)
		elseif pg.land_based_template[var_15_0.attachmentId].type == ChapterConst.LBDock then
			return self:applyToDock(arg_15_1, var_15_0, arg_15_2)
		elseif pg.land_based_template[var_15_0.attachmentId].type == ChapterConst.LBAntiAir then
			return self:applyToAntiAir(arg_15_1, var_15_0, arg_15_2)
		else
			return false, "Trouble with Attach LandBased"
		end
	end

	if self.stgId > 0 then
		return self:applyToStrategy(arg_15_1, self.stgId, arg_15_2)
	end

	local var_15_1 = arg_15_1:getChampion(self.line.row, self.line.column)

	if var_15_1 then
		return self:applyToChampion(arg_15_1, var_15_1, arg_15_2)
	end

	return false, "can not find any object at: [" .. self.line.row .. ", " .. self.line.column .. "]"
end

function ChapterAIAction:applyToChampion(arg_16_1, arg_16_2, arg_16_3)
	if arg_16_2.flag == ChapterConst.CellFlagDisabled then
		return false, "can not apply ai to dead champion at: [" .. self.line.row .. ", " .. self.line.column .. "]"
	end

	local var_16_0 = 0
	local var_16_1 = 0
	local var_16_2 = self.line

	if self.stgId > 0 and not pg.strategy_data_template[self.stgId] then
		return false, "can not find strategy: " .. self.stgId
	end

	if #self.movePath > 0 then
		var_16_2 = self.movePath[#self.movePath]

		if _.any(self.movePath, function(arg_17_0)
			local var_17_0 = arg_16_1:getChapterCell(arg_17_0.row, arg_17_0.column)

			return not var_17_0 or not var_17_0:IsWalkable()
		end) then
			return false, "invalide move path"
		end
	end

	if #self.shipUpdate > 0 and not arg_16_1:getFleet(FleetType.Normal, var_16_2.row, var_16_2.column) then
		return false, "can not find fleet at: [" .. self.line.row .. ", " .. self.line.column .. "]"
	end

	if not arg_16_3 then
		if #self.movePath > 0 then
			arg_16_2.row = var_16_2.row
			arg_16_2.column = var_16_2.column
			var_16_0 = bit.bor(var_16_0, ChapterConst.DirtyChampionPosition)
		end

		if arg_16_1:existFleet(FleetType.Submarine, arg_16_2.row, arg_16_2.column) then
			var_16_0 = bit.bor(var_16_0, ChapterConst.DirtyFleet)
		end

		if self.actType == ChapterConst.ActType_SubmarineHunting then
			local var_16_3 = arg_16_1:getChapterCell(var_16_2.row, var_16_2.column)

			if var_16_3 and var_16_3.attachment == ChapterConst.AttachBarrier then
				var_16_3.flag = ChapterConst.CellFlagDisabled

				arg_16_1:mergeChapterCell(var_16_3)

				var_16_0 = bit.bor(var_16_0, ChapterConst.DirtyAttachment)
			end
		end

		if #self.shipUpdate > 0 then
			_.each(self.shipUpdate, function(arg_18_0)
				arg_16_1:updateFleetShipHp(arg_18_0.id, arg_18_0.hpRant)

				return
			end)

			var_16_0 = bit.bor(var_16_0, ChapterConst.DirtyFleet)
		end

		if #self.cellUpdates > 0 then
			_.each(self.cellUpdates, function(arg_19_0)
				if isa(arg_19_0, ChapterChampionPackage) then
					var_16_0 = bit.bor(var_16_0, (arg_16_1:mergeChampion(arg_19_0) or nil) and (ChapterConst.DirtyChampionPosition or ChapterConst.DirtyChampion))
				else
					arg_16_1:mergeChapterCell(arg_19_0)

					var_16_0 = bit.bor(var_16_0, ChapterConst.DirtyAttachment)
				end

				return
			end)

			var_16_1 = bit.bor(var_16_1, ChapterConst.DirtyAutoAction)
		end
	end

	return true, var_16_0, var_16_1
end

function ChapterAIAction:applyToStrategy(arg_20_1, arg_20_2, arg_20_3)
	if not pg.strategy_data_template[arg_20_2] then
		return false, "can not find strategy: " .. arg_20_2
	end

	local var_20_0 = 0

	if not arg_20_3 and self.stgId == ChapterConst.StrategySonarDetect then
		_.each(self.cellUpdates, function(arg_21_0)
			if isa(arg_21_0, ChapterChampionPackage) then
				arg_20_1:mergeChampion(arg_21_0)

				var_20_0 = bit.bor(var_20_0, ChapterConst.DirtyChampion)
			else
				arg_20_1:mergeChapterCell(arg_21_0)

				var_20_0 = bit.bor(var_20_0, ChapterConst.DirtyAttachment)
			end

			return
		end)
	end

	return true, var_20_0
end

function ChapterAIAction:applyToCoastalGun(arg_22_1, arg_22_2, arg_22_3)
	if arg_22_2.flag == ChapterConst.CellFlagDisabled then
		return false, "can not apply ai to dead coastalgun at: [" .. self.line.row .. ", " .. self.line.column .. "]"
	end

	local var_22_0 = 0
	local var_22_1 = 0
	local var_22_2 = arg_22_1:getFleet(FleetType.Normal, self.stgTarget.row, self.stgTarget.column)

	if not var_22_2 then
		return false, "can not find fleet at: [" .. self.stgTarget.row .. ", " .. self.stgTarget.column .. "]"
	end

	if not arg_22_3 then
		var_22_2:increaseSlowSpeedFactor()

		var_22_0 = bit.bor(var_22_0, ChapterConst.DirtyFleet)

		_.each(self.cellUpdates, function(arg_23_0)
			if isa(arg_23_0, ChapterChampionPackage) then
				arg_22_1:mergeChampion(arg_23_0)

				var_22_0 = bit.bor(var_22_0, ChapterConst.DirtyChampion)
			else
				arg_22_1:mergeChapterCell(arg_23_0)

				var_22_0 = bit.bor(var_22_0, ChapterConst.DirtyAttachment)
			end

			return
		end)

		if #self.cellUpdates > 0 then
			var_22_1 = bit.bor(var_22_1, ChapterConst.DirtyAutoAction)
		end
	end

	return true, var_22_0, var_22_1
end

function ChapterAIAction:applyToHarbor(arg_24_1, arg_24_2, arg_24_3)
	if arg_24_2.flag == ChapterConst.CellFlagDisabled then
		return false, "can not apply ai to dead Harbor at: [" .. self.line.row .. ", " .. self.line.column .. "]"
	end

	local var_24_0 = 0
	local var_24_1 = 0
	local var_24_2 = arg_24_1:getChampion(self.stgTarget.row, self.stgTarget.column)

	if not var_24_2 then
		return false, "can not find champion at: [" .. self.stgTarget.row .. ", " .. self.stgTarget.column .. "]"
	end

	if not arg_24_3 then
		arg_24_1.BaseHP = math.max(arg_24_1.BaseHP - self.hp_del, 0)

		arg_24_1:RemoveChampion(var_24_2)

		var_24_0 = bit.bor(var_24_0, ChapterConst.DirtyBase, ChapterConst.DirtyChampion)
		var_24_1 = bit.bor(var_24_1, ChapterConst.DirtyAutoAction)

		if #self.cellUpdates > 0 then
			_.each(self.cellUpdates, function(arg_25_0)
				if isa(arg_25_0, ChapterChampionPackage) then
					local var_25_0 = arg_24_1:mergeChampion(arg_25_0)

					var_24_0 = bit.bor(var_24_0, ChapterConst.DirtyChampion)
				else
					arg_24_1:mergeChapterCell(arg_25_0)

					var_24_0 = bit.bor(var_24_0, ChapterConst.DirtyAttachment)
				end

				return
			end)
		end
	end

	return true, var_24_0, var_24_1
end

function ChapterAIAction:applyToDock(arg_26_1, arg_26_2, arg_26_3)
	if arg_26_2.flag == ChapterConst.CellFlagDisabled then
		return false, "can not apply ai to dead Dock at: [" .. self.line.row .. ", " .. self.line.column .. "]"
	end

	local var_26_0 = 0

	if not arg_26_1:getFleet(FleetType.Normal, self.stgTarget.row, self.stgTarget.column) then
		return false, "can not find fleet at: [" .. self.stgTarget.row .. ", " .. self.stgTarget.column .. "]"
	end

	if not arg_26_3 then
		_.each(self.cellUpdates, function(arg_27_0)
			if isa(arg_27_0, ChapterCell) then
				arg_26_1:mergeChapterCell(arg_27_0)

				var_26_0 = bit.bor(var_26_0, ChapterConst.DirtyAttachment)
			end

			return
		end)
		_.each(self.shipUpdate, function(arg_28_0)
			arg_26_1:updateFleetShipHp(arg_28_0.id, arg_28_0.hpRant)

			return
		end)

		var_26_0 = bit.bor(var_26_0, ChapterConst.DirtyFleet)
	end

	return true, var_26_0
end

function ChapterAIAction:applyToAntiAir(arg_29_1, arg_29_2, arg_29_3)
	if arg_29_2.flag == ChapterConst.CellFlagDisabled then
		return false, "can not apply ai to dead antiairGun at: [" .. self.line.row .. ", " .. self.line.column .. "]"
	end

	local var_29_0 = 0
	local var_29_1 = arg_29_1:getChampion(self.stgTarget.row, self.stgTarget.column)

	if not var_29_1 then
		return false, "can not find champion at: [" .. self.stgTarget.row .. ", " .. self.stgTarget.column .. "]"
	end

	if not arg_29_3 then
		arg_29_1:RemoveChampion(var_29_1)

		var_29_0 = bit.bor(var_29_0, ChapterConst.DirtyChampion, ChapterConst.DirtyAttachment)

		_.each(self.cellUpdates, function(arg_30_0)
			if isa(arg_30_0, ChapterChampionPackage) then
				local var_30_0 = arg_29_1:mergeChampion(arg_30_0)
			else
				arg_29_1:mergeChapterCell(arg_30_0)

				var_29_0 = bit.bor(var_29_0, ChapterConst.DirtyAttachment)
			end

			return
		end)
	end

	return true, var_29_0, 0
end

return ChapterAIAction
