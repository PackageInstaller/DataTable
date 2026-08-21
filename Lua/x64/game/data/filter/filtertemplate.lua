local var_0_0 = class("FilterTemplate")
local var_0_1, var_0_2 = pcall(require, "bit")

if not var_0_1 then
	local var_0_3

	var_0_3, var_0_2 = pcall(require, "bit32")
end

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.filterId = arg_1_1
	arg_1_0.data = {}
end

function var_0_0.Clear(arg_2_0)
	arg_2_0.data = {}
end

function var_0_0.ClearGroup(arg_3_0, arg_3_1)
	if arg_3_0.data[arg_3_1] then
		arg_3_0.data[arg_3_1] = nil
	end
end

function var_0_0.IsAll(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.data) do
		if iter_4_1 > 0 then
			return false
		end
	end

	return true
end

function var_0_0.LShiftOne(arg_5_0, arg_5_1)
	return var_0_2.lshift(1, arg_5_1)
end

function var_0_0.HasFlag(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = CommonFilterConst.GetGroupCfg(arg_6_1)
	local var_6_1 = arg_6_0:GetFilterData(arg_6_1) or 0

	if var_6_0.mode == Filter_Group_Mode.SingleMode and var_6_1 == 0 and arg_6_2 == 1 then
		return true
	end

	return var_0_2.band(var_6_1, arg_6_2) ~= 0
end

function var_0_0.LessEqualFlag(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0:GetFilterData(arg_7_1) or 0

	return var_0_2.band(var_7_0, arg_7_2) == arg_7_2
end

function var_0_0.SelectTag(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = CommonFilterConst.GetGroupCfg(arg_8_1).mode
	local var_8_1 = CommonFilterConst.GetTagIndexAtGroup(arg_8_1, arg_8_2)
	local var_8_2 = arg_8_0:GetFilterData(arg_8_1) or 0
	local var_8_3 = var_0_2.lshift(1, var_8_1)
	local var_8_4 = var_8_2

	if var_8_0 == Filter_Group_Mode.SingleMode then
		var_8_4 = var_8_3
	else
		var_8_4 = var_0_2.bor(var_8_2, var_8_3)
	end

	arg_8_0:SetFilterGroupMask(arg_8_1, var_8_4)

	return var_8_4
end

function var_0_0.DeSelectTag(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = CommonFilterConst.GetGroupCfg(arg_9_1).mode
	local var_9_1 = CommonFilterConst.GetTagIndexAtGroup(arg_9_1, arg_9_2)
	local var_9_2 = arg_9_0:GetFilterData(arg_9_1) or 0
	local var_9_3 = var_0_2.lshift(1, var_9_1)
	local var_9_4 = var_9_2
	local var_9_5 = var_9_0 == Filter_Group_Mode.SingleMode and 0 or var_0_2.bxor(var_9_2, var_9_3)

	arg_9_0:SetFilterGroupMask(arg_9_1, var_9_5)

	return var_9_5
end

function var_0_0.HasIndexFlag(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = CommonFilterConst.GetTagIndexAtGroup(arg_10_1, arg_10_2)

	return arg_10_0:HasFlag(arg_10_1, var_0_2.lshift(1, var_10_0))
end

function var_0_0.HasIndexFlagList(arg_11_0, arg_11_1, arg_11_2)
	arg_11_2 = arg_11_2 or {}

	local var_11_0 = 0

	for iter_11_0, iter_11_1 in ipairs(arg_11_2) do
		local var_11_1 = CommonFilterConst.GetTagIndexAtGroup(arg_11_1, iter_11_1)

		var_11_0 = var_0_2.bor(var_11_0, var_0_2.lshift(1, var_11_1))
	end

	return arg_11_0:HasFlag(arg_11_1, var_11_0)
end

function var_0_0.AllIndexFlagPast(arg_12_0, arg_12_1, arg_12_2)
	arg_12_2 = arg_12_2 or {}

	local var_12_0 = 0

	for iter_12_0, iter_12_1 in ipairs(arg_12_2) do
		local var_12_1 = CommonFilterConst.GetTagIndexAtGroup(arg_12_1, iter_12_1)

		var_12_0 = var_0_2.bor(var_12_0, var_0_2.lshift(1, var_12_1))
	end

	return arg_12_0:LessEqualFlag(arg_12_1, var_12_0)
end

function var_0_0.SpecificHasFlag(arg_13_0, arg_13_1, arg_13_2)
	if (arg_13_0:GetFilterData(arg_13_1) or 0) == 0 then
		return true
	end

	arg_13_2 = arg_13_2 or {}

	local var_13_0 = 0

	for iter_13_0, iter_13_1 in ipairs(arg_13_2) do
		local var_13_1 = CommonFilterConst.GetTagIndexAtGroup(arg_13_1, iter_13_1)

		var_13_0 = var_0_2.bor(var_13_0, var_0_2.lshift(1, var_13_1))
	end

	return arg_13_0:HasFlag(arg_13_1, var_13_0)
end

function var_0_0.GetGroupSelectedTags(arg_14_0, arg_14_1)
	local var_14_0 = {}
	local var_14_1 = CommonFilterConst.GetGroupCfg(arg_14_1)

	if var_14_1 then
		local var_14_2 = var_14_1.tags

		for iter_14_0, iter_14_1 in ipairs(var_14_2) do
			if arg_14_0:HasIndexFlag(arg_14_1, iter_14_1) then
				table.insert(var_14_0, iter_14_1)
			end
		end
	end

	return var_14_0
end

function var_0_0.AtLeastOneChoose(arg_15_0)
	local var_15_0 = CommonFilterConst.GetFilterGroups(arg_15_0.filterId)

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		local var_15_1 = arg_15_0:GetFilterData(iter_15_1)

		if var_15_1 and var_15_1 > 0 then
			return true
		end
	end

	return false
end

function var_0_0.AtLeastOneChooseGroup(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:GetFilterData(arg_16_1)

	if var_16_0 and var_16_0 > 0 then
		return true
	end

	return false
end

function var_0_0.GetFilterData(arg_17_0, arg_17_1)
	return arg_17_0.data[arg_17_1]
end

function var_0_0.SetFilterGroupMask(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0.data[arg_18_1] = arg_18_2
end

function var_0_0.CheckIsSame(arg_19_0, arg_19_1)
	local var_19_0 = true
	local var_19_1 = 0
	local var_19_2 = 0

	for iter_19_0, iter_19_1 in pairs(arg_19_0.data) do
		var_19_1 = var_19_1 + 1

		if arg_19_1:GetFilterData(iter_19_0) and iter_19_1 == arg_19_1:GetFilterData(iter_19_0) then
			-- block empty
		else
			var_19_0 = false
		end
	end

	for iter_19_2, iter_19_3 in pairs(arg_19_1.data) do
		if iter_19_3 > 0 then
			var_19_2 = var_19_2 + 1
		end
	end

	if var_19_1 == 0 and var_19_2 ~= 0 then
		var_19_0 = false
	end

	return var_19_0
end

return var_0_0
