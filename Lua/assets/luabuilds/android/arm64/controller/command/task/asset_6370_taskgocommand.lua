local TaskGoCommand = class("TaskGoCommand", pm.SimpleCommand)

function TaskGoCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().taskVO
	local var_1_1 = getProxy(ChapterProxy)
	local var_1_2 = var_1_0:getConfig("scene")

	if var_1_2 and #var_1_2 > 0 then
		if var_1_2[1] == "ACTIVITY_MAP" then
			local var_1_3 = {}

			if var_1_2[2] then
				table.insert(var_1_3, function(arg_2_0)
					local var_2_0 = getProxy(ActivityProxy)

					if underscore.any(var_1_2[2], function(arg_3_0)
						local var_3_0 = var_2_0:getActivityById(arg_3_0)

						return var_3_0 and not var_3_0:isEnd()
					end) then
						arg_2_0()
					else
						pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_notStartOrEnd"))
					end

					return
				end)
			end

			table.insert(var_1_3, function(arg_4_0)
				local var_4_0, var_4_1 = var_1_1:getLastMapForActivity()

				if var_4_0 then
					if var_1_1:getMapById(var_4_0):isUnlock() then
						arg_4_0(var_4_0, var_4_1)

						goto label_4_0
					end
				end

				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_notStartOrEnd"))

				::label_4_0::

				return
			end)
			seriesAsync(var_1_3, function(arg_5_0, arg_5_1)
				pg.m02:sendNotification(GAME.GO_SCENE, SCENE.LEVEL, {
					chapterId = arg_5_1,
					mapIdx = arg_5_0
				})

				return
			end)
		elseif var_1_2[1] == "HARD_MAP" then
			local var_1_4 = var_1_1:getUseableMaxEliteMap()

			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.LEVEL, {
				mapIdx = var_1_4 and var_1_4.id
			})
		elseif SCENE[var_1_2[1]] == SCENE.LEVEL and var_1_2[2] then
			local var_1_5 = {}

			if var_1_2[2].mapIdx then
				table.insert(var_1_5, function(arg_6_0)
					local var_6_0, var_6_1 = var_1_1:getMapById(var_1_2[2].mapIdx):isUnlock()

					if var_6_0 then
						arg_6_0()
					else
						pg.TipsMgr.GetInstance():ShowTips(var_6_1)
					end

					return
				end)
			end

			if var_1_2[2].chapterId then
				table.insert(var_1_5, function(arg_7_0)
					if var_1_1:getChapterById(var_1_2[2].chapterId):isUnlock() then
						arg_7_0()
					else
						pg.TipsMgr.GetInstance():ShowTips(i18n("battle_levelScene_chapter_lock"))
					end

					return
				end)
			end

			seriesAsync(var_1_5, function()
				self:sendNotification(GAME.GO_SCENE, SCENE[var_1_2[1]], var_1_2[2])

				return
			end)
		elseif var_1_2[1] == "MINI_GAME" and var_1_2[2] then
			self:sendNotification(GAME.GO_MINI_GAME, var_1_2[2])
		elseif var_1_2[2] and var_1_2[2].unlockActivityID then
			local var_1_6 = getProxy(ActivityProxy):getActivityById(var_1_2[2].unlockActivityID)

			if var_1_6 and not var_1_6:isEnd() then
				self:sendNotification(GAME.GO_SCENE, SCENE[var_1_2[1]], var_1_2[2])
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("challenge_end_tip"))

				return
			end
		else
			self:sendNotification(GAME.GO_SCENE, SCENE[var_1_2[1]], var_1_2[2])
		end

		return
	end

	if isa(var_1_0, AvatarFrameTask) then
		return
	end

	local var_1_7 = var_1_0:getConfig("sub_type")
	local var_1_8 = var_1_1:getActiveChapter()
	local var_1_9 = {
		chapterId = var_1_8 and var_1_8.id,
		mapIdx = var_1_8 and var_1_8:getConfig("map")
	}
	local var_1_10 = math.modf(var_1_7 / 10)
	local var_1_11 = math.fmod(var_1_7, 10)

	if var_1_10 == 0 then
		self:sendNotification(GAME.GO_SCENE, SCENE.LEVEL, var_1_9)
	elseif var_1_10 == 1 then
		if var_1_11 == 9 then
			self:sendNotification(GAME.GO_SCENE, SCENE.DAILYLEVEL)
		else
			self:sendNotification(GAME.GO_SCENE, SCENE.LEVEL, var_1_9)
		end
	elseif var_1_10 == 2 then
		if var_1_11 == 6 then
			self:sendNotification(GAME.GO_SCENE, SCENE.DAILYLEVEL)
		elseif var_1_11 == 7 then
			self:sendNotification(GAME.GO_SCENE, SCENE.MILITARYEXERCISE)
		elseif var_1_11 == 8 then
			self:sendNotification(GAME.GO_SCENE, SCENE.LEVEL, var_1_9)
		elseif var_1_11 == 9 then
			self:sendNotification(GAME.BEGIN_STAGE, {
				system = SYSTEM_PERFORM,
				stageId = tonumber((tonumber(var_1_0:getConfig("target_id"))))
			})
		else
			self:sendNotification(GAME.GO_SCENE, SCENE.LEVEL, var_1_9)
		end
	elseif var_1_10 == 3 then
		if var_1_11 == 0 then
			self:sendNotification(GAME.GO_SCENE, SCENE.GETBOAT)
		elseif var_1_11 == 1 then
			local var_1_12 = {
				blockLock = true,
				mode = DockyardScene.MODE_DESTROY,
				onShip = ShipStatus.canDestroyShip,
				selectedMax = getGameset("ship_select_limit")[1],
				leftTopInfo = i18n("word_destroy")
			}

			var_1_12.ignoredIds = pg.ShipFlagMgr.GetInstance():FilterShips({
				isActivityNpc = true
			})

			self:sendNotification(GAME.GO_SCENE, SCENE.DOCKYARD, var_1_12)
		elseif var_1_11 == 7 then
			self:sendNotification(GAME.GO_SCENE, SCENE.NAVALACADEMYSCENE, {
				warp = NavalAcademyScene.WARP_TO_TACTIC
			})
		else
			self:sendNotification(GAME.GO_SCENE, SCENE.DOCKYARD, {
				mode = DockyardScene.MODE_OVERVIEW
			})
		end
	elseif var_1_10 == 4 then
		if var_1_11 == 2 then
			self:sendNotification(GAME.GO_SCENE, SCENE.EQUIPSCENE, {
				warp = StoreHouseConst.WARP_TO_DESIGN
			})
		elseif var_1_11 == 3 then
			self:sendNotification(GAME.GO_SCENE, SCENE.DOCKYARD, {
				mode = DockyardScene.MODE_OVERVIEW
			})
		else
			self:sendNotification(GAME.GO_SCENE, SCENE.EQUIPSCENE, {
				warp = StoreHouseConst.WARP_TO_WEAPON
			})
		end
	elseif var_1_10 == 5 then
		if var_1_11 == 0 or var_1_11 == 1 then
			self:sendNotification(GAME.GO_SCENE, SCENE.EQUIPSCENE, {
				warp = StoreHouseConst.WARP_TO_MATERIAL
			})
		end
	elseif var_1_10 == 6 then
		self:sendNotification(GAME.GO_SCENE, SCENE.COURTYARD)
	elseif var_1_10 == 7 then
		self:sendNotification(GAME.GO_SCENE, SCENE.NAVALACADEMYSCENE, {
			warp = (var_1_11 == 1 or nil) and NavalAcademyScene.WARP_TO_TACTIC
		})
	elseif var_1_10 == 8 then
		if var_1_11 == 0 then
			self:sendNotification(GAME.GO_SCENE, SCENE.EVENT)
		elseif var_1_11 == 1 then
			self:sendNotification(GAME.GO_SCENE, SCENE.NAVALACADEMYSCENE)
		end
	elseif var_1_10 == 9 then
		if var_1_11 == 2 then
			self:sendNotification(TaskMediator.TASK_FILTER, "weekly")
		end
	elseif var_1_10 == 10 then
		if var_1_11 == 4 or var_1_11 == 5 then
			self:sendNotification(GAME.GO_SCENE, SCENE.MAINUI, {
				subContext = Context.New({
					viewComponent = InstagramLayer,
					mediator = InstagramMediator,
					data = {
						id = act.id
					}
				})
			})
		end
	elseif var_1_10 == 11 then
		if var_1_11 == 0 then
			self:sendNotification(GAME.GO_SCENE, SCENE.TECHNOLOGY)
		end
	elseif var_1_10 == 12 then
		if var_1_11 == 0 then
			self:sendNotification(GAME.GO_SCENE, SCENE.SHOP, {
				warp = NewShopsScene.TYPE_SHAM_SHOP
			})
		elseif var_1_11 == 1 then
			self:sendNotification(GAME.GO_SCENE, SCENE.LEVEL, var_1_9)
		elseif var_1_11 == 2 then
			self:sendNotification(GAME.GO_SCENE, SCENE.SHOP, {
				warp = NewShopsScene.TYPE_SHOP_STREET
			})
		end
	elseif var_1_10 == 13 then
		if var_1_11 == 0 then
			self:sendNotification(GAME.GO_SCENE, SCENE.LEVEL, var_1_9)
		end
	elseif var_1_10 == 14 then
		if var_1_11 == 0 then
			self:sendNotification(GAME.GO_SCENE, SCENE.DAILYLEVEL)
		end
	elseif var_1_10 == 15 then
		if var_1_11 == 1 then
			self:sendNotification(GAME.GO_SCENE, SCENE.SHOP, {
				warp = NewShopsScene.TYPE_GUILD
			})
		elseif var_1_11 == 0 then
			self:sendNotification(GAME.GO_SCENE, SCENE.SHOP)
		end
	elseif var_1_10 == 17 then
		if var_1_11 == 0 then
			self:sendNotification(GAME.GO_SCENE, SCENE.COMMANDERCAT, {
				fleetType = CommanderCatScene.FLEET_TYPE_COMMON
			})
		end
	elseif var_1_10 == 18 then
		if var_1_11 == 2 then
			self:sendNotification(GAME.GO_SCENE, SCENE.LEVEL, var_1_9)
		end
	elseif var_1_10 == 30 then
		if var_1_11 == 4 then
			self:sendNotification(GAME.GO_SCENE, SCENE.WORLD)
		end
	elseif var_1_10 == 40 then
		if var_1_11 == 2 then
			if getProxy(GuildProxy):getData() then
				self:sendNotification(GAME.GO_SCENE, SCENE.GUILD, {
					page = "office"
				})
			else
				self:sendNotification(GAME.GO_SCENE, SCENE.PUBLIC_GUILD)
			end
		end
	elseif var_1_10 == 41 then
		if var_1_11 == 7 then
			pg.m02:sendNotification(GAME.GO_MINI_GAME, 56)
		end
	elseif var_1_10 == 43 then
		if var_1_11 == 0 or var_1_11 == 1 then
			self:sendNotification(GAME.GO_SCENE, SCENE.FEAST)
		elseif var_1_11 == 2 or var_1_11 == 3 then
			self:sendNotification(GAME.GO_SCENE, SCENE.FEAST, {
				page = 1
			})
		elseif var_1_11 == 4 then
			pg.m02:sendNotification(GAME.GO_MINI_GAME, 56)
		end
	elseif var_1_10 == 100 then
		self:sendNotification(GAME.GO_SCENE, SCENE.LEVEL, var_1_9)
	elseif var_1_10 == 101 then
		if var_1_11 == 3 then
			self:sendNotification(GAME.GO_SCENE, SCENE.LEVEL, var_1_9)
		elseif var_1_11 == 5 or var_1_11 == 8 then
			self:sendNotification(GAME.GO_SCENE, SCENE.DOCKYARD, {
				mode = DockyardScene.MODE_OVERVIEW
			})
		end
	elseif var_1_10 == 102 then
		self:sendNotification(GAME.GO_SCENE, SCENE.LEVEL, var_1_9)
	elseif var_1_10 == 200 then
		if var_1_11 == 1 or var_1_11 == 2 then
			self:sendNotification(GAME.GO_SCENE, SCENE.BIANDUI)
		end
	elseif var_1_10 == 201 then
		if var_1_11 == 0 then
			self:sendNotification(GAME.GO_SCENE, SCENE.COURTYARD)
		elseif var_1_11 == 1 then
			self:sendNotification(GAME.GO_SCENE, SCENE.MAINUI)
		end
	end

	return
end

return TaskGoCommand
