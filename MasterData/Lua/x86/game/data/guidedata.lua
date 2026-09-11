local var_0_0 = singletonClass("GuideData")

function var_0_0.Init(arg_1_0)
	arg_1_0.finishGuideID_ = {}
	arg_1_0.finishWeakGuideID_ = {}
end

function var_0_0:InitGuideData(arg_2_1)
	self.finishGuideID_ = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.mod_guide_list) do
		table.insert(self.finishGuideID_, iter_2_1)
	end
end

function var_0_0:InitWeakGuideData(arg_3_1)
	self.finishWeakGuideID_ = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.mod_guide_list) do
		table.insert(self.finishWeakGuideID_, iter_3_1)
	end
end

function var_0_0:IsFinish(arg_4_1, arg_4_2)
	if arg_4_2 and GuideBaseCfg[arg_4_1].is_repeat == 1 then
		return false
	else
		return table.keyof(self.finishGuideID_, arg_4_1) ~= nil
	end
end

function var_0_0:IsWeakGuideFinish(arg_5_1)
	return table.keyof(self.finishWeakGuideID_, arg_5_1) ~= nil
end

function var_0_0:FinishGuideID(arg_6_1)
	table.insert(self.finishGuideID_, arg_6_1)
end

function var_0_0:FinishWeakGuideID(arg_7_1)
	table.insert(self.finishWeakGuideID_, arg_7_1)
end

return var_0_0
