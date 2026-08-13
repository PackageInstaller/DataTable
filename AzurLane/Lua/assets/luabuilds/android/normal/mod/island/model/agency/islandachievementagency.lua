class = var_0_10000

local var_0_0 = "IslandAchievementAgency"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandBaseAgency"))

var_0_1.NEW_CAN_GET = "IslandAchievementAgency.NEW_CAN_GET"

function var_0_1.OnInit(arg_1_0, arg_1_1)
	local var_1_0

	if not arg_1_1.achievement_sys.finish_list then
		var_1_0 = {}
	end

	arg_1_0.gotList = var_1_0
	arg_1_0.recordDic = {}
	ipairs = var_3

	local var_1_1

	if not var_2.achieve_list then
		var_1_1 = {}
	end

	for iter_1_0, iter_1_1 in var_3(var_1_1) do
		local var_1_2 = iter_1_1.event_type
		local var_1_3 = iter_1_1.event_arg
		local var_1_4 = iter_1_1.value

		if not arg_1_0.recordDic[var_1_2] then
			arg_1_0.recordDic[var_1_2] = {}
		end

		arg_1_0.recordDic[var_1_2][var_1_3] = var_1_4
	end

	return
end

function var_0_1.InitRuntimeRecords(arg_2_0)
	IslandAchievementType = var_1_10001

	local var_2_0 = var_1_10001.GetRuntimeTypes()

	IslandAchievementType = var_1_10002

	local var_2_1 = var_1_10002.GetClientTypes()

	ipairs = var_1_10003
	pg = var_1_10004

	for iter_2_0, iter_2_1 in var_1_10003(var_1_10004.island_achievement.all) do
		pg = var_1_10008

		local var_2_2 = var_1_10008.island_achievement[iter_2_1].target_type
		local var_2_3 = var_1_10008.target_value1

		table = var_1_10011

		if var_1_10011.contains(var_2_0, var_2_2) then
			if not arg_2_0.recordDic[var_2_2] then
				var_1_10011 = arg_2_0.recordDic
				var_1_10011[var_2_2] = {}
			end

			if not arg_2_0.recordDic[var_2_2][var_2_3] then
				var_1_10011 = arg_2_0.recordDic[var_2_2]
				IslandAchievementHelper = var_12
				var_1_10011[var_2_3] = var_12.GetRuntimeData(var_2_2, var_2_3)
			end
		else
			table = var_1_10011

			if var_1_10011.contains(var_2_1, var_2_2) then
				if not arg_2_0.recordDic[var_2_2] then
					var_1_10011 = arg_2_0.recordDic
					var_1_10011[var_2_2] = {}
				end

				if not arg_2_0.recordDic[var_2_2][var_2_3] then
					var_1_10011 = arg_2_0.recordDic[var_2_2]
					var_1_10011[var_2_3] = 0
				end
			end
		end
	end

	arg_2_0:BuildDataDic()

	return
end

function var_0_1.BuildDataDic(arg_3_0)
	arg_3_0.groupDic = {}
	arg_3_0.achvDic = {}
	pairs = var_1
	pg = var_1_10002

	for iter_3_0, iter_3_1 in var_1(var_1_10002.island_achievement.get_id_list_by_group) do
		IslandAchievementGroup = var_1_10006
		var_1_10006 = var_1_10006.New(iter_3_0, iter_3_1)
		ipairs = var_7

		for iter_3_2, iter_3_3 in var_7(iter_3_1) do
			local var_3_0 = var_1_10006
			local var_3_1 = var_1_10006.GetAchvById(var_3_0, iter_3_3)

			table = var_3_0

			if var_3_0.contains(arg_3_0.gotList, iter_3_3) then
				local var_3_2 = var_3_1
				local var_3_3 = var_3_1.SetStatus

				IslandAchievement = var_15

				var_3_3(var_3_2, var_15.STATUS.GOT)

				goto label_3_0
			end

			local var_3_4 = var_3_1
			local var_3_5 = var_3_1.SetStatus

			if arg_3_0:IsCanGet(var_3_1) then
				IslandAchievement = var_3_6

				do
					local var_3_6

					if not var_3_6.STATUS.GET then
						IslandAchievement = var_3_6
						var_3_6 = var_3_6.STATUS.NORMAL
					end

					var_3_5(var_3_4, var_3_6)
				end

				::label_3_0::

				local var_3_7 = var_3_1:GetType()
				local var_3_8 = var_3_1:GetParam()

				if not arg_3_0.achvDic[var_3_7] then
					arg_3_0.achvDic[var_3_7] = {}
				end

				local var_3_9

				if not arg_3_0.achvDic[var_3_7][var_3_8] then
					var_3_9 = arg_3_0.achvDic[var_3_7]
					var_3_9[var_3_8] = {}
				end

				table = var_3_9

				var_3_9.insert(arg_3_0.achvDic[var_3_7][var_3_8], var_3_1)
			end
		end

		arg_3_0.groupDic[iter_3_0] = var_1_10006
	end

	return
