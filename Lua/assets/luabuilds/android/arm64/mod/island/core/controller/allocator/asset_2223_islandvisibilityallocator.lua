local IslandVisibilityAllocator = class("IslandVisibilityAllocator", import(".IslandComparableAllocator"))

function IslandVisibilityAllocator:Ctor(arg_1_1)
	self.lockNpcList = {}

	IslandVisibilityAllocator.super.Ctor(self, arg_1_1)

	return
end

function IslandVisibilityAllocator:OnInitFlags(arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(self.controller.sceneData.unitList) do
		if not self:IsLockNpc(iter_2_1.id, IslandConst.UNIT_LIST_OBJ) then
			self.flags[iter_2_1.id] = not iter_2_1.isDynamic

			self:ApplyCondition(iter_2_1)
		elseif arg_2_1 then
			self.flags[iter_2_1.id] = arg_2_1[iter_2_1.id] or not iter_2_1.isDynamic
		end
	end

	return
end

function IslandVisibilityAllocator:OnCompareSample(arg_3_1, arg_3_2)
	for iter_3_0, iter_3_1 in pairs(arg_3_1) do
		if iter_3_1 ~= nil and arg_3_2[iter_3_0] ~= nil and iter_3_1 ~= arg_3_2[iter_3_0] then
			if iter_3_1 == true and arg_3_2[iter_3_0] == false then
				self:RemoveUnit(IslandConst.UNIT_LIST_OBJ, iter_3_0)
			elseif iter_3_1 == false and arg_3_2[iter_3_0] == true then
				local var_3_1 = self:GetUnitData(iter_3_0)

				if var_3_1 then
					self:GenUnit(var_3_1)
				end
			end
		end
	end

	return
end

function IslandVisibilityAllocator:GetUnitData(arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(self.controller.sceneData.unitList) do
		if iter_4_1.id == arg_4_1 then
			return iter_4_1
		end
	end

	return nil
end

function IslandVisibilityAllocator:ApplyCondition(arg_5_1)
	local var_5_0 = arg_5_1:GetShowCondition()
	local var_5_1 = arg_5_1:GetHideCondition()

	if #var_5_0 == 0 and #var_5_1 == 0 then
		return
	end

	local var_5_2 = self.controller.island:GetTaskAgency()
	local var_5_3 = var_5_2:GetTraceId()
	local var_5_4 = var_5_2:GetMainTraceId()
	local var_5_5 = self:CollectAllTaskStatus(var_5_2)
	local var_5_6 = pg.NewStoryMgr.GetInstance():GetPlayedList()
	local var_5_7 = self.flags[arg_5_1.id]
	local var_5_8 = self:GetCondition(var_5_5, var_5_6, var_5_3, var_5_4, var_5_0)
	local var_5_9 = self:GetCondition(var_5_5, var_5_6, var_5_3, var_5_4, var_5_1)

	if #var_5_0 > 0 and #var_5_1 == 0 then
		if var_5_8 then
			var_5_7 = true
		end
	elseif #var_5_0 == 0 and #var_5_1 > 0 then
		if var_5_9 then
			var_5_7 = false
		end
	elseif #var_5_0 > 0 and #var_5_1 > 0 then
		var_5_7 = self:SortCondition(arg_5_1, var_5_3, var_5_4, var_5_8, var_5_9)
	end

	self.flags[arg_5_1.id] = var_5_7

	return
end

function IslandVisibilityAllocator:SortCondition(arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	if not arg_6_4 and not arg_6_5 then
		return false
	elseif arg_6_4 and not arg_6_5 then
		return true
	elseif not arg_6_4 and arg_6_5 then
		return false
	end

	if self:IsTaskType(arg_6_4) and self:IsTaskType(arg_6_5) then
		return self:SortTaskCondition(arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	elseif self:IsStoryType(arg_6_4) and self:IsStoryType(arg_6_5) then
		return self:SortStoryCondition(arg_6_4, arg_6_5)
	elseif arg_6_4[3] == arg_6_5[3] then
		if self:IsStoryType(arg_6_4) then
			return true
		end

		if self:IsStoryType(arg_6_5) then
			return false
		end

		return true
	else
		return arg_6_4[3] > arg_6_5[3]
	end

	return
end

function IslandVisibilityAllocator:SortStoryCondition(arg_7_1, arg_7_2)
	if arg_7_1[3] == arg_7_2[3] then
		local var_7_0 = {
			arg_7_1[2],
			arg_7_2[2]
		}

		table.sort(var_7_0, function(arg_8_0, arg_8_1)
			return arg_8_1 < arg_8_0
		end)

		return var_7_0[1] == arg_7_1[2]
	else
		return arg_7_1[3] > arg_7_2[3]
	end

	return
end

function IslandVisibilityAllocator:SortTaskCondition(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if arg_9_3[2] == arg_9_1 and arg_9_4[2] == arg_9_1 or arg_9_3[2] == arg_9_2 and arg_9_4[2] == arg_9_2 then
		if arg_9_3[3] == arg_9_4[3] then
			local var_9_0 = {
				arg_9_3[2],
				arg_9_4[2]
			}

			table.sort(var_9_0, CompareFuncs({
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

function IslandVisibilityAllocator:CollectAllTaskStatus(arg_12_1)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs((arg_12_1:GetTasks())) do
		var_12_0[iter_12_1.id] = IslandConst.UNIT_SHOW_TYPE_ACCEPT_TASK

		if iter_12_1:IsFinish() then
			var_12_0[iter_12_1.id] = IslandConst.UNIT_SHOW_TYPE_FINISH_TASK
		end
	end

	for iter_12_2, iter_12_3 in ipairs(arg_12_1.finishedIds) do
		var_12_0[iter_12_3] = IslandConst.UNIT_SHOW_TYPE_RECIVE_TASK
	end

	return var_12_0
end

function IslandVisibilityAllocator:IsTaskType(arg_13_1)
	return arg_13_1[1] == IslandConst.UNIT_SHOW_TYPE_ACCEPT_TASK or arg_13_1[1] == IslandConst.UNIT_SHOW_TYPE_FINISH_TASK or arg_13_1[1] == IslandConst.UNIT_SHOW_TYPE_RECIVE_TASK
end

function IslandVisibilityAllocator:IsStoryType(arg_14_1)
	return arg_14_1[1] == IslandConst.UNIT_SHOW_TYPE_STORY_PLAYED
end

function IslandVisibilityAllocator:GetCondition(arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
	local var_15_0 = {}
	local var_15_1 = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_5) do
		if self:IsTaskType(iter_15_1) then
			table.insert(var_15_0, iter_15_1)
		elseif self:IsStoryType(iter_15_1) then
			table.insert(var_15_1, iter_15_1)
		end
	end

	local var_15_2 = self:GetTaskCondition(var_15_0, arg_15_3, arg_15_4, arg_15_1)
	local var_15_3 = self:GetStoryCondition(arg_15_2, var_15_1)

	if var_15_2 and var_15_3 then
		return var_15_3[3] >= var_15_2[3] and var_15_3 or var_15_2
	elseif var_15_2 and not var_15_3 then
		return var_15_2
	elseif var_15_3 and not var_15_2 then
		return var_15_3
	end

	return nil
end

function IslandVisibilityAllocator:GetTaskCondition(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
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

function IslandVisibilityAllocator:GetStoryCondition(arg_19_1, arg_19_2)
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

function IslandVisibilityAllocator:IsVisible(arg_21_1)
	return self.flags[arg_21_1] == true
end

function IslandVisibilityAllocator:IsLockNpc(arg_22_1, arg_22_2)
	return _.any(self.lockNpcList or {}, function(arg_23_0)
		return arg_23_0[1] == arg_22_1 and arg_23_0[2] == arg_22_2
	end)
end

function IslandVisibilityAllocator:LockNpc(arg_24_1, arg_24_2)
	table.insert(self.lockNpcList, {
		arg_24_1,
		arg_24_2
	})

	return
end

function IslandVisibilityAllocator:ReleaseNpc(arg_25_1, arg_25_2)
	for iter_25_0 = #self.lockNpcList, 1, -1 do
		if self.lockNpcList[iter_25_0][1] == arg_25_1 and self.lockNpcList[iter_25_0][2] == arg_25_2 then
			table.remove(self.lockNpcList, iter_25_0)
		end
	end

	return
end

return IslandVisibilityAllocator
