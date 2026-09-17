local var_0_0 = {}
local network = require("network.network")
local playermodel = require("model.playermodel")
local xuanshang_data = require("data.xuanshang_data")
local model_data = require("data.model_data")
local drop_manager = require("controller.drop_manager")
local item_manager = require("controller.item_manager")

function var_0_0.getTotalLevelInfoByServer(arg_1_0, arg_1_1)
	network:rpc("get_explore_level_info", nil, function(arg_2_0)
		if arg_2_0.explore_level_info then
			playermodel.exploreLevel = {}

			for iter_2_0, iter_2_1 in pairs(arg_2_0.explore_level_info) do
				playermodel.exploreLevel[iter_2_1.classid] = iter_2_1
			end

			if arg_1_1 then
				arg_1_1()
			end
		else
			cclog("ERROR!!!!!!IMPOSSIBLE!!!!!!PLZ CALL 木川")
		end
	end)
end

function var_0_0.getExploreLevelInfo(arg_3_0, arg_3_1)
	return playermodel.exploreLevel[arg_3_1]
end

function var_0_0.pushExploreLevel(arg_4_0, arg_4_1, arg_4_2)
	network:rpc("push_explore_level", {
		classid = arg_4_1
	}, function(arg_5_0)
		if arg_5_0.result == 1 then
			if arg_5_0.explore_level_info then
				arg_4_0:updateExploreLevelInfo(arg_4_1, arg_5_0.explore_level_info)
			end
		elseif arg_5_0.result == 2 then
			cclog("数据不存在")
		elseif arg_5_0.result == 3 then
			cclog("支线已完成")
		elseif arg_5_0.result == 4 then
			cclog("完成类型不匹配")
		end

		if arg_4_2 then
			arg_4_2(arg_5_0.result)
		end
	end)
end

function var_0_0.updateExploreLevelInfo(arg_6_0, arg_6_1, arg_6_2)
	playermodel.exploreLevel[arg_6_1] = arg_6_2
end

