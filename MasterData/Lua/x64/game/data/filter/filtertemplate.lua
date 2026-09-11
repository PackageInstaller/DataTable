local FilterTemplate = class("FilterTemplate")
local var_0_1, var_0_2 = pcall(require, "bit")

if not var_0_1 then
	local var_0_3

	var_0_3, var_0_2 = pcall(require, "bit32")
end

function FilterTemplate:Ctor(arg_1_1)
	self.filterId = arg_1_1
	self.data = {}
end

function FilterTemplate:Clear()
	self.data = {}
end

function FilterTemplate:ClearGroup(arg_3_1)
	if self.data[arg_3_1] then
		self.data[arg_3_1] = nil
	end
end

function FilterTemplate:IsAll(arg_4_1)
	for iter_4_0, iter_4_1 in pairs(self.data) do
		if iter_4_1 > 0 then
			return false
		end
	end

	return true
end

function FilterTemplate:LShiftOne(arg_5_1)
	return var_0_2.lshift(1, arg_5_1)
end

function FilterTemplate:HasFlag(arg_6_1, arg_6_2)
	local var_6_0 = self:GetFilterData(arg_6_1) or 0

	if CommonFilterConst.GetGroupCfg(arg_6_1).mode == Filter_Group_Mode.SingleMode and var_6_0 == 0 and arg_6_2 == 1 then
		return true
	end

	return var_0_2.band(var_6_0, arg_6_2) ~= 0
end

function FilterTemplate:LessEqualFlag(arg_7_1, arg_7_2)
	return var_0_2.band(self:GetFilterData(arg_7_1) or 0, arg_7_2) == arg_7_2
end

function FilterTemplate:SelectTag(arg_8_1, arg_8_2)
	local var_8_0 = self:GetFilterData(arg_8_1) or 0
	local var_8_1 = var_0_2.lshift(1, (CommonFilterConst.GetTagIndexAtGroup(arg_8_1, arg_8_2)))
	local var_8_2 = var_8_0

	var_8_2 = CommonFilterConst.GetGroupCfg(arg_8_1).mode == Filter_Group_Mode.SingleMode and var_8_1 or var_0_2.bor(var_8_0, var_8_1)

	self:SetFilterGroupMask(arg_8_1, var_8_2)

	return var_8_2
end

function FilterTemplate:DeSelectTag(arg_9_1, arg_9_2)
	local var_9_0 = self:GetFilterData(arg_9_1) or 0
	local var_9_2 = CommonFilterConst.GetGroupCfg(arg_9_1).mode == Filter_Group_Mode.SingleMode and 0 or var_0_2.bxor(var_9_0, (var_0_2.lshift(1, (CommonFilterConst.GetTagIndexAtGroup(arg_9_1, arg_9_2)))))

	self:SetFilterGroupMask(arg_9_1, var_9_0)

	return var_9_2
end

function FilterTemplate:HasIndexFlag(arg_10_1, arg_10_2)
	return self:HasFlag(arg_10_1, var_0_2.lshift(1, (CommonFilterConst.GetTagIndexAtGroup(arg_10_1, arg_10_2))))
end

function FilterTemplate:HasIndexFlagList(arg_11_1, arg_11_2)
	arg_11_2 = arg_11_2 or {}

	local var_11_0 = 0

	for iter_11_0, iter_11_1 in ipairs(arg_11_2) do
		var_11_0 = var_0_2.bor(var_11_0, var_0_2.lshift(1, (CommonFilterConst.GetTagIndexAtGroup(arg_11_1, iter_11_1))))
	end

	return self:HasFlag(arg_11_1, var_11_0)
end

function FilterTemplate:AllIndexFlagPast(arg_12_1, arg_12_2)
	arg_12_2 = arg_12_2 or {}

	local var_12_0 = 0

	for iter_12_0, iter_12_1 in ipairs(arg_12_2) do
		var_12_0 = var_0_2.bor(var_12_0, var_0_2.lshift(1, (CommonFilterConst.GetTagIndexAtGroup(arg_12_1, iter_12_1))))
	end

	return self:LessEqualFlag(arg_12_1, var_12_0)
end

function FilterTemplate:SpecificHasFlag(arg_13_1, arg_13_2)
	if (self:GetFilterData(arg_13_1) or 0) == 0 then
		return true
	end

	arg_13_2 = arg_13_2 or {}

	local var_13_0 = 0

	for iter_13_0, iter_13_1 in ipairs(arg_13_2) do
		var_13_0 = var_0_2.bor(var_13_0, var_0_2.lshift(1, (CommonFilterConst.GetTagIndexAtGroup(arg_13_1, iter_13_1))))
	end

	return self:HasFlag(arg_13_1, var_13_0)
end

function FilterTemplate:GetGroupSelectedTags(arg_14_1)
	local var_14_0 = {}
	local var_14_1 = CommonFilterConst.GetGroupCfg(arg_14_1)

	if var_14_1 then
		for iter_14_0, iter_14_1 in ipairs(var_14_1.tags) do
			if self:HasIndexFlag(arg_14_1, iter_14_1) then
				table.insert(var_14_0, iter_14_1)
			end
		end
	end

	return var_14_0
end

function FilterTemplate:AtLeastOneChoose()
	for iter_15_0, iter_15_1 in ipairs((CommonFilterConst.GetFilterGroups(self.filterId))) do
		local var_15_0 = self:GetFilterData(iter_15_1)

		if var_15_0 and var_15_0 > 0 then
			return true
		end
	end

	return false
end

function FilterTemplate:AtLeastOneChooseGroup(arg_16_1)
	local var_16_0 = self:GetFilterData(arg_16_1)

	if var_16_0 and var_16_0 > 0 then
		return true
	end

	return false
end

function FilterTemplate:GetFilterData(arg_17_1)
	return self.data[arg_17_1]
end

function FilterTemplate:SetFilterGroupMask(arg_18_1, arg_18_2)
	self.data[arg_18_1] = arg_18_2
end

function FilterTemplate:CheckIsSame(arg_19_1)
	local var_19_0 = true
	local var_19_1 = 0
	local var_19_2 = 0

	for iter_19_0, iter_19_1 in pairs(self.data) do
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

	return (var_19_1 == 0 and var_19_2 ~= 0 or nil) and false
end

return FilterTemplate
