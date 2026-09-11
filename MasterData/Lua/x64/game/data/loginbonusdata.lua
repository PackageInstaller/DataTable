local var_0_0 = singletonClass("LoginBonusData")

function var_0_0.Init(arg_1_0)
	arg_1_0.finishIndexList_ = {}
	arg_1_0.isFinish_ = false
end

function var_0_0:InitBonusData(arg_2_1)
	self.finishIndexList_ = arg_2_1.stage_list
	self.isFinish_ = not not (self.finishIndexList_ and #self.finishIndexList_ > 0)
end

function var_0_0:UpdateIndexData(arg_3_1)
	self.finishIndexList_ = {}

	if arg_3_1 and arg_3_1 > 0 then
		for iter_3_0 = 1, arg_3_1 do
			table.insert(self.finishIndexList_, iter_3_0)
		end
	end
end

function var_0_0:GetIsFinish()
	return self.isFinish_
end

function var_0_0:GetCurIndex()
	if self.finishIndexList_ and #self.finishIndexList_ > 0 then
		if #self.finishIndexList_ == 1 then
			return 3
		elseif #self.finishIndexList_ == 2 then
			return 5
		end
	else
		return 1
	end

	return 5
end

return var_0_0
