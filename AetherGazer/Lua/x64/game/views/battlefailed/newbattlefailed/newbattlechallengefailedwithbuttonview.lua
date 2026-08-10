NewBattleChallengeFailedView = import("game.views.battleFailed.newBattleFailed.NewBattleChallengeFailedView")

local var_0_0 = class("NewBattleChallengeFailedWithButtonView", NewBattleChallengeFailedView)

function var_0_0.AddUIListener(arg_1_0)
	var_0_0.super.AddUIListener(arg_1_0)
	arg_1_0.btnMask_.onClick:RemoveAllListeners()
	arg_1_0:AddBtnListener(arg_1_0.btnMask_, nil, function()
		arg_1_0:Back(false, function()
			return
		end)
	end)
	arg_1_0.btnController:SetSelectedState("2btn")
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.stageData_ = arg_4_0.params_.stageData
	arg_4_0.stageID_ = arg_4_0.stageData_:GetStageId()
	arg_4_0.stageType_ = arg_4_0.stageData_:GetType()

	BattleInstance.hideBattlePanel()
	arg_4_0:RebuildUI()
end

return var_0_0
