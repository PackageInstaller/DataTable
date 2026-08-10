local var_0_0 = class("ActivityNewWarChessRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	if arg_1_0.params_.mainActivityID == ActivityConst.ACTIVITY_NEWWARCHESS_2_6 then
		return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionNewWarChessRewardUI"
	elseif arg_1_0.params_.mainActivityID == ActivityConst.ACTIVITY_2_10_NEWWARCHESS then
		return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionUI_2_10NewWarChessRewardUI"
	end
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
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

	arg_5_0.uiList_ = LuaList.New(handler(arg_5_0, arg_5_0.indexItem), arg_5_0.uilistGo_, ActivityNewWarChessRewardItem)
end

function var_0_0.indexItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_0.activityIds_[arg_6_1])
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.bgBtn_, nil, function()
		arg_7_0:Back()
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.mainActivityID_ = arg_9_0.params_.mainActivityID
	arg_9_0.activityIds_ = arg_9_0.params_.activityIDList

	local var_9_0 = arg_9_0:GetCurScrollIndex()

	arg_9_0.uiList_:StartScroll(#arg_9_0.activityIds_, var_9_0)
end

function var_0_0.GetCurScrollIndex(arg_10_0)
	local var_10_0 = 1

	for iter_10_0, iter_10_1 in pairs(arg_10_0.activityIds_) do
		local var_10_1 = NewWarChessLevelCfg.get_id_list_by_activity[iter_10_1][1]
		local var_10_2 = NewWarChessLevelCfg[var_10_1].explore
		local var_10_3 = NewWarChessData:GetExploreValue(var_10_1)

		for iter_10_2, iter_10_3 in pairs(var_10_2) do
			if iter_10_3 <= var_10_3 and not NewWarChessData:GetRewardIsGet(var_10_1, iter_10_3) then
				var_10_0 = iter_10_0

				return var_10_0
			end
		end
	end

	return var_10_0
end

function var_0_0.Dispose(arg_11_0)
	if arg_11_0.uiList_ then
		arg_11_0.uiList_:Dispose()

		arg_11_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
