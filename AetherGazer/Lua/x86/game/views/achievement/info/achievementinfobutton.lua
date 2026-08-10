local var_0_0 = class("AchievementInfoButton", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.achievementType_ = arg_1_2

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "toggle")
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.btn_, nil, function()
		AchievementData:SetScrollRecord(false)
		arg_2_0:Go("/achievementInfo", {
			achievementType = arg_2_0.achievementType_
		})
	end)
end

function var_0_0.RefreshSelectType(arg_4_0, arg_4_1)
	if arg_4_0.achievementType_ == arg_4_1 then
		arg_4_0.controller_:SetSelectedState("on")
	else
		arg_4_0.controller_:SetSelectedState("off")
	end
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
end

return var_0_0
