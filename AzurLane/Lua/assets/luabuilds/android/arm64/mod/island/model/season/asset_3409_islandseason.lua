class = var_0_10000

local var_0_0 = "IslandSeason"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

var_0_1.RESET_TIP_KEY = "IslandSeason.RESET_TIP_KEY"

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id

	local var_1_0

	if not arg_1_1.pt then
		var_1_0 = 0
	end

	arg_1_0.pt = var_1_0

	local var_1_1

	if not arg_1_1.fetch_list then
		var_1_1 = {}
	end

	arg_1_0.gotPtAwardList = var_1_1
	arg_1_0.records = {}
	ipairs = var_2

	local var_1_2

	if not arg_1_1.count_list then
		var_1_2 = {}
	end

	for iter_1_0, iter_1_1 in var_2(var_1_2) do
		arg_1_0.records[iter_1_1.key] = iter_1_1.value
	end

	pg = var_2

	local var_1_3 = var_2.TimeMgr.GetInstance()

	arg_1_0.endTime = var_2.parseTimeFromConfig(var_1_3, arg_1_0:getConfig("time")[2])

	local var_1_4 = var_0_1.RESET_TIP_KEY
	local var_1_5 = "_"

	getProxy = var_1_3
	PlayerProxy = iter_1_1

	local var_1_6 = var_1_3(iter_1_1)

	arg_1_0.localTipKey = var_1_4 .. var_1_5 .. var_4.getRawData(var_1_6).id .. "_" .. arg_1_0.id

	return
end

function var_0_1.IsEnd(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.TimeMgr.GetInstance()

	return var_1.GetServerTime(var_2_0) >= arg_2_0.endTime
end

function var_0_1.bindConfigTable(arg_3_0)
	pg = var_1_10001

	return var_1_10001.island_season
end

function var_0_1.GetTimeStr(arg_4_0)
	local var_4_0 = arg_4_0:getConfig("time")[1][1]
	local var_4_1 = var_1[2][1]

	string = var_4

	return var_4.format("%d.%d.%d - %d.%d.%d", var_4_0[1], var_4_0[2], var_4_0[3], var_4_1[1], var_4_1[2], var_4_1[3])
end

function var_0_1.GetRemainTime(arg_5_0)
	local var_5_0 = arg_5_0.endTime

	pg = var_1_10002

	local var_5_1 = var_1_10002.TimeMgr.GetInstance()

	return var_5_0 - var_2.GetServerTime(var_5_1)
end

function var_0_1.NeedTip(arg_6_0)
	local var_6_0 = arg_6_0.endTime

	pg = var_1_10002

	local var_6_1 = var_1_10002.TimeMgr.GetInstance()
	local var_6_2 = var_6_0 - var_2.GetServerTime(var_6_1)

	math = var_2

	local var_6_3 = var_2.floor(var_6_2 / 0)

	if 3 < var_6_3 then
		return false
	end

	PlayerPrefs = var_3

	if var_3.GetInt(arg_6_0.localTipKey .. "_" .. arg_6_0:GetTipStamp(var_6_3)) == 1 then
		return false
	end

	local var_6_4 = true
	local var_6_5 = var_6_3

	math = var_6

	local var_6_6 = var_6.floor(var_6_2 / 16)
end

function var_0_1.SetTipFlag(arg_7_0, arg_7_1)
	PlayerPrefs = var_1_10002

	var_1_10002.SetInt(arg_7_0.localTipKey .. "_" .. arg_7_0:GetTipStamp(arg_7_1), 1)

	return
end

function var_0_1.GetTipStamp(arg_8_0, arg_8_1)
	return arg_8_1 .. "_" .. arg_8_0.endTime - arg_8_1 * 0
end

function var_0_1.AddPt(arg_9_0, arg_9_1)
	if arg_9_0.pt == 0 then
		IslandAchievementHelper = var_2

		local var_9_0 = var_2.UpdateRecordWithAdd

		IslandAchievementType = var_1_10004

		var_9_0(var_1_10004.SEASON_NUM, 0, 1)
	end

	arg_9_0.pt = arg_9_0.pt + arg_9_1

	return
end

function var_0_1.GetPt(arg_10_0)
	return arg_10_0.pt
end

function var_0_1.GetGotPtAwardList(arg_11_0)
	return arg_11_0.gotPtAwardList
end

function var_0_1.AddGotPtAwardList(arg_12_0, arg_12_1)
	if arg_12_1 == 0 then
		ipairs = var_1_10002

		for iter_12_0, iter_12_1 in var_1_10002(arg_12_0:getConfig("target")) do
			if iter_12_1 <= arg_12_0.pt then
				table = var_7

				if not var_7.contains(arg_12_0.gotPtAwardList, iter_12_1) then
					table = var_7

					var_7.insert(arg_12_0.gotPtAwardList, iter_12_1)
				end
			end
		end
	else
		table = var_1_10002

		var_1_10002.insert(arg_12_0.gotPtAwardList, arg_12_1)
	end

	return
end

function var_0_1.GanGetPtAward(arg_13_0)
	underscore = var_1_10001

	return var_1_10001.any(arg_13_0:getConfig("target"), function(arg_14_0)
		local var_14_0

		if arg_14_0 <= arg_13_0.pt then
			table = var_1
			var_14_0 = not var_1.contains(arg_13_0.gotPtAwardList, arg_14_0)
		else
			var_14_0 = false
		end

		if false then
			var_14_0 = true
		end

		return var_14_0
	end)
end

function var_0_1.GetTaskIds(arg_15_0)
	return arg_15_0:getConfig("task_list")
end

function var_0_1.GetAwardsByRank(arg_16_0, arg_16_1)
	pg = var_1_10002

	local var_16_0 = var_1_10002.island_season[arg_16_0].rank

	pg = var_1_10003

	local var_16_1 = var_1_10003.island_season[arg_16_0].rankaward_display

	ipairs = var_1_10004

	for iter_16_0, iter_16_1 in var_1_10004(var_16_0) do
		if arg_16_1 >= iter_16_1[1] and arg_16_1 <= iter_16_1[2] then
			underscore = var_9

			return var_9.map(var_16_1[iter_16_0], function(arg_17_0)
				Drop = var_2_10001

				return var_2_10001.Create(arg_17_0)
			end)
		end
	end

	return {}
end

function var_0_1.GetPtAwardInfos(arg_18_0)
	local var_18_0 = {}

	pg = var_1_10002

	local var_18_1 = var_1_10002.island_season[arg_18_0]

	ipairs = var_1_10003

	for iter_18_0, iter_18_1 in var_1_10003(var_18_1.target) do
		table = var_1_10008
		var_1_10008 = var_1_10008.insert

		local var_18_2 = var_18_0
		local var_18_3 = {
			target = iter_18_1
		}

		Drop = var_1_10012
		var_18_3.drop = var_1_10012.Create(var_18_1.ptaward_display[iter_18_0])
		table = var_1_10012
		var_18_3.isImportant = var_1_10012.contains(var_18_1.ptaward_highvalue, iter_18_0)

		var_1_10008(var_18_2, var_18_3)
	end

	return var_18_0
end

return var_0_1
