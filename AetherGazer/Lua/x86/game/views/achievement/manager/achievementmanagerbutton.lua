local var_0_0 = class("AchievementManagerButton", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.achievementType_ = arg_1_2

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.button_, nil, function()
		AchievementData:SetScrollRecord(false)
		arg_2_0:Go("/achievementInfo", {
			achievementType = arg_2_0.achievementType_
		})
	end)
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.imageProcess_.fillAmount = AchievementData:GetFinishAchievementCnt(arg_4_0.achievementType_) / AchievementData:GetAchievementCnt(arg_4_0.achievementType_)

	SetActive(arg_4_0.goTips_, manager.redPoint:getTipValue(string.format("%s_%s", RedPointConst.ACHIEVEMENT, arg_4_0.achievementType_)) > 0)
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
end

return var_0_0
