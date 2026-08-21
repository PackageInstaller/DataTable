local var_0_0 = class("SingleEvent", import("model.vo.BaseVO"))

var_0_0.EVENT_TYPE = {
	DAILY = 2,
	MAIN = 1
}
var_0_0.STORY_TYPE = {
	STORY = 1,
	BATTLE = 2
}
var_0_0.MODE_TYPE = {
	STORY = 1,
	BATTLE = 2
}

function var_0_0.bindConfigTable(arg_1_0)
	return pg.activity_single_event
end

function var_0_0.Ctor(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.configId = arg_2_0.id

	return
end

function var_0_0.IsMain(arg_3_0)
	return arg_3_0:getConfig("type") == var_0_0.EVENT_TYPE.MAIN
end

function var_0_0.IsDaily(arg_4_0)
	return arg_4_0:getConfig("type") == var_0_0.EVENT_TYPE.DAILY
end

function var_0_0.GetType(arg_5_0)
	return arg_5_0:getConfig("type")
end

function var_0_0.GetMode(arg_6_0)
	return arg_6_0:getConfig("mode")
end

function var_0_0.GetName(arg_7_0)
	return arg_7_0:getConfig("name")
end

function var_0_0.GetPos(arg_8_0)
	return arg_8_0:getConfig("pos")
end

function var_0_0.GetIconName(arg_9_0)
	return arg_9_0:getConfig("icon")
end

function var_0_0.GetStoryType(arg_10_0)
	return arg_10_0:getConfig("story_type")
end

function var_0_0.GetStory(arg_11_0)
	return arg_11_0:getConfig("story")
end

function var_0_0.GetPreEventId(arg_12_0)
	return arg_12_0:getConfig("pre_event")
end

function var_0_0.GetOptions(arg_13_0)
	return arg_13_0:getConfig("options")
end

function var_0_0.GetMapOptions(arg_14_0)
	return arg_14_0:getConfig("map_options")
end

return var_0_0
