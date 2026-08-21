local var_0_0 = class("SequentialBattleBossInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	local var_1_0 = SequentialBattleChapterCfg[arg_1_0.params_.activityID].main_id
	local var_1_1 = SequentialBattleUICfg.get_id_list_by_main_activity_id[var_1_0][1]

	return SequentialBattleUICfg[var_1_1].boss_info_prefab
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.bossUIList_ = LuaList.New(handler(arg_3_0, arg_3_0.RefreshItem), arg_3_0.uiList_, SequentialBattleBossInfoItem)

	arg_3_0.bossUIList_:SetPageChangeHandler(handler(arg_3_0, arg_3_0.OnPageChange))
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.activityID_ = arg_4_0.params_.activityID
	arg_4_0.bossIndex_ = arg_4_0.params_.bossIndex
	arg_4_0.pageIndex_ = arg_4_0.bossIndex_
	arg_4_0.bossStageList_ = {}

	local var_4_0 = SequentialBattleChapterCfg[arg_4_0.activityID_].boss_list

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		if iter_4_1 ~= 0 then
			table.insert(arg_4_0.bossStageList_, iter_4_1)
		end
	end

	arg_4_0.bossUIList_:StartScroll(#arg_4_0.bossStageList_, arg_4_0.pageIndex_, true, false)
	arg_4_0:RefreshBtn()
end

function var_0_0.OnExti(arg_5_0)
	return
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
	arg_6_0.bossUIList_:Dispose()

	arg_6_0.bossUIList_ = nil
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.closeBtn_, nil, function()
		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.leftBtn_, nil, function()
		if arg_7_0.pageIndex_ > 1 then
			arg_7_0.pageIndex_ = arg_7_0.pageIndex_ - 1

			arg_7_0.bossUIList_:SwitchToPage(arg_7_0.pageIndex_)
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.rightBtn_, nil, function()
		if arg_7_0.pageIndex_ < #arg_7_0.bossStageList_ then
			arg_7_0.pageIndex_ = arg_7_0.pageIndex_ + 1

			arg_7_0.bossUIList_:SwitchToPage(arg_7_0.pageIndex_)
		end
	end)
end

function var_0_0.RefreshItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.bossStageList_[arg_11_1]
	local var_11_1 = table.keyof(SequentialBattleChapterCfg[arg_11_0.activityID_].boss_list, var_11_0)

	arg_11_2:SetBossID(var_11_0, var_11_1)
end

function var_0_0.OnPageChange(arg_12_0, arg_12_1)
	arg_12_0.pageIndex_ = arg_12_1

	arg_12_0:RefreshBtn()
end

function var_0_0.RefreshBtn(arg_13_0)
	SetActive(arg_13_0.leftBtn_.gameObject, arg_13_0.pageIndex_ > 1)
	SetActive(arg_13_0.rightBtn_.gameObject, arg_13_0.pageIndex_ < #arg_13_0.bossStageList_)
end

return var_0_0
