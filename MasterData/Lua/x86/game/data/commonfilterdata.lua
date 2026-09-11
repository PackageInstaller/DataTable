local FilterTemplate = import("game.data.Filter.FilterTemplate")
local var_0_1 = singletonClass("CommonFilterData")

function var_0_1.Init(arg_1_0)
	arg_1_0.data = {}
end

function var_0_1.Clear(arg_2_0)
	arg_2_0.data = {}
end

function var_0_1:GetFilter(arg_3_1)
	self.data[arg_3_1] = self.data[arg_3_1] or FilterTemplate.New(arg_3_1)

	return self.data[arg_3_1]
end

function var_0_1:ClearGroup(arg_4_1, arg_4_2)
	self:GetFilter(arg_4_1):ClearGroup(arg_4_2)
end

function var_0_1:ClearFilter(arg_5_1)
	self:GetFilter(arg_5_1):Clear()
end

function var_0_1:IsAll(arg_6_1)
	if self.data[arg_6_1] then
		return self:GetFilter(arg_6_1):IsAll()
	else
		return true
	end
end

function var_0_1:HasFlag(arg_7_1, arg_7_2, arg_7_3)
	return self:GetFilter(arg_7_1):HasFlag(arg_7_2, arg_7_3)
end

function var_0_1:LessEqualFlag(arg_8_1, arg_8_2, arg_8_3)
	return self:GetFilter(arg_8_1):LessEqualFlag(arg_8_2, arg_8_3)
end

function var_0_1:SelectTag(arg_9_1, arg_9_2, arg_9_3)
	return self:GetFilter(arg_9_1):SelectTag(arg_9_2, arg_9_3)
end

function var_0_1:DeSelectTag(arg_10_1, arg_10_2, arg_10_3)
	return self:GetFilter(arg_10_1):DeSelectTag(arg_10_2, arg_10_3)
end

function var_0_1:HasIndexFlag(arg_11_1, arg_11_2, arg_11_3)
	return self:GetFilter(arg_11_1):HasIndexFlag(arg_11_2, arg_11_3)
end

function var_0_1:HasIndexFlagList(arg_12_1, arg_12_2, arg_12_3)
	return self:GetFilter(arg_12_1):HasIndexFlagList(arg_12_2, arg_12_3)
end

function var_0_1:AllIndexFlagPast(arg_13_1, arg_13_2, arg_13_3)
	return self:GetFilter(arg_13_1):AllIndexFlagPast(arg_13_2, arg_13_3)
end

function var_0_1:SpecificHasFlag(arg_14_1, arg_14_2, arg_14_3)
	return self:GetFilter(arg_14_1):SpecificHasFlag(arg_14_2, arg_14_3)
end

function var_0_1:GetGroupSelectedTags(arg_15_1, arg_15_2)
	return self:GetFilter(arg_15_1):GetGroupSelectedTags(arg_15_2)
end

function var_0_1:AtLeastOneChoose(arg_16_1)
	return self:GetFilter(arg_16_1):AtLeastOneChoose()
end

function var_0_1:AtLeastOneChooseGroup(arg_17_1, arg_17_2)
	return self:GetFilter(arg_17_1):AtLeastOneChooseGroup(arg_17_2)
end

function var_0_1:GetFilterDataCopy(arg_18_1)
	return deepClone((self:GetFilter(arg_18_1)))
end

function var_0_1:ApplyFilterCopy(arg_19_1)
	if arg_19_1 then
		self.data[arg_19_1.filterId] = arg_19_1
	end
end

return var_0_1
