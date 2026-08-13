class = var_0_10000

local var_0_0 = "StageProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NetProxy"))

var_0_1.STAGE_ADDED = "stage added"
var_0_1.STAGE_UPDATED = "stage updated"
var_0_1.RANDOM_STAGE_DELETE = "random stage deleted"
var_0_1.RANDOM_STAGE_ADDED = "stage added"

function var_0_1.register(arg_1_0)
	arg_1_0:on(13001, function(arg_2_0)
		local var_2_0 = arg_1_0.data

		var_2_0.satges = {}
		ipairs = var_2_0

		for iter_2_0, iter_2_1 in var_2_0(arg_2_0.expedition_list) do
			Stage = var_2_10006

			local var_2_1 = var_2_10006.New(iter_2_1)

			var_2_10006.display(var_2_1, "loaded")

			arg_1_0.data.satges[var_2_10006.id] = var_2_10006
		end

		return
	end)
	arg_1_0:on(13100, function(arg_3_0)
		local var_3_0 = arg_1_0.data

		var_3_0.randomexpeditions = {}
		ipairs = var_3_0

		for iter_3_0, iter_3_1 in var_3_0(arg_3_0.random_expedition_list) do
			Stage = var_2_10006

			local var_3_1 = var_2_10006.New(iter_3_1)

			var_2_10006.display(var_3_1, "loaded")

			if not arg_1_0.data.randomexpeditions[var_2_10006.id] then
				print = var_7

				var_7("随机关卡添加" .. var_2_10006.id)

				local var_3_2 = arg_1_0

				var_7.addRandomStage(var_3_2, var_2_10006)
			else
				arg_1_0.data.randomexpeditions[var_2_10006.id] = var_2_10006
			end
		end

		return
	end)
	arg_1_0:listenerRandomStage()

	return
end

function var_0_1.remove(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.TimeMgr.GetInstance()

	var_1.RemoveTimer(var_4_0, arg_4_0.timerId)

	arg_4_0.timerId = nil

	return
end

function var_0_1.addStage(arg_5_0, arg_5_1)
	assert = var_1_10002
	isa = var_1_10004

	local var_5_0 = arg_5_1

	Stage = var_1_10007

	var_1_10002(var_1_10004(var_5_0, var_1_10007), "should be an instance of Stage")

	assert = var_1_10002

	var_1_10002(arg_5_0.data.satges[arg_5_1.id] == nil, "ship already exist, use updateStage() instead")

	arg_5_0.data.satges[arg_5_1.id] = arg_5_1:clone()

	local var_5_1 = arg_5_0.data.satges[arg_5_1.id]

	var_2.display(var_5_1, "added")

	local var_5_2 = arg_5_0.facade

	var_2.sendNotification(var_5_2, var_0_1.STAGE_ADDED, arg_5_1:clone())

	return
end

function var_0_1.getStageById(arg_6_0, arg_6_1)
	if arg_6_0.data.satges[arg_6_1] ~= nil then
		local var_6_0 = arg_6_0.data.satges[arg_6_1]

		return var_2.clone(var_6_0)
	end

	return
end

function var_0_1.updateStage(arg_7_0, arg_7_1)
	assert = var_1_10002
	isa = var_1_10004

	local var_7_0 = arg_7_1

	Stage = var_1_10007

	var_1_10002(var_1_10004(var_7_0, var_1_10007), "should be an instance of Stage")

	arg_7_0.data.satges[arg_7_1.id] = arg_7_1:clone()

	local var_7_1 = arg_7_0.data.satges[arg_7_1.id]

	var_2.display(var_7_1, "updated")

	local var_7_2 = arg_7_0.facade

	var_2.sendNotification(var_7_2, var_0_1.STAGE_UPDATED, arg_7_1:clone())

	return
end

function var_0_1.getRandomStages(arg_8_0)
	Clone = var_1_10001

	local var_8_0

	if not var_1_10001(arg_8_0.data.randomexpeditions) then
		var_8_0 = {}
	end

	return var_8_0
end

function var_0_1.addRandomStage(arg_9_0, arg_9_1)
	assert = var_1_10002
	isa = var_1_10004

	local var_9_0 = arg_9_1

	Stage = var_1_10007

	var_1_10002(var_1_10004(var_9_0, var_1_10007), "should be an instance of Stage")

	assert = var_1_10002

	var_1_10002(arg_9_0.data.randomexpeditions[arg_9_1.id] == nil, "ship already exist, use updateStage() instead")

	arg_9_0.data.randomexpeditions[arg_9_1.id] = arg_9_1

	local var_9_1 = arg_9_0.facade

	var_2.sendNotification(var_9_1, var_0_1.RANDOM_STAGE_ADDED, arg_9_1:clone())

	return
end

function var_0_1.listenerRandomStage(arg_10_0)
	pg = var_1_10001

	local var_10_0 = var_1_10001.TimeMgr.GetInstance()

	arg_10_0.timerId = var_1.AddTimer(var_10_0, "listenerRandomStage", 0, 1, function()
		if arg_10_0.data.randomexpeditions then
			table = var_0

			local var_11_0 = var_0.getCount(arg_10_0.data.randomexpeditions)

			if 0 < var_11_0 then
				pg = var_11_0

				local var_11_1 = var_11_0.TimeMgr.GetInstance()
				local var_11_2 = var_0.GetServerTime(var_11_1)

				pairs = var_1

				for iter_11_0, iter_11_1 in var_1(arg_10_0.data.randomexpeditions) do
					if iter_11_1.out_time == var_11_2 then
						local var_11_3 = arg_10_0

						var_6.removeRandomStageById(var_11_3, iter_11_1.id)
					end
				end
			end
		end

		return
	end)

	return
end

function var_0_1.removeRandomStageById(arg_12_0, arg_12_1)
	assert = var_1_10002

	var_1_10002(arg_12_0.data.randomexpeditions[arg_12_1], "不存在随机卡关" .. arg_12_1)

	arg_12_0.data.randomexpeditions[arg_12_1] = nil

	local var_12_0 = arg_12_0.facade

	var_2.sendNotification(var_12_0, var_0_1.RANDOM_STAGE_DELETE, arg_12_1)

	return
end

return var_0_1
