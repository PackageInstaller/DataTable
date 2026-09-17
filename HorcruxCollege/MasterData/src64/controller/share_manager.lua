local var_0_0 = {}
local network = require("network.network")
local share_bridge = require("controller.share_bridge")
local var_0_3 = false

function var_0_0.enableChannelShare(arg_1_0, arg_1_1)
	var_0_3 = arg_1_1
end

function var_0_0.can_share(arg_2_0)
	if not var_0_3 then
		return false
	end

	return share_bridge.canShare()
end

function var_0_0.registerShareHandler(arg_3_0, arg_3_1)
	share_bridge.registerShareHandler(arg_3_1)
end

function var_0_0.doShare(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	share_bridge.doShare(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
end

function var_0_0.getShareChannelArr(arg_5_0)
	return share_bridge.getShareChannelArr()
end

var_0_0.SHARE_CHANNEL = {
	weibo = 3,
	weixingroup = 1,
	weixinfriend = 0,
	qqfriend = 2
}

function var_0_0.doChannelShare(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	share_bridge.doChannelShare(arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
end

function var_0_0:get_share_data(arg_7_1)
	if not self:can_share() then
		if arg_7_1 then
			arg_7_1(2)
		end

		return
	end

	network:rpc("get_share_data", {
		channelid = DeviceManager:getChannelID()
	}, function(arg_8_0)
		if arg_7_1 then
			arg_7_1(arg_8_0.result, arg_8_0)
		end
	end)
end

function var_0_0:get_test_share_data(arg_9_1)
	if not self:can_share() then
		if arg_9_1 then
			arg_9_1(2)
		end

		return
	end

	network:rpc("get_share_data", {
		sharetest = true,
		channelid = DeviceManager:getChannelID()
	}, function(arg_10_0)
		if arg_9_1 then
			arg_9_1(arg_10_0.result, arg_10_0)
		end
	end)
end

function var_0_0.share_success(arg_11_0, arg_11_1)
	network:rpc("share_success", nil, function(arg_12_0)
		if arg_12_0.result == 1 then
			if arg_12_0.items then
				global_gain({
					items = arg_12_0.items
				})
			end

			if arg_11_1 then
				arg_11_1(1)
			end
		elseif arg_11_1 then
			arg_11_1(arg_12_0.result)
		end
	end)
end

function var_0_0.get_total_share_award(arg_13_0, arg_13_1, arg_13_2)
	network:rpc("get_total_share_award", {
		index = arg_13_1
	}, function(arg_14_0)
		if arg_14_0.result == 1 then
			if arg_14_0.item then
				local var_14_0 = {
					items = {}
				}

				table.insert(var_14_0.items, arg_14_0.item)
				global_gain(var_14_0)
			end

			if arg_13_2 then
				arg_13_2(1)
			end
		elseif arg_13_2 then
			arg_13_2(arg_14_0.result)
		end
	end)
end

function var_0_0.get_activity_share_data(arg_15_0, arg_15_1, arg_15_2)
	if DeviceManager:getChannelID() == "270055" or DeviceManager:getChannelID() == "270054" then
		if arg_15_2 then
			arg_15_2(2)
		end

		return
	end

	network:rpc("get_activity_share_data", {
		id = arg_15_1,
		channelid = DeviceManager:getChannelID()
	}, function(arg_16_0)
		if arg_15_2 then
			arg_15_2(arg_16_0.result, arg_16_0)
		end
	end)
end

function var_0_0.activity_share_success(arg_17_0, arg_17_1, arg_17_2)
	network:rpc("activity_share_success", {
		id = arg_17_1
	}, function(arg_18_0)
		if arg_18_0.result == 1 then
			if arg_18_0.items then
				local var_18_0 = {
					items = arg_18_0.items
				}

				cc.Director:getInstance():getRunningScene():runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
					global_gain(var_18_0)
				end)))
			end

			if arg_17_2 then
				arg_17_2(1)
			end
		elseif arg_17_2 then
			arg_17_2(arg_18_0.result)
		end
	end)
end

function var_0_0.get_activity_total_share_award(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	network:rpc("get_activity_total_share_award", {
		id = arg_20_1,
		index = arg_20_2
	}, function(arg_21_0)
		if arg_21_0.result == 1 then
			if arg_21_0.item then
				local var_21_0 = {
					items = {}
				}

				table.insert(var_21_0.items, arg_21_0.item)
				global_gain(var_21_0)
			end

			if arg_20_3 then
				arg_20_3(1)
			end
		elseif arg_20_3 then
			arg_20_3(arg_21_0.result)
		end
	end)
end

return var_0_0
