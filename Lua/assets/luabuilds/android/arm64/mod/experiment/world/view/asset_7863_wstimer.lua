local WSTimer = class("WSTimer", import("...BaseEntity"))

WSTimer.Fields = {
	inMapTweens = "table",
	inMapTimers = "table",
	tweens = "table",
	timers = "table"
}
WSTimer.Listeners = {}

function WSTimer:Setup()
	self.inMapTimers = {}
	self.timers = {}
	self.inMapTweens = {}
	self.tweens = {}

	return
end

function WSTimer:Dispose()
	self:ClearInMapTweens()
	self:ClearInMapTimers()
	self:ClearTweens()
	self:ClearTimers()
	self:Clear()

	return
end

function WSTimer:AddInMapTimer(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = Timer.New(arg_3_1, arg_3_2, arg_3_3, arg_3_4)

	table.insert(self.inMapTimers, var_3_0)

	return var_3_0
end

function WSTimer:RemoveInMapTimer(arg_4_1)
	arg_4_1:Stop()

	for iter_4_0, iter_4_1 in ipairs(self.inMapTimers) do
		if iter_4_1 == arg_4_1 then
			table.remove(self.inMapTimers, iter_4_0)
		end
	end

	return
end

function WSTimer:ClearInMapTimers()
	for iter_5_0, iter_5_1 in ipairs(self.inMapTimers) do
		iter_5_1:Stop()
	end

	self.inMapTimers = {}

	return
end

function WSTimer:AddTimer(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_0 = Timer.New(arg_6_1, arg_6_2, arg_6_3, arg_6_4)

	table.insert(self.timers, var_6_0)

	return var_6_0
end

function WSTimer:RemoveTimer(arg_7_1)
	arg_7_1:Stop()

	for iter_7_0, iter_7_1 in ipairs(self.timers) do
		if iter_7_1 == arg_7_1 then
			table.remove(self.timers, iter_7_0)
		end
	end

	return
end

function WSTimer:ClearTimers()
	for iter_8_0, iter_8_1 in ipairs(self.timers) do
		iter_8_1:Stop()
	end

	self.timers = {}

	return
end

function WSTimer:AddInMapTween(arg_9_1)
	assert(arg_9_1 and type(arg_9_1) == "number")
	table.insert(self.inMapTweens, arg_9_1)

	return
end

function WSTimer:RemoveInMapTween(arg_10_1)
	assert(arg_10_1 and type(arg_10_1) == "number")
	LeanTween.cancel(arg_10_1)

	for iter_10_0, iter_10_1 in ipairs(self.inMapTweens) do
		if iter_10_1 == arg_10_1 then
			table.remove(self.inMapTweens, iter_10_0)

			break
		end
	end

	return
end

function WSTimer:ClearInMapTweens()
	for iter_11_0, iter_11_1 in ipairs(self.inMapTweens) do
		LeanTween.cancel(iter_11_1)
	end

	self.inMapTweens = {}

	return
end

function WSTimer:AddTween(arg_12_1)
	assert(arg_12_1 and type(arg_12_1) == "number")
	table.insert(self.tweens, arg_12_1)

	return
end

function WSTimer:RemoveTween(arg_13_1)
	assert(arg_13_1 and type(arg_13_1) == "number")
	LeanTween.cancel(arg_13_1)

	for iter_13_0, iter_13_1 in ipairs(self.tweens) do
		if iter_13_1 == arg_13_1 then
			table.remove(self.tweens, iter_13_0)
		end
	end

	return
end

function WSTimer:ClearTweens()
	for iter_14_0, iter_14_1 in ipairs(self.tweens) do
		LeanTween.cancel(iter_14_1)
	end

	self.tweens = {}

	return
end

return WSTimer
