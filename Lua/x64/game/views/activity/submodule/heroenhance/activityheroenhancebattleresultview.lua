NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")

local var_0_0 = class("ActivityHeroEnhanceBattleResultView", NewBattleSettlementView)

function var_0_0.InitUI(arg_1_0)
	var_0_0.super.InitUI(arg_1_0)

	arg_1_0.firstHeroModule = arg_1_0.heroModule[1]

	SetActive(arg_1_0.heroHead2Obj_, false)
	SetActive(arg_1_0.heroHead3Obj_, false)
end

function var_0_0.OnAddListner(arg_2_0)
	SetActive(arg_2_0.emptyMaskBtn_.gameObject, true)
	arg_2_0:AddBtnListener(arg_2_0.emptyMaskBtn_, nil, function()
		BattleInstance.QuitBattle(arg_2_0.stageData)
	end)
end

function var_0_0.onRenderMissionResultContent(arg_4_0)
	if not arg_4_0.missionView then
		arg_4_0.missionView = ActivityHeroEnhanceBattleSettlementModule.New(arg_4_0.contentContainer_, arg_4_0.stageData:GetActivityID())
	end

	arg_4_0.missionView:RenderView({
		stageData = arg_4_0.stageData,
		rewardList = arg_4_0.params_.rewardList
	})
end

function var_0_0.ShowContent(arg_5_0)
	arg_5_0:onRenderMissionResultContent()
end

function var_0_0.PostRenderView(arg_6_0)
	arg_6_0.btnController:SetSelectedState("nobtn")
end

function var_0_0.RenderTitleView(arg_7_0)
	SetActive(arg_7_0.titleObj_, true)

	local var_7_0 = BattleStageTools.GetStageCfg(arg_7_0.stageType, arg_7_0.stageId)

	arg_7_0.titleTxt_.text = GetI18NText(var_7_0.name)
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.missionView:Dispose()
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
