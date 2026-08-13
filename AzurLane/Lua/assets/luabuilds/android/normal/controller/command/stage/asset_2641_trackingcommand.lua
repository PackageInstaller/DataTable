class = var_0_10000

local var_0_0 = "TrackingCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().chapterId
	local var_1_1 = var_2.fleetIds
	local var_1_2

	if not var_2.operationItem then
		var_1_2 = 0
	end

	local var_1_3

	if not var_2.loopFlag then
		var_1_3 = 0
	end

	local var_1_4

	if not var_2.duties or var_1_3 == 0 then
		var_1_4 = {}
	end

	local var_1_5 = {}

	ipairs = var_1_10009

	for iter_1_0, iter_1_1 in var_1_10009(var_1_4) do
		table = var_1_10014

		var_1_10014.insert(var_1_5, {
			key = iter_1_0,
			value = iter_1_1
		})
	end

	getProxy = var_9
	ChapterProxy = var_10

	local var_1_6 = var_9(var_10)
	local var_1_7 = var_9.getChapterById(var_1_6, var_1_0)

	var_1_7.loopFlag = var_1_3

	local var_1_8 = var_9
	local var_1_9 = var_9.getMapById
	local var_1_10 = var_1_7
	local var_1_11 = var_1_9(var_1_8, var_1_7.getConfig(var_1_10, "map"))
	local var_1_12 = var_9
	local var_1_13 = var_9.GetContinuousData

	SYSTEM_SCENARIO = var_1_10

	local var_1_14 = var_1_13(var_1_12, var_1_10)
	local var_1_15 = var_9:getRemasterTicketCost()
	local var_1_16

	seriesAsync = var_15

	var_15({
		function(arg_2_0)
			local var_2_0 = var_1_11

			if var_1.isRemaster(var_2_0) and var_0.remasterTickets < var_1_15 then
				pg = var_1

				local var_2_1 = var_1.TipsMgr.GetInstance()
				local var_2_2 = var_1.ShowTips

				i18n = var_2_10003

				var_2_2(var_2_1, var_2_10003("levelScene_remaster_tickets_not_enough"))

				local var_2_3 = arg_1_0
				local var_2_4 = var_1.sendNotification

				GAME = var_2_10003

				var_2_4(var_2_3, var_2_10003.TRACKING_ERROR, {
					chapter = var_1_7
				})

				return
			end

			local var_2_5 = var_1_11

			if var_1.isActivity(var_2_5) then
				local var_2_6 = var_1_11

				if not var_1.isRemaster(var_2_6) then
					local var_2_7 = var_1_7

					if not var_1.inActTime(var_2_7) then
						pg = var_1

						local var_2_8 = var_1.TipsMgr.GetInstance()
						local var_2_9 = var_1.ShowTips

						i18n = var_2_10003

						var_2_9(var_2_8, var_2_10003("battle_levelScene_close"))

						local var_2_10 = arg_1_0
						local var_2_11 = var_1.sendNotification

						GAME = var_2_10003

						var_2_11(var_2_10, var_2_10003.TRACKING_ERROR, {
							chapter = var_1_7
						})

						return
					end
				end
			end

			local var_2_12 = var_1_7
			local var_2_13

			if var_1.isTriesLimit(var_2_12) then
				var_2_12 = var_1_7

				if not var_2_13.enoughTimes2Start(var_2_12) then
					var_2_12 = var_1_7

					if var_2_13.IsSpChapter(var_2_12) then
						pg = var_2_13
						var_2_12 = var_2_13.TipsMgr.GetInstance()
						var_2_13 = var_2_13.ShowTips
						i18n = var_2_10003

						var_2_13(var_2_12, var_2_10003("sp_no_quota"))
					else
						pg = var_2_13
						var_2_12 = var_2_13.TipsMgr.GetInstance()
						var_2_13 = var_2_13.ShowTips
						i18n = var_2_10003

						var_2_13(var_2_12, var_2_10003("common_elite_no_quota"))
					end

					var_2_12 = arg_1_0
					var_2_13 = var_2_13.sendNotification
					GAME = var_2_10003

					var_2_13(var_2_12, var_2_10003.TRACKING_ERROR, {
						chapter = var_1_7
					})

					return
				end
			end

			getProxy = var_2_13
			DailyLevelProxy = var_2_12

			local var_2_14 = var_2_13(var_2_12)
			local var_2_15 = var_1_11
			local var_2_16 = var_2.getMapType(var_2_15)

			Map = var_2_15

			if var_2_16 == var_2_15.ELITE and not var_2_14:IsEliteEnabled() then
				pg = var_2

				local var_2_17 = var_2.TipsMgr.GetInstance()
				local var_2_18 = var_2.ShowTips

				i18n = var_2_10004

				var_2_18(var_2_17, var_2_10004("common_elite_no_quota"))

				local var_2_19 = arg_1_0
				local var_2_20 = var_2.sendNotification

				GAME = var_2_10004

				var_2_20(var_2_19, var_2_10004.TRACKING_ERROR, {
					chapter = var_1_7
				})

				return
			end

			if var_1_7.active then
				pg = var_2

				local var_2_21 = var_2.TipsMgr.GetInstance()
				local var_2_22 = var_2.ShowTips

				i18n = var_2_10004

				var_2_22(var_2_21, var_2_10004("levelScene_strategying"))

				local var_2_23 = arg_1_0
				local var_2_24 = var_2.sendNotification

				GAME = var_4

				var_2_24(var_2_23, var_4.TRACKING_ERROR, {
					chapter = var_1_7
				})

				return
			end

			local var_2_25 = var_1_11

			if var_2.isEscort(var_2_25) then
				local var_2_26 = var_0.escortChallengeTimes
				local var_2_27 = var_0

				if var_2_26 >= var_3.getMaxEscortChallengeTimes(var_2_27) then
					pg = var_2_26

					local var_2_28 = var_2_26.TipsMgr.GetInstance()
					local var_2_29 = var_2.ShowTips

					i18n = var_2_27

					var_2_29(var_2_28, var_2_27("escort_less_count_to_combat"))

					local var_2_30 = arg_1_0
					local var_2_31 = var_2.sendNotification

					GAME = var_4

					var_2_31(var_2_30, var_4.TRACKING_ERROR, {
						chapter = var_1_7
					})

					return
				end
			end

			arg_2_0()

			return
		end,
		function(arg_3_0)
			local var_3_0 = var_1_7
			local var_3_1 = var_1.getConfig(var_3_0, "type")

			Chapter = var_3_0

			if var_3_1 ~= var_3_0.CustomFleet then
				arg_3_0()

				return
			end

			local var_3_2 = var_1_7
			local var_3_3, var_3_4 = var_1.IsEliteFleetLegal(var_3_2)

			if var_3_3 then
				arg_3_0()
			else
				pg = var_3

				local var_3_5 = var_3.TipsMgr.GetInstance()

				var_3.ShowTips(var_3_5, var_3_4)

				local var_3_6 = arg_1_0
				local var_3_7 = var_3.sendNotification

				GAME = var_5

				var_3_7(var_3_6, var_5.TRACKING_ERROR, {
					chapter = var_1_7
				})

				return
			end

			return
		end,
		function(arg_4_0)
			local var_4_0 = var_1_7
			local var_4_1 = var_1.getConfig(var_4_0, "oil")
			local var_4_2 = var_1_7

			if var_2.IsSupportSubmarineStage(var_4_2) then
				local var_4_3 = var_1_7

				if #var_2.getSupportFleet(var_4_3) > 0 then
					getGameset = var_2
					var_4_1 = var_4_1 + var_2("submarine_support_oil_consume")[1]
				end
			end

			local var_4_4 = var_4_1 * var_0_1.CalculateSpItemMoreCostRate(var_1_2)

			getProxy = var_2
			PlayerProxy = var_3

			local var_4_5 = var_2(var_3)
			local var_4_6 = var_2.getRawData(var_4_5)

			if not var_3.isEnough(var_4_6, {
				oil = var_4_4
			}) then
				ItemTipPanel = var_4

				if not var_4.ShowOilBuyTip(var_4_4) then
					pg = var_4

					local var_4_7 = var_4.TipsMgr.GetInstance()
					local var_4_8 = var_4.ShowTips

					i18n = var_6

					var_4_8(var_4_7, var_6("common_no_resource"))
				end

				local var_4_9 = arg_1_0
				local var_4_10 = var_4.sendNotification

				GAME = var_6

				var_4_10(var_4_9, var_6.TRACKING_ERROR, {
					chapter = var_1_7
				})

				pg = var_4_10

				local var_4_11 = var_4_10.TrackerMgr.GetInstance()
				local var_4_12 = var_4.Tracking

				TRACKING_STRIKE_FAILD = var_6

				var_4_12(var_4_11, var_6)

				return
			end

			arg_4_0()

			return
		end,
		function(arg_5_0)
			local var_5_0 = var_1_7
			local var_5_1 = var_1.getConfig(var_5_0, "type")

			Chapter = var_5_0

			if var_5_1 == var_5_0.SelectFleet then
				var_5_1 = {}
				FleetType = var_2
				var_5_1[var_2.Normal] = {}
				FleetType = var_2
				var_5_1[var_2.Submarine] = {}
				FleetType = var_2

				local var_5_2 = var_2.Support

				Clone = var_3

				local var_5_3 = var_1_7.eliteFleetList

				FleetType = var_2_10005
				var_5_1[var_5_2] = var_3(var_5_3[var_2_10005.Support])
				var_1_16 = var_5_1
				var_5_1 = false

				local var_5_4 = ""

				ipairs = var_3

				for iter_5_0, iter_5_1 in var_3(var_1_1) do
					getProxy = var_2_10008
					FleetProxy = var_2_10009
					var_2_10009 = var_2_10008(var_2_10009)

					local var_5_5 = var_2_10008.getFleetById(var_2_10009, iter_5_1)
					local var_5_6

					var_2_10009, var_5_6 = var_2_10008.ChangeToElite(var_5_5)
					table = var_2_10011

					var_2_10011.insert(var_1_16[var_5_6], var_2_10009)

					if not var_5_1 then
						local var_5_7

						var_2_10011, var_5_7 = var_2_10008:GetEnergyStatus()

						local var_5_8 = var_5_7

						var_5_1 = var_2_10011
					end
				end
			else
				var_1_16 = var_1_7.eliteFleetList
			end

			Chapter = var_5_1
			var_1_16 = var_5_1.PackEliteFleetInfo(var_1_16)

			local var_5_9 = {}

			hasTiredState = var_2

			if var_2 then
				table = var_2

				var_2.insert(var_5_9, function(arg_6_0)
					pg = var_3_10001

					local var_6_0 = var_3_10001.MsgboxMgr.GetInstance()
					local var_6_1 = var_1.ShowMsgBox
					local var_6_2 = {}

					tooltip = var_3_10004
					var_6_2.content = var_3_10004
					var_6_2.onYes = arg_6_0

					var_6_1(var_6_0, var_6_2)

					return
				end)
			end

			seriesAsync = var_2

			var_2(var_5_9, arg_5_0)

			return
		end,
		function(arg_7_0)
			local var_7_0 = var_1_11

			if var_1.isRemaster(var_7_0) then
				PlayerPrefs = var_1

				local var_7_1 = var_1.GetString("remaster_tip")

				pg = var_2

				local var_7_2 = var_2.TimeMgr.GetInstance()

				if var_7_1 ~= var_2.CurrentSTimeDesc(var_7_2, "%Y/%m/%d") then
					if var_1_14 then
						local var_7_3 = var_1_14

						if var_1.IsFirstBattle(var_7_3) then
							pg = var_1

							local var_7_4 = var_1.MsgboxMgr.GetInstance()
							local var_7_5 = var_1.ShowMsgBox
							local var_7_6 = {
								showStopRemind = true
							}

							i18n = var_4

							local var_7_7 = "levelScene_activate_remaster_1"

							getProxy = var_2_10006
							ChapterProxy = var_2_10007

							local var_7_8 = var_2_10006(var_2_10007)

							var_7_6.content = var_4(var_7_7, var_6.getRemasterTicketCost(var_7_8))

							function var_7_6.onYes()
								pg = var_3_10000

								if var_3_10000.MsgboxMgr.GetInstance().stopRemindToggle.isOn then
									PlayerPrefs = var_0

									local var_8_0 = var_0.SetString
									local var_8_1 = "remaster_tip"

									pg = var_3_10002

									local var_8_2 = var_3_10002.TimeMgr.GetInstance()

									var_8_0(var_8_1, var_2.CurrentSTimeDesc(var_8_2, "%Y/%m/%d"))
								end

								arg_7_0()

								return
							end

							var_7_5(var_7_4, var_7_6)

							return
						end

						arg_7_0()

						return
					end
				end
			end
		end,
		function(arg_9_0)
			local var_9_0 = var_1_7

			if var_1.IsSupportSubmarineStage(var_9_0) then
				local var_9_1 = var_1_7

				if #var_1.getSupportFleet(var_9_1) > 0 then
					if var_1_14 then
						arg_9_0()
					else
						getGameset = var_1

						local var_9_2 = var_1("submarine_support_oil_consume")[1]

						pg = var_2

						local var_9_3 = var_2.MsgboxMgr.GetInstance()
						local var_9_4 = var_2.ShowMsgBox
						local var_9_5 = {}

						i18n = var_2_10005
						var_9_5.content = var_2_10005("submarine_support_oil_consume_tip", var_9_2)
						var_9_5.onYes = arg_9_0

						var_9_4(var_9_3, var_9_5)
					end

					goto label_9_0
				end
			end

			arg_9_0()

			::label_9_0::

			return
		end,
		function(arg_10_0)
			local var_10_0 = var_1_7
			local var_10_1 = var_1.getConfig(var_10_0, "enter_story")
			local var_10_2 = var_1_7
			local var_10_3 = var_2.getConfig(var_10_2, "enter_story_limit")

			if var_10_1 and var_10_1 ~= "" then
				local var_10_4 = arg_1_0

				if var_3.isCrossStoryLimit(var_10_4, var_10_3) then
					local var_10_5 = var_1_11

					if not var_3.isRemaster(var_10_5) then
						pg = var_3

						local var_10_6 = var_3.NewStoryMgr.GetInstance()

						if not var_3.IsPlayed(var_10_6, var_10_1) then
							tonumber = var_10_6

							local var_10_8

							if var_10_6(var_10_1) and 0 < var_4 then
								getProxy = var_10_8
								ContextProxy = var_2_10006

								local var_10_7 = var_10_8(var_2_10006)

								var_10_8 = var_10_8.getContextByMediator
								LevelMediator2 = var_2_10007

								if var_10_8(var_10_7, var_2_10007) then
									var_10_8.data.pendingEnterChapterId = var_1_0
								end

								local var_10_9 = arg_1_0
								local var_10_10 = var_6.sendNotification

								GAME = var_2_10008

								local var_10_11 = var_2_10008.BEGIN_STAGE
								local var_10_12 = {}

								SYSTEM_PERFORM = var_2_10010
								var_10_12.system = var_2_10010
								var_10_12.stageId = var_4
								var_10_12.exitCallback = arg_10_0

								var_10_10(var_10_9, var_10_11, var_10_12)

								return
							else
								ChapterOpCommand = var_10_8

								local var_10_13 = var_10_8.PlayChapterStory
								local var_10_14 = var_10_1
								local var_10_15 = arg_10_0
								local var_10_16 = var_1_7
								local var_10_17

								if var_8.isLoop(var_10_16) then
									PlayerPrefs = var_10_17
									var_10_17 = var_10_17.GetInt("chapter_autofight_flag_" .. var_1_7.id, 1) == 1
								end

								var_10_13(var_10_14, var_10_15, var_10_17)

								return
							end
						end
					end
				end
			end

			arg_10_0()

			return
		end,
		function(arg_11_0)
			if var_1_14 then
				local var_11_0 = var_1_14
				local var_11_1 = var_1.GetRestBattleTime(var_11_0)
				local var_11_2 = {
					1,
					1,
					2
				}
				local var_11_3 = var_1_11

				if var_3.isRemaster(var_11_3) then
					table = var_3

					var_3.insert(var_11_2, 1)
				end

				_ = var_3

				if var_11_1 > var_3.reduce(var_11_2, -1, function(arg_12_0, arg_12_1)
					return arg_12_0 + arg_12_1
				end) then
					local var_11_4 = arg_1_0
					local var_11_5 = var_4.sendNotification
					local var_11_6 = 15300
					local var_11_7 = {
						type = 2
					}

					string = var_2_10008
					var_11_7.ver_str = var_2_10008.format("tracking Chapter %d by CO times %d", var_1_7.id, var_11_1)

					var_11_5(var_11_4, var_11_6, var_11_7)
				end
			end

			arg_11_0()

			return
		end,
		function(arg_13_0)
			arg_1_0.chapterId = var_1_0
			arg_1_0.fleetDatas = var_1_16
			arg_1_0.loopFlag = var_1_3
			arg_1_0.operationItem = var_1_2
			arg_1_0.dutiesKeyValue = var_1_5
			arg_1_0.autoFightFlag = var_0.autoFightFlag

			local var_13_0 = arg_1_0

			var_1.sendProto(var_13_0)

			return
		end
	})

	return
