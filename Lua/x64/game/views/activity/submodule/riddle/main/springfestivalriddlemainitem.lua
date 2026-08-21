local var_0_0 = class("SpringFestivalRiddleMainItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.activityID_ = arg_1_2
	arg_1_0.questionID_ = arg_1_3

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "riddlesBtn")
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		JumpTools.OpenPageByJump("springFestivalRiddleQuestion", {
			activityID = arg_3_0.activityID_,
			questionID = arg_3_0.questionID_
		})
	end)
end

function var_0_0.RefreshState(arg_5_0, arg_5_1)
	local var_5_0 = SpringFestivalRiddleData:GetQuestionAnswerList(arg_5_0.activityID_, arg_5_0.questionID_)

	if table.keyof(var_5_0, ActivitySpringFestivalRiddleCfg[arg_5_0.questionID_].correct_answer) then
		arg_5_0.controller_:SetSelectedState("finish")
	elseif arg_5_1 == false then
		arg_5_0.controller_:SetSelectedState("normal")
	else
		arg_5_0.controller_:SetSelectedState("receive")
	end
end

return var_0_0
