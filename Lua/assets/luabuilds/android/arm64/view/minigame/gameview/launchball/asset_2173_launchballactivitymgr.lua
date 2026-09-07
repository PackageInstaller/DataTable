local LaunchBallActivityMgr = class("LaunchBallActivityMgr")

function LaunchBallActivityMgr:GetRoundCount()
	local var_1_0 = LaunchBallActivityMgr.GetActivityById(self)

	if not var_1_0 then
		return 0
	end

	if var_1_0.data1 and var_1_0.data1 > 0 then
		return var_1_0.data1
	end

	return 0
end

function LaunchBallActivityMgr:GetRoundCountMax()
	local var_2_0 = LaunchBallActivityMgr.GetActivityById(self)

	if not var_2_0 then
		return 0
	end

	return #var_2_0:getConfig("config_data")[1]
end

function LaunchBallActivityMgr:GotInvitationFlag()
	return LaunchBallActivityMgr.GetActivityById(self).data3 == 1
end

function LaunchBallActivityMgr:GetActivityDay()
	local var_4_0 = LaunchBallActivityMgr.GetActivityById(self)

	if var_4_0 then
		return var_4_0:getDayIndex()
	end

	return 0
end

function LaunchBallActivityMgr:GetRemainCount()
	return LaunchBallActivityMgr.GetActivityDay(self) - LaunchBallActivityMgr.GetRoundCount(self)
end

function LaunchBallActivityMgr:IsTip()
	return LaunchBallActivityMgr.GetRemainCount(self) > 0
end

function LaunchBallActivityMgr:GetInvitationAble()
	if LaunchBallActivityMgr.GotInvitationFlag(self) then
		return false
	end

	return LaunchBallActivityMgr.GetRoundCount(self) >= LaunchBallActivityMgr.GetRoundCountMax(self)
end

function LaunchBallActivityMgr:GetInvitation()
	if LaunchBallActivityMgr.GetInvitationAble(self) then
		pg.m02:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 2,
			activity_id = self
		})
	end

	return
end

function LaunchBallActivityMgr:GetInvitationDropId()
	return LaunchBallActivityMgr.GetActivityById(self):getConfig("config_data")[6]
end

function LaunchBallActivityMgr:GetActivityById()
	return getProxy(ActivityProxy):getActivityById(self)
end

function LaunchBallActivityMgr:GetZhuanShuCount()
	local var_11_0 = LaunchBallActivityMgr.GetActivityById(self)

	if not var_11_0 then
		return 0
	end

	return var_11_0.data1_list or {}
end

function LaunchBallActivityMgr:GetZhuanShuItems(arg_12_1)
	local var_12_0 = LaunchBallActivityMgr.GetActivityById(self)

	if not var_12_0 then
		return 0
	end

	return var_12_0:getConfig("config_data")[4][1][arg_12_1]
end

function LaunchBallActivityMgr:IsFinishZhuanShu(arg_13_1)
	if not LaunchBallActivityMgr.GetActivityById(self) then
		return 0
	end

	local var_13_0 = LaunchBallActivityMgr.GetZhuanShuCount(self)

	return var_13_0 and table.contains(var_13_0, arg_13_1)
end

function LaunchBallActivityMgr:CheckZhuanShuAble(arg_14_1)
	local var_14_0 = LaunchBallActivityMgr.GetZhuanShuItems(self, arg_14_1)

	return ((var_14_0 or nil) and getProxy(BagProxy):getItemById(var_14_0)) ~= nil
end

function LaunchBallActivityMgr:GetPlayerZhuanshuIndex()
	if self > 1 then
		return self - 1
	end

	return nil
end

function LaunchBallActivityMgr:GetGameScore(arg_16_1)
	local var_16_0 = LaunchBallActivityMgr.GetActivityById(self)

	if not var_16_0 then
		return 0
	end

	return var_16_0.data2 or 0
end

function LaunchBallActivityMgr:OpenGame(arg_17_1)
	LaunchBallGameVo.initRoundData(self, arg_17_1)
	pg.m02:sendNotification(GAME.GO_MINI_GAME, 57)

	return
end

function LaunchBallActivityMgr:GetGameAward(arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = LaunchBallActivityMgr.GetActivityById(self)

	if not var_18_0 then
		return
	end

	local var_18_1 = LaunchBallActivityMgr.GetRoundCount(self)
	local var_18_2 = LaunchBallActivityMgr.GetRoundCountMax(self)
	local var_18_3 = LaunchBallActivityMgr.GetGameScores(self)

	if arg_18_1 == LaunchBallGameConst.round_type_juqing then
		if LaunchBallActivityMgr.GetActivityDay(self) <= var_18_1 then
			print("活动天数不足")

			return
		end

		if var_18_1 < var_18_2 and arg_18_2 <= var_18_1 then
			print("已经领过剧情关奖励")

			return
		end

		if arg_18_2 > var_18_1 + 1 then
			print("上一关还未解锁")

			return
		end

		pg.m02:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = self,
			arg1 = arg_18_1,
			arg2 = arg_18_2,
			arg3 = math.floor(LaunchBallGameVo.gameStepTime)
		})
	elseif arg_18_1 == LaunchBallGameConst.round_type_wuxian then
		if var_18_1 < var_18_2 then
			print("还没有完全通关剧情关卡")

			return
		end

		if arg_18_3 <= var_18_0.data2 then
			print("没有超过往期的最大分数")

			return
		end

		local var_18_4 = false

		for iter_18_0 = 1, #var_18_3 do
			if not var_18_4 and arg_18_3 >= var_18_3[iter_18_0][1] and var_18_0.data2 < var_18_3[iter_18_0][1] then
				var_18_4 = true
			end
		end

		if var_18_4 then
			pg.m02:sendNotification(GAME.ACTIVITY_OPERATION, {
				cmd = 1,
				activity_id = self,
				arg1 = arg_18_1,
				arg2 = arg_18_3,
				arg3 = math.floor(LaunchBallGameVo.gameStepTime)
			})
		end
	else
		if not LaunchBallActivityMgr.CheckZhuanShuAble(self, arg_18_2) then
			print("专属关卡没有解锁")

			return
		end

		pg.m02:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = self,
			arg1 = arg_18_1,
			arg2 = arg_18_2,
			arg3 = math.floor(LaunchBallGameVo.gameStepTime)
		})
	end

	return
end

function LaunchBallActivityMgr:GetGameScores()
	local var_19_0 = LaunchBallActivityMgr.GetActivityById(self)

	if not var_19_0 then
		return 0
	end

	return var_19_0:getConfig("config_data")[5]
end

function LaunchBallActivityMgr:GetGamePtId()
	local var_20_0 = LaunchBallActivityMgr.GetActivityById(self)

	if not var_20_0 then
		return 0
	end

	return var_20_0:getConfig("config_data")[2]
end

return LaunchBallActivityMgr
