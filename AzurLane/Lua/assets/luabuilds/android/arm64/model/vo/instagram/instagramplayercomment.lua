class = var_0_10000

local var_0_0 = "InstagramPlayerComment"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".InstagramComment"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)

	local var_1_0 = arg_1_0.level + 1

	type = var_1_10006

	if var_1_10006(arg_1_1.npc_reply) == "table" then
		ipairs = var_6

		for iter_1_0, iter_1_1 in var_6(arg_1_1.npc_reply) do
			InstagramNpcComment = var_1_1

			local var_1_1 = var_1_1.New(arg_1_0.allReply[iter_1_1], arg_1_2, var_1_0, arg_1_0)

			table = var_1_10012

			var_1_10012.insert(arg_1_0.replyList, var_1_1)
		end
	elseif arg_1_1.npc_reply ~= 0 then
		InstagramNpcComment = var_6

		local var_1_2 = var_6.New(arg_1_0.allReply[arg_1_1.npc_reply], arg_1_2, var_1_0, arg_1_0)

		table = var_7

		var_7.insert(arg_1_0.replyList, var_1_2)
	end

	return
end

function var_0_1.GetName(arg_2_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_2_0 = var_1_10001(var_1_10003)

	return var_1.getData(var_2_0).name
end

function var_0_1.GetPainting(arg_3_0)
	return "ui/InstagramUI_atlas", "txdi_3"
end

function var_0_1.GetType(arg_4_0)
	Instagram = var_1_10001

	return var_1_10001.TYPE_PLAYER_COMMENT
end

return var_0_1
