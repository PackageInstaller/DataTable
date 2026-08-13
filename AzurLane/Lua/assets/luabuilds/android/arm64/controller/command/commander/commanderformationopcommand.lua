class = var_0_10000

local var_0_0 = "CommanderFormationOPCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().data.FleetType

	getProxy = var_1_10005
	CommanderProxy = var_1_10007

	local var_1_1 = var_1_10005(var_1_10007)

	getProxy = var_1_10006
	ChapterProxy = var_1_10008

	local var_1_2 = var_1_10006(var_1_10008)

	getProxy = var_1_10007
	FleetProxy = var_1_10009

	local var_1_3 = var_1_10007(var_1_10009)
	local var_1_4 = var_3.data.type

	LevelUIConst = var_1_10010

	if var_1_4 == var_1_10010.COMMANDER_OP_RENAME then
		var_1_4 = var_8.id

		local var_1_5 = var_8.str
		local var_1_6 = var_8.onFailed

		var_1_10014 = arg_1_0

		local var_1_7 = arg_1_0.sendNotification

		GAME = var_1_10015

		var_1_7(var_1_10014, var_1_10015.SET_COMMANDER_PREFAB_NAME, {
			id = var_1_4,
			name = var_1_5,
			onFailed = var_1_6
		})

		return
	end

	LevelUIConst = var_1_4

	local var_1_8

	if var_1_0 == var_1_4.FLEET_TYPE_SELECT then
		var_1_8 = var_8.id

		local var_1_9 = var_3.fleetId
		local var_1_10 = var_3.chapterId
		local var_1_11 = var_8.type

		LevelUIConst = var_1_10013

		local var_1_12

		if var_1_11 == var_1_10013.COMMANDER_OP_RECORD_PREFAB then
			var_1_10014 = var_1_3
			var_1_10015 = var_1_3.getFleetById(var_1_10014, var_1_9)
			var_1_12 = var_12.getCommanders(var_1_10015)

			local var_1_13 = arg_1_0

			var_1_10014 = arg_1_0.sendNotification
			GAME = var_1_10017

			var_1_10014(var_1_13, var_1_10017.SET_COMMANDER_PREFAB, {
				id = var_1_8,
				commanders = var_1_12
			})
		else
			local var_1_14 = var_8.type

			LevelUIConst = var_1_12

			if var_1_14 == var_1_12.COMMANDER_OP_USE_PREFAB then
				var_1_10014 = arg_1_0

				local var_1_15 = arg_1_0.sendNotification

				GAME = var_1_10015

				var_1_15(var_1_10014, var_1_10015.USE_COMMANDER_PREFBA, {
					pid = var_1_8,
					fleetId = var_1_9
				})
			else
				local var_1_16 = var_8.type

				LevelUIConst = var_13

				if var_1_16 == var_13.COMMANDER_OP_REST_ALL then
					local var_1_17 = {
						function(arg_2_0)
							local var_2_0 = arg_1_0
							local var_2_1 = var_1.sendNotification

							GAME = var_2_10004

							var_2_1(var_2_0, var_2_10004.COOMMANDER_EQUIP_TO_FLEET, {
								commanderId = 0,
								pos = 1,
								fleetId = var_1_9,
								callback = arg_2_0
							})

							return
						end,
						function(arg_3_0)
							local var_3_0 = arg_1_0
							local var_3_1 = var_1.sendNotification

							GAME = var_2_10004

							var_3_1(var_3_0, var_2_10004.COOMMANDER_EQUIP_TO_FLEET, {
								commanderId = 0,
								pos = 2,
								fleetId = var_1_9,
								callback = arg_3_0
							})

							return
						end
					}

					seriesAsync = var_13

					var_13(var_1_17)
				end
			end
		end
	else
		LevelUIConst = var_1_8

		local var_1_18

		if var_1_0 == var_1_8.FLEET_TYPE_EDIT then
			var_1_18 = var_8.id

			local var_1_19 = var_1_1:getPrefabFleetById(var_1_18)
			local var_1_20 = var_3.index
			local var_1_21 = var_3.chapterId
			local var_1_22 = var_8.type

			LevelUIConst = var_1_10014

			if var_1_22 == var_1_10014.COMMANDER_OP_RECORD_PREFAB then
				var_1_10015 = var_1_2

				local var_1_23 = var_1_2.getChapterById(var_1_10015, var_1_21)

				var_1_10015 = var_13.getEliteFleetCommanders(var_1_23)[var_1_20]
				table = var_1_23

				if var_1_23.getCount(var_1_10015) == 0 then
					return
				end

				local var_1_24 = {}

				for iter_1_2 = 1, 2 do
					iter_1_6 = var_1_10015[iter_1_2]

					if var_1_1:getCommanderById(iter_1_6) then
						var_1_24[iter_1_2] = var_22
					end
				end

				var_1_10019 = arg_1_0

				local var_1_25 = arg_1_0.sendNotification

				GAME = iter_1_2

				var_1_25(var_1_10019, iter_1_2.SET_COMMANDER_PREFAB, {
					id = var_1_18,
					commanders = var_1_24
				})

				var_1_10019 = var_1_2

				var_1_2.updateChapter(var_1_10019, var_13)

				var_1_10019 = arg_1_0

				local var_1_26 = arg_1_0.sendNotification

				GAME = iter_1_2

				var_1_26(var_1_10019, iter_1_2.COMMANDER_ELIT_FORMATION_OP_DONE, {
					chapterId = var_13.id,
					index = var_1_20
				})
			else
				local var_1_27 = var_8.type

				LevelUIConst = var_1_10014

				if var_1_27 == var_1_10014.COMMANDER_OP_USE_PREFAB then
					local var_1_28 = {}

					for iter_1_1 = 1, 2 do
						iter_1_2 = var_1_19

						if var_1_19.getCommanderByPos(iter_1_2, iter_1_1) then
							Commander = var_1_10019
							var_1_10019, iter_1_2 = var_1_10019.canEquipToEliteChapter(var_1_21, var_1_20, iter_1_1, var_1_10018.id)

							if not var_1_10019 then
								pg = iter_1_6
								var_1_10023 = iter_1_6.TipsMgr.GetInstance()

								iter_1_6.ShowTips(var_1_10023, iter_1_2)

								return
							end
						end
					end

					local var_1_29 = var_1_2:getChapterById(var_1_21)
					local var_1_30 = var_1_10014.getEliteFleetCommanders(var_1_29)[var_1_20]

					if var_1_19:isSameId(var_1_30) then
						return
					end

					for iter_1_2 = 1, 2 do
						var_1_10023 = var_1_19

						if var_1_19.getCommanderByPos(var_1_10023, iter_1_2) then
							local var_1_31 = arg_1_0
							local var_1_32 = arg_1_0.sendNotification

							GAME = var_1_10025

							var_1_32(var_1_31, var_1_10025.SELECT_ELIT_CHAPTER_COMMANDER, {
								chapterId = var_1_21,
								index = var_1_20,
								pos = iter_1_2,
								commanderId = iter_1_6.id
							})
						else
							local var_1_33 = arg_1_0
							local var_1_34 = arg_1_0.sendNotification

							GAME = var_1_10025

							var_1_34(var_1_33, var_1_10025.SELECT_ELIT_CHAPTER_COMMANDER, {
								commanderId = 0,
								chapterId = var_1_21,
								index = var_1_20,
								pos = iter_1_2
							})
						end
					end

					local var_1_35 = arg_1_0
					local var_1_36 = arg_1_0.sendNotification

					GAME = iter_1_2

					var_1_36(var_1_35, iter_1_2.COMMANDER_ELIT_FORMATION_OP_DONE, {
						chapterId = var_1_10014.id,
						index = var_1_20
					})
				else
					local var_1_37 = var_8.type

					LevelUIConst = var_1_10014

					if var_1_37 == var_1_10014.COMMANDER_OP_REST_ALL then
						var_1_10015 = var_1_2

						local var_1_38 = var_1_2.getChapterById(var_1_10015, var_1_21)

						for iter_1_3 = 1, 2 do
							iter_1_2 = arg_1_0
							var_1_10018 = arg_1_0.sendNotification
							GAME = iter_1_6

							var_1_10018(iter_1_2, iter_1_6.SELECT_ELIT_CHAPTER_COMMANDER, {
								commanderId = 0,
								chapterId = var_1_21,
								index = var_1_20,
								pos = iter_1_3
							})
						end

						local var_1_39 = arg_1_0

						var_1_10014 = arg_1_0.sendNotification
						GAME = iter_1_3

						var_1_10014(var_1_39, iter_1_3.COMMANDER_ELIT_FORMATION_OP_DONE, {
							chapterId = var_1_38.id,
							index = var_1_20
						})
					end
				end
			end
		else
			LevelUIConst = var_1_18

			local var_1_40

			if var_1_0 == var_1_18.FLEET_TYPE_ACTIVITY then
				var_1_40 = var_8.id

				local var_1_41 = var_1_1:getPrefabFleetById(var_1_40)
				local var_1_42 = var_3.fleetId
				local var_1_43 = var_3.actId
				local var_1_44 = var_8.type

				LevelUIConst = var_1_10014

				if var_1_44 == var_1_10014.COMMANDER_OP_RECORD_PREFAB then
					var_1_10015 = var_1_3

					local var_1_45 = var_1_3.getActivityFleets(var_1_10015)[var_1_43][var_1_42]

					var_1_10014 = var_13.getCommanders(var_1_45)

					local var_1_46 = arg_1_0

					var_1_10015 = arg_1_0.sendNotification
					GAME = var_1_10018

					var_1_10015(var_1_46, var_1_10018.SET_COMMANDER_PREFAB, {
						id = var_1_40,
						commanders = var_1_10014
					})
				else
					local var_1_47 = var_8.type

					LevelUIConst = var_1_10014

					if var_1_47 == var_1_10014.COMMANDER_OP_USE_PREFAB then
						local var_1_48 = {}

						var_1_10014 = var_1_3:getActivityFleets()[var_1_43]
						pg = var_1_10015

						local var_1_49

						if not var_1_10015.activity_template[var_1_43] or not var_1_10015.type then
							var_1_49 = 0
						end

						local function var_1_50(arg_4_0)
							pairs = var_2_10001

							for iter_4_0, iter_4_1 in var_2_10001(var_1_10014) do
								local var_4_0 = var_1_42 ~= iter_4_0
								local var_4_1 = var_1_49

								ActivityConst = var_2_10008

								if var_4_1 ~= var_2_10008.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2 then
									var_4_1 = var_1_49
									ActivityConst = var_2_10008

									if var_4_1 ~= var_2_10008.ACTIVITY_TYPE_BOSSSINGLE then
										var_4_1 = var_1_49
										ActivityConst = var_2_10008

										if var_4_1 == var_2_10008.ACTIVITY_TYPE_BOSSSINGLE_VARIABLE then
											ActivityBossMediatorTemplate = var_4_1
											var_4_0 = iter_4_0 == var_4_1.GetPairedFleetIndex(var_1_42)
										end

										if var_4_0 then
											local var_4_2 = iter_4_1:getCommanders()

											pairs = var_2_10008

											for iter_4_2, iter_4_3 in var_2_10008(var_4_2) do
												if arg_4_0 == iter_4_3.id then
													return iter_4_0, iter_4_2
												end
											end
										end
									end
								end
							end

							return nil
						end

						for iter_1_6 = 1, 2 do
							if var_1_41:getCommanderByPos(iter_1_6) then
								local var_1_51

								var_1_10023, var_1_51 = var_1_50(var_22.id)

								if var_1_10023 and var_1_51 then
									table = var_25

									var_25.insert(var_1_48, function(arg_5_0)
										if var_1_51 == 1 then
											i18n = var_5_0

											local var_5_0

											if not var_5_0("commander_main_pos") then
												i18n = var_5_0
												var_5_0 = var_5_0("commander_assistant_pos")
											end

											Fleet = var_2_10002

											local var_5_1 = var_2_10002.DEFAULT_NAME[var_1_10023]

											pg = var_3

											local var_5_2 = var_3.MsgboxMgr.GetInstance()
											local var_5_3 = var_3.ShowMsgBox
											local var_5_4 = {}

											i18n = var_2_10007
											var_5_4.content = var_2_10007("comander_repalce_tip", var_5_1, var_5_0)

											function var_5_4.onYes()
												local var_6_0 = var_1_10014[var_1_10023]

												var_0.updateCommanderByPos(var_6_0, var_1_51, nil)

												local var_6_1 = var_1_3

												var_1.updateActivityFleet(var_6_1, var_1_43, var_1_10023, var_0)

												local var_6_2 = var_1_10014[var_1_42]

												var_1.updateCommanderByPos(var_6_2, iter_1_6, var_0)

												local var_6_3 = var_1_3

												var_2.updateActivityFleet(var_6_3, var_1_43, var_1_42, var_1)
												arg_5_0()

												return
											end

											var_5_4.onNo = arg_5_0

											var_5_3(var_5_2, var_5_4)

											return
										end
									end)
								else
									table = var_25

									var_25.insert(var_1_48, function(arg_7_0)
										local var_7_0 = var_1_10014[var_1_42]

										var_1.updateCommanderByPos(var_7_0, iter_1_6, var_0)

										local var_7_1 = var_1_3

										var_2.updateActivityFleet(var_7_1, var_1_43, var_1_42, var_1)
										arg_7_0()

										return
									end)
								end
							else
								table = var_1_10023

								var_1_10023.insert(var_1_48, function(arg_8_0)
									local var_8_0 = var_1_10014[var_1_42]

									var_1.updateCommanderByPos(var_8_0, iter_1_6, nil)

									local var_8_1 = var_1_3

									var_2.updateActivityFleet(var_8_1, var_1_43, var_1_42, var_1)
									arg_8_0()

									return
								end)
							end
						end

						seriesAsync = var_1_10018

						var_1_10018(var_1_48, function()
							local var_9_0 = arg_1_0
							local var_9_1 = var_0.sendNotification

							GAME = var_2_10003

							var_9_1(var_9_0, var_2_10003.COMMANDER_ACTIVITY_FORMATION_OP_DONE, {
								actId = var_1_43,
								fleetId = var_1_42
							})

							return
						end)
					else
						local var_1_52 = var_8.type

						LevelUIConst = var_1_10014

						if var_1_52 == var_1_10014.COMMANDER_OP_REST_ALL then
							var_1_10015 = var_1_3

							local var_1_53 = var_1_3.getActivityFleets(var_1_10015)[var_1_43][var_1_42]

							for iter_1_5 = 1, 2 do
								iter_1_2 = var_1_53

								var_1_53.updateCommanderByPos(iter_1_2, iter_1_5, nil)
							end

							var_1_3:updateActivityFleet(var_1_43, var_1_42, var_1_53)

							local var_1_54 = arg_1_0

							var_1_10014 = arg_1_0.sendNotification
							GAME = var_17

							var_1_10014(var_1_54, var_17.COMMANDER_ACTIVITY_FORMATION_OP_DONE, {
								actId = var_1_43,
								fleetId = var_1_42
							})
						end
					end
				end
			else
				LevelUIConst = var_1_40

				local var_1_55

				if var_1_0 == var_1_40.FLEET_TYPE_WORLD then
					var_1_55 = var_8.id

					local var_1_56 = var_1_1:getPrefabFleetById(var_1_55)
					local var_1_57 = var_3.fleets
					local var_1_58 = var_3.fleetType
					local var_1_59 = var_3.fleetIndex

					var_1_10014 = var_1_57[var_1_58][var_1_59]
					Fleet = var_1_10015
					var_1_10015 = var_1_10015.New({
						ship_list = {},
						commanders = var_1_10014.commanders
					})

					local var_1_60 = var_8.type

					LevelUIConst = var_17

					local var_1_63

					if var_1_60 == var_17.COMMANDER_OP_RECORD_PREFAB then
						var_1_10018 = var_1_10015

						local var_1_61 = var_1_10015.getCommanders(var_1_10018)
						local var_1_62 = arg_1_0

						var_1_63 = arg_1_0.sendNotification
						GAME = iter_1_2

						var_1_63(var_1_62, iter_1_2.SET_COMMANDER_PREFAB, {
							id = var_1_55,
							commanders = var_1_61
						})
					else
						local var_1_64 = var_8.type

						LevelUIConst = var_1_63

						local var_1_66

						if var_1_64 == var_1_63.COMMANDER_OP_USE_PREFAB then
							local var_1_65 = {}

							function var_1_66(arg_10_0)
								pairs = var_2_10001

								for iter_10_0, iter_10_1 in var_2_10001(var_1_57) do
									pairs = var_2_10006

									for iter_10_2, iter_10_3 in var_2_10006(iter_10_1) do
										if var_1_10014 ~= iter_10_3 then
											ipairs = var_11

											for iter_10_4, iter_10_5 in var_11(iter_10_3.commanders) do
												if iter_10_5.id == arg_10_0 then
													return iter_10_0, iter_10_2, iter_10_5.pos
												end
											end
										end
									end
								end

								return nil
							end

							for iter_1_6 = 1, 2 do
								if var_1_56:getCommanderByPos(iter_1_6) then
									local var_1_67, var_1_68

									var_1_10023, var_1_67, var_1_68 = var_1_66(var_22.id)

									if var_1_10023 and var_1_67 and var_1_68 then
										table = var_1_10026

										var_1_10026.insert(var_1_65, function(arg_11_0)
											if var_1_68 == 1 then
												i18n = var_11_0

												local var_11_0

												if not var_11_0("commander_main_pos") then
													i18n = var_11_0
													var_11_0 = var_11_0("commander_assistant_pos")
												end

												Fleet = var_2_10002

												local var_11_1 = var_2_10002.DEFAULT_NAME
												local var_11_2 = var_1_67
												local var_11_3 = var_1_10023

												FleetType = var_2_10005

												local var_11_4 = var_11_1[var_11_2 + (var_11_3 == var_2_10005.Submarine and 10 or 0)]

												pg = var_3

												local var_11_5 = var_3.MsgboxMgr.GetInstance()
												local var_11_6 = var_3.ShowMsgBox
												local var_11_7 = {}

												i18n = var_2_10007
												var_11_7.content = var_2_10007("comander_repalce_tip", var_11_4, var_11_0)

												function var_11_7.onYes()
													local var_12_0 = var_1_57[var_1_10023][var_1_67]

													Fleet = var_1

													local var_12_1 = var_1.New({
														ship_list = {},
														commanders = var_12_0.commanders
													})

													var_1.updateCommanderByPos(var_12_1, iter_1_6, nil)

													var_12_0.commanders = var_1:outputCommanders()

													local var_12_2 = var_1_10015

													var_2.updateCommanderByPos(var_12_2, iter_1_6, var_0)

													local var_12_3 = var_1_10014
													local var_12_4 = var_1_10015

													var_12_3.commanders = var_3.outputCommanders(var_12_4)

													arg_11_0()

													return
												end

												var_11_7.onNo = arg_11_0

												var_11_6(var_11_5, var_11_7)

												return
											end
										end)
									else
										table = var_1_10026

										var_1_10026.insert(var_1_65, function(arg_13_0)
											local var_13_0 = var_1_10015

											var_1.updateCommanderByPos(var_13_0, iter_1_6, var_0)

											local var_13_1 = var_1_10014
											local var_13_2 = var_1_10015

											var_13_1.commanders = var_2.outputCommanders(var_13_2)

											arg_13_0()

											return
										end)
									end
								else
									table = var_1_10023

									var_1_10023.insert(var_1_65, function(arg_14_0)
										local var_14_0 = var_1_10015

										var_1.updateCommanderByPos(var_14_0, iter_1_6, nil)

										local var_14_1 = var_1_10014
										local var_14_2 = var_1_10015

										var_14_1.commanders = var_2.outputCommanders(var_14_2)

										arg_14_0()

										return
									end)
								end
							end

							seriesAsync = var_1_10018

							var_1_10018(var_1_65, function()
								local var_15_0 = arg_1_0
								local var_15_1 = var_0.sendNotification

								GAME = var_2_10003

								var_15_1(var_15_0, var_2_10003.COMMANDER_WORLD_FORMATION_OP_DONE, {
									fleet = var_1_10015
								})

								return
							end)
						else
							local var_1_69 = var_8.type

							LevelUIConst = var_1_66

							if var_1_69 == var_1_66.COMMANDER_OP_REST_ALL then
								for iter_1_7 = 1, 2 do
									var_1_10015:updateCommanderByPos(iter_1_7, nil)
								end

								var_1_10018 = var_1_10015
								var_1_10014.commanders = var_1_10015.outputCommanders(var_1_10018)
								var_1_10018 = arg_1_0

								local var_1_70 = arg_1_0.sendNotification

								GAME = iter_1_7

								var_1_70(var_1_10018, iter_1_7.COMMANDER_WORLD_FORMATION_OP_DONE, {
									fleet = var_1_10015
								})
							end
						end
					end
				else
					LevelUIConst = var_1_55

					if var_1_0 == var_1_55.FLEET_TYPE_BOSSRUSH then
						local var_1_71 = var_8.id
						local var_1_72 = var_1_1:getPrefabFleetById(var_1_71)
						local var_1_73 = var_3.fleetId
						local var_1_74 = var_3.actId
						local var_1_75 = var_8.type

						LevelUIConst = var_1_10014

						local var_1_77

						if var_1_75 == var_1_10014.COMMANDER_OP_RECORD_PREFAB then
							var_1_10015 = var_1_3

							local var_1_76 = var_1_3.getActivityFleets(var_1_10015)[var_1_74][var_1_73]

							var_1_77 = var_13.getCommanders(var_1_76)

							local var_1_78 = arg_1_0

							var_1_10015 = arg_1_0.sendNotification
							GAME = var_1_10018

							var_1_10015(var_1_78, var_1_10018.SET_COMMANDER_PREFAB, {
								id = var_1_71,
								commanders = var_1_77
							})
						else
							local var_1_79 = var_8.type

							LevelUIConst = var_1_77

							local var_1_81

							if var_1_79 == var_1_77.COMMANDER_OP_USE_PREFAB then
								local var_1_80 = {}

								var_1_81 = {}
								_ = var_1_10015

								var_1_10015.each(var_3.fleets, function(arg_16_0)
									var_1_81[arg_16_0.id] = arg_16_0

									return
								end)

								local function var_1_82(arg_17_0)
									pairs = var_2_10001

									for iter_17_0, iter_17_1 in var_2_10001(var_1_81) do
										if var_1_73 ~= iter_17_0 then
											local var_17_0 = iter_17_1:getCommanders()

											pairs = var_2_10008

											for iter_17_2, iter_17_3 in var_2_10008(var_17_0) do
												if arg_17_0 == iter_17_3.id then
													return iter_17_0, iter_17_2
												end
											end
										end
									end

									return nil
								end

								for iter_1_8 = 1, 2 do
									if var_1_72:getCommanderByPos(iter_1_8) then
										local var_1_83

										iter_1_6, var_1_83 = var_1_82(var_20.id)

										if iter_1_6 and var_1_83 then
											table = var_23

											var_23.insert(var_1_80, function(arg_18_0)
												if var_1_83 == 1 then
													i18n = var_18_0

													local var_18_0

													if not var_18_0("commander_main_pos") then
														i18n = var_18_0
														var_18_0 = var_18_0("commander_assistant_pos")
													end

													table = var_2_10002

													local var_18_1 = var_2_10002.indexof(var_0.fleets, var_1_81[iter_1_6])

													Fleet = var_2_10003

													local var_18_2 = var_2_10003.DEFAULT_NAME[var_18_1]

													pg = var_4

													local var_18_3 = var_4.MsgboxMgr.GetInstance()
													local var_18_4 = var_4.ShowMsgBox
													local var_18_5 = {}

													i18n = var_2_10008
													var_18_5.content = var_2_10008("comander_repalce_tip", var_18_2, var_18_0)

													function var_18_5.onYes()
														local var_19_0 = var_1_81[iter_1_6]

														var_0.updateCommanderByPos(var_19_0, var_1_83, nil)

														local var_19_1 = var_1_3

														var_1.updateActivityFleet(var_19_1, var_1_74, iter_1_6, var_0)

														local var_19_2 = var_1_81[var_1_73]

														var_1.updateCommanderByPos(var_19_2, iter_1_8, var_0)

														local var_19_3 = var_1_3

														var_2.updateActivityFleet(var_19_3, var_1_74, var_1_73, var_1)
														arg_18_0()

														return
													end

													var_18_5.onNo = arg_18_0

													var_18_4(var_18_3, var_18_5)

													return
												end
											end)
										else
											table = var_23

											var_23.insert(var_1_80, function(arg_20_0)
												local var_20_0 = var_1_81[var_1_73]

												var_1.updateCommanderByPos(var_20_0, iter_1_8, var_0)

												local var_20_1 = var_1_3

												var_2.updateActivityFleet(var_20_1, var_1_74, var_1_73, var_1)
												arg_20_0()

												return
											end)
										end
									else
										table = iter_1_6

										iter_1_6.insert(var_1_80, function(arg_21_0)
											local var_21_0 = var_1_81[var_1_73]

											var_1.updateCommanderByPos(var_21_0, iter_1_8, nil)

											local var_21_1 = var_1_3

											var_2.updateActivityFleet(var_21_1, var_1_74, var_1_73, var_1)
											arg_21_0()

											return
										end)
									end
								end

								seriesAsync = var_16

								var_16(var_1_80, function()
									local var_22_0 = arg_1_0
									local var_22_1 = var_0.sendNotification

									GAME = var_2_10003

									var_22_1(var_22_0, var_2_10003.COMMANDER_ACTIVITY_FORMATION_OP_DONE, {
										actId = var_1_74,
										fleetId = var_1_73
									})

									return
								end)
							else
								local var_1_84 = var_8.type

								LevelUIConst = var_1_81

								if var_1_84 == var_1_81.COMMANDER_OP_REST_ALL then
									local var_1_85 = var_1_3:getActivityFleets()[var_1_74][var_1_73]

									for iter_1_9 = 1, 2 do
										var_1_85:updateCommanderByPos(iter_1_9, nil)
									end

									var_1_3:updateActivityFleet(var_1_74, var_1_73, var_1_85)

									local var_1_86 = arg_1_0
									local var_1_87 = arg_1_0.sendNotification

									GAME = var_17

									var_1_87(var_1_86, var_17.COMMANDER_ACTIVITY_FORMATION_OP_DONE, {
										actId = var_1_74,
										fleetId = var_1_73
									})
								end
							end
						end
					end
				end
			end
		end
	end

	return
end

return var_0_1
