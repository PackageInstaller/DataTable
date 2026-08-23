local var_0_0 = {}
local var_0_1 = table.insert

var_0_0.TYPE = {
	HIT = 2,
	SKILL = 1
}
var_0_0.triggerTime = {
	var_0_0.TYPE.SKILL,
	var_0_0.TYPE.HIT,
	var_0_0.TYPE.SKILL
}

function var_0_0:addRule(arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = {
		check = var_0_0.getCheckFunc(arg_1_1, arg_1_3),
		execute = function(arg_2_0)
			arg_1_3:addEnergyEffect(arg_1_2)
		end
	}
	local var_1_1 = var_0_0.triggerTime[arg_1_1] or 0

	if type(var_1_1) == "table" then
		for iter_1_0, iter_1_1 in ipairs(var_1_1) do
			self[iter_1_1] = self[iter_1_1] or {}

			var_0_1(self[iter_1_1], var_1_0)
		end
	else
		self[var_1_1] = self[var_1_1] or {}

		var_0_1(self[var_1_1], var_1_0)
	end

	return self
end

function var_0_0.initRule(arg_3_0, arg_3_1)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		var_0_0.addRule(var_3_0, iter_3_1.type, iter_3_1.value, arg_3_0)
	end

	return var_3_0
end

function var_0_0.getCheckFunc(arg_4_0, arg_4_1)
	if arg_4_0 == 1 then
		return function(arg_5_0, arg_5_1)
			return arg_4_1.serialId == arg_5_1.serialId
		end
	elseif arg_4_0 == 2 then
		return function(arg_6_0, arg_6_1)
			return true
		end
	elseif arg_4_0 == 3 then
		return function(arg_7_0, arg_7_1)
			if arg_7_1.identity == arg_4_1.identity then
				return arg_7_1.serialId ~= arg_4_1.serialId
			end

			return false
		end
	end
end

return var_0_0
