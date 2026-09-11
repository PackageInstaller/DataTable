local var_0_0 = {}

manager.net:Bind(78001, function(arg_1_0)
	PushSnowBallData:InitFromServer(arg_1_0)
	var_0_0.InitRedPoint()
	manager.notify:RegistListener(OSIRIS_TASK_UPDATE, function()
		var_0_0.UpdateRedPoint()
	end)
end)
manager.net:Bind(78005, function(arg_3_0)
	PushSnowBallData:OnReceviedSingleBattleResult(arg_3_0)
	var_0_0.UpdateRedPoint()
end)
manager.net:Bind(54111, function(arg_4_0)
	local var_4_0 = ActivityData:GetActivityData(PushSnowBallData:GetActivityID())

	if not var_4_0 or manager.time:GetServerTime() >= var_4_0.stopTime or manager.time:GetServerTime() < var_4_0.startTime then
		return
	end

	PushSnowBallData:OnReceviedTeamBattleResult(arg_4_0)
	var_0_0.UpdateRedPoint()
end)
manager.net:Bind(78009, function(arg_5_0)
	PushSnowBallData:OnUnlockDevice(arg_5_0)
	var_0_0.UpdateDeviceRedPoint()
end)
manager.net:Bind(78013, function(arg_6_0, arg_6_1)
	var_0_0.CancleMatchingResultHandler(arg_6_0, arg_6_1)
end)
manager.net:Bind(78015, function(arg_7_0)
	PushSnowBallData:SetPlayerList(arg_7_0)
	BattleController:LaunchCooperationBattleWithoutRoom(arg_7_0)
end)

function var_0_0.SendEquipDevice(arg_8_0, arg_8_1, arg_8_2)
	manager.net:SendWithLoadingNew(78002, {
		activity_id = arg_8_1,
		equip = arg_8_2
	}, 78003, var_0_0.EquipDeviceResultHandler)
end

function var_0_0:EquipDeviceResultHandler(arg_9_1)
	if isSuccess(self.result) then
		PushSnowBallData:SetSelectedDeviceID(arg_9_1.equip)
	else
		ShowTips(GetTips(self.result))
	end

	manager.notify:Invoke(PUSH_SNOWBALL_EQUIP_DEVICE)
end

