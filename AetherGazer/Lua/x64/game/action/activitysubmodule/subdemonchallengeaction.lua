local var_0_0 = {}
local var_0_1 = false

function var_0_0.Init()
	SubDemonChallengeData:InitData()

	if var_0_1 then
		return
	end

	manager.net:Bind(11031, function(arg_2_0)
		SubDemonChallengeData:SetData(arg_2_0.activity_info)
		var_0_0.UpdateRedPoint(arg_2_0.activity_info.activity_id)
	end)

	var_0_1 = true
end

local var_0_2

function var_0_0.GetChallengeReward(arg_3_0, arg_3_1)
	local var_3_0 = {
		id = arg_3_0
	}

	var_0_2 = arg_3_1

	manager.net:SendWithLoadingNew(11032, var_3_0, 11033, var_0_0.OnGetChallengeReward)
end

function var_0_0.OnGetChallengeReward(arg_4_0, arg_4_1)
	if isSuccess(arg_4_0.result) then
		if var_0_2 then
			SubDemonChallengeData:SetRewardState(var_0_2, arg_4_1.id, ActivityConst.DEMON_CHALLENGE_REWARD_STATE.RECEIVED)
		end

		getReward2(arg_4_0.item_list)

		if var_0_2 then
			var_0_0.UpdateRedPoint(var_0_2)
		end
	end

	manager.notify:CallUpdateFunc(DEMON_CHALLENGE_RECEIVE_REWARD, arg_4_0, arg_4_1)
end

function var_0_0.SetSelectedActivityId(arg_5_0)
	SubDemonChallengeData:AddSelectedActivityId(arg_5_0)
	var_0_0.UpdateRedPoint(arg_5_0)
end

function var_0_0.InitRedPointKey(arg_6_0)
	local var_6_0 = ActivityData:GetActivityData(arg_6_0).subActivityIdList
	local var_6_1 = {}

	for iter_6_0 = 1, #var_6_0 do
		local var_6_2 = RedPointConst.DEMON_CHALLENGE .. var_6_0[iter_6_0]

		manager.redPoint:addGroup(var_6_2, {
			RedPointConst.DEMON_CHALLENGE_REWARD .. var_6_0[iter_6_0],
			RedPointConst.DEMON_CHALLENGE_UNFINISH .. var_6_0[iter_6_0]
		})
		table.insert(var_6_1, var_6_2)
	end

	manager.redPoint:addGroup(RedPointConst.DEMON_CHALLENGE .. arg_6_0, var_6_1)
end

function var_0_0.UpdateRedPoint(arg_7_0)
	if not ActivityData:GetActivityIsOpen(arg_7_0) then
		return
	end

	local var_7_0 = SubDemonChallengeData:GetChallengeInfo(arg_7_0)
	local var_7_1 = false
	local var_7_2 = true

	if var_7_0 then
		for iter_7_0, iter_7_1 in pairs(var_7_0.challengeInfo) do
			local var_7_3 = iter_7_1.challenge_state
			local var_7_4 = iter_7_1.reward_state

			if var_7_3 > ActivityConst.DEMON_CHALLENGE_STATE.UNFINISHED and var_7_4 == ActivityConst.DEMON_CHALLENGE_REWARD_STATE.UNRECEIVE then
				var_7_1 = true
			elseif var_7_3 == ActivityConst.DEMON_CHALLENGE_STATE.FINISHED then
				var_7_2 = false
			end
		end
	end

	manager.redPoint:setTip(RedPointConst.DEMON_CHALLENGE_REWARD .. arg_7_0, var_7_1 and 1 or 0)

	local var_7_5 = getData("DemonChallenge" .. "_" .. USER_ID, tostring(arg_7_0)) or 0

	if not manager.time:IsToday(var_7_5) and var_7_2 and not SubDemonChallengeData:GetIsSelected(arg_7_0) then
		manager.redPoint:setTip(RedPointConst.DEMON_CHALLENGE_REWARD .. arg_7_0, 1)
	else
		manager.redPoint:setTip(RedPointConst.DEMON_CHALLENGE_UNFINISH .. arg_7_0, 0)
	end
end

function var_0_0.RefreshRedPoint(arg_8_0)
	if manager.time:GetServerTime() >= ActivityData:GetActivityData(arg_8_0).stopTime then
		local var_8_0 = ActivityData:GetActivityData(arg_8_0).subActivityIdList

		for iter_8_0, iter_8_1 in ipairs(var_8_0) do
			manager.redPoint:setTip(RedPointConst.DEMON_CHALLENGE_REWARD .. iter_8_1, 0)
			manager.redPoint:setTip(RedPointConst.DEMON_CHALLENGE_UNFINISH .. iter_8_1, 0)
		end
	end
end

return var_0_0
