class = var_0_10000

local var_0_0 = var_0_10000("MainGuideSequence")
local var_0_1 = {
	{
		id = "NG002",
		condition = function()
			getProxy = var_1_10000
			TaskProxy = var_1_10001

			local var_1_0 = var_1_10000(var_1_10001)
			local var_1_1 = var_0.getTaskById(var_1_0, 10302)

			getProxy = var_1_0
			FleetProxy = var_2

			local var_1_2 = var_1_0(var_2)
			local var_1_3 = var_1.getFleetById(var_1_2, 11)
			local var_1_4

			if var_1_1 and var_1_1:isFinish() then
				var_1_4 = not var_1_1:isReceive() and var_1_3:isEmpty()
			end

			return var_1_4
		end,
		args = function()
			_ = var_1_10000

			local var_2_0 = var_1_10000.any

			getProxy = var_1_10001
			BayProxy = var_1_10002

			local var_2_1 = var_1_10001(var_1_10002)
			local var_2_2

			if not var_2_0(var_1.getShips(var_2_1), function(arg_3_0)
				return arg_3_0 and arg_3_0.configId == 308031
			end) or not {} then
				var_2_2 = {
					1
				}
			end

			return var_2_2
		end
	},
	{
		id = "NG004",
		condition = function()
			pg = var_1_10000

			local var_4_0 = var_1_10000.SeriesGuideMgr.GetInstance()

			if var_0.IsNewVersion(var_4_0) then
				return false
			end

			getProxy = var_0
			ActivityProxy = var_4_0

			local var_4_1 = var_0(var_4_0)
			local var_4_2 = var_0.getActivityByType

			ActivityConst = var_1_10002

			local var_4_3

			var_4_3 = var_4_2(var_4_1, var_1_10002.ACTIVITY_TYPE_GUIDE_TASKS) and not var_0:isEnd()

			local var_4_4 = false

			if var_4_3 then
				local var_4_5 = var_0
				local var_4_6 = var_0.getConfig(var_4_5, "config_data")[1]

				getProxy = var_4_5
				ChapterProxy = var_5

				local var_4_7 = var_4_5(var_5)

				var_4_4 = var_4.getChapterById(var_4_7, var_4_6) and var_4:isClear()
			end

			return var_4_3 and var_4_4
		end,
		args = function()
			return {}
		end
	},
	{
		id = "NG005",
		condition = function()
			getProxy = var_1_10000
			PlayerProxy = var_1_10001

			local var_6_0 = var_1_10000(var_1_10001)
			local var_6_1 = var_0.getRawData(var_6_0).level

			pg = var_6_0

			local var_6_2 = var_6_0.SystemOpenMgr.GetInstance()

			return var_1.isOpenSystem(var_6_2, var_6_1, "CommanderCatMediator")
		end,
		args = function()
			return {}
		end
	},
	{
		id = "NG0022",
		condition = function()
			getProxy = var_1_10000
			PlayerProxy = var_1_10001

			local var_8_0 = var_1_10000(var_1_10001)
			local var_8_1 = var_0.getRawData(var_8_0).level

			pg = var_8_0

			local var_8_2 = var_8_0.SystemOpenMgr.GetInstance()

			return var_1.isOpenSystem(var_8_2, var_8_1, "EquipmentTransformTreeMediator")
		end,
		args = function()
			return {}
		end
	},
	{
		id = "NG0023",
		condition = function()
			pg = var_1_10000

			local var_10_0 = var_1_10000.NewStoryMgr.GetInstance()

			return var_0.IsPlayed(var_10_0, "WorldG192")
		end,
		args = function()
			return {}
		end
	},
	{
		id = "NG0030",
		condition = function()
			getProxy = var_1_10000
			ActivityProxy = var_1_10001

			local var_12_0 = var_1_10000(var_1_10001)
			local var_12_1 = var_0.getActivityByType

			ActivityConst = var_1_10002

			local var_12_2 = var_12_1(var_12_0, var_1_10002.ACTIVITY_TYPE_ATELIER_LINK)

			tobool = var_12_0

			if not var_12_0(var_12_2) then
				return false
			end

			getProxy = var_2
			ChapterProxy = var_1_10003

			local var_12_3 = var_2(var_1_10003)
			local var_12_4

			if var_2.getChapterById(var_12_3, 21) and var_3:isClear() then
				var_12_4 = var_2:getMapById(var_2:getLastMapForActivity())
			end

			return var_12_4
		end,
		args = function()
			getProxy = var_1_10000
			ChapterProxy = var_1_10001

			local var_13_0 = var_1_10000(var_1_10001)
			local var_13_1 = var_0.getLastMapForActivity(var_13_0)
			local var_13_2 = var_0:getMapById(var_13_1)
			local var_13_3 = var_2.getConfig(var_13_2, "type")

			Map = var_13_2

			local var_13_4

			if not (var_13_3 == var_13_2.ACTIVITY_HARD) or not {
				1,
				3
			} then
				var_13_4 = {
					1,
					2,
					3
				}
			end

			return var_13_4
		end
	},
	{
		id = "NG0032_1",
		condition = function()
			pg = var_1_10000

			local var_14_0 = var_1_10000.NewStoryMgr.GetInstance()

			return var_0.IsPlayed(var_14_0, "NG0030")
		end,
		args = function()
			getProxy = var_1_10000
			ActivityProxy = var_1_10001

			local var_15_0 = var_1_10000(var_1_10001)
			local var_15_1 = var_0.getActivityByType

			ActivityConst = var_1_10002

			local var_15_2 = var_15_1(var_15_0, var_1_10002.ACTIVITY_TYPE_ATELIER_LINK)

			tobool = var_15_0

			if not var_15_0(var_15_2) then
				return false
			end

			PlayerPrefs = var_2

			local var_15_3 = var_2.GetInt

			string = var_1_10003

			local var_15_4 = var_1_10003.format
			local var_15_5 = "first_enter_ryza_atelier_%s_%s"

			getProxy = var_1_10005
			PlayerProxy = var_1_10006

			local var_15_6 = var_1_10005(var_1_10006)
			local var_15_7

			if not (var_15_3(var_15_4(var_15_5, var_5.getRawData(var_15_6).id, var_15_2.id), 0) == 0) or not {
				1,
				2
			} then
				var_15_7 = {
					1
				}
			end

			return var_15_7
		end
	},
	{
		id = "NG0037",
		condition = function()
			pg = var_1_10000

			local var_16_0 = var_1_10000.SeriesGuideMgr.GetInstance()

			if var_0.IsNewVersion(var_16_0) then
				return false
			end

			NewServerCarnivalScene = var_0

			return var_0.isShow()
		end,
		args = function()
			return {}
		end
	},
	{
		id = "NG0038",
		condition = function()
			getProxy = var_1_10000
			PlayerProxy = var_1_10001

			local var_18_0 = var_1_10000(var_1_10001)
			local var_18_1 = var_0.getRawData(var_18_0).level

			if 30 <= var_18_1 then
				PLATFORM_CODE = var_18_1
				PLATFORM_CHT = var_1

				local var_18_2

				if var_18_1 == var_1 then
					var_18_2 = false
				else
					var_18_2 = true
				end

				return var_18_2
			end
		end,
		args = function()
			return {}
		end
	},
	{
		id = "tb_20",
		condition = function()
			LOCK_EDUCATE_SYSTEM = var_1_10000

			local var_20_0

			if not var_1_10000 then
				NewEducateHelper = var_1_10000
				var_20_0 = var_1_10000.HasAnyUnlockShip()
			else
				var_20_0 = false
			end

			if false then
				var_20_0 = true
			end

			return var_20_0
		end,
		args = function()
			return {}
		end
	},
	{
		id = "DORM3D_GUIDE_01",
		condition = function()
			LOCK_DORM3D_SYSTEM = var_1_10000

			local var_22_3

			if not var_1_10000 then
				pg = var_1_10000

				local var_22_0 = var_1_10000.SystemOpenMgr.GetInstance()
				local var_22_1 = var_0.isOpenSystem

				getProxy = var_1_10002
				PlayerProxy = var_1_10003

				local var_22_2 = var_1_10002(var_1_10003)

				var_22_3 = var_22_1(var_22_0, var_2.getData(var_22_2).level, "SelectDorm3DMediator")
			else
				var_22_3 = false
			end

			if false then
				var_22_3 = true
			end

			return var_22_3
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
			getProxy = var_1_10000
			ActivityProxy = var_1_10001

			local var_26_0 = var_1_10000(var_1_10001)
			local var_26_1 = var_0.getActivityByType

			ActivityConst = var_1_10002

			local var_26_2 = var_26_1(var_26_0, var_1_10002.ACTIVITY_TYPE_ATELIER_LINK)

			tobool = var_26_0

			if not var_26_0(var_26_2) then
				return false
			end

			AtelierTools = var_2

			return var_2.IsUnlockAtelier(var_26_2, 2)
		end,
		args = function()
			return {}
		end
	},
	{
		id = "ISLAND_GUIDE_1",
		condition = function()
			LOCK_ISLAND_DISPLAY = var_1_10000

			local var_28_3

			if not var_1_10000 then
				LOCK_ISLAND_GUIDE = var_1_10000

				if not var_1_10000 then
					pg = var_1_10000

					local var_28_0 = var_1_10000.SystemOpenMgr.GetInstance()
					local var_28_1 = var_0.isOpenSystem

					getProxy = var_1_10002
					PlayerProxy = var_1_10003

					local var_28_2 = var_1_10002(var_1_10003)

					var_28_3 = var_28_1(var_28_0, var_2.getData(var_28_2).level, "IslandMediator")

					goto label_28_0
				end
			end

			var_28_3 = false

			if false then
				var_28_3 = true
			end

			::label_28_0::

			return var_28_3
		end,
		args = function()
			return {}
		end
	}
}

