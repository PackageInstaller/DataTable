local var_0_0 = class("OsirisRecallView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/BranchlineUI/OsirisRecallUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.list = LuaList.New(handler(arg_5_0, arg_5_0.IndexItem), arg_5_0.m_list, OsirisRecallItem)
end

function var_0_0.AddUIListener(arg_6_0)
	return
end

function var_0_0.OnTop(arg_7_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.data = ActivityStoryCollect[ActivityConst.OSIRIS_ACTIVITY] and ActivityStoryCollect[ActivityConst.OSIRIS_ACTIVITY].story_id or {}

	arg_8_0.list:StartScroll(#arg_8_0.data)
end

function var_0_0.OnExit(arg_9_0)
	manager.windowBar:HideBar()
end

function var_0_0.IndexItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.data[arg_10_1]

	arg_10_2:SetData(var_10_0)
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.list:Dispose()
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
