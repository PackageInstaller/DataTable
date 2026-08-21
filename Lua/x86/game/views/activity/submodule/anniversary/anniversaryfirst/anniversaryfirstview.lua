ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("AnniversaryFirstView", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return "UI/VersionUI/XuHeng1stUI/XH1stYearsHomeUI/XH1stYearsHomeUI"
end

function var_0_0.Init(arg_2_0)
	var_0_0.super.Init(arg_2_0)

	arg_2_0.anniversaryGiftView_ = AnniversaryGiftView.New(arg_2_0.giftGo_)
	arg_2_0.taskUpdateHandler_ = handler(arg_2_0, arg_2_0.TaskUpdate)
	arg_2_0.scrollHelper_ = LuaList.New(handler(arg_2_0, arg_2_0.RefreshItem), arg_2_0.uiList_, AnniversaryTaskItem)
end

function var_0_0.OnEnter(arg_3_0)
	var_0_0.super.OnEnter(arg_3_0)
	arg_3_0.anniversaryGiftView_:OnEnter()
	manager.notify:RegistListener(OSIRIS_TASK_UPDATE, arg_3_0.taskUpdateHandler_)
end

function var_0_0.OnExit(arg_4_0)
	var_0_0.super.OnExit(arg_4_0)
	arg_4_0.anniversaryGiftView_:OnExit()
	manager.notify:RemoveListener(OSIRIS_TASK_UPDATE, arg_4_0.taskUpdateHandler_)
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0.taskUpdateHandler_ = nil

	arg_5_0.scrollHelper_:Dispose()
	arg_5_0.anniversaryGiftView_:Dispose()

	arg_5_0.anniversaryGiftView_ = nil

	var_0_0.super.Dispose(arg_5_0)
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.infoButton_, nil, function()
		local var_7_0 = GetTips("ANNIVERSARY_INFO")

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ANNIVERSARY_INFO",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = var_7_0
		})
	end)
end

function var_0_0.Show(arg_8_0, arg_8_1)
	var_0_0.super.Show(arg_8_0, arg_8_1)

	if arg_8_1 then
		arg_8_0.scrollHelper_:StartScroll(#TaskData2:GetActivityTaskSortList(ActivityConst.ACTIVITY_2_0_ANNIVERSARY_NORMAL_TASK))
	end
end

function var_0_0.TaskUpdate(arg_9_0)
	arg_9_0.scrollHelper_:StartScroll(#TaskData2:GetActivityTaskSortList(ActivityConst.ACTIVITY_2_0_ANNIVERSARY_NORMAL_TASK))
	arg_9_0.anniversaryGiftView_:UpdateItem()
end

function var_0_0.RefreshItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = TaskData2:GetActivityTaskSortList(ActivityConst.ACTIVITY_2_0_ANNIVERSARY_NORMAL_TASK)[arg_10_1].id

	arg_10_2:SetData(var_10_0)
end

return var_0_0
