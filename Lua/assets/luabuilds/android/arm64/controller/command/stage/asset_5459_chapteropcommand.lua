local ChapterOpCommand = class("ChapterOpCommand", import(".ChapterOpRoutine"))

function ChapterOpCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	if (function()
		if var_1_0.type == ChapterConst.OpRetreat then
			local var_2_0 = getProxy(ChapterProxy):getActiveChapter()

			if not var_2_0 then
				return
			end

			if not var_2_0:CheckChapterWillWin() then
				return
			end

			local var_2_1 = getProxy(ChapterProxy):GetContinuousData(SYSTEM_SCENARIO)

			var_1_0.arg1 = var_2_1 and var_2_1:IsRecordTime() and 1 or 0

			return
		end

		local var_2_2 = getProxy(ChapterProxy)
		local var_2_3 = var_2_2:getActiveChapter()

		if not var_2_3 then
			return true
		end

		if var_1_0.type == ChapterConst.OpSwitch then
			for iter_2_0, iter_2_1 in ipairs(var_2_3.fleets) do
				if iter_2_1.id == var_1_0.id then
					var_2_3.findex = iter_2_0

					break
				end
			end

			var_2_2:updateChapter(var_2_3, bit.bor(ChapterConst.DirtyStrategy, ChapterConst.DirtyFleet))
			self:sendNotification(GAME.CHAPTER_OP_DONE, {
				type = var_1_0.type
			})
			pg.TipsMgr.GetInstance():ShowTips(i18n("formation_switch_success", var_2_3.fleet.name))

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

			self:initData(var_1_0, arg_3_0, var_3_1)
			self:doDropUpdate()

			if self.chapter then
				local var_3_4 = self.items

				if var_1_0.type == ChapterConst.OpMove then
					self:doCollectCommonAction()
					self:doCollectAI()
					self:doMove()
					self:doTeleportByPortal()
					getProxy(ChapterProxy):SetExtendChapterData(var_3_1.id, "FleetMoveDistance", #arg_3_0.move_path)
				elseif var_1_0.type == ChapterConst.OpBox then
					self:AddBoxAction()
					self:doCollectAI()
				else
					self:doMapUpdate()
					self:doAIUpdate()
					self:doShipUpdate()
					self:doBuffUpdate()
					self:doCellFlagUpdate()
					self:doExtraFlagUpdate()

					if var_1_0.type == ChapterConst.OpRetreat then
						if not var_1_0.id then
							var_1_0.win = self.chapter:CheckChapterWillWin()

							if var_1_0.win then
								self.chapter:UpdateProgressOnRetreat()
								var_3_0:addRemasterPassCount(self.chapter.id)
							end

							local var_3_5 = pg.TimeMgr.GetInstance()

							if var_1_0.win and var_3_0:getMapById(var_3_1:getConfig("map")):getMapType() == Map.ELITE and var_3_5:IsSameDay(var_3_1:getStartTime(), var_3_5:GetServerTime()) then
								getProxy(DailyLevelProxy):EliteCountPlus()
							end

							if var_3_4 and #var_3_4 > 0 then
								getProxy(ChapterProxy):AddExtendChapterDataArray(self.chapter.id, "ResultDrops", var_3_4)

								var_3_4 = nil
							end

							var_3_2 = var_3_0:FinishAutoFight(var_3_1.id)

							getProxy(ChapterProxy):SetLastFleetIndex(self.chapter:GetRegularFleetIds(), true)
						end

						self:doRetreat(arg_3_0.auto_battle_time_update)

						if not var_1_0.id then
							var_3_3 = Clone(self.chapter)

							self.chapter:CleanLevelData()
						end
					elseif var_1_0.type == ChapterConst.OpStory then
						self:doCollectAI()
						self:doPlayStory()
					elseif var_1_0.type == ChapterConst.OpAmbush then
						self:doAmbush()
					elseif var_1_0.type == ChapterConst.OpStrategy then
						self:doCollectAI()
						self:doStrategy()
					elseif var_1_0.type == ChapterConst.OpRepair then
						self:doRepair()
					elseif var_1_0.type == ChapterConst.OpSupply then
						self:doSupply()
					elseif var_1_0.type == ChapterConst.OpEnemyRound then
						self:doCollectAI()
						self:doEnemyRound()
					elseif var_1_0.type == ChapterConst.OpSubState then
						self:doSubState()
					elseif var_1_0.type == ChapterConst.OpBarrier then
						self:doBarrier()
					elseif var_1_0.type == ChapterConst.OpRequest then
						self:doRequest()
					elseif var_1_0.type == ChapterConst.OpSkipBattle then
						self.chapter:UpdateProgressAfterSkipBattle()
						self:doSkipBattle()
					elseif var_1_0.type == ChapterConst.OpPreClear then
						self.chapter:CleanCurrentEnemy()
						self:doSkipBattle()
					elseif var_1_0.type == ChapterConst.OpSubTeleport then
						self:doTeleportSub()
						self:doTeleportByPortal()
					elseif var_1_0.type == ChapterConst.OPSubStrike then
						existCall(var_1_0.callback)
					end
				end

				if var_1_0.type == ChapterConst.OpEnemyRound or var_1_0.type == ChapterConst.OpMove then
					var_3_0:updateChapter(self.chapter, self.flag)
				else
					self.flag = bit.bor(self.flag, self.extraFlag)

					var_3_0:updateChapter(self.chapter, self.flag)
				end

				if var_1_0.type == ChapterConst.OpSkipBattle then
					self:sendNotification(GAME.CHAPTER_BATTLE_RESULT_REQUEST, {
						isSkipBattle = true
					})

					return
				end

				local var_3_6 = {
					type = var_1_0.type,
					id = var_1_0.id,
					arg1 = var_1_0.arg1,
					arg2 = var_1_0.arg2,
					path = arg_3_0.move_path,
					fullpath = self.fullpath,
					items = var_3_4
				}

				var_3_6.exittype = var_1_0.exittype or 0
				var_3_6.aiActs = self.aiActs
				var_3_6.extraFlag = self.extraFlag
				var_3_6.oldLine = var_1_0.ordLine
				var_3_6.win = var_1_0.win
				var_3_6.teleportPaths = self.teleportPaths
				var_3_6.extendData = var_3_2
				var_3_6.finalChapterLevelData = var_3_3

				self:sendNotification(GAME.CHAPTER_OP_DONE, var_3_6)
			end
		else
			errorMsg(string.format("SLG操作%d 请求失效，重新拉取信息", var_1_0.type))
			pg.TipsMgr.GetInstance():ShowTips(errorTip("levelScene_operation", arg_3_0.result))

			if var_1_0.type ~= ChapterConst.OpRequest and var_1_0.type ~= ChapterConst.OpRetreat and var_1_0.type ~= ChapterConst.OpSubTeleport then
				self:sendNotification(GAME.CHAPTER_OP, {
					type = ChapterConst.OpRequest,
					id = var_1_0.id
				})
			end
		end

		return
	end)

	return
end

function ChapterOpCommand:PrepareChapterRetreat()
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
						end
					end

					arg_6_2()

					return
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
	}, self)

	return
end

function ChapterOpCommand:PlayChapterStory(arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = pg.NewStoryMgr.GetInstance()

	var_8_0:Play(self, arg_8_1, arg_8_3)

	if not getProxy(SettingsProxy):GetStoryAutoPlayFlag() and arg_8_2 and var_8_0:IsRunning() then
		var_8_0:Pause()

		local function var_8_1()
			var_8_0:Resume()

			return
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideYes = true,
			parent = rtf(var_8_0._tf),
			type = MSGBOX_TYPE_STORY_CANCEL_TIP,
			onYes = function()
				var_8_1()
				var_8_0:TriggerAutoBtn()

				return
			end,
			onNo = var_8_1
		})

		return true
	end

	return
end

return ChapterOpCommand
