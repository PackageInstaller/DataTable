local var_0_0 = l2d.LAppLive2DManager:getInstance()
local var_0_1 = {
	actions = {}
}
local var_0_2 = 0
local var_0_3 = 1
local var_0_4 = 2

function var_0_1:update(arg_1_1)
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in pairs(self.actions) do
		iter_1_1.curtime = iter_1_1.curtime + arg_1_1

		if iter_1_1.curtime >= iter_1_1.time then
			iter_1_1.curtime = iter_1_1.time
			iter_1_1.work = false

			table.insert(var_1_0, iter_1_0)
		end

		local function var_1_1(arg_2_0)
			local var_2_0 = iter_1_1.curtime / iter_1_1.time

			if iter_1_1.tweenclosure ~= nil then
				var_2_0 = iter_1_1.tweenclosure(var_2_0)
			end

			return iter_1_1.oldvals[arg_2_0] + (iter_1_1.newvals[arg_2_0] - iter_1_1.oldvals[arg_2_0]) * var_2_0
		end

		if iter_1_1.type == var_0_2 then
			var_0_0:setModelScale(iter_1_1.model, var_1_1(1))
		elseif iter_1_1.type == var_0_4 then
			var_0_0:setModelAlpha(iter_1_1.model, var_1_1(1))
		elseif iter_1_1.type == var_0_3 then
			var_0_0:setModelPosition(iter_1_1.model, var_1_1(1), var_1_1(2))
		end
	end

	for iter_1_2, iter_1_3 in pairs(var_1_0) do
		table.remove(self.actions, iter_1_3)
	end
end

function var_0_1:ScaleTo(arg_3_1, arg_3_2, arg_3_3)
	return self:ActionBase(var_0_2, arg_3_1, arg_3_2, {
		arg_3_3
	}, {
		(var_0_0:getModelScale(arg_3_1))
	})
end

function var_0_1:AlphaTo(arg_4_1, arg_4_2, arg_4_3)
	if arg_4_3 < 0 then
		arg_4_3 = 0
	end

	return self:ActionBase(var_0_4, arg_4_1, arg_4_2, {
		arg_4_3
	}, {
		(var_0_0:getModelAlpha(arg_4_1))
	})
end

function var_0_1:MoveTo(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	return self:ActionBase(var_0_3, arg_5_1, arg_5_2, {
		arg_5_3,
		arg_5_4
	}, {
		var_0_0:getModelRelativeX(arg_5_1),
		(var_0_0:getModelRelativeY(arg_5_1))
	})
end

function var_0_1.EaseIn(arg_6_0, arg_6_1, arg_6_2)
	function arg_6_1.tweenclosure(arg_7_0)
		local var_7_0 = arg_6_2

		return (function(arg_8_0)
			return math.pow(arg_8_0, var_7_0)
		end)(arg_7_0)
	end
end

function var_0_0.EaseOut(arg_9_0, arg_9_1, arg_9_2)
	function arg_9_1.tweenclosure(arg_10_0)
		local var_10_0 = arg_9_2

		return easeIn(arg_10_0)
	end
end

function var_0_1.ActionBase(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5)
	if var_0_0:isModelExist(arg_12_2) == false then
		return
	end

	if arg_12_3 < 0 then
		return
	end

	local var_12_0 = {
		type = arg_12_1,
		time = arg_12_3
	}

	var_12_0.curtime = 0
	var_12_0.newvals = arg_12_4
	var_12_0.oldvals = arg_12_5
	var_12_0.work = true
	var_12_0.model = arg_12_2
	var_12_0.tweenfunc = 0

	table.insert(var_0_1.actions, var_12_0)

	return var_12_0
end

local function var_0_5(arg_13_0)
	var_0_1:update(arg_13_0)
end

function var_0_1.schedule(arg_14_0)
	var_0_1.scheduleid = var_0_1.scheduleid or cc.Director:getInstance():getScheduler():scheduleScriptFunc(var_0_5, 0, false)
end

function var_0_1.unschedule(arg_15_0)
	if var_0_1.scheduleid then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(var_0_1.scheduleid)

		var_0_1.scheduleid = nil
	end
end

return var_0_1
