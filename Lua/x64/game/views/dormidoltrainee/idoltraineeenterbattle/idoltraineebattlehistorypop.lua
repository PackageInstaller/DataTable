local var_0_0 = class("IdolTraineeBattleHistoryPop", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/IdolTrainee/IdolBattleHistoryPopup"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.historyList_ = LuaList.New(handler(arg_4_0, arg_4_0.refreshItem), arg_4_0.questList_, IdolTraineeBattleHistoryItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.dataList = {}

	local var_7_0 = IdolTraineeData:GetHistoryBattleData()

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		table.insert(arg_7_0.dataList, iter_7_1)
	end

	CommonTools.UniversalSortEx(arg_7_0.dataList, {
		map = function(arg_8_0)
			return arg_8_0.startTime
		end
	})
	arg_7_0:RefreshView()
end

function var_0_0.RefreshView(arg_9_0)
	arg_9_0.historyList_:StartScroll(#arg_9_0.dataList)
end

function var_0_0.refreshItem(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2:RefreshUI(arg_10_0.dataList[arg_10_1])
end

function var_0_0.OnExit(arg_11_0)
	arg_11_0.dataList = nil
end

function var_0_0.Dispose(arg_12_0)
	if arg_12_0.historyList_ then
		arg_12_0.historyList_:Dispose()
	end

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