function var_0_0.Execute(arg_30_0, arg_30_1)
	IsUnityEditor = var_1_10002

	if var_1_10002 then
		ENABLE_GUIDE = var_1_10002

		if not var_1_10002 then
			if arg_30_1 then
				arg_30_1()
			end

			return
		end
	end

	getProxy = var_1_10002
	ContextProxy = var_1_10003

	local var_30_0 = var_1_10002(var_1_10003)

	if var_2.getCurrentContext(var_30_0) and var_2.mediator.__cname ~= "NewMainMediator" then
		return
	end

	_ = var_30_0

	if not var_30_0.detect(var_0_1, function(arg_31_0)
		local var_31_0 = arg_31_0.id
		local var_31_1 = arg_31_0.condition

		pg = var_2_10003

		local var_31_2 = var_2_10003.NewStoryMgr.GetInstance()

		return not var_3.IsPlayed(var_31_2, var_31_0) and var_31_1()
	end) then
		arg_30_1()

		return
	end

	local var_30_1 = var_3.id
	local var_30_2 = var_3.args()

	pg = var_1_10007

	local var_30_3 = var_1_10007.SeriesGuideMgr.GetInstance()

	if var_7.isRunning(var_30_3) then
		arg_30_1()

		return
	end

	pg = var_7

	local var_30_4 = var_7.NewGuideMgr.GetInstance()

	if not var_7.CanPlay(var_30_4) then
		arg_30_1()

		return
	end

	pg = var_7

	local var_30_5 = var_7.m02
	local var_30_6 = var_7.sendNotification

	GAME = var_1_10009

	var_30_6(var_30_5, var_1_10009.STORY_UPDATE, {
		storyId = var_30_1
	})

	if var_30_1 == "DORM3D_GUIDE_01" then
		pg = var_30_6

		local var_30_7 = var_30_6.m02

		var_30_6 = var_30_6.sendNotification
		GAME = var_9

		local var_30_8 = var_9.APARTMENT_TRACK

		Dorm3dTrackCommand = var_10

		local var_30_9 = var_10.BuildDataGuide
		local var_30_10 = 1

		pg = var_1_10012

		local var_30_11 = var_1_10012.NewStoryMgr.GetInstance()

		var_30_6(var_30_7, var_30_8, var_30_9(var_30_10, var_12.StoryName2StoryId(var_30_11, var_30_1)))
	end

	pg = var_30_6

	local var_30_12 = var_30_6.NewGuideMgr.GetInstance()

	var_7.Play(var_30_12, var_30_1, var_30_2, function()
		if var_30_1 == "DORM3D_GUIDE_01" then
			pg = var_0

			local var_32_0 = var_0.m02
			local var_32_1 = var_0.sendNotification

			GAME = var_2_10002

			local var_32_2 = var_2_10002.APARTMENT_TRACK

			Dorm3dTrackCommand = var_2_10003

			local var_32_3 = var_2_10003.BuildDataGuide
			local var_32_4 = 2

			pg = var_2_10005

			local var_32_5 = var_2_10005.NewStoryMgr.GetInstance()

			var_32_1(var_32_0, var_32_2, var_32_3(var_32_4, var_5.StoryName2StoryId(var_32_5, var_30_1)))
		end

		if var_0.nextOne then
			local var_32_6, var_32_7 = var_0.nextOne()
			local var_32_8 = arg_30_0

			var_2.PlayNextOne(var_32_8, var_32_6, var_32_7)
		end

		return
	end, arg_30_1)

	return
end

function var_0_0.PlayNextOne(arg_33_0, arg_33_1, arg_33_2)
	if not arg_33_1 then
		return
	end

	pg = var_1_10003

	local var_33_0 = var_1_10003.NewGuideMgr.GetInstance()

	var_3.Play(var_33_0, arg_33_1, arg_33_2, function()
		return
	end)

	pg = var_3

	local var_33_1 = var_3.m02
	local var_33_2 = var_3.sendNotification

	GAME = var_5

	var_33_2(var_33_1, var_5.STORY_UPDATE, {
		storyId = arg_33_1
	})

	return
end

return var_0_0
