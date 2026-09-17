local var_0_0 = {}
local servant_data = require("data.servant_data")
local ai_chat_data = require("data.ai_chat_data")
local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local network = require("network.network")

function var_0_0.getAichatList(arg_1_0)
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in pairs(servant_data) do
		if iter_1_1.ai_chat and playermodel.haveServant[iter_1_0] then
			local var_1_1 = {}

			for iter_1_2, iter_1_3 in pairs((string.split(iter_1_1.ai_chat, ","))) do
				local var_1_2, var_1_3 = ai_chat_data[iter_1_3].unlock_condition:match("([^=]+)=([^=]+)")
				local var_1_4 = false
				local var_1_5
				local var_1_6

				if var_1_2 == "love" then
					var_1_4 = playermodel.favor[iter_1_1.major].favorlevel >= tonumber(var_1_3)
					var_1_5 = var_1_3
				elseif var_1_2 == "skin" then
					var_1_4 = item_manager:haveItem(tonumber(var_1_3))
					var_1_6 = tonumber(var_1_3)
				end

				local var_1_7 = clone(ai_chat_data[iter_1_3])

				var_1_7.chat_id = iter_1_3
				var_1_7.unlock = var_1_4
				var_1_7.love_level = var_1_5
				var_1_7.unlock_skin = var_1_6
				var_1_1[iter_1_2] = var_1_7
			end

			var_1_0[iter_1_0] = var_1_1
		end
	end

	return var_1_0
end

function var_0_0.send_message_to_ai(arg_2_0, arg_2_1, arg_2_2)
	network:rpc("send_message_to_ai", {
		id = arg_2_1.id,
		user_input = arg_2_1.user_input
	}, function(arg_3_0)
		if arg_3_0.result == 1 and arg_3_0.items then
			global_gain(arg_3_0)
		end

		arg_2_2(arg_3_0)
	end)
end

function var_0_0.query_ai_session(arg_4_0, arg_4_1, arg_4_2)
	network:rpc("query_ai_session", {
		id = arg_4_1.id
	}, function(arg_5_0)
		arg_4_2(arg_5_0)
	end)
end

function var_0_0.restart_ai_chat(arg_6_0, arg_6_1, arg_6_2)
	network:rpc("restart_ai_chat", {
		id = arg_6_1.id,
		iserror = arg_6_1.iserror
	}, function(arg_7_0)
		arg_6_2(arg_7_0)
	end)
end

return var_0_0
