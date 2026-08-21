local var_0_0 = class("StageProxy", import(".NetProxy"))

var_0_0.STAGE_ADDED = "stage added"
var_0_0.STAGE_UPDATED = "stage updated"
var_0_0.RANDOM_STAGE_DELETE = "random stage deleted"
var_0_0.RANDOM_STAGE_ADDED = "stage added"

function var_0_0.register(arg_1_0)
	arg_1_0:on(13001, function(arg_2_0)
		arg_1_0.data.satges = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.expedition_list) do
			local var_2_0 = Stage.New(iter_2_1)

			var_2_0:display("loaded")

			arg_1_0.data.satges[var_2_0.id] = var_2_0
		end

		return
	end)
	arg_1_0:on(13100, function(arg_3_0)
		arg_1_0.data.randomexpeditions = {}

		for iter_3_0, iter_3_1 in ipairs(arg_3_0.random_expedition_list) do
			local var_3_0 = Stage.New(iter_3_1)

			var_3_0:display("loaded")

			if not arg_1_0.data.randomexpeditions[var_3_0.id] then
				print("随机关卡添加" .. var_3_0.id)
				arg_1_0:addRandomStage(var_3_0)
			else
				arg_1_0.data.randomexpeditions[var_3_0.id] = var_3_0
			end
		end

		return
	end)
	arg_1_0:listenerRandomStage()

	return
end

function var_0_0.remove(arg_4_0)
	pg.TimeMgr.GetInstance():RemoveTimer(arg_4_0.timerId)

	arg_4_0.timerId = nil

	return
end

function var_0_0.addStage(arg_5_0, arg_5_1)
	assert(isa(arg_5_1, Stage), "should be an instance of Stage")
	assert(arg_5_0.data.satges[arg_5_1.id] == nil, "ship already exist, use updateStage() instead")

	arg_5_0.data.satges[arg_5_1.id] = arg_5_1:clone()

	arg_5_0.data.satges[arg_5_1.id]:display("added")
	arg_5_0.facade:sendNotification(var_0_0.STAGE_ADDED, arg_5_1:clone())

	return
end

function var_0_0.getStageById(arg_6_0, arg_6_1)
	if arg_6_0.data.satges[arg_6_1] ~= nil then
		return arg_6_0.data.satges[arg_6_1]:clone()
	end

	return
end

function var_0_0.updateStage(arg_7_0, arg_7_1)
	assert(isa(arg_7_1, Stage), "should be an instance of Stage")

	arg_7_0.data.satges[arg_7_1.id] = arg_7_1:clone()

	arg_7_0.data.satges[arg_7_1.id]:display("updated")
	arg_7_0.facade:sendNotification(var_0_0.STAGE_UPDATED, arg_7_1:clone())

	return
end

function var_0_0.getRandomStages(arg_8_0)
	return Clone(arg_8_0.data.randomexpeditions) or {}
end

function var_0_0.addRandomStage(arg_9_0, arg_9_1)
	assert(isa(arg_9_1, Stage), "should be an instance of Stage")
	assert(arg_9_0.data.randomexpeditions[arg_9_1.id] == nil, "ship already exist, use updateStage() instead")

	arg_9_0.data.randomexpeditions[arg_9_1.id] = arg_9_1

	arg_9_0.facade:sendNotification(var_0_0.RANDOM_STAGE_ADDED, arg_9_1:clone())

	return
end

function var_0_0.listenerRandomStage(arg_10_0)
	arg_10_0.timerId = pg.TimeMgr.GetInstance():AddTimer("listenerRandomStage", 0, 1, function()
		if arg_10_0.data.randomexpeditions and table.getCount(arg_10_0.data.randomexpeditions) > 0 then
			local var_11_0 = pg.TimeMgr.GetInstance():GetServerTime()

			for iter_11_0, iter_11_1 in pairs(arg_10_0.data.randomexpeditions) do
				if iter_11_1.out_time == var_11_0 then
					arg_10_0:removeRandomStageById(iter_11_1.id)
				end
			end
		end

		return
	end)

	return
end

function var_0_0.removeRandomStageById(arg_12_0, arg_12_1)
	assert(arg_12_0.data.randomexpeditions[arg_12_1], "不存在随机卡关" .. arg_12_1)

	arg_12_0.data.randomexpeditions[arg_12_1] = nil

	arg_12_0.facade:sendNotification(var_0_0.RANDOM_STAGE_DELETE, arg_12_1)

	return
end

return var_0_0