function var_0_0.SendStartMatching(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	manager.net:SendWithLoadingNew(78010, {
		dest = arg_10_0,
		battle_type = arg_10_1,
		hero_id = arg_10_2,
		activity_id = arg_10_3
	}, 78011, var_0_0.StartMatchingResultHandler)
end

function var_0_0:StartMatchingResultHandler(arg_11_1)
	if isSuccess(self.result) then
		JumpTools.OpenPageByJump("pushSnowBallMatchPop")
	elseif self.result == 2 then
		ShowTips(string.format(GetTips("ACTIVITY_SNOWBALL_PUSH_ONLINE_DESC"), manager.time:GetLostTimeStr(self.timestamp, nil, true)))
	else
		ShowTips(GetTips(self.result))
	end
end

function var_0_0.SendCancelMatching()
	manager.net:Push(78012, {})
end

function var_0_0:CancleMatchingResultHandler(arg_13_1)
	manager.notify.Invoke(PUSH_SNOWBALL_CANCLE_MATCHING)

	if isSuccess(self.result) then
		-- block empty
	else
		ShowTips(GetTips(self.result))
	end
end

function var_0_0:ReceiveScoreReward(arg_14_1)
	manager.net:SendWithLoadingNew(60054, {
		point_reward_id_list = {
			arg_14_1
		}
	}, 60055, handler(self, self.OnReceiveScoreReward))
end

function var_0_0.OnReceiveScoreReward(arg_15_0, arg_15_1, arg_15_2)
	if isSuccess(arg_15_1.result) then
		PushSnowBallData:ReceiveScoreReward(arg_15_2.point_reward_id_list[1])
		getReward2(arg_15_1.reward_list)
	else
		ShowTips(arg_15_1.result)
	end

	manager.notify:CallUpdateFunc(PUSH_SNOW_BALL_REWAERD_SCORE_TASK)
	var_0_0.UpdateRedPoint()
end

function var_0_0.SendQuitBattle(arg_16_0)
	manager.net:SendWithLoadingNew(78016, {
		battle_id = BattleFieldData:GetServerBattleID()
	}, 78017, function()
		return
	end)
end

function var_0_0.InitRedPoint()
	local var_18_0 = string.format("%s_%s", ActivityTools.GetRedPointKey(PushSnowBallData:GetSingleActivityID()), PushSnowBallData:GetSingleActivityID())
	local var_18_1 = string.format("%s_%s", ActivityTools.GetRedPointKey(PushSnowBallData:GetTeamActivityID()), PushSnowBallData:GetTeamActivityID())

	for iter_18_0 = 1, 3 do
		manager.redPoint:addGroup(RedPointConst.ACTIVITY_PUSH_SNOWBALL_DEVICE_UNLOCK, {
			RedPointConst.ACTIVITY_PUSH_SNOWBALL_DEVICE_UNLOCK .. iter_18_0
		})
		manager.redPoint:addGroup(RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_SCORE, {
			RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_SCORE .. iter_18_0
		})
		manager.redPoint:addGroup(RedPointConst.ACTIVITY_PUSH_SNOWBALL_LEVEL_UNLOCK, {
			RedPointConst.ACTIVITY_PUSH_SNOWBALL_LEVEL_UNLOCK .. iter_18_0
		})
	end

	local var_18_2 = PushSnowBallData:GetTeamWinTaskList()

	if var_18_2 then
		for iter_18_1, iter_18_2 in pairs(var_18_2) do
			manager.redPoint:addGroup(RedPointConst.ACTIVITY_PUSH_SNOWBALL_TEAM_WIN, {
				RedPointConst.ACTIVITY_PUSH_SNOWBALL_TEAM_WIN .. iter_18_2.id
			})
		end
	end

	manager.redPoint:addGroup(var_18_0, {
		RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_REWARD,
		RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_SCORE,
		RedPointConst.ACTIVITY_PUSH_SNOWBALL_LEVEL_UNLOCK
	})
	manager.redPoint:addGroup(var_18_1, {
		RedPointConst.ACTIVITY_PUSH_SNOWBALL_TEAM_WIN,
		RedPointConst.ACTIVITY_PUSH_SNOWBALL_TEAM_PARTICIPATE
	})
	manager.redPoint:addGroup(ActivityTools.GetRedPointKey(PushSnowBallData:GetActivityID()) .. PushSnowBallData:GetActivityID(), {
		var_18_0,
		var_18_1
	})
	var_0_0.UpdateRedPoint()
end

function var_0_0.IsActivityTime()
	if not PushSnowBallData:GetActivityID() then
		return
	end

	local var_19_0 = ActivityData:GetActivityData(PushSnowBallData:GetActivityID())

	if var_19_0.stopTime > manager.time:GetServerTime() and var_19_0.startTime < manager.time:GetServerTime() then
		return true
	end

	return false
end

function var_0_0.UpdateRedPoint()
	local var_20_0 = {}

	if var_0_0.IsActivityTime() then
		var_20_0 = PushSnowBallData:GetTeamWinTaskList()
	end

	for iter_20_0 = 1, 3 do
		manager.redPoint:setTip(RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_SCORE .. iter_20_0, PushSnowBallData:GetHasCompeletedScoreTaskByModel(iter_20_0) and 1 or 0)
	end

	for iter_20_1 = 1, 3 do
		manager.redPoint:setTip(RedPointConst.ACTIVITY_PUSH_SNOWBALL_LEVEL_UNLOCK .. iter_20_1, PushSnowBallData:GetIsNewLevelUnLock(iter_20_1) and not (getData("PushSnowBall", "Level" .. iter_20_1 .. PlayerData:GetPlayerInfo().userID) or false) and 1 or 0)
	end

	if var_20_0 then
		for iter_20_2, iter_20_3 in pairs(var_20_0) do
			manager.redPoint:setTip(RedPointConst.ACTIVITY_PUSH_SNOWBALL_TEAM_WIN .. iter_20_3.id, PushSnowBallData:GetHasCompeletedWinTaskByID(iter_20_3.id) and 1 or 0)
		end
	end

	manager.redPoint:setTip(RedPointConst.ACTIVITY_PUSH_SNOWBALL_SINGLE_REWARD, PushSnowBallData:GetHasCompeletedWeeklyTask() and 1 or 0)
	manager.redPoint:setTip(RedPointConst.ACTIVITY_PUSH_SNOWBALL_TEAM_PARTICIPATE, PushSnowBallData:GetHasCompeletedTeamTask() and 1 or 0)
	var_0_0.UpdateDeviceRedPoint()
end

function var_0_0.UpdateDeviceRedPoint()
	for iter_21_0 = 1, 3 do
		manager.redPoint:setTip(RedPointConst.ACTIVITY_PUSH_SNOWBALL_DEVICE_UNLOCK .. iter_21_0, PushSnowBallData:GetIsDeviceUnlockByID(iter_21_0) and not getData("PushSnowBall", "Device" .. iter_21_0 .. PushSnowBallData:GetActivityID() .. PlayerData:GetPlayerInfo().userID) and 1 or 0)
	end
end

return var_0_0
