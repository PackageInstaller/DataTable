class = var_0_10000

local var_0_0 = var_0_10000("MainAwakeGuideSequence")
local var_0_1 = {
	{
		id = "NG004_1",
		condition = function()
			pg = var_1_10000

			local var_1_0 = var_1_10000.SeriesGuideMgr.GetInstance()

			if not var_0.IsNewVersion(var_1_0) then
				return false
			end

			getProxy = var_0
			ActivityProxy = var_1_0

			local var_1_1 = var_0(var_1_0)
			local var_1_2 = var_0.getActivityByType

			ActivityConst = var_1_10003

			local var_1_3 = var_1_2(var_1_1, var_1_10003.ACTIVITY_TYPE_GUIDE_TASKS) and not var_0:isEnd()
			local var_1_4 = false

			if var_1_3 then
				local var_1_5 = var_0:getConfig("config_data")[1]

				getProxy = var_1_10004
				ChapterProxy = var_6

				local var_1_6 = var_1_10004(var_6)

				var_1_4 = var_4.getChapterById(var_1_6, var_1_5) and var_4:isClear()
			end

			return var_1_3 and var_1_4
		end,
		args = function()
			return {}
		end
	}
}

function var_0_0.Execute(arg_3_0, arg_3_1)
	IsUnityEditor = var_1_10002

	if var_1_10002 then
		ENABLE_GUIDE = var_1_10002

		if not var_1_10002 then
			if arg_3_1 then
				arg_3_1()
			end

			return
		end
	end

	getProxy = var_1_10002
	ContextProxy = var_1_10004

	local var_3_0 = var_1_10002(var_1_10004)

	if var_2.getCurrentContext(var_3_0) and var_2.mediator.__cname ~= "NewMainMediator" then
		if arg_3_1 then
			arg_3_1()
		end

		return
	end

	_ = var_1_10003

	if not var_1_10003.detect(var_0_1, function(arg_4_0)
		local var_4_0 = arg_4_0.id
		local var_4_1 = arg_4_0.condition

		pg = var_2_10003

		local var_4_2 = var_2_10003.NewStoryMgr.GetInstance()

		return not var_3.IsPlayed(var_4_2, var_4_0) and var_4_1()
	end) then
		arg_3_1()

		return
	end

	local var_3_1 = var_3.id
	local var_3_2 = var_3.args()

	pg = var_1_10007

	local var_3_3 = var_1_10007.SeriesGuideMgr.GetInstance()

	if var_7.isRunning(var_3_3) then
		arg_3_1()

		return
	end

	pg = var_7

	local var_3_4 = var_7.NewGuideMgr.GetInstance()

	if not var_7.CanPlay(var_3_4) then
		arg_3_1()

		return
	end

	pg = var_7

	local var_3_5 = var_7.m02
	local var_3_6 = var_7.sendNotification

	GAME = var_1_10010

	var_3_6(var_3_5, var_1_10010.STORY_UPDATE, {
		storyId = var_3_1
	})

	pg = var_3_6

	local var_3_7 = var_3_6.NewGuideMgr.GetInstance()

	var_7.Play(var_3_7, var_3_1, var_3_2, nil, arg_3_1)

	return
end

return var_0_0
