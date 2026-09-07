local MainGuideSequence = class("MainGuideSequence")
local var_0_1 = {
	{
		id = "NG002",
		condition = function()
			local var_1_0 = getProxy(TaskProxy)
			local var_1_1 = var_1_0:getTaskById(10302)
			local var_1_2 = var_1_1 and var_1_1:isFinish() and not var_1_1:isReceive() and getProxy(FleetProxy):getFleetById(11):isEmpty()

			return var_1_0
		end,
		args = function()
			return _.any(getProxy(BayProxy):getShips(), function(arg_3_0)
				return arg_3_0 and arg_3_0.configId == 308031
			end) and {} or {
				1
			}
		end
	},
	{
		id = "NG004",
		condition = function()
			if pg.SeriesGuideMgr.GetInstance():IsNewVersion() then
				return false
			end

			local var_4_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_GUIDE_TASKS)
			local var_4_1 = var_4_0 and not var_4_0:isEnd()
			local var_4_2 = false

			if var_4_1 then
				local var_4_3 = getProxy(ChapterProxy):getChapterById(var_4_0:getConfig("config_data")[1])

				var_4_2 = var_4_3 and var_4_3:isClear()
			end

			return var_4_1 and var_4_2
		end,
		args = function()
			return {}
		end
	},
	{
		id = "NG005",
		condition = function()
			return pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getRawData().level, "CommanderCatMediator")
		end,
		args = function()
			return {}
		end
	},
	{
		id = "NG0022",
		condition = function()
			return pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getRawData().level, "EquipmentTransformTreeMediator")
		end,
		args = function()
			return {}
		end
	},
	{
		id = "NG0023",
		condition = function()
			return pg.NewStoryMgr.GetInstance():IsPlayed("WorldG192")
		end,
		args = function()
			return {}
		end
	},
	{
		id = "NG0030",
		condition = function()
			if not tobool((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ATELIER_LINK))) then
				return false
			end

			local var_12_0 = getProxy(ChapterProxy)
			local var_12_1 = var_12_0:getChapterById(21)

			return var_12_1 and var_12_1:isClear() and var_12_0:getMapById(var_12_0:getLastMapForActivity())
		end,
		args = function()
			local var_13_0 = getProxy(ChapterProxy)

			return var_13_0:getMapById((var_13_0:getLastMapForActivity())):getConfig("type") == Map.ACTIVITY_HARD and {
				1,
				3
			} or {
				1,
				2,
				3
			}
		end
	},
	{
		id = "NG0032_1",
		condition = function()
			return pg.NewStoryMgr.GetInstance():IsPlayed("NG0030")
		end,
		args = function()
			local var_15_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ATELIER_LINK)
			local var_15_1

			if not tobool(var_15_0) then
				do return false end

				var_15_1 = getProxy(PlayerProxy)
			end

			return PlayerPrefs.GetInt(string.format("first_enter_ryza_atelier_%s_%s", var_15_1:getRawData().id, var_15_0.id), 0) == 0 and {
				1,
				2
			} or {
				1
			}
		end
	},
	{
		id = "NG0037",
		condition = function()
			if pg.SeriesGuideMgr.GetInstance():IsNewVersion() then
				return false
			end

			return NewServerCarnivalScene.isShow()
		end,
		args = function()
			return {}
		end
	},
	{
		id = "NG0038",
		condition = function()
			return getProxy(PlayerProxy):getRawData().level >= 30 and PLATFORM_CODE ~= PLATFORM_CHT
		end,
		args = function()
			return {}
		end
	},
	{
		id = "tb_20",
		condition = function()
			return not LOCK_EDUCATE_SYSTEM and NewEducateHelper.HasAnyUnlockShip()
		end,
		args = function()
			return {}
		end
	},
	{
		id = "DORM3D_GUIDE_01",
		condition = function()
			local var_22_0 = not LOCK_DORM3D_SYSTEM and pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getData().level, "SelectDorm3DMediator") or false

			return (false or nil) and true
		end,
		args = function()
			return {}
		end
	},
	{
		id = "JUUS_GUIDE01",
		condition = function()
			return true
		end,
		args = function()
			return {}
		end
	},
	{
		id = "Yumia_atelier",
		condition = function()
			local var_26_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ATELIER_LINK)

			if not tobool(var_26_0) then
				return false
			end

			return AtelierTools.IsUnlockAtelier(var_26_0, 2)
		end,
		args = function()
			return {}
		end
	},
	{
		id = "ISLAND_GUIDE_1",
		condition = function()
			local var_28_0 = not LOCK_ISLAND_DISPLAY and not LOCK_ISLAND_GUIDE and pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getData().level, "IslandMediator") or false

			return (false or nil) and true
		end,
		args = function()
			return {}
		end
	}
}

function MainGuideSequence:Execute(arg_30_1)
	if IsUnityEditor and not ENABLE_GUIDE then
		if arg_30_1 then
			arg_30_1()
		end

		return
	end

	local var_30_0 = getProxy(ContextProxy):getCurrentContext()

	if var_30_0 and var_30_0.mediator.__cname ~= "NewMainMediator" then
		return
	end

	local var_30_1 = _.detect(var_0_1, function(arg_31_0)
		return not pg.NewStoryMgr.GetInstance():IsPlayed(arg_31_0.id) and arg_31_0.condition()
	end)

	if not var_30_1 then
		arg_30_1()

		return
	end

	local var_30_2 = var_30_1.id

	if pg.SeriesGuideMgr.GetInstance():isRunning() then
		arg_30_1()

		return
	end

	if not pg.NewGuideMgr.GetInstance():CanPlay() then
		arg_30_1()

		return
	end

	pg.m02:sendNotification(GAME.STORY_UPDATE, {
		storyId = var_30_2
	})

	if var_30_2 == "DORM3D_GUIDE_01" then
		pg.m02:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataGuide(1, pg.NewStoryMgr.GetInstance():StoryName2StoryId(var_30_2)))
	end

	pg.NewGuideMgr.GetInstance():Play(var_30_2, var_30_1.args(), function()
		if var_30_2 == "DORM3D_GUIDE_01" then
			pg.m02:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataGuide(2, pg.NewStoryMgr.GetInstance():StoryName2StoryId(var_30_2)))
		end

		if var_30_1.nextOne then
			local var_32_0, var_32_1 = var_30_1.nextOne()

			self:PlayNextOne(var_32_0, var_32_1)
		end

		return
	end, arg_30_1)

	return
end

function MainGuideSequence:PlayNextOne(arg_33_1, arg_33_2)
	if not arg_33_1 then
		return
	end

	pg.NewGuideMgr.GetInstance():Play(arg_33_1, arg_33_2, function()
		return
	end)
	pg.m02:sendNotification(GAME.STORY_UPDATE, {
		storyId = arg_33_1
	})

	return
end

return MainGuideSequence
