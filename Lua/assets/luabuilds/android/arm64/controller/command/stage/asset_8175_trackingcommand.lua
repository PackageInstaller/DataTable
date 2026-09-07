local TrackingCommand = class("TrackingCommand", pm.SimpleCommand)

function TrackingCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.chapterId
	local var_1_2 = var_1_0.fleetIds
	local var_1_3 = var_1_0.operationItem or 0
	local var_1_4 = var_1_0.loopFlag or 0
	local var_1_5 = var_1_0.duties

	if not var_1_0.duties or var_1_4 == 0 then
		var_1_5 = {}
	end

	local var_1_6 = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_5) do
		table.insert(var_1_6, {
			key = iter_1_0,
			value = iter_1_1
		})
	end

	local var_1_7 = getProxy(ChapterProxy)
	local var_1_8 = var_1_7:getChapterById(var_1_1)

	var_1_8.loopFlag = var_1_4

	local var_1_9 = var_1_7:getMapById(var_1_8:getConfig("map"))
	local var_1_10 = var_1_7:GetContinuousData(SYSTEM_SCENARIO)
	local var_1_11 = var_1_7:getRemasterTicketCost()
	local var_1_12

	seriesAsync({
		function(arg_2_0)
			if var_1_9:isRemaster() and var_1_7.remasterTickets < var_1_11 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("levelScene_remaster_tickets_not_enough"))
				self:sendNotification(GAME.TRACKING_ERROR, {
					chapter = var_1_8
				})

				return
			end

			if var_1_9:isActivity() and not var_1_9:isRemaster() and not var_1_8:inActTime() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("battle_levelScene_close"))
				self:sendNotification(GAME.TRACKING_ERROR, {
					chapter = var_1_8
				})

				return
			end

			if var_1_8:isTriesLimit() and not var_1_8:enoughTimes2Start() then
				if var_1_8:IsSpChapter() then
					pg.TipsMgr.GetInstance():ShowTips(i18n("sp_no_quota"))
				else
					pg.TipsMgr.GetInstance():ShowTips(i18n("common_elite_no_quota"))
				end

				self:sendNotification(GAME.TRACKING_ERROR, {
					chapter = var_1_8
				})

				return
			end

			if var_1_9:getMapType() == Map.ELITE and not getProxy(DailyLevelProxy):IsEliteEnabled() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_elite_no_quota"))
				self:sendNotification(GAME.TRACKING_ERROR, {
					chapter = var_1_8
				})

				return
			end

			if var_1_8.active then
				pg.TipsMgr.GetInstance():ShowTips(i18n("levelScene_strategying"))
				self:sendNotification(GAME.TRACKING_ERROR, {
					chapter = var_1_8
				})

				return
			end

			if var_1_9:isEscort() and var_1_7.escortChallengeTimes >= var_1_7:getMaxEscortChallengeTimes() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("escort_less_count_to_combat"))
				self:sendNotification(GAME.TRACKING_ERROR, {
					chapter = var_1_8
				})

				return
			end

			arg_2_0()

			return
		end,
		function(arg_3_0)
			if var_1_8:getConfig("type") ~= Chapter.CustomFleet then
				arg_3_0()

				return
			end

			local var_3_0, var_3_1 = var_1_8:IsEliteFleetLegal()

			if var_3_0 then
				arg_3_0()
			else
				pg.TipsMgr.GetInstance():ShowTips(var_3_1)
				self:sendNotification(GAME.TRACKING_ERROR, {
					chapter = var_1_8
				})

				return
			end

			return
		end,
		function(arg_4_0)
			local var_4_0 = var_1_8:getConfig("oil")

			if var_1_8:IsSupportSubmarineStage() and #var_1_8:getSupportFleet() > 0 then
				var_4_0 = var_4_0 + getGameset("submarine_support_oil_consume")[1]
			end

			local var_4_1 = var_4_0 * TrackingCommand.CalculateSpItemMoreCostRate(var_1_3)

			if not getProxy(PlayerProxy):getRawData():isEnough({
				oil = var_4_1
			}) then
				if not ItemTipPanel.ShowOilBuyTip(var_4_1) then
					pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))
				end

				self:sendNotification(GAME.TRACKING_ERROR, {
					chapter = var_1_8
				})
				pg.TrackerMgr.GetInstance():Tracking(TRACKING_STRIKE_FAILD)

				return
			end

			arg_4_0()

			return
		end,
		function(arg_5_0)
			if var_1_8:getConfig("type") == Chapter.SelectFleet then
				var_1_12 = {
					[FleetType.Normal] = {},
					[FleetType.Submarine] = {},
					[FleetType.Support] = Clone(var_1_8.eliteFleetList[FleetType.Support])
				}

				local var_5_0 = false

				for iter_5_0, iter_5_1 in ipairs(var_1_2) do
					local var_5_2 = getProxy(FleetProxy):getFleetById(iter_5_1)
					local var_5_3, var_5_4 = var_5_2:ChangeToElite()

					table.insert(var_1_12[var_5_4], var_5_3)

					if not var_5_0 then
						local var_5_5

						var_5_0, var_5_5 = var_5_2:GetEnergyStatus()
					end
				end
			else
				var_1_12 = var_1_8.eliteFleetList
			end

			var_1_12 = Chapter.PackEliteFleetInfo(var_1_12)

			local var_5_6 = {}

			if hasTiredState then
				table.insert(var_5_6, function(arg_6_0)
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						content = tooltip,
						onYes = arg_6_0
					})

					return
				end)
			end

			seriesAsync(var_5_6, arg_5_0)

			return
		end,
		function(arg_7_0)
			if var_1_9:isRemaster() then
				if PlayerPrefs.GetString("remaster_tip") ~= pg.TimeMgr.GetInstance():CurrentSTimeDesc("%Y/%m/%d") and (not var_1_10 or var_1_10:IsFirstBattle()) then
					local var_7_0 = pg.MsgboxMgr.GetInstance()
					local var_7_1 = {
						showStopRemind = true
					}

					var_7_1.content = i18n("levelScene_activate_remaster_1", getProxy(ChapterProxy):getRemasterTicketCost())

					function var_7_1.onYes()
						if pg.MsgboxMgr.GetInstance().stopRemindToggle.isOn then
							PlayerPrefs.SetString("remaster_tip", pg.TimeMgr.GetInstance():CurrentSTimeDesc("%Y/%m/%d"))
						end

						arg_7_0()

						return
					end

					var_7_0:ShowMsgBox(var_7_1)

					return
				end
			end

			arg_7_0()

			return
		end,
		function(arg_9_0)
			if var_1_8:IsSupportSubmarineStage() and #var_1_8:getSupportFleet() > 0 then
				if var_1_10 then
					arg_9_0()
				else
					local var_9_0 = {}

					var_9_0.content = i18n("submarine_support_oil_consume_tip", getGameset("submarine_support_oil_consume")[1])
					var_9_0.onYes = arg_9_0

					pg.MsgboxMgr.GetInstance():ShowMsgBox(var_9_0)
				end
			else
				arg_9_0()
			end

			return
		end,
		function(arg_10_0)
			local var_10_0 = var_1_8:getConfig("enter_story")

			if var_10_0 and var_10_0 ~= "" and self:isCrossStoryLimit((var_1_8:getConfig("enter_story_limit"))) and not var_1_9:isRemaster() then
				if not pg.NewStoryMgr.GetInstance():IsPlayed(var_10_0) then
					local var_10_1 = tonumber(var_10_0)

					if var_10_1 and var_10_1 > 0 then
						local var_10_2 = getProxy(ContextProxy):getContextByMediator(LevelMediator2)

						if var_10_2 then
							var_10_2.data.pendingEnterChapterId = var_1_1
						end

						self:sendNotification(GAME.BEGIN_STAGE, {
							system = SYSTEM_PERFORM,
							stageId = var_10_1,
							exitCallback = arg_10_0
						})

						return
					else
						ChapterOpCommand.PlayChapterStory(var_10_0, arg_10_0, var_1_8:isLoop() and PlayerPrefs.GetInt("chapter_autofight_flag_" .. var_1_8.id, 1) == 1)

						return
					end
				end
			end

			arg_10_0()

			return
		end,
		function(arg_11_0)
			if var_1_10 then
				local var_11_0 = var_1_10:GetRestBattleTime()
				local var_11_1 = {
					1,
					1,
					2
				}

				if var_1_9:isRemaster() then
					table.insert(var_11_1, 1)
				end

				if var_11_0 > _.reduce(var_11_1, -1, function(arg_12_0, arg_12_1)
					return arg_12_0 + arg_12_1
				end) then
					self:sendNotification(15300, {
						type = 2,
						ver_str = string.format("tracking Chapter %d by CO times %d", var_1_8.id, var_11_0)
					})
				end
			end

			arg_11_0()

			return
		end,
		function(arg_13_0)
			self.chapterId = var_1_1
			self.fleetDatas = var_1_12
			self.loopFlag = var_1_4
			self.operationItem = var_1_3
			self.dutiesKeyValue = var_1_6
			self.autoFightFlag = var_1_0.autoFightFlag

			self:sendProto()

			return
		end
	})

	return
