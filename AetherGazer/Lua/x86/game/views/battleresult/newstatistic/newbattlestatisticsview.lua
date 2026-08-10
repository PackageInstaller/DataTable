local var_0_0 = class("NewBattleStatisticsView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/BattleResult/Common/BattleResultStatisticsUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()

	arg_3_0.adaptComp = arg_3_0:FindCom("AdaptImage", nil, arg_3_0.commonBgMask_.transform)

	arg_3_0:AddListeners()
end

function var_0_0.OnEnter(arg_4_0)
	SetActive(arg_4_0.shareBtn_.gameObject, OperationData:IsOperationOpen(OperationConst.SHARE_FLAG))

	arg_4_0.stageData = arg_4_0.params_.stageData
	arg_4_0.hasSnapshot_ = arg_4_0.params_.hasSnapshot_
	arg_4_0.statisticsHeroItem_ = {}

	local var_4_0, var_4_1, var_4_2 = BattleTools.GetBattleStatisticsData()
	local var_4_3 = LuaExchangeHelper.GetBattleStatisticsData()
	local var_4_4 = var_4_3 and var_4_3.dataForLua.currentHPHero or {}
	local var_4_5 = arg_4_0.stageData:GetHeroTeam()
	local var_4_6 = 0

	for iter_4_0, iter_4_1 in ipairs(var_4_5) do
		if iter_4_1 ~= 0 then
			var_4_6 = var_4_6 + 1
		end
	end

	local var_4_7 = var_4_4.Count or 0

	if var_4_7 ~= var_4_6 then
		for iter_4_2 = 1, 3 do
			if iter_4_2 <= var_4_7 then
				local var_4_8 = var_4_4[iter_4_2 - 1]
				local var_4_9 = table.indexof(var_4_5, var_4_8)
				local var_4_10 = arg_4_0.stageData:GetHeroDataByPos(var_4_9)

				arg_4_0.heroModule[iter_4_2]:SetHeroData(iter_4_2, var_4_10)
				arg_4_0.heroModule[iter_4_2]:SetStatisticsData(var_4_1, var_4_2, var_4_0[iter_4_2])
			else
				arg_4_0.heroModule[iter_4_2]:SetHeroData(iter_4_2, nil)
			end
		end
	else
		for iter_4_3 = 1, 3 do
			local var_4_11 = arg_4_0.stageData:GetHeroDataByPos(iter_4_3)

			arg_4_0.heroModule[iter_4_3]:SetHeroData(iter_4_3, var_4_11)
			arg_4_0.heroModule[iter_4_3]:SetStatisticsData(var_4_1, var_4_2, var_4_0[iter_4_3])
		end
	end

	arg_4_0:SetLevelTitle()
	arg_4_0:RefreshTimeText()
	arg_4_0:RenderMaskBg()

	if arg_4_0.params_.battleResult ~= nil and arg_4_0.params_.battleResult.errorCode ~= nil and arg_4_0.params_.battleResult.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("ACTIVITY_LOCK_SETTLEMENT_TIP"),
			OkCallback = function()
				arg_4_0:CloseFunc()
			end
		})
	end
end

function var_0_0.CloseFunc(arg_6_0)
	BattleInstance.QuitBattle(arg_6_0.stageData)
end

function var_0_0.OnExit(arg_7_0)
	return
end

function var_0_0.Dispose(arg_8_0)
	for iter_8_0 = 1, 3 do
		arg_8_0.heroModule[iter_8_0]:Dispose()
	end

	arg_8_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_8_0)
end

function var_0_0.InitUI(arg_9_0)
	arg_9_0:BindCfgUI()

	arg_9_0.heroModule = {
		NewBattleStatisticsHeroItem.New(arg_9_0.hero1Obj_),
		NewBattleStatisticsHeroItem.New(arg_9_0.hero2Obj_),
		(NewBattleStatisticsHeroItem.New(arg_9_0.hero3Obj_))
	}
end

function var_0_0.SetLevelTitle(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.stageData:GetStageId()
	local var_10_1 = arg_10_0.stageData:GetType()
	local var_10_2 = BattleStageTools.GetStageName(var_10_1, var_10_0)
	local var_10_3, var_10_4 = BattleStageTools.GetChapterSectionIndex(var_10_1, var_10_0)

	if var_10_3 ~= "" then
		arg_10_0.titleTxt_.text = string.format("%s-%s ", GetI18NText(var_10_3), GetI18NText(var_10_4)) .. var_10_2
	else
		arg_10_0.titleTxt_.text = var_10_2
	end
end

function var_0_0.RefreshTimeText(arg_11_0)
	SetActive(arg_11_0.timeTxt_.gameObject, arg_11_0.params_.battleTime ~= nil)

	if not arg_11_0.params_.battleTime then
		return
	end

	arg_11_0.timeTxt_.text = table.concat({
		GetTips("BATTLE_TOTAL_TIME"),
		": ",
		arg_11_0.params_.battleTime or "00"
	})
end

function var_0_0.RenderMaskBg(arg_12_0)
	if not arg_12_0.hasSnapshot_ then
		arg_12_0.commonBgMask_.sprite = pureGetSpriteWithoutAtlas("TextureBg/BattleResult/battleResult_bg_common")

		arg_12_0.adaptComp:AdaptImg()
		SetActive(arg_12_0.commonBgMask_.gameObject, true)
		SetActive(arg_12_0.bgMask_.gameObject, false)
	else
		arg_12_0.bgMask_.texture = arg_12_0.hasSnapshot_

		SetActive(arg_12_0.commonBgMask_.gameObject, false)
		SetActive(arg_12_0.bgMask_.gameObject, true)
	end
end

function var_0_0.AddListeners(arg_13_0)
	arg_13_0:AddBtnListener(arg_13_0.backBtn_, nil, function()
		arg_13_0:Back()
	end)
	arg_13_0:AddBtnListener(arg_13_0.shareBtn_, nil, function()
		manager.share:Share(function()
			SetActive(arg_13_0.shareBtn_.gameObject, false)
			SetActive(arg_13_0.backBtn_.gameObject, false)
		end, function()
			SetActive(arg_13_0.shareBtn_.gameObject, true)
			SetActive(arg_13_0.backBtn_.gameObject, true)
		end)
	end)
end

return var_0_0
