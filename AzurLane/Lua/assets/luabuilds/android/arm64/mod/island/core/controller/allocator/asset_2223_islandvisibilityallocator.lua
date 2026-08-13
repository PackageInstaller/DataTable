class = var_0_10000

local var_0_0 = "IslandVisibilityAllocator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandComparableAllocator"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.lockNpcList = {}

	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_1.OnInitFlags(arg_2_0, arg_2_1)
	ipairs = var_1_10002

	for iter_2_0, iter_2_1 in var_1_10002(arg_2_0.controller.sceneData.unitList) do
		local var_2_0 = arg_2_0
		local var_2_1 = arg_2_0.IsLockNpc
		local var_2_2 = iter_2_1.id

		IslandConst = var_1_10011

		if not var_2_1(var_2_0, var_2_2, var_1_10011.UNIT_LIST_OBJ) then
			arg_2_0.flags[iter_2_1.id] = not iter_2_1.isDynamic

			arg_2_0:ApplyCondition(iter_2_1)
		elseif arg_2_1 then
			local var_2_3 = arg_2_0.flags
			local var_2_4 = iter_2_1.id
			local var_2_5

			if not arg_2_1[iter_2_1.id] then
				var_2_5 = not iter_2_1.isDynamic
			end

			var_2_3[var_2_4] = var_2_5
		end
	end

	return
end

function var_0_1.OnCompareSample(arg_3_0, arg_3_1, arg_3_2)
	pairs = var_1_10003

	for iter_3_0, iter_3_1 in var_1_10003(arg_3_1) do
		local var_3_0 = iter_3_1
		local var_3_1 = arg_3_2[iter_3_0]

		if var_3_0 ~= nil and var_3_1 ~= nil and var_3_0 ~= var_3_1 then
			if var_3_0 == true and var_3_1 == false then
				local var_3_2 = arg_3_0
				local var_3_3 = arg_3_0.RemoveUnit

				IslandConst = var_1_10013

				var_3_3(var_3_2, var_1_10013.UNIT_LIST_OBJ, iter_3_0)
			elseif var_3_0 == false and var_3_1 == true and arg_3_0:GetUnitData(iter_3_0) then
				var_1_10013 = arg_3_0

				arg_3_0.GenUnit(var_1_10013, var_10)
			end
		end
	end

	return
end

function var_0_1.GetUnitData(arg_4_0, arg_4_1)
	ipairs = var_1_10002

	for iter_4_0, iter_4_1 in var_1_10002(arg_4_0.controller.sceneData.unitList) do
		if iter_4_1.id == arg_4_1 then
			return iter_4_1
		end
	end

	return nil
end