end

function var_0_1.GetRecordsByType(arg_4_0, arg_4_1)
	local var_4_0

	if not arg_4_0.recordDic[arg_4_1] then
		var_4_0 = {}
	end

	return var_4_0
end

function var_0_1.IsGot(arg_5_0, arg_5_1)
	table = var_1_10002

	return var_1_10002.contains(arg_5_0.gotList, arg_5_1)
end

function var_0_1.GetGotList(arg_6_0)
	return arg_6_0.gotList
end

function var_0_1.GetGotGroupMaxStageList(arg_7_0)
	pg = var_1_10001

	local var_7_0 = var_1_10001.island_achievement
	local var_7_1 = {}
	local var_7_2 = {}

	ipairs = var_1_10004

	for iter_7_0, iter_7_1 in var_1_10004(arg_7_0.gotList) do
		local var_7_3 = var_7_0[iter_7_1].group
		local var_7_4 = var_7_0[iter_7_1].stage

		if not var_7_1[var_7_3] or var_7_4 > var_7_1[var_7_3] then
			var_7_1[var_7_3] = var_7_4
			var_7_2[var_7_3] = iter_7_1
		end
	end

	underscore = var_4

	return var_4.values(var_7_2)
end

function var_0_1.UpdataAchLv(arg_8_0, arg_8_1)
	local var_8_0 = {}
	local var_8_1 = arg_8_0:GetGotGroupMaxStageList()
	local var_8_2 = {}

	ipairs = var_1_10005

	for iter_8_0, iter_8_1 in var_1_10005(var_8_1) do
		pg = var_1_10010
		var_8_2[var_1_10010.island_achievement[iter_8_1].group] = iter_8_1
	end

	ipairs = var_5

	for iter_8_2, iter_8_3 in var_5(arg_8_1) do
		pg = var_1_10010
		var_1_10010 = var_1_10010.island_achievement[iter_8_3]
		table = var_1_10011

		var_1_10011.insert(var_8_0, var_8_2[var_1_10010.group])
	end

	local var_8_3

	return var_8_0
end

function var_0_1.GetGroup(arg_9_0, arg_9_1)
	return arg_9_0.groupDic[arg_9_1]
end