end

function var_0_1.sendProto(arg_14_0)
	local var_14_0 = arg_14_0.chapterId
	local var_14_1 = arg_14_0.fleetIds
	local var_14_2 = arg_14_0.fleetDatas
	local var_14_3 = arg_14_0.operationItem
	local var_14_4 = arg_14_0.loopFlag
	local var_14_5 = arg_14_0.dutiesKeyValue
	local var_14_6 = arg_14_0.autoFightFlag

	pg = var_1_10008

	local var_14_7 = var_1_10008.ConnectionMgr.GetInstance()

	var_8.Send(var_14_7, 13101, {
		id = var_14_0,
		fleet = var_14_2,
		operation_item = var_14_3,
		loop_flag = var_14_4,
		fleet_duties = var_14_5
	}, 13102, function(arg_15_0)
		if arg_15_0.result == 0 then
			getProxy = var_1
			ChapterProxy = var_2_10002
			var_2_10003 = var_1(var_2_10002)
			var_2_10002 = var_1.getChapterById(var_2_10003, var_14_0)

			local var_15_0 = var_1

			var_2_10003 = var_1.getMapById(var_15_0, var_2_10002:getConfig("map"))
			getProxy = var_15_0
			PlayerProxy = var_2_10005

			local var_15_1 = var_15_0(var_2_10005)

			var_2_10005 = var_4.getData(var_15_1)

			var_2_10002:update(arg_15_0.current_chapter)

			local var_15_2 = var_2_10002:getConfig("oil")

			if var_2_10002:IsSupportSubmarineStage() and var_2_10002:getChapterSupportFleet() then
				getGameset = var_7
				var_15_2 = var_15_2 + var_7("submarine_support_oil_consume")[1]
			end

			var_2_10005:consume({
				oil = var_15_2 * var_2_10002:GetExtraCostRate()
			})

			local var_15_3 = var_4

			var_4.updatePlayer(var_15_3, var_2_10005)

			if var_14_3 ~= 0 then
				getProxy = var_7
				BagProxy = var_15_3

				local var_15_4 = var_7(var_15_3)

				var_7.removeItemById(var_15_4, var_14_3, 1)
			end

			pairs = var_7

			for iter_15_0, iter_15_1 in var_7(var_2_10002.cells) do
				ChapterConst = var_2_10012

				if var_2_10012.NeedMarkAsLurk(iter_15_1) then
					ChapterConst = var_2_10012
					iter_15_1.trait = var_2_10012.TraitLurk
				end
			end

			ipairs = var_7

			for iter_15_2, iter_15_3 in var_7(var_2_10002.champions) do
				ChapterConst = var_2_10012
				iter_15_3.trait = var_2_10012.TraitLurk
			end

			var_1:updateChapter(var_2_10002)

			if var_2_10003:isEscort() then
				var_1.escortChallengeTimes = var_1.escortChallengeTimes + 1
			end

			if var_2_10003:isRemaster() then
				var_1:updateRemasterTicketsNum(var_1.remasterTickets - var_1:getRemasterTicketCost())
			end

			local var_15_5 = var_1
			local var_15_6 = var_1.GetContinuousData

			SYSTEM_SCENARIO = var_9

			if var_15_6(var_15_5, var_9) then
				var_7:TryActivate()
			end

			local var_15_7 = arg_14_0
			local var_15_8 = var_8.sendNotification

			GAME = iter_15_2

			var_15_8(var_15_7, iter_15_2.TRACKING_DONE, var_2_10002)

			getProxy = var_15_8
			ChapterProxy = var_15_7

			local var_15_9 = var_15_8(var_15_7)

			var_8.updateExtraFlag(var_15_9, var_2_10002, var_2_10002:getExtraFlags(), {}, true)

			if var_14_4 ~= 0 and var_14_6 then
				getProxy = var_8
				ChapterProxy = var_15_9

				local var_15_10 = var_8(var_15_9)

				var_8.SetChapterAutoFlag(var_15_10, var_14_0, true)
			end

			return
		end

		local var_15_11

		if arg_15_0.result == 1 then
			pg = var_15_11
			var_2_10002 = var_15_11.TipsMgr.GetInstance()
			var_15_11 = var_15_11.ShowTips
			i18n = var_2_10003

			var_15_11(var_2_10002, var_2_10003("levelScene_tracking_error_retry"))

			var_2_10002 = arg_14_0
			var_15_11 = var_15_11.sendNotification
			GAME = var_2_10003
			var_2_10003 = var_2_10003.CHAPTER_OP

			local var_15_12 = {}

			ChapterConst = var_2_10005
			var_15_12.type = var_2_10005.OpRetreat

			var_15_11(var_2_10002, var_2_10003, var_15_12)
		elseif arg_15_0.result == 3010 then
			pg = var_15_11
			var_2_10002 = var_15_11.TipsMgr.GetInstance()
			var_15_11 = var_15_11.ShowTips
			i18n = var_2_10003

			var_15_11(var_2_10002, var_2_10003("levelScene_tracking_error_3001"))
		else
			pg = var_15_11
			var_2_10002 = var_15_11.TipsMgr.GetInstance()
			var_15_11 = var_15_11.ShowTips
			errorTip = var_2_10003

			var_15_11(var_2_10002, var_2_10003("levelScene_tracking_erro", arg_15_0.result))
		end

		getProxy = var_15_11
		ChapterProxy = var_2_10002

		local var_15_13 = var_15_11(var_2_10002)
		local var_15_14 = var_1.getChapterById(var_15_13, var_14_0)
		local var_15_15 = arg_14_0
		local var_15_16 = var_3.sendNotification

		GAME = var_2_10005

		var_15_16(var_15_15, var_2_10005.TRACKING_ERROR, {
			chapter = var_15_14
		})

		return
	end)

	return
