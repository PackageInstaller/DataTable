local var_0_0 = class("IslandTask", import("model.vo.BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.acceptTime = arg_1_1.timestamp or 0

	arg_1_0:InitEndTime()
	arg_1_0:UpdateTargetData(arg_1_1.process_list)

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.island_task
end

function var_0_0.GetAcceptTime(arg_3_0)
	return arg_3_0.acceptTime
end

function var_0_0.InitEndTime(arg_4_0)
	local var_4_0 = arg_4_0:getConfig("unlock_time")

	arg_4_0.endTime = var_4_0 == "always" and 0 or pg.TimeMgr.GetInstance():parseTimeFromConfig(var_4_0[2])

	return
end

function var_0_0.SetEndTime(arg_5_0, arg_5_1)
	arg_5_0.endTime = arg_5_1

	return
end

function var_0_0.UpdateTargetData(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		({})[iter_6_1.target_id] = iter_6_1
	end

	arg_6_0.targetList = {}

	for iter_6_2, iter_6_3 in ipairs(arg_6_0:getConfig("target_id")) do
		local var_6_0 = ({})[iter_6_3]

		if not ({})[iter_6_3] then
			var_6_0 = {
				target_id = iter_6_3
			}
		end

		table.insert(arg_6_0.targetList, IslandTaskTarget.New(var_6_0))
	end

	return
end

function var_0_0.GetTargetList(arg_7_0)
	return arg_7_0.targetList
end

function var_0_0.GetTargetById(arg_8_0, arg_8_1)
	return underscore.detect(arg_8_0.targetList, function(arg_9_0)
		return arg_9_0.id == arg_8_1
	end)
end

function var_0_0.GetRecycleItemInfos(arg_10_0)
	local var_10_0 = {}

	underscore.each(arg_10_0.targetList, function(arg_11_0)
		if arg_11_0:GetType() == IslandTaskTargetType.RECYCLE then
			table.insert(var_10_0, Drop.New({
				type = DROP_TYPE_ISLAND_ITEM,
				id = arg_11_0:GetTargetId(),
				count = arg_11_0:GetTargetNum()
			}))
		end

		return
	end)

	return {}
end

function var_0_0.ExistTargetType(arg_12_0, arg_12_1)
	return underscore.any(arg_12_0.targetList, function(arg_13_0)
		return arg_13_0:GetType() == arg_12_1
	end)
end

function var_0_0.GetTargetIdByTypeAndParam(arg_14_0, arg_14_1, arg_14_2)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.targetList) do
		if iter_14_1:CheckTypeAndTargetId(arg_14_1, arg_14_2) and not table.contains({}, iter_14_1.id) then
			table.insert({}, iter_14_1.id)
		end
	end

	return {}
end

function var_0_0.GetRemainTimeStr(arg_15_0)
	local var_15_0 = arg_15_0.endTime - pg.TimeMgr.GetInstance():GetServerTime()

	return i18n("island_task_lefttime", math.floor(var_15_0 / 0), (math.floor(var_15_0 % 0 / 16)))
end

function var_0_0.IsFinish(arg_16_0)
	return underscore.all(arg_16_0.targetList, function(arg_17_0)
		return arg_17_0:IsFinish()
	end)
end

function var_0_0.IsSubmitOnUI(arg_18_0)
	return arg_18_0:getConfig("complete_type") == 3
end

function var_0_0.GetSubmitObjectId(arg_19_0)
	return arg_19_0:getConfig("complete_data")
end

function var_0_0.IsSubmitImmediately(arg_20_0)
	return arg_20_0:getConfig("complete_type") == 2 and arg_20_0:GetSubmitObjectId() == 0
end

function var_0_0.CheckSubmitOnApproach(arg_21_0, arg_21_1)
	return arg_21_0:GetSubmitObjectId() == arg_21_1 and arg_21_0:getConfig("complete_type") == 2
end

function var_0_0.GetFinishedDesc(arg_22_0)
	return arg_22_0:getConfig("complete_tips")
end

function var_0_0.InTime(arg_23_0)
	if arg_23_0.endTime == 0 then
		return true
	end

	local var_23_0 = pg.TimeMgr.GetInstance()

	return var_23_0:GetServerTime() < arg_23_0.endTime
end

function var_0_0.GetType(arg_24_0)
	return arg_24_0:getConfig("type")
end

function var_0_0.GetShowType(arg_25_0)
	return IslandTaskType.Type2ShowType[arg_25_0:getConfig("type")]
end

function var_0_0.GetName(arg_26_0)
	return arg_26_0:getConfig("name")
end

function var_0_0.GetDesc(arg_27_0)
	return arg_27_0:getConfig("task_desc")
end

function var_0_0.IsSeries(arg_28_0)
	return arg_28_0:getConfig("series") ~= ""
end

function var_0_0.GetSeriesTitle(arg_29_0)
	return arg_29_0:getConfig("series") .. " " .. arg_29_0:getConfig("series_name")
end

function var_0_0.GetAddedStory(arg_30_0)
	return arg_30_0:getConfig("rec_perform")
end

function var_0_0.GetSubmitStory(arg_31_0)
	return arg_31_0:getConfig("com_perform")
end

function var_0_0.GetTraceParam(arg_32_0)
	for iter_32_0, iter_32_1 in ipairs(arg_32_0.targetList) do
		if not iter_32_1:IsFinish() then
			return iter_32_1:GetTrackParma(), iter_32_0
		end
	end

	return arg_32_0:GetSubmitObjectId() ~= 0 and arg_32_0:GetSubmitObjectId() or ""
end

function var_0_0.GetAwards(arg_33_0)
	local var_33_0 = arg_33_0:getConfig("reward_show")
	local var_33_1 = {}

	if type(var_33_0) == "table" then
		var_33_1 = underscore.map(var_33_0, function(arg_34_0)
			return Drop.Create(arg_34_0)
		end)
	end

	if arg_33_0:GetExpAward() then
		table.insert(var_33_1, arg_33_0:GetExpAward())
	end

	return var_33_1
end

function var_0_0.GetExp(arg_35_0)
	return arg_35_0:getConfig("reward_exp")
end

function var_0_0.GetExpAward(arg_36_0)
	if arg_36_0:GetExp() ~= 0 then
		return {
			id = 2,
			type = DROP_TYPE_ISLAND_ITEM,
			count = arg_36_0:GetExp()
		}
	end

	return nil
end

function var_0_0.GetAwardsStatic(arg_37_0)
	local var_37_0 = {}

	if type(pg.island_task[arg_37_0].reward_show) == "table" then
		var_37_0 = underscore.map(pg.island_task[arg_37_0].reward_show, function(arg_38_0)
			return Drop.Create(arg_38_0)
		end)
	end

	if pg.island_task[arg_37_0].reward_exp ~= 0 then
		table.insert(var_37_0, {
			id = 2,
			type = DROP_TYPE_ISLAND_ITEM,
			count = pg.island_task[arg_37_0].reward_exp
		})
	end

	return var_37_0
end

function var_0_0.GetSubmitPlayInfo(arg_39_0)
	if pg.island_task[arg_39_0].com_perform == "" or #pg.island_task[arg_39_0].com_perform == 0 then
		return nil
	end

	return pg.island_task[arg_39_0].com_perform[1], pg.island_task[arg_39_0].com_perform[2]
end

function var_0_0.BuildFakeTask(arg_40_0)
	return var_0_0.New({
		id = arg_40_0,
		process_list = _.map(pg.island_task[arg_40_0].target_id, function(arg_41_0)
			return {
				target_id = arg_41_0,
				target_count = pg.island_task_target[arg_41_0].target_num
			}
		end)
	})
end

return var_0_0
