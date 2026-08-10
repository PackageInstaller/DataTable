local var_0_0 = singletonClass("DormCharacterActionManager")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.listener = EventListener.New()

	local var_1_0 = class("SyncUpdateDormTaskRunner", DormTaskRunner)

	function var_1_0.Time(arg_2_0)
		return arg_1_0.now
	end

	arg_1_0.taskRunner = var_1_0.New()
	arg_1_0.frameTaskRunner = var_1_0.New()
end

function var_0_0.Init(arg_3_0)
	arg_3_0.animationEventHandlers = {}
	arg_3_0.schedule = {}

	arg_3_0:RegisterTaskRunner(arg_3_0.taskRunner, 15, 7)
	arg_3_0:RegisterTaskRunner(arg_3_0.frameTaskRunner, 2)

	arg_3_0.tickCount = 0
	arg_3_0.now = Time.time
	arg_3_0.tick = Timer.New(function()
		local var_4_0 = Time.time

		arg_3_0.now = var_4_0
		arg_3_0.tickCount = arg_3_0.tickCount + 1

		if arg_3_0.tickCount % 2 == 0 then
			manager.notify:Invoke(DORM_FRAME_TICK, var_4_0)
		end

		if arg_3_0.tickCount % 15 == 7 then
			manager.notify:Invoke(DORM_LOGIC_TICK, var_4_0)
		end

		for iter_4_0, iter_4_1 in pairs(arg_3_0.schedule) do
			if arg_3_0.tickCount % iter_4_1.interval == iter_4_1.offset then
				iter_4_0:TickUpdate()
			end
		end
	end, 0.016666666666666666, -1)

	arg_3_0.tick:Start()
	arg_3_0.listener:Register(ON_DORM_ENTITY_ANIME_EVENT, handler(arg_3_0, arg_3_0.HandleAnimationLoop))
end

function var_0_0.RegisterTaskRunner(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_3 = arg_5_3 or 0
	arg_5_3 = arg_5_3 % arg_5_2

	arg_5_1:Init()

	arg_5_0.schedule[arg_5_1] = {
		interval = arg_5_2,
		offset = arg_5_3
	}

	return arg_5_1
end

function var_0_0.Reset(arg_6_0)
	arg_6_0.listener:RemoveAll()

	if arg_6_0.tick then
		arg_6_0.tick:Stop()
	end

	arg_6_0.taskRunner:Reset()
	arg_6_0.frameTaskRunner:Reset()

	arg_6_0.schedule = {}
end

function var_0_0.HandleAnimationLoop(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_0.animationEventHandlers then
		arg_7_0.inAnimationHandleLoop = true

		local var_7_0 = {}

		for iter_7_0, iter_7_1 in ipairs(arg_7_0.animationEventHandlers) do
			if not iter_7_1(arg_7_1, arg_7_2, arg_7_3) then
				table.insert(var_7_0, iter_7_1)
			end
		end

		arg_7_0.animationEventHandlers = var_7_0
		arg_7_0.inAnimationHandleLoop = false
	end
end

function var_0_0.RegisterAnimeEvent(arg_8_0, arg_8_1)
	table.insert(arg_8_0.animationEventHandlers, arg_8_1)
end

function var_0_0.FrameTaskDeltaTime(arg_9_0)
	return arg_9_0.frameTaskRunner:DeltaTime()
end

function var_0_0.LogicTaskDeltaTime(arg_10_0)
	return arg_10_0.taskRunner:DeltaTime()
end

return var_0_0.GetInstance()
