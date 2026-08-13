class = var_0_10000

local var_0_0 = "WorldMapOpCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	assert = var_1_10003

	local var_1_1 = var_1_0.class

	WorldMapOp = var_1_10006

	var_1_10003(var_1_1 == var_1_10006, "command parameter should be type of WorldMapOp")

	pg = var_1_10003

	local var_1_2 = var_1_10003.ConnectionMgr.GetInstance()
	local var_1_3 = var_3.Send
	local var_1_4 = 33103
	local var_1_5 = {
		act = var_1_0.op
	}
	local var_1_6

	if not var_1_0.id then
		var_1_6 = 0
	end

	var_1_5.group_id = var_1_6
	var_1_5.act_arg_1 = var_1_0.arg1
	var_1_5.act_arg_2 = var_1_0.arg2

	local var_1_7

	if not var_1_0.locations then
		var_1_7 = {}
	end

	var_1_5.pos_list = var_1_7

	var_1_3(var_1_2, var_1_4, var_1_5, 33104, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			WorldProxy = var_2_10003

			local var_2_0 = var_1(var_2_10003)

			nowWorld = var_2_10002
			var_2_10004 = var_2_10002()
			var_2_10002 = var_2_10002.GetActiveMap(var_2_10004)
			assert = var_2_10003

			var_2_10003(var_2_10002, "active map not exist.")

			local var_2_1 = var_1_0

			PlayerConst = var_2_10004
			var_2_1.drops = var_2_10004.addTranDrop(arg_2_0.drop_list)
			var_1_0.updateAttachmentCells = var_2_0:NetBuildMapAttachmentCells(arg_2_0.pos_list)
			var_1_0.fleetAttachUpdates = var_2_0:NetBuildFleetAttachUpdate(arg_2_0.pos_list)
			var_1_0.terrainUpdates = var_2_0:NetBulidTerrainUpdate(arg_2_0.land_list)
			var_1_0.fleetUpdates = var_2_0:NetBuildFleetUpdate(arg_2_0.group_update)
			var_1_0.shipUpdates = var_2_0:NetBuildShipUpdate(arg_2_0.ship_update)

			local var_2_2 = var_1_0

			var_2_2.salvageUpdates = var_2_0:NetBuildSalvageUpdate(arg_2_0.cmd_collection_list)
			WorldConst = var_2_2

			var_2_2.DebugPrintAttachmentCell("Op is " .. var_1_0.op, var_1_0.updateAttachmentCells)
			var_2_0:NetUpdateAchievements(arg_2_0.target_list)

			local var_2_3 = var_1_0.op

			WorldConst = var_2_10004

			if var_2_3 == var_2_10004.OpReqMoveFleet then
				local var_2_4 = arg_1_0

				var_3.BuildFleetMove(var_2_4, arg_2_0.move_path, var_1_0)

				goto label_2_0
			end

			local var_2_5 = var_1_0.op

			WorldConst = var_2_10004

			local var_2_7

			if var_2_5 == var_2_10004.OpReqRetreat then
				local var_2_6 = var_1_0

				var_2_7 = arg_1_0
				var_2_6.childOps = var_2_10004.BuildAIAction(var_2_7, arg_2_0)

				goto label_2_0
			end

			local var_2_8 = var_1_0.op

			WorldConst = var_2_10004

			if var_2_8 == var_2_10004.OpReqEvent then
				var_2_10004 = var_1_0.effect.effect_type

				local var_2_9 = var_3.effect_paramater

				WorldMapAttachment = var_2_7

				if var_2_10004 ~= var_2_7.EffectEventTeleport then
					WorldMapAttachment = var_6

					if var_2_10004 == var_6.EffectEventTeleportBack then
						local var_2_10 = arg_1_0

						var_6.BuildTransfer(var_2_10, arg_2_0, var_1_0)

						goto label_2_0
					end

					WorldMapAttachment = var_6

					local var_2_11

					if var_2_10004 == var_6.EffectEventProgress then
						var_2_11 = var_1_0

						local var_2_12 = arg_1_0

						var_2_11.childOps = var_7.BuildProgressAction(var_2_12, var_2_9[1])

						goto label_2_0
					end

					WorldMapAttachment = var_2_11

					if var_2_10004 ~= var_2_11.EffectEventBlink1 then
						WorldMapAttachment = var_6

						if var_2_10004 == var_6.EffectEventBlink2 then
							local var_2_13 = var_1_0
							local var_2_14 = arg_1_0

							var_2_13.childOps = var_7.BuildBlinkAction(var_2_14, var_1_0.attachment, var_1_0.updateAttachmentCells)

							goto label_2_0

							local var_2_15 = var_1_0.op

							WorldConst = var_2_10004

							if var_2_15 == var_2_10004.OpReqTransport then
								local var_2_16 = arg_1_0

								var_3.BuildTransfer(var_2_16, arg_2_0, var_1_0)
							else
								local var_2_17 = var_1_0.op

								WorldConst = var_2_10004

								if var_2_17 == var_2_10004.OpReqJumpOut then
									local var_2_18 = arg_1_0

									var_3.BuildTransfer(var_2_18, arg_2_0, var_1_0)
								else
									local var_2_19 = var_1_0.op

									WorldConst = var_2_10004

									if var_2_19 == var_2_10004.OpReqRound then
										local var_2_20 = var_1_0
										local var_2_21 = arg_1_0

										var_2_20.childOps = var_2_10004.BuildAIAction(var_2_21, arg_2_0)
									else
										local var_2_22 = var_1_0.op

										WorldConst = var_2_10004

										if var_2_22 == var_2_10004.OpReqBox then
											-- block empty
										end
									end
								end
							end

							goto label_2_0

							if arg_2_0.result == 2 then
								pg = var_1

								local var_2_23 = var_1.TipsMgr.GetInstance()
								local var_2_24 = var_1.ShowTips

								i18n = var_2_10004

								var_2_24(var_2_23, var_2_10004("world_stamina_not_enough"))
							else
								local var_2_25 = var_1_0.op

								WorldConst = var_2_10002

								if var_2_25 == var_2_10002.OpReqRetreat then
									pg = var_2_25

									local var_2_26 = var_2_25.TipsMgr.GetInstance()

									var_2_25 = var_2_25.ShowTips
									i18n = var_2_10004

									var_2_25(var_2_26, var_2_10004("no_way_to_escape"))
								else
									pg = var_2_25

									local var_2_27 = var_2_25.TipsMgr.GetInstance()
									local var_2_28 = var_1.ShowTips

									errorTip = var_2_10004

									var_2_28(var_2_27, var_2_10004("world_map_op_error_", arg_2_0.result))
								end
							end

							local var_2_29 = var_1_0.op

							WorldConst = var_2_10002

							if var_2_29 == var_2_10002.OpReqEvent then
								WorldConst = var_2_29

								local var_2_30 = var_2_29.Print
								local var_2_31 = var_1_0.attachment

								var_2_30(var_3.DebugPrint(var_2_31))
							end
						end

						::label_2_0::

						local var_2_32 = arg_1_0
						local var_2_33 = var_1.sendNotification

						GAME = var_2_10004

						var_2_33(var_2_32, var_2_10004.WORLD_MAP_OP_DONE, {
							result = arg_2_0.result,
							mapOp = var_1_0
						})

						return
					end
				end
			end
		end
	end)

	return
