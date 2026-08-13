class = var_0_10000

local var_0_0 = "WorldMapOp"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...BaseEntity"))

var_0_1.Fields = {
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

function var_0_1.Apply(arg_1_0)
	assert = var_1_10001

	var_1_10001(not arg_1_0.applied, "current op has been applied.")

	arg_1_0.applied = true
	getProxy = var_1
	WorldProxy = var_3

	local var_1_0 = var_1(var_3)

	nowWorld = var_1_10002

	local var_1_1 = var_1_10002()
	local var_1_2 = var_2.GetActiveMap(var_1_1)
	local var_1_3 = arg_1_0.op

	WorldConst = var_1_1

	if var_1_3 == var_1_1.OpReqMoveFleet then
		var_1_10006 = var_2

		var_2.IncRound(var_1_10006)

		goto label_1_0
	end

	local var_1_4 = arg_1_0.op

	WorldConst = var_5

	if var_1_4 == var_5.OpReqRound then
		var_1_10006 = var_2

		var_2.IncRound(var_1_10006)

		goto label_1_0
	end

	local var_1_5 = arg_1_0.op

	WorldConst = var_5

	if var_1_5 == var_5.OpReqEvent then
		var_1_10006 = var_1_2

		local var_1_6 = var_1_2.GetFleet(var_1_10006, arg_1_0.id)

		var_1_10006 = arg_1_0.effect.effect_type

		local var_1_7 = var_5.effect_paramater

		WorldMapAttachment = var_1_10008

		if var_1_10006 ~= var_1_10008.EffectEventTeleport then
			WorldMapAttachment = var_8

			if var_1_10006 == var_8.EffectEventTeleportBack then
				assert = var_8

				local var_1_8

				if arg_1_0.destMapId then
					var_1_8 = arg_1_0.destMapId > 0
				end

				var_8(var_1_8)
				var_1_0:NetUpdateActiveMap(arg_1_0.entranceId, arg_1_0.destMapId, arg_1_0.destGridId)
			else
				WorldMapAttachment = var_8

				local var_1_9

				if var_1_10006 == var_8.EffectEventShipBuff then
					var_1_9 = var_1_7[1]
					_ = var_1_10009

					var_1_10009.each(var_1_6:GetShips(true), function(arg_2_0)
						arg_2_0:AddBuff(var_1_9, 1)

						return
					end)
				else
					WorldMapAttachment = var_1_9

					if var_1_10006 == var_1_9.EffectEventAchieveCarry then
						_ = var_8

						var_8.each(var_1_7, function(arg_3_0)
							WorldCarryItem = var_2_10001

							local var_3_0 = var_2_10001.New()

							var_1.Setup(var_3_0, arg_3_0)

							local var_3_1 = var_1_6

							var_2.AddCarry(var_3_1, var_1)

							return
						end)
					else
						WorldMapAttachment = var_8

						local var_1_10

						if var_1_10006 == var_8.EffectEventConsumeCarry then
							if not var_1_7[1] then
								var_1_10 = {}
							end

							_ = var_1_10009

							var_1_10009.each(var_1_10, function(arg_4_0)
								local var_4_0 = var_1_6

								var_1.RemoveCarry(var_4_0, arg_4_0)

								return
							end)
						else
							WorldMapAttachment = var_1_10

							if var_1_10006 == var_1_10.EffectEventConsumeItem then
								local var_1_11 = var_2:GetInventoryProxy()

								var_8.RemoveItem(var_1_11, var_1_7[1], var_1_7[2])
							else
								WorldMapAttachment = var_8

								if var_1_10006 == var_8.EffectEventDropTreasure then
									var_2.treasureCount = var_2.treasureCount + 1
								else
									WorldMapAttachment = var_8

									if var_1_10006 == var_8.EffectEventFOV then
										var_1_2:EventEffectOpenFOV(var_5)
									else
										WorldMapAttachment = var_8

										local var_1_12

										if var_1_10006 == var_8.EffectEventProgress then
											math = var_1_12
											var_1_12 = var_1_12.max(var_2:GetProgress(), var_1_7[1])

											var_2:UpdateProgress(var_1_12)
										else
											WorldMapAttachment = var_1_12

											local var_1_13

											if var_1_10006 == var_1_12.EffectEventDeleteTask then
												var_1_13 = var_2:GetTaskProxy()
												ipairs = var_1_10009

												for iter_1_0, iter_1_1 in var_1_10009(var_1_7) do
													var_1_10016 = var_1_13

													var_1_13.deleteTask(var_1_10016, iter_1_1)
												end
											else
												WorldMapAttachment = var_1_13

												if var_1_10006 == var_1_13.EffectEventGlobalBuff then
													var_2:AddGlobalBuff(var_1_7[1], var_1_7[2])
												else
													WorldMapAttachment = var_8

													if var_1_10006 == var_8.EffectEventMapClearFlag then
														var_1_2:UpdateClearFlag(var_1_7[1] == 1)
													else
														WorldMapAttachment = var_8

														if var_1_10006 == var_8.EffectEventBrokenClean then
															ipairs = var_8

															for iter_1_2, iter_1_3 in var_8(var_2:GetShips()) do
																if iter_1_3:IsBroken() then
																	local var_1_14 = iter_1_3
																	local var_1_15 = iter_1_3.RemoveBuff

																	WorldConst = var_1_10016

																	var_1_15(var_1_14, var_1_10016.BrokenBuffId)
																end
															end
														else
															WorldMapAttachment = var_8

															if var_1_10006 == var_8.EffectEventCatSalvage then
																-- block empty
															else
																WorldMapAttachment = var_8

																if var_1_10006 == var_8.EffectEventAddWorldBossFreeCount then
																	nowWorld = var_8

																	local var_1_16 = var_8()
																	local var_1_17 = var_8.GetBossProxy(var_1_16)

																	var_8.AddSummonFree(var_1_17, 1)
																end
															end
														end
													end
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end

			if #var_5.sound_effects > 0 then
				pg = var_8

				local var_1_18 = var_8.CriMgr.GetInstance()

				var_8.PlaySoundEffect_V3(var_1_18, "event:" .. var_5.sound_effects)
			end

			if false then
				local var_1_19 = arg_1_0.op

				WorldConst = var_5

				if var_1_19 == var_5.OpReqDiscover then
					_ = var_1_19

					var_1_19.each(arg_1_0.locations, function(arg_5_0)
						local var_5_0 = var_1_2
						local var_5_1 = var_1.GetCell(var_5_0, arg_5_0.row, arg_5_0.column)

						var_1.UpdateDiscovered(var_5_1, true)

						return
					end)

					_ = var_4

					var_4.each(arg_1_0.hiddenAttachments, function(arg_6_0)
						arg_6_0:UpdateLurk(false)

						return
					end)
				else
					local var_1_20 = arg_1_0.op

					WorldConst = var_5

					if var_1_20 == var_5.OpReqTransport then
						assert = var_1_20

						if arg_1_0.destMapId then
							var_1_10006 = arg_1_0.destMapId > 0
						end

						var_1_20(var_1_10006)

						var_1_10006 = var_1_0

						var_1_0.NetUpdateActiveMap(var_1_10006, arg_1_0.entranceId, arg_1_0.destMapId, arg_1_0.destGridId)

						var_1_10006 = var_2

						if var_2.TreasureMap2ItemId(var_1_10006, arg_1_0.destMapId, arg_1_0.entranceId) then
							local var_1_21 = var_2:GetInventoryProxy()

							var_5.RemoveItem(var_1_21, var_4, 1)
						end
					else
						local var_1_22 = arg_1_0.op

						WorldConst = var_5

						if var_1_22 == var_5.OpReqSub then
							var_1_10006 = var_2

							var_2.ResetSubmarine(var_1_10006)

							var_1_10006 = var_2

							var_2.UpdateSubmarineSupport(var_1_10006, true)

							var_1_10006 = var_2

							local var_1_23 = var_2.GetActiveMap(var_1_10006)
						else
							local var_1_24 = arg_1_0.op

							WorldConst = var_5

							if var_1_24 == var_5.OpReqPressingMap then
								local var_1_25 = arg_1_0.arg1

								var_2:FlagMapPressingAward(var_1_25)

								local var_1_26 = var_2:GetAtlas()

								var_5.AddPressingMap(var_1_26, var_1_25)

								if not var_2:GetMap(var_1_25).visionFlag then
									nowWorld = var_7

									local var_1_27 = var_7()

									if var_7.IsMapVisioned(var_1_27, var_1_25) then
										var_1_10006:UpdateVisionFlag(true)
									end
								end
							else
								local var_1_28 = arg_1_0.op

								WorldConst = var_5

								local var_1_30

								if var_1_28 == var_5.OpReqJumpOut then
									assert = var_1_28

									if arg_1_0.destMapId then
										var_1_10006 = arg_1_0.destMapId > 0
									end

									var_1_28(var_1_10006)

									pg = var_1_28

									local var_1_29 = var_1_28.world_chapter_template_reset[var_1_2.gid].reset_item

									var_1_30 = var_2:GetInventoryProxy()
									_ = var_1_10006

									var_1_10006.each(var_1_29, function(arg_7_0)
										local var_7_0 = var_1_30

										var_1.RemoveItem(var_7_0, arg_7_0)

										return
									end)
									var_1_0:NetUpdateActiveMap(arg_1_0.entranceId, arg_1_0.destMapId, arg_1_0.destGridId)

									var_1_2 = var_2:GetActiveMap()
								else
									local var_1_31 = arg_1_0.op

									WorldConst = var_1_30

									if var_1_31 == var_1_30.OpReqEnterPort then
										-- block empty
									else
										local var_1_32 = arg_1_0.op

										WorldConst = var_5

										if var_1_32 == var_5.OpReqCatSalvage then
											var_1_10006 = var_1_2

											local var_1_33 = var_1_2.GetFleet(var_1_10006, arg_1_0.id)

											var_4.UpdateCatSalvage(var_1_33, 0, nil, 0)
										else
											local var_1_34 = arg_1_0.op

											WorldConst = var_5

											if var_1_34 == var_5.OpReqSkipBattle then
												var_1_10006 = var_1_2

												var_1_2.WriteBack(var_1_10006, true, {
													statistics = {},
													hpDropInfo = {}
												})
											else
												local var_1_35 = arg_1_0.op

												WorldConst = var_5

												if var_1_35 == var_5.OpActionFleetMove then
													local var_1_36 = arg_1_0.path[#arg_1_0.path]

													var_1_2:UpdateFleetLocation(arg_1_0.id, var_1_36.row, var_1_36.column)

													var_2.stepCount = var_2.stepCount + #arg_1_0.path
												else
													local var_1_37 = arg_1_0.op

													WorldConst = var_5

													if var_1_37 == var_5.OpActionMoveStep then
														var_1_10006 = arg_1_0

														arg_1_0.ApplyAttachmentUpdate(var_1_10006)

														_ = var_4

														var_4.each(arg_1_0.hiddenCells, function(arg_8_0)
															arg_8_0:UpdateDiscovered(true)

															return
														end)

														var_1_10006 = var_1_2

														local var_1_38 = var_1_2.GetFleet(var_1_10006, arg_1_0.id)
														local var_1_39 = var_1_2:GetCell(var_1_38.row, var_1_38.column)

														if var_5.GetEventAttachment(var_1_39) and var_1_10006:IsTriggered() then
															var_1_10006.triggered = false
														end

														if arg_1_0.updateCarryItems then
															local var_1_40 = #arg_1_0.updateCarryItems

															if 0 < var_1_40 then
																local var_1_41 = var_1_38:GetCarries()

																assert = var_8

																var_8(#var_1_41 == #arg_1_0.updateCarryItems)

																ipairs = var_8

																for iter_1_4, iter_1_5 in var_8(var_1_41) do
																	iter_1_5:UpdateOffset(arg_1_0.updateCarryItems[iter_1_4].offsetRow, arg_1_0.updateCarryItems[iter_1_4].offsetColumn)
																end

																WPool = var_8

																var_8:ReturnArray(arg_1_0.updateCarryItems)

																arg_1_0.updateCarryItems = nil
															end
														end

														var_1_2:UpdateFleetLocation(arg_1_0.id, arg_1_0.pos.row, arg_1_0.pos.column)

														_ = var_7

														var_7.each(arg_1_0.hiddenAttachments, function(arg_9_0)
															arg_9_0:UpdateLurk(false)

															return
														end)
													else
														local var_1_42 = arg_1_0.op

														WorldConst = var_5

														local var_1_44

														if var_1_42 == var_5.OpActionAttachmentMove then
															assert = var_1_42
															var_1_10006 = #arg_1_0.path > 0

															var_1_42(var_1_10006)

															var_1_10006 = arg_1_0.attachment

															local var_1_43 = var_4.Clone(var_1_10006)

															var_1_44 = arg_1_0.path[#arg_1_0.path]

															local var_1_45 = var_1_2
															local var_1_46 = var_1_2.GetCell(var_1_45, arg_1_0.attachment.row, arg_1_0.attachment.column)

															var_1_10006.RemoveAttachment(var_1_46, arg_1_0.attachment)

															local var_1_47 = var_1_2:GetCell(var_1_44.row, var_1_44.column)

															assert = var_1_45

															var_1_45(var_1_47, "dest cell not exist: " .. var_1_44.row .. ", " .. var_1_44.column)

															var_1_43.row = var_1_44.row
															var_1_43.column = var_1_44.column

															var_1_47:AddAttachment(var_1_43)
														else
															local var_1_48 = arg_1_0.op

															WorldConst = var_1_44

															local var_1_49

															if var_1_48 == var_1_44.OpActionEventOp then
																var_1_49 = arg_1_0.effect.effect_type
																WorldMapAttachment = var_1_10006

																if var_1_49 == var_1_10006.EffectEventFOV then
																	var_1_2:EventEffectOpenFOV(var_4)
																end

																local var_1_50 = arg_1_0.attachment

																var_1_49.UpdateDataOp(var_1_50, arg_1_0.attachment.dataop - 1)
															else
																local var_1_51 = arg_1_0.op

																WorldConst = var_1_49

																if var_1_51 == var_1_49.OpActionTaskGoto then
																	local var_1_52 = arg_1_0.effect.effect_type

																	WorldMapAttachment = var_1_10006

																	if var_1_52 == var_1_10006.EffectEventFOV then
																		var_1_2:EventEffectOpenFOV(var_4)
																	end
																end
															end
														end
													end
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end

			::label_1_0::

			if arg_1_0.childOps then
				_ = var_4

				var_4.each(arg_1_0.childOps, function(arg_10_0)
					if not arg_10_0.applied then
						arg_10_0:Apply()
					end

					return
				end)
			end

			if arg_1_0.stepOps then
				_ = var_4

				var_4.each(arg_1_0.stepOps, function(arg_11_0)
					if not arg_11_0.applied then
						arg_11_0:Apply()
					end

					return
				end)
			end

			arg_1_0:ApplyAttachmentUpdate()
			arg_1_0:ApplyNetUpdate()

			if arg_1_0.callbacksWhenApplied then
				_ = var_4

				var_4.each(arg_1_0.callbacksWhenApplied, function(arg_12_0)
					arg_12_0()

					return
				end)
			end

			return
		end
	end
end

function var_0_1.ApplyAttachmentUpdate(arg_13_0)
	getProxy = var_1_10001
	WorldProxy = var_1_10003

	local var_13_0 = var_1_10001(var_1_10003)

	nowWorld = var_1_10002

	local var_13_1 = var_1_10002()
	local var_13_2 = var_2.GetActiveMap(var_13_1)

	if arg_13_0.updateAttachmentCells then
		var_13_0:UpdateMapAttachmentCells(var_13_2.id, arg_13_0.updateAttachmentCells)

		pairs = var_4

		for iter_13_0, iter_13_1 in var_4(arg_13_0.updateAttachmentCells) do
			local var_13_3 = var_13_2:GetCell(iter_13_1.pos.row, iter_13_1.pos.column)

			_ = var_1_10010

			var_1_10010.each(iter_13_1.attachmentList, function(arg_14_0)
				local var_14_0 = var_13_3

				if not var_1.ContainsAttachment(var_14_0, arg_14_0) then
					WPool = var_1

					var_1:Return(arg_14_0)
				end

				return
			end)
		end

		arg_13_0.updateAttachmentCells = nil
	end

	return
end

function var_0_1.ApplyNetUpdate(arg_15_0)
	getProxy = var_1_10001
	WorldProxy = var_1_10003

	local var_15_0 = var_1_10001(var_1_10003)

	nowWorld = var_1_10002

	local var_15_1 = var_1_10002()
	local var_15_2 = var_2.GetActiveMap(var_15_1)

	if arg_15_0.staminaUpdate then
		local var_15_3 = var_2.staminaMgr

		var_4.ChangeStamina(var_15_3, arg_15_0.staminaUpdate[1], arg_15_0.staminaUpdate[2])

		arg_15_0.staminaUpdate = nil
	end

	if arg_15_0.shipUpdates and #arg_15_0.shipUpdates > 0 then
		var_15_0:ApplyShipUpdate(arg_15_0.shipUpdates)

		WPool = var_4

		var_4:ReturnArray(arg_15_0.shipUpdates)

		arg_15_0.shipUpdates = nil
	end

	if arg_15_0.fleetAttachUpdates and #arg_15_0.fleetAttachUpdates > 0 then
		var_15_0:ApplyFleetAttachUpdate(var_15_2.id, arg_15_0.fleetAttachUpdates)

		WPool = var_4

		var_4:ReturnArray(arg_15_0.fleetAttachUpdates)

		arg_15_0.fleetAttachUpdates = nil
	end

	if arg_15_0.fleetUpdates and #arg_15_0.fleetUpdates > 0 then
		var_15_0:ApplyFleetUpdate(var_15_2.id, arg_15_0.fleetUpdates)

		WPool = var_4

		var_4:ReturnArray(arg_15_0.fleetUpdates)

		arg_15_0.fleetUpdates = nil
	end

	if arg_15_0.terrainUpdates and #arg_15_0.terrainUpdates > 0 then
		var_15_0:ApplyTerrainUpdate(var_15_2.id, arg_15_0.terrainUpdates)

		WPool = var_4

		var_4:ReturnArray(arg_15_0.terrainUpdates)

		arg_15_0.terrainUpdates = nil
	end

	if arg_15_0.salvageUpdates and #arg_15_0.salvageUpdates > 0 then
		var_15_0:ApplySalvageUpdate(arg_15_0.salvageUpdates)

		WPool = var_4

		var_4:ReturnArray(arg_15_0.salvageUpdates)

		arg_15_0.salvageUpdates = nil
	end

	return
end

function var_0_1.AddCallbackWhenApplied(arg_16_0, arg_16_1)
	if not arg_16_0.callbacksWhenApplied then
		arg_16_0.callbacksWhenApplied = {}
	end

	table = var_2

	var_2.insert(arg_16_0.callbacksWhenApplied, arg_16_1)

	return
end

return var_0_1
