local var_0_0 = {}
local activity_conf_data = require("data.activity_conf_data")
local item_data = require("data.item_data")
local time_check_manager = require("controller.time_check_manager")
local activity_manager = require("controller.activity_manager")
local network = require("network.network")
local var_0_6 = 109
local var_0_7 = 4
local var_0_8 = {
	{
		itemid = 1000205
	},
	{
		itemid = 1000204
	},
	{
		itemid = 1000200
	},
	{
		itemid = 3050011
	}
}
local var_0_9 = {
	{
		itemid = 3052911
	},
	{
		itemid = 3052921
	},
	{
		itemid = 3052931
	},
	{
		itemid = 3052941
	},
	{
		itemid = 3052951
	},
	{
		itemid = 3053011
	},
	{
		itemid = 3053021
	},
	{
		itemid = 3053031
	},
	{
		itemid = 3053041
	},
	{
		itemid = 3053051
	},
	{
		itemid = 3053111
	},
	{
		itemid = 3053121
	},
	{
		itemid = 3053131
	},
	{
		itemid = 3053141
	},
	{
		itemid = 3053151
	},
	{
		itemid = 3053211
	},
	{
		itemid = 3053221
	},
	{
		itemid = 3053231
	},
	{
		itemid = 3053241
	},
	{
		itemid = 3053251
	},
	{
		itemid = 3053311
	},
	{
		itemid = 3053321
	},
	{
		itemid = 3053331
	},
	{
		itemid = 3053341
	},
	{
		itemid = 3053351
	},
	{
		itemid = 3053411
	},
	{
		itemid = 3053421
	},
	{
		itemid = 3053431
	},
	{
		itemid = 3053441
	},
	{
		itemid = 3053451
	},
	{
		itemid = 3053511
	},
	{
		itemid = 3053521
	},
	{
		itemid = 3053531
	},
	{
		itemid = 3053541
	},
	{
		itemid = 3053551
	},
	{
		itemid = 3053611
	},
	{
		itemid = 3053621
	},
	{
		itemid = 3053631
	},
	{
		itemid = 3053641
	},
	{
		itemid = 3053651
	},
	{
		itemid = 3053711
	},
	{
		itemid = 3053721
	},
	{
		itemid = 3053731
	},
	{
		itemid = 3053741
	},
	{
		itemid = 3053751
	}
}

function var_0_0.getTwistStatus(arg_1_0)
	network:rpc("get_twist_status", {
		twistclass = var_0_7
	}, function(arg_2_0)
		if arg_2_0.result ~= 1 then
			return
		end

		arg_1_0.data = arg_2_0.config
		arg_1_0.twistData = {}

		for iter_2_0, iter_2_1 in pairs(arg_2_0.config) do
			arg_1_0.twistData[iter_2_1.twisttype] = iter_2_1
		end

		activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_TWIST_STATUS_UPDATE)
	end)
end

function var_0_0.getTwistRemainItems(arg_3_0, arg_3_1)
	network:rpc("get_twist_remain_item", {
		id = arg_3_1
	}, function(arg_4_0)
		arg_3_0.list = arg_4_0.list or var_0_9
		arg_3_0.keylist = arg_4_0.keylist or var_0_8

		activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_TWIST_ITEM_UPDATE)
	end)
end

function var_0_0:getTwistConf()
	return self.twistData
end

function var_0_0.getActivityEndTime(arg_6_0)
	return global_get_time_by_date(activity_conf_data[var_0_6].finishtime) - time_check_manager:getCurTime()
end

function var_0_0:isTwsitLock(arg_7_1)
	if not arg_7_1 then
		return
	end

	if not self.twistData or not next(self.twistData) then
		return true
	end

	return self.twistData[arg_7_1].locked
end

function var_0_0:isTwsitNUll(arg_8_1)
	if not arg_8_1 then
		return
	end

	if not self.twistData or not next(self.twistData) then
		return false
	end

	if not self.twistData[arg_8_1].twist_remain_count then
		return false
	end

	return self.twistData[arg_8_1].twist_remain_count <= 0
end

function var_0_0:getTwistTenDisplayNum(arg_9_1)
	if not arg_9_1 then
		return
	end

	if not self.twistData or not next(self.twistData) then
		return 0
	end

	if not self.twistData[arg_9_1].twist_remain_count then
		return 10
	end

	local var_9_0 = self.twistData[arg_9_1].twist_remain_count

	if not self.twistData[arg_9_1].twist_remain_count or var_9_0 > 10 then
		return 10
	else
		return var_9_0
	end
end

local function var_0_10(arg_10_0, arg_10_1)
	return item_data[arg_10_0.itemid].equip_quality > item_data[arg_10_1.itemid].equip_quality
end

function var_0_0:getSpItemData(arg_11_1)
	if arg_11_1 == 107 then
		return var_0_8
	end

	if not self.keylist or not next(self.keylist) then
		return var_0_8
	end

	table.sort(self.keylist, var_0_10)

	return self.keylist
end

function var_0_0:getOrdTwistList(arg_12_1)
	if arg_12_1 == 107 then
		return var_0_9
	end

	if not self.list or not next(self.list) then
		return var_0_9
	end

	table.sort(self.list, var_0_10)

	return self.list
end

function var_0_0:getTwistRemainTime(arg_13_1)
	if not arg_13_1 then
		return
	end

	if not self.twistData or not next(self.twistData) then
		return false
	end

	local var_13_0 = self.twistData[arg_13_1].twist_remain_count

	if self.twistData[arg_13_1].twist_remain_count and var_13_0 < 10 then
		return "0" .. var_13_0
	end

	return var_13_0
end

function var_0_0:set_twist_status(arg_14_1)
	if arg_14_1 then
		arg_14_1(self.data)
	end
end

function var_0_0:getNeedShowTwist()
	if not self.twistData then
		return
	end

	for iter_15_0 = 105, 107 do
		if not self:isTwsitNUll(iter_15_0) then
			return iter_15_0
		end
	end

	return 107
end

return var_0_0