end

function var_0_1.isCrossStoryLimit(arg_16_0, arg_16_1)
	local var_16_0 = true

	if arg_16_1 ~= "" and #arg_16_1 > 0 then
		_ = var_3
		var_16_0 = var_3.all(arg_16_1, function(arg_17_0)
			if arg_17_0[1] == 1 then
				getProxy = var_1
				TaskProxy = var_2_10002

				local var_17_0 = var_1(var_2_10002)
				local var_17_1

				var_17_1 = var_1.getTaskById(var_17_0, arg_17_0[2]) and not var_2:isFinish()

				return var_17_1
			end

			return false
		end)
	end

	return var_16_0
end

function var_0_1.CalculateSpItemMoreCostRate(arg_18_0)
	local var_18_0 = 1

	if not arg_18_0 or arg_18_0 == 0 then
		return var_18_0
	end

	Item = var_1_10002

	local var_18_1 = var_1_10002.getConfigData(arg_18_0).usage_arg

	_ = var_3

	local var_18_2 = var_3.map

	string = var_1_10004

	local var_18_3 = var_1_10004.split

	string = var_1_10005

	local var_18_4 = var_18_2(var_18_3(var_1_10005.sub(var_18_1, 2, -2), ","), function(arg_19_0)
		tonumber = var_2_10001

		return var_2_10001(arg_19_0)
	end)

	ipairs = var_4

	for iter_18_0, iter_18_1 in var_4(var_18_4) do
		pg = var_1_10009

		if var_1_10009.benefit_buff_template[iter_18_0] then
			local var_18_5 = var_1_10009.benefit_type

			Chapter = var_1_10011

			if var_18_5 == var_1_10011.OPERATION_BUFF_TYPE_COST then
				tonumber = var_18_5
				var_18_0 = var_18_0 + var_18_5(var_1_10009.benefit_effect) * 0.01
			end
		end
	end

	math = var_4

	return (var_4.max(1, var_18_0))
end

return var_0_1