function var_0_1.IsCanGet(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1
	local var_10_1 = arg_10_1.GetStatus(var_10_0)

	IslandAchievement = var_10_0

	if var_10_1 == var_10_0.STATUS.GOT then
		return
	end

	local var_10_2 = arg_10_1:GetType()
	local var_10_3 = arg_10_1:GetParam()
	local var_10_4 = arg_10_1:GetNum()

	if not arg_10_0.recordDic[var_10_2] then
		return false
	end

	return arg_10_0.recordDic[var_10_2][var_10_3] and var_10_4 <= var_5
end

function var_0_1.GetCurProgress(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1:GetType()
	local var_11_1 = arg_11_1:GetParam()
	local var_11_2 = arg_11_1:GetNum()

	if not arg_11_0.recordDic[var_11_0] then
		return 0
	end

	local var_11_3

	if not arg_11_0.recordDic[var_11_0][var_11_1] then
		var_11_3 = 0
	end

	return var_11_3
end

function var_0_1.GetTotalCnt(arg_12_0)
	local var_12_0 = 0

	pairs = var_1_10002

	for iter_12_0, iter_12_1 in var_1_10002(arg_12_0.groupDic) do
		underscore = var_1_10007
		var_12_0 = var_1_10007.reduce(iter_12_1:GetSortAchvList(), var_12_0, function(arg_13_0, arg_13_1)
			local var_13_1

			if arg_13_1:IsHideType() then
				local var_13_0 = arg_12_0

				if var_2.IsCanGet(var_13_0, arg_13_1) then
					var_13_1 = 1
				else
					var_13_1 = 0
				end
			else
				var_13_1 = 1
			end

			return arg_13_0 + var_13_1
		end)
	end

	return var_12_0
end

function var_0_1.CheckRecordExist(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0

	if arg_14_0.recordDic[arg_14_1] then
		var_14_0 = arg_14_0.recordDic[arg_14_1][arg_14_2]
	end

	return var_14_0
end

function var_0_1.UpdateRecord(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	if not arg_15_0.recordDic[arg_15_1] then
		arg_15_0.recordDic[arg_15_1] = {}
	end

	if not arg_15_0.recordDic[arg_15_1][arg_15_2] then
		local var_15_0 = 0
	end

	arg_15_0.recordDic[arg_15_1][arg_15_2] = arg_15_3

	arg_15_0:CheckAchvStatus(arg_15_1, arg_15_2)

	return
end

function var_0_1.UpdateRecordWithAdd(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if not arg_16_0.recordDic[arg_16_1] then
		arg_16_0.recordDic[arg_16_1] = {}
	end

	local var_16_0

	if not arg_16_0.recordDic[arg_16_1][arg_16_2] then
		var_16_0 = 0
	end

	arg_16_0.recordDic[arg_16_1][arg_16_2] = var_16_0 + arg_16_3

	arg_16_0:CheckAchvStatus(arg_16_1, arg_16_2)

	return
end

function var_0_1.CheckAchvStatus(arg_17_0, arg_17_1, arg_17_2)
	if not arg_17_0.achvDic[arg_17_1] or not arg_17_0.achvDic[arg_17_1][arg_17_2] then
		return
	end

	ipairs = var_3

	for iter_17_0, iter_17_1 in var_3(arg_17_0.achvDic[arg_17_1][arg_17_2]) do
		local var_17_0 = iter_17_1
		local var_17_1 = iter_17_1.GetStatus(var_17_0)

		IslandAchievement = var_17_0

		if var_17_1 == var_17_0.STATUS.NORMAL and arg_17_0:IsCanGet(iter_17_1) then
			local var_17_2 = iter_17_1
			local var_17_3 = iter_17_1.SetStatus

			IslandAchievement = var_10

			var_17_3(var_17_2, var_10.STATUS.GET)
			arg_17_0:DispatchEvent(var_0_1.NEW_CAN_GET, iter_17_1)
		end
	end

	return
end

function var_0_1.AddGotIds(arg_18_0, arg_18_1)
	ipairs = var_1_10002

	for iter_18_0, iter_18_1 in var_1_10002(arg_18_1) do
		table = var_1_10007

		var_1_10007.insert(arg_18_0.gotList, iter_18_1)

		pg = var_1_10007
		var_1_10007 = var_1_10007.island_achievement[iter_18_1].group

		local var_18_0 = arg_18_0.groupDic[var_1_10007]

		var_8.SetGotTagById(var_18_0, iter_18_1)
	end

	return
end

function var_0_1.IsTip(arg_19_0)
	pairs = var_1_10001

	for iter_19_0, iter_19_1 in var_1_10001(arg_19_0.groupDic) do
		ipairs = var_1_10006

		for iter_19_2, iter_19_3 in var_1_10006(iter_19_1:GetSortAchvList()) do
			local var_19_0 = iter_19_3
			local var_19_1 = iter_19_3.GetStatus(var_19_0)

			IslandAchievement = var_19_0

			if var_19_1 == var_19_0.STATUS.GET then
				return true
			end
		end
	end

	return false
end

return var_0_1
