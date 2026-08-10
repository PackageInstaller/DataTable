NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")

local var_0_0 = class("NewBattleMythicFinalResultView", NewBattleSettlementView)

function var_0_0.AddListener(arg_1_0)
	var_0_0.super.AddListener(arg_1_0)
	arg_1_0:AddBtnListener(arg_1_0.confirm2Btn_, nil, function()
		BattleInstance.TryNextBattle(arg_1_0.stageData)
	end)
	arg_1_0:AddBtnListener(arg_1_0.restartBtn_, nil, function()
		arg_1_0:RestartFunc()
	end)
	arg_1_0:AddBtnListener(arg_1_0.exitBtn_, nil, function()
		BattleInstance.QuitBattle(arg_1_0.stageData)
	end)
end

function var_0_0.RestartFunc(arg_5_0)
	ShowMessageBox({
		content = GetTips("MYTHIC_FINAL_LEVEL_RETRY"),
		OkCallback = function()
			BattleInstance.OnceMoreBattle(arg_5_0.stageData)
		end
	})
end

function var_0_0.onRenderBlackRegionContent(arg_7_0)
	if not arg_7_0.blackRegionView then
		arg_7_0.blackRegionView = BattleSettlementBlackRegionModule.New(arg_7_0.contentContainer_)
	end

	arg_7_0.blackRegionView:RenderView({
		stageData = arg_7_0.stageData
	})
end

function var_0_0.ShowContent(arg_8_0)
	arg_8_0:onRenderBlackRegionContent()
end

function var_0_0.PostRenderView(arg_9_0)
	if arg_9_0.params_.battleResult.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("ACTIVITY_LOCK_SETTLEMENT_TIP"),
			OkCallback = function()
				BattleInstance.TryNextBattle(arg_9_0.stageData)
			end
		})
	end

	arg_9_0.btnController:SetSelectedState("blackzone")

	if #MythicData:GetCurLevelIdList() > 1 and arg_9_0.stageData:GetDest() < #MythicData:GetCurLevelIdList() then
		SetActive(arg_9_0.exitBtn_.gameObject, true)
	else
		SetActive(arg_9_0.exitBtn_.gameObject, false)
	end
end

function var_0_0.RenderTitleView(arg_11_0)
	SetActive(arg_11_0.titleObj_, true)

	arg_11_0.titleTxt_.text = string.format(GetTips("MYTHIC_FINAL_LEVEL"), MythicData:GetCurHotLevelId())
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.blackRegionView:Dispose()
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
