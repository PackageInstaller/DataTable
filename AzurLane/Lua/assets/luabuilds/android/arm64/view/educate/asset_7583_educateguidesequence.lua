class = var_0_10000

local var_0_0 = var_0_10000("EducateGuideSequence")

var_0_0.config = {
	EducateScene = {
		{
			ignorePlayer = true,
			id = "tb_1",
			condition = function()
				getProxy = var_1_10000
				EducateProxy = var_1_10002

				local var_1_0 = var_1_10000(var_1_10002)
				local var_1_1 = var_0.GetTaskProxy(var_1_0)
				local var_1_2 = var_0.GetTaskById

				EducateConst = var_1_10003

				return var_1_2(var_1_1, var_1_10003.MAIN_TASK_ID_1)
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
				pg = var_1_10000

				local var_4_0 = var_1_10000.NewStoryMgr.GetInstance()
				local var_4_3

				if var_0.IsPlayed(var_4_0, "tb_1") then
					getProxy = var_4_3
					EducateProxy = var_4_0

					local var_4_1 = var_4_3(var_4_0)
					local var_4_2 = var_4_3.GetTaskProxy(var_4_1)

					var_4_3 = var_4_3.GetTargetId(var_4_2) == 0
				end

				return var_4_3
			end,
			args = function()
				return {}
			end
		},
		{
			id = "tb_4",
			condition = function()
				getProxy = var_1_10000
				EducateProxy = var_1_10002

				local var_6_0 = var_1_10000(var_1_10002)
				local var_6_1 = var_0.GetCurTime(var_6_0)

				pg = var_1_10001

				local var_6_2 = var_1_10001.NewStoryMgr.GetInstance()
				local var_6_3

				if var_1.IsPlayed(var_6_2, "tb_3") then
					var_6_3 = var_6_1.month == 2 and var_6_1.week == 4
				end

				return var_6_3
			end,
			args = function()
				return {}
			end
		},
		{
			id = "tb_5",
			condition = function()
				getProxy = var_1_10000
				EducateProxy = var_1_10002

				local var_8_0 = var_1_10000(var_1_10002)

				return var_0.GetCurTime(var_8_0).month ~= 2
			end,
			args = function()
				return {}
			end
		},
		{
			id = "tb_18",
			condition = function()
				getProxy = var_1_10000
				EducateProxy = var_1_10002

				local var_10_0 = var_1_10000(var_1_10002)

				return var_0.GetCurTime(var_10_0).month == 3 and var_0.week == 2
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
				getProxy = var_1_10000
				EducateProxy = var_1_10002

				local var_13_0 = var_1_10000(var_1_10002)
				local var_13_1 = var_0.GetCurTime(var_13_0)

				pg = var_1_10001

				local var_13_2 = var_1_10001.NewStoryMgr.GetInstance()
				local var_13_3

				if var_1.IsPlayed(var_13_2, "tb_18") then
					var_13_3 = var_13_1.month == 3 and var_13_1.week == 2
				end

				return var_13_3
			end,
			args = function()
				return {}
			end
		},
		{
			id = "tb_8",
			condition = function()
				getProxy = var_1_10000
				EducateProxy = var_1_10002

				local var_15_0 = var_1_10000(var_1_10002)

				return #var_0.GetPolaroidList(var_15_0) > 0
			end,
			args = function()
				pg = var_1_10000

				local var_16_0 = var_1_10000.NewStoryMgr.GetInstance()
				local var_16_1

				if not var_0.IsPlayed(var_16_0, "tb_7") or not {
					1,
					3
				} then
					var_16_1 = {
						1,
						2,
						3
					}
				end

				return var_16_1
			end
		},
		{
			id = "tb_12_0",
			condition = function()
				getProxy = var_1_10000
				EducateProxy = var_1_10002

				local var_17_0 = var_1_10000(var_1_10002)
				local var_17_1 = var_0.GetEventProxy(var_17_0)

				return #var_0.GetHomeSpecEvents(var_17_1) > 0
			end,
			args = function()
				return {}
			end
		},
		{
			id = "tb_12",
			condition = function()
				EducateHelper = var_1_10000

				local var_19_0 = var_1_10000.IsSystemUnlock

				EducateConst = var_1_10002

				return var_19_0(var_1_10002.SYSTEM_FAVOR_AND_MIND)
			end,
			args = function()
				return {}
			end
		},
		{
			id = "tb_10",
			condition = function()
				getProxy = var_1_10000
				EducateProxy = var_1_10002

				local var_21_0 = var_1_10000(var_1_10002)

				if var_0.GetCurTime(var_21_0).month == 3 and var_0.week == 4 then
					getProxy = var_1
					EducateProxy = var_1_10003

					local var_21_1 = var_1(var_1_10003)
					local var_21_2

					if not (#var_1.GetBuffList(var_21_1) > 0) then
						var_21_2 = false
					else
						var_21_2 = true
					end

					return var_21_2
				end
			end,
			args = function()
				return {}
			end
		},
		{
			id = "tb_9_2",
			condition = function()
				getProxy = var_1_10000
				EducateProxy = var_1_10002

				local var_23_0 = var_1_10000(var_1_10002)
				local var_23_1 = var_0.GetTaskProxy(var_23_0)
				local var_23_2 = var_0.GetTargetId(var_23_1)
				local var_23_3 = var_0
				local var_23_4 = var_0.GetTargetSetDays(var_23_3)

				getProxy = var_23_1
				EducateProxy = var_1_10005

				local var_23_5 = var_23_1(var_1_10005)
				local var_23_6 = var_3.GetCurTime(var_23_5)

				EducateHelper = var_23_3

				local var_23_7

				if var_23_3.IsSameDay(var_23_6, var_23_4[2]) then
					pg = var_23_7
					var_23_7 = var_23_7.child_target_set[var_23_2].stage == 2
				end

				return var_23_7
			end,
			args = function()
				return {}
			end
		},
		{
			id = "tb_11",
			ignorePlayer = true,
			condition = function()
				getProxy = var_1_10000
				EducateProxy = var_1_10002

				local var_25_0 = var_1_10000(var_1_10002)
				local var_25_1 = var_0.GetCurTime(var_25_0)

				getProxy = var_1_10001
				EducateProxy = var_1_10003

				local var_25_2 = var_1_10001(var_1_10003)
				local var_25_3 = var_1.GetCharData(var_25_2)

				return var_25_1.month == 4 and var_25_1.week == 1 and var_25_3.site == var_25_3:GetSiteCnt()
			end,
			args = function()
				return {}
			end
		},
		{
			id = "tb_13",
			condition = function()
				getProxy = var_1_10000
				EducateProxy = var_1_10002

				local var_27_0 = var_1_10000(var_1_10002)

				return var_0.GetCurTime(var_27_0).month == 4 and var_0.week == 3
			end,
			args = function()
				return {}
			end
		},
		{
			id = "tb_14",
			condition = function()
				getProxy = var_1_10000
				EducateProxy = var_1_10002

				local var_29_0 = var_1_10000(var_1_10002)

				return var_0.GetCurTime(var_29_0).month == 4 and var_0.week == 4
			end,
			args = function()
				return {}
			end
		},
		{
			id = "tb_21",
			condition = function()
				getProxy = var_1_10000
				EducateProxy = var_1_10002

				local var_31_0 = var_1_10000(var_1_10002)
				local var_31_1 = var_0.GetTaskProxy(var_31_0)
				local var_31_2 = var_0.GetTargetId(var_31_1)
				local var_31_3 = var_0
				local var_31_4 = var_0.GetTargetSetDays(var_31_3)

				getProxy = var_31_1
				EducateProxy = var_1_10005

				local var_31_5 = var_31_1(var_1_10005)
				local var_31_6 = var_3.GetCurTime(var_31_5)

				EducateHelper = var_31_3

				local var_31_7

				if var_31_3.IsSameDay(var_31_6, var_31_4[3]) then
					pg = var_31_7
					var_31_7 = var_31_7.child_target_set[var_31_2].stage == 3
				end

				return var_31_7
			end,
			args = function()
				return {}
			end
		},
		{
			id = "tb_9",
			condition = function()
				getProxy = var_1_10000
				EducateProxy = var_1_10002

				local var_33_0 = var_1_10000(var_1_10002)

				return var_0.GetCurTime(var_33_0).month == 6 and var_0.week == 1
			end,
			args = function()
				return {}
			end
		},
		{
			id = "tb_22",
			condition = function()
				getProxy = var_1_10000
				EducateProxy = var_1_10002

				local var_35_0 = var_1_10000(var_1_10002)
				local var_35_1 = var_0.GetTaskProxy(var_35_0)
				local var_35_2 = var_0.GetTargetId(var_35_1)
				local var_35_3 = var_0
				local var_35_4 = var_0.GetTargetSetDays(var_35_3)

				getProxy = var_35_1
				EducateProxy = var_1_10005

				local var_35_5 = var_35_1(var_1_10005)
				local var_35_6 = var_3.GetCurTime(var_35_5)

				EducateHelper = var_35_3

				local var_35_7

				if var_35_3.IsSameDay(var_35_6, var_35_4[4]) then
					pg = var_35_7
					var_35_7 = var_35_7.child_target_set[var_35_2].stage == 4
				end

				return var_35_7
			end,
			args = function()
				return {}
			end
		},
		{
			id = "tb_16",
			condition = function()
				getProxy = var_1_10000
				EducateProxy = var_1_10002

				local var_37_0 = var_1_10000(var_1_10002)

				return var_0.GetCurTime(var_37_0).month == 14 and var_0.week == 4
			end,
			args = function()
				return {}
			end
		},
		{
			id = "tb_17",
			condition = function()
				getProxy = var_1_10000
				EducateProxy = var_1_10002

				local var_39_0 = var_1_10000(var_1_10002)
				local var_39_1 = var_0.GetGameStatus(var_39_0)

				EducateConst = var_1_10001

				return var_39_1 == var_1_10001.STATUES_RESET
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
				pg = var_1_10000

				local var_41_0 = var_1_10000.NewStoryMgr.GetInstance()
				local var_41_3

				if var_0.IsPlayed(var_41_0, "tb_2") then
					getProxy = var_41_3
					EducateProxy = var_41_0

					local var_41_1 = var_41_3(var_41_0)
					local var_41_2 = var_41_3.GetTaskProxy(var_41_1)

					var_41_3 = var_41_3.GetTaskById
					EducateConst = var_3
					var_41_3 = var_41_3(var_41_2, var_3.MAIN_TASK_ID_2)
				end

				return var_41_3
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
				EducateHelper = var_1_10000

				local var_43_0 = var_1_10000.IsSystemUnlock

				EducateConst = var_1_10002

				return var_43_0(var_1_10002.SYSTEM_MEMORY)
			end,
			args = function()
				return {}
			end
		}
	}
}

function var_0_0.CheckGuide(arg_45_0, arg_45_1)
	getProxy = var_1_10002
	EducateProxy = var_1_10004

	local var_45_0 = var_1_10002(var_1_10004)

	if not var_2.IsFirstGame(var_45_0) then
		arg_45_1()

		return
	end

	local var_45_1

	if not var_0_0.config[arg_45_0] then
		var_45_1 = {}
	end

	underscore = var_1_10003

	if not var_1_10003.detect(var_45_1, function(arg_46_0)
		local var_46_0 = arg_46_0.id
		local var_46_1 = arg_46_0.condition

		if not arg_46_0.ignorePlayer then
			pg = var_3

			local var_46_2 = var_3.NewStoryMgr.GetInstance()
			local var_46_3

			if not var_3.IsPlayed(var_46_2, var_46_0) then
				var_46_3 = var_46_1()
			else
				var_46_3 = false
			end

			if false then
				var_46_3 = true
			end

			return var_46_3
		end
	end) then
		arg_45_1()

		return
	end

	local var_45_2 = var_3.id
	local var_45_3 = var_3.args()

	pg = var_1_10007

	local var_45_4 = var_1_10007.SeriesGuideMgr.GetInstance()

	if var_7.isRunning(var_45_4) then
		arg_45_1()

		return
	end

	pg = var_7

	local var_45_5 = var_7.NewGuideMgr.GetInstance()

	if not var_7.CanPlay(var_45_5) then
		arg_45_1()

		return
	end

	pg = var_7

	local var_45_6 = var_7.m02
	local var_45_7 = var_7.sendNotification

	GAME = var_1_10010

	var_45_7(var_45_6, var_1_10010.STORY_UPDATE, {
		storyId = var_45_2
	})

	pg = var_45_7

	local var_45_8 = var_45_7.NewGuideMgr.GetInstance()

	var_7.Play(var_45_8, var_45_2, var_45_3, function()
		if var_0.nextOne then
			local var_47_0, var_47_1 = var_0.nextOne()

			var_0_0.PlayNextOne(var_47_0, var_47_1)
		end

		arg_45_1()

		return
	end, arg_45_1)

	return
end

function var_0_0.PlayNextOne(arg_48_0, arg_48_1)
	if not arg_48_0 then
		return
	end

	pg = var_1_10002

	local var_48_0 = var_1_10002.NewGuideMgr.GetInstance()

	var_2.Play(var_48_0, arg_48_0, arg_48_1, function()
		return
	end)

	pg = var_2

	local var_48_1 = var_2.m02
	local var_48_2 = var_2.sendNotification

	GAME = var_5

	var_48_2(var_48_1, var_5.STORY_UPDATE, {
		storyId = arg_48_0
	})

	return
end

return var_0_0
