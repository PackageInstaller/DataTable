local var_0_0 = class("MainAwakeGuideSequence")
local var_0_1 = {
	{
		id = "NG004_1",
		condition = function()
			if not pg.SeriesGuideMgr.GetInstance():IsNewVersion() then
				return false
			end

			local var_1_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_GUIDE_TASKS)
			local var_1_1 = var_1_0 and not var_1_0:isEnd()
			local var_1_2 = false

			if var_1_1 then
				local var_1_3 = getProxy(ChapterProxy):getChapterById(var_1_0:getConfig("config_data")[1])

				var_1_2 = var_1_3 and var_1_3:isClear()
			end

			return var_1_1 and var_1_2
		end,
		args = function()
			return {}
		end
	}
}

function var_0_0.Execute(arg_3_0, arg_3_1)
	if IsUnityEditor and not ENABLE_GUIDE then
		if arg_3_1 then
			arg_3_1()
		end

		return
	end

	local var_3_0 = getProxy(ContextProxy):getCurrentContext()

	if var_3_0 and var_3_0.mediator.__cname ~= "NewMainMediator" then
		if arg_3_1 then
			arg_3_1()
		end

		return
	end

	local var_3_1 = _.detect(var_0_1, function(arg_4_0)
		local var_4_1 = pg.NewStoryMgr.GetInstance()

		return not var_4_1:IsPlayed(arg_4_0.id) and var_4_0()
	end)

	if not var_3_1 then
		arg_3_1()

		return
	end

	local var_3_2 = var_3_1.id

	if pg.SeriesGuideMgr.GetInstance():isRunning() then
		arg_3_1()

		return
	end

	local var_3_3 = pg.NewGuideMgr.GetInstance()

	if not var_3_3:CanPlay() then
		arg_3_1()

		return
	end

	pg.m02:sendNotification(GAME.STORY_UPDATE, {
		storyId = var_3_2
	})
	pg.NewGuideMgr.GetInstance():Play(var_3_2, var_3_1.args(), nil, arg_3_1)

	return
end

return var_0_0
