local network = require("network.network")
local item_data = require("data.item_data")
local task_data = require("data.task_data")
local activity_conf_data = require("data.activity_conf_data")
local activity_art_conf_data = require("data.activity_art_conf_data")
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local item_manager = require("controller.item_manager")
local drop_manager = require("controller.drop_manager")
local var_0_9 = require("network.network")
local playermodel = require("model.playermodel")

function ACTIVITY_OBJ_NEW:getArtInfo()
	var_0_9:rpc("get_activity_art_info", {
		activityid = self._id
	}, function(arg_2_0)
		if arg_2_0.result == 1 then
			self.artStat = arg_2_0.stat

			activity_manager:fireEvent(activity_manager.activityEventId.ART_INFO_UPDATE, arg_2_0)
		else
			global_ShowBlockWords(L_ACTIVITY_END)
		end
	end)
end

function ACTIVITY_OBJ_NEW:activityArtDraw(arg_3_1, arg_3_2)
	var_0_9:rpc("activity_art_use_brushes", {
		activityid = self._id
	}, function(arg_4_0)
		if arg_4_0.result == 1 then
			for iter_4_0, iter_4_1 in pairs(arg_4_0.costItems) do
				item_manager:deleteItem(iter_4_1.itemid, iter_4_1.num)
			end

			global_ShowBlockWords(L_ACTIVITY_ART_CHOOSE[2])
			global_gain(arg_4_0)
			self:getArtInfo()
		end
	end)
end

function ACTIVITY_OBJ_NEW:getArtEndTime()
	local var_5_0 = global_get_time_by_date(activity_art_conf_data[self._id].finishtime) - time_check_manager:getCurTime()

	if var_5_0 < 0 then
		return 0
	end

	return var_5_0
end

function ACTIVITY_OBJ_NEW:getArtItemNumber()
	return item_manager:getItemNumber(activity_art_conf_data[self._id].item)
end

function ACTIVITY_OBJ_NEW:isArtFinished()
	return self.artStat and self.artStat >= activity_art_conf_data[self._id].totalnum
end

function ACTIVITY_OBJ_NEW:isArtNeedAlert()
	return self:getArtItemNumber() > 0
end

function ACTIVITY_OBJ_NEW:getArtTaskList()
	self:getActivityTaskList(nil, function(arg_10_0, arg_10_1)
		if arg_10_0 ~= 1 then
			return
		end

		self.taskList = {}

		for iter_10_0, iter_10_1 in pairs(arg_10_1.list) do
			iter_10_1.name = task_data[iter_10_1.taskid].name
			iter_10_1.task_des = task_data[iter_10_1.taskid].task_des
			iter_10_1.image = task_data[iter_10_1.taskid].image
			iter_10_1.drop = task_data[iter_10_1.taskid].drop
			iter_10_1.jump = task_data[iter_10_1.taskid].jump
			iter_10_1.order = task_data[iter_10_1.taskid].order

			if iter_10_1.status == 1 then
				iter_10_1.percent = -1
			end

			table.insert(self.taskList, iter_10_1)
		end

		table.sort(self.taskList, function(arg_11_0, arg_11_1)
			if arg_11_0.percent == arg_11_1.percent then
				return arg_11_0.order < arg_11_1.order
			else
				return arg_11_0.percent > arg_11_1.percent
			end
		end)
		activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, {
			list = self.taskList,
			listLen = #self.taskList
		})
		activity_manager:updateActivityAlert("art", self._id, self:isHasArtCanCompleteTask())
	end, false, nil, "art")
end

function ACTIVITY_OBJ_NEW:isHasArtCanCompleteTask()
	if not self.taskList or #self.taskList == 0 then
		return false
	end

	if self.taskList[1].status == 0 and self.taskList[1].percent == 100 then
		return true
	end

	return false
end

function ACTIVITY_OBJ_NEW:getArtTaskReward(arg_13_1)
	self:getTaskReward(arg_13_1, function(arg_14_0, arg_14_1)
		if arg_14_0 ~= 1 then
			global_ShowBlockWords(L_BATTLE_PASS.FAIL)

			return
		end

		global_gain(arg_14_1)
		self:getArtTaskList()
		self:getArtInfo()
	end)
end
