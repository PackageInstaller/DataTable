class = var_0_10000

local var_0_0 = "TaskGoCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).taskVO

	getProxy = var_1_0
	ChapterProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)

	if var_1_1:getConfig("scene") then
		var_1_10006 = #var_5

		if 0 < var_1_10006 then
			if var_5[1] == "ACTIVITY_MAP" then
				var_1_10006 = {}

				if var_5[2] then
					table = var_7

					var_7.insert(var_1_10006, function(arg_2_0)
						getProxy = var_2_10001
						ActivityProxy = var_2_10003

						local var_2_0 = var_2_10001(var_2_10003)

						underscore = var_2_10002

						if var_2_10002.any(var_0[2], function(arg_3_0)
							local var_3_0 = var_2_0

							return var_1.getActivityById(var_3_0, arg_3_0) and not var_1:isEnd()
						end) then
							arg_2_0()
						else
							pg = var_2

							local var_2_1 = var_2.TipsMgr.GetInstance()
							local var_2_2 = var_2.ShowTips

							i18n = var_5

							var_2_2(var_2_1, var_5("common_activity_notStartOrEnd"))
						end

						return
					end)
				end

				table = var_7

				var_7.insert(var_1_10006, function(arg_4_0)
					local var_4_0 = var_1_2
					local var_4_1, var_4_2 = var_1.getLastMapForActivity(var_4_0)

					if var_4_1 then
						local var_4_3 = var_1_2
						local var_4_4 = var_4_0.getMapById(var_4_3, var_4_1)

						if var_4_0.isUnlock(var_4_4) then
							arg_4_0(var_4_1, var_4_2)

							goto label_4_0
						end
					end

					pg = var_4_0

					do
						local var_4_5 = var_4_0.TipsMgr.GetInstance()
						local var_4_6 = var_3.ShowTips

						i18n = var_2_10006

						var_4_6(var_4_5, var_2_10006("common_activity_notStartOrEnd"))
					end

					::label_4_0::

					return
				end)

				seriesAsync = var_7

				var_7(var_1_10006, function(arg_5_0, arg_5_1)
					pg = var_2_10002

					local var_5_0 = var_2_10002.m02
					local var_5_1 = var_2.sendNotification

					GAME = var_2_10005

					local var_5_2 = var_2_10005.GO_SCENE

					SCENE = var_2_10006

					var_5_1(var_5_0, var_5_2, var_2_10006.LEVEL, {
						chapterId = arg_5_1,
						mapIdx = arg_5_0
					})

					return
				end)
			else
				local var_1_3

				if var_5[1] == "HARD_MAP" then
					var_1_3 = var_1_2
					var_1_10006 = var_1_2.getUseableMaxEliteMap(var_1_3)
					pg = var_7
					var_1_10009 = var_7.m02

					local var_1_4 = var_7.sendNotification

					GAME = var_1_10010
					var_1_10010 = var_1_10010.GO_SCENE
					SCENE = var_1_10011

					var_1_4(var_1_10009, var_1_10010, var_1_10011.LEVEL, {
						mapIdx = var_1_10006 and var_1_10006.id
					})
				else
					SCENE = var_1_10006
					var_1_10006 = var_1_10006[var_5[1]]
					SCENE = var_7

					if var_1_10006 == var_7.LEVEL and var_5[2] then
						var_1_10006 = {}

						if var_5[2].mapIdx then
							table = var_1_6

							var_1_6.insert(var_1_10006, function(arg_6_0)
								local var_6_0 = var_1_2
								local var_6_1 = var_1.getMapById(var_6_0, var_0[2].mapIdx)
								local var_6_2, var_6_3 = var_1.isUnlock(var_6_1)

								if var_6_2 then
									arg_6_0()
								else
									pg = var_6_1

									local var_6_4 = var_6_1.TipsMgr.GetInstance()

									var_4.ShowTips(var_6_4, var_6_3)
								end

								return
							end)
						end

						if var_5[2].chapterId then
							table = var_1_6

							var_1_6.insert(var_1_10006, function(arg_7_0)
								local var_7_0 = var_1_2
								local var_7_1 = var_1.getChapterById(var_7_0, var_0[2].chapterId)

								if var_1.isUnlock(var_7_1) then
									arg_7_0()
								else
									pg = var_2

									local var_7_2 = var_2.TipsMgr.GetInstance()
									local var_7_3 = var_2.ShowTips

									i18n = var_2_10005

									var_7_3(var_7_2, var_2_10005("battle_levelScene_chapter_lock"))
								end

								return
							end)
						end

						seriesAsync = var_1_6

						var_1_6(var_1_10006, function()
							local var_8_0 = arg_1_0
							local var_8_1 = var_0.sendNotification

							GAME = var_2_10003

							local var_8_2 = var_2_10003.GO_SCENE

							SCENE = var_2_10004

							var_8_1(var_8_0, var_8_2, var_2_10004[var_0[1]], var_0[2])

							return
						end)
					elseif var_5[1] == "MINI_GAME" and var_5[2] then
						var_1_3 = arg_1_0
						var_1_10006 = arg_1_0.sendNotification
						GAME = var_1_10009

						var_1_10006(var_1_3, var_1_10009.GO_MINI_GAME, var_5[2])
					elseif var_5[2] and var_5[2].unlockActivityID then
						getProxy = var_1_10006
						ActivityProxy = var_1_3

						local var_1_5 = var_1_10006(var_1_3)
						local var_1_6

						if var_1_10006.getActivityById(var_1_5, var_5[2].unlockActivityID) then
							var_1_10009 = var_1_10006

							if not var_1_10006.isEnd(var_1_10009) then
								var_1_10009 = arg_1_0
								var_1_6 = arg_1_0.sendNotification
								GAME = var_1_10010
								var_1_10010 = var_1_10010.GO_SCENE
								SCENE = var_1_10011

								var_1_6(var_1_10009, var_1_10010, var_1_10011[var_5[1]], var_5[2])

								goto label_1_0
							end
						end

						pg = var_1_6
						var_1_10009 = var_1_6.TipsMgr.GetInstance()

						local var_1_7 = var_7.ShowTips

						i18n = var_1_10010

						var_1_7(var_1_10009, var_1_10010("challenge_end_tip"))

						return
					else
						local var_1_8 = arg_1_0

						var_1_10006 = arg_1_0.sendNotification
						GAME = var_1_10009
						var_1_10009 = var_1_10009.GO_SCENE
						SCENE = var_1_10010

						var_1_10006(var_1_8, var_1_10009, var_1_10010[var_5[1]], var_5[2])
					end
				end
			end

			::label_1_0::

			return
		end
	end

	isa = var_1_10006

	local var_1_9 = var_1_1

	AvatarFrameTask = var_1_10009

	if var_1_10006(var_1_9, var_1_10009) then
		return
	end

	local var_1_10 = var_1_1:getConfig("sub_type")
	local var_1_11 = var_1_2:getActiveChapter()
	local var_1_12 = {
		chapterId = var_1_11 and var_1_11.id,
		mapIdx = var_1_11 and var_1_11:getConfig("map")
	}

	math = var_9

	local var_1_13 = var_9.modf(var_1_10 / 10)

	math = var_1_10010

	local var_1_14 = var_1_10010.fmod(var_1_10, 10)
	local var_1_15, var_1_16

	if var_1_13 == 0 then
		var_1_15 = arg_1_0
		var_1_16 = arg_1_0.sendNotification
		GAME = var_1_10014
		var_1_10014 = var_1_10014.GO_SCENE
		SCENE = var_1_10015

		var_1_16(var_1_15, var_1_10014, var_1_10015.LEVEL, var_1_12)
	elseif var_1_13 == 1 then
		if var_1_14 == 9 then
			var_1_15 = arg_1_0
			var_1_16 = arg_1_0.sendNotification
			GAME = var_1_10014
			var_1_10014 = var_1_10014.GO_SCENE
			SCENE = var_1_10015

			var_1_16(var_1_15, var_1_10014, var_1_10015.DAILYLEVEL)
		else
			var_1_15 = arg_1_0
			var_1_16 = arg_1_0.sendNotification
			GAME = var_1_10014
			var_1_10014 = var_1_10014.GO_SCENE
			SCENE = var_1_10015

			var_1_16(var_1_15, var_1_10014, var_1_10015.LEVEL, var_1_12)
		end
	else
		local var_1_17

		if var_1_13 == 2 then
			if var_1_14 == 6 then
				var_1_15 = arg_1_0
				var_1_16 = arg_1_0.sendNotification
				GAME = var_1_10014
				var_1_10014 = var_1_10014.GO_SCENE
				SCENE = var_1_10015

				var_1_16(var_1_15, var_1_10014, var_1_10015.DAILYLEVEL)
			elseif var_1_14 == 7 then
				var_1_15 = arg_1_0
				var_1_16 = arg_1_0.sendNotification
				GAME = var_1_10014
				var_1_10014 = var_1_10014.GO_SCENE
				SCENE = var_1_10015

				var_1_16(var_1_15, var_1_10014, var_1_10015.MILITARYEXERCISE)
			elseif var_1_14 == 8 then
				var_1_15 = arg_1_0
				var_1_16 = arg_1_0.sendNotification
				GAME = var_1_10014
				var_1_10014 = var_1_10014.GO_SCENE
				SCENE = var_1_10015

				var_1_16(var_1_15, var_1_10014, var_1_10015.LEVEL, var_1_12)
			elseif var_1_14 == 9 then
				tonumber = var_1_16
				var_1_10015 = var_1_1
				var_1_16 = var_1_16(var_1_1.getConfig(var_1_10015, "target_id"))
				var_1_10014 = arg_1_0
				var_1_17 = arg_1_0.sendNotification
				GAME = var_1_10015
				var_1_10015 = var_1_10015.BEGIN_STAGE
				var_1_10016 = {}
				SYSTEM_PERFORM = var_1_10017
				var_1_10016.system = var_1_10017
				tonumber = var_1_10017
				var_1_10016.stageId = var_1_10017(var_1_16)

				var_1_17(var_1_10014, var_1_10015, var_1_10016)
			else
				var_1_15 = arg_1_0
				var_1_16 = arg_1_0.sendNotification
				GAME = var_1_10014
				var_1_10014 = var_1_10014.GO_SCENE
				SCENE = var_1_10015

				var_1_16(var_1_15, var_1_10014, var_1_10015.LEVEL, var_1_12)
			end
		elseif var_1_13 == 3 then
			if var_1_14 == 0 then
				var_1_15 = arg_1_0
				var_1_16 = arg_1_0.sendNotification
				GAME = var_1_10014
				var_1_10014 = var_1_10014.GO_SCENE
				SCENE = var_1_10015

				var_1_16(var_1_15, var_1_10014, var_1_10015.GETBOAT)
			elseif var_1_14 == 1 then
				var_1_15 = arg_1_0
				var_1_16 = arg_1_0.sendNotification
				GAME = var_1_10014
				var_1_10014 = var_1_10014.GO_SCENE
				SCENE = var_1_10015
				var_1_10015 = var_1_10015.DOCKYARD
				var_1_10016 = {
					blockLock = true
				}
				DockyardScene = var_1_10017
				var_1_10016.mode = var_1_10017.MODE_DESTROY
				ShipStatus = var_1_10017
				var_1_10016.onShip = var_1_10017.canDestroyShip
				getGameset = var_1_10017
				var_1_10016.selectedMax = var_1_10017("ship_select_limit")[1]
				i18n = var_1_10017
				var_1_10016.leftTopInfo = var_1_10017("word_destroy")
				pg = var_1_10017

				local var_1_18 = var_1_10017.ShipFlagMgr.GetInstance()

				var_1_10016.ignoredIds = var_1_10017.FilterShips(var_1_18, {
					isActivityNpc = true
				})

				var_1_16(var_1_15, var_1_10014, var_1_10015, var_1_10016)
			elseif var_1_14 == 7 then
				var_1_15 = arg_1_0
				var_1_16 = arg_1_0.sendNotification
				GAME = var_1_10014
				var_1_10014 = var_1_10014.GO_SCENE
				SCENE = var_1_10015
				var_1_10015 = var_1_10015.NAVALACADEMYSCENE
				var_1_10016 = {}
				NavalAcademyScene = var_1_10017
				var_1_10016.warp = var_1_10017.WARP_TO_TACTIC

				var_1_16(var_1_15, var_1_10014, var_1_10015, var_1_10016)
			else
				var_1_15 = arg_1_0
				var_1_16 = arg_1_0.sendNotification
				GAME = var_1_10014
				var_1_10014 = var_1_10014.GO_SCENE
				SCENE = var_1_10015
				var_1_10015 = var_1_10015.DOCKYARD
				var_1_10016 = {}
				DockyardScene = var_1_10017
				var_1_10016.mode = var_1_10017.MODE_OVERVIEW

				var_1_16(var_1_15, var_1_10014, var_1_10015, var_1_10016)
			end
		elseif var_1_13 == 4 then
			if var_1_14 == 2 then
				var_1_15 = arg_1_0
				var_1_16 = arg_1_0.sendNotification
				GAME = var_1_10014
				var_1_10014 = var_1_10014.GO_SCENE
				SCENE = var_1_10015
				var_1_10015 = var_1_10015.EQUIPSCENE
				var_1_10016 = {}
				StoreHouseConst = var_1_10017
				var_1_10016.warp = var_1_10017.WARP_TO_DESIGN

				var_1_16(var_1_15, var_1_10014, var_1_10015, var_1_10016)
			elseif var_1_14 == 3 then
				var_1_15 = arg_1_0
				var_1_16 = arg_1_0.sendNotification
				GAME = var_1_10014
				var_1_10014 = var_1_10014.GO_SCENE
				SCENE = var_1_10015
				var_1_10015 = var_1_10015.DOCKYARD
				var_1_10016 = {}
				DockyardScene = var_1_10017
				var_1_10016.mode = var_1_10017.MODE_OVERVIEW

				var_1_16(var_1_15, var_1_10014, var_1_10015, var_1_10016)
			else
				var_1_15 = arg_1_0
				var_1_16 = arg_1_0.sendNotification
				GAME = var_1_10014
				var_1_10014 = var_1_10014.GO_SCENE
				SCENE = var_1_10015
				var_1_10015 = var_1_10015.EQUIPSCENE
				var_1_10016 = {}
				StoreHouseConst = var_1_10017
				var_1_10016.warp = var_1_10017.WARP_TO_WEAPON

				var_1_16(var_1_15, var_1_10014, var_1_10015, var_1_10016)
			end
		elseif var_1_13 == 5 then
			if var_1_14 == 0 or var_1_14 == 1 then
				var_1_15 = arg_1_0
				var_1_16 = arg_1_0.sendNotification
				GAME = var_1_10014
				var_1_10014 = var_1_10014.GO_SCENE
				SCENE = var_1_10015
				var_1_10015 = var_1_10015.EQUIPSCENE
				var_1_10016 = {}
				StoreHouseConst = var_1_10017
				var_1_10016.warp = var_1_10017.WARP_TO_MATERIAL

				var_1_16(var_1_15, var_1_10014, var_1_10015, var_1_10016)
			end
		elseif var_1_13 == 6 then
			var_1_15 = arg_1_0
			var_1_16 = arg_1_0.sendNotification
			GAME = var_1_10014
			var_1_10014 = var_1_10014.GO_SCENE
			SCENE = var_1_10015

			var_1_16(var_1_15, var_1_10014, var_1_10015.COURTYARD)
		elseif var_1_13 == 7 then
			var_1_16 = nil

			if var_1_14 == 1 then
				NavalAcademyScene = var_1_17
				var_1_16 = var_1_17.WARP_TO_TACTIC
			end

			var_1_10014 = arg_1_0

			local var_1_19 = arg_1_0.sendNotification

			GAME = var_1_10015
			var_1_10015 = var_1_10015.GO_SCENE
			SCENE = var_1_10016

			var_1_19(var_1_10014, var_1_10015, var_1_10016.NAVALACADEMYSCENE, {
				warp = var_1_16
			})
		elseif var_1_13 == 8 then
			if var_1_14 == 0 then
				var_1_15 = arg_1_0
				var_1_16 = arg_1_0.sendNotification
				GAME = var_1_10014
				var_1_10014 = var_1_10014.GO_SCENE
				SCENE = var_1_10015

				var_1_16(var_1_15, var_1_10014, var_1_10015.EVENT)
			elseif var_1_14 == 1 then
				var_1_15 = arg_1_0
				var_1_16 = arg_1_0.sendNotification
				GAME = var_1_10014
				var_1_10014 = var_1_10014.GO_SCENE
				SCENE = var_1_10015

				var_1_16(var_1_15, var_1_10014, var_1_10015.NAVALACADEMYSCENE)
			end
		elseif var_1_13 == 9 then
			if var_1_14 == 2 then
				var_1_15 = arg_1_0
				var_1_16 = arg_1_0.sendNotification
				TaskMediator = var_1_10014

				var_1_16(var_1_15, var_1_10014.TASK_FILTER, "weekly")
			end
		elseif var_1_13 == 10 then
			if var_1_14 == 4 or var_1_14 == 5 then
				var_1_15 = arg_1_0
				var_1_16 = arg_1_0.sendNotification
				GAME = var_1_10014
				var_1_10014 = var_1_10014.GO_SCENE
				SCENE = var_1_10015
				var_1_10015 = var_1_10015.MAINUI

				local var_1_20 = {}

				Context = var_1_10017
				var_1_10017 = var_1_10017.New

				local var_1_21 = {}

				InstagramLayer = var_1_10020
				var_1_21.viewComponent = var_1_10020
				InstagramMediator = var_1_10020
				var_1_21.mediator = var_1_10020

				local var_1_22 = {}

				act = var_1_10021
				var_1_22.id = var_1_10021.id
				var_1_21.data = var_1_22
				var_1_20.subContext = var_1_10017(var_1_21)

				var_1_16(var_1_15, var_1_10014, var_1_10015, var_1_20)
			end
		elseif var_1_13 == 11 then
			if var_1_14 == 0 then
				var_1_15 = arg_1_0
				var_1_16 = arg_1_0.sendNotification
				GAME = var_1_10014
				var_1_10014 = var_1_10014.GO_SCENE
				SCENE = var_1_10015

				var_1_16(var_1_15, var_1_10014, var_1_10015.TECHNOLOGY)
			end
		elseif var_1_13 == 12 then
			if var_1_14 == 0 then
				var_1_15 = arg_1_0
				var_1_16 = arg_1_0.sendNotification
				GAME = var_1_10014
				var_1_10014 = var_1_10014.GO_SCENE
				SCENE = var_1_10015
				var_1_10015 = var_1_10015.SHOP

				local var_1_23 = {}

				NewShopsScene = var_1_10017
				var_1_23.warp = var_1_10017.TYPE_SHAM_SHOP

				var_1_16(var_1_15, var_1_10014, var_1_10015, var_1_23)
			elseif var_1_14 == 1 then
				var_1_15 = arg_1_0
				var_1_16 = arg_1_0.sendNotification
				GAME = var_1_10014
				var_1_10014 = var_1_10014.GO_SCENE
				SCENE = var_1_10015

				var_1_16(var_1_15, var_1_10014, var_1_10015.LEVEL, var_1_12)
			elseif var_1_14 == 2 then
				var_1_15 = arg_1_0
				var_1_16 = arg_1_0.sendNotification
				GAME = var_1_10014
				var_1_10014 = var_1_10014.GO_SCENE
				SCENE = var_1_10015
				var_1_10015 = var_1_10015.SHOP

				local var_1_24 = {}

				NewShopsScene = var_1_10017
				var_1_24.warp = var_1_10017.TYPE_SHOP_STREET

				var_1_16(var_1_15, var_1_10014, var_1_10015, var_1_24)
			end
		elseif var_1_13 == 13 then
			if var_1_14 == 0 then
				var_1_15 = arg_1_0
				var_1_16 = arg_1_0.sendNotification
				GAME = var_1_10014
				var_1_10014 = var_1_10014.GO_SCENE
				SCENE = var_1_10015

				var_1_16(var_1_15, var_1_10014, var_1_10015.LEVEL, var_1_12)
			end
		elseif var_1_13 == 14 then
			if var_1_14 == 0 then
				var_1_15 = arg_1_0
				var_1_16 = arg_1_0.sendNotification
				GAME = var_1_10014
				var_1_10014 = var_1_10014.GO_SCENE
				SCENE = var_1_10015

				var_1_16(var_1_15, var_1_10014, var_1_10015.DAILYLEVEL)
			end
		elseif var_1_13 == 15 then
			if var_1_14 == 1 then
				var_1_15 = arg_1_0
				var_1_16 = arg_1_0.sendNotification
				GAME = var_1_10014
				var_1_10014 = var_1_10014.GO_SCENE
				SCENE = var_1_10015
				var_1_10015 = var_1_10015.SHOP

				local var_1_25 = {}

				NewShopsScene = var_1_10017
				var_1_25.warp = var_1_10017.TYPE_GUILD

				var_1_16(var_1_15, var_1_10014, var_1_10015, var_1_25)
			elseif var_1_14 == 0 then
				var_1_15 = arg_1_0
				var_1_16 = arg_1_0.sendNotification
				GAME = var_1_10014
				var_1_10014 = var_1_10014.GO_SCENE
				SCENE = var_1_10015

				var_1_16(var_1_15, var_1_10014, var_1_10015.SHOP)
			end
		elseif var_1_13 == 17 then
			if var_1_14 == 0 then
				var_1_15 = arg_1_0
				var_1_16 = arg_1_0.sendNotification
				GAME = var_1_10014
				var_1_10014 = var_1_10014.GO_SCENE
				SCENE = var_1_10015
				var_1_10015 = var_1_10015.COMMANDERCAT

				local var_1_26 = {}

				CommanderCatScene = var_1_10017
				var_1_26.fleetType = var_1_10017.FLEET_TYPE_COMMON

				var_1_16(var_1_15, var_1_10014, var_1_10015, var_1_26)
			end
		elseif var_1_13 == 18 then
			if var_1_14 == 2 then
				var_1_15 = arg_1_0
				var_1_16 = arg_1_0.sendNotification
				GAME = var_1_10014
				var_1_10014 = var_1_10014.GO_SCENE
				SCENE = var_1_10015

				var_1_16(var_1_15, var_1_10014, var_1_10015.LEVEL, var_1_12)
			end
		elseif var_1_13 == 30 then
			if var_1_14 == 4 then
				var_1_15 = arg_1_0
				var_1_16 = arg_1_0.sendNotification
				GAME = var_1_10014
				var_1_10014 = var_1_10014.GO_SCENE
				SCENE = var_1_10015

				var_1_16(var_1_15, var_1_10014, var_1_10015.WORLD)
			end
		elseif var_1_13 == 40 then
			if var_1_14 == 2 then
				getProxy = var_1_16
				GuildProxy = var_1_15

				local var_1_27 = var_1_16(var_1_15)

				if var_1_16.getData(var_1_27) then
					local var_1_28 = arg_1_0

					var_1_16 = arg_1_0.sendNotification
					GAME = var_1_10014
					var_1_10014 = var_1_10014.GO_SCENE
					SCENE = var_1_10015

					var_1_16(var_1_28, var_1_10014, var_1_10015.GUILD, {
						page = "office"
					})
				else
					local var_1_29 = arg_1_0

					var_1_16 = arg_1_0.sendNotification
					GAME = var_1_10014
					var_1_10014 = var_1_10014.GO_SCENE
					SCENE = var_1_10015

					var_1_16(var_1_29, var_1_10014, var_1_10015.PUBLIC_GUILD)
				end
			end
		elseif var_1_13 == 41 then
			if var_1_14 == 7 then
				pg = var_1_16

				local var_1_30 = var_1_16.m02

				var_1_16 = var_1_16.sendNotification
				GAME = var_1_10014

				var_1_16(var_1_30, var_1_10014.GO_MINI_GAME, 56)
			end
		elseif var_1_13 == 43 then
			if var_1_14 == 0 or var_1_14 == 1 then
				local var_1_31 = arg_1_0

				var_1_16 = arg_1_0.sendNotification
				GAME = var_1_10014
				var_1_10014 = var_1_10014.GO_SCENE
				SCENE = var_1_10015

				var_1_16(var_1_31, var_1_10014, var_1_10015.FEAST)
			elseif var_1_14 == 2 or var_1_14 == 3 then
				local var_1_32 = arg_1_0

				var_1_16 = arg_1_0.sendNotification
				GAME = var_1_10014
				var_1_10014 = var_1_10014.GO_SCENE
				SCENE = var_1_10015

				var_1_16(var_1_32, var_1_10014, var_1_10015.FEAST, {
					page = 1
				})
			elseif var_1_14 == 4 then
				pg = var_1_16

				local var_1_33 = var_1_16.m02
				local var_1_34 = var_11.sendNotification

				GAME = var_1_10014

				var_1_34(var_1_33, var_1_10014.GO_MINI_GAME, 56)
			end
		elseif var_1_13 == 100 then
			local var_1_35 = arg_1_0
			local var_1_36 = arg_1_0.sendNotification

			GAME = var_1_10014
			var_1_10014 = var_1_10014.GO_SCENE
			SCENE = var_1_10015

			var_1_36(var_1_35, var_1_10014, var_1_10015.LEVEL, var_1_12)
		elseif var_1_13 == 101 then
			if var_1_14 == 3 then
				local var_1_37 = arg_1_0
				local var_1_38 = arg_1_0.sendNotification

				GAME = var_1_10014
				var_1_10014 = var_1_10014.GO_SCENE
				SCENE = var_1_10015

				var_1_38(var_1_37, var_1_10014, var_1_10015.LEVEL, var_1_12)
			elseif var_1_14 == 5 or var_1_14 == 8 then
				local var_1_39 = arg_1_0
				local var_1_40 = arg_1_0.sendNotification

				GAME = var_1_10014
				var_1_10014 = var_1_10014.GO_SCENE
				SCENE = var_1_10015
				var_1_10015 = var_1_10015.DOCKYARD

				local var_1_41 = {}

				DockyardScene = var_1_10017
				var_1_41.mode = var_1_10017.MODE_OVERVIEW

				var_1_40(var_1_39, var_1_10014, var_1_10015, var_1_41)
			end
		elseif var_1_13 == 102 then
			local var_1_42 = arg_1_0
			local var_1_43 = arg_1_0.sendNotification

			GAME = var_1_10014
			var_1_10014 = var_1_10014.GO_SCENE
			SCENE = var_1_10015

			var_1_43(var_1_42, var_1_10014, var_1_10015.LEVEL, var_1_12)
		elseif var_1_13 == 200 then
			if var_1_14 == 1 or var_1_14 == 2 then
				local var_1_44 = arg_1_0
				local var_1_45 = arg_1_0.sendNotification

				GAME = var_1_10014
				var_1_10014 = var_1_10014.GO_SCENE
				SCENE = var_1_10015

				var_1_45(var_1_44, var_1_10014, var_1_10015.BIANDUI)
			end
		elseif var_1_13 == 201 then
			if var_1_14 == 0 then
				local var_1_46 = arg_1_0
				local var_1_47 = arg_1_0.sendNotification

				GAME = var_1_10014
				var_1_10014 = var_1_10014.GO_SCENE
				SCENE = var_1_10015

				var_1_47(var_1_46, var_1_10014, var_1_10015.COURTYARD)
			elseif var_1_14 == 1 then
				local var_1_48 = arg_1_0
				local var_1_49 = arg_1_0.sendNotification

				GAME = var_1_10014

				local var_1_50 = var_1_10014.GO_SCENE

				SCENE = var_1_10015

				var_1_49(var_1_48, var_1_50, var_1_10015.MAINUI)
			end
		end
	end

	return
end

return var_0_1
