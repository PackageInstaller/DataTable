local var_0_0 = import("game.data.Filter.FilterTemplate")
local var_0_1 = singletonClass("CommonFilterData")

function var_0_1.Init(arg_1_0)
	arg_1_0.data = {}
end

function var_0_1.Clear(arg_2_0)
	arg_2_0.data = {}
end

function var_0_1.GetFilter(arg_3_0, arg_3_1)
	if not arg_3_0.data[arg_3_1] then
		arg_3_0.data[arg_3_1] = var_0_0.New(arg_3_1)
	end

	return arg_3_0.data[arg_3_1]
end

function var_0_1.ClearGroup(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:GetFilter(arg_4_1):ClearGroup(arg_4_2)
end

function var_0_1.ClearFilter(arg_5_0, arg_5_1)
	arg_5_0:GetFilter(arg_5_1):Clear()
end

function var_0_1.IsAll(arg_6_0, arg_6_1)
	if arg_6_0.data[arg_6_1] then
		return arg_6_0:GetFilter(arg_6_1):IsAll()
	else
		return true
	end
end

function var_0_1.HasFlag(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	return arg_7_0:GetFilter(arg_7_1):HasFlag(arg_7_2, arg_7_3)
end

function var_0_1.LessEqualFlag(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	return arg_8_0:GetFilter(arg_8_1):LessEqualFlag(arg_8_2, arg_8_3)
end

function var_0_1.SelectTag(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	return arg_9_0:GetFilter(arg_9_1):SelectTag(arg_9_2, arg_9_3)
end

function var_0_1.DeSelectTag(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	return arg_10_0:GetFilter(arg_10_1):DeSelectTag(arg_10_2, arg_10_3)
end

function var_0_1.HasIndexFlag(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	return arg_11_0:GetFilter(arg_11_1):HasIndexFlag(arg_11_2, arg_11_3)
end

function var_0_1.HasIndexFlagList(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	return arg_12_0:GetFilter(arg_12_1):HasIndexFlagList(arg_12_2, arg_12_3)
end

function var_0_1.AllIndexFlagPast(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	return arg_13_0:GetFilter(arg_13_1):AllIndexFlagPast(arg_13_2, arg_13_3)
end

function var_0_1.SpecificHasFlag(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	return arg_14_0:GetFilter(arg_14_1):SpecificHasFlag(arg_14_2, arg_14_3)
end

function var_0_1.GetGroupSelectedTags(arg_15_0, arg_15_1, arg_15_2)
	return arg_15_0:GetFilter(arg_15_1):GetGroupSelectedTags(arg_15_2)
end

function var_0_1.AtLeastOneChoose(arg_16_0, arg_16_1)
	return arg_16_0:GetFilter(arg_16_1):AtLeastOneChoose()
end

function var_0_1.AtLeastOneChooseGroup(arg_17_0, arg_17_1, arg_17_2)
	return arg_17_0:GetFilter(arg_17_1):AtLeastOneChooseGroup(arg_17_2)
end

function var_0_1.GetFilterDataCopy(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:GetFilter(arg_18_1)

	return deepClone(var_18_0)
end

function var_0_1.ApplyFilterCopy(arg_19_0, arg_19_1)
	if arg_19_1 then
		arg_19_0.data[arg_19_1.filterId] = arg_19_1
	end
end

return var_0_1
