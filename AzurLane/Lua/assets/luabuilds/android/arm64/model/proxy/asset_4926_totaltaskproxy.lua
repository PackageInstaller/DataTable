class = var_0_10000

local var_0_0 = "TotalTaskProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NetProxy"))

var_0_1.act_task_onece_type = {
	6,
	26
}

local var_0_2 = {}

ActivityConst = var_0_0
var_0_2[1] = var_0_0.ACTIVITY_TYPE_PT_OTHER
var_0_1.avatar_task_type = var_0_2

local var_0_3 = {}

ActivityConst = var_2
var_0_3[1] = var_2.ACTIVITY_TYPE_TASK_RYZA
ActivityConst = var_2
var_0_3[2] = var_2.ACTIVITY_TYPE_HOTSPRING_2
ActivityConst = var_2
var_0_3[3] = var_2.ACTIVITY_TYPE_NOT_TRACEABLE
var_0_1.activity_task_type = var_0_3

local var_0_4 = {}

ActivityConst = var_2
var_0_4[1] = var_2.ACTIVITY_TYPE_TASKS
ActivityConst = var_2
var_0_4[2] = var_2.ACTIVITY_TYPE_PT_CRUSING
ActivityConst = var_2
var_0_4[3] = var_2.ACTIVITY_TYPE_PT_HEI5
ActivityConst = var_2
var_0_4[4] = var_2.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB
var_0_1.normal_task_type = var_0_4

