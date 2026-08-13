class = var_0_10000

local var_0_0 = "ChapterOpCommand"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".ChapterOpRoutine"))

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	if (function()
		local var_2_0 = var_1_0.type

		ChapterConst = var_2_10001

		if var_2_0 == var_2_10001.OpRetreat then
			return
		end

		getProxy = var_2_0
		ChapterProxy = var_1

		local var_2_1 = var_2_0(var_1)

		if not var_0.getActiveChapter(var_2_1) then
			return true
		end

		local var_2_2 = var_1_0.type

		ChapterConst = var_2_10003

		if var_2_2 == var_2_10003.OpSwitch then
			ipairs = var_2_2

			for iter_2_0, iter_2_1 in var_2_2(var_1.fleets) do
				if iter_2_1.id == var_1_0.id then
					var_1.findex = iter_2_0

					break
				end
			end

			local var_2_3 = var_0
			local var_2_4 = var_0.updateChapter
			local var_2_5 = var_1

			bit = iter_2_0

			local var_2_6 = iter_2_0.bor

			ChapterConst = iter_2_1

			local var_2_7 = iter_2_1.DirtyStrategy

			ChapterConst = var_2_10007

			var_2_4(var_2_3, var_2_5, var_2_6(var_2_7, var_2_10007.DirtyFleet))

			local var_2_8 = arg_1_0
			local var_2_9 = var_2.sendNotification

			GAME = var_2_5

			var_2_9(var_2_8, var_2_5.CHAPTER_OP_DONE, {
				type = var_1_0.type
			})

			pg = var_2_9

			local var_2_10 = var_2_9.TipsMgr.GetInstance()
			local var_2_11 = var_2.ShowTips

			i18n = var_4

			var_2_11(var_2_10, var_4("formation_switch_success", var_1.fleet.name))

			return true
		end

		return
	end)() then
		return
	end

	pg = var_4

	local var_1_1 = var_4.ConnectionMgr.GetInstance()
	local var_1_2 = var_4.Send
	local var_1_3 = 13103
	local var_1_4 = {
		act = var_1_0.type
	}

	defaultValue = var_8
	var_1_4.group_id = var_8(var_1_0.id, 0)
	var_1_4.act_arg_1 = var_1_0.arg1
	var_1_4.act_arg_2 = var_1_0.arg2
	var_1_4.act_arg_3 = var_1_0.arg3
	var_1_4.act_arg_4 = var_1_0.arg4
	var_1_4.act_arg_5 = var_1_0.arg5

	var_1_2(var_1_1, var_1_3, var_1_4, 13104, function(arg_3_0)
		if arg_3_0.result == 0 then
			getProxy = var_1
			ChapterProxy = var_2_10002

			local var_3_0 = var_1(var_2_10002)

			if not var_1.getActiveChapter(var_3_0) then
				return
			end

			local var_3_1
			local var_3_2
			local var_3_3 = arg_1_0

			var_5.initData(var_3_3, var_1_0, arg_3_0, var_2_10002)

			local var_3_4 = arg_1_0

			var_5.doDropUpdate(var_3_4)

			if arg_1_0.chapter then
				local var_3_5 = arg_1_0.items
				local var_3_6 = var_1_0.type

				ChapterConst = var_7

				local var_3_7, var_3_10

				if var_3_6 == var_7.OpMove then
					var_3_7 = arg_1_0

					var_6.doCollectCommonAction(var_3_7)

					var_3_7 = arg_1_0

					var_6.doCollectAI(var_3_7)

					var_3_7 = arg_1_0

					var_6.doMove(var_3_7)

					var_3_7 = arg_1_0

					var_6.doTeleportByPortal(var_3_7)

					getProxy = var_6
					ChapterProxy = var_3_7
					var_3_7 = var_6(var_3_7)

					var_6.SetExtendChapterData(var_3_7, var_2_10002.id, "FleetMoveDistance", #arg_3_0.move_path)
				else
					local var_3_8 = var_1_0.type

					ChapterConst = var_3_7

					if var_3_8 == var_3_7.OpBox then
						var_3_7 = arg_1_0

						var_6.AddBoxAction(var_3_7)

						var_3_7 = arg_1_0

						var_6.doCollectAI(var_3_7)
					else
						var_3_7 = arg_1_0

						var_6.doMapUpdate(var_3_7)

						var_3_7 = arg_1_0

						var_6.doAIUpdate(var_3_7)

						var_3_7 = arg_1_0

						var_6.doShipUpdate(var_3_7)

						var_3_7 = arg_1_0

						var_6.doBuffUpdate(var_3_7)

						var_3_7 = arg_1_0

						var_6.doCellFlagUpdate(var_3_7)

						var_3_7 = arg_1_0

						var_6.doExtraFlagUpdate(var_3_7)

						local var_3_9 = var_1_0.type

						ChapterConst = var_3_7

						if var_3_9 == var_3_7.OpRetreat then
							if not var_1_0.id then
								var_3_7 = var_1
								var_3_10 = var_1.getMapById(var_3_7, var_2_10002:getConfig("map"))
								var_3_7 = var_6.getMapType(var_3_10)
								var_3_10 = var_1_0

								local var_3_11 = arg_1_0.chapter

								var_3_10.win = var_9.CheckChapterWillWin(var_3_11)

								if var_1_0.win then
									local var_3_12 = arg_1_0.chapter

									var_3_10.UpdateProgressOnRetreat(var_3_12)
									var_1:addRemasterPassCount(arg_1_0.chapter.id)
								end

								pg = var_3_10
								var_3_10 = var_3_10.TimeMgr.GetInstance()

								if var_1_0.win then
									Map = var_9

									if var_3_7 == var_9.ELITE then
										local var_3_13 = var_3_10

										if var_3_10.IsSameDay(var_3_13, var_2_10002:getStartTime(), var_3_10:GetServerTime()) then
											getProxy = var_9
											DailyLevelProxy = var_3_13

											local var_3_14 = var_9(var_3_13)

											var_9.EliteCountPlus(var_3_14)
										end
									end
								end

								if var_3_5 then
									local var_3_15 = #var_3_5

									if 0 < var_3_15 then
										getProxy = var_3_15
										ChapterProxy = var_10

										local var_3_16 = var_3_15(var_10)

										var_9.AddExtendChapterDataArray(var_3_16, arg_1_0.chapter.id, "ResultDrops", var_3_5)

										var_3_5 = nil
									end
								end

								var_3_1 = var_1:FinishAutoFight(var_2_10002.id)

								local var_3_17 = arg_1_0.chapter
								local var_3_18 = var_9.GetRegularFleetIds(var_3_17)

								getProxy = var_3_17
								ChapterProxy = var_11

								local var_3_19 = var_3_17(var_11)

								var_10.SetLastFleetIndex(var_3_19, var_3_18, true)
							end

							var_3_7 = arg_1_0

							var_6.doRetreat(var_3_7)

							if not var_1_0.id then
								Clone = var_6
								var_3_2 = var_6(arg_1_0.chapter)
								var_3_7 = arg_1_0.chapter

								var_6.CleanLevelData(var_3_7)
							end
						else
							local var_3_20 = var_1_0.type

							ChapterConst = var_3_7

							if var_3_20 == var_3_7.OpStory then
								var_3_7 = arg_1_0

								var_6.doCollectAI(var_3_7)

								var_3_7 = arg_1_0

								var_6.doPlayStory(var_3_7)
							else
								local var_3_21 = var_1_0.type

								ChapterConst = var_3_7

								if var_3_21 == var_3_7.OpAmbush then
									var_3_7 = arg_1_0

									var_6.doAmbush(var_3_7)
								else
									local var_3_22 = var_1_0.type

									ChapterConst = var_3_7

									if var_3_22 == var_3_7.OpStrategy then
										var_3_7 = arg_1_0

										var_6.doCollectAI(var_3_7)

										var_3_7 = arg_1_0

										var_6.doStrategy(var_3_7)
									else
										local var_3_23 = var_1_0.type

										ChapterConst = var_3_7

										if var_3_23 == var_3_7.OpRepair then
											var_3_7 = arg_1_0

											var_6.doRepair(var_3_7)
										else
											local var_3_24 = var_1_0.type

											ChapterConst = var_3_7

											if var_3_24 == var_3_7.OpSupply then
												var_3_7 = arg_1_0

												var_6.doSupply(var_3_7)
											else
												local var_3_25 = var_1_0.type

												ChapterConst = var_3_7

												if var_3_25 == var_3_7.OpEnemyRound then
													var_3_7 = arg_1_0

													var_6.doCollectAI(var_3_7)

													var_3_7 = arg_1_0

													var_6.doEnemyRound(var_3_7)
												else
													local var_3_26 = var_1_0.type

													ChapterConst = var_3_7

													if var_3_26 == var_3_7.OpSubState then
														var_3_7 = arg_1_0

														var_6.doSubState(var_3_7)
													else
														local var_3_27 = var_1_0.type

														ChapterConst = var_3_7

														if var_3_27 == var_3_7.OpBarrier then
															var_3_7 = arg_1_0

															var_6.doBarrier(var_3_7)
														else
															local var_3_28 = var_1_0.type

															ChapterConst = var_3_7

															if var_3_28 == var_3_7.OpRequest then
																var_3_7 = arg_1_0

																var_6.doRequest(var_3_7)
															else
																local var_3_29 = var_1_0.type

																ChapterConst = var_3_7

																if var_3_29 == var_3_7.OpSkipBattle then
																	var_3_7 = arg_1_0.chapter

																	var_6.UpdateProgressAfterSkipBattle(var_3_7)

																	var_3_7 = arg_1_0

																	var_6.doSkipBattle(var_3_7)
																else
																	local var_3_30 = var_1_0.type

																	ChapterConst = var_3_7

																	if var_3_30 == var_3_7.OpPreClear then
																		var_3_7 = arg_1_0.chapter

																		var_6.CleanCurrentEnemy(var_3_7)

																		var_3_7 = arg_1_0

																		var_6.doSkipBattle(var_3_7)
																	else
																		local var_3_31 = var_1_0.type

																		ChapterConst = var_3_7

																		if var_3_31 == var_3_7.OpSubTeleport then
																			var_3_7 = arg_1_0

																			var_6.doTeleportSub(var_3_7)

																			var_3_7 = arg_1_0

																			var_6.doTeleportByPortal(var_3_7)
																		else
																			local var_3_32 = var_1_0.type

																			ChapterConst = var_3_7

																			if var_3_32 == var_3_7.OPSubStrike then
																				existCall = var_3_32

																				var_3_32(var_1_0.callback)
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
				end

				local var_3_33 = var_1_0.type

				ChapterConst = var_3_7

				if var_3_33 ~= var_3_7.OpEnemyRound then
					local var_3_34 = var_1_0.type

					ChapterConst = var_3_35

					local var_3_35

					if var_3_34 == var_3_35.OpMove then
						var_3_35 = var_1

						var_1.updateChapter(var_3_35, arg_1_0.chapter, arg_1_0.flag)
					else
						local var_3_36 = arg_1_0

						bit = var_3_35
						var_3_36.flag = var_3_35.bor(arg_1_0.flag, arg_1_0.extraFlag)
						var_3_35 = var_1

						var_1.updateChapter(var_3_35, arg_1_0.chapter, arg_1_0.flag)
					end

					local var_3_37 = var_1_0.type

					ChapterConst = var_3_35

					if var_3_37 == var_3_35.OpSkipBattle then
						local var_3_38 = arg_1_0
						local var_3_39 = var_6.sendNotification

						GAME = var_3_10

						var_3_39(var_3_38, var_3_10.CHAPTER_BATTLE_RESULT_REQUEST, {
							isSkipBattle = true
						})

						return
					end

					local var_3_40 = arg_1_0
					local var_3_41 = var_6.sendNotification

					GAME = var_3_10

					local var_3_42 = var_3_10.CHAPTER_OP_DONE
					local var_3_43 = {
						type = var_1_0.type,
						id = var_1_0.id,
						arg1 = var_1_0.arg1,
						arg2 = var_1_0.arg2,
						path = arg_3_0.move_path,
						fullpath = arg_1_0.fullpath,
						items = var_3_5
					}
					local var_3_44

					if not var_1_0.exittype then
						var_3_44 = 0
					end

					var_3_43.exittype = var_3_44
					var_3_43.aiActs = arg_1_0.aiActs
					var_3_43.extraFlag = arg_1_0.extraFlag
					var_3_43.oldLine = var_1_0.ordLine
					var_3_43.win = var_1_0.win
					var_3_43.teleportPaths = arg_1_0.teleportPaths
					var_3_43.extendData = var_3_1
					var_3_43.finalChapterLevelData = var_3_2

					var_3_41(var_3_40, var_3_42, var_3_43)

					goto label_3_0

					errorMsg = var_1
					string = var_2_10002

					var_1(var_2_10002.format("SLG操作%d 请求失效，重新拉取信息", var_1_0.type))

					pg = var_1

					do
						local var_3_45 = var_1.TipsMgr.GetInstance()
						local var_3_46 = var_1.ShowTips

						errorTip = var_3

						var_3_46(var_3_45, var_3("levelScene_operation", arg_3_0.result))

						local var_3_47 = var_1_0.type

						ChapterConst = var_3_45

						if var_3_47 ~= var_3_45.OpRequest then
							local var_3_48 = var_1_0.type

							ChapterConst = var_2

							if var_3_48 ~= var_2.OpRetreat then
								local var_3_49 = var_1_0.type

								ChapterConst = var_2

								if var_3_49 ~= var_2.OpSubTeleport then
									local var_3_50 = arg_1_0
									local var_3_51 = var_1.sendNotification

									GAME = var_3

									local var_3_52 = var_3.CHAPTER_OP
									local var_3_53 = {}

									ChapterConst = var_5
									var_3_53.type = var_5.OpRequest
									var_3_53.id = var_1_0.id

									var_3_51(var_3_50, var_3_52, var_3_53)
								end
							end
						end
					end

					::label_3_0::

					return
				end
			end
		end
	end)

	return
end

function var_0_1.PrepareChapterRetreat(arg_4_0)
	seriesAsync = var_1_10001

	var_1_10001({
		function(arg_5_0)
			getProxy = var_2_10001
			ChapterProxy = var_2_10002

			local var_5_0 = var_2_10001(var_2_10002)

			if var_1.getActiveChapter(var_5_0) and var_1:CheckChapterWillWin() and not var_1:IsRemaster() then
				var_1:UpdateProgressOnRetreat()

				local var_5_1 = var_1:getConfig("defeat_story_count")
				local var_5_2 = var_1:getConfig("defeat_story")
				local var_5_3 = false

				table = var_5

				var_5.SerialIpairsAsync(var_5_1, function(arg_6_0, arg_6_1, arg_6_2)
					if arg_6_1 > var_0.defeatCount then
						arg_6_2()

						return
					end

					if var_5_2[arg_6_0] then
						pg = var_3_10004

						local var_6_0 = var_3_10004.NewStoryMgr.GetInstance()

						var_3_10004 = var_3_10004.IsPlayed
						tostring = var_3_10006

						if var_3_10004(var_6_0, var_3_10006(var_3)) then
							arg_6_2()

							return
						end

						type = var_3_10004

						local var_6_2

						if var_3_10004(var_3) == "number" then
							pg = var_6_2

							local var_6_1 = var_6_2.m02

							var_6_2 = var_6_2.sendNotification
							GAME = var_3_10006

							local var_6_3 = var_3_10006.BEGIN_STAGE
							local var_6_4 = {}

							SYSTEM_PERFORM = var_3_10008
							var_6_4.system = var_3_10008
							var_6_4.stageId = var_3

							var_6_2(var_6_1, var_6_3, var_6_4)
						else
							type = var_6_2

							if var_6_2(var_3) == "string" then
								ChapterOpCommand = var_4

								local var_6_5 = var_4.PlayChapterStory
								local var_6_6 = var_3
								local var_6_7 = arg_6_2
								local var_6_9

								if not var_5_3 then
									local var_6_8 = var_0

									var_6_9 = var_7.IsAutoFight(var_6_8)
								else
									var_6_9 = false
								end

								if false then
									var_6_9 = true
								end

								if var_6_5(var_6_6, var_6_7, var_6_9) then
									var_5_3 = true
								end
							else
								arg_6_2()
							end
						end

						return
					end
				end, arg_5_0)
			else
				arg_5_0()
			end

			return
		end,
		function(arg_7_0)
			pg = var_2_10001

			local var_7_0 = var_2_10001.m02
			local var_7_1 = var_1.sendNotification

			GAME = var_2_10003

			local var_7_2 = var_2_10003.CHAPTER_OP
			local var_7_3 = {}

			ChapterConst = var_2_10005
			var_7_3.type = var_2_10005.OpRetreat

			var_7_1(var_7_0, var_7_2, var_7_3)
			arg_7_0()

			return
		end
	}, arg_4_0)

	return
end

function var_0_1.PlayChapterStory(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	pg = var_1_10004

	local var_8_0 = var_1_10004.NewStoryMgr.GetInstance()

	var_4.Play(var_8_0, arg_8_0, arg_8_1, arg_8_3)

	getProxy = var_5
	SettingsProxy = var_8_0

	local var_8_1 = var_5(var_8_0)

	if not var_5.GetStoryAutoPlayFlag(var_8_1) and arg_8_2 and var_4:IsRunning() then
		local var_8_2 = var_4

		var_4.Pause(var_8_2)

		local function var_8_3()
			local var_9_0 = var_0

			var_0.Resume(var_9_0)

			return
		end

		pg = var_8_2

		local var_8_4 = var_8_2.MsgboxMgr.GetInstance()
		local var_8_5 = var_6.ShowMsgBox
		local var_8_6 = {
			hideYes = true
		}

		rtf = var_9
		var_8_6.parent = var_9(var_4._tf)
		MSGBOX_TYPE_STORY_CANCEL_TIP = var_9
		var_8_6.type = var_9

		function var_8_6.onYes()
			var_8_3()

			local var_10_0 = var_0

			var_0.TriggerAutoBtn(var_10_0)

			return
		end

		var_8_6.onNo = var_8_3

		var_8_5(var_8_4, var_8_6)

		return true
	end

	return
end

return var_0_1
