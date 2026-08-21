local var_0_0 = {}

local function var_0_1(...)
	local var_1_0 = {
		...
	}

	if var_0_0.waitTask then
		var_0_0.waitTask:Abort()
	end

	var_0_0.waitTask = DormCharacterActionManager.taskRunner:NewTask()

	var_0_0.waitTask:WaitForSec(1.6):Then(function()
		manager.notify:CallUpdateFunc("EndFishingGame", unpack(var_1_0))

		var_0_0.waitTask = nil
	end)
	var_0_0.waitTask:Start()
	SDKTools.SendMessageToSDK("activity_kagutsuchi_fish", {
		activity_id = KagutsuchiFishingEventData.activityID,
		reward = var_1_0[1],
		result = var_1_0[2] and 1 or 2
	})
end

function var_0_0.Enter(arg_3_0)
	manager.ui:SetMainCamera("fishing")

	arg_3_0.game = FishingGame.New()

	gameContext:Go("/kagutsuchiFishingGameEnter")
	manager.notify:RegistListener(KAGUTSUCHI_FISHING_EVENT_QTE_FINISH, var_0_1)
	arg_3_0.game:Init()
end

function var_0_0.Exit(arg_4_0)
	if var_0_0.waitTask then
		var_0_0.waitTask:Abort()
	end

	manager.notify:RemoveListener(KAGUTSUCHI_FISHING_EVENT_QTE_FINISH, var_0_1)
	arg_4_0.game:Dispose()

	arg_4_0.game = nil
end

return var_0_0
