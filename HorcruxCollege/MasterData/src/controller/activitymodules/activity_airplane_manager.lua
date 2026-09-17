local activity_base_manager = require("controller.activitymodules.activity_base_manager")

function activity_base_manager:enter_airplane_get_conf(arg_1_1, arg_1_2)
	return self.activities[arg_1_1]:enter_airplane_get_conf(arg_1_2)
end

function activity_base_manager:go_next_turns_tasks(arg_2_1, arg_2_2)
	return self.activities[arg_2_1]:go_next_turns_tasks(arg_2_2)
end

function activity_base_manager:buy_airplane_shop(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	return self.activities[arg_3_1]:buy_airplane_shop(arg_3_2, arg_3_3, arg_3_4)
end

function activity_base_manager:updateShopPanelData(arg_4_1, arg_4_2)
	return self.activities[arg_4_1]:updateShopPanelData(arg_4_2)
end

function activity_base_manager:getAPKeyItem(arg_5_1)
	return self.activities[arg_5_1]:getAPKeyItem()
end

function activity_base_manager:getAPKeyPoint(arg_6_1)
	return self.activities[arg_6_1]:getAPKeyPoint()
end

function activity_base_manager:getAPTaskTurns(arg_7_1)
	return self.activities[arg_7_1]:getAPTaskTurns()
end

function activity_base_manager:getAPShopTurns(arg_8_1)
	return self.activities[arg_8_1]:getAPShopTurns()
end

function activity_base_manager:getAPShopData(arg_9_1)
	return self.activities[arg_9_1]:getAPShopData()
end

function activity_base_manager:goCommonNextTurn(arg_10_1)
	return self.activities[arg_10_1]:goCommonNextTurn()
end

function activity_base_manager:getAPMaxTaskTurns(arg_11_1)
	return self.activities[arg_11_1]:getAPMaxTaskTurns()
end

function activity_base_manager:getGiftBuyJump(arg_12_1)
	return self.activities[arg_12_1]:getGiftBuyJump()
end
