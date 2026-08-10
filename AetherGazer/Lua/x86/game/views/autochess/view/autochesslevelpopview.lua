local var_0_0 = class("AutoChessLevelPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Xihe/Activity_Xihe_RankPopUI"
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

	arg_4_0.levelList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.levelListGo_, AutoChessLevelPopItemView)
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.IndexItem(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2:SetData(arg_7_0.groupedRankIdList_[arg_7_1], arg_7_0.groupedRankIdList_[arg_7_1 + 1], arg_7_0.totalScore_)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.totalScore_ = AutoChessCardData:GetRankScore()

	local var_8_0 = clone(AutoChessRankCfg.all)

	table.remove(var_8_0, 1)

	arg_8_0.groupedRankIdList_ = {}

	for iter_8_0 = 1, #var_8_0, 3 do
		local var_8_1 = {}

		for iter_8_1 = iter_8_0, math.min(iter_8_0 + 2, #var_8_0) do
			table.insert(var_8_1, var_8_0[iter_8_1])
		end

		table.insert(arg_8_0.groupedRankIdList_, var_8_1)
	end

	arg_8_0.levelList_:StartScroll(#arg_8_0.groupedRankIdList_)
end

function var_0_0.Dispose(arg_9_0)
	if arg_9_0.levelList_ then
		arg_9_0.levelList_:Dispose()
	end

	arg_9_0.levelList_ = {}

	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
