class = var_0_10000

local var_0_0 = "LinerRoom"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.configId = arg_1_0.id
	arg_1_0.time2CharInfo = {}
	ipairs = var_2

	for iter_1_0, iter_1_1 in var_2(arg_1_0:getConfig("sd")) do
		ipairs = var_1_10007

		for iter_1_2, iter_1_3 in var_1_10007(iter_1_1[1]) do
			arg_1_0.time2CharInfo[iter_1_3] = {
				iter_1_1[2],
				iter_1_1[3]
			}
		end
	end

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.activity_liner_room
end

function var_0_1.GetName(arg_3_0)
	return arg_3_0:getConfig("name")
end

function var_0_1.GetPic(arg_4_0)
	return arg_4_0:getConfig("pic")
end

function var_0_1.GetDesc(arg_5_0)
	HXSet = var_1_10001

	return var_1_10001.hxLan(arg_5_0:getConfig("desc"))
end

function var_0_1.GetDescList(arg_6_0)
	local var_6_0 = {}

	ipairs = var_1_10002

	for iter_6_0, iter_6_1 in var_1_10002(arg_6_0:getConfig("desc_display")) do
		HXSet = var_1_10007
		var_1_10007 = var_1_10007.hxLan(iter_6_1[1])
		table = var_8

		var_8.insert(var_6_0, var_1_10007)
	end

	return var_6_0
end

function var_0_1.GetStory(arg_7_0)
	return arg_7_0:getConfig("memory_id")
end

function var_0_1.GetSpineCharInfo(arg_8_0, arg_8_1)
	return arg_8_0.time2CharInfo[arg_8_1]
end

return var_0_1
