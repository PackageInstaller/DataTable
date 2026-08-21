local var_0_0 = class("GuildActivityRankView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/GuildActivityUI/GuildActivityRankUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, GuildActivityRaceRankItem)
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.IndexItem(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2:RefreshUI(arg_7_0.rankList_[arg_7_1])
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0.rankList_ = GuildActivityData:GetRankList()

	arg_9_0.scrollHelper_:StartScroll(#arg_9_0.rankList_)
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
