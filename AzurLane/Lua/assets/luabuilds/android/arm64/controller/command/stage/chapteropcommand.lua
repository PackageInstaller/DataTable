local var_0_0 = class("ChapterOpCommand", import(".ChapterOpRoutine"))

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	if (function()
		if var_1_0.type == ChapterConst.OpRetreat then
			return
		end

		local var_2_0 = getProxy(ChapterProxy)
		local var_2_1 = var_2_0:getActiveChapter()

		if not var_2_1 then
			return true
		end

		if var_1_0.type == ChapterConst.OpSwitch then
			for iter_2_0, iter_2_1 in ipairs(var_2_1.fleets) do
				if iter_2_1.id == var_1_0.id then
					var_2_1.findex = iter_2_0

					break
				end
			end

			var_2_0:updateChapter(var_2_1, bit.bor(ChapterConst.DirtyStrategy, ChapterConst.DirtyFleet))
			arg_1_0:sendNotification(GAME.CHAPTER_OP_DONE, {
				type = var_1_0.type
			})
			pg.TipsMgr.GetInstance():ShowTips(i18n("formation_switch_success", var_2_1.fleet.name))

			return true
		end

		return
	end)() then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(13103, {
		act = var_1_0.type,
		group_id = defaultValue(var_1_0.id, 0),
		act_arg_1 = var_1_0.arg1,
		act_arg_2 = var_1_0.arg2,
		act_arg_3 = var_1_0.arg3,
		act_arg_4 = var_1_0.arg4,
		act_arg_5 = var_1_0.arg5
	}, 13104, function(arg_3_0)
		if arg_3_0.result == 0 then
			local var_3_0 = getProxy(ChapterProxy)
			local var_3_1 = var_3_0:getActiveChapter()

			if not var_3_1 then
				return
			end

			local var_3_2
			local var_3_3

			arg_1_0:initData(var_1_0, arg_3_0, var_3_1)
			arg_1_0:doDropUpdate()

			if arg_1_0.chapter then
				local var_3_4 = arg_1_0.items

				if var_1_0.type == ChapterConst.OpMove then
					arg_1_0:doCollectCommonAction()
					arg_1_0:doCollectAI()
					arg_1_0:doMove()
					arg_1_0:doTeleportByPortal()
					getProxy(ChapterProxy):SetExtendChapterData(var_3_1.id, "FleetMoveDistance", #arg_3_0.move_path)
				elseif var_1_0.type == ChapterConst.OpBox then
					arg_1_0:AddBoxAction()
					arg_1_0:doCollectAI()
				else
					arg_1_0:doMapUpdate()
					arg_1_0:doAIUpdate()
					arg_1_0:doShipUpdate()
					arg_1_0:doBuffUpdate()
					arg_1_0:doCellFlagUpdate()
					arg_1_0:doExtraFlagUpdate()

					if var_1_0.type == ChapterConst.OpRetreat then
						if not var_1_0.id then
							var_1_0.win = arg_1_0.chapter:CheckChapterWillWin()

							if var_1_0.win then
								arg_1_0.chapter:UpdateProgressOnRetreat()
								var_3_0:addRemasterPassCount(arg_1_0.chapter.id)
							end

							local var_3_5 = pg.TimeMgr.GetInstance()

							if var_1_0.win and var_3_0:getMapById(var_3_1:getConfig("map")):getMapType() == Map.ELITE and var_3_5:IsSameDay(var_3_1:getStartTime(), var_3_5:GetServerTime()) then
								getProxy(DailyLevelProxy):EliteCountPlus()
							end

							if var_3_4 and #var_3_4 > 0 then
								getProxy(ChapterProxy):AddExtendChapterDataArray(arg_1_0.chapter.id, "ResultDrops", var_3_4)

								var_3_4 = nil
							end

							var_3_2 = var_3_0:FinishAutoFight(var_3_1.id)

							getProxy(ChapterProxy):SetLastFleetIndex(arg_1_0.chapter:GetRegularFleetIds(), true)
						end

						arg_1_0:doRetreat()

						if not var_1_0.id then
							var_3_3 = Clone(arg_1_0.chapter)

							arg_1_0.chapter:CleanLevelData()
						end
					elseif var_1_0.type == ChapterConst.OpStory then
						arg_1_0:doCollectAI()
						arg_1_0:doPlayStory()
					elseif var_1_0.type == ChapterConst.OpAmbush then
						arg_1_0:doAmbush()
					elseif var_1_0.type == ChapterConst.OpStrategy then
						arg_1_0:doCollectAI()
						arg_1_0:doStrategy()
					elseif var_1_0.type == ChapterConst.OpRepair then
						arg_1_0:doRepair()
					elseif var_1_0.type == ChapterConst.OpSupply then
						arg_1_0:doSupply()
					elseif var_1_0.type == ChapterConst.OpEnemyRound then
						arg_1_0:doCollectAI()
						arg_1_0:doEnemyRound()
					elseif var_1_0.type == ChapterConst.OpSubState then
						arg_1_0:doSubState()
					elseif var_1_0.type == ChapterConst.OpBarrier then
						arg_1_0:doBarrier()
					elseif var_1_0.type == ChapterConst.OpRequest then
						arg_1_0:doRequest()
					elseif var_1_0.type == ChapterConst.OpSkipBattle then
						arg_1_0.chapter:UpdateProgressAfterSkipBattle()
						arg_1_0:doSkipBattle()
					elseif var_1_0.type == ChapterConst.OpPreClear then
						arg_1_0.chapter:CleanCurrentEnemy()
						arg_1_0:doSkipBattle()
					elseif var_1_0.type == ChapterConst.OpSubTeleport then
						arg_1_0:doTeleportSub()
						arg_1_0:doTeleportByPortal()
					elseif var_1_0.type == ChapterConst.OPSubStrike then
						existCall(var_1_0.callback)
					end
				end

				if var_1_0.type == ChapterConst.OpEnemyRound or var_1_0.type == ChapterConst.OpMove then
					var_3_0:updateChapter(arg_1_0.chapter, arg_1_0.flag)
				else
					arg_1_0.flag = bit.bor(arg_1_0.flag, arg_1_0.extraFlag)

					var_3_0:updateChapter(arg_1_0.chapter, arg_1_0.flag)
				end

				if var_1_0.type == ChapterConst.OpSkipBattle then
					arg_1_0:sendNotification(GAME.CHAPTER_BATTLE_RESULT_REQUEST, {
						isSkipBattle = true
					})

					return
				end

				;({
					type = var_1_0.type,
					id = var_1_0.id,
					arg1 = var_1_0.arg1,
					arg2 = var_1_0.arg2,
					path = arg_3_0.move_path,
					fullpath = arg_1_0.fullpath,
					items = var_3_4
				}).exittype = var_1_0.exittype or 0
				;({
					type = var_1_0.type,
					id = var_1_0.id,
					arg1 = var_1_0.arg1,
					arg2 = var_1_0.arg2,
					path = arg_3_0.move_path,
					fullpath = arg_1_0.fullpath,
					items = var_3_4
				}).aiActs = arg_1_0.aiActs
				;({
					type = var_1_0.type,
					id = var_1_0.id,
					arg1 = var_1_0.arg1,
					arg2 = var_1_0.arg2,
					path = arg_3_0.move_path,
					fullpath = arg_1_0.fullpath,
					items = var_3_4
				}).extraFlag = arg_1_0.extraFlag
				;({
					type = var_1_0.type,
					id = var_1_0.id,
					arg1 = var_1_0.arg1,
					arg2 = var_1_0.arg2,
					path = arg_3_0.move_path,
					fullpath = arg_1_0.fullpath,
					items = var_3_4
				}).oldLine = var_1_0.ordLine
				;({
					type = var_1_0.type,
					id = var_1_0.id,
					arg1 = var_1_0.arg1,
					arg2 = var_1_0.arg2,
					path = arg_3_0.move_path,
					fullpath = arg_1_0.fullpath,
					items = var_3_4
				}).win = var_1_0.win
				;({
					type = var_1_0.type,
					id = var_1_0.id,
					arg1 = var_1_0.arg1,
					arg2 = var_1_0.arg2,
					path = arg_3_0.move_path,
					fullpath = arg_1_0.fullpath,
					items = var_3_4
				}).teleportPaths = arg_1_0.teleportPaths
				;({
					type = var_1_0.type,
					id = var_1_0.id,
					arg1 = var_1_0.arg1,
					arg2 = var_1_0.arg2,
					path = arg_3_0.move_path,
					fullpath = arg_1_0.fullpath,
					items = var_3_4
				}).extendData = var_3_2
				;({
					type = var_1_0.type,
					id = var_1_0.id,
					arg1 = var_1_0.arg1,
					arg2 = var_1_0.arg2,
					path = arg_3_0.move_path,
					fullpath = arg_1_0.fullpath,
					items = var_3_4
				}).finalChapterLevelData = var_3_3

				var_3_6(arg_1_0, GAME.CHAPTER_OP_DONE, {
					type = var_1_0.type,
					id = var_1_0.id,
					arg1 = var_1_0.arg1,
					arg2 = var_1_0.arg2,
					path = arg_3_0.move_path,
					fullpath = arg_1_0.fullpath,
					items = var_3_4
				})
			end
		else
			errorMsg(string.format("SLG操作%d 请求失效，重新拉取信息", var_1_0.type))
			pg.TipsMgr.GetInstance():ShowTips(errorTip("levelScene_operation", arg_3_0.result))

			if var_1_0.type ~= ChapterConst.OpRequest and var_1_0.type ~= ChapterConst.OpRetreat and var_1_0.type ~= ChapterConst.OpSubTeleport then
				arg_1_0:sendNotification(GAME.CHAPTER_OP, {
					type = ChapterConst.OpRequest,
					id = var_1_0.id
				})
			end
		end

		return
	end)

	return
end

function var_0_0.PrepareChapterRetreat(arg_4_0)
	seriesAsync({
		function(arg_5_0)
			local var_5_0 = getProxy(ChapterProxy):getActiveChapter()

			if var_5_0 and var_5_0:CheckChapterWillWin() and not var_5_0:IsRemaster() then
				var_5_0:UpdateProgressOnRetreat()

				local var_5_1 = var_5_0:getConfig("defeat_story")
				local var_5_2 = false

				table.SerialIpairsAsync(var_5_0:getConfig("defeat_story_count"), function(arg_6_0, arg_6_1, arg_6_2)
					if arg_6_1 > var_5_0.defeatCount then
						arg_6_2()

						return
					end

					local var_6_0 = var_5_1[arg_6_0]

					if var_5_1[arg_6_0] then
						if pg.NewStoryMgr.GetInstance():IsPlayed(tostring(var_6_0)) then
							arg_6_2()

							return
						end

						if type(var_6_0) == "number" then
							pg.m02:sendNotification(GAME.BEGIN_STAGE, {
								system = SYSTEM_PERFORM,
								stageId = var_6_0
							})
						elseif type(var_6_0) == "string" then
							if ChapterOpCommand.PlayChapterStory(var_6_0, arg_6_2, not var_5_2 and var_5_0:IsAutoFight()) then
								var_5_2 = true
							end
						else
							arg_6_2()
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
			pg.m02:sendNotification(GAME.CHAPTER_OP, {
				type = ChapterConst.OpRetreat
			})
			arg_7_0()

			return
		end
	}, arg_4_0)

	return
end

function var_0_0.PlayChapterStory(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = pg.NewStoryMgr.GetInstance()

	var_8_0:Play(arg_8_0, arg_8_1, arg_8_3)

	if not getProxy(SettingsProxy):GetStoryAutoPlayFlag() and arg_8_2 and var_8_0:IsRunning() then
		var_8_0:Pause()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideYes = true,
			parent = rtf(var_8_0._tf),
			type = MSGBOX_TYPE_STORY_CANCEL_TIP,
			onYes = function()
				var_0()
				var_8_0:TriggerAutoBtn()

				return
			end,
			onNo = function()
				var_8_0:Resume()

				return
			end
		})

		return true
	end

	return
end

return var_0_0
