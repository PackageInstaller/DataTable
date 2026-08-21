local var_0_0 = class("NewBattleChallengeStatisticsView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/BattleResult/BattleFailed/BattleChallengeStatisticsUI"
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

	arg_4_0.toggles_ = {
		arg_4_0.lvBtn_,
		arg_4_0.equipBtn_,
		arg_4_0.transitionBtn_
	}
	arg_4_0.items_ = {
		NewBattleChallengeStatisticsItem.New(arg_4_0.itemGo1_),
		NewBattleChallengeStatisticsItem.New(arg_4_0.itemGo2_),
		NewBattleChallengeStatisticsItem.New(arg_4_0.itemGo3_)
	}
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.closeBtn_, nil, function()
		arg_5_0:Back()
	end)

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.toggles_) do
		arg_5_0:AddToggleListener(iter_5_1, function(arg_7_0)
			if arg_7_0 then
				arg_5_0:Refresh(iter_5_0)

				local var_7_0 = BattleFieldData:GetServerBattleID() or 0

				SDKTools.SendMessageToSDK("combat_over_lose_recomme_detail_", {
					battle_id_str = var_7_0,
					direction_type = iter_5_0
				})
			end
		end)
	end
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.index = arg_8_0.params_.index
	arg_8_0.stageData_ = arg_8_0.params_.stageData
	arg_8_0.heroList_ = arg_8_0.stageData_.heroList_

	arg_8_0:RefreshBtn()
	arg_8_0:Refresh(arg_8_0.index)
end

function var_0_0.Refresh(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0.heroList_) do
		arg_9_0.items_[iter_9_0]:SetData(arg_9_1, iter_9_1)
	end

	arg_9_0.toggles_[arg_9_1].isOn = true
end

function var_0_0.RefreshBtn(arg_10_0)
	arg_10_0.userData = PlayerData:GetPlayerInfo()

	if arg_10_0.userData.userLevel >= 60 then
		SetActive(arg_10_0.transitionBtn_.gameObject, true)
	elseif arg_10_0.userData.userLevel >= 20 and arg_10_0.userData.userLevel < 60 then
		SetActive(arg_10_0.transitionBtn_.gameObject, false)
		SetActive(arg_10_0.equipBtn_.gameObject, true)
	elseif arg_10_0.userData.userLevel < 20 then
		SetActive(arg_10_0.equipBtn_.gameObject, false)
	end
end

function var_0_0.OnExit(arg_11_0)
	return
end

function var_0_0.Dispose(arg_12_0)
	for iter_12_0 = 1, #arg_12_0.items_ do
		arg_12_0.items_[iter_12_0]:Dispose()
	end

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
