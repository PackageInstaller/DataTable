local network = require("network.network")
local drop_manager = require("controller.drop_manager")
local time_check_manager = require("controller.time_check_manager")
local activity_manager = require("controller.activity_manager")
local item_manager = require("controller.item_manager")
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local activity_newbee_investment_conf_data = require("data.activity_309.activity_newbee_investment_conf_data")

function ACTIVITY_OBJ_NEW:get_activity_newbee_investment_info()
	network:rpc("get_activity_newbee_investment_info", {
		activityid = self._id
	}, function(arg_2_0)
		if arg_2_0.result == 1 then
			self.manage_money_list = arg_2_0.issue_list
			self.manage_money_end_time = arg_2_0.end_time

			activity_manager:updateActivityAlert("investment", self._id, self:isManagedMoney())
			activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_MANAGE_MONEY_DATA_UPDATE, arg_2_0)
		end
	end)
end

function ACTIVITY_OBJ_NEW:activity_newbee_investment_invest(arg_3_1)
	network:rpc("activity_newbee_investment_invest", {
		activityid = self._id,
		issue = arg_3_1
	}, function(arg_4_0)
		if arg_4_0.result == 1 then
			if arg_4_0.cost_diamond then
				playermodel.diamond = playermodel.diamond - arg_4_0.cost_diamond

				global_update_gold_stone_diamond(nil, nil, arg_4_0.cost_diamond)
			end

			if arg_4_0.cost_items and next(arg_4_0.cost_items) then
				for iter_4_0, iter_4_1 in ipairs(arg_4_0.cost_items) do
					item_manager:deleteItem(iter_4_1.entityid, iter_4_1.num)
				end
			end

			self:get_activity_newbee_investment_info()
		else
			global_ShowBlockWords(L_MANAGE_MONEY_INVEST[arg_4_0.result])
		end

		if arg_4_0.result == 4 then
			LayerManager:pushInLayer("PopGoBuyDiamond", {
				is_need_pop_layer = 1
			})
		elseif arg_4_0.result == 5 then
			LayerManager:pushInLayer("PopGoBuyGiftTicketLayer", {
				is_need_pop_layer = 1
			})
		end
	end)
end

function ACTIVITY_OBJ_NEW:activity_newbee_investment_reward(arg_5_1)
	network:rpc("activity_newbee_investment_reward", {
		activityid = self._id,
		issue = arg_5_1
	}, function(arg_6_0)
		if arg_6_0.result == 1 then
			global_gain(arg_6_0)
			self:get_activity_newbee_investment_info()
		else
			global_ShowBlockWords(L_MANAGE_MONEY_GET_REWARD[arg_6_0.result])
		end
	end)
end

function ACTIVITY_OBJ_NEW:getManageMoneyEndTime()
	if not self.manage_money_end_time then
		return 1
	end

	return self.manage_money_end_time - time_check_manager:getCurTime()
end

function ACTIVITY_OBJ_NEW:getManageMoneyRewardType(arg_8_1)
	if time_check_manager:getCurTime() > self.manage_money_list[arg_8_1].end_time and self.manage_money_list[arg_8_1].invest then
		if drop_manager:getDiamond(activity_newbee_investment_conf_data[arg_8_1].drop_id) > 0 then
			return 0
		else
			return 1
		end
	end

	if activity_newbee_investment_conf_data[arg_8_1].invest_diamond then
		return 0
	else
		return 1
	end
end

function ACTIVITY_OBJ_NEW:getManageMoneyRewardNum(arg_9_1)
	if time_check_manager:getCurTime() > self.manage_money_list[arg_9_1].end_time and self.manage_money_list[arg_9_1].invest then
		if drop_manager:getDiamond(activity_newbee_investment_conf_data[arg_9_1].drop_id) > 0 then
			return drop_manager:getDiamond(activity_newbee_investment_conf_data[arg_9_1].drop_id)
		else
			return drop_manager:getAllDrops(activity_newbee_investment_conf_data[arg_9_1].drop_id)[1].dropNum
		end
	end

	return activity_newbee_investment_conf_data[arg_9_1].invest_diamond or activity_newbee_investment_conf_data[arg_9_1].invest_num1
end

function ACTIVITY_OBJ_NEW.getManageMoneyInvestNum(arg_10_0, arg_10_1)
	if activity_newbee_investment_conf_data[arg_10_1].invest_diamond then
		return activity_newbee_investment_conf_data[arg_10_1].invest_diamond, L_DIAMOND
	else
		return activity_newbee_investment_conf_data[arg_10_1].invest_num1, item_data[activity_newbee_investment_conf_data[arg_10_1].invest_id1].name
	end
end

function ACTIVITY_OBJ_NEW.getManageMoneyGetNum(arg_11_0, arg_11_1)
	if drop_manager:getDiamond(activity_newbee_investment_conf_data[arg_11_1].drop_id) > 0 then
		return drop_manager:getDiamond(activity_newbee_investment_conf_data[arg_11_1].drop_id), L_DIAMOND
	else
		local var_11_0 = drop_manager:getAllDrops(activity_newbee_investment_conf_data[arg_11_1].drop_id)

		return var_11_0[1].dropNum, item_data[var_11_0[1].dropid].name
	end
end

function ACTIVITY_OBJ_NEW:isManagedMoney()
	local var_12_0 = time_check_manager:getCurTime()

	for iter_12_0, iter_12_1 in pairs(self.manage_money_list) do
		if not iter_12_1.reward and var_12_0 >= iter_12_1.end_time and iter_12_1.invest then
			return true
		end
	end

	return false
end
