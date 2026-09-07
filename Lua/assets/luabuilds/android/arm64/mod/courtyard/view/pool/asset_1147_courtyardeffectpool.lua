local CourtYardEffectPool = class("CourtYardEffectPool", import(".CourtYardPool"))

function CourtYardEffectPool:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	self.recycleTime = arg_1_5 or 2

	pg.ViewUtils.SetLayer(tf(arg_1_2), Layer.UI)
	CourtYardEffectPool.super.Ctor(self, arg_1_1, arg_1_2, arg_1_3, arg_1_4)

	self.timers = {}

	return
end

function CourtYardEffectPool:Dequeue()
	local var_2_0 = CourtYardEffectPool.super.Dequeue(self)

	self.timers[var_2_0] = Timer.New(function()
		self:Enqueue(var_2_0)

		return
	end, self.recycleTime, 1)

	self.timers[var_2_0]:Start()

	return var_2_0
end

function CourtYardEffectPool:Dispose()
	for iter_4_0, iter_4_1 in pairs(self.timers) do
		self:Enqueue(iter_4_0)
		iter_4_1:Stop()
	end

	self.timers = nil

	CourtYardEffectPool.super.Dispose(self)

	return
end

return CourtYardEffectPool
