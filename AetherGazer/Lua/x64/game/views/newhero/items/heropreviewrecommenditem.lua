local var_0_0 = class("HeroPreviewReCommendItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0.uiList_ = LuaList.New(handler(arg_2_0, arg_2_0.indexItem), arg_2_0.uiListGo_, HeroPreviewReCommendItemItem)
end

function var_0_0.indexItem(arg_3_0, arg_3_1, arg_3_2)
	arg_3_2:RefreshData(arg_3_0.cfg, arg_3_1, arg_3_0.curHeroID_)
end

function var_0_0.RefreshData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:Show(true)

	arg_4_0.curHeroID_ = arg_4_2
	arg_4_0.cfg = RecommandTeamCfg[arg_4_1]

	arg_4_0.uiList_:StartScroll(3)
end

function var_0_0.Show(arg_5_0, arg_5_1)
	SetActive(arg_5_0.gameObject_, arg_5_1)
end

function var_0_0.Dispose(arg_6_0)
	if arg_6_0.uiList_ then
		arg_6_0.uiList_:Dispose()

		arg_6_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
