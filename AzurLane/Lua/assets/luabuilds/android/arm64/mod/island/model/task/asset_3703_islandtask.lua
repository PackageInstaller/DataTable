class = var_0_10000

local var_0_0 = "IslandTask"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id

	local var_1_0

	if not arg_1_1.timestamp then
		var_1_0 = 0
	end

	arg_1_0.acceptTime = var_1_0

	arg_1_0:InitEndTime()
	arg_1_0:UpdateTargetData(arg_1_1.process_list)

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.island_task
end

function var_0_1.GetAcceptTime(arg_3_0)
	return arg_3_0.acceptTime
end

function var_0_1.InitEndTime(arg_4_0)
	if arg_4_0:getConfig("unlock_time") == "always" then
		arg_4_0.endTime = 0
	else
		pg = var_1_10002

		local var_4_0 = var_1_10002.TimeMgr.GetInstance()

		arg_4_0.endTime = var_2.parseTimeFromConfig(var_4_0, var_1[2])
	end

	return
end

function var_0_1.SetEndTime(arg_5_0, arg_5_1)
	arg_5_0.endTime = arg_5_1

	return
end

function var_0_1.UpdateTargetData(arg_6_0, arg_6_1)
	local var_6_0 = {}

	ipairs = var_1_10003

	for iter_6_0, iter_6_1 in var_1_10003(arg_6_1) do
		var_6_0[iter_6_1.target_id] = iter_6_1
	end

	arg_6_0.targetList = {}
	ipairs = var_3

	for iter_6_2, iter_6_3 in var_3(arg_6_0:getConfig("target_id")) do
		table = var_6_1

		local var_6_1 = var_6_1.insert
		local var_6_2 = arg_6_0.targetList

		IslandTaskTarget = var_1_10011
		var_1_10011 = var_1_10011.New

		local var_6_3

		if not var_6_0[iter_6_3] then
			var_6_3 = {
				target_id = iter_6_3
			}
		end

		var_6_1(var_6_2, var_1_10011(var_6_3))
	end

	return
end

function var_0_1.GetTargetList(arg_7_0)
	return arg_7_0.targetList
end

function var_0_1.GetTargetById(arg_8_0, arg_8_1)
	underscore = var_1_10002

	return var_1_10002.detect(arg_8_0.targetList, function(arg_9_0)
		return arg_9_0.id == arg_8_1
	end)
end

function var_0_1.GetRecycleItemInfos(arg_10_0)
	local var_10_0 = {}

	underscore = var_1_10002

	var_1_10002.each(arg_10_0.targetList, function(arg_11_0)
		local var_11_0 = arg_11_0:GetType()

		IslandTaskTargetType = var_2_10002

		if var_11_0 == var_2_10002.RECYCLE then
			table = var_11_0

			local var_11_1 = var_11_0.insert
			local var_11_2 = var_10_0

			Drop = var_2_10004

			local var_11_3 = var_2_10004.New
			local var_11_4 = {}

			DROP_TYPE_ISLAND_ITEM = var_2_10007
			var_11_4.type = var_2_10007
			var_11_4.id = arg_11_0:GetTargetId()
			var_11_4.count = arg_11_0:GetTargetNum()

			var_11_1(var_11_2, var_11_3(var_11_4))
		end

		return
	end)

	return var_10_0
end

function var_0_1.ExistTargetType(arg_12_0, arg_12_1)
	underscore = var_1_10002

	return var_1_10002.any(arg_12_0.targetList, function(arg_13_0)
		return arg_13_0:GetType() == arg_12_1
	end)
end

