local var_0_0 = {}

var_0_0.eventHandlers = {}
var_0_0.EVENT_IDS = require("common.Utility"):enumeration({
	"DECOMPOSE_ITEMS",
	"COMPOUND_ITEM_ONE_KEY",
	"LAYER_EXIT_SCENE",
	"UPDATE_USER_ITEMS",
	"UPDATE_COURSE_DATA",
	"UPDATE_OFFERS",
	"SHOW_LIMITTIME_PACKAGES"
})

function var_0_0:registerEvent(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.eventHandlers = self.eventHandlers or {}
	self.eventHandlers[arg_1_1] = self.eventHandlers[arg_1_1] or {}
	self.eventHandlers[arg_1_1][arg_1_2] = {
		func = arg_1_3,
		priority = arg_1_4 or 0
	}
end

function var_0_0:triggerEvent(arg_2_1, ...)
	if not self.eventHandlers then
		return
	end

	local var_2_0 = {}

	for iter_2_0, iter_2_1 in pairs(self.eventHandlers) do
		if iter_2_1[arg_2_1] then
			var_2_0[#var_2_0 + 1] = iter_2_1[arg_2_1]
		end
	end

	table.sort(var_2_0, function(arg_3_0, arg_3_1)
		return arg_3_0.priority > arg_3_1.priority
	end)

	for iter_2_2, iter_2_3 in ipairs(var_2_0) do
		iter_2_3.func(...)
	end
end

function var_0_0:removeEvent(arg_4_1, arg_4_2)
	if not arg_4_1 then
		return
	end

	if arg_4_2 then
		self.eventHandlers[arg_4_1][arg_4_2] = nil
	else
		self.eventHandlers[arg_4_1] = nil
	end
end

function var_0_0.removeAllEvents(arg_5_0)
	arg_5_0.eventHandlers = {}
end

return var_0_0
