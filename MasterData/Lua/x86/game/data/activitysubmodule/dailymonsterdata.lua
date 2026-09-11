local var_0_0 = singletonClass("DailyMonsterData")

function var_0_0:InitData(arg_1_1)
	self.activityId_ = arg_1_1.activity_id
	self.benefitActivityId_ = 343725

	self:InitOpenStage(arg_1_1.data)
end

function var_0_0:InitOpenStage(arg_2_1)
	self.openStage_ = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		self.openStage_[iter_2_1.stage_id] = {
			firstPass = iter_2_1.first_pass
		}
	end
end

function var_0_0:GetActivityId()
	return self.activityId_
end

function var_0_0:GetBenefitActivityId()
	return self.benefitActivityId_
end

function var_0_0:GetOpenStage()
	return self.openStage_
end

function var_0_0:GetOpenStageById(arg_6_1)
	return self.openStage_[arg_6_1]
end

function var_0_0:UpdateStagePass(arg_7_1)
	if self.openStage_[arg_7_1] then
		self.openStage_[arg_7_1].firstPass = 1
	end
end

function var_0_0.SetBattleType(arg_8_0, arg_8_1)
	arg_8_0.battleType_ = arg_8_1
end

function var_0_0:GetBattleType()
	return self.battleType_
end

return var_0_0
