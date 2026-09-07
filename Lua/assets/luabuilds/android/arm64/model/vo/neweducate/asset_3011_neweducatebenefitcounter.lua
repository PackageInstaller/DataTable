local NewEducateBenefitCounter = class("NewEducateBenefitCounter")

NewEducateBenefitCounter.TYPE = {
	GAIN = 1,
	COST = 2
}

function NewEducateBenefitCounter:Ctor(arg_1_1)
	self.group = arg_1_1.group

	self:InitData(arg_1_1.change)

	return
end

function NewEducateBenefitCounter:InitData(arg_2_1)
	self.data = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		self.data[iter_2_1.drop_type] = self.data[iter_2_1.drop_type] or {}
		self.data[iter_2_1.drop_type][iter_2_1.drop_id] = {
			[NewEducateBenefitCounter.TYPE.GAIN] = iter_2_1.positive_counter,
			[NewEducateBenefitCounter.TYPE.COST] = iter_2_1.negative_counter
		}
	end

	return
end

function NewEducateBenefitCounter:UpdateData(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		self.data[iter_3_1.drop_type] = self.data[iter_3_1.drop_type] or {}

		local var_3_0 = self.data[iter_3_1.drop_type][iter_3_1.drop_id]
		local var_3_1 = {}

		var_3_1[NewEducateBenefitCounter.TYPE.GAIN] = ((self.data[iter_3_1.drop_type][iter_3_1.drop_id] or nil) and (var_3_0[NewEducateBenefitCounter.TYPE.GAIN] or 0)) + iter_3_1.positive_counter
		var_3_1[NewEducateBenefitCounter.TYPE.COST] = ((var_3_0 or nil) and (var_3_0[NewEducateBenefitCounter.TYPE.COST] or 0)) + iter_3_1.negative_counter
		self.data[iter_3_1.drop_type][iter_3_1.drop_id] = var_3_1
	end

	return
end

function NewEducateBenefitCounter:GetValue(arg_4_1, arg_4_2, arg_4_3)
	if not self.data[arg_4_2] or not self.data[arg_4_2][arg_4_3] then
		return 0
	end

	return self.data[arg_4_2][arg_4_3][arg_4_1]
end

return NewEducateBenefitCounter
