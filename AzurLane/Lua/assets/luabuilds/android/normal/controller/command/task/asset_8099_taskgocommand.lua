class = var_0_10000

local var_0_0 = "TaskGoCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().taskVO

	getProxy = var_1_10004
	ChapterProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)
	local var_1_2 = var_1_0

	if var_1_0.getConfig(var_1_2, "scene") and #var_5 > 0 then
		if var_5[1] == "ACTIVITY_MAP" then
			var_1_2 = {}

			if var_5[2] then
				table = var_7

				var_7.insert(var_1_2, function(arg_2_0)
					getProxy = var_2_10001
					ActivityProxy = var_2_10002

					local var_2_0 = var_2_10001(var_2_10002)

					underscore = var_2_10002

					if var_2_10002.any(var_0[2], function(arg_3_0)
						local var_3_0 = var_2_0
						local var_3_1

						var_3_1 = var_1.getActivityById(var_3_0, arg_3_0) and not var_1:isEnd()

						return var_3_1
					end) then
						arg_2_0()
					else
						pg = var_2

						local var_2_1 = var_2.TipsMgr.GetInstance()
						local var_2_2 = var_2.ShowTips

						i18n = var_4

						var_2_2(var_2_1, var_4("common_activity_notStartOrEnd"))
					end

					return
				end)
			end

			table = var_7

			var_7.insert(var_1_2, function(arg_4_0)
				local var_4_0 = var_1_1
				local var_4_1, var_4_2 = var_1.getLastMapForActivity(var_4_0)

				if var_4_1 then
					local var_4_3 = var_1_1
					local var_4_4 = var_2_10003.getMapById(var_4_3, var_4_1)

					if var_2_10003.isUnlock(var_4_4) then
						arg_4_0(var_4_1, var_4_2)

						goto label_4_0
					end
				end

				pg = var_2_10003

				do
					local var_4_5 = var_2_10003.TipsMgr.GetInstance()
					local var_4_6 = var_3.ShowTips

					i18n = var_2_10005

					var_4_6(var_4_5, var_2_10005("common_activity_notStartOrEnd"))
				end

				::label_4_0::

				return
			end)

			seriesAsync = var_7

			var_7(var_1_2, function(arg_5_0, arg_5_1)
				pg = var_2_10002

				local var_5_0 = var_2_10002.m02
				local var_5_1 = var_2.sendNotification

				GAME = var_2_10004

				local var_5_2 = var_2_10004.GO_SCENE

				SCENE = var_2_10005

				var_5_1(var_5_0, var_5_2, var_2_10005.LEVEL, {
					chapterId = arg_5_1,
					mapIdx = arg_5_0
				})

				return
			end)
		elseif var_5[1] == "HARD_MAP" then
			local var_1_3 = var_1_1

			var_1_2 = var_1_1.getUseableMaxEliteMap(var_1_3)
			pg = var_1_3
			var_1_10008 = var_1_3.m02

			local var_1_4 = var_7.sendNotification

			GAME = var_1_10009
			var_1_10009 = var_1_10009.GO_SCENE
			SCENE = var_1_10010

			var_1_4(var_1_10008, var_1_10009, var_1_10010.LEVEL, {
				mapIdx = var_1_2 and var_1_2.id
			})
		else
			SCENE = var_1_2
			var_1_2 = var_1_2[var_5[1]]
			SCENE = var_7

			if var_1_2 == var_7.LEVEL and var_5[2] then
				var_1_2 = {}

				if var_5[2].mapIdx then
					table = var_1_5

					var_1_5.insert(var_1_2, function(arg_6_0)
						local var_6_0 = var_1_1
						local var_6_1 = var_1.getMapById(var_6_0, var_0[2].mapIdx)
						local var_6_2, var_6_3 = var_1.isUnlock(var_6_1)

						if var_6_2 then
							arg_6_0()
						else
							pg = var_2_10004

							local var_6_4 = var_2_10004.TipsMgr.GetInstance()

							var_4.ShowTips(var_6_4, var_6_3)
						end

						return
					end)
				end

				if var_5[2].chapterId then
					table = var_1_5

					var_1_5.insert(var_1_2, function(arg_7_0)
						local var_7_0 = var_1_1
						local var_7_1 = var_1.getChapterById(var_7_0, var_0[2].chapterId)

						if var_1.isUnlock(var_7_1) then
							arg_7_0()
						else
							pg = var_2

							local var_7_2 = var_2.TipsMgr.GetInstance()
							local var_7_3 = var_2.ShowTips

							i18n = var_2_10004

							var_7_3(var_7_2, var_2_10004("battle_levelScene_chapter_lock"))
						end

						return
					end)
				end

				seriesAsync = var_1_5

				var_1_5(var_1_2, function()
					local var_8_0 = arg_1_0
					local var_8_1 = var_0.sendNotification

					GAME = var_2_10002

					local var_8_2 = var_2_10002.GO_SCENE

					SCENE = var_2_10003

					var_8_1(var_8_0, var_8_2, var_2_10003[var_0[1]], var_0[2])

					return
				end)
			else
				local var_1_5

				if var_5[1] == "MINI_GAME" and var_5[2] then
					var_1_5 = arg_1_0
					var_1_2 = arg_1_0.sendNotification
					GAME = var_1_10008

					var_1_2(var_1_5, var_1_10008.GO_MINI_GAME, var_5[2])
				elseif var_5[2] and var_5[2].unlockActivityID then
					getProxy = var_1_2
					ActivityProxy = var_1_5

					local var_1_6 = var_1_2(var_1_5)

					if var_1_2.getActivityById(var_1_6, var_5[2].unlockActivityID) then
						var_1_10008 = var_1_2

						if not var_1_2.isEnd(var_1_10008) then
							var_1_10008 = arg_1_0
							var_1_6 = arg_1_0.sendNotification
							GAME = var_1_10009
							var_1_10009 = var_1_10009.GO_SCENE
							SCENE = var_1_10010

							var_1_6(var_1_10008, var_1_10009, var_1_10010[var_5[1]], var_5[2])

							goto label_1_0
						end
					end

					pg = var_1_6
					var_1_10008 = var_1_6.TipsMgr.GetInstance()

					local var_1_7 = var_7.ShowTips

					i18n = var_1_10009

					var_1_7(var_1_10008, var_1_10009("challenge_end_tip"))

					return
				else
					local var_1_8 = arg_1_0

					var_1_2 = arg_1_0.sendNotification
					GAME = var_1_10008
					var_1_10008 = var_1_10008.GO_SCENE
					SCENE = var_1_10009

					var_1_2(var_1_8, var_1_10008, var_1_10009[var_5[1]], var_5[2])
				end
			end
		end

		::label_1_0::

		return
	end

	isa = var_1_2

	local var_1_9 = var_1_0

	AvatarFrameTask = var_1_10008

	if var_1_2(var_1_9, var_1_10008) then
		return
	end

	local var_1_10 = var_1_0:getConfig("sub_type")
	local var_1_11 = var_1_1:getActiveChapter()
	local var_1_12 = {
		chapterId = var_1_11 and var_1_11.id,
		mapIdx = var_1_11 and var_1_11:getConfig("map")
	}

	math = var_9

	local var_1_13 = var_9.modf(var_1_10 / 10)

	math = var_10

	local var_1_14 = var_10.fmod(var_1_10, 10)
	local var_1_15, var_1_16

	if var_1_13 == 0 then
		var_1_15 = arg_1_0
		var_1_16 = arg_1_0.sendNotification
		GAME = var_1_10013
		var_1_10013 = var_1_10013.GO_SCENE
		SCENE = var_1_10014

		var_1_16(var_1_15, var_1_10013, var_1_10014.LEVEL, var_1_12)
	elseif var_1_13 == 1 then
		if var_1_14 == 9 then
			var_1_15 = arg_1_0
			var_1_16 = arg_1_0.sendNotification
			GAME = var_1_10013
			var_1_10013 = var_1_10013.GO_SCENE
			SCENE = var_1_10014

			var_1_16(var_1_15, var_1_10013, var_1_10014.DAILYLEVEL)
		else
			var_1_15 = arg_1_0
			var_1_16 = arg_1_0.sendNotification
			GAME = var_1_10013
			var_1_10013 = var_1_10013.GO_SCENE
			SCENE = var_1_10014

			var_1_16(var_1_15, var_1_10013, var_1_10014.LEVEL, var_1_12)
		end
	elseif var_1_13 == 2 then
		if var_1_14 == 6 then
			var_1_15 = arg_1_0
			var_1_16 = arg_1_0.sendNotification
			GAME = var_1_10013
			var_1_10013 = var_1_10013.GO_SCENE
			SCENE = var_1_10014

			var_1_16(var_1_15, var_1_10013, var_1_10014.DAILYLEVEL)
		elseif var_1_14 == 7 then
			var_1_15 = arg_1_0
			var_1_16 = arg_1_0.sendNotification
			GAME = var_1_10013
			var_1_10013 = var_1_10013.GO_SCENE
			SCENE = var_1_10014

			var_1_16(var_1_15, var_1_10013, var_1_10014.MILITARYEXERCISE)
		elseif var_1_14 == 8 then
			var_1_15 = arg_1_0
			var_1_16 = arg_1_0.sendNotification
			GAME = var_1_10013
			var_1_10013 = var_1_10013.GO_SCENE
			SCENE = var_1_10014

			var_1_16(var_1_15, var_1_10013, var_1_10014.LEVEL, var_1_12)
		elseif var_1_14 == 9 then
			tonumber = var_1_16
			var_1_10013 = var_1_0
			var_1_16 = var_1_16(var_1_0.getConfig(var_1_10013, "target_id"))
			var_1_10013 = arg_1_0
			var_1_15 = arg_1_0.sendNotification
			GAME = var_1_10014
			var_1_10014 = var_1_10014.BEGIN_STAGE
			var_1_10015 = {}
			SYSTEM_PERFORM = var_1_10016
			var_1_10015.system = var_1_10016
			tonumber = var_1_10016
			var_1_10015.stageId = var_1_10016(var_1_16)

			var_1_15(var_1_10013, var_1_10014, var_1_10015)
		else
			var_1_15 = arg_1_0
			var_1_16 = arg_1_0.sendNotification
			GAME = var_1_10013
			var_1_10013 = var_1_10013.GO_SCENE
			SCENE = var_1_10014

			var_1_16(var_1_15, var_1_10013, var_1_10014.LEVEL, var_1_12)
		end
	elseif var_1_13 == 3 then
		if var_1_14 == 0 then
			var_1_15 = arg_1_0
			var_1_16 = arg_1_0.sendNotification
			GAME = var_1_10013
			var_1_10013 = var_1_10013.GO_SCENE
			SCENE = var_1_10014

			var_1_16(var_1_15, var_1_10013, var_1_10014.GETBOAT)
		elseif var_1_14 == 1 then
			var_1_15 = arg_1_0
			var_1_16 = arg_1_0.sendNotification
			GAME = var_1_10013
			var_1_10013 = var_1_10013.GO_SCENE
			SCENE = var_1_10014
			var_1_10014 = var_1_10014.DOCKYARD
			var_1_10015 = {
				blockLock = true
			}
			DockyardScene = var_1_10016
			var_1_10015.mode = var_1_10016.MODE_DESTROY
			ShipStatus = var_1_10016
			var_1_10015.onShip = var_1_10016.canDestroyShip
			getGameset = var_1_10016
			var_1_10015.selectedMax = var_1_10016("ship_select_limit")[1]
			i18n = var_1_10016
			var_1_10015.leftTopInfo = var_1_10016("word_destroy")
			pg = var_1_10016

			local var_1_17 = var_1_10016.ShipFlagMgr.GetInstance()

			var_1_10015.ignoredIds = var_1_10016.FilterShips(var_1_17, {
				isActivityNpc = true
			})

			var_1_16(var_1_15, var_1_10013, var_1_10014, var_1_10015)
		elseif var_1_14 == 7 then
			var_1_15 = arg_1_0
			var_1_16 = arg_1_0.sendNotification
			GAME = var_1_10013
			var_1_10013 = var_1_10013.GO_SCENE
			SCENE = var_1_10014
			var_1_10014 = var_1_10014.NAVALACADEMYSCENE
			var_1_10015 = {}
			NavalAcademyScene = var_1_10016
			var_1_10015.warp = var_1_10016.WARP_TO_TACTIC

			var_1_16(var_1_15, var_1_10013, var_1_10014, var_1_10015)
		else
			var_1_15 = arg_1_0
			var_1_16 = arg_1_0.sendNotification
			GAME = var_1_10013
			var_1_10013 = var_1_10013.GO_SCENE
			SCENE = var_1_10014
			var_1_10014 = var_1_10014.DOCKYARD
			var_1_10015 = {}
			DockyardScene = var_1_10016
			var_1_10015.mode = var_1_10016.MODE_OVERVIEW

			var_1_16(var_1_15, var_1_10013, var_1_10014, var_1_10015)
		end
	elseif var_1_13 == 4 then
		if var_1_14 == 2 then
			var_1_15 = arg_1_0
			var_1_16 = arg_1_0.sendNotification
			GAME = var_1_10013
			var_1_10013 = var_1_10013.GO_SCENE
			SCENE = var_1_10014
			var_1_10014 = var_1_10014.EQUIPSCENE
			var_1_10015 = {}
			StoreHouseConst = var_1_10016
			var_1_10015.warp = var_1_10016.WARP_TO_DESIGN

			var_1_16(var_1_15, var_1_10013, var_1_10014, var_1_10015)
		elseif var_1_14 == 3 then
			var_1_15 = arg_1_0
			var_1_16 = arg_1_0.sendNotification
			GAME = var_1_10013
			var_1_10013 = var_1_10013.GO_SCENE
			SCENE = var_1_10014
			var_1_10014 = var_1_10014.DOCKYARD
			var_1_10015 = {}
			DockyardScene = var_1_10016
			var_1_10015.mode = var_1_10016.MODE_OVERVIEW

			var_1_16(var_1_15, var_1_10013, var_1_10014, var_1_10015)
		else
			var_1_15 = arg_1_0
			var_1_16 = arg_1_0.sendNotification
			GAME = var_1_10013
			var_1_10013 = var_1_10013.GO_SCENE
			SCENE = var_1_10014
			var_1_10014 = var_1_10014.EQUIPSCENE
			var_1_10015 = {}
			StoreHouseConst = var_1_10016
			var_1_10015.warp = var_1_10016.WARP_TO_WEAPON

			var_1_16(var_1_15, var_1_10013, var_1_10014, var_1_10015)
		end
	elseif var_1_13 == 5 then
		if var_1_14 == 0 or var_1_14 == 1 then
			var_1_15 = arg_1_0
			var_1_16 = arg_1_0.sendNotification
			GAME = var_1_10013
			var_1_10013 = var_1_10013.GO_SCENE
			SCENE = var_1_10014
			var_1_10014 = var_1_10014.EQUIPSCENE
			var_1_10015 = {}
			StoreHouseConst = var_1_10016
			var_1_10015.warp = var_1_10016.WARP_TO_MATERIAL

			var_1_16(var_1_15, var_1_10013, var_1_10014, var_1_10015)
		end
	elseif var_1_13 == 6 then
		var_1_15 = arg_1_0
		var_1_16 = arg_1_0.sendNotification
		GAME = var_1_10013
		var_1_10013 = var_1_10013.GO_SCENE
		SCENE = var_1_10014

		var_1_16(var_1_15, var_1_10013, var_1_10014.COURTYARD)
	elseif var_1_13 == 7 then
		var_1_16 = nil

		if var_1_14 == 1 then
			NavalAcademyScene = var_1_15
			var_1_16 = var_1_15.WARP_TO_TACTIC
		end

		var_1_10013 = arg_1_0
		var_1_15 = arg_1_0.sendNotification
		GAME = var_1_10014
		var_1_10014 = var_1_10014.GO_SCENE
		SCENE = var_1_10015

		var_1_15(var_1_10013, var_1_10014, var_1_10015.NAVALACADEMYSCENE, {
			warp = var_1_16
		})
	elseif var_1_13 == 8 then
		if var_1_14 == 0 then
			var_1_15 = arg_1_0
			var_1_16 = arg_1_0.sendNotification
			GAME = var_1_10013
			var_1_10013 = var_1_10013.GO_SCENE
			SCENE = var_1_10014

			var_1_16(var_1_15, var_1_10013, var_1_10014.EVENT)
		elseif var_1_14 == 1 then
			var_1_15 = arg_1_0
			var_1_16 = arg_1_0.sendNotification
			GAME = var_1_10013
			var_1_10013 = var_1_10013.GO_SCENE
			SCENE = var_1_10014

			var_1_16(var_1_15, var_1_10013, var_1_10014.NAVALACADEMYSCENE)
		end
	elseif var_1_13 == 9 then
		if var_1_14 == 2 then
			var_1_15 = arg_1_0
			var_1_16 = arg_1_0.sendNotification
			TaskMediator = var_1_10013

			var_1_16(var_1_15, var_1_10013.TASK_FILTER, "weekly")
		end
	elseif var_1_13 == 10 then
		if var_1_14 == 4 or var_1_14 == 5 then
			var_1_15 = arg_1_0
			var_1_16 = arg_1_0.sendNotification
			GAME = var_1_10013
			var_1_10013 = var_1_10013.GO_SCENE
			SCENE = var_1_10014
			var_1_10014 = var_1_10014.MAINUI

			local var_1_18 = {}

			Context = var_1_10016
			var_1_10016 = var_1_10016.New

			local var_1_19 = {}

			InstagramLayer = var_1_10018
			var_1_19.viewComponent = var_1_10018
			InstagramMediator = var_1_10018
			var_1_19.mediator = var_1_10018

			local var_1_20 = {}

			act = var_1_10019
			var_1_20.id = var_1_10019.id
			var_1_19.data = var_1_20
			var_1_18.subContext = var_1_10016(var_1_19)

			var_1_16(var_1_15, var_1_10013, var_1_10014, var_1_18)
		end
	elseif var_1_13 == 11 then
		if var_1_14 == 0 then
			var_1_15 = arg_1_0
			var_1_16 = arg_1_0.sendNotification
			GAME = var_1_10013
			var_1_10013 = var_1_10013.GO_SCENE
			SCENE = var_1_10014

			var_1_16(var_1_15, var_1_10013, var_1_10014.TECHNOLOGY)
		end
	elseif var_1_13 == 12 then
		if var_1_14 == 0 then
			var_1_15 = arg_1_0
			var_1_16 = arg_1_0.sendNotification
			GAME = var_1_10013
			var_1_10013 = var_1_10013.GO_SCENE
			SCENE = var_1_10014
			var_1_10014 = var_1_10014.SHOP

			local var_1_21 = {}

			NewShopsScene = var_1_10016
			var_1_21.warp = var_1_10016.TYPE_SHAM_SHOP

			var_1_16(var_1_15, var_1_10013, var_1_10014, var_1_21)
		elseif var_1_14 == 1 then
			var_1_15 = arg_1_0
			var_1_16 = arg_1_0.sendNotification
			GAME = var_1_10013
			var_1_10013 = var_1_10013.GO_SCENE
			SCENE = var_1_10014

			var_1_16(var_1_15, var_1_10013, var_1_10014.LEVEL, var_1_12)
		elseif var_1_14 == 2 then
			var_1_15 = arg_1_0
			var_1_16 = arg_1_0.sendNotification
			GAME = var_1_10013
			var_1_10013 = var_1_10013.GO_SCENE
			SCENE = var_1_10014
			var_1_10014 = var_1_10014.SHOP

			local var_1_22 = {}

			NewShopsScene = var_1_10016
			var_1_22.warp = var_1_10016.TYPE_SHOP_STREET

			var_1_16(var_1_15, var_1_10013, var_1_10014, var_1_22)
		end
	elseif var_1_13 == 13 then
		if var_1_14 == 0 then
			var_1_15 = arg_1_0
			var_1_16 = arg_1_0.sendNotification
			GAME = var_1_10013
			var_1_10013 = var_1_10013.GO_SCENE
			SCENE = var_1_10014

			var_1_16(var_1_15, var_1_10013, var_1_10014.LEVEL, var_1_12)
		end
	elseif var_1_13 == 14 then
		if var_1_14 == 0 then
			var_1_15 = arg_1_0
			var_1_16 = arg_1_0.sendNotification
			GAME = var_1_10013
			var_1_10013 = var_1_10013.GO_SCENE
			SCENE = var_1_10014

			var_1_16(var_1_15, var_1_10013, var_1_10014.DAILYLEVEL)
		end
	elseif var_1_13 == 15 then
		if var_1_14 == 1 then
			var_1_15 = arg_1_0
			var_1_16 = arg_1_0.sendNotification
			GAME = var_1_10013
			var_1_10013 = var_1_10013.GO_SCENE
			SCENE = var_1_10014
			var_1_10014 = var_1_10014.SHOP

			local var_1_23 = {}

			NewShopsScene = var_1_10016
			var_1_23.warp = var_1_10016.TYPE_GUILD

			var_1_16(var_1_15, var_1_10013, var_1_10014, var_1_23)
		elseif var_1_14 == 0 then
			var_1_15 = arg_1_0
			var_1_16 = arg_1_0.sendNotification
			GAME = var_1_10013
			var_1_10013 = var_1_10013.GO_SCENE
			SCENE = var_1_10014

			var_1_16(var_1_15, var_1_10013, var_1_10014.SHOP)
		end
	elseif var_1_13 == 17 then
		if var_1_14 == 0 then
			var_1_15 = arg_1_0
			var_1_16 = arg_1_0.sendNotification
			GAME = var_1_10013
			var_1_10013 = var_1_10013.GO_SCENE
			SCENE = var_1_10014
			var_1_10014 = var_1_10014.COMMANDERCAT

			local var_1_24 = {}

			CommanderCatScene = var_1_10016
			var_1_24.fleetType = var_1_10016.FLEET_TYPE_COMMON

			var_1_16(var_1_15, var_1_10013, var_1_10014, var_1_24)
		end
	elseif var_1_13 == 18 then
		if var_1_14 == 2 then
			var_1_15 = arg_1_0
			var_1_16 = arg_1_0.sendNotification
			GAME = var_1_10013
			var_1_10013 = var_1_10013.GO_SCENE
			SCENE = var_1_10014

			var_1_16(var_1_15, var_1_10013, var_1_10014.LEVEL, var_1_12)
		end
	elseif var_1_13 == 30 then
		if var_1_14 == 4 then
			var_1_15 = arg_1_0
			var_1_16 = arg_1_0.sendNotification
			GAME = var_1_10013
			var_1_10013 = var_1_10013.GO_SCENE
			SCENE = var_1_10014

			var_1_16(var_1_15, var_1_10013, var_1_10014.WORLD)
		end
	elseif var_1_13 == 40 then
		if var_1_14 == 2 then
			getProxy = var_1_16
			GuildProxy = var_1_15

			local var_1_25 = var_1_16(var_1_15)

			if var_1_16.getData(var_1_25) then
				local var_1_26 = arg_1_0

				var_1_16 = arg_1_0.sendNotification
				GAME = var_1_10013
				var_1_10013 = var_1_10013.GO_SCENE
				SCENE = var_1_10014

				var_1_16(var_1_26, var_1_10013, var_1_10014.GUILD, {
					page = "office"
				})
			else
				local var_1_27 = arg_1_0

				var_1_16 = arg_1_0.sendNotification
				GAME = var_1_10013
				var_1_10013 = var_1_10013.GO_SCENE
				SCENE = var_1_10014

				var_1_16(var_1_27, var_1_10013, var_1_10014.PUBLIC_GUILD)
			end
		end
	elseif var_1_13 == 41 then
		if var_1_14 == 7 then
			pg = var_1_16

			local var_1_28 = var_1_16.m02

			var_1_16 = var_1_16.sendNotification
			GAME = var_1_10013

			var_1_16(var_1_28, var_1_10013.GO_MINI_GAME, 56)
		end
	elseif var_1_13 == 43 then
		if var_1_14 == 0 or var_1_14 == 1 then
			local var_1_29 = arg_1_0

			var_1_16 = arg_1_0.sendNotification
			GAME = var_1_10013
			var_1_10013 = var_1_10013.GO_SCENE
			SCENE = var_1_10014

			var_1_16(var_1_29, var_1_10013, var_1_10014.FEAST)
		elseif var_1_14 == 2 or var_1_14 == 3 then
			local var_1_30 = arg_1_0

			var_1_16 = arg_1_0.sendNotification
			GAME = var_1_10013
			var_1_10013 = var_1_10013.GO_SCENE
			SCENE = var_1_10014

			var_1_16(var_1_30, var_1_10013, var_1_10014.FEAST, {
				page = 1
			})
		elseif var_1_14 == 4 then
			pg = var_1_16

			local var_1_31 = var_1_16.m02
			local var_1_32 = var_11.sendNotification

			GAME = var_1_10013

			var_1_32(var_1_31, var_1_10013.GO_MINI_GAME, 56)
		end
	elseif var_1_13 == 100 then
		local var_1_33 = arg_1_0
		local var_1_34 = arg_1_0.sendNotification

		GAME = var_1_10013
		var_1_10013 = var_1_10013.GO_SCENE
		SCENE = var_1_10014

		var_1_34(var_1_33, var_1_10013, var_1_10014.LEVEL, var_1_12)
	elseif var_1_13 == 101 then
		if var_1_14 == 3 then
			local var_1_35 = arg_1_0
			local var_1_36 = arg_1_0.sendNotification

			GAME = var_1_10013
			var_1_10013 = var_1_10013.GO_SCENE
			SCENE = var_1_10014

			var_1_36(var_1_35, var_1_10013, var_1_10014.LEVEL, var_1_12)
		elseif var_1_14 == 5 or var_1_14 == 8 then
			local var_1_37 = arg_1_0
			local var_1_38 = arg_1_0.sendNotification

			GAME = var_1_10013
			var_1_10013 = var_1_10013.GO_SCENE
			SCENE = var_1_10014
			var_1_10014 = var_1_10014.DOCKYARD

			local var_1_39 = {}

			DockyardScene = var_1_10016
			var_1_39.mode = var_1_10016.MODE_OVERVIEW

			var_1_38(var_1_37, var_1_10013, var_1_10014, var_1_39)
		end
	elseif var_1_13 == 102 then
		local var_1_40 = arg_1_0
		local var_1_41 = arg_1_0.sendNotification

		GAME = var_1_10013
		var_1_10013 = var_1_10013.GO_SCENE
		SCENE = var_1_10014

		var_1_41(var_1_40, var_1_10013, var_1_10014.LEVEL, var_1_12)
	elseif var_1_13 == 200 then
		if var_1_14 == 1 or var_1_14 == 2 then
			local var_1_42 = arg_1_0
			local var_1_43 = arg_1_0.sendNotification

			GAME = var_1_10013
			var_1_10013 = var_1_10013.GO_SCENE
			SCENE = var_1_10014

			var_1_43(var_1_42, var_1_10013, var_1_10014.BIANDUI)
		end
	elseif var_1_13 == 201 then
		if var_1_14 == 0 then
			local var_1_44 = arg_1_0
			local var_1_45 = arg_1_0.sendNotification

			GAME = var_1_10013
			var_1_10013 = var_1_10013.GO_SCENE
			SCENE = var_1_10014

			var_1_45(var_1_44, var_1_10013, var_1_10014.COURTYARD)
		elseif var_1_14 == 1 then
			local var_1_46 = arg_1_0
			local var_1_47 = arg_1_0.sendNotification

			GAME = var_1_10013

			local var_1_48 = var_1_10013.GO_SCENE

			SCENE = var_1_10014

			var_1_47(var_1_46, var_1_48, var_1_10014.MAINUI)
		end
	end

	return
end

return var_0_1
