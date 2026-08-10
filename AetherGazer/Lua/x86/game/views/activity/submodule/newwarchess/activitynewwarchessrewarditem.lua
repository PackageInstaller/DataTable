local var_0_0 = class("ActivityNewWarChessRewardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.uiList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.m_list, ActivityNewWarChessRewardItemItem)
end

function var_0_0.IndexItem(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:SetData(arg_4_1, arg_4_0.levelCfg_.id_level, arg_4_0.activityId_, arg_4_0.levelCfg_.explore[arg_4_1])
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.activityId_ = arg_5_1
	arg_5_0.levelCfg_ = NewWarChessLevelCfg[NewWarChessLevelCfg.get_id_list_by_activity[arg_5_0.activityId_][1]]
	arg_5_0.m_title.text = arg_5_0.levelCfg_.name_level

	arg_5_0.uiList_:StartScroll(#arg_5_0.levelCfg_.explore)
end

function var_0_0.UpdateView(arg_6_0)
	return
end

function var_0_0.Dispose(arg_7_0)
	if arg_7_0.uiList_ then
		arg_7_0.uiList_:Dispose()

		arg_7_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
