class = var_0_10000

local var_0_0 = var_0_10000("LaunchBallActivityMgr")

function var_0_0.GetRoundCount(arg_1_0)
	LaunchBallActivityMgr = var_1_10001

	if not var_1_10001.GetActivityById(arg_1_0) then
		return 0
	end

	if var_1.data1 and var_1.data1 > 0 then
		return var_1.data1
	end

	return 0
end

function var_0_0.GetRoundCountMax(arg_2_0)
	LaunchBallActivityMgr = var_1_10001

	if not var_1_10001.GetActivityById(arg_2_0) then
		return 0
	end

	return #var_1:getConfig("config_data")[1]
end

function var_0_0.GotInvitationFlag(arg_3_0)
	LaunchBallActivityMgr = var_1_10001

	return var_1_10001.GetActivityById(arg_3_0).data3 == 1
end

function var_0_0.GetActivityDay(arg_4_0)
	LaunchBallActivityMgr = var_1_10001

	if var_1_10001.GetActivityById(arg_4_0) then
		return var_1:getDayIndex()
	end

	return 0
end

function var_0_0.GetRemainCount(arg_5_0)
	LaunchBallActivityMgr = var_1_10001

	local var_5_0 = var_1_10001.GetActivityDay(arg_5_0)

	LaunchBallActivityMgr = var_1_10002

	return var_5_0 - var_1_10002.GetRoundCount(arg_5_0)
end

function var_0_0.IsTip(arg_6_0)
	LaunchBallActivityMgr = var_1_10001

	return var_1_10001.GetRemainCount(arg_6_0) > 0
end

function var_0_0.GetInvitationAble(arg_7_0)
	LaunchBallActivityMgr = var_1_10001

	if var_1_10001.GotInvitationFlag(arg_7_0) then
		return false
	end

	LaunchBallActivityMgr = var_1_10002

	local var_7_0 = var_1_10002.GetRoundCount(arg_7_0)

	LaunchBallActivityMgr = var_3

	return var_7_0 >= var_3.GetRoundCountMax(arg_7_0)
end

function var_0_0.GetInvitation(arg_8_0)
	LaunchBallActivityMgr = var_1_10001

	if var_1_10001.GetInvitationAble(arg_8_0) then
		pg = var_1_10002

		local var_8_0 = var_1_10002.m02
		local var_8_1 = var_2.sendNotification

		GAME = var_1_10005

		var_8_1(var_8_0, var_1_10005.ACTIVITY_OPERATION, {
			cmd = 2,
			activity_id = arg_8_0
		})
	end

	return
end

function var_0_0.GetInvitationDropId(arg_9_0)
	LaunchBallActivityMgr = var_1_10001

	local var_9_0 = var_1_10001.GetActivityById(arg_9_0)

	return var_1.getConfig(var_9_0, "config_data")[6]
end

