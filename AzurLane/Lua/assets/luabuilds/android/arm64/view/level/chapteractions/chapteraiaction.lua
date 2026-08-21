local var_0_0 = class("ChapterAIAction")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.line = {
		row = arg_1_1.ai_pos.row,
		column = arg_1_1.ai_pos.column
	}
	arg_1_0.stgId = arg_1_1.strategy_id

	if arg_1_1.target_pos then
		arg_1_0.stgTarget = {
			row = arg_1_1.target_pos.row,
			column = arg_1_1.target_pos.column
		}
	end

	arg_1_0.movePath = _.map(arg_1_1.move_path, function(arg_2_0)
		return {
			row = arg_2_0.row,
			column = arg_2_0.column
		}
	end)
	arg_1_0.shipUpdate = _.map(arg_1_1.ship_update, function(arg_3_0)
		return {
			id = arg_3_0.id,
			hpRant = arg_3_0.hp_rant
		}
	end)
	arg_1_0.cellUpdates = {}

	_.each(arg_1_1.map_update, function(arg_4_0)
		if arg_4_0.item_type ~= ChapterConst.AttachNone and arg_4_0.item_type ~= ChapterConst.AttachBorn and arg_4_0.item_type ~= ChapterConst.AttachBorn_Sub and (arg_4_0.item_type ~= ChapterConst.AttachStory or arg_4_0.item_data ~= ChapterConst.StoryTrigger) then
			local var_4_0 = arg_4_0.item_type == ChapterConst.AttachChampion and ChapterChampionPackage.New(arg_4_0) or ChapterCell.New(arg_4_0)

			table.insert(arg_1_0.cellUpdates, var_4_0)
		end

		return
	end)

	arg_1_0.actType = arg_1_1.act_type
	arg_1_0.hp_del = arg_1_1.hp_del

	return
end

