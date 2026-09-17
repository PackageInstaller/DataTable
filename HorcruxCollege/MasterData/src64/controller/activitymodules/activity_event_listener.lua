local activity_base_manager = require("controller.activitymodules.activity_base_manager")

activity_base_manager.activityEventId = require("controller.activitymodules.activity_event_ids")

local var_0_1 = {}

function activity_base_manager.registerEventListener(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if type(arg_1_2) ~= "number" then
		print("ROORR:: activityEventId 参数非法")

		return
	end

	if var_0_1[arg_1_2] ~= nil then
		local var_1_0 = false

		for iter_1_0, iter_1_1 in pairs(var_0_1[arg_1_2].monitor) do
			if iter_1_1.layerName == arg_1_1 then
				print("WARNING:: eventId和layerName都一样前面的注册信息会被覆盖", arg_1_2, arg_1_1)

				var_1_0 = true
				iter_1_1.func = arg_1_3
			end
		end

		if not var_1_0 then
			table.insert(var_0_1[arg_1_2].monitor, {
				layerName = arg_1_1,
				func = arg_1_3
			})
		end
	else
		var_0_1[arg_1_2] = {}
		var_0_1[arg_1_2].monitor = {}

		table.insert(var_0_1[arg_1_2].monitor, {
			layerName = arg_1_1,
			func = arg_1_3
		})
	end
end

function activity_base_manager.releaseEventListener(arg_2_0, arg_2_1, arg_2_2)
	for iter_2_0, iter_2_1 in pairs(var_0_1[arg_2_2].monitor) do
		if iter_2_1.layerName == arg_2_1 then
			var_0_1[arg_2_2].monitor[iter_2_0] = nil
		end
	end
end

function activity_base_manager.releaseEventListenerByName(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in pairs(var_0_1) do
		for iter_3_2, iter_3_3 in pairs(iter_3_1.monitor) do
			if iter_3_3.layerName == arg_3_1 then
				iter_3_1.monitor[iter_3_2] = nil
			end
		end
	end
end

function activity_base_manager.releaseAllEventListener(arg_4_0)
	var_0_1 = {}
end

function activity_base_manager.dispatchEvent(arg_5_0, arg_5_1, arg_5_2)
	if type(arg_5_1) ~= "number" then
		print("ROORR:: activityEventId 参数非法")

		return
	end

	if var_0_1[arg_5_1] == nil then
		return
	end

	for iter_5_0, iter_5_1 in pairs(var_0_1[arg_5_1].monitor) do
		iter_5_1.func(arg_5_2)
	end
end

function activity_base_manager:fireEvent(arg_6_1, arg_6_2)
	if not var_0_1 or not next(var_0_1) then
		return
	end

	self:dispatchEvent(arg_6_1, arg_6_2)
end
