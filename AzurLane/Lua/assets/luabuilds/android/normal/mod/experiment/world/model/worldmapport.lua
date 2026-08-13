class = var_0_10000

local var_0_0 = "WorldMapPort"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...BaseEntity"))

var_0_1.Fields = {
	config = "table",
	zeroHourTime = "number",
	goods = "table",
	taskIds = "table",
	id = "number",
	expiredTime = "number"
}
var_0_1.EventUpdateTaskIds = "WorldMapPort.UpdateTaskIds"
var_0_1.EventUpdateGoods = "WorldMapPort.EventUpdateGoods"

function var_0_1.Build(arg_1_0)
	arg_1_0.taskIds = {}
	arg_1_0.goods = {}

	return
end

function var_0_1.Setup(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1
	pg = var_1_10002
	arg_2_0.config = var_1_10002.world_port_data[arg_2_0.id]
	assert = var_2

	var_2(arg_2_0.config, "world_port_data not exist: " .. arg_2_0.id)

	return
end

function var_0_1.Dispose(arg_3_0)
	arg_3_0:ClearGoods()
	arg_3_0:Clear()

	return
end

function var_0_1.IsValid(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.TimeMgr.GetInstance()
	local var_4_1 = var_1.GetServerTime(var_4_0)

	if arg_4_0.expiredTime then
		if var_4_1 <= arg_4_0.expiredTime then
			local var_4_2

			if arg_4_0.zeroHourTime then
				if not (var_4_1 <= arg_4_0.zeroHourTime) then
					var_4_2 = false
				else
					var_4_2 = true
				end
			end

			return var_4_2
		end
	end
end

function var_0_1.UpdateExpiredTime(arg_5_0, arg_5_1)
	arg_5_0.expiredTime = arg_5_1
	pg = var_1_10002

	local var_5_0 = var_1_10002.TimeMgr.GetInstance()

	arg_5_0.zeroHourTime = var_2.GetNextTime(var_5_0, 0, 0, 0)

	return
end

function var_0_1.UpdateTaskIds(arg_6_0, arg_6_1)
	if arg_6_0.taskIds ~= arg_6_1 then
		arg_6_0.taskIds = arg_6_1

		arg_6_0:DispatchEvent(var_0_1.EventUpdateTaskIds)
	end

	return
end

function var_0_1.UpdateGoods(arg_7_0, arg_7_1)
	if arg_7_0.goods ~= arg_7_1 then
		arg_7_0.goods = arg_7_1
		underscore = var_2

		local var_7_0 = var_2.filter(arg_7_0.goods, function(arg_8_0)
			return arg_8_0.count > 0
		end)

		nowWorld = var_3

		local var_7_1 = var_3()
		local var_7_2 = var_3.GetAtlas(var_7_1)

		var_3.UpdatePortMark(var_7_2, arg_7_0.id, #var_7_0 > 0)
		arg_7_0:DispatchEvent(var_0_1.EventUpdateGoods)
	end

	return
end

function var_0_1.ClearGoods(arg_9_0)
	WPool = var_1_10001

	var_1_10001:ReturnArray(arg_9_0.goods)

	arg_9_0.goods = {}

	return
end

function var_0_1.GetRealm(arg_10_0)
	return arg_10_0.config.port_camp
end

function var_0_1.IsOpen(arg_11_0, arg_11_1, arg_11_2)
	ipairs = var_1_10003

	for iter_11_0, iter_11_1 in var_1_10003(arg_11_0.config.open_condition) do
		if iter_11_1[1] == arg_11_1 and arg_11_2 >= iter_11_1[2] then
			return true
		end
	end

	return false
end

function var_0_1.IsTempPort(arg_12_0)
	return arg_12_0.config.port_camp == 0
end

return var_0_1