function var_0_0.PlayAIAction(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_1:getChapterCell(arg_5_0.line.row, arg_5_0.line.column)

	if var_5_0 and var_5_0.attachment == ChapterConst.AttachLandbase and not table.equal(arg_5_0.stgTarget, {
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
			if not arg_5_0.hp_del or arg_5_0.hp_del <= 0 then
				arg_5_3()
			end

			arg_5_2.viewComponent.grid:PlayAttachmentEffect(var_5_0.row, var_5_0.column, "huoqiubaozha", Vector2.zero)
			arg_5_3()
		elseif pg.land_based_template[var_5_0.attachmentId].type == ChapterConst.LBDock then
			arg_5_3()
		elseif pg.land_based_template[var_5_0.attachmentId].type == ChapterConst.LBAntiAir then
			arg_5_2.viewComponent:doPlayAnim("AntiAirFire", function(arg_7_0)
				setActive(arg_7_0, false)
				arg_5_2.viewComponent.grid:PlayAttachmentEffect(arg_5_0.stgTarget.row, arg_5_0.stgTarget.column, "huoqiubaozha", Vector2.zero, arg_5_3)

				return
			end)
		else
			assert(false)
		end

		return
	end

	if arg_5_0.stgId > 0 then
		if arg_5_0.stgId == ChapterConst.StrategySonarDetect then
			local var_5_1 = {}

			_.each(arg_5_0.cellUpdates, function(arg_8_0)
				if isa(arg_8_0, ChapterChampionPackage) then
					table.insert(var_5_1, arg_8_0)
				end

				return
			end)
			arg_5_2.viewComponent.grid:PlaySonarDetectAnim({}, arg_5_3)
		else
			assert(false)
		end

		return
	end

	local var_5_2 = arg_5_1:getChampion(arg_5_0.line.row, arg_5_0.line.column)
	local var_5_3 = arg_5_1:getChampionIndex(arg_5_0.line.row, arg_5_0.line.column)
	local var_5_4

	if not arg_5_0.movePath[#arg_5_0.movePath] then
		var_5_4 = arg_5_0.line
	end

	if arg_5_1:getChampionIndex(arg_5_0.line.row, arg_5_0.line.column) then
		seriesAsync({
			function(arg_9_0)
				if #arg_5_0.movePath > 0 then
					arg_5_2.viewComponent.grid:moveChampion(var_5_3, arg_5_0.movePath, Clone(arg_5_0.movePath), arg_9_0)
				else
					arg_9_0()
				end

				return
			end,
			function(arg_10_0)
				if #arg_5_0.shipUpdate > 0 then
					arg_5_2.viewComponent:doPlayEnemyAnim(var_5_2, "SubSairenTorpedoUI", arg_10_0)
				else
					arg_10_0()
				end

				return
			end,
			function(arg_11_0)
				local var_11_0 = false

				if arg_5_0.actType == ChapterConst.ActType_SubmarineHunting and #arg_5_0.cellUpdates > 0 then
					_.each(arg_5_0.cellUpdates, function(arg_12_0)
						if var_5_4.row == arg_12_0.row and var_5_4.column == arg_12_0.column and isa(arg_12_0, ChapterChampionPackage) then
							arg_5_0:TryPlayChampionSubAnim(arg_5_2, arg_12_0, var_5_2, arg_11_0)

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

function var_0_0.TryPlayChampionSubAnim(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	if arg_14_2.flag == ChapterConst.CellFlagDiving or arg_14_3.flag == ChapterConst.CellFlagDiving then
		if arg_14_2.flag ~= ChapterConst.CellFlagActive then
			if arg_14_3.flag == ChapterConst.CellFlagActive then
				var_14_0(arg_14_1.viewComponent.grid, arg_14_3, arg_14_2.flag == ChapterConst.CellFlagDiving, arg_14_4)

				return
			end

			arg_14_4()

			return
		end
	end
end

function var_0_0.applyTo(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_1:getChapterCell(arg_15_0.line.row, arg_15_0.line.column)

	if var_15_0 and var_15_0.attachment == ChapterConst.AttachLandbase and not table.equal(arg_15_0.stgTarget, {
		row = 9999,
		column = 9999
	}) then
		if pg.land_based_template[var_15_0.attachmentId].type == ChapterConst.LBCoastalGun then
			return arg_15_0:applyToCoastalGun(arg_15_1, var_15_0, arg_15_2)
		elseif pg.land_based_template[var_15_0.attachmentId].type == ChapterConst.LBHarbor then
			return arg_15_0:applyToHarbor(arg_15_1, var_15_0, arg_15_2)
		elseif pg.land_based_template[var_15_0.attachmentId].type == ChapterConst.LBDock then
			return arg_15_0:applyToDock(arg_15_1, var_15_0, arg_15_2)
		elseif pg.land_based_template[var_15_0.attachmentId].type == ChapterConst.LBAntiAir then
			return arg_15_0:applyToAntiAir(arg_15_1, var_15_0, arg_15_2)
		else
			return false, "Trouble with Attach LandBased"
		end
	end

	if arg_15_0.stgId > 0 then
		return arg_15_0:applyToStrategy(arg_15_1, arg_15_0.stgId, arg_15_2)
	end

	local var_15_1 = arg_15_1:getChampion(arg_15_0.line.row, arg_15_0.line.column)

	if var_15_1 then
		return arg_15_0:applyToChampion(arg_15_1, var_15_1, arg_15_2)
	end

	return false, "can not find any object at: [" .. arg_15_0.line.row .. ", " .. arg_15_0.line.column .. "]"
end

function var_0_0.applyToChampion(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if arg_16_2.flag == ChapterConst.CellFlagDisabled then
		return false, "can not apply ai to dead champion at: [" .. arg_16_0.line.row .. ", " .. arg_16_0.line.column .. "]"
	end

	local var_16_0 = 0
	local var_16_1 = 0
	local var_16_2 = arg_16_0.line

	if arg_16_0.stgId > 0 and not pg.strategy_data_template[arg_16_0.stgId] then
		return false, "can not find strategy: " .. arg_16_0.stgId
	end

	if #arg_16_0.movePath > 0 then
		var_16_2 = arg_16_0.movePath[#arg_16_0.movePath]

		if _.any(arg_16_0.movePath, function(arg_17_0)
			local var_17_0 = arg_16_1:getChapterCell(arg_17_0.row, arg_17_0.column)

			return not var_17_0 or not var_17_0:IsWalkable()
		end) then
			return false, "invalide move path"
		end
	end

	if #arg_16_0.shipUpdate > 0 and not arg_16_1:getFleet(FleetType.Normal, var_16_2.row, var_16_2.column) then
		return false, "can not find fleet at: [" .. arg_16_0.line.row .. ", " .. arg_16_0.line.column .. "]"
	end

	if not arg_16_3 then
		if #arg_16_0.movePath > 0 then
			arg_16_2.row = var_16_2.row
			arg_16_2.column = var_16_2.column
			var_16_0 = bit.bor(var_16_0, ChapterConst.DirtyChampionPosition)
		end

		if arg_16_1:existFleet(FleetType.Submarine, arg_16_2.row, arg_16_2.column) then
			var_16_0 = bit.bor(var_16_0, ChapterConst.DirtyFleet)
		end

		if arg_16_0.actType == ChapterConst.ActType_SubmarineHunting then
			local var_16_3 = arg_16_1:getChapterCell(var_16_2.row, var_16_2.column)

			if var_16_3 and var_16_3.attachment == ChapterConst.AttachBarrier then
				var_16_3.flag = ChapterConst.CellFlagDisabled

				arg_16_1:mergeChapterCell(var_16_3)

				var_16_0 = bit.bor(var_16_0, ChapterConst.DirtyAttachment)
			end
		end

		if #arg_16_0.shipUpdate > 0 then
			_.each(arg_16_0.shipUpdate, function(arg_18_0)
				arg_16_1:updateFleetShipHp(arg_18_0.id, arg_18_0.hpRant)

				return
			end)

			var_16_0 = bit.bor(var_16_0, ChapterConst.DirtyFleet)
		end

		if #arg_16_0.cellUpdates > 0 then
			_.each(arg_16_0.cellUpdates, function(arg_19_0)
				if isa(arg_19_0, ChapterChampionPackage) then
					if arg_16_1:mergeChampion(arg_19_0) then
						local var_19_0 = ChapterConst.DirtyChampionPosition or ChapterConst.DirtyChampion

						var_16_0 = bit.bor(var_16_0, var_19_0)

						if false then
							arg_16_1:mergeChapterCell(arg_19_0)

							var_16_0 = bit.bor(var_16_0, ChapterConst.DirtyAttachment)
						end

						return
					end
				end
			end)

			var_16_1 = bit.bor(var_16_1, ChapterConst.DirtyAutoAction)
		end
	end

	return true, var_16_0, var_16_1
end

function var_0_0.applyToStrategy(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if not pg.strategy_data_template[arg_20_2] then
		return false, "can not find strategy: " .. arg_20_2
	end

	local var_20_0 = 0

	if not arg_20_3 and arg_20_0.stgId == ChapterConst.StrategySonarDetect then
		_.each(arg_20_0.cellUpdates, function(arg_21_0)
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

function var_0_0.applyToCoastalGun(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	if arg_22_2.flag == ChapterConst.CellFlagDisabled then
		return false, "can not apply ai to dead coastalgun at: [" .. arg_22_0.line.row .. ", " .. arg_22_0.line.column .. "]"
	end

	local var_22_0 = 0
	local var_22_1 = 0
	local var_22_2 = arg_22_1:getFleet(FleetType.Normal, arg_22_0.stgTarget.row, arg_22_0.stgTarget.column)

	if not var_22_2 then
		return false, "can not find fleet at: [" .. arg_22_0.stgTarget.row .. ", " .. arg_22_0.stgTarget.column .. "]"
	end

	if not arg_22_3 then
		var_22_2:increaseSlowSpeedFactor()

		var_22_0 = bit.bor(var_22_0, ChapterConst.DirtyFleet)

		_.each(arg_22_0.cellUpdates, function(arg_23_0)
			if isa(arg_23_0, ChapterChampionPackage) then
				arg_22_1:mergeChampion(arg_23_0)

				var_22_0 = bit.bor(var_22_0, ChapterConst.DirtyChampion)
			else
				arg_22_1:mergeChapterCell(arg_23_0)

				var_22_0 = bit.bor(var_22_0, ChapterConst.DirtyAttachment)
			end

			return
		end)

		if #arg_22_0.cellUpdates > 0 then
			var_22_1 = bit.bor(var_22_1, ChapterConst.DirtyAutoAction)
		end
	end

	return true, var_22_0, var_22_1
end

function var_0_0.applyToHarbor(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	if arg_24_2.flag == ChapterConst.CellFlagDisabled then
		return false, "can not apply ai to dead Harbor at: [" .. arg_24_0.line.row .. ", " .. arg_24_0.line.column .. "]"
	end

	local var_24_0 = 0
	local var_24_1 = 0
	local var_24_2 = arg_24_1:getChampion(arg_24_0.stgTarget.row, arg_24_0.stgTarget.column)

	if not var_24_2 then
		return false, "can not find champion at: [" .. arg_24_0.stgTarget.row .. ", " .. arg_24_0.stgTarget.column .. "]"
	end

	if not arg_24_3 then
		arg_24_1.BaseHP = math.max(arg_24_1.BaseHP - arg_24_0.hp_del, 0)

		arg_24_1:RemoveChampion(var_24_2)

		var_24_0 = bit.bor(var_24_0, ChapterConst.DirtyBase, ChapterConst.DirtyChampion)
		var_24_1 = bit.bor(var_24_1, ChapterConst.DirtyAutoAction)

		if #arg_24_0.cellUpdates > 0 then
			_.each(arg_24_0.cellUpdates, function(arg_25_0)
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

function var_0_0.applyToDock(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	if arg_26_2.flag == ChapterConst.CellFlagDisabled then
		return false, "can not apply ai to dead Dock at: [" .. arg_26_0.line.row .. ", " .. arg_26_0.line.column .. "]"
	end

	local var_26_0 = 0

	if not arg_26_1:getFleet(FleetType.Normal, arg_26_0.stgTarget.row, arg_26_0.stgTarget.column) then
		return false, "can not find fleet at: [" .. arg_26_0.stgTarget.row .. ", " .. arg_26_0.stgTarget.column .. "]"
	end

	if not arg_26_3 then
		_.each(arg_26_0.cellUpdates, function(arg_27_0)
			if isa(arg_27_0, ChapterCell) then
				arg_26_1:mergeChapterCell(arg_27_0)

				var_26_0 = bit.bor(var_26_0, ChapterConst.DirtyAttachment)
			end

			return
		end)
		_.each(arg_26_0.shipUpdate, function(arg_28_0)
			arg_26_1:updateFleetShipHp(arg_28_0.id, arg_28_0.hpRant)

			return
		end)

		var_26_0 = bit.bor(var_26_0, ChapterConst.DirtyFleet)
	end

	return true, var_26_0
end

function var_0_0.applyToAntiAir(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	if arg_29_2.flag == ChapterConst.CellFlagDisabled then
		return false, "can not apply ai to dead antiairGun at: [" .. arg_29_0.line.row .. ", " .. arg_29_0.line.column .. "]"
	end

	local var_29_0 = 0
	local var_29_1 = arg_29_1:getChampion(arg_29_0.stgTarget.row, arg_29_0.stgTarget.column)

	if not var_29_1 then
		return false, "can not find champion at: [" .. arg_29_0.stgTarget.row .. ", " .. arg_29_0.stgTarget.column .. "]"
	end

	if not arg_29_3 then
		arg_29_1:RemoveChampion(var_29_1)

		var_29_0 = bit.bor(var_29_0, ChapterConst.DirtyChampion, ChapterConst.DirtyAttachment)

		_.each(arg_29_0.cellUpdates, function(arg_30_0)
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

return var_0_0