function var_0_1.register(arg_1_0)
	arg_1_0.avatarFrames = {}
	arg_1_0.actTasks = {}

	arg_1_0:on(20201, function(arg_2_0)
		getProxy = var_2_10001
		AvatarFrameProxy = var_2_10003

		local var_2_0 = var_2_10001(var_2_10003)

		var_1.clearData(var_2_0)

		getProxy = var_1
		ActivityTaskProxy = var_2_0

		local var_2_1 = var_1(var_2_0)

		var_1.clearData(var_2_1)

		ipairs = var_1

		for iter_2_0, iter_2_1 in var_1(arg_2_0.info) do
			local var_2_2 = iter_2_1.act_id
			local var_2_3 = iter_2_1.tasks
			local var_2_4 = iter_2_1.finish_ids

			pg = var_2_10009
			var_2_10009 = var_2_10009.activity_template[var_2_2].type
			table = var_2_10010
			var_2_10010 = var_2_10010.contains
			TotalTaskProxy = var_2_10012

			if var_2_10010(var_2_10012.avatar_task_type, var_2_10009) then
				getProxy = var_2_10010
				AvatarFrameProxy = var_2_10012
				var_2_10012 = var_2_10010(var_2_10012)

				var_2_10010.initListData(var_2_10012, var_2_2, var_2_3, var_2_4)
			else
				table = var_2_10010
				var_2_10010 = var_2_10010.contains
				TotalTaskProxy = var_2_10012

				if var_2_10010(var_2_10012.activity_task_type, var_2_10009) then
					getProxy = var_2_10010
					ActivityTaskProxy = var_2_10012
					var_2_10012 = var_2_10010(var_2_10012)

					var_2_10010.initActList(var_2_10012, var_2_2, var_2_3, var_2_4)
				else
					table = var_2_10010
					var_2_10010 = var_2_10010.contains
					TotalTaskProxy = var_2_10012

					if var_2_10010(var_2_10012.normal_task_type, var_2_10009) then
						getProxy = var_2_10010
						TaskProxy = var_2_10012
						var_2_10012 = var_2_10010(var_2_10012)

						var_2_10010.initActData(var_2_10012, var_2_2, var_2_3, var_2_4)
					end
				end
			end
		end

		return
	end)
	arg_1_0:on(20202, function(arg_3_0)
		ipairs = var_2_10001

		for iter_3_0, iter_3_1 in var_2_10001(arg_3_0.info) do
			local var_3_0 = iter_3_1.act_id
			local var_3_1 = iter_3_1.tasks

			pg = var_2_10008
			var_2_10008 = var_2_10008.activity_template[var_3_0].type
			table = var_2_10009
			var_2_10009 = var_2_10009.contains
			TotalTaskProxy = var_2_10011

			if var_2_10009(var_2_10011.avatar_task_type, var_2_10008) then
				getProxy = var_2_10009
				AvatarFrameProxy = var_2_10011
				var_2_10011 = var_2_10009(var_2_10011)

				var_2_10009.update(var_2_10011, var_3_0, var_3_1)
			else
				table = var_2_10009
				var_2_10009 = var_2_10009.contains
				TotalTaskProxy = var_2_10011

				if var_2_10009(var_2_10011.activity_task_type, var_2_10008) then
					getProxy = var_2_10009
					ActivityTaskProxy = var_2_10011
					var_2_10011 = var_2_10009(var_2_10011)

					var_2_10009.updateActList(var_2_10011, var_3_0, var_3_1)
				else
					table = var_2_10009
					var_2_10009 = var_2_10009.contains
					TotalTaskProxy = var_2_10011

					if var_2_10009(var_2_10011.normal_task_type, var_2_10008) then
						getProxy = var_2_10009
						TaskProxy = var_2_10011
						var_2_10011 = var_2_10009(var_2_10011)

						var_2_10009.updateActProgress(var_2_10011, var_3_0, var_3_1)
					end
				end
			end

			getProxy = var_2_10009
			ActivityProxy = var_2_10011
			var_2_10011 = var_2_10009(var_2_10011)
			var_2_10009 = var_2_10009.getActivityById(var_2_10011, var_3_0)

			local var_3_2 = arg_1_0
			local var_3_3 = var_10.sendNotification

			ActivityProxy = var_2_10013

			var_3_3(var_3_2, var_2_10013.ACTIVITY_UPDATED, var_2_10009:clone())
		end

		local var_3_4 = arg_1_0.facade
		local var_3_5 = var_1.sendNotification

		GAME = iter_3_0

		var_3_5(var_3_4, iter_3_0.TOTAL_TASK_UPDATED)

		return
	end)
	arg_1_0:on(20203, function(arg_4_0)
		ipairs = var_2_10001

		for iter_4_0, iter_4_1 in var_2_10001(arg_4_0.info) do
			local var_4_0 = iter_4_1.act_id
			local var_4_1 = iter_4_1.tasks

			pg = var_2_10008
			var_2_10008 = var_2_10008.activity_template[var_4_0].type
			table = var_2_10009
			var_2_10009 = var_2_10009.contains
			TotalTaskProxy = var_2_10011

			if var_2_10009(var_2_10011.avatar_task_type, var_2_10008) then
				getProxy = var_2_10009
				AvatarFrameProxy = var_2_10011
				var_2_10011 = var_2_10009(var_2_10011)

				var_2_10009.addData(var_2_10011, var_4_0, var_4_1)
			else
				table = var_2_10009
				var_2_10009 = var_2_10009.contains
				TotalTaskProxy = var_2_10011

				if var_2_10009(var_2_10011.activity_task_type, var_2_10008) then
					getProxy = var_2_10009
					ActivityTaskProxy = var_2_10011
					var_2_10011 = var_2_10009(var_2_10011)

					var_2_10009.addActList(var_2_10011, var_4_0, var_4_1)
				else
					table = var_2_10009
					var_2_10009 = var_2_10009.contains
					TotalTaskProxy = var_2_10011

					if var_2_10009(var_2_10011.normal_task_type, var_2_10008) then
						getProxy = var_2_10009
						TaskProxy = var_2_10011
						var_2_10011 = var_2_10009(var_2_10011)

						var_2_10009.addActData(var_2_10011, var_4_0, var_4_1)
					end
				end
			end

			getProxy = var_2_10009
			ActivityProxy = var_2_10011
			var_2_10011 = var_2_10009(var_2_10011)
			var_2_10009 = var_2_10009.getActivityById(var_2_10011, var_4_0)

			local var_4_2 = arg_1_0
			local var_4_3 = var_10.sendNotification

			ActivityProxy = var_2_10013

			var_4_3(var_4_2, var_2_10013.ACTIVITY_UPDATED, var_2_10009:clone())
		end

		local var_4_4 = arg_1_0.facade
		local var_4_5 = var_1.sendNotification

		GAME = iter_4_0

		var_4_5(var_4_4, iter_4_0.TOTAL_TASK_UPDATED)

		return
	end)
	arg_1_0:on(20204, function(arg_5_0)
		ipairs = var_2_10001

		for iter_5_0, iter_5_1 in var_2_10001(arg_5_0.info) do
			local var_5_0 = iter_5_1.act_id
			local var_5_1 = iter_5_1.tasks

			pg = var_2_10008
			var_2_10008 = var_2_10008.activity_template[var_5_0].type
			table = var_2_10009
			var_2_10009 = var_2_10009.contains
			TotalTaskProxy = var_2_10011

			if var_2_10009(var_2_10011.avatar_task_type, var_2_10008) then
				getProxy = var_2_10009
				AvatarFrameProxy = var_2_10011
				var_2_10011 = var_2_10009(var_2_10011)

				var_2_10009.removeData(var_2_10011, var_5_0, var_5_1)
			else
				table = var_2_10009
				var_2_10009 = var_2_10009.contains
				TotalTaskProxy = var_2_10011

				if var_2_10009(var_2_10011.activity_task_type, var_2_10008) then
					getProxy = var_2_10009
					ActivityTaskProxy = var_2_10011
					var_2_10011 = var_2_10009(var_2_10011)

					var_2_10009.removeActList(var_2_10011, var_5_0, var_5_1)
				else
					table = var_2_10009
					var_2_10009 = var_2_10009.contains
					TotalTaskProxy = var_2_10011

					if var_2_10009(var_2_10011.normal_task_type, var_2_10008) then
						getProxy = var_2_10009
						TaskProxy = var_2_10011
						var_2_10011 = var_2_10009(var_2_10011)

						var_2_10009.removeActData(var_2_10011, var_5_0, var_5_1)
					end
				end
			end

			getProxy = var_2_10009
			ActivityProxy = var_2_10011
			var_2_10011 = var_2_10009(var_2_10011)
			var_2_10009 = var_2_10009.getActivityById(var_2_10011, var_5_0)

			local var_5_2 = arg_1_0
			local var_5_3 = var_10.sendNotification

			ActivityProxy = var_2_10013

			var_5_3(var_5_2, var_2_10013.ACTIVITY_UPDATED, var_2_10009:clone())
		end

		local var_5_4 = arg_1_0.facade
		local var_5_5 = var_1.sendNotification

		GAME = iter_5_0

		var_5_5(var_5_4, iter_5_0.TOTAL_TASK_UPDATED)

		return
	end)

	return
end

function var_0_1.timeCall(arg_6_0)
	local var_6_0 = {}

	ProxyRegister = var_1_10002
	var_6_0[var_1_10002.DayCall] = function(arg_7_0)
		local var_7_0 = arg_6_0

		var_1.clearTimeOut(var_7_0)

		return
	end

	return var_6_0
end

function var_0_1.clearTimeOut(arg_8_0)
	getProxy = var_1_10001
	AvatarFrameProxy = var_1_10003

	local var_8_0 = var_1_10001(var_1_10003)

	var_1.clearTimeOut(var_8_0)

	getProxy = var_1
	TaskProxy = var_8_0

	local var_8_1 = var_1(var_8_0)

	var_1.clearTimeOut(var_8_1)

	return
end

return var_0_1
