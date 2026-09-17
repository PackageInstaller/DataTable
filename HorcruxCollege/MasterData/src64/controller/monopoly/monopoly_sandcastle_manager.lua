local MonopolySandcastleManager = class("MonopolySandcastleManager", (require("controller.base_manager")))

MonopolySandcastleManager.MULTITON_MSG = "MonopolySandcastleManager instancealready constructed!"

local var_0_1 = tonumber
local var_0_2 = tostring

MonopolySandcastleManager.COST_TYPE = {
	DIAMOND = 2,
	GOLD = 1
}
MonopolySandcastleManager.COST_STATE = {
	DOWN = 1,
	UP = 0,
	NORMAL = 2
}
MonopolySandcastleManager.INCOME_STATE = {
	DOWN = 1,
	UP = 0,
	NORMAL = 2
}

function MonopolySandcastleManager:ctor()
	MonopolySandcastleManager.super.ctor(self)

	self._data = {}
end

function MonopolySandcastleManager:requestInfo(arg_2_1)
	return
end

function MonopolySandcastleManager:requestLevelUp()
	local var_3_0 = require("controller.monopoly.monopoly_manager"):getInstance()

	var_3_0:requestHandleTile(var_3_0.GRID_ACTION_TYPE.LEVEL_UP)
end

function MonopolySandcastleManager:requestPassLevelUp()
	local var_4_0 = require("controller.monopoly.monopoly_manager"):getInstance()

	var_4_0:requestHandleTile(var_4_0.GRID_ACTION_TYPE.PASS)
end

function MonopolySandcastleManager:handlerInfo(arg_5_1)
	return
end

function MonopolySandcastleManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function MonopolySandcastleManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

