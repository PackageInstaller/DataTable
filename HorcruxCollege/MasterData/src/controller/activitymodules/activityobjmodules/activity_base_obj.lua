local var_0_1 = 2
local activity_conf_data = require("data.activity_conf_data")
local network = require("network.network")

function ACTIVITY_OBJ_NEW:init_activity_base_info(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self._id = arg_1_1
	self._status = arg_1_2
	self._module_stat = arg_1_4
	self._modules_info = {}

	self:initActivityModules(arg_1_3)
end

function ACTIVITY_OBJ_NEW:initActivityModules(arg_2_1)
	if not arg_2_1 then
		return
	end

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		iter_2_1.status = self._status

		if self["initModule" .. iter_2_1.module] then
			self["initModule" .. iter_2_1.module](self, iter_2_1)
		end

		self._modules_info[iter_2_1.module] = iter_2_1
	end
end

function ACTIVITY_OBJ_NEW:isHaveModule(arg_3_1)
	assert(arg_3_1, "Need Module")

	return activity_conf_data[self._id][arg_3_1] ~= nil
end

function ACTIVITY_OBJ_NEW:getStatus()
	return self._status
end

function ACTIVITY_OBJ_NEW.setStatus(arg_5_0, arg_5_1)
	arg_5_0._status = arg_5_1
end

function ACTIVITY_OBJ_NEW.isNewVersion(arg_6_0)
	return true
end

function ACTIVITY_OBJ_NEW:isCanShow()
	return self._status == var_0_1
end

function ACTIVITY_OBJ_NEW.getJumpToConfig(arg_8_0)
	return
end

function ACTIVITY_OBJ_NEW.canCloseDirectly(arg_9_0)
	return true
end

function ACTIVITY_OBJ_NEW.isNewVersionObj(arg_10_0)
	return true
end

function ACTIVITY_OBJ_NEW.getMainLayerImage(arg_11_0)
	if config._DEBUG then
		print("activityObj.getMainLayerImage is Deprecated")
	end

	return {
		"mainScenebg/activity/branch4/activity_entrance.png",
		"mainScenebg/activity/branch4/activity_entrance.png"
	}
end

function ACTIVITY_OBJ_NEW.getEntranceId(arg_12_0)
	if config._DEBUG then
		print("activityObj.getEntranceId is Deprecated")
	end

	return nil
end

function ACTIVITY_OBJ_NEW:isActivityShowEntrance()
	if config._DEBUG then
		print("activityObj.isActivityShowEntrance is Deprecated")
	end

	return self._status == var_0_1
end

function ACTIVITY_OBJ_NEW.getMainLayerAlertPos(arg_14_0)
	if config._DEBUG then
		print("activityObj.getMainLayerAlertPos is Deprecated")
	end

	return cc.p(104, 113)
end

function ACTIVITY_OBJ_NEW.getMainLayerNewAlertPos(arg_15_0)
	if config._DEBUG then
		print("activityObj.getMainLayerNewAlertPos is Deprecated")
	end

	return cc.p(130, 130)
end

function ACTIVITY_OBJ_NEW.getAutoPopLayerFunc(arg_16_0)
	if config._DEBUG then
		print("activityObj.getAutoPopLayerFunc is Deprecated")
	end

	return nil
end

function ACTIVITY_OBJ_NEW.getAutoPopOrder(arg_17_0)
	if config._DEBUG then
		print("activityObj.getAutoPopOrder is Deprecated")
	end

	return nil
end

function ACTIVITY_OBJ_NEW:isHasBattlePass()
	if config._DEBUG then
		print("????????isHasBattlePass", self._id, self:isHaveModule("bp"))
	end

	return self:isHaveModule("bp")
end

function ACTIVITY_OBJ_NEW:isHasWordCollect()
	return self:isHaveModule("word_collect")
end

function ACTIVITY_OBJ_NEW.updateOnOpen(arg_20_0)
	return
end

function ACTIVITY_OBJ_NEW.updateOnClose(arg_21_0)
	return
end

function ACTIVITY_OBJ_NEW:isHasRoulette()
	return self._isHasRoulette
end

function ACTIVITY_OBJ_NEW:isHasArt()
	return self._isHasArt
end

function ACTIVITY_OBJ_NEW:get_subsystem_time(arg_24_1)
	network:rpc("get_activity_sub_time_conf", {
		activityid = self._id
	}, function(arg_25_0)
		if arg_25_0.result == 1 then
			self.subsystemtime = arg_25_0.confs

			if arg_24_1 then
				arg_24_1(arg_25_0.confs)
			end
		else
			global_ShowBlockWords(L_ACTIVITY_NOT_MODEL_TIME)
		end
	end)
end

function ACTIVITY_OBJ_NEW:getSystemTime()
	return self.subsystemtime
end

function ACTIVITY_OBJ_NEW:getSystemTimeTbl()
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in pairs(self.subsystemtime) do
		var_27_0[iter_27_1.id] = iter_27_1
	end

	return var_27_0
end

function ACTIVITY_OBJ_NEW:is_module_stat_finished(arg_28_1)
	for iter_28_0, iter_28_1 in pairs(self._module_stat) do
		if iter_28_1.activitymodule == arg_28_1 then
			return iter_28_1.finished
		end
	end

	return true
end

function ACTIVITY_OBJ_NEW:update_module_stat(arg_29_1, arg_29_2)
	for iter_29_0, iter_29_1 in pairs(self._module_stat) do
		if iter_29_1.activitymodule == arg_29_1 then
			iter_29_1.finished = arg_29_2
		end
	end
end

function ACTIVITY_OBJ_NEW:get_module_starttime(arg_30_1)
	return self._modules_info[arg_30_1] and self._modules_info[arg_30_1].starttime
end

function ACTIVITY_OBJ_NEW:get_module_finishtime(arg_31_1)
	return self._modules_info[arg_31_1] and self._modules_info[arg_31_1].finishtime
end

function ACTIVITY_OBJ_NEW:get_module_resettime(arg_32_1)
	for iter_32_0, iter_32_1 in pairs(self._modules_info) do
		if string.find(iter_32_0, arg_32_1) then
			return self._modules_info[iter_32_0] and self._modules_info[iter_32_0].resettime
		end
	end
end

function ACTIVITY_OBJ_NEW:getActivityProceed(arg_33_1, arg_33_2)
	if arg_33_2 == "bp" then
		return self:getActivityBPProceed(arg_33_1)
	elseif arg_33_2 == "pt" then
		return self:getActivityPTProceed(arg_33_1)
	end
end

function ACTIVITY_OBJ_NEW:getActivityProceedAward(arg_34_1, arg_34_2, arg_34_3)
	if arg_34_3 == "bp" then
		return self:getActivityBPProceedAward(arg_34_1, arg_34_2)
	elseif arg_34_3 == "pt" then
		return self:getActivityPTProceedAward(arg_34_1, arg_34_2)
	end
end

function ACTIVITY_OBJ_NEW:getActivityPTProceed(arg_35_1)
	network:rpc("get_activity_pt_proceed", {
		activityid = self._id
	}, function(arg_36_0)
		if arg_36_0.result == 1 then
			if arg_35_1 then
				arg_35_1(1, arg_36_0.list)
			end
		elseif arg_35_1 then
			arg_35_1(arg_36_0.result)
		end
	end)
end

function ACTIVITY_OBJ_NEW:getActivityPTProceedAward(arg_37_1, arg_37_2)
	network:rpc("get_activity_pt_proceed_award", {
		activityid = self._id,
		index = arg_37_1
	}, function(arg_38_0)
		if arg_38_0.result == 1 then
			if arg_37_2 then
				arg_37_2(1, arg_38_0)
			end
		elseif arg_37_2 then
			arg_37_2(arg_38_0.result, arg_38_0)
		end
	end)
end

function ACTIVITY_OBJ_NEW:getFightCollectionItemId()
	local activity_multi_pt_conf_data = require("data.activity_multi_pt_conf_data")

	if activity_multi_pt_conf_data[self._id] then
		return activity_multi_pt_conf_data[self._id].cost_item
	end

	local activity_proceed_data = require("data.activity_proceed_data")

	if activity_proceed_data[self._id .. "bp-1"] then
		return activity_proceed_data[self._id .. "bp-1"].item1
	end
end

function ACTIVITY_OBJ_NEW:getCollectionItem(arg_40_1)
	local unlockactivity_item_config_data = require("data.unlockactivity_item_config_data")
	local var_40_1 = {}

	if unlockactivity_item_config_data[self._id] then
		var_40_1.itemid = unlockactivity_item_config_data[self._id][arg_40_1 .. "_itemid"]
		var_40_1.des = unlockactivity_item_config_data[self._id][arg_40_1 .. "_des"]

		return var_40_1
	else
		return nil
	end
end
