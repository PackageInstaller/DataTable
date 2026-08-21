local var_0_0 = class("MusicBottomFilterItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.filterValue = arg_4_1

	if arg_4_2 == MusicConst.MusicFilterType.tagFilterKey then
		arg_4_0:UpdateTagUI()
	elseif arg_4_2 == MusicConst.MusicFilterType.verFilterKey then
		arg_4_0:UpdateVersionUI()
	end
end

function var_0_0.UpdateVersionUI(arg_5_0)
	local var_5_0 = MusicData:GetMusicTypeByTheme(arg_5_0.filterValue)
	local var_5_1 = MusicConst.MusicViewRoutesName[var_5_0].activityID
	local var_5_2 = ActivityCfg.get_id_list_by_sub_activity_list[var_5_1][1]

	arg_5_0.nameText_.text = ActivityCfg[var_5_2].remark
end

function var_0_0.UpdateTagUI(arg_6_0)
	arg_6_0.nameText_.text = GetTips(MusicConst.MusicTagTips[arg_6_0.filterValue])
end

function var_0_0.Show(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
