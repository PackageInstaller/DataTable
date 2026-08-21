local var_0_0 = class("LinerEventGroup", import("model.vo.BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.configId = arg_1_0.id
	arg_1_0.events = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_0:GetIds()) do
		arg_1_0.events[iter_1_1] = LinerEvent.New(iter_1_1)
	end

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.activity_liner_event_group
end

function var_0_0.GetTitle(arg_3_0)
	return HXSet.hxLan(arg_3_0:getConfig("title"))
end

function var_0_0.GetPic(arg_4_0)
	return arg_4_0:getConfig("pic")
end

function var_0_0.GetEvent(arg_5_0, arg_5_1)
	return arg_5_0.events[arg_5_1]
end

function var_0_0.GetEvents(arg_6_0)
	return arg_6_0.events
end

function var_0_0.GetIds(arg_7_0)
	return arg_7_0:getConfig("ids")
end

function var_0_0.GetEventList(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.events) do
		table.insert({}, iter_8_1)
	end

	return {}
end

function var_0_0.GetConclusions(arg_9_0)
	return arg_9_0:getConfig("conclusion")
end

function var_0_0.GetDrop(arg_10_0)
	return Drop.Create(arg_10_0:getConfig("drop_display"))
end

return var_0_0
