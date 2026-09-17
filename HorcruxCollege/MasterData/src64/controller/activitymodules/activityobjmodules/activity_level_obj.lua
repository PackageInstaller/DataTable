local network = require("network.network")
local array_manager = require("controller.array_manager")
local activity_manager = require("controller.activity_manager")
local item_manager = require("controller.item_manager")
local playermodel = require("model.playermodel")
local task_data = require("data.task_data")
local activity_conf_data = require("data.activity_conf_data")
local activity_tecjnology_data = require("data.activity_tecjnology_data")
local activity_adventure_conf_data = require("data.activity_adventure_conf_data")

function ACTIVITY_OBJ_NEW.initModuleLevel(arg_1_0, arg_1_1)
	return
end

function ACTIVITY_OBJ_NEW:get_activity_level_info()
	network:rpc("get_activity_level_info", {
		activityid = self._id
	}, function(arg_3_0)
		if self._cur_technology and self._cur_technology < arg_3_0.cur_technology then
			arg_3_0.levelup = true
		end

		self.mode = arg_3_0.cur_mode
		self._cur_technology = arg_3_0.cur_technology

		activity_manager:updateActivityAlert("daily_level", self._id, arg_3_0.less_fight > 0)
		activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_LEVEL_INFO_UPDATE, arg_3_0)
	end)
end

function ACTIVITY_OBJ_NEW:get_cur_activity_technology()
	local var_4_0 = item_manager:getItemNumber(activity_conf_data[self._id].technology)

	if not activity_tecjnology_data[self._cur_technology + 1] then
		return self._cur_technology, "max", 100
	end

	return self._cur_technology - 1, string.format("%d/%d", var_4_0 - activity_tecjnology_data[self._cur_technology].num1, activity_tecjnology_data[self._cur_technology + 1].num1 - activity_tecjnology_data[self._cur_technology].num1), (var_4_0 - activity_tecjnology_data[self._cur_technology].num1) / (activity_tecjnology_data[self._cur_technology + 1].num1 - activity_tecjnology_data[self._cur_technology].num1) * 100
end

function ACTIVITY_OBJ_NEW:get_activity_level_buy_time_cost()
	self.mode = self.mode or 17301

	return activity_adventure_conf_data[self.mode].buy_cost
end

function ACTIVITY_OBJ_NEW:add_activity_level_time()
	network:rpc("add_activity_level_time", {
		activityid = self._id
	}, function(arg_7_0)
		if arg_7_0.result == 1 then
			self:get_activity_level_info()
			global_ShowBlockWords(L_TWISTEGG_LACK_OF_COST.Buy_Success)

			if arg_7_0.costdiamond ~= 0 then
				playermodel.diamond = playermodel.diamond - arg_7_0.costdiamond

				global_update_gold_stone_diamond(nil, nil, playermodel.diamond)
			end
		elseif arg_7_0.result == 2 then
			global_ShowBlockWords(L_ACTIVITY_ADV_3)
		elseif arg_7_0.result == 4 then
			global_ShowBlockWords(L_ACTIVITY_ADV_4)
		elseif arg_7_0.result == 3 then
			LayerManager:pushInLayer("PopDoLayer", {
				surecallback = function()
					LayerManager:switchShowLayer("SupermarketLayer")
				end,
				labels = {
					button = L_BUTTON_TEXT.Sure,
					title = L_TOWER_DEFENCE_COST_ERROR[6],
					des = L_TVT_GO_BUG
				}
			})
		end
	end)
end

function ACTIVITY_OBJ_NEW.get_activity_adventure_add(arg_9_0, arg_9_1, arg_9_2)
	while activity_adventure_conf_data[arg_9_1]["upservant" .. 1] do
		if arg_9_2 == activity_adventure_conf_data[arg_9_1]["upservant" .. 1] then
			return activity_adventure_conf_data[arg_9_1]["upnum" .. 1 .. "_" .. playermodel.soulContract[arg_9_2]] or activity_adventure_conf_data[arg_9_1]["upnum" .. 1]
		end
	end

	return 0
end

function ACTIVITY_OBJ_NEW:getActivityLevelDrop(arg_10_1)
	local var_10_0 = 0

	for iter_10_0, iter_10_1 in pairs(require("controller.formation.formation_mode_manager"):getInstance():getFormationInfo()[1]) do
		var_10_0 = var_10_0 + (self:get_activity_adventure_add(arg_10_1, iter_10_1.fight_girl) or 0)
	end

	return {
		itemid = activity_adventure_conf_data[arg_10_1].upitem,
		num = var_10_0
	}
end

function ACTIVITY_OBJ_NEW:getDailyLevelItem()
	return activity_adventure_conf_data[self.mode].upitem
end

function ACTIVITY_OBJ_NEW:getDailyLevelServant()
	local var_12_0 = {}

	while activity_adventure_conf_data[self.mode]["upservant" .. 1] do
		table.insert(var_12_0, {
			servantid = activity_adventure_conf_data[self.mode]["upservant" .. 1]
		})
	end

	return var_12_0
end

function ACTIVITY_OBJ_NEW:sweep_activity_daily_level(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	network:rpc("sweep_activity_daily_level", {
		activityid = self._id,
		mode = arg_13_1,
		chapter = arg_13_2,
		fight_array = arg_13_3
	}, function(arg_14_0)
		if arg_14_0.result == 1 then
			global_gain(arg_14_0)
			self:get_activity_level_info()
			global_ShowBlockWords("扫荡成功!!!")
		elseif arg_14_0.result == 2 then
			global_ShowBlockWords("该模式不支持扫荡!!!")
		elseif arg_14_0.result == 3 then
			global_ShowBlockWords("关卡错误!!!")
		elseif arg_14_0.result == 4 then
			global_ShowBlockWords("通过关卡后才可以扫荡哦~")
		elseif arg_14_0.result == 5 then
			global_ShowBlockWords("挑战次数不足!!!")
		else
			global_ShowBlockWords("error!!!")
		end

		if arg_13_4 then
			arg_13_4(arg_14_0)
		end
	end)
end
