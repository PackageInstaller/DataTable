return {
	LevelScene = {
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
			args = function(arg_2_0)
				getProxy = var_1_10001
				ChapterProxy = var_1_10002

				local var_2_0 = var_1_10001(var_1_10002)

				if var_1.getActiveChapter(var_2_0) then
					var_2_0 = arg_2_0

					arg_2_0.switchToMap(var_2_0)
				end

				_ = var_2

				local var_2_1 = var_2.any

				getProxy = var_2_0
				BayProxy = var_1_10004

				local var_2_2 = var_2_0(var_1_10004)
				local var_2_3

				if not var_2_1(var_3.getShips(var_2_2), function(arg_3_0)
					return arg_3_0 and arg_3_0.configId == 308031
				end) or not {
					2
				} then
					var_2_3 = {
						2,
						1
					}
				end

				return var_2_3
			end
		},
		{
			id = "NG0030",
			condition = function()
				getProxy = var_1_10000
				ActivityProxy = var_1_10001

				local var_4_0 = var_1_10000(var_1_10001)
				local var_4_1 = var_0.getActivityByType

				ActivityConst = var_1_10002

				local var_4_2 = var_4_1(var_4_0, var_1_10002.ACTIVITY_TYPE_ATELIER_LINK)

				tobool = var_4_0

				if not var_4_0(var_4_2) then
					return false
				end

				getProxy = var_2
				ChapterProxy = var_1_10003

				local var_4_3 = var_2(var_1_10003)
				local var_4_4

				if var_2.getChapterById(var_4_3, 21) and var_3:isClear() then
					var_4_4 = var_2:getMapById(var_2:getLastMapForActivity())
				end

				return var_4_4
			end,
			args = function()
				getProxy = var_1_10000
				ChapterProxy = var_1_10001

				local var_5_0 = var_1_10000(var_1_10001)
				local var_5_1 = var_0.getLastMapForActivity(var_5_0)
				local var_5_2 = var_0:getMapById(var_5_1)
				local var_5_3 = var_2.getConfig(var_5_2, "type")

				Map = var_5_2

				local var_5_4

				if not (var_5_3 == var_5_2.ACTIVITY_HARD) or not {
					3
				} then
					var_5_4 = {
						2,
						3
					}
				end

				return var_5_4
			end
		}
	},
	ChallengeMainScene = {
		{
			id = "NG0014",
			condition = function()
				return true
			end,
			args = function()
				return {}
			end
		}
	},
	InstagramLayer = {
		{
			id = "NG0018",
			condition = function()
				return true
			end,
			args = function()
				return {}
			end
		}
	},
	DockyardScene = {
		{
			id = "NG0019",
			condition = function(arg_10_0)
				local var_10_0 = arg_10_0.contextData.mode

				DockyardScene = var_1_10002

				return var_10_0 == var_1_10002.MODE_DESTROY
			end,
			args = function()
				return {}
			end
		}
	},
	GameHallScene = {
		{
			id = "NG0039",
			condition = function(arg_12_0)
				PLATFORM_CODE = var_1_10001
				PLATFORM_CHT = var_1_10002

				return var_1_10001 ~= var_1_10002
			end,
			args = function()
				return {}
			end
		},
		{
			id = "NG0040",
			condition = function(arg_14_0)
				PLATFORM_CODE = var_1_10001
				PLATFORM_CHT = var_1_10002

				return var_1_10001 ~= var_1_10002
			end,
			args = function()
				return {}
			end
		}
	}
}
