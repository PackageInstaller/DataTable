local var_0_0 = singletonClass("DormCharacterActionManager")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.listener = EventListener.New()

	local SyncUpdateDormTaskRunner = class("SyncUpdateDormTaskRunner", DormTaskRunner)

	function SyncUpdateDormTaskRunner:Time()
		return arg_1_0.now
	end

	arg_1_0.taskRunner = SyncUpdateDormTaskRunner.New()
	arg_1_0.frameTaskRunner = SyncUpdateDormTaskRunner.New()
end

function var_0_0:Init()
	self.animationEventHandlers = {}
	self.schedule = {}

	self:RegisterTaskRunner(self.taskRunner, 15, 7)
	self:RegisterTaskRunner(self.frameTaskRunner, 2)

	self.tickCount = 0
	self.now = Time.time
	self.tick = Timer.New(function()
		self.now = Time.time
		self.tickCount = self.tickCount + 1

		if self.tickCount % 2 == 0 then
			manager.notify:Invoke(DORM_FRAME_TICK, Time.time)
		end

		if self.tickCount % 15 == 7 then
			manager.notify:Invoke(DORM_LOGIC_TICK, Time.time)
		end

		for iter_4_0, iter_4_1 in pairs(self.schedule) do
			if self.tickCount % iter_4_1.interval == iter_4_1.offset then
				iter_4_0:TickUpdate()
			end
		end
	end, 0.016666666666666666, -1)

	self.tick:Start()
	self.listener:Register(ON_DORM_ENTITY_ANIME_EVENT, handler(self, self.HandleAnimationLoop))
end

function var_0_0:RegisterTaskRunner(arg_5_1, arg_5_2, arg_5_3)
	arg_5_3 = arg_5_3 or 0
	arg_5_3 = arg_5_3 % arg_5_2

	arg_5_1:Init()

	self.schedule[arg_5_1] = {
		interval = arg_5_2,
		offset = arg_5_3
	}

	return arg_5_1
end

function var_0_0:Reset()
	self.listener:RemoveAll()

	if self.tick then
		self.tick:Stop()
	end

	self.taskRunner:Reset()
	self.frameTaskRunner:Reset()

	self.schedule = {}
end

function var_0_0:HandleAnimationLoop(arg_7_1, arg_7_2, arg_7_3)
	if self.animationEventHandlers then
		self.inAnimationHandleLoop = true

		local var_7_0 = {}

		for iter_7_0, iter_7_1 in ipairs(self.animationEventHandlers) do
			if not iter_7_1(arg_7_1, arg_7_2, arg_7_3) then
				table.insert(var_7_0, iter_7_1)
			end
		end

		self.animationEventHandlers = var_7_0
		self.inAnimationHandleLoop = false
	end
end

function var_0_0:RegisterAnimeEvent(arg_8_1)
	table.insert(self.animationEventHandlers, arg_8_1)
end

function var_0_0:FrameTaskDeltaTime()
	return self.frameTaskRunner:DeltaTime()
end

function var_0_0:LogicTaskDeltaTime()
	return self.taskRunner:DeltaTime()
end

return var_0_0.GetInstance()
