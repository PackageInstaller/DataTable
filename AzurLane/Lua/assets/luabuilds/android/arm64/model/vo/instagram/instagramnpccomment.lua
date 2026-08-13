class = var_0_10000

local var_0_0 = "InstagramNpcComment"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".InstagramComment"))

pg = var_0_10001

local var_0_2 = var_0_10001.activity_ins_ship_group_template

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)

	arg_1_0.configId = arg_1_0.id

	local var_1_0 = arg_1_0.level + 1

	ipairs = var_1_10006

	for iter_1_0, iter_1_1 in var_1_10006(arg_1_1.npc_reply) do
		assert = var_1_1

		var_1_1(arg_1_0.allReply[iter_1_1], iter_1_1)

		table = var_1_1

		local var_1_1 = var_1_1.insert
		local var_1_2 = arg_1_0.replyList

		InstagramNpcComment = var_14

		var_1_1(var_1_2, var_14.New(arg_1_0.allReply[iter_1_1], arg_1_2, var_1_0, arg_1_0))
	end

	arg_1_0.config = var_0_2[arg_1_0:getConfig("ship_group")]

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.activity_ins_npc_template
end

function var_0_1.GetName(arg_3_0)
	return arg_3_0.config.name
end

function var_0_1.GetPainting(arg_4_0)
	return arg_4_0.config.sculpture
end

function var_0_1.GetType(arg_5_0)
	Instagram = var_1_10001

	return var_1_10001.TYPE_NPC_COMMENT
end

return var_0_1
