SpringPreheatPrayBubbleView = import("game.views.activity.Submodule.springFestival.springPreheat.SpringPreheatPrayBubbleView")

local var_0_0 = class("SpringWelfarePrayBubbleView", SpringPreheatPrayBubbleView)

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)

	arg_1_0.signController_ = ControllerUtil.GetController(arg_1_0.transform_, "sign")
	arg_1_0.acquireController_ = ControllerUtil.GetController(arg_1_0.transform_, "acquire")
end

function var_0_0.SwitchController(arg_2_0, arg_2_1)
	if not arg_2_0.selectController_ or not arg_2_0.lockController_ or not arg_2_0.signController_ or not arg_2_0.acquireController_ then
		return
	end

	arg_2_0.lockController_:SetSelectedState("false")
	arg_2_0.selectController_:SetSelectedState("selected")

	if arg_2_1 == SPRING_WELFARE_DAY_STATE_TYPE.ACQUIRED then
		arg_2_0.acquireController_:SetSelectedState("acquired")
		arg_2_0.signController_:SetSelectedState("false")
	elseif arg_2_1 == SPRING_WELFARE_DAY_STATE_TYPE.NOT_ACQUIRE then
		arg_2_0.acquireController_:SetSelectedState("notready")
		arg_2_0.signController_:SetSelectedState("false")
	elseif arg_2_1 == SPRING_WELFARE_DAY_STATE_TYPE.NEED_SIGN then
		arg_2_0.acquireController_:SetSelectedState("ready")
		arg_2_0.signController_:SetSelectedState("true")
	elseif arg_2_1 == SPRING_WELFARE_DAY_STATE_TYPE.CAN_PRAY then
		arg_2_0.acquireController_:SetSelectedState("ready")
		arg_2_0.signController_:SetSelectedState("false")
	end
end

function var_0_0.GetDayState(arg_3_0)
	return (SpringWelfareData:GetDayState(arg_3_0.day_))
end

function var_0_0.GetPraySelectionList(arg_4_0)
	return SpringWelfareData:GetPraySelectionList(arg_4_0.day_)
end

return var_0_0