function MonopolySandcastleManager:getCostInfo(arg_8_1)
	local var_8_0 = require("controller.monopoly.monopoly_manager"):getInstance()
	local var_8_1 = require("controller.monopoly.monopoly_map_manager"):getInstance()
	local var_8_2 = require("controller.monopoly.monopoly_buff_manager"):getInstance()
	local var_8_3 = var_8_1:getPosByValue(arg_8_1)
	local var_8_4 = var_8_1:getMapData()[var_8_3.x][var_8_3.y].gridType
	local var_8_5 = var_8_0:getLevelConfigByLevel(var_8_0:getLevel())
	local var_8_6 = var_8_0:getGridInfo(arg_8_1)
	local var_8_7 = {
		income = 0,
		incomeTextColor = "fff45c",
		costNum = 0,
		costTextColor = "00ffff",
		costState = MonopolySandcastleManager.COST_STATE.NORMAL
	}
	local var_8_8 = 0

	if var_8_6 then
		var_8_8 = var_8_6.lv
	end

	var_8_7.curLv = var_8_8
	var_8_7.nextLv = var_8_8 + 1

	local var_8_9 = "Monopoly_" .. var_8_0:getActivityId() .. "/MonopolySandcastleLayer/"

	if var_8_4 == var_8_1.GridType.Sand then
		var_8_7.costNum = var_8_5["up_money_" .. var_8_8 + 1]
		var_8_7.income = var_8_5["build_income_" .. var_8_8 + 1]
		var_8_7.buildImg = var_8_9 .. "sand_" .. var_8_8 .. ".png"
		var_8_7.nextBuildImg = var_8_9 .. "sand_" .. var_8_8 + 1 .. ".png"
		var_8_7.currencyPath = "public/currency/UI_battleEnd_gold.png"
		var_8_7.incomePath = "public/currency/UI_battleEnd_gold.png"
		var_8_7.costType = MonopolySandcastleManager.COST_TYPE.GOLD
	elseif var_8_4 == var_8_1.GridType.HignSand then
		var_8_7.costNum = var_8_5["highup_money_" .. var_8_8 + 1]
		var_8_7.income = var_8_5["highbuild_income_" .. var_8_8 + 1]
		var_8_7.buildImg = var_8_9 .. "high_sand_" .. var_8_8 .. ".png"
		var_8_7.nextBuildImg = var_8_9 .. "high_sand_" .. var_8_8 + 1 .. ".png"
		var_8_7.currencyPath = "public/currency/UI_battleEnd_diamond.png"
		var_8_7.incomePath = "public/currency/UI_battleEnd_gold.png"
		var_8_7.costType = MonopolySandcastleManager.COST_TYPE.DIAMOND
	end

	if var_8_7.costType == MonopolySandcastleManager.COST_TYPE.GOLD then
		local var_8_10 = var_8_0:getBuffs()
		local var_8_11 = 0
		local var_8_12 = 0

		for iter_8_0 = 1, #var_8_10 do
			local var_8_13 = var_8_2:getConfigById((var_0_2(var_8_10[iter_8_0].id)))

			if var_8_13.type == var_8_2.BUFF_VALUE_TYPE.BUILD_COST_GOLD then
				if var_8_13.buff_or_debuff == var_8_2.BUFF_TYPE.BUFF then
					var_8_11 = var_8_11 - var_0_1(var_8_13.param1)
				elseif var_8_13.buff_or_debuff == var_8_2.BUFF_TYPE.DEBUFF then
					var_8_11 = var_8_11 + var_0_1(var_8_13.param1)
				end
			end

			if var_8_13.type == var_8_2.BUFF_VALUE_TYPE.BUILD_INCOME then
				if var_8_13.buff_or_debuff == var_8_2.BUFF_TYPE.BUFF then
					var_8_12 = var_8_12 + var_0_1(var_8_13.param1)
				elseif var_8_13.buff_or_debuff == var_8_2.BUFF_TYPE.DEBUFF then
					var_8_12 = var_8_12 - var_0_1(var_8_13.param1)
				end
			end
		end

		if var_8_11 ~= 0 then
			if var_8_11 > 0 then
				var_8_7.costState = MonopolySandcastleManager.COST_STATE.UP
				var_8_7.costTextColor = "ff0000"
			else
				var_8_7.costState = MonopolySandcastleManager.COST_STATE.DOWN
				var_8_7.costTextColor = "00ff00"
			end

			var_8_7.costNum = var_8_7.costNum * (1 + var_8_11)
		end

		if var_8_12 ~= 0 then
			if var_8_12 > 0 then
				var_8_7.incomeState = MonopolySandcastleManager.INCOME_STATE.UP
				var_8_7.incomeTextColor = "00ff00"
			else
				var_8_7.incomeState = MonopolySandcastleManager.INCOME_STATE.DOWN
				var_8_7.incomeTextColor = "ff0000"
			end

			var_8_7.income = var_8_7.income * (1 + var_8_12)
		end
	end

	return var_8_7
end

function MonopolySandcastleManager:isMaxLevel(arg_9_1)
	local var_9_0 = require("controller.monopoly.monopoly_manager"):getInstance()
	local var_9_1 = require("controller.monopoly.monopoly_map_manager"):getInstance()
	local var_9_2 = var_9_1:getPosByValue(arg_9_1)
	local var_9_3 = var_9_1:getMapData()[var_9_2.x][var_9_2.y].gridType
	local var_9_4 = var_9_0:getLevelConfigByLevel(var_9_0:getLevel()).house_max_level
	local var_9_5 = var_9_0:getGridInfo(arg_9_1)

	if var_9_5 then
		return var_9_4 <= var_9_5.lv
	end

	return false
end

function MonopolySandcastleManager:updateSureButton()
	local var_10_0 = require("controller.monopoly.monopoly_manager"):getInstance()

	var_10_0:setPlayerGold(require("model.playermodel").gold)
	var_10_0:updateOurBillText()

	if self.layer then
		self.layer:updateSureButton()
	end
end

return MonopolySandcastleManager