function var_0_0.finish_offer(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.running_offers = arg_7_2.running_offers
	arg_7_0.ready_num = arg_7_2.readyNum
	arg_7_0.new_offer_num = 1

	item_manager:deleteItem(ELECTRIC, xuanshang_data[arg_7_1].xuanshang_cost)
end

function var_0_0:getOfferList(arg_8_1)
	arg_8_1 = arg_8_1 or "daily"

	local var_8_0 = {}
	local var_8_1 = {}
	local var_8_2 = 1
	local var_8_3 = 1

	for iter_8_0, iter_8_1 in ipairs(self.running_offers) do
		local var_8_4 = xuanshang_data[iter_8_1].boss_modelid or "37666"
		local var_8_5 = xuanshang_data[iter_8_1].xuanshang_map

		assert(xuanshang_data[iter_8_1].xuanshang_map, "exploreOfferData[" .. iter_8_1 .. "].xuanshang_map" .. " is nil")

		local var_8_6 = self:getExploreAimInfo(var_8_5)
		local var_8_7 = {
			offerid = iter_8_1,
			aimid = var_8_5,
			equip_quality = xuanshang_data[iter_8_1].xuanshang_diff,
			des = xuanshang_data[iter_8_1].xuanshang_des
		}

		var_8_7.client = xuanshang_data[iter_8_1].xuanshang_weituoren or "委员会"
		var_8_7.boss_modelid = var_8_4
		var_8_7.head = model_data[var_8_4].head_image
		var_8_7.title = xuanshang_data[iter_8_1].xuanshang_name or "没填xuanshang_name"
		var_8_7.power_cost = xuanshang_data[iter_8_1].xuanshang_cost
		var_8_7.level_limit = xuanshang_data[iter_8_1].xuanshang_level
		var_8_7.drops = drop_manager:getAllDrops(xuanshang_data[iter_8_1].xuanshang_reward or "S1XUANSHANG1001")
		var_8_7.offerType = xuanshang_data[iter_8_1].is_special_xuanshang == 1 and "special" or "daily"

		if xuanshang_data[iter_8_1].is_special_xuanshang == 1 then
			var_8_7.index = var_8_2
			var_8_2 = var_8_2 + 1

			table.insert(var_8_1, var_8_7)
		else
			var_8_7.index = var_8_3
			var_8_3 = var_8_3 + 1

			table.insert(var_8_0, var_8_7)
		end
	end

	if arg_8_1 == "special" then
		return var_8_1
	elseif arg_8_1 == "daily" then
		return var_8_0
	end
end

function var_0_0.initOfferConfig(arg_9_0, arg_9_1)
	network:rpc("get_explore_offer_config", nil, function(arg_10_0)
		arg_9_0.running_offers = arg_10_0.running_offers
		arg_9_0.ready_limit = arg_10_0.ready_limit
		arg_9_0.running_limit = arg_10_0.running_limit
		arg_9_0.ready_num = arg_10_0.readyNum
		arg_9_0.ready_time = arg_10_0.ready_time
		arg_9_0.new_offer_num = arg_10_0.new_offer_num

		arg_9_0:get_can_mop_up_offers(arg_9_1)
	end)
end

function var_0_0.gen_running_offer(arg_11_0, arg_11_1)
	network:rpc("gen_running_offer", nil, function(arg_12_0)
		print("::::gen_running_offer::::", dump(arg_12_0))

		if arg_12_0.result == 1 then
			arg_11_0.running_offers = arg_12_0.offers
			arg_11_0.ready_num = arg_12_0.readyNum
			arg_11_0.ready_time = arg_12_0.ready_time
		elseif arg_12_0.result == 2 then
			global_ShowBlockWords("没有可领取的悬赏令")
		elseif arg_12_0.result == 3 then
			global_ShowBlockWords("可持有队列已满")
		end

		if arg_11_1 then
			arg_11_1(arg_12_0.result)
		end
	end)
end

function var_0_0:insert_offer(arg_13_1)
	self.running_offers = self.running_offers or {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		table.insert(self.running_offers, iter_13_1)
	end
end

function var_0_0:getReadyOfferNum()
	return self.ready_num
end

function var_0_0:getReadyOfferLimit()
	return self.ready_limit
end

function var_0_0:getRunningOfferNum(arg_16_1)
	if arg_16_1 == "special" then
		local var_16_0 = 0

		for iter_16_0, iter_16_1 in pairs(self.running_offers) do
			if xuanshang_data[iter_16_1].is_special_xuanshang == 1 then
				var_16_0 = var_16_0 + 1
			end
		end

		return var_16_0
	elseif arg_16_1 == "daily" then
		local var_16_1 = 0

		for iter_16_2, iter_16_3 in pairs(self.running_offers) do
			if xuanshang_data[iter_16_3].is_special_xuanshang ~= 1 then
				var_16_1 = var_16_1 + 1
			end
		end

		return var_16_1
	else
		return #self.running_offers
	end
end

function var_0_0:getRunningOfferLimit()
	return self.running_limit
end

function var_0_0.getOfferConditions(arg_18_0, arg_18_1)
	local var_18_0 = {
		function(arg_19_0, arg_19_1)
			local var_19_0 = {}

			for iter_19_0 in arg_19_0:gmatch("([^,]+)") do
				table.insert(var_19_0, iter_19_0)
			end

			return {
				limit_type = 1,
				attrs = var_19_0,
				limit_des = arg_19_1
			}
		end,
		function(arg_20_0, arg_20_1)
			local var_20_0 = {}

			for iter_20_0 in arg_20_0:gmatch("([^,]+)") do
				table.insert(var_20_0, tonumber(iter_20_0))
			end

			return {
				limit_type = 2,
				models = var_20_0,
				limit_des = arg_20_1
			}
		end
	}
	local var_18_1 = {}

	while xuanshang_data[arg_18_1]["condition_type" .. 1] do
		table.insert(var_18_1, var_18_0[xuanshang_data[arg_18_1]["condition_type" .. 1]](xuanshang_data[arg_18_1]["condition_value" .. 1], xuanshang_data[arg_18_1]["condition_des" .. 1]))
	end

	return next(var_18_1) ~= nil and var_18_1 or nil
end

function var_0_0.getOfferMapDrops(arg_21_0, arg_21_1)
	return drop_manager:getAllDrops(xuanshang_data[arg_21_1].map_reward or "EX11001001")
end

function var_0_0.getOfferTaskDrops(arg_22_0, arg_22_1)
	return drop_manager:getAllDrops(xuanshang_data[arg_22_1].xuanshang_reward)
end

function var_0_0:get_ready_time_count_down()
	return self.ready_time
end

function var_0_0.cancel_offer(arg_24_0, arg_24_1, arg_24_2)
	network:rpc("cancel_offer", {
		offerid = arg_24_1
	}, function(arg_25_0)
		if arg_25_0.result == 1 then
			arg_24_0.running_offers = arg_25_0.running_offers
			arg_24_0.ready_num = arg_25_0.readyNum
			arg_24_0.new_offer_num = 1

			arg_24_0:get_can_mop_up_offers(arg_24_2)
		elseif arg_24_2 then
			arg_24_2(arg_25_0.result)
		end
	end)
end

function var_0_0:get_new_running_offer_num()
	return self.new_offer_num or 0
end

function var_0_0.refresh_offer(arg_27_0, arg_27_1, arg_27_2)
	network:rpc("refresh_offer", {
		offerid = arg_27_1
	}, function(arg_28_0)
		if arg_28_0.result == 1 then
			arg_27_0.running_offers = arg_28_0.running_offers
			arg_27_0.ready_num = arg_28_0.readyNum

			local var_28_0 = arg_28_0.cost_diamond or 0

			playermodel.diamond = playermodel.diamond - var_28_0

			global_update_gold_stone_diamond(nil, nil, -var_28_0)
			arg_27_0:get_can_mop_up_offers(arg_27_2)
		elseif arg_28_0.result == 2 then
			global_ShowBlockWords("魂晶不足")

			if arg_27_2 then
				arg_27_2(arg_28_0.result)
			end
		end
	end)
end

function var_0_0:getAimIds()
	local var_29_0 = {}

	for iter_29_0, iter_29_1 in ipairs(self.running_offers) do
		if not xuanshang_data[iter_29_1] then
			print("errr data: ", iter_29_1)
		else
			var_29_0[#var_29_0 + 1] = xuanshang_data[iter_29_1].xuanshang_map
		end
	end

	return var_29_0
end

function var_0_0:get_can_mop_up_offers(arg_30_1)
	network:rpc("get_explore_sweep", {
		class = 4,
		aimidList = self:getAimIds()
	}, function(arg_31_0)
		if arg_31_0.result == 1 then
			self.canMopUpAims = {}

			for iter_31_0, iter_31_1 in ipairs(arg_31_0.sweepList or {}) do
				if iter_31_1.canSweep then
					self.canMopUpAims[iter_31_1.aimid] = true
				end
			end

			if arg_30_1 then
				arg_30_1(1)
			end
		else
			print("error: get mop up status failed")
		end
	end)
end

function var_0_0.do_explore_mop_up(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	network:rpc("do_explore_sweep", {
		class = arg_32_1,
		param1 = arg_32_2
	}, function(arg_33_0)
		if arg_33_0.result == 1 then
			global_gain(arg_33_0)

			if arg_33_0.explore_offer_info then
				arg_32_0.running_offers = arg_33_0.explore_offer_info.running_offers
				arg_32_0.ready_num = arg_33_0.explore_offer_info.readyNum
			end

			arg_32_0:get_can_mop_up_offers(arg_32_3)
		elseif arg_32_3 then
			arg_32_3(arg_33_0.result)
		end
	end)
end

function var_0_0:queryAimCanMopUp(arg_34_1)
	if not self.canMopUpAims then
		return false
	end

	return self.canMopUpAims[arg_34_1]
end

return var_0_0