function var_0_1.ApplyCondition(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:GetShowCondition()
	local var_5_1 = arg_5_1:GetHideCondition()

	if #var_5_0 == 0 and #var_5_1 == 0 then
		return
	end

	local var_5_2 = arg_5_0.controller.island
	local var_5_3 = var_4.GetTaskAgency(var_5_2)
	local var_5_4 = var_4.GetTraceId(var_5_3)
	local var_5_5 = var_4
	local var_5_6 = var_4.GetMainTraceId(var_5_5)
	local var_5_7 = arg_5_0:CollectAllTaskStatus(var_4)

	pg = var_5_5

	local var_5_8 = var_5_5.NewStoryMgr.GetInstance()
	local var_5_9 = var_8.GetPlayedList(var_5_8)
	local var_5_10 = arg_5_0.flags[arg_5_1.id]
	local var_5_11 = arg_5_0:GetCondition(var_5_7, var_5_9, var_5_4, var_5_6, var_5_0)
	local var_5_12 = arg_5_0:GetCondition(var_5_7, var_5_9, var_5_4, var_5_6, var_5_1)

	if #var_5_0 > 0 and #var_5_1 == 0 then
		if var_5_11 then
			var_5_10 = true
		end
	elseif #var_5_0 == 0 and #var_5_1 > 0 then
		if var_5_12 then
			var_5_10 = false
		end
	elseif #var_5_0 > 0 and #var_5_1 > 0 then
		var_5_10 = arg_5_0:SortCondition(arg_5_1, var_5_4, var_5_6, var_5_11, var_5_12)
	end

	arg_5_0.flags[arg_5_1.id] = var_5_10

	return
end

function var_0_1.SortCondition(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	if not arg_6_4 and not arg_6_5 then
		return false
	elseif arg_6_4 and not arg_6_5 then
		return true
	elseif not arg_6_4 and arg_6_5 then
		return false
	end

	if arg_6_0:IsTaskType(arg_6_4) and arg_6_0:IsTaskType(arg_6_5) then
		return arg_6_0:SortTaskCondition(arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	elseif arg_6_0:IsStoryType(arg_6_4) and arg_6_0:IsStoryType(arg_6_5) then
		return arg_6_0:SortStoryCondition(arg_6_4, arg_6_5)
	elseif arg_6_4[3] == arg_6_5[3] then
		if arg_6_0:IsStoryType(arg_6_4) then
			return true
		end

		if arg_6_0:IsStoryType(arg_6_5) then
			return false
		end

		return true
	else
		return arg_6_4[3] > arg_6_5[3]
	end

	return
end

function var_0_1.SortStoryCondition(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1[3] == arg_7_2[3] then
		local var_7_0 = {
			arg_7_1[2],
			arg_7_2[2]
		}

		table = var_4

		var_4.sort(var_7_0, function(arg_8_0, arg_8_1)
			return arg_8_1 < arg_8_0
		end)

		return var_7_0[1] == arg_7_1[2]
	else
		return arg_7_1[3] > arg_7_2[3]
	end

	return
end

function var_0_1.SortTaskCondition(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if arg_9_3[2] == arg_9_1 and arg_9_4[2] == arg_9_1 or arg_9_3[2] == arg_9_2 and arg_9_4[2] == arg_9_2 then
		if arg_9_3[3] == arg_9_4[3] then
			local var_9_0 = {
				arg_9_3[2],
				arg_9_4[2]
			}

			table = var_6

			local var_9_1 = var_6.sort
			local var_9_2 = var_9_0

			CompareFuncs = var_1_10009

			var_9_1(var_9_2, var_1_10009({
				function(arg_10_0)
					pg = var_2_10001

					return -1 * var_2_10001.island_task[arg_10_0].type
				end,
				function(arg_11_0)
					return arg_11_0
				end
			}))

			return var_9_0[1] == arg_9_3[2]
		else
			return arg_9_3[3] > arg_9_4[3]
		end
	else
		return arg_9_3[2] == arg_9_1 or arg_9_3[2] == arg_9_2
	end

	return
end

function var_0_1.CollectAllTaskStatus(arg_12_0, arg_12_1)
	local var_12_0 = {}
	local var_12_1 = arg_12_1:GetTasks()

	pairs = var_1_10004

	for iter_12_0, iter_12_1 in var_1_10004(var_12_1) do
		var_1_10009 = iter_12_1.id
		IslandConst = var_1_10010
		var_12_0[var_1_10009] = var_1_10010.UNIT_SHOW_TYPE_ACCEPT_TASK

		if iter_12_1:IsFinish() then
			var_1_10009 = iter_12_1.id
			IslandConst = var_1_10010
			var_12_0[var_1_10009] = var_1_10010.UNIT_SHOW_TYPE_FINISH_TASK
		end
	end

	ipairs = var_4

	for iter_12_2, iter_12_3 in var_4(arg_12_1.finishedIds) do
		IslandConst = var_1_10009
		var_12_0[iter_12_3] = var_1_10009.UNIT_SHOW_TYPE_RECIVE_TASK
	end

	return var_12_0
end

function var_0_1.IsTaskType(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1[1]

	IslandConst = var_1_10003

	local var_13_1

	if var_13_0 ~= var_1_10003.UNIT_SHOW_TYPE_ACCEPT_TASK then
		IslandConst = var_3

		if var_13_0 ~= var_3.UNIT_SHOW_TYPE_FINISH_TASK then
			IslandConst = var_3

			if var_13_0 ~= var_3.UNIT_SHOW_TYPE_RECIVE_TASK then
				var_13_1 = false

				goto label_13_0
			end
		end
	end

	var_13_1 = true

	::label_13_0::

	return var_13_1
end

function var_0_1.IsStoryType(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1[1]

	IslandConst = var_1_10003

	return var_14_0 == var_1_10003.UNIT_SHOW_TYPE_STORY_PLAYED
end

function var_0_1.GetCondition(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
	local var_15_0 = {}
	local var_15_1 = {}

	ipairs = var_1_10008

	for iter_15_0, iter_15_1 in var_1_10008(arg_15_5) do
		if arg_15_0:IsTaskType(iter_15_1) then
			table = var_13

			var_13.insert(var_15_0, iter_15_1)
		elseif arg_15_0:IsStoryType(iter_15_1) then
			table = var_13

			var_13.insert(var_15_1, iter_15_1)
		end
	end

	local var_15_2 = arg_15_0:GetTaskCondition(var_15_0, arg_15_3, arg_15_4, arg_15_1)
	local var_15_3 = arg_15_0:GetStoryCondition(arg_15_2, var_15_1)

	if var_15_2 and var_15_3 then
		return var_15_3[3] >= var_15_2[3] and var_15_3 or var_15_2
	elseif var_15_2 and not var_15_3 then
		return var_15_2
	elseif var_15_3 and not var_15_2 then
		return var_15_3
	end

	return nil
end

function var_0_1.GetTaskCondition(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	table = var_1_10005

	local var_16_0 = var_1_10005.sort
	local var_16_1 = arg_16_1

	CompareFuncs = var_1_10008

	var_16_0(var_16_1, var_1_10008({
		function(arg_17_0)
			return (arg_17_0[2] == arg_16_2 or arg_17_0[2] == arg_16_3) and 1 or 0
		end,
		function(arg_18_0)
			return arg_18_0[3]
		end
	}))

	ipairs = var_16_0

	for iter_16_0, iter_16_1 in var_16_0(arg_16_1) do
		local var_16_2 = iter_16_1[1]

		if arg_16_4[iter_16_1[2]] == var_16_2 then
			return iter_16_1
		end
	end

	return nil
end

function var_0_1.GetStoryCondition(arg_19_0, arg_19_1, arg_19_2)
	table = var_1_10003

	local var_19_0 = var_1_10003.sort
	local var_19_1 = arg_19_2

	CompareFuncs = var_1_10006

	var_19_0(var_19_1, var_1_10006({
		function(arg_20_0)
			return arg_20_0[3]
		end
	}))

	ipairs = var_19_0

	for iter_19_0, iter_19_1 in var_19_0(arg_19_2) do
		if arg_19_1[iter_19_1[2]] == true then
			return iter_19_1
		end
	end

	return nil
end

function var_0_1.IsVisible(arg_21_0, arg_21_1)
	return arg_21_0.flags[arg_21_1] == true
end

function var_0_1.IsLockNpc(arg_22_0, arg_22_1, arg_22_2)
	_ = var_1_10003

	local var_22_0 = var_1_10003.any
	local var_22_1

	if not arg_22_0.lockNpcList then
		var_22_1 = {}
	end

	return var_22_0(var_22_1, function(arg_23_0)
		return arg_23_0[1] == arg_22_1 and arg_23_0[2] == arg_22_2
	end)
end

function var_0_1.LockNpc(arg_24_0, arg_24_1, arg_24_2)
	table = var_1_10003

	var_1_10003.insert(arg_24_0.lockNpcList, {
		arg_24_1,
		arg_24_2
	})

	return
end

function var_0_1.ReleaseNpc(arg_25_0, arg_25_1, arg_25_2)
	for iter_25_0 = #arg_25_0.lockNpcList, 1, -1 do
		if arg_25_0.lockNpcList[iter_25_0][1] == arg_25_1 and var_7[2] == arg_25_2 then
			table = var_8

			var_8.remove(arg_25_0.lockNpcList, iter_25_0)
		end
	end

	return
end

return var_0_1
