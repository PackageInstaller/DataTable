local var_0_0 = class("SummerPlotItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "Item")
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.button_, nil, function()
		if not arg_2_0.isLock_ then
			WarChessAction.SetActivityChessPlotRedPoint(ActivityConst.THEME.SUMMER, arg_2_0.storyID_)
			manager.story:StartStoryById(arg_2_0.storyID_, function()
				return
			end)
		end
	end)
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
	manager.redPoint:unbindUIandKey(arg_5_0.transform_, string.format("%s_%s_%s", RedPointConst.ACTIVITY_SIDE_STORY, ActivityConst.THEME.SUMMER, arg_5_0.storyID_))
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_3 < arg_6_2

	if var_6_0 then
		arg_6_0.controller_:SetSelectedState("lock")

		arg_6_0.nameText_.text = string.format(GetTips("EXPLORE_UNLOCK"), arg_6_2)
	else
		arg_6_0.controller_:SetSelectedState("false")

		arg_6_0.nameText_.text = GetI18NText(StoryCfg[arg_6_1].name)
	end

	arg_6_0.storyID_ = arg_6_1
	arg_6_0.isLock_ = var_6_0

	manager.redPoint:bindUIandKey(arg_6_0.transform_, string.format("%s_%s_%s", RedPointConst.ACTIVITY_SIDE_STORY, ActivityConst.THEME.SUMMER, arg_6_0.storyID_))
end

return var_0_0