end

function var_0_1.BuildAIAction(arg_3_0, arg_3_1)
	local var_3_0 = {}

	getProxy = var_1_10003
	WorldProxy = var_1_10005

	local var_3_1 = var_1_10003(var_1_10005)

	ipairs = var_1_10004

	for iter_3_0, iter_3_1 in var_1_10004(arg_3_1.ai_act_list) do
		local var_3_2 = {}
		local var_3_3 = iter_3_1.type

		WorldMapAttachment = var_1_10011

		if var_3_3 == var_1_10011.TypeFleet then
			var_3_2 = arg_3_0:BuildFleetAction(iter_3_1)
		else
			local var_3_4 = iter_3_1.type

			WorldMapAttachment = var_1_10011

			if var_3_4 == var_1_10011.TypeTrap then
				var_3_2 = arg_3_0:BuildTrapAction(iter_3_1)
			else
				var_3_2 = arg_3_0:BuildAttachmentAction(iter_3_1)
			end
		end

		var_3_2[#var_3_2].shipUpdates = var_3_1:NetBuildShipUpdate(iter_3_1.ship_update)

		local var_3_5 = var_3_2[#var_3_2]

		var_3_5.fleetAttachUpdates = var_3_1:NetBuildFleetAttachUpdate(iter_3_1.pos_list)
		table = var_3_5
		var_3_0 = var_3_5.mergeArray(var_3_0, var_3_2)
	end

	return var_3_0
end

function var_0_1.BuildTransfer(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2.entranceId = arg_4_1.enter_map_id
	arg_4_2.destMapId = arg_4_1.id.random_id
	arg_4_2.destGridId = arg_4_1.id.template_id
	arg_4_2.staminaUpdate = {
		arg_4_1.action_power,
		arg_4_1.action_power_extra
	}

	return
end

function var_0_1.BuildFleetMove(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = {}
	local var_5_1 = #arg_5_1
	local var_5_3

	if 0 < var_5_1 then
		nowWorld = var_5_1

		local var_5_2 = var_5_1()

		var_1_10007 = var_5_1.GetActiveMap(var_5_2)
		var_5_3 = var_5_1.GetFleet(var_1_10007)

		local var_5_4 = arg_5_2.updateAttachmentCells

		arg_5_2.updateAttachmentCells = {}
		table = var_1_10007
		var_5_0 = var_1_10007.mergeArray(var_5_0, arg_5_0:BuildFleetMoveAction(arg_5_1, var_5_1, var_5_3.id, var_5_3.row, var_5_3.column, var_5_4, true))
	else
		var_5_1 = arg_5_2.trap
		WorldBuff = var_5_3

		if var_5_1 == var_5_3.TrapVortex then
			WBank = var_5_1

			local var_5_5 = var_5_1

			var_5_1 = var_5_1.Fetch
			WorldMapOp = var_1_10007
			var_5_1 = var_5_1(var_5_5, var_1_10007)
			WorldConst = var_5
			var_5_1.op = var_5.OpActionFleetAnim
			var_5_1.id = arg_5_2.id
			WorldConst = var_5
			var_5_1.anim = var_5.ActionYun
			var_5_1.duration = 2
			table = var_5

			var_5.insert(var_5_0, var_5_1)
		end
	end

	_ = var_5_1
	arg_5_2.path = var_5_1.rest(arg_5_1, 1)
	arg_5_2.childOps = var_5_0

	return
end

function var_0_1.BuildFleetPath(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	nowWorld = var_1_10005

	local var_6_0 = var_1_10005()
	local var_6_1 = var_5.GetActiveMap(var_6_0)
	local var_6_2 = var_5.GetFleet(var_6_1, arg_6_3.id)

	_ = var_6_0

	var_6_0.each(arg_6_1, function(arg_7_0)
		local var_7_0 = arg_7_0.duration
		local var_7_1 = var_6_2

		arg_7_0.duration = var_7_0 * var_2.GetStepDurationRate(var_7_1)

		return
	end)

	local var_6_3 = {}
	local var_6_4 = {}
	local var_6_5 = {}
	local var_6_6 = var_6_2
	local var_6_7 = var_6_2.GetCarries(var_6_6)

	_ = var_1_10011

	local var_6_8 = var_1_10011.map(var_6_7, function(arg_8_0)
		local var_8_0 = var_6_2

		return var_1.BuildCarryPath(var_8_0, arg_8_0, arg_6_2, arg_6_1)
	end)

	_ = var_6_6

	var_6_6.each(arg_6_1, function(arg_9_0)
		WBank = var_2_10001

		local var_9_0 = var_2_10001
		local var_9_1 = var_2_10001.Fetch

		WorldMapOp = var_2_10004

		local var_9_2 = var_9_1(var_9_0, var_2_10004)

		WorldConst = var_2_10002
		var_9_2.op = var_2_10002.OpActionMoveStep
		var_9_2.id = arg_6_3.id
		var_9_2.pos = {
			row = arg_9_0.row,
			column = arg_9_0.column
		}
		var_9_2.updateAttachmentCells = {}
		var_9_2.hiddenCells = {}
		var_9_2.hiddenAttachments = {}

		if #var_6_7 > 0 then
			var_9_2.updateCarryItems = {}
			ipairs = var_2

			for iter_9_0, iter_9_1 in var_2(var_6_7) do
				local var_9_3 = var_6_8[#var_9_2.updateCarryItems + 1]

				WPool = var_8

				local var_9_4 = var_8
				local var_9_5 = var_8.Get

				WorldCarryItem = var_2_10011
				var_2_10011 = var_9_5(var_9_4, var_2_10011)

				var_8.Setup(var_2_10011, iter_9_1.id)

				var_2_10011 = var_8

				var_8.UpdateOffset(var_2_10011, var_9_3[#var_6_3 + 1].row - arg_9_0.row, var_9_3[#var_6_3 + 1].column - arg_9_0.column)

				table = var_9

				var_9.insert(var_9_2.updateCarryItems, var_8)
			end
		end

		local var_9_6 = var_0.theme
		local var_9_7 = var_0
		local var_9_8 = var_3.GetFOVRange(var_9_7, var_6_2, arg_9_0.row, arg_9_0.column)

		for iter_9_2 = arg_9_0.row - var_9_8, arg_9_0.row + var_9_8 do
			for iter_9_3 = arg_9_0.column - var_9_8, arg_9_0.column + var_9_8 do
				local var_9_9 = var_0
				local var_9_10 = var_12.GetCell(var_9_9, iter_9_2, iter_9_3)
				local var_9_11 = iter_9_2 .. "_" .. iter_9_3

				if var_9_10 and not var_9_10.discovered then
					WorldConst = var_14

					if var_14.InFOVRange(arg_9_0.row, arg_9_0.column, iter_9_2, iter_9_3, var_9_8) and not var_6_4[var_9_11] then
						local var_9_12 = var_6_4

						var_9_12[var_9_11] = true
						table = var_9_12

						var_9_12.insert(var_9_2.hiddenCells, var_9_10)

						table = var_14

						var_14.insert(var_6_5, {
							row = var_9_10.row,
							column = var_9_10.column
						})

						_ = var_14

						var_14.each(var_9_10.attachments, function(arg_10_0)
							if arg_10_0:ShouldMarkAsLurk() then
								table = var_1

								var_1.insert(var_9_2.hiddenAttachments, arg_10_0)
							end

							return
						end)

						WorldMapCell = var_14

						local var_9_13 = var_14.GetName(var_9_10.row, var_9_10.column)

						if arg_6_4[var_9_13] then
							_ = var_15

							var_15.each(arg_6_4[var_9_13].attachmentList, function(arg_11_0)
								if arg_11_0:ShouldMarkAsLurk() then
									table = var_1

									var_1.insert(var_9_2.hiddenAttachments, arg_11_0)
								end

								return
							end)

							var_9_2.updateAttachmentCells[var_9_13] = arg_6_4[var_9_13]
							arg_6_4[var_9_13] = nil
						end
					end
				end
			end
		end

		table = var_4

		var_4.insert(var_6_3, var_9_2)

		return
	end)

	arg_6_3.stepOps = var_6_3
	arg_6_3.path = arg_6_1
	arg_6_3.pos = {
		row = arg_6_2.row,
		column = arg_6_2.column
	}
	arg_6_3.locations = var_6_5

	return
end

function var_0_1.BuildFleetAction(arg_12_0, arg_12_1)
	nowWorld = var_1_10002

	local var_12_0 = var_1_10002()
	local var_12_1 = var_2.GetActiveMap(var_12_0)
	local var_12_2 = var_2.FindFleet(var_12_1, arg_12_1.ai_pos.row, arg_12_1.ai_pos.column)

	assert = var_12_0

	var_12_0(var_12_2, "fleet not exist at: " .. arg_12_1.ai_pos.column .. ", " .. arg_12_1.ai_pos.column)

	getProxy = var_12_0
	WorldProxy = var_6

	local var_12_3 = var_12_0(var_6)
	local var_12_4 = var_4.NetBuildMapAttachmentCells(var_12_3, arg_12_1.pos_list)
	local var_12_5
	local var_12_6 = #arg_12_1.move_path

	if 0 < var_12_6 then
		var_12_5 = arg_12_0:BuildFleetMoveAction(arg_12_1.move_path, var_2, var_12_2.id, var_12_2.row, var_12_2.column, var_12_4)
	else
		WBank = var_12_6

		local var_12_7 = var_12_6
		local var_12_8 = var_12_6.Fetch

		WorldMapOp = var_9

		local var_12_9 = var_12_8(var_12_7, var_9)

		WorldConst = var_7
		var_12_9.op = var_7.OpActionUpdate
		var_12_9.updateAttachmentCells = var_12_4
		var_12_5 = {
			var_12_9
		}
	end

	return var_12_5
end

function var_0_1.BuildFleetMoveAction(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5, arg_13_6, arg_13_7)
	local var_13_0 = {}

	if arg_13_7 then
		WorldMapCell = var_1_10009

		local var_13_2

		if not var_1_10009.TerrainNone then
			local var_13_1 = arg_13_2:GetCell(arg_13_4, arg_13_5)

			var_13_2 = var_9.GetTerrain(var_13_1)
		end

		local var_13_3 = arg_13_2:GetCell(arg_13_4, arg_13_5).terrainStrong
		local var_13_4 = {
			row = arg_13_4,
			column = arg_13_5
		}
		local var_13_5 = 0
		local var_13_6 = {}

		ipairs = var_14

		for iter_13_0, iter_13_1 in var_14(arg_13_1) do
			local var_13_7 = arg_13_2
			local var_13_8 = arg_13_2.GetCell(var_13_7, iter_13_1.row, iter_13_1.column)
			local var_13_9 = var_19.GetTerrain(var_13_8)

			table = var_13_7

			local var_13_10 = var_13_7.insert
			local var_13_11 = var_13_6
			local var_13_12 = {
				row = iter_13_1.row,
				column = iter_13_1.column,
				terrain = var_13_2
			}

			WorldConst = var_25
			var_13_12.duration = var_25.GetTerrainMoveStepDuration(var_13_2)

			var_13_10(var_13_11, var_13_12)

			local var_13_13
			local var_13_14
			local var_13_15

			WorldMapCell = var_13_12

			local var_13_16

			if var_13_2 == var_13_12.TerrainWind then
				var_13_16 = var_13_5 + var_13_3

				if #var_13_6 < var_13_16 then
					var_13_13 = true

					goto label_13_0
				end
			end

			if var_13_2 ~= var_13_9 then
				var_13_14 = true
			else
				WorldMapCell = var_13_16

				if var_13_9 == var_13_16.TerrainWind then
					var_13_15 = true
				end
			end

			::label_13_0::

			if iter_13_0 == #arg_13_1 or var_13_14 then
				var_13_5 = 0
				WBank = var_24

				local var_13_17 = var_24
				local var_13_18 = var_24.Fetch

				WorldMapOp = var_27

				local var_13_19 = var_13_18(var_13_17, var_27)

				WorldConst = var_25
				var_13_19.op = var_25.OpActionFleetMove
				var_13_19.id = arg_13_3
				var_13_19.arg1 = iter_13_1.row
				var_13_19.arg2 = iter_13_1.column

				arg_13_0:BuildFleetPath(var_13_6, var_13_4, var_13_19, arg_13_6)

				if iter_13_0 == #arg_13_1 then
					var_13_19.updateAttachmentCells = arg_13_6
				end

				table = var_25

				var_25.insert(var_13_0, var_13_19)

				var_13_6, var_13_4 = {}, {
					row = iter_13_1.row,
					column = iter_13_1.column
				}
			elseif var_13_15 then
				var_13_5 = var_13_5 + var_13_3
			end

			if var_13_13 then
				-- block empty
			else
				var_13_2 = var_13_9
				var_13_3 = var_19.terrainStrong
			end
		end

		return var_13_0
	end
end

function var_0_1.BuildAttachmentAction(arg_14_0, arg_14_1)
	nowWorld = var_1_10002

	local var_14_0 = var_1_10002()
	local var_14_1 = var_2.GetActiveMap(var_14_0)
	local var_14_2 = arg_14_1.ai_pos.row
	local var_14_3 = arg_14_1.ai_pos.column
	local var_14_4 = var_14_1
	local var_14_5 = var_14_1.GetCell(var_14_4, var_14_2, var_14_3)
	local var_14_6 = var_5.FindAliveAttachment

	WorldMapAttachment = var_9

	local var_14_7 = var_14_6(var_14_5, var_9.TypeEnemyAI)

	assert = var_14_4

	var_14_4(var_14_7, "attachment not exist at: " .. var_14_2 .. ", " .. var_14_3)

	local var_14_8 = {}

	WBank = var_14_5

	local var_14_9 = var_14_5
	local var_14_10 = var_14_5.Fetch

	WorldMapOp = var_11

	local var_14_11 = var_14_10(var_14_9, var_11)

	WorldConst = var_9
	var_14_11.op = var_9.OpActionCameraMove
	var_14_11.attachment = var_14_7
	table = var_9

	var_9.insert(var_14_8, var_14_11)

	WBank = var_9

	local var_14_12 = var_9
	local var_14_13 = var_9.Fetch

	WorldMapOp = var_12

	local var_14_14 = var_14_13(var_14_12, var_12)

	getProxy = var_14_9
	WorldProxy = var_12

	local var_14_15 = var_14_9(var_12)

	var_14_14.updateAttachmentCells = var_10.NetBuildMapAttachmentCells(var_14_15, arg_14_1.pos_list)

	if #arg_14_1.move_path > 0 then
		WorldConst = var_10
		var_14_14.op = var_10.OpActionAttachmentMove
		var_14_14.attachment = var_14_7

		arg_14_0:BuildAttachmentActionPath(arg_14_1.move_path, var_14_14)
	else
		WorldConst = var_10
		var_14_14.op = var_10.OpActionUpdate
	end

	table = var_10

	var_10.insert(var_14_8, var_14_14)

	return var_14_8
end

function var_0_1.BuildAttachmentActionPath(arg_15_0, arg_15_1, arg_15_2)
	nowWorld = var_1_10003

	local var_15_0 = var_1_10003()
	local var_15_1 = var_3.GetActiveMap(var_15_0)

	assert = var_1_10004

	var_1_10004(var_15_1, "active map not exist.")

	underscore = var_1_10004
	arg_15_2.path = var_1_10004.map(arg_15_1, function(arg_16_0)
		local var_16_0 = {
			row = arg_16_0.row,
			column = arg_16_0.column
		}

		WorldConst = var_2

		local var_16_1 = var_2.GetTerrainMoveStepDuration

		WorldMapCell = var_2_10004
		var_16_0.duration = var_16_1(var_2_10004.TerrainNone)

		return var_16_0
	end)
	arg_15_2.pos = {
		row = arg_15_2.attachment.row,
		column = arg_15_2.attachment.column
	}

	return
end

function var_0_1.BuildTrapAction(arg_17_0, arg_17_1)
	nowWorld = var_1_10002

	local var_17_0 = var_1_10002()
	local var_17_1 = var_2.GetActiveMap(var_17_0)
	local var_17_2 = arg_17_1.ai_pos.row
	local var_17_3 = arg_17_1.ai_pos.column
	local var_17_4 = var_17_1
	local var_17_5 = var_17_1.GetCell(var_17_4, var_17_2, var_17_3)
	local var_17_6 = var_5.FindAliveAttachment

	WorldMapAttachment = var_9

	local var_17_7 = var_17_6(var_17_5, var_9.TypeTrap)

	assert = var_17_4

	var_17_4(var_17_7, "attachment not exist at: " .. var_17_2 .. ", " .. var_17_3)

	local var_17_8 = {}

	WBank = var_17_5

	local var_17_9 = var_17_5
	local var_17_10 = var_17_5.Fetch

	WorldMapOp = var_11

	local var_17_11 = var_17_10(var_17_9, var_11)

	WorldConst = var_9
	var_17_11.op = var_9.OpActionCameraMove
	var_17_11.attachment = var_17_7
	table = var_9

	var_9.insert(var_17_8, var_17_11)

	WBank = var_9

	local var_17_12 = var_9
	local var_17_13 = var_9.Fetch

	WorldMapOp = var_12

	local var_17_14 = var_17_13(var_17_12, var_12)

	WorldConst = var_17_9
	var_17_14.op = var_17_9.OpActionTrapGravityAnim
	var_17_14.attachment = var_17_7
	table = var_10

	var_10.insert(var_17_8, var_17_14)

	return var_17_8
end

function var_0_1.BuildBlinkAction(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = {}
	local var_18_1 = arg_18_1:GetSpEventType()

	WorldMapCell = var_1_10005

	local var_18_2 = arg_18_2[var_1_10005.GetName(arg_18_1.row, arg_18_1.column)]
	local var_18_3

	pairs = var_7

	for iter_18_0, iter_18_1 in var_7(arg_18_2) do
		_ = var_1_10012

		if var_1_10012.any(iter_18_1.attachmentList, function(arg_19_0)
			return arg_19_0.type == arg_18_1.type and arg_19_0.id == arg_18_1.id
		end) then
			var_18_3 = iter_18_1

			break
		end
	end

	WorldMapAttachment = var_7

	local var_18_5

	if var_18_1 == var_7.SpEventHaibao then
		WBank = var_18_5

		local var_18_4 = var_18_5

		var_18_5 = var_18_5.Fetch
		WorldMapOp = iter_18_0
		var_18_5 = var_18_5(var_18_4, iter_18_0)
		WorldConst = var_8
		var_18_5.op = var_8.OpActionAttachmentAnim
		var_18_5.attachment = arg_18_1
		WorldConst = var_8
		var_18_5.anim = var_8.ActionVanish

		local var_18_6 = {}

		WorldMapCell = var_18_4
		var_18_6[var_18_4.GetName(var_18_2.pos.row, var_18_2.pos.column)] = var_18_2
		WorldMapCell = var_9
		var_18_6[var_9.GetName(var_18_3.pos.row, var_18_3.pos.column)] = var_18_3
		var_18_5.updateAttachmentCells = var_18_6
		WorldMapCell = var_18_6
		arg_18_2[var_18_6.GetName(var_18_2.pos.row, var_18_2.pos.column)] = nil
		WorldMapCell = var_8
		arg_18_2[var_8.GetName(var_18_3.pos.row, var_18_3.pos.column)] = nil
		table = var_8

		var_8.insert(var_18_0, var_18_5)

		WBank = var_8

		local var_18_7 = var_8
		local var_18_8 = var_8.Fetch

		WorldMapOp = var_11

		local var_18_9 = var_18_8(var_18_7, var_11)

		WorldConst = var_9
		var_18_9.op = var_9.OpActionAttachmentAnim
		_ = var_9
		var_18_9.attachment = var_9.detect(var_18_3.attachmentList, function(arg_20_0)
			return arg_20_0.type == arg_18_1.type and arg_20_0.id == arg_18_1.id
		end)
		WorldConst = var_9
		var_18_9.anim = var_9.ActionAppear
		table = var_9

		var_9.insert(var_18_0, var_18_9)
	else
		WorldMapAttachment = var_18_5

		if var_18_1 == var_18_5.SpEventFufen then
			nowWorld = var_7

			local var_18_10 = var_7()
			local var_18_11 = var_7.GetActiveMap(var_18_10)
			local var_18_12, var_18_13 = var_7.FindAIPath(var_18_11, {
				row = arg_18_1.row,
				column = arg_18_1.column
			}, {
				row = var_18_3.pos.row,
				column = var_18_3.pos.column
			})

			PathFinding = var_18_11

			if var_18_12 < var_18_11.PrioObstacle then
				WBank = var_10

				local var_18_14 = var_10
				local var_18_15 = var_10.Fetch

				WorldMapOp = var_13

				local var_18_16 = var_18_15(var_18_14, var_13)

				WorldConst = var_11
				var_18_16.op = var_11.OpActionAttachmentMove
				var_18_16.attachment = arg_18_1

				arg_18_0:BuildAttachmentActionPath(var_18_13, var_18_16)

				table = var_11

				var_11.insert(var_18_0, var_18_16)
			end
		end
	end

	return var_18_0
end

function var_0_1.BuildProgressAction(arg_21_0, arg_21_1)
	local var_21_0 = {}

	nowWorld = var_1_10003

	local var_21_1 = var_1_10003()
	local var_21_2 = var_3.GetRealm(var_21_1)

	if var_3:GetProgress() < arg_21_1 then
		WorldConst = var_5

		local var_21_3 = var_5.FindStageTemplates(arg_21_1)

		_ = var_21_1

		var_21_1.each(var_21_3, function(arg_22_0)
			if arg_22_0 and #arg_22_0.stage_effect[var_21_2] > 0 then
				_ = var_1

				var_1.each(arg_22_0.stage_effect[var_21_2], function(arg_23_0)
					pg = var_3_10001

					local var_23_0 = var_3_10001.world_effect_data[arg_23_0]

					assert = var_3_10002

					var_3_10002(var_23_0, "world_effect_data not exist: " .. arg_23_0)

					WBank = var_3_10002

					local var_23_1 = var_3_10002
					local var_23_2 = var_3_10002.Fetch

					WorldMapOp = var_5

					local var_23_3 = var_23_2(var_23_1, var_5)

					WorldConst = var_3_10003
					var_23_3.op = var_3_10003.OpActionEventEffect
					var_23_3.effect = var_23_0
					table = var_3

					var_3.insert(var_21_0, var_23_3)

					return
				end)
			end

			return
		end)
	end

	return var_21_0
end

return var_0_1
