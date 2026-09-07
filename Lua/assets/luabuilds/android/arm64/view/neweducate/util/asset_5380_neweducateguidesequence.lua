local NewEducateGuideSequence = class("NewEducateGuideSequence")

NewEducateGuideSequence.config = {
	NewEducateTalentLayer = {
		{
			id = "tb2_1",
			condition = function()
				return true
			end
		}
	},
	NewEducateMainScene = {
		{
			id = "tb2_2",
			condition = function()
				local var_2_0 = pg.NewStoryMgr.GetInstance():IsPlayed("tb2_1")

				if var_2_0 then
					var_2_0 = #getProxy(NewEducateProxy):GetCurChar():GetTalentList() > 0
				end

				return var_2_0
			end
		},
		{
			id = "tb2_3",
			condition = function()
				local var_3_0 = getProxy(NewEducateProxy):GetCurChar():GetRoundData().round == 1 and not getProxy(NewEducateProxy):GetCurChar():GetFSM():GetState(NewEducateFSM.SYSTEM.TOPIC) or false

				return (false or nil) and true
			end
		},
		{
			id = "tb2_4",
			condition = function()
				return pg.NewStoryMgr.GetInstance():IsPlayed("tb2_3")
			end,
			nextOne = function()
				return "tb2_5"
			end
		},
		{
			id = "tb2_5",
			condition = function()
				return getProxy(NewEducateProxy):GetCurChar():GetRoundData().round == 1
			end,
			nextOne = function()
				return "tb2_6"
			end
		},
		{
			id = "tb2_6",
			condition = function()
				return pg.NewStoryMgr.GetInstance():IsPlayed("tb2_5")
			end,
			nextOne = function()
				return "tb2_7"
			end
		},
		{
			id = "tb2_7",
			condition = function()
				return pg.NewStoryMgr.GetInstance():IsPlayed("tb2_6")
			end
		},
		{
			id = "tb2_9",
			condition = function()
				return getProxy(NewEducateProxy):GetCurChar():GetRoundData().round == 2
			end,
			nextOne = function()
				return "tb2_10"
			end
		},
		{
			id = "tb2_10",
			condition = function()
				return pg.NewStoryMgr.GetInstance():IsPlayed("tb2_9")
			end
		},
		{
			id = "tb2_11",
			condition = function()
				return getProxy(NewEducateProxy):GetCurChar():IsUnlock("rand_event")
			end
		},
		{
			id = "tb2_13",
			condition = function()
				return getProxy(NewEducateProxy):GetCurChar():IsUnlock("char_event")
			end
		},
		{
			id = "tb2_15",
			condition = function()
				return getProxy(NewEducateProxy):GetCurChar():IsUnlock("shop")
			end
		},
		{
			id = "tb2_17",
			condition = function()
				return getProxy(NewEducateProxy):GetCurChar():GetPermanentData():IsTarotType()
			end
		},
		{
			id = "tb2_18",
			condition = function()
				local var_18_0 = getProxy(NewEducateProxy):GetCurChar()

				if not var_18_0:GetRoundData():ExistEndless() then
					return false
				end

				if var_18_0:GetFSM():GetSystemNo() ~= NewEducateFSM.SYSTEM.ENDING then
					return false
				end

				local var_18_1 = var_18_0:GetFSM():GetState(NewEducateFSM.SYSTEM.ENDING)

				return var_18_1 and var_18_1:IsFinish()
			end
		}
	},
	NewEducateScheduleScene = {
		{
			id = "tb2_8",
			condition = function()
				return pg.NewStoryMgr.GetInstance():IsPlayed("tb2_7")
			end
		},
		{
			id = "tb2_14",
			condition = function()
				return getProxy(NewEducateProxy):GetCurChar():IsUnlock("lesson_upgrade")
			end
		}
	},
	NewEducateChooseLayer = {
		{
			id = "tb2_16",
			condition = function()
				return true
			end
		}
	},
	NewEducateRankLayer = {
		{
			id = "tb2_20",
			condition = function()
				return true
			end
		}
	}
}

function NewEducateGuideSequence:CheckGuide(arg_23_1)
	local var_23_0 = arg_23_1 or function()
		return
	end

	if NewEducateConst.LOCK_GUIDE then
		var_23_0()

		return
	end

	local var_23_1 = getProxy(NewEducateProxy):GetCurChar()

	if var_23_1:GetGameCnt() == 1 then
		if var_23_1:GetRoundData():IsTemp() then
			var_23_0()

			return
		end
	end

	local var_23_2 = underscore.detect(NewEducateGuideSequence.config[self] or {}, function(arg_25_0)
		return not pg.NewStoryMgr.GetInstance():IsPlayed(arg_25_0.id) and arg_25_0.condition()
	end)

	if not var_23_2 then
		var_23_0()

		return
	end

	local var_23_3 = var_23_2.id
	local var_23_4 = {
		var_23_1.id
	}

	if pg.SeriesGuideMgr.GetInstance():isRunning() then
		var_23_0()

		return
	end

	if not pg.NewGuideMgr.GetInstance():CanPlay() then
		var_23_0()

		return
	end

	pg.m02:sendNotification(GAME.STORY_UPDATE, {
		storyId = var_23_3
	})
	pg.NewGuideMgr.GetInstance():Play(var_23_3, var_23_4, function()
		if var_23_2.nextOne then
			NewEducateGuideSequence.PlayNextOne(var_23_2.nextOne(), var_23_4)
		end

		return
	end, var_23_0)

	return
end

function NewEducateGuideSequence:PlayNextOne(arg_27_1)
	if not self then
		return
	end

	pg.NewGuideMgr.GetInstance():Play(self, arg_27_1, function()
		return
	end)
	pg.m02:sendNotification(GAME.STORY_UPDATE, {
		storyId = self
	})

	return
end

return NewEducateGuideSequence
