local var_0_0 = class("AutoChessBrahmaUpgradePopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_OsirisHorus/Activity_OsirisHorus_AutoChess/Activity_OsirisHorus_ObtainUpgradePopUI"
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

	arg_4_0.buffItemList_ = {}
	arg_4_0.buffItemCout_ = arg_4_0.buffContain_.childCount

	for iter_4_0 = 1, arg_4_0.buffItemCout_ do
		local var_4_0 = arg_4_0.buffContain_:GetChild(iter_4_0 - 1).gameObject
		local var_4_1 = AutoChessHeroUpgradePopItem.New(var_4_0)

		table.insert(arg_4_0.buffItemList_, var_4_1)
	end
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btnBack_, nil, function()
		AutoChessTools.PlayerCheesUpgrade(arg_5_0.params_.gameType, 0, 1)
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.info_ = arg_7_0.params_.heroUpgradeInfo

	arg_7_0:UpdateUI()
end

function var_0_0.UpdateUI(arg_8_0)
	for iter_8_0 = 1, arg_8_0.buffItemCout_ do
		local var_8_0 = arg_8_0.info_.heroBuffs[iter_8_0]
		local var_8_1 = arg_8_0.buffItemList_[iter_8_0]

		if var_8_0 then
			var_8_1:SetData(false, iter_8_0, var_8_0, 5, arg_8_0.params_.gameType)
			var_8_1:SetNotClick(false)
			SetActive(var_8_1.gameObject_, true)
		else
			SetActive(var_8_1.gameObject_, false)
		end
	end
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.buffItemList_) do
		iter_10_1:Dispose()
	end

	arg_10_0.buffItemList_ = {}

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
