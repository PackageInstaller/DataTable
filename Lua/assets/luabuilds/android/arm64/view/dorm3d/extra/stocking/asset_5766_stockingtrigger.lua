local StockingTrigger = class("StockingTrigger")

function StockingTrigger:Ctor(arg_1_1)
	self.id = arg_1_1

	local var_1_0 = pg.dorm3d_stocking_trigger[arg_1_1]

	self.triggerPos = pg.dorm3d_stocking_trigger[arg_1_1].trigger_pos
	self.compareType = var_1_0.compare_type
	self.triggerType = var_1_0.trigger_type
	self.shouldExit = var_1_0.exit == 1
	self.triggerParam = var_1_0.trigger_param
	self.isTriggered = false

	return
end

function StockingTrigger:Check(arg_2_1, arg_2_2, arg_2_3)
	if self.isTriggered then
		return false
	end

	if self.compareType == 0 then
		if arg_2_1 >= self.triggerPos and arg_2_3 < self.triggerPos then
			return true
		end
	elseif arg_2_1 <= self.triggerPos and arg_2_2 > self.triggerPos then
		return true
	end

	return false
end

function StockingTrigger:Trigger()
	self.isTriggered = true

	return self.triggerType, self.triggerParam, self.shouldExit
end

function StockingTrigger:GetCompareType()
	return self.compareType
end

function StockingTrigger:Sort()
	table.sort(self, function(arg_6_0, arg_6_1)
		if arg_6_0.compareType == 0 then
			return arg_6_0.triggerPos > arg_6_1.triggerPos
		else
			return arg_6_0.triggerPos < arg_6_1.triggerPos
		end

		return
	end)

	return
end

return StockingTrigger
