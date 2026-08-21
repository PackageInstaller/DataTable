local var_0_0 = class("TowerGameRewardBlock", ReduxView)

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

	arg_3_0.list_ = LuaList.New(handler(arg_3_0, arg_3_0.RefreshItem), arg_3_0.listgo_, TowerGameRewardItem)
end

function var_0_0.RefreshItem(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:RefreshItem(arg_4_1, arg_4_0.levelid_)
end

function var_0_0.Refresh(arg_5_0, arg_5_1)
	arg_5_0.levelid_ = arg_5_1

	local var_5_0 = TowerGameCfg[arg_5_0.levelid_]

	arg_5_0.title_.text = GetI18NText(BattleTowerGameCfg[var_5_0.stage_id].name)

	arg_5_0.list_:StartScroll(#ActivityPointRewardCfg.get_id_list_by_activity_id[arg_5_0.levelid_])
end

function var_0_0.Dispose(arg_6_0)
	if arg_6_0.list_ then
		arg_6_0.list_:Dispose()

		arg_6_0.list_ = nil
	end
end

return var_0_0
