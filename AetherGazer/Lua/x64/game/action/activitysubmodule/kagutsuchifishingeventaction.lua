local var_0_0 = {}

manager.net:Bind(76001, function(arg_1_0)
	KagutsuchiFishingEventData:InitFromServer(arg_1_0)
end)
manager.notify:RegistListener(NEW_DAY, function()
	KagutsuchiFishingEventData.dailyGameCount = 0

	manager.notify:CallUpdateFunc("UpdateFishingGameCount")
end)

local function var_0_1()
	if KagutsuchiWorkData then
		return KagutsuchiWorkData:GetStamina()
	end

	return 0
end

function var_0_0.SendFishingSuccess(arg_4_0, arg_4_1)
	local var_4_0 = KagutsuchiFishingEventData.GetInstance().activityID
	local var_4_1 = var_0_1()
	local var_4_2 = math.min(GameSetting.activity_kagutsuchi_fatigue_fish_recover.value[1], GameSetting.activity_kagutsuchi_battle_fatigue_max.value[1] - var_4_1)
	local var_4_3 = math.max(0, var_4_2)

	local function var_4_4(arg_5_0)
		local var_5_0 = isSuccess(arg_5_0.result)

		if var_5_0 then
			-- block empty
		else
			ShowTips(arg_5_0.result)
		end

		local var_5_1 = KagutsuchiFishingEventData:GetRarity(arg_4_0)

		KagutsuchiFishingEventData:OnFishingGameFinish(arg_4_0, var_5_0)
		manager.notify:Invoke(KAGUTSUCHI_FISHING_EVENT_QTE_FINISH, arg_4_0, var_5_0, var_5_0 and var_4_3 or 0, var_5_0 and var_5_1)

		if arg_4_1 then
			arg_4_1()
		end
	end

	manager.net:SendWithLoadingNew(76006, {
		activity_id = var_4_0,
		fish_id = arg_4_0
	}, 76007, var_4_4)
end

return var_0_0
