local var_0_0 = class("LinerTimeGroup", import("model.vo.BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.configId = arg_1_0.id
	arg_1_0.times = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_0:GetIds()) do
		arg_1_0.times[iter_1_1] = LinerTime.New(iter_1_1)
	end

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.activity_liner_time_group
end

function var_0_0.GetTime(arg_3_0, arg_3_1)
	return arg_3_0.times[arg_3_1]
end

function var_0_0.GetTimes(arg_4_0)
	return arg_4_0.times
end

function var_0_0.GetIds(arg_5_0)
	return arg_5_0:getConfig("ids")
end

function var_0_0.GetTimeList(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.times) do
		table.insert({}, iter_6_1)
	end

	return {}
end

function var_0_0.GetDrop(arg_7_0)
	return Drop.Create(arg_7_0:getConfig("drop_display"))
end

return var_0_0
