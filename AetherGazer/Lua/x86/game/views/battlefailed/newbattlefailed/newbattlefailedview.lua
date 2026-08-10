local var_0_0 = import("game.views.pop.PopFramingBaseView")
local var_0_1 = class("NewBattleFailedView", var_0_0)
local var_0_2 = import("game.tools.BattleInstance")

function var_0_1.UIName(arg_1_0)
	return "Widget/System/BattleResult/BattleFailed/BattleResultLoseUI"
end

function var_0_1.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_1.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_1.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.styleController = arg_4_0.controllerEx_:GetController("default0")
	arg_4_0.posController = arg_4_0.controllerEx_:GetController("move")
	arg_4_0.lvController = arg_4_0.lvController_:GetController("red")
	arg_4_0.btnController = arg_4_0.btnController_:GetController("btn")
	arg_4_0.typeImgs = {}
	arg_4_0.criList = LuaList.New(handler(arg_4_0, arg_4_0.indexTypeItem), arg_4_0.criListObj_, BattleFailedCriItem)
end

function var_0_1.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btnBattleCount_, nil, function()
		arg_5_0:GoToBattleStatistics()
	end)
	arg_5_0:AddBtnListener(arg_5_0.exitBtn_, nil, function()
		arg_5_0:OnClickBack()
	end)
	arg_5_0:AddBtnListener(arg_5_0.restartBtn_, nil, function()
		arg_5_0:OnClickRestart()
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnMask_, nil, function()
		arg_5_0:Back(false, handler(arg_5_0, arg_5_0.OnClickBack))
	end)
	SetActive(arg_5_0.btnMask_.gameObject, true)
	arg_5_0.btnController:SetSelectedState("nobtn")
end

function var_0_1.GoToBattleStatistics(arg_10_0)
	JumpTools.OpenPageByJump("battleStatistics", {
		stageData = arg_10_0.params_.stageData,
		battleTime = arg_10_0:GetBattleTime()
	})
end

function var_0_1.GetBattleTime(arg_11_0)
	local var_11_0 = (LuaExchangeHelper.GetBattleStatisticsData() or LuaExchangeHelper.GetBattleStatisticsDataBeforeBattleEnd()).dataForLua.battleTime

	return manager.time:DescCdTime2(var_11_0)
end

function var_0_1.OnEnter(arg_12_0)
	arg_12_0.stageData_ = arg_12_0.params_.stageData
	arg_12_0.stageID_ = arg_12_0.stageData_:GetStageId()
	arg_12_0.stageType_ = arg_12_0.stageData_:GetType()
	arg_12_0.recommendAttriList = {}

	var_0_2.hideBattlePanel()
	arg_12_0:RebuildUI()
	arg_12_0:RecordThreeStar()
end

function var_0_1.OnExit(arg_13_0)
	return
end

function var_0_1.RebuildUI(arg_14_0)
	arg_14_0:ChangeStyle()
	arg_14_0:RefreshRecommendType()
	arg_14_0:RefreshRecommendLevel()

	arg_14_0.battleTimeText_.text = table.concat({
		GetTips("BATTLE_TOTAL_TIME"),
		": ",
		arg_14_0:GetBattleTime() or "00"
	})
	arg_14_0.titleTxt_.text = BattleStageTools.GetStageName(arg_14_0.stageType_, arg_14_0.stageID_)

	local var_14_0 = BattleStageTools.GetStageCfg(arg_14_0.stageType_, arg_14_0.stageID_)

	if var_14_0.is_hide_failed_tips and var_14_0.is_hide_failed_tips >= 1 then
		arg_14_0.posController:SetSelectedState("true")
		SetActive(arg_14_0.tipsTitleObj_, false)
		SetActive(arg_14_0.tips1Obj_, false)
		SetActive(arg_14_0.tips2Obj_, false)
		SetActive(arg_14_0.tips3Obj_, false)
		SetActive(arg_14_0.bottomLineObj_, false)
	else
		arg_14_0.posController:SetSelectedState("false")
		SetActive(arg_14_0.tipsTitleObj_, true)
		SetActive(arg_14_0.tips1Obj_, true)
		SetActive(arg_14_0.tips2Obj_, true)
		SetActive(arg_14_0.tips3Obj_, true)
		SetActive(arg_14_0.bottomLineObj_, true)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_0.infoTrans_)
end

function var_0_1.ChangeStyle(arg_15_0)
	if arg_15_0.params_.isHalfWay_ then
		arg_15_0.styleController:SetSelectedState("end")
	else
		arg_15_0.styleController:SetSelectedState("lose")
	end
