class = var_0_10000

local var_0_0 = var_0_10000("NewEducateGuideSequence")

var_0_0.config = {
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
				pg = var_1_10000

				local var_2_0 = var_1_10000.NewStoryMgr.GetInstance()
				local var_2_3

				if var_0.IsPlayed(var_2_0, "tb2_1") then
					getProxy = var_2_3
					NewEducateProxy = var_2_0

					local var_2_1 = var_2_3(var_2_0)
					local var_2_2 = var_2_3.GetCurChar(var_2_1)

					var_2_3 = #var_2_3.GetTalentList(var_2_2) > 0
				end

				return var_2_3
			end
		},
		{
			id = "tb2_3",
			condition = function()
				getProxy = var_1_10000
				NewEducateProxy = var_1_10002

				local var_3_0 = var_1_10000(var_1_10002)
				local var_3_1 = var_0.GetCurChar(var_3_0)
				local var_3_6

				if var_0.GetRoundData(var_3_1).round == 1 then
					getProxy = var_0
					NewEducateProxy = var_3_1

					local var_3_2 = var_0(var_3_1)
					local var_3_3 = var_0.GetCurChar(var_3_2)
					local var_3_4 = var_0.GetFSM(var_3_3)
					local var_3_5 = var_0.GetState

					NewEducateFSM = var_1_10003
					var_3_6 = not var_3_5(var_3_4, var_1_10003.SYSTEM.TOPIC)
				else
					var_3_6 = false
				end

				if false then
					var_3_6 = true
				end

				return var_3_6
			end
		},
		{
			id = "tb2_4",
			condition = function()
				pg = var_1_10000

				local var_4_0 = var_1_10000.NewStoryMgr.GetInstance()

				return var_0.IsPlayed(var_4_0, "tb2_3")
			end,
			nextOne = function()
				return "tb2_5"
			end
		},
		{
			id = "tb2_5",
			condition = function()
				getProxy = var_1_10000
				NewEducateProxy = var_1_10002

				local var_6_0 = var_1_10000(var_1_10002)
				local var_6_1 = var_0.GetCurChar(var_6_0)

				return var_0.GetRoundData(var_6_1).round == 1
			end,
			nextOne = function()
				return "tb2_6"
			end
		},
		{
			id = "tb2_6",
			condition = function()
				pg = var_1_10000

				local var_8_0 = var_1_10000.NewStoryMgr.GetInstance()

				return var_0.IsPlayed(var_8_0, "tb2_5")
			end,
			nextOne = function()
				return "tb2_7"
			end
		},
		{
			id = "tb2_7",
			condition = function()
				pg = var_1_10000

				local var_10_0 = var_1_10000.NewStoryMgr.GetInstance()

				return var_0.IsPlayed(var_10_0, "tb2_6")
			end
		},
		{
			id = "tb2_9",
			condition = function()
				getProxy = var_1_10000
				NewEducateProxy = var_1_10002

				local var_11_0 = var_1_10000(var_1_10002)
				local var_11_1 = var_0.GetCurChar(var_11_0)

				return var_0.GetRoundData(var_11_1).round == 2
			end,
			nextOne = function()
				return "tb2_10"
			end
		},
		{
			id = "tb2_10",
			condition = function()
				pg = var_1_10000

				local var_13_0 = var_1_10000.NewStoryMgr.GetInstance()

				return var_0.IsPlayed(var_13_0, "tb2_9")
			end
		},
		{
			id = "tb2_11",
			condition = function()
				getProxy = var_1_10000
				NewEducateProxy = var_1_10002

				local var_14_0 = var_1_10000(var_1_10002)
				local var_14_1 = var_0.GetCurChar(var_14_0)

				return var_0.IsUnlock(var_14_1, "rand_event")
			end
		},
		{
			id = "tb2_13",
			condition = function()
				getProxy = var_1_10000
				NewEducateProxy = var_1_10002

				local var_15_0 = var_1_10000(var_1_10002)
				local var_15_1 = var_0.GetCurChar(var_15_0)

				return var_0.IsUnlock(var_15_1, "char_event")
			end
		},
		{
			id = "tb2_15",
			condition = function()
				getProxy = var_1_10000
				NewEducateProxy = var_1_10002

				local var_16_0 = var_1_10000(var_1_10002)
				local var_16_1 = var_0.GetCurChar(var_16_0)

				return var_0.IsUnlock(var_16_1, "shop")
			end
		},
		{
			id = "tb2_17",
			condition = function()
				getProxy = var_1_10000
				NewEducateProxy = var_1_10002

				local var_17_0 = var_1_10000(var_1_10002)
				local var_17_1 = var_0.GetCurChar(var_17_0)
				local var_17_2 = var_0.GetPermanentData(var_17_1)

				return var_0.IsTarotType(var_17_2)
			end
		},
		{
			id = "tb2_18",
			condition = function()
				getProxy = var_1_10000
				NewEducateProxy = var_1_10002

				local var_18_0 = var_1_10000(var_1_10002)
				local var_18_1 = var_0.GetCurChar(var_18_0)
				local var_18_2 = var_0.GetRoundData(var_18_1)

				if not var_1.ExistEndless(var_18_2) then
					return false
				end

				local var_18_3 = var_0:GetFSM()
				local var_18_4 = var_1.GetSystemNo(var_18_3)

				NewEducateFSM = var_18_0

				if var_18_4 ~= var_18_0.SYSTEM.ENDING then
					return false
				end

				local var_18_5 = var_0:GetFSM()
				local var_18_6 = var_2.GetState

				NewEducateFSM = var_1_10005

				return var_18_6(var_18_5, var_1_10005.SYSTEM.ENDING) and var_2:IsFinish()
			end
		}
	},
	NewEducateScheduleScene = {
		{
			id = "tb2_8",
			condition = function()
				pg = var_1_10000

				local var_19_0 = var_1_10000.NewStoryMgr.GetInstance()

				return var_0.IsPlayed(var_19_0, "tb2_7")
			end
		},
		{
			id = "tb2_14",
			condition = function()
				getProxy = var_1_10000
				NewEducateProxy = var_1_10002

				local var_20_0 = var_1_10000(var_1_10002)
				local var_20_1 = var_0.GetCurChar(var_20_0)

				return var_0.IsUnlock(var_20_1, "lesson_upgrade")
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

function var_0_0.CheckGuide(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1 or function()
		return
	end

	NewEducateConst = var_1_10003

	if var_1_10003.LOCK_GUIDE then
		var_23_0()

		return
	end

	getProxy = var_3
	NewEducateProxy = var_1_10005

	local var_23_1 = var_3(var_1_10005)
	local var_23_2 = var_3.GetCurChar(var_23_1)

	if var_3.GetGameCnt(var_23_2) == 1 then
		local var_23_3 = var_3:GetRoundData()

		if var_4.IsTemp(var_23_3) then
			var_23_0()

			return
		end

		local var_23_4

		if not var_0_0.config[arg_23_0] then
			var_23_4 = {}
		end

		underscore = var_23_1

		if not var_23_1.detect(var_23_4, function(arg_25_0)
			local var_25_0 = arg_25_0.id
			local var_25_1 = arg_25_0.condition

			pg = var_2_10003

			local var_25_2 = var_2_10003.NewStoryMgr.GetInstance()

			return not var_3.IsPlayed(var_25_2, var_25_0) and var_25_1()
		end) then
			var_23_0()

			return
		end

		local var_23_5 = var_5.id
		local var_23_6 = {
			var_3.id
		}

		pg = var_8

		local var_23_7 = var_8.SeriesGuideMgr.GetInstance()

		if var_8.isRunning(var_23_7) then
			var_23_0()

			return
		end

		pg = var_8

		local var_23_8 = var_8.NewGuideMgr.GetInstance()

		if not var_8.CanPlay(var_23_8) then
			var_23_0()

			return
		end

		pg = var_8

		local var_23_9 = var_8.m02
		local var_23_10 = var_8.sendNotification

		GAME = var_1_10011

		var_23_10(var_23_9, var_1_10011.STORY_UPDATE, {
			storyId = var_23_5
		})

		pg = var_23_10

		local var_23_11 = var_23_10.NewGuideMgr.GetInstance()

		var_8.Play(var_23_11, var_23_5, var_23_6, function()
			if var_0.nextOne then
				local var_26_0 = var_0.nextOne()

				var_0_0.PlayNextOne(var_26_0, var_23_6)
			end

			return
		end, var_23_0)

		return
	end
end

function var_0_0.PlayNextOne(arg_27_0, arg_27_1)
	if not arg_27_0 then
		return
	end

	pg = var_1_10002

	local var_27_0 = var_1_10002.NewGuideMgr.GetInstance()

	var_2.Play(var_27_0, arg_27_0, arg_27_1, function()
		return
	end)

	pg = var_2

	local var_27_1 = var_2.m02
	local var_27_2 = var_2.sendNotification

	GAME = var_5

	var_27_2(var_27_1, var_5.STORY_UPDATE, {
		storyId = arg_27_0
	})

	return
end

return var_0_0