end

function TrackingCommand:sendProto()
	local var_14_0 = self.chapterId
	local var_14_2 = self.operationItem
	local var_14_3 = self.loopFlag
	local var_14_4 = self.autoFightFlag

	pg.ConnectionMgr.GetInstance():Send(13101, {
		id = self.chapterId,
		fleet = self.fleetDatas,
		operation_item = self.operationItem,
		loop_flag = self.loopFlag,
		fleet_duties = self.dutiesKeyValue
	}, 13102, function(arg_15_0)
		if arg_15_0.result == 0 then
			local var_15_0 = getProxy(ChapterProxy)
			local var_15_1 = var_15_0:getChapterById(var_14_0)
			local var_15_2 = var_15_0:getMapById(var_15_1:getConfig("map"))
			local var_15_3 = getProxy(PlayerProxy)
			local var_15_4 = var_15_3:getData()

			var_15_1:update(arg_15_0.current_chapter)

			local var_15_5 = var_15_1:getConfig("oil")

			if var_15_1:IsSupportSubmarineStage() and var_15_1:getChapterSupportFleet() then
				var_15_5 = var_15_5 + getGameset("submarine_support_oil_consume")[1]
			end

			var_15_4:consume({
				oil = var_15_5 * var_15_1:GetExtraCostRate()
			})
			var_15_3:updatePlayer(var_15_4)

			if var_14_2 ~= 0 then
				getProxy(BagProxy):removeItemById(var_14_2, 1)
			end

			for iter_15_0, iter_15_1 in pairs(var_15_1.cells) do
				if ChapterConst.NeedMarkAsLurk(iter_15_1) then
					iter_15_1.trait = ChapterConst.TraitLurk
				end
			end

			for iter_15_2, iter_15_3 in ipairs(var_15_1.champions) do
				iter_15_3.trait = ChapterConst.TraitLurk
			end

			var_15_0:updateChapter(var_15_1)

			if var_15_2:isEscort() then
				var_15_0.escortChallengeTimes = var_15_0.escortChallengeTimes + 1
			end

			if var_15_2:isRemaster() then
				var_15_0:updateRemasterTicketsNum(var_15_0.remasterTickets - var_15_0:getRemasterTicketCost())
			end

			local var_15_6 = var_15_0:GetContinuousData(SYSTEM_SCENARIO)

			if var_15_6 then
				var_15_6:TryActivate()
			end

			self:sendNotification(GAME.TRACKING_DONE, var_15_1)
			getProxy(ChapterProxy):updateExtraFlag(var_15_1, var_15_1:getExtraFlags(), {}, true)

			if var_14_3 ~= 0 and var_14_4 then
				getProxy(ChapterProxy):SetChapterAutoFlag(var_14_0, true)
			end

			return
		end

		if arg_15_0.result == 1 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("levelScene_tracking_error_retry"))
			self:sendNotification(GAME.CHAPTER_OP, {
				type = ChapterConst.OpRetreat
			})
		elseif arg_15_0.result == 3010 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("levelScene_tracking_error_3001"))
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("levelScene_tracking_erro", arg_15_0.result))
		end

		local var_15_7 = getProxy(ChapterProxy)

		self:sendNotification(GAME.TRACKING_ERROR, {
			chapter = var_15_7:getChapterById(var_14_0)
		})

		return
	end)

	return
end

function TrackingCommand:isCrossStoryLimit(arg_16_1)
	return (arg_16_1 ~= "" and #arg_16_1 > 0 or nil) and _.all(arg_16_1, function(arg_17_0)
		if arg_17_0[1] == 1 then
			local var_17_0 = getProxy(TaskProxy):getTaskById(arg_17_0[2])

			return var_17_0 and not var_17_0:isFinish()
		end

		return false
	end)
end

function TrackingCommand:CalculateSpItemMoreCostRate()
	local var_18_0 = 1

	if not self or self == 0 then
		return var_18_0
	end

	for iter_18_0, iter_18_1 in ipairs((_.map(string.split(string.sub(Item.getConfigData(self).usage_arg, 2, -2), ","), function(arg_19_0)
		return tonumber(arg_19_0)
	end))) do
		if pg.benefit_buff_template[iter_18_0] and pg.benefit_buff_template[iter_18_0].benefit_type == Chapter.OPERATION_BUFF_TYPE_COST then
			var_18_0 = var_18_0 + tonumber(pg.benefit_buff_template[iter_18_0].benefit_effect) * 0.01
		end
	end

	return (math.max(1, var_18_0))
end

return TrackingCommand
