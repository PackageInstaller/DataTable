local var_0_0 = class("IslandVisibilityAllocator", import(".IslandComparableAllocator"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.lockNpcList = {}

	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_0.OnInitFlags(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0.controller.sceneData.unitList) do
		if not arg_2_0:IsLockNpc(iter_2_1.id, IslandConst.UNIT_LIST_OBJ) then
			arg_2_0.flags[iter_2_1.id] = not iter_2_1.isDynamic

			arg_2_0:ApplyCondition(iter_2_1)
		elseif arg_2_1 then
			arg_2_0.flags[iter_2_1.id] = arg_2_1[iter_2_1.id] or not iter_2_1.isDynamic
		end
	end

	return
end

function var_0_0.OnCompareSample(arg_3_0, arg_3_1, arg_3_2)
	for iter_3_0, iter_3_1 in pairs(arg_3_1) do
		if iter_3_1 ~= nil and arg_3_2[iter_3_0] ~= nil and iter_3_1 ~= arg_3_2[iter_3_0] then
			if iter_3_1 == true and arg_3_2[iter_3_0] == false then
				arg_3_0:RemoveUnit(IslandConst.UNIT_LIST_OBJ, iter_3_0)
			elseif iter_3_1 == false and arg_3_2[iter_3_0] == true then
				local var_3_1 = arg_3_0:GetUnitData(iter_3_0)

				if var_3_1 then
					arg_3_0:GenUnit(var_3_1)
				end
			end
		end
	end

	return
end

function var_0_0.GetUnitData(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.controller.sceneData.unitList) do
		if iter_4_1.id == arg_4_1 then
			return iter_4_1
		end
	end

	return nil
end

function var_0_0.ApplyCondition(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:GetShowCondition()
	local var_5_1 = arg_5_1:GetHideCondition()

	if #var_5_0 == 0 and #var_5_1 == 0 then
		return
	end

	local var_5_2 = arg_5_0.controller.island:GetTaskAgency()
	local var_5_3 = var_5_2:GetTraceId()
	local var_5_4 = var_5_2:GetMainTraceId()
	local var_5_5 = arg_5_0:CollectAllTaskStatus(var_5_2)
	local var_5_6 = pg.NewStoryMgr.GetInstance():GetPlayedList()
	local var_5_7 = arg_5_0.flags[arg_5_1.id]
	local var_5_8 = arg_5_0:GetCondition(var_5_5, var_5_6, var_5_3, var_5_4, var_5_0)
	local var_5_9 = arg_5_0:GetCondition(var_5_5, var_5_6, var_5_3, var_5_4, var_5_1)

	if #var_5_0 > 0 and #var_5_1 == 0 then
		if var_5_8 then
			var_5_7 = true
		end
	elseif #var_5_0 == 0 and #var_5_1 > 0 then
		if var_5_9 then
			var_5_7 = false
		end
	elseif #var_5_0 > 0 and #var_5_1 > 0 then
		var_5_7 = arg_5_0:SortCondition(arg_5_1, var_5_3, var_5_4, var_5_8, var_5_9)
	end

	arg_5_0.flags[arg_5_1.id] = var_5_7

	return
end

function var_0_0.SortCondition(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
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

function var_0_0.SortStoryCondition(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1[3] == arg_7_2[3] then
		local var_7_0 = {
			arg_7_1[2],
			arg_7_2[2]
		}

		table.sort({
			arg_7_1[2],
			arg_7_2[2]
		}, function(arg_8_0, arg_8_1)
			return arg_8_1 < arg_8_0
		end)

		return var_7_0[1] == arg_7_1[2]
	else
		return arg_7_1[3] > arg_7_2[3]
	end

	return
end

function var_0_0.SortTaskCondition(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if arg_9_3[2] == arg_9_1 and arg_9_4[2] == arg_9_1 or arg_9_3[2] == arg_9_2 and arg_9_4[2] == arg_9_2 then
		if arg_9_3[3] == arg_9_4[3] then
			local var_9_0 = {
				arg_9_3[2],
				arg_9_4[2]
			}

			table.sort({
				arg_9_3[2],
				arg_9_4[2]
			}, CompareFuncs({
				function(arg_10_0)
					return -1 * pg.island_task[arg_10_0].type
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

function var_0_0.CollectAllTaskStatus(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in pairs((arg_12_1:GetTasks())) do
		({})[iter_12_1.id] = IslandConst.UNIT_SHOW_TYPE_ACCEPT_TASK

		if iter_12_1:IsFinish() then
			({})[iter_12_1.id] = IslandConst.UNIT_SHOW_TYPE_FINISH_TASK
		end
	end

	for iter_12_2, iter_12_3 in ipairs(arg_12_1.finishedIds) do
		({})[iter_12_3] = IslandConst.UNIT_SHOW_TYPE_RECIVE_TASK
	end

	return {}
end

function var_0_0.IsTaskType(arg_13_0, arg_13_1)
	return arg_13_1[1] == IslandConst.UNIT_SHOW_TYPE_ACCEPT_TASK or arg_13_1[1] == IslandConst.UNIT_SHOW_TYPE_FINISH_TASK or arg_13_1[1] == IslandConst.UNIT_SHOW_TYPE_RECIVE_TASK
end

function var_0_0.IsStoryType(arg_14_0, arg_14_1)
	return arg_14_1[1] == IslandConst.UNIT_SHOW_TYPE_STORY_PLAYED
end

function var_0_0.GetCondition(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
	for iter_15_0, iter_15_1 in ipairs(arg_15_5) do
		if arg_15_0:IsTaskType(iter_15_1) then
			table.insert({}, iter_15_1)
		elseif arg_15_0:IsStoryType(iter_15_1) then
			table.insert({}, iter_15_1)
		end
	end

	local var_15_0 = arg_15_0:GetTaskCondition({}, arg_15_3, arg_15_4, arg_15_1)
	local var_15_1 = arg_15_0:GetStoryCondition(arg_15_2, {})

	if var_15_0 and var_15_1 then
		return var_15_1[3] >= var_15_0[3] and var_15_1 or var_15_0
	elseif var_15_0 and not var_15_1 then
		return var_15_0
	elseif var_15_1 and not var_15_0 then
		return var_15_1
	end

	return nil
end

function var_0_0.GetTaskCondition(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	table.sort(arg_16_1, CompareFuncs({
		function(arg_17_0)
			return (arg_17_0[2] == arg_16_2 or arg_17_0[2] == arg_16_3) and 1 or 0
		end,
		function(arg_18_0)
			return arg_18_0[3]
		end
	}))

	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		if arg_16_4[iter_16_1[2]] == iter_16_1[1] then
			return iter_16_1
		end
	end

	return nil
end

function var_0_0.GetStoryCondition(arg_19_0, arg_19_1, arg_19_2)
	table.sort(arg_19_2, CompareFuncs({
		function(arg_20_0)
			return arg_20_0[3]
		end
	}))

	for iter_19_0, iter_19_1 in ipairs(arg_19_2) do
		if arg_19_1[iter_19_1[2]] == true then
			return iter_19_1
		end
	end

	return nil
end

function var_0_0.IsVisible(arg_21_0, arg_21_1)
	return arg_21_0.flags[arg_21_1] == true
end

function var_0_0.IsLockNpc(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0.lockNpcList or {}

	return _.any(var_22_0, function(arg_23_0)
		return arg_23_0[1] == arg_22_1 and arg_23_0[2] == arg_22_2
	end)
end

function var_0_0.LockNpc(arg_24_0, arg_24_1, arg_24_2)
	table.insert(arg_24_0.lockNpcList, {
		arg_24_1,
		arg_24_2
	})

	return
end

function var_0_0.ReleaseNpc(arg_25_0, arg_25_1, arg_25_2)
	for iter_25_0 = #arg_25_0.lockNpcList, 1, -1 do
		if arg_25_0.lockNpcList[iter_25_0][1] == arg_25_1 and arg_25_0.lockNpcList[iter_25_0][2] == arg_25_2 then
			table.remove(arg_25_0.lockNpcList, iter_25_0)
		end
	end

	return
end

return var_0_0
