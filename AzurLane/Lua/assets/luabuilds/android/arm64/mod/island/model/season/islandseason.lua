local var_0_0 = class("IslandSeason", import("model.vo.BaseVO"))

var_0_0.RESET_TIP_KEY = "IslandSeason.RESET_TIP_KEY"

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.pt = arg_1_1.pt or 0
	arg_1_0.gotPtAwardList = arg_1_1.fetch_list or {}
	arg_1_0.records = {}

	local var_1_0 = arg_1_1.count_list or {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		arg_1_0.records[iter_1_1.key] = iter_1_1.value
	end

	arg_1_0.endTime = pg.TimeMgr.GetInstance():parseTimeFromConfig(arg_1_0:getConfig("time")[2])
	arg_1_0.localTipKey = var_0_0.RESET_TIP_KEY .. "_" .. getProxy(PlayerProxy):getRawData().id .. "_" .. arg_1_0.id

	return
end

function var_0_0.IsEnd(arg_2_0)
	local var_2_0 = pg.TimeMgr.GetInstance()

	return var_2_0:GetServerTime() >= arg_2_0.endTime
end

function var_0_0.bindConfigTable(arg_3_0)
	return pg.island_season
end

function var_0_0.GetTimeStr(arg_4_0)
	local var_4_0 = arg_4_0:getConfig("time")

	return string.format("%d.%d.%d - %d.%d.%d", var_4_0[1][1][1], var_4_0[1][1][2], var_4_0[1][1][3], var_4_0[2][1][1], var_4_0[2][1][2], var_4_0[2][1][3])
end

function var_0_0.GetRemainTime(arg_5_0)
	return arg_5_0.endTime - pg.TimeMgr.GetInstance():GetServerTime()
end

function var_0_0.NeedTip(arg_6_0)
	local var_6_0 = arg_6_0.endTime - pg.TimeMgr.GetInstance():GetServerTime()
	local var_6_1 = math.floor(var_6_0 / 0)

	if var_6_1 > 3 then
		return false
	end

	if PlayerPrefs.GetInt(arg_6_0.localTipKey .. "_" .. arg_6_0:GetTipStamp(var_6_1)) == 1 then
		return false
	end

	local var_6_4 = math.floor(var_6_0 / 16)
end

function var_0_0.SetTipFlag(arg_7_0, arg_7_1)
	PlayerPrefs.SetInt(arg_7_0.localTipKey .. "_" .. arg_7_0:GetTipStamp(arg_7_1), 1)

	return
end

function var_0_0.GetTipStamp(arg_8_0, arg_8_1)
	return arg_8_1 .. "_" .. arg_8_0.endTime - arg_8_1 * 0
end

function var_0_0.AddPt(arg_9_0, arg_9_1)
	if arg_9_0.pt == 0 then
		IslandAchievementHelper.UpdateRecordWithAdd(IslandAchievementType.SEASON_NUM, 0, 1)
	end

	arg_9_0.pt = arg_9_0.pt + arg_9_1

	return
end

function var_0_0.GetPt(arg_10_0)
	return arg_10_0.pt
end

function var_0_0.GetGotPtAwardList(arg_11_0)
	return arg_11_0.gotPtAwardList
end

function var_0_0.AddGotPtAwardList(arg_12_0, arg_12_1)
	if arg_12_1 == 0 then
		for iter_12_0, iter_12_1 in ipairs(arg_12_0:getConfig("target")) do
			if iter_12_1 <= arg_12_0.pt and not table.contains(arg_12_0.gotPtAwardList, iter_12_1) then
				table.insert(arg_12_0.gotPtAwardList, iter_12_1)
			end
		end
	else
		table.insert(arg_12_0.gotPtAwardList, arg_12_1)
	end

	return
end

function var_0_0.GanGetPtAward(arg_13_0)
	return underscore.any(arg_13_0:getConfig("target"), function(arg_14_0)
		return arg_14_0 <= arg_13_0.pt and not table.contains(arg_13_0.gotPtAwardList, arg_14_0)
	end)
end

function var_0_0.GetTaskIds(arg_15_0)
	return arg_15_0:getConfig("task_list")
end

function var_0_0.GetAwardsByRank(arg_16_0, arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(pg.island_season[arg_16_0].rank) do
		if arg_16_1 >= iter_16_1[1] and arg_16_1 <= iter_16_1[2] then
			return underscore.map(pg.island_season[arg_16_0].rankaward_display[iter_16_0], function(arg_17_0)
				return Drop.Create(arg_17_0)
			end)
		end
	end

	return {}
end

function var_0_0.GetPtAwardInfos(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(pg.island_season[arg_18_0].target) do
		table.insert({}, {
			target = iter_18_1,
			drop = Drop.Create(pg.island_season[arg_18_0].ptaward_display[iter_18_0]),
			isImportant = table.contains(pg.island_season[arg_18_0].ptaward_highvalue, iter_18_0)
		})
	end

	return {}
end

return var_0_0
