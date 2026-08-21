local var_0_0 = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
local var_0_1 = class("AnniversaryCelebrationGiftViewBase", var_0_0)

function var_0_1.Init(arg_1_0)
	var_0_1.super.Init(arg_1_0)

	arg_1_0.openController = arg_1_0.controllers_:GetController("open")
	arg_1_0.quests = CommonActivityTaskListModule.New(arg_1_0.questListGo_)
end

function var_0_1.OnEnter(arg_2_0)
	var_0_1.super.OnEnter(arg_2_0)

	if arg_2_0.isAdvanceActivity_ then
		arg_2_0.openController:SetSelectedState("false")
	else
		arg_2_0.openController:SetSelectedState("true")
	end
end

function var_0_1.OnExit(arg_3_0)
	var_0_1.super.OnExit(arg_3_0)
end

function var_0_1.Dispose(arg_4_0)
	arg_4_0.quests:Dispose()
	var_0_1.super.Dispose(arg_4_0)
end

function var_0_1.GetSubTaskActivity(arg_5_0)
	return ActivityTools.GetAllTaskSubActivityID(arg_5_0.activityID_)[1]
end

function var_0_1.Show(arg_6_0, arg_6_1)
	var_0_1.super.Show(arg_6_0, arg_6_1)

	if arg_6_0.isAdvanceActivity_ then
		return
	end

	if arg_6_1 then
		arg_6_0.quests:OnEnter()
		arg_6_0.quests:RenderView(arg_6_0:GetSubTaskActivity())
	else
		arg_6_0.quests:OnExit()
	end
end

function var_0_1.HideRedPoint(arg_7_0)
	if arg_7_0.isAdvanceActivity_ then
		return
	end

	local var_7_0 = arg_7_0:GetSubTaskActivity()
	local var_7_1 = "ANNIVERSARY_CELEBRATION_GIFT_REMIND_TASK_AVAILABLE" .. var_7_0

	manager.redPoint:setTip(var_7_1, 0)
end

return var_0_1
