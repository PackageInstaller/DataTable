local var_0_0 = import("game.views.battleResult.multiple.BattleMultipleResultView")
local var_0_1 = class("BattleActivityRaceResultView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "UI/BattleResult/ActivityRaceMultipletUI"
end

function var_0_1.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListener()

	arg_2_0.heroItemView_ = {}
	arg_2_0.rewardList_ = LuaList.New(handler(arg_2_0, arg_2_0.RewardRenderer), arg_2_0.rewardUIList_, CommonItem)
	arg_2_0.affixList_ = LuaList.New(handler(arg_2_0, arg_2_0.AffixRenderer), arg_2_0.affixUIList_, ActivityRaceAffixResultItem)
end

function var_0_1.OnEnter(arg_3_0)
	arg_3_0.stageData = arg_3_0.params_.stageData
	arg_3_0.stageId = arg_3_0.stageData:GetStageId()
	arg_3_0.stageType = arg_3_0.stageData:GetType()

	BattleInstance.hideBattlePanel()
	arg_3_0:RefreshUI()

	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.params_.rewardList) do
		for iter_3_2, iter_3_3 in ipairs(iter_3_1) do
			var_3_0[iter_3_3[1]] = var_3_0[iter_3_3[1]] or {}
			var_3_0[iter_3_3[1]][1] = iter_3_3[1]

			if var_3_0[iter_3_3[1]][2] == nil then
				var_3_0[iter_3_3[1]][2] = 0
			end

			var_3_0[iter_3_3[1]][2] = var_3_0[iter_3_3[1]][2] + iter_3_3[2]
		end
	end

	arg_3_0.rewardDataList_ = {}

	local var_3_1 = 1

	for iter_3_4, iter_3_5 in pairs(var_3_0) do
		arg_3_0.rewardDataList_[var_3_1] = iter_3_5
		var_3_1 = var_3_1 + 1
	end

	arg_3_0.rewardList_:StartScroll(#arg_3_0.rewardDataList_, 1)
	arg_3_0.affixList_:StartScroll(#arg_3_0.params_.affixList, 1)

	if arg_3_0.params_.battleResult.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("ACTIVITY_LOCK_SETTLEMENT_TIP"),
			OkCallback = function()
				arg_3_0:CloseFunc()
			end
		})
	end
end

function var_0_1.Dispose(arg_5_0)
	arg_5_0.affixList_:Dispose()

	arg_5_0.affixList_ = nil

	arg_5_0.rewardList_:Dispose()

	arg_5_0.rewardList_ = nil

	var_0_1.super.Dispose(arg_5_0)
end

function var_0_1.RewardRenderer(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:RefreshData(formatReward(arg_6_0.rewardDataList_[arg_6_1]))
	arg_6_2:RegistCallBack(function()
		ShowPopItem(POP_OTHER_ITEM, arg_6_0.rewardDataList_[arg_6_1])
	end)
end

function var_0_1.AffixRenderer(arg_8_0, arg_8_1, arg_8_2)
	arg_8_2:SetData(arg_8_0.params_.affixList[arg_8_1])
end

return var_0_1
