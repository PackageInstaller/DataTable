local activity_base_manager = require("controller.activitymodules.activity_base_manager")

function activity_base_manager.initActivityCommonFlop(arg_1_0, arg_1_1)
	return
end

function activity_base_manager:getActivityCommonFlopConf(arg_2_1, arg_2_2)
	return self.activities[arg_2_1]:getActivityCommonFlopConf(arg_2_2)
end

function activity_base_manager:setActivityCommonFlopResult(arg_3_1, arg_3_2, arg_3_3)
	return self.activities[arg_3_1]:setActivityCommonFlopResult(arg_3_2, arg_3_3)
end

function activity_base_manager:setCommonFlopChampionItems(arg_4_1, arg_4_2, arg_4_3)
	return self.activities[arg_4_1]:setCommonFlopChampionItems(arg_4_2, arg_4_3)
end

function activity_base_manager:getCommonFlopLimitTurns(arg_5_1)
	return self.activities[arg_5_1]:getCommonFlopLimitTurns()
end

function activity_base_manager:getCommonFlopTurns(arg_6_1)
	return self.activities[arg_6_1]:getCommonFlopTurns()
end

function activity_base_manager:getChampionItems(arg_7_1)
	return self.activities[arg_7_1]:getChampionItems()
end

function activity_base_manager:getChampionConf(arg_8_1)
	return self.activities[arg_8_1]:getChampionConf()
end

function activity_base_manager:getCommonSpecialTurns(arg_9_1)
	return self.activities[arg_9_1]:getCommonSpecialTurns()
end

function activity_base_manager:isChampionByPos(arg_10_1, arg_10_2)
	return self.activities[arg_10_1]:isChampionByPos(arg_10_2)
end

function activity_base_manager:goCommonNextTurn(arg_11_1)
	return self.activities[arg_11_1]:goCommonNextTurn()
end

function activity_base_manager:canreset(arg_12_1)
	return self.activities[arg_12_1]:getCanReset()
end

function activity_base_manager:getNormalReward(arg_13_1)
	return self.activities[arg_13_1]:getNormalReward()
end

function activity_base_manager:getChampiontByTurns(arg_14_1, arg_14_2)
	return self.activities[arg_14_1]:getChampiontByTurns(arg_14_2)
end

function activity_base_manager:getAllTurnsChampion(arg_15_1)
	return self.activities[arg_15_1]:getAllTurnsChampion()
end

function activity_base_manager:getCommonFlopPoint(arg_16_1)
	return self.activities[arg_16_1]:getCommonFlopPoint()
end

function activity_base_manager:test11(arg_17_1)
	return self.activities[arg_17_1]:test11()
end

function activity_base_manager:isCommonFlop(arg_18_1)
	return self.activities[arg_18_1]:isCommonFlop()
end

function activity_base_manager:getFlopShopJump(arg_19_1)
	return self.activities[arg_19_1]:getFlopShopJump()
end

function activity_base_manager:setCommonFlopThreeRandomChampion(arg_20_1, arg_20_2)
	return self.activities[arg_20_1]:setCommonFlopThreeRandomChampion(arg_20_2)
end