end

function var_0_1.OnClickBack(arg_16_0)
	arg_16_0:QuitUI()
end

function var_0_1.QuitUI(arg_17_0)
	local var_17_0 = PlayerData:GetlevelUpInfos()

	if #var_17_0 > 0 then
		PlayerAction.LevelUpFinish()
		JumpTools.OpenPageByJump("levelUp", {
			levelUpInfoList = var_17_0,
			callback = function()
				FrameTimer.New(function()
					var_0_2.QuitBattle(arg_17_0.params_.stageData, true, true)
				end, 1, 1):Start()
			end
		})
	else
		var_0_2.QuitBattle(arg_17_0.params_.stageData, true, true)
	end
end

function var_0_1.OnClickRestart(arg_20_0)
	LuaExchangeHelper.GameOver(2)
	BattleController.GetInstance():LaunchBattle(arg_20_0.params_.stageData)
	LuaForCursor.SwitchCursor(false)
end

function var_0_1.RecordThreeStar(arg_21_0)
	local var_21_0 = arg_21_0.params_.starMissionData
	local var_21_1 = {}

	for iter_21_0 = 1, 3 do
		if var_21_0 ~= nil and var_21_0[iter_21_0] ~= nil then
			local var_21_2 = ThreeStarConditionCfg[var_21_0[iter_21_0].id]
			local var_21_3

			if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == arg_21_0.stageType_ then
				var_21_3 = BattleStageData:GetStageData()[arg_21_0.stageID_]
			elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE == arg_21_0.stageType_ then
				var_21_3 = BattleBossChallengeNormalData:GetStarList(arg_21_0.stageID_)
			end

			local var_21_4 = false

			if var_21_3 and var_21_3.stars and var_21_3.stars[iter_21_0] == 1 then
				var_21_4 = true
			end

			local var_21_5 = false

			if var_21_2.id == 15 or var_21_2.id == 16 then
				var_21_5 = var_21_0[iter_21_0].isComplete
			end

			var_21_1[iter_21_0] = (var_21_5 or var_21_4) and 1 or 0
		end
	end

	var_0_2.RecordThreeStar(arg_21_0.stageType_, arg_21_0.stageID_, var_21_1)
end

function var_0_1.RefreshRecommendType(arg_22_0)
	local var_22_0 = BattleStageTools.GetStageCfg(arg_22_0.stageType_, arg_22_0.stageID_)

	if var_22_0 then
		local var_22_1 = var_22_0.recommend_attribute_list or {}

		if #var_22_1 > 0 then
			SetActive(arg_22_0.recommendTypeObj_, true)

			arg_22_0.recommendAttriList = var_22_1

			arg_22_0.criList:StartScroll(#var_22_1)
		else
			SetActive(arg_22_0.recommendTypeObj_, false)
		end
	else
		SetActive(arg_22_0.recommendTypeObj_, false)
	end
end

function var_0_1.RefreshRecommendLevel(arg_23_0)
	local var_23_0 = 0
	local var_23_1, var_23_2 = arg_23_0.params_.stageData:GetHeroTeam()

	for iter_23_0 = 1, 3 do
		if var_23_1[iter_23_0] and var_23_1[iter_23_0] ~= 0 then
			local var_23_3 = arg_23_0.params_.stageData:GetHeroDataByPos(iter_23_0)

			var_23_0 = math.max(var_23_3.level, var_23_0)
		end
	end

	local var_23_4 = arg_23_0:GetRecommendLevel()

	if var_23_4 and var_23_4 ~= 0 then
		SetActive(arg_23_0.lvController_.gameObject, true)

		arg_23_0.recommendNumTxt_.text = var_23_4

		if var_23_4 <= var_23_0 then
			arg_23_0.lvController:SetSelectedState("state0")
		else
			arg_23_0.lvController:SetSelectedState("state1")
		end
	else
		SetActive(arg_23_0.lvController_.gameObject, false)
	end
end

function var_0_1.indexTypeItem(arg_24_0, arg_24_1, arg_24_2)
	arg_24_2:OnRenderItem(HeroTools.GetSkillAttributeIcon(arg_24_0.recommendAttriList[arg_24_1]))
end

function var_0_1.GetRecommendLevel(arg_25_0)
	return BattleStageTools.GetStageCfg(arg_25_0.stageType_, arg_25_0.stageID_).recommend_level
end

function var_0_1.Dispose(arg_26_0)
	arg_26_0.criList:Dispose()
	var_0_1.super.Dispose(arg_26_0)
end

return var_0_1
