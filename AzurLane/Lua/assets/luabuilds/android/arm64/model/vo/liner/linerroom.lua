local var_0_0 = class("LinerRoom", import("model.vo.BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.configId = arg_1_0.id
	arg_1_0.time2CharInfo = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_0:getConfig("sd")) do
		for iter_1_2, iter_1_3 in ipairs(iter_1_1[1]) do
			arg_1_0.time2CharInfo[iter_1_3] = {
				iter_1_1[2],
				iter_1_1[3]
			}
		end
	end

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.activity_liner_room
end

function var_0_0.GetName(arg_3_0)
	return arg_3_0:getConfig("name")
end

function var_0_0.GetPic(arg_4_0)
	return arg_4_0:getConfig("pic")
end

function var_0_0.GetDesc(arg_5_0)
	return HXSet.hxLan(arg_5_0:getConfig("desc"))
end

function var_0_0.GetDescList(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0:getConfig("desc_display")) do
		table.insert({}, (HXSet.hxLan(iter_6_1[1])))
	end

	return {}
end

function var_0_0.GetStory(arg_7_0)
	return arg_7_0:getConfig("memory_id")
end

function var_0_0.GetSpineCharInfo(arg_8_0, arg_8_1)
	return arg_8_0.time2CharInfo[arg_8_1]
end

return var_0_0