function var_0_0.GetActivityById(arg_10_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_10_0 = var_1_10001(var_1_10003)

	return var_1.getActivityById(var_10_0, arg_10_0)
end

function var_0_0.GetZhuanShuCount(arg_11_0)
	LaunchBallActivityMgr = var_1_10001

	if not var_1_10001.GetActivityById(arg_11_0) then
		return 0
	end

	local var_11_0

	if not var_1.data1_list then
		var_11_0 = {}
	end

	return var_11_0
end

function var_0_0.GetZhuanShuItems(arg_12_0, arg_12_1)
	LaunchBallActivityMgr = var_1_10002

	if not var_1_10002.GetActivityById(arg_12_0) then
		return 0
	end

	return var_2:getConfig("config_data")[4][1][arg_12_1]
end

function var_0_0.IsFinishZhuanShu(arg_13_0, arg_13_1)
	LaunchBallActivityMgr = var_1_10002

	if not var_1_10002.GetActivityById(arg_13_0) then
		return 0
	end

	LaunchBallActivityMgr = var_1_10003

	local var_13_0

	if var_1_10003.GetZhuanShuCount(arg_13_0) then
		::label_13_0::

		table = var_13_0
		var_13_0 = var_13_0.contains(var_3, arg_13_1)
	end

	return var_13_0
end

function var_0_0.CheckZhuanShuAble(arg_14_0, arg_14_1)
	LaunchBallActivityMgr = var_1_10002

	local var_14_0 = var_1_10002.GetZhuanShuItems(arg_14_0, arg_14_1)
	local var_14_1

	if var_14_0 then
		getProxy = var_4
		BagProxy = var_1_10006

		local var_14_2 = var_4(var_1_10006)

		var_14_1 = var_4.getItemById(var_14_2, var_14_0)
	end

	return var_14_1 ~= nil
end

function var_0_0.GetPlayerZhuanshuIndex(arg_15_0)
	if arg_15_0 > 1 then
		return arg_15_0 - 1
	end

	return nil
end

function var_0_0.GetGameScore(arg_16_0, arg_16_1)
	LaunchBallActivityMgr = var_1_10002

	if not var_1_10002.GetActivityById(arg_16_0) then
		return 0
	end

	local var_16_0

	if not var_2.data2 then
		var_16_0 = 0
	end

	return var_16_0
end

function var_0_0.OpenGame(arg_17_0, arg_17_1)
	LaunchBallGameVo = var_1_10002

	var_1_10002.initRoundData(arg_17_0, arg_17_1)

	pg = var_2

	local var_17_0 = var_2.m02
	local var_17_1 = var_2.sendNotification

	GAME = var_5

	var_17_1(var_17_0, var_5.GO_MINI_GAME, 57)

	return
end

function var_0_0.GetGameAward(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	LaunchBallActivityMgr = var_1_10004

	if not var_1_10004.GetActivityById(arg_18_0) then
		return
	end

	LaunchBallActivityMgr = var_1_10005

	local var_18_0 = var_1_10005.GetRoundCount(arg_18_0)

	LaunchBallActivityMgr = var_6

	local var_18_1 = var_6.GetActivityDay(arg_18_0)

	LaunchBallActivityMgr = var_7

	local var_18_2 = var_7.GetRoundCountMax(arg_18_0)
	local var_18_3 = var_4.data2

	LaunchBallActivityMgr = var_9

	local var_18_4 = var_9.GetGameScores(arg_18_0)

	LaunchBallGameConst = var_1_10010

	local var_18_6

	if arg_18_1 == var_1_10010.round_type_juqing then
		if var_18_1 <= var_18_0 then
			print = var_18_6

			var_18_6("活动天数不足")

			return
		end

		if var_18_0 < var_18_2 and arg_18_2 <= var_18_0 then
			print = var_18_6

			var_18_6("已经领过剧情关奖励")

			return
		end

		if var_18_0 + 1 < arg_18_2 then
			print = var_18_6

			var_18_6("上一关还未解锁")

			return
		end

		pg = var_18_6

		local var_18_5 = var_18_6.m02

		var_18_6 = var_18_6.sendNotification
		GAME = var_1_10013

		local var_18_7 = var_1_10013.ACTIVITY_OPERATION

		iter_18_0 = {
			cmd = 1,
			activity_id = arg_18_0,
			arg1 = arg_18_1,
			arg2 = arg_18_2
		}
		math = var_1_10015

		local var_18_8 = var_1_10015.floor

		LaunchBallGameVo = var_1_10017
		iter_18_0.arg3 = var_18_8(var_1_10017.gameStepTime)

		var_18_6(var_18_5, var_18_7, iter_18_0)
	else
		LaunchBallGameConst = var_18_6

		local var_18_9, var_18_11

		if arg_18_1 == var_18_6.round_type_wuxian then
			if var_18_0 < var_18_2 then
				print = var_18_9

				var_18_9("还没有完全通关剧情关卡")

				return
			end

			if arg_18_3 <= var_18_3 then
				print = var_18_9

				var_18_9("没有超过往期的最大分数")

				return
			end

			var_18_9 = false

			for iter_18_0 = 1, #var_18_4 do
				if not var_18_9 and arg_18_3 >= var_18_4[iter_18_0][1] and var_18_3 < var_18_4[iter_18_0][1] then
					var_18_9 = true
				end
			end

			if var_18_9 then
				pg = var_18_11

				local var_18_10 = var_18_11.m02

				var_18_11 = var_18_11.sendNotification
				GAME = iter_18_0
				iter_18_0 = iter_18_0.ACTIVITY_OPERATION

				local var_18_12 = {
					cmd = 1,
					activity_id = arg_18_0,
					arg1 = arg_18_1,
					arg2 = arg_18_3
				}

				math = var_1_10016
				var_1_10016 = var_1_10016.floor
				LaunchBallGameVo = var_1_10018
				var_18_12.arg3 = var_1_10016(var_1_10018.gameStepTime)

				var_18_11(var_18_10, iter_18_0, var_18_12)
			end
		else
			LaunchBallActivityMgr = var_18_9

			if not var_18_9.CheckZhuanShuAble(arg_18_0, arg_18_2) then
				print = var_18_11

				var_18_11("专属关卡没有解锁")

				return
			end

			pg = var_18_11

			local var_18_13 = var_18_11.m02
			local var_18_14 = var_11.sendNotification

			GAME = iter_18_0

			local var_18_15 = iter_18_0.ACTIVITY_OPERATION
			local var_18_16 = {
				cmd = 1,
				activity_id = arg_18_0,
				arg1 = arg_18_1,
				arg2 = arg_18_2
			}

			math = var_1_10016

			local var_18_17 = var_1_10016.floor

			LaunchBallGameVo = var_1_10018
			var_18_16.arg3 = var_18_17(var_1_10018.gameStepTime)

			var_18_14(var_18_13, var_18_15, var_18_16)
		end
	end

	return
end

function var_0_0.GetGameScores(arg_19_0)
	LaunchBallActivityMgr = var_1_10001

	if not var_1_10001.GetActivityById(arg_19_0) then
		return 0
	end

	return var_1:getConfig("config_data")[5]
end

function var_0_0.GetGamePtId(arg_20_0)
	LaunchBallActivityMgr = var_1_10001

	if not var_1_10001.GetActivityById(arg_20_0) then
		return 0
	end

	return var_1:getConfig("config_data")[2]
end

return var_0_0
