NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")

local var_0_0 = class("BattleMatrixResultViewNew", NewBattleSettlementView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/MatrixlUI/MatirxBattleResultWinUI"
end

function var_0_0.Init(arg_2_0)
	arg_2_0.hasSnapshot_ = GetBattleResultSnapShot()

	arg_2_0:InitUI()

	arg_2_0.btnController = arg_2_0.btnController_:GetController("btn")
	arg_2_0.adaptComp = arg_2_0:FindCom("AdaptImage", nil, arg_2_0.commonMaskBg_.transform)

	arg_2_0:AddListener()

	arg_2_0.affixList = LuaList.New(handler(arg_2_0, arg_2_0.IndexAffixItem), arg_2_0.affixListGo_, BattleMatrixAffixItem)
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.heroModule = {
		BattleSettlementMatrixHeroHeadModule.New(arg_3_0.heroHead1Obj_),
		BattleSettlementMatrixHeroHeadModule.New(arg_3_0.heroHead2Obj_),
		(BattleSettlementMatrixHeroHeadModule.New(arg_3_0.heroHead3Obj_))
	}
end

function var_0_0.OnAddListner(arg_4_0)
	SetActive(arg_4_0.emptyMaskBtn_.gameObject, true)
	arg_4_0:AddBtnListener(arg_4_0.emptyMaskBtn_, nil, function()
		BattleInstance.QuitBattle(arg_4_0.stageData)
	end)
end

function var_0_0.RenderView(arg_6_0)
	arg_6_0:RenderTitleView()
	arg_6_0:RefreshMyExpS()
	arg_6_0:RefreshHeroS()
	arg_6_0:RefreshBattleTime()
	arg_6_0:ShowContent()
end

function var_0_0.PostRenderView(arg_7_0)
	arg_7_0.btnController:SetSelectedState("nobtn")

	if arg_7_0.params_.battleResult.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("ACTIVITY_LOCK_SETTLEMENT_TIP"),
			OkCallback = function()
				arg_7_0:CloseFunc()
			end
		})
	end
end

function var_0_0.RenderTitleView(arg_9_0)
	SetActive(arg_9_0.titleObj_, true)

	local var_9_0 = arg_9_0.stageData:GetActivityID()
	local var_9_1 = StrategyMatrixData:GetTierID(var_9_0)
	local var_9_2 = StrategyMatrixTierTemplateCfg[var_9_1]

	arg_9_0.titleTxt_.text = string.format("%s-%s", var_9_2.tier, var_9_2.level)
	arg_9_0.affixTxt_.text = GetTips("MATRIX_GET_AFFIX")
	arg_9_0.affixData = StrategyMatrixData:GetAffixList(var_9_0)

	arg_9_0.affixList:StartScroll(#arg_9_0.affixData)
end

function var_0_0.RefreshBattleTime(arg_10_0)
	arg_10_0.battleTimeText_.text = manager.time:DescCTime(BattleFieldData:GetBattleResultData().useSecond, "%M:%S")
end

function var_0_0.RefreshHeroS(arg_11_0)
	local var_11_0 = arg_11_0.stageData:GetHeroTeam()

	for iter_11_0 = 1, 3 do
		if not var_11_0[iter_11_0] or var_11_0[iter_11_0] == 0 then
			arg_11_0.heroModule[iter_11_0]:SetHeroData(nil)
			arg_11_0.heroModule[iter_11_0]:ShowCaptain(false)
		else
			arg_11_0.heroModule[iter_11_0]:ShowCaptain(true)

			local var_11_1 = arg_11_0.stageData:GetHeroDataByPos(iter_11_0)

			arg_11_0.heroModule[iter_11_0]:SetHeroData({
				id = var_11_1.id,
				using_skin = var_11_1.using_skin,
				star = var_11_1.star or 0
			})
			arg_11_0.heroModule[iter_11_0]:ShowLevel(var_11_1.level, 1)

			local var_11_2 = StrategyMatrixData:GetHeroDataNew(var_11_0[iter_11_0])
			local var_11_3 = var_11_2:GetHeroHP()
			local var_11_4 = var_11_2:GetHeroMaxHP()

			arg_11_0.heroModule[iter_11_0]:ShowHp(var_11_3, var_11_4)
		end
	end
end

function var_0_0.onRenderMissionContent(arg_12_0)
	if not arg_12_0.missionView then
		arg_12_0.missionView = MatrixBattleSettlementMissionModule.New(arg_12_0.contentContainer_)
	end

	arg_12_0.missionView:RenderRewards(arg_12_0.params_.rewardList)
end

function var_0_0.NeedAddExp(arg_13_0)
	return false
end

function var_0_0.ShowVitalityBox(arg_14_0, arg_14_1)
	if needShowVitalityFullBox() then
		showVitalitySendMail(arg_14_1)
	else
		arg_14_1()
	end
end

function var_0_0.ShowEquipBox(arg_15_0, arg_15_1)
	if needShowBagFullBox() then
		showEquipSendMail(arg_15_1)
	else
		arg_15_1()
	end
end

function var_0_0.IndexAffixItem(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0.affixData[arg_16_1]

	arg_16_2:SetData(var_16_0)
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0.missionView:Dispose()
	arg_17_0.affixList:Dispose()
	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
