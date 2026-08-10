NewBattleFailedView = import("game.views.battleFailed.newBattleFailed.NewBattleFailedView")

local var_0_0 = class("MonsterCosplayBattleFailView", NewBattleFailedView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_MonsterPlayUI/Summer2024_MonsterPlayBattleResultLoseUI"
end

function var_0_0.AddUIListener(arg_2_0)
	var_0_0.super.AddUIListener(arg_2_0)
	arg_2_0.btnMask_.onClick:RemoveAllListeners()
	arg_2_0:AddBtnListener(arg_2_0.btnMask_, nil, function()
		arg_2_0:Back(false, function()
			return
		end)
	end)
	arg_2_0.btnController:SetSelectedState("2btn")
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0.stageData_ = arg_5_0.params_.stageData
	arg_5_0.stageID_ = arg_5_0.stageData_:GetStageId()
	arg_5_0.stageType_ = arg_5_0.stageData_:GetType()

	BattleInstance.hideBattlePanel()
	arg_5_0:RebuildUI()
end

function var_0_0.RebuildUI(arg_6_0)
	arg_6_0:ChangeStyle()
	arg_6_0:RefreshRecommendType()
	arg_6_0:RefreshRecommendLevel()

	arg_6_0.battleTimeText_.text = table.concat({
		GetTips("BATTLE_TOTAL_TIME"),
		": ",
		arg_6_0:GetBattleTime() or "00"
	})
	arg_6_0.titleTxt_.text = BattleStageTools.GetStageName(arg_6_0.stageType_, arg_6_0.stageID_)

	local var_6_0 = BattleStageTools.GetStageCfg(arg_6_0.stageType_, arg_6_0.stageID_)
end

return var_0_0
