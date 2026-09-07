local EducateGuideSequence = class("EducateGuideSequence")

EducateGuideSequence.config = {
	EducateScene = {
		{
			ignorePlayer = true,
			id = "tb_1",
			condition = function()
				return getProxy(EducateProxy):GetTaskProxy():GetTaskById(EducateConst.MAIN_TASK_ID_1)
			end,
			args = function()
				return {}
			end,
			nextOne = function()
				return "tb_2"
			end
		},
		{
			id = "tb_2",
			ignorePlayer = true,
			condition = function()
				local var_4_0 = pg.NewStoryMgr.GetInstance():IsPlayed("tb_1")

				if var_4_0 then
					var_4_0 = getProxy(EducateProxy):GetTaskProxy():GetTargetId() == 0
				end

				return var_4_0
			end,
			args = function()
				return {}
			end
		},
		{
			id = "tb_4",
			condition = function()
				local var_6_0 = getProxy(EducateProxy):GetCurTime()
				local var_6_1 = pg.NewStoryMgr.GetInstance():IsPlayed("tb_3")

				var_6_1 = var_6_1 and var_6_0.month == 2 and var_6_0.week == 4

				return var_6_1
			end,
			args = function()
				return {}
			end
		},
		{
			id = "tb_5",
			condition = function()
				return getProxy(EducateProxy):GetCurTime().month ~= 2
			end,
			args = function()
				return {}
			end
		},
		{
			id = "tb_18",
			condition = function()
				local var_10_0 = getProxy(EducateProxy):GetCurTime()

				return var_10_0.month == 3 and var_10_0.week == 2
			end,
			args = function()
				return {}
			end,
			nextOne = function()
				return "tb_19"
			end
		},
		{
			id = "tb_19",
			condition = function()
				local var_13_0 = getProxy(EducateProxy):GetCurTime()
				local var_13_1 = pg.NewStoryMgr.GetInstance():IsPlayed("tb_18")

				var_13_1 = var_13_1 and var_13_0.month == 3 and var_13_0.week == 2

				return var_13_1
			end,
			args = function()
				return {}
			end
		},
		{
			id = "tb_8",
			condition = function()
				return #getProxy(EducateProxy):GetPolaroidList() > 0
			end,
			args = function()
				return pg.NewStoryMgr.GetInstance():IsPlayed("tb_7") and {
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
			id = "tb_12_0",
			condition = function()
				return #getProxy(EducateProxy):GetEventProxy():GetHomeSpecEvents() > 0
			end,
			args = function()
				return {}
			end
		},
		{
			id = "tb_12",
			condition = function()
				return EducateHelper.IsSystemUnlock(EducateConst.SYSTEM_FAVOR_AND_MIND)
			end,
			args = function()
				return {}
			end
		},
		{
			id = "tb_10",
			condition = function()
				local var_21_0 = getProxy(EducateProxy):GetCurTime()
				local var_21_1

				if var_21_0.month == 3 and var_21_0.week == 4 then
					if #getProxy(EducateProxy):GetBuffList() <= 0 then
						var_21_1 = false

						goto label_21_0
					end
				end

				::label_21_0::

				return true
			end,
			args = function()
				return {}
			end
		},
		{
			id = "tb_9_2",
			condition = function()
				local var_23_0 = getProxy(EducateProxy):GetTaskProxy()

				return EducateHelper.IsSameDay(getProxy(EducateProxy):GetCurTime(), var_23_0:GetTargetSetDays()[2]) and pg.child_target_set[var_23_0:GetTargetId()].stage == 2
			end,
			args = function()
				return {}
			end
		},
		{
			id = "tb_11",
			ignorePlayer = true,
			condition = function()
				local var_25_0 = getProxy(EducateProxy):GetCurTime()
				local var_25_1 = getProxy(EducateProxy):GetCharData()

				return var_25_0.month == 4 and var_25_0.week == 1 and var_25_1.site == var_25_1:GetSiteCnt()
			end,
			args = function()
				return {}
			end
		},
		{
			id = "tb_13",
			condition = function()
				local var_27_0 = getProxy(EducateProxy):GetCurTime()

				return var_27_0.month == 4 and var_27_0.week == 3
			end,
			args = function()
				return {}
			end
		},
		{
			id = "tb_14",
			condition = function()
				local var_29_0 = getProxy(EducateProxy):GetCurTime()

				return var_29_0.month == 4 and var_29_0.week == 4
			end,
			args = function()
				return {}
			end
		},
		{
			id = "tb_21",
			condition = function()
				local var_31_0 = getProxy(EducateProxy):GetTaskProxy()

				return EducateHelper.IsSameDay(getProxy(EducateProxy):GetCurTime(), var_31_0:GetTargetSetDays()[3]) and pg.child_target_set[var_31_0:GetTargetId()].stage == 3
			end,
			args = function()
				return {}
			end
		},
		{
			id = "tb_9",
			condition = function()
				local var_33_0 = getProxy(EducateProxy):GetCurTime()

				return var_33_0.month == 6 and var_33_0.week == 1
			end,
			args = function()
				return {}
			end
		},
		{
			id = "tb_22",
			condition = function()
				local var_35_0 = getProxy(EducateProxy):GetTaskProxy()

				return EducateHelper.IsSameDay(getProxy(EducateProxy):GetCurTime(), var_35_0:GetTargetSetDays()[4]) and pg.child_target_set[var_35_0:GetTargetId()].stage == 4
			end,
			args = function()
				return {}
			end
		},
		{
			id = "tb_16",
			condition = function()
				local var_37_0 = getProxy(EducateProxy):GetCurTime()

				return var_37_0.month == 14 and var_37_0.week == 4
			end,
			args = function()
				return {}
			end
		},
		{
			id = "tb_17",
			condition = function()
				return getProxy(EducateProxy):GetGameStatus() == EducateConst.STATUES_RESET
			end,
			args = function()
				return {}
			end
		}
	},
	EducateTargetLayer = {
		{
			id = "tb_3",
			ignorePlayer = true,
			condition = function()
				local var_41_0 = pg.NewStoryMgr.GetInstance():IsPlayed("tb_2")

				var_41_0 = var_41_0 and getProxy(EducateProxy):GetTaskProxy():GetTaskById(EducateConst.MAIN_TASK_ID_2)

				return var_41_0
			end,
			args = function()
				return {}
			end
		}
	},
	EducateCollectEntranceLayer = {
		{
			id = "tb_7",
			condition = function()
				return EducateHelper.IsSystemUnlock(EducateConst.SYSTEM_MEMORY)
			end,
			args = function()
				return {}
			end
		}
	}
}

function EducateGuideSequence:CheckGuide(arg_45_1)
	if not getProxy(EducateProxy):IsFirstGame() then
		arg_45_1()

		return
	end

	local var_45_0 = underscore.detect(EducateGuideSequence.config[self] or {}, function(arg_46_0)
		if not arg_46_0.ignorePlayer then
			local var_46_0

			if not pg.NewStoryMgr.GetInstance():IsPlayed(arg_46_0.id) then
				var_46_0 = arg_46_0.condition()

				goto label_46_0
			end
		end

		var_46_0 = false and true

		::label_46_0::

		return var_46_0
	end)

	if not var_45_0 then
		arg_45_1()

		return
	end

	local var_45_1 = var_45_0.id

	if pg.SeriesGuideMgr.GetInstance():isRunning() then
		arg_45_1()

		return
	end

	if not pg.NewGuideMgr.GetInstance():CanPlay() then
		arg_45_1()

		return
	end

	pg.m02:sendNotification(GAME.STORY_UPDATE, {
		storyId = var_45_1
	})
	pg.NewGuideMgr.GetInstance():Play(var_45_1, var_45_0.args(), function()
		if var_45_0.nextOne then
			local var_47_0, var_47_1 = var_45_0.nextOne()

			EducateGuideSequence.PlayNextOne(var_47_0, var_47_1)
		end

		arg_45_1()

		return
	end, arg_45_1)

	return
end

function EducateGuideSequence:PlayNextOne(arg_48_1)
	if not self then
		return
	end

	pg.NewGuideMgr.GetInstance():Play(self, arg_48_1, function()
		return
	end)
	pg.m02:sendNotification(GAME.STORY_UPDATE, {
		storyId = self
	})

	return
end

return EducateGuideSequence
