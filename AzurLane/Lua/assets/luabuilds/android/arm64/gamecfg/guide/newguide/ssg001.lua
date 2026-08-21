return {
	LevelScene = {
		{
			id = "NG002",
			condition = function()
				local var_1_9000
				local var_1_0 = getProxy(TaskProxy)
				local var_1_1 = var_1_0.getTaskById(var_1_9000, 10302)
				local var_1_2 = getProxy(FleetProxy):getFleetById(11)
				local var_1_3 = var_1_1 and var_1_1:isFinish() and not var_1_1:isReceive() and var_1_2:isEmpty()

				return var_1_0
			end,
			args = function(arg_2_0)
				if getProxy(ChapterProxy):getActiveChapter() then
					arg_2_0:switchToMap()
				end

				if _.any(getProxy(BayProxy):getShips(), function(arg_3_0)
					return arg_3_0 and arg_3_0.configId == 308031
				end) then
					local var_2_0 = {
						2
					}

					if not {
						2
					} then
						var_2_0 = {
							2,
							1
						}
					end

					return var_2_0
				end
			end
		},
		{
			id = "NG0030",
			condition = function()
				if not tobool((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ATELIER_LINK))) then
					return false
				end

				local var_4_0 = getProxy(ChapterProxy)
				local var_4_1 = var_4_0:getChapterById(21)

				return var_4_1 and var_4_1:isClear() and var_4_0:getMapById(var_4_0:getLastMapForActivity())
			end,
			args = function()
				local var_5_0 = getProxy(ChapterProxy)
				local var_5_1 = var_5_0:getMapById((var_5_0:getLastMapForActivity()))

				if var_5_1:getConfig("type") == Map.ACTIVITY_HARD then
					local var_5_2 = {
						3
					}

					if not {
						3
					} then
						var_5_2 = {
							2,
							3
						}
					end

					return var_5_2
				end
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
				return arg_10_0.contextData.mode == DockyardScene.MODE_DESTROY
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
				return PLATFORM_CODE ~= PLATFORM_CHT
			end,
			args = function()
				return {}
			end
		},
		{
			id = "NG0040",
			condition = function(arg_14_0)
				return PLATFORM_CODE ~= PLATFORM_CHT
			end,
			args = function()
				return {}
			end
		}
	}
}
