return {
	LevelScene = {
		{
			id = "NG002",
			condition = function()
				local var_1_0 = getProxy(TaskProxy)
				local var_1_1 = var_1_0:getTaskById(10302)
				local var_1_2 = var_1_1 and var_1_1:isFinish() and not var_1_1:isReceive() and getProxy(FleetProxy):getFleetById(11):isEmpty()

				return var_1_0
			end,
			args = function(self)
				if getProxy(ChapterProxy):getActiveChapter() then
					self:switchToMap()
				end

				return _.any(getProxy(BayProxy):getShips(), function(arg_3_0)
					return arg_3_0 and arg_3_0.configId == 308031
				end) and {
					2
				} or {
					2,
					1
				}
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

				return var_5_0:getMapById((var_5_0:getLastMapForActivity())):getConfig("type") == Map.ACTIVITY_HARD and {
					3
				} or {
					2,
					3
				}
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
			condition = function(self)
				return self.contextData.mode == DockyardScene.MODE_DESTROY
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