function var_0_1.GetTargetIdByTypeAndParam(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = {}

	ipairs = var_1_10004

	for iter_14_0, iter_14_1 in var_1_10004(arg_14_0.targetList) do
		if iter_14_1:CheckTypeAndTargetId(arg_14_1, arg_14_2) then
			table = var_9

			if not var_9.contains(var_14_0, iter_14_1.id) then
				table = var_9

				var_9.insert(var_14_0, iter_14_1.id)
			end
		end
	end

	return var_14_0
end

function var_0_1.GetRemainTimeStr(arg_15_0)
	local var_15_0 = arg_15_0.endTime

	pg = var_1_10002

	local var_15_1 = var_1_10002.TimeMgr.GetInstance()
	local var_15_2 = var_15_0 - var_2.GetServerTime(var_15_1)

	math = var_2

	local var_15_3 = var_2.floor(var_15_2 / 0)

	math = var_1_10003

	local var_15_4 = var_1_10003.floor(var_15_2 % 0 / 16)

	i18n = var_4

	return var_4("island_task_lefttime", var_15_3, var_15_4)
end

function var_0_1.IsFinish(arg_16_0)
	underscore = var_1_10001

	return var_1_10001.all(arg_16_0.targetList, function(arg_17_0)
		return arg_17_0:IsFinish()
	end)
end

function var_0_1.IsSubmitOnUI(arg_18_0)
	return arg_18_0:getConfig("complete_type") == 3
end

function var_0_1.GetSubmitObjectId(arg_19_0)
	return arg_19_0:getConfig("complete_data")
end

function var_0_1.IsSubmitImmediately(arg_20_0)
	return arg_20_0:getConfig("complete_type") == 2 and arg_20_0:GetSubmitObjectId() == 0
end

function var_0_1.CheckSubmitOnApproach(arg_21_0, arg_21_1)
	return arg_21_0:GetSubmitObjectId() == arg_21_1 and arg_21_0:getConfig("complete_type") == 2
end

function var_0_1.GetFinishedDesc(arg_22_0)
	return arg_22_0:getConfig("complete_tips")
end

function var_0_1.InTime(arg_23_0)
	if arg_23_0.endTime == 0 then
		return true
	end

	pg = var_1

	local var_23_0 = var_1.TimeMgr.GetInstance()

	return var_1.GetServerTime(var_23_0) < arg_23_0.endTime
end

function var_0_1.GetType(arg_24_0)
	return arg_24_0:getConfig("type")
end

function var_0_1.GetShowType(arg_25_0)
	IslandTaskType = var_1_10001

	return var_1_10001.Type2ShowType[arg_25_0:getConfig("type")]
end

function var_0_1.GetName(arg_26_0)
	return arg_26_0:getConfig("name")
end

function var_0_1.GetDesc(arg_27_0)
	return arg_27_0:getConfig("task_desc")
end

function var_0_1.IsSeries(arg_28_0)
	return arg_28_0:getConfig("series") ~= ""
end

function var_0_1.GetSeriesTitle(arg_29_0)
	return arg_29_0:getConfig("series") .. " " .. arg_29_0:getConfig("series_name")
end

function var_0_1.GetAddedStory(arg_30_0)
	return arg_30_0:getConfig("rec_perform")
end

function var_0_1.GetSubmitStory(arg_31_0)
	return arg_31_0:getConfig("com_perform")
end

function var_0_1.GetTraceParam(arg_32_0)
	ipairs = var_1_10001

	for iter_32_0, iter_32_1 in var_1_10001(arg_32_0.targetList) do
		if not iter_32_1:IsFinish() then
			return iter_32_1:GetTrackParma(), iter_32_0
		end
	end

	local var_32_0

	if arg_32_0:GetSubmitObjectId() == 0 or not arg_32_0:GetSubmitObjectId() then
		var_32_0 = ""
	end

	return var_32_0
end

function var_0_1.GetAwards(arg_33_0)
	local var_33_0 = arg_33_0
	local var_33_1 = arg_33_0.getConfig(var_33_0, "reward_show")
	local var_33_2 = {}

	type = var_33_0

	if var_33_0(var_33_1) == "table" then
		underscore = var_3
		var_33_2 = var_3.map(var_33_1, function(arg_34_0)
			Drop = var_2_10001

			return var_2_10001.Create(arg_34_0)
		end)
	end

	if arg_33_0:GetExpAward() then
		table = var_3

		var_3.insert(var_33_2, arg_33_0:GetExpAward())
	end

	return var_33_2
end

function var_0_1.GetExp(arg_35_0)
	return arg_35_0:getConfig("reward_exp")
end

function var_0_1.GetExpAward(arg_36_0)
	if arg_36_0:GetExp() ~= 0 then
		local var_36_0 = {
			id = 2
		}

		DROP_TYPE_ISLAND_ITEM = var_1_10002
		var_36_0.type = var_1_10002
		var_36_0.count = arg_36_0:GetExp()

		return var_36_0
	end

	return nil
end

function var_0_1.GetAwardsStatic(arg_37_0)
	pg = var_1_10001

	local var_37_0 = var_1_10001.island_task[arg_37_0].reward_show

	pg = var_1_10002

	local var_37_1 = var_1_10002.island_task[arg_37_0].reward_exp
	local var_37_2 = {}

	type = var_1_10004

	local var_37_3

	if var_1_10004(var_37_0) == "table" then
		underscore = var_37_3
		var_37_3 = var_37_3.map
		pg = var_6
		var_37_2 = var_37_3(var_6.island_task[arg_37_0].reward_show, function(arg_38_0)
			Drop = var_2_10001

			return var_2_10001.Create(arg_38_0)
		end)
	end

	if var_37_1 ~= 0 then
		table = var_37_3

		local var_37_4 = var_37_3.insert
		local var_37_5 = var_37_2
		local var_37_6 = {
			id = 2
		}

		DROP_TYPE_ISLAND_ITEM = var_1_10008
		var_37_6.type = var_1_10008
		var_37_6.count = var_37_1

		var_37_4(var_37_5, var_37_6)
	end

	return var_37_2
end

function var_0_1.GetSubmitPlayInfo(arg_39_0)
	pg = var_1_10001

	if var_1_10001.island_task[arg_39_0].com_perform == "" or #var_1 == 0 then
		return nil
	end

	return var_1[1], var_1[2]
end

function var_0_1.BuildFakeTask(arg_40_0)
	_ = var_1_10001

	local var_40_0 = var_1_10001.map

	pg = var_1_10003

	local var_40_1 = var_40_0(var_1_10003.island_task[arg_40_0].target_id, function(arg_41_0)
		local var_41_0 = {
			target_id = arg_41_0
		}

		pg = var_2_10002
		var_41_0.target_count = var_2_10002.island_task_target[arg_41_0].target_num

		return var_41_0
	end)

	return var_0_1.New({
		id = arg_40_0,
		process_list = var_40_1
	})
end

return var_0_1
