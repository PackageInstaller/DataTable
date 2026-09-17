local network = require("network.network")
local activity_manager = require("controller.activity_manager")
local item_manager = require("controller.item_manager")
local playermodel = require("model.playermodel")
local activity_recruit_servant_data = require("data.activity_recruit_servant_data")
local activity_recruit_index_data = require("data.activity_recruit_index_data")
local var_0_6 = {
	1,
	2,
	4,
	8,
	16,
	32,
	64,
	128,
	256,
	512,
	1024,
	2048,
	4096,
	8192,
	16384,
	32768,
	65536,
	131072,
	262144,
	524288,
	1048576,
	2097152,
	4194304,
	8388608,
	16777216,
	33554432,
	67108864,
	134217728,
	268435456,
	536870912,
	1073741824,
	2147483648
}

function ACTIVITY_OBJ_NEW.initModuleRecurit(arg_1_0)
	arg_1_0.recruitInfos = {}
	arg_1_0.recruitRoles = {}
end

function ACTIVITY_OBJ_NEW:get_recruit_info(arg_2_1)
	network:rpc("get_activity_recruit_info", {
		activityid = self._id
	}, function(arg_3_0)
		if arg_3_0.result == 1 then
			self:updateRecuritInfos(arg_3_0.list)
		end

		activity_manager:fireEvent(activity_manager.activityEventId.GET_RECURIT_INFOS, arg_3_0)

		if type(arg_2_1) == "function" then
			arg_2_1()
		end
	end)
end

function ACTIVITY_OBJ_NEW:complete_recurit_task(arg_4_1, arg_4_2)
	network:rpc("do_activity_recruit", {
		activityid = self._id,
		servantid = arg_4_1,
		taskindex = arg_4_2
	}, function(arg_5_0)
		if arg_5_0.result == 1 then
			if arg_5_0.consumes then
				for iter_5_0, iter_5_1 in ipairs(arg_5_0.consumes) do
					item_manager:deleteItem(iter_5_1.entityid, iter_5_1.num)
				end
			end

			global_gain(arg_5_0)
			self:get_recruit_info(function()
				activity_manager:fireEvent(activity_manager.activityEventId.COMPLETE_RECURIT_TASK, arg_5_0)
			end)
		else
			global_ShowBlockWords("完成任务出错")
		end
	end)
end

function ACTIVITY_OBJ_NEW:get_recurit_reward(arg_7_1)
	network:rpc("finish_activity_recruit", {
		activityid = self._id,
		servantid = arg_7_1
	}, function(arg_8_0)
		if arg_8_0.result == 1 then
			if arg_8_0.items then
				global_gain(arg_8_0)
			end

			self:get_recruit_info(function()
				activity_manager:fireEvent(activity_manager.activityEventId.GET_RECURIT_INFOS, arg_8_0)
			end)
		end
	end)
end

function ACTIVITY_OBJ_NEW:updateRecuritInfos(arg_10_1)
	self.recruitInfos = {}
	self.recruitRoles = {}

	local var_10_0 = {
		[RECRUIT_ROLE.ROLE_LIST_STATUS.LOCK] = 3,
		[RECRUIT_ROLE.ROLE_LIST_STATUS.GO_RECRUIT] = 2,
		[RECRUIT_ROLE.ROLE_LIST_STATUS.CAN_RECRUIT] = 1,
		[RECRUIT_ROLE.ROLE_LIST_STATUS.HAVE_GOTTED] = 4
	}

	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		local var_10_1 = {}

		for iter_10_2, iter_10_3 in pairs(activity_recruit_index_data) do
			if iter_10_3.servantid == iter_10_1.servantid then
				table.insert(var_10_1, iter_10_3)
			end
		end

		local var_10_2 = 0

		for iter_10_4, iter_10_5 in pairs(var_10_1) do
			if bit.band(iter_10_1.finish, var_0_6[iter_10_5.index]) ~= 0 then
				var_10_2 = var_10_2 + 1
			end
		end

		local var_10_3 = iter_10_1.state

		if iter_10_1.state ~= 4 and #var_10_1 == var_10_2 then
			var_10_3 = 3
		end

		local var_10_4 = {
			state = var_10_3,
			finish = iter_10_1.finish,
			servantid = iter_10_1.servantid
		}

		var_10_4.tasks = iter_10_1.list or {}
		var_10_4.complete_num = var_10_2
		var_10_4.total_num = #var_10_1
		var_10_4.stateIndex = var_10_0[var_10_3]
		self.recruitInfos[iter_10_1.servantid] = self.recruitInfos[iter_10_1.servantid] or var_10_4
		self.recruitRoles[#self.recruitRoles + 1] = iter_10_1.servantid
	end

	table.sort(self.recruitRoles, function(arg_11_0, arg_11_1)
		local var_11_0 = self.recruitInfos[arg_11_0].stateIndex
		local var_11_1 = self.recruitInfos[arg_11_1].stateIndex

		if self.recruitInfos[arg_11_0].stateIndex == self.recruitInfos[arg_11_1].stateIndex then
			return activity_recruit_servant_data[arg_11_0].sort < activity_recruit_servant_data[arg_11_1].sort
		else
			return var_11_0 < var_11_1
		end
	end)
end

function ACTIVITY_OBJ_NEW:get_recurit_roles()
	return self.recruitRoles or {}
end

function ACTIVITY_OBJ_NEW:get_recurit_data(arg_13_1)
	return self.recruitInfos[arg_13_1] or {}
end

function ACTIVITY_OBJ_NEW:get_recurit_tasks(arg_14_1)
	if not self.recruitInfos[arg_14_1] then
		return {}
	end

	local var_14_0 = self.recruitInfos[arg_14_1].tasks or {}
	local var_14_1 = self.recruitInfos[arg_14_1].finish or 0
	local var_14_2 = {}
	local activity_recruit_data = require("data.activity_recruit_data")

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		local var_14_4 = activity_recruit_data[iter_14_1.taskid]

		if not activity_recruit_data[iter_14_1.taskid] then
			print("miss task info with taskid: ", iter_14_1.taskid)
		else
			local var_14_5 = 1
			local var_14_6 = bit.band(var_14_1, var_0_6[iter_14_0])

			if var_14_6 == 0 and iter_14_1.percent == 100 then
				var_14_5 = 2
			elseif var_14_6 ~= 0 then
				var_14_5 = 3
			end

			iter_14_1.name = var_14_4.name
			iter_14_1.order = var_14_4.order
			iter_14_1.drop = var_14_4.drop
			iter_14_1.status = var_14_5
			iter_14_1.needs_type = var_14_4.needs_type
			iter_14_1.jump = var_14_4.jump
			iter_14_1.index = var_14_4.index
			var_14_2[#var_14_2 + 1] = iter_14_1
		end
	end

	table.sort(var_14_2, function(arg_15_0, arg_15_1)
		if arg_15_0.status == arg_15_1.status then
			return arg_15_0.order > arg_15_1.order
		else
			return arg_15_0.status > arg_15_1.status
		end
	end)

	return var_14_2
end
