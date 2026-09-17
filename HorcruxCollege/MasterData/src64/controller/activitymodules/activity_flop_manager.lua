local activity_base_manager = require("controller.activitymodules.activity_base_manager")

function activity_base_manager.initActivityFlop(arg_1_0, arg_1_1)
	return
end

function activity_base_manager:getActivityFlopConf(arg_2_1, arg_2_2)
	return self.activities[arg_2_1]:getActivityFlopConf(arg_2_2)
end

function activity_base_manager:setActivityFlopResult(arg_3_1, arg_3_2, arg_3_3)
	return self.activities[arg_3_1]:setActivityFlopResult(arg_3_2, arg_3_3)
end

function activity_base_manager:getFlopChampionItem(arg_4_1)
	return self.activities[arg_4_1]:getChampionItem()
end

function activity_base_manager:getFlopMatrixConf(arg_5_1)
	return self.activities[arg_5_1]:getMatrixConf()
end

function activity_base_manager:getChampionOrder(arg_6_1)
	return self.activities[arg_6_1]:getChampionOrder()
end

function activity_base_manager:getChampionCardPos(arg_7_1)
	return self.activities[arg_7_1]:getChampionCardPos()
end

function activity_base_manager:getFlopTicket(arg_8_1)
	return self.activities[arg_8_1]:getFlopTicket()
end

function activity_base_manager:getFlopCount(arg_9_1)
	return self.activities[arg_9_1]:getFlopCount()
end

function activity_base_manager:getFlopItemByOrder(arg_10_1, arg_10_2)
	return self.activities[arg_10_1]:getItemByOrder(arg_10_2)
end

function activity_base_manager:buyTicketItem(arg_11_1, arg_11_2, arg_11_3)
	return self.activities[arg_11_1]:buyTicketItem(arg_11_2, arg_11_3)
end

function activity_base_manager:getDropConf(arg_12_1)
	return self.activities[arg_12_1]:getDropConf()
end

function activity_base_manager:getFlopTurns(arg_13_1)
	return self.activities[arg_13_1]:getFlopTurns()
end

function activity_base_manager:getCurFlopLevel(arg_14_1)
	return self.activities[arg_14_1]:getCurFlopLevel()
end

function activity_base_manager:getResetEnable(arg_15_1)
	return self.activities[arg_15_1]:getResetEnable()
end

function activity_base_manager.resetFlop(arg_16_0, arg_16_1, arg_16_2)
	return
end

function activity_base_manager:getFlopSkinData(arg_17_1)
	return self.activities[arg_17_1]:getFlopSkinData()
end

function activity_base_manager:getFlopLimitBag(arg_18_1, arg_18_2, arg_18_3)
	return self.activities[arg_18_1]:getFlopLimitBag(arg_18_2, arg_18_3)
end

function activity_base_manager:buyFlopLimitBag(arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5)
	return self.activities[arg_19_1]:buyFlopLimitBag(arg_19_2, arg_19_3, arg_19_4, arg_19_5)
end

function activity_base_manager:getSkinList(arg_20_1)
	return self.activities[arg_20_1]:getSkinList()
end

function activity_base_manager:getSkinid(arg_21_1)
	return self.activities[arg_21_1]:getSkinid()
end

function activity_base_manager:getFlopAwardAllByTurn(arg_22_1)
	return self.activities[arg_22_1]:getFlopAwardAllByTurn()
end

function activity_base_manager:goNextTurn(arg_23_1, arg_23_2)
	return self.activities[arg_23_1]:goNextTurn(arg_23_2)
end

function activity_base_manager:goPreviousTurn(arg_24_1, arg_24_2)
	return self.activities[arg_24_1]:goPreviousTurn(arg_24_2)
end

function activity_base_manager:getFlopFurniture(arg_25_1, arg_25_2)
	return self.activities[arg_25_1]:getFlopFurniture(arg_25_2)
end

function activity_base_manager:canFlop(arg_26_1)
	return self.activities[arg_26_1]:can_flop()
end

function activity_base_manager:getFlopLimitTurns(arg_27_1)
	return self.activities[arg_27_1]:getFlopLimitTurns()
end

function activity_base_manager:canGoPreciouTurn(arg_28_1)
	return self.activities[arg_28_1]:canGoPreciouTurn()
end
