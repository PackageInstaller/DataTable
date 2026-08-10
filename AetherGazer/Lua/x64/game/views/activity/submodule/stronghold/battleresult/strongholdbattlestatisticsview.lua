local var_0_0 = class("StrongholdBattleStatisticsView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/CooperationBattleResult/CooperationStatisticsUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.staticHeroItemList = {}

	for iter_4_0 = 1, 3 do
		local var_4_0 = arg_4_0["m_hero" .. iter_4_0]
		local var_4_1 = StrongholdBattleStatisticsHeroItem.New(var_4_0)

		table.insert(arg_4_0.staticHeroItemList, var_4_1)
	end
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.buttonShare_, nil, function()
		manager.share:Share(function()
			SetActive(arg_5_0.goShare_, false)
			SetActive(arg_5_0.goBack_, false)
		end, function()
			SetActive(arg_5_0.goShare_, true)
			SetActive(arg_5_0.goBack_, true)
		end)
	end)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.stageData = arg_10_0.params_.stageData

	local var_10_0, var_10_1, var_10_2 = BattleTools.GetBattleStatisticsData()
	local var_10_3, var_10_4 = arg_10_0.stageData:GetIsCooperation()

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.staticHeroItemList) do
		local var_10_5 = var_10_4[iter_10_0]

		iter_10_1:SetData(var_10_5, var_10_0[iter_10_0], var_10_2)
	end

	arg_10_0.battleTimeText_.text = arg_10_0.params_.battleTime
end

function var_0_0.OnExit(arg_11_0)
	return
end

function var_0_0.Dispose(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.staticHeroItemList) do
		iter_12_1:Dispose()
	end

	arg_12_0.staticHeroItemList = {}

	var_0_0.super.Dispose(arg_12_0)
end

function var_0_0.OnCooperationRoomInit(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.staticHeroItemList) do
		iter_13_1:RefreshState()
	end
end

function var_0_0.OnCooperationRoomUpdate(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.staticHeroItemList) do
		iter_14_1:RefreshState()
	end
end

return var_0_0
