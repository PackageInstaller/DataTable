local var_0_0 = {}
local network = require("network.network")
local drop_manager = require("controller.drop_manager")
local item_manager = require("controller.item_manager")
local activity_manager = require("controller.activity_manager")
local order_conf_data = require("data.order.order_conf_data")

local function var_0_6(arg_1_0)
	if arg_1_0.index > 10 then
		return -1
	end

	for iter_1_0, iter_1_1 in pairs(arg_1_0.needlist) do
		if iter_1_1.neednum > item_manager:getItemNumber(iter_1_1.needitem) then
			return 0
		end
	end

	return 1
end

function var_0_0.get_order_info(arg_2_0)
	network:rpc("get_order_info", {}, function(arg_3_0)
		if arg_3_0.result == 1 then
			local var_3_0 = RoleDefault:getInstance():getIntegerForKey("last_order_num", 0)

			RoleDefault:getInstance():setIntegerForKey("last_order_num", (arg_3_0.orderlist or nil) and (#arg_3_0.orderlist or 0))

			if arg_3_0.orderlist and next(arg_3_0.orderlist) then
				for iter_3_0, iter_3_1 in pairs(arg_3_0.orderlist) do
					iter_3_1.index = iter_3_0

					if var_3_0 < iter_3_0 then
						iter_3_1.new = true
					end
				end

				table.sort(arg_3_0.orderlist, function(arg_4_0, arg_4_1)
					local var_4_0 = var_0_6(arg_4_0)
					local var_4_1 = var_0_6(arg_4_1)

					if var_4_0 == var_4_1 then
						return arg_4_0.index > arg_4_1.index
					end

					return var_4_1 < var_4_0
				end)
			end

			if #arg_3_0.orderlist < 10 then
				arg_3_0.orderlist[#arg_3_0.orderlist + 1] = {
					id = -1,
					quality = 4,
					dropid = "LTBTMDXZ",
					needlist = {}
				}
			end

			activity_manager:fireEvent(activity_manager.activityEventId.SCHOOL_ORDER_INFO_UPDATE, arg_3_0)
		end
	end)
end

function var_0_0.delete_order_by_index(arg_5_0, arg_5_1)
	network:rpc("delete_order_by_index", {
		index = arg_5_1
	}, function(arg_6_0)
		global_ShowBlockWords(L_ORDER_DELETE_RESULT[arg_6_0.result])

		if arg_6_0.result == 1 then
			arg_5_0:get_order_info()
		end
	end)
end

function var_0_0.get_order_reward_by_index(arg_7_0, arg_7_1)
	network:rpc("get_order_reward_by_index", {
		index = arg_7_1
	}, function(arg_8_0)
		if arg_8_0.result == 1 then
			global_gain(arg_8_0)

			if arg_8_0.costitems then
				for iter_8_0, iter_8_1 in pairs(arg_8_0.costitems) do
					item_manager:deleteItem(iter_8_1.itemid, iter_8_1.num)
				end
			end

			arg_7_0:get_order_info()
		end
	end)
end

function var_0_0.refsh_order_right_now(arg_9_0)
	network:rpc("refsh_order_right_now", {}, function(arg_10_0)
		if arg_10_0.result == 1 then
			if arg_10_0.costitems then
				for iter_10_0, iter_10_1 in pairs(arg_10_0.costitems) do
					item_manager:deleteItem(iter_10_1.itemid, iter_10_1.num)
				end
			end

			global_ShowBlockWords(L_ORDER_REFSH_RESULT[arg_10_0.result])
			arg_9_0:get_order_info()
		elseif arg_10_0.result == 3 then
			LayerManager:pushInLayer("PopGoGainLayer", {
				item = arg_9_0:getRefshItemId()
			})
		end
	end)
end

function var_0_0.set_new_order(arg_11_0)
	network:rpc("set_new_order", {}, function(arg_12_0)
		return
	end)
end

function var_0_0.getMaxShowNum(arg_13_0)
	return order_conf_data.max_order_num.value
end

function var_0_0.getRefshItemId(arg_14_0)
	return tonumber(order_conf_data.refsh_item.value)
end

return var_0_0
