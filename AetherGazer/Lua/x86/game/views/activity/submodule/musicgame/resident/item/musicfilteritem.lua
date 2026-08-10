local var_0_0 = class("MusicFilterItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.selectController_ = arg_3_0.controllerEx_:GetController("select")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.clickBtn_, nil, function()
		manager.notify:Invoke(MUSIC_FILTER_CLICK_ITEM, arg_4_0.filterKey, arg_4_0.filterIndex, not arg_4_0.isSelect)
	end)
end

function var_0_0.UpdateSelect(arg_6_0, arg_6_1)
	arg_6_0.isSelect = arg_6_1

	arg_6_0.selectController_:SetSelectedState(arg_6_1 and "select" or "normal")
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.filterIndex = arg_7_1
	arg_7_0.filterValue = arg_7_2
	arg_7_0.filterKey = arg_7_3

	if arg_7_3 == MusicConst.MusicFilterType.tagFilterKey then
		arg_7_0:UpdateTagUI()
	elseif arg_7_3 == MusicConst.MusicFilterType.verFilterKey then
		arg_7_0:UpdateVersionUI()
	end
end

function var_0_0.UpdateVersionUI(arg_8_0)
	local var_8_0 = MusicData:GetMusicTypeByTheme(arg_8_0.filterValue)
	local var_8_1 = MusicConst.MusicViewRoutesName[var_8_0].activityID
	local var_8_2 = ActivityCfg.get_id_list_by_sub_activity_list[var_8_1][1]

	arg_8_0.tagTxt_.text = ActivityCfg[var_8_2].remark
end

function var_0_0.UpdateTagUI(arg_9_0)
	arg_9_0.tagTxt_.text = GetTips(MusicConst.MusicTagTips[arg_9_0.filterValue])
end

function var_0_0.GetFilterValue(arg_10_0)
	return arg_10_0.filterValue
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
