local var_0_0 = class("matrixOverNewView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/BattleResult/BattleMatrixOverUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.heroItemList_ = {}

	for iter_4_0 = 1, 3 do
		local var_4_0 = arg_4_0[string.format("heroItem%s_", iter_4_0)]

		arg_4_0.heroItemList_[iter_4_0] = MatrixOverHeroItem.New(var_4_0)
	end

	arg_4_0.affixList_ = LuaList.New(handler(arg_4_0, arg_4_0.AffixIndexItem), arg_4_0.m_affixList, MatrixOverAffixItem)
	arg_4_0.treasureList_ = LuaList.New(handler(arg_4_0, arg_4_0.ArtifactIndexItem), arg_4_0.m_treasureList, MatrixOverArtifactItem)
	arg_4_0.beaconList_ = LuaList.New(handler(arg_4_0, arg_4_0.BeaconIndexItem), arg_4_0.m_beaconList, MatrixOverBeaconItem)
	arg_4_0.resultController_ = ControllerUtil.GetController(arg_4_0.transform_, "result")
	arg_4_0.difficultyController_ = ControllerUtil.GetController(arg_4_0.transform_, "difficulty")
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.closeBtn_, nil, function()
		if arg_5_0:GetGameState() == MatrixConst.STATE_TYPE.NOTSTARTED then
			arg_5_0:Go("/matrixBlank/matrixPrepare")
		else
			MatrixAction.QueryMatrixOver(function(arg_7_0)
				if isSuccess(arg_7_0.result) then
					arg_5_0:Go("/matrixBlank/matrixPrepare")
				end
			end)
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_evaluateBtn, nil, function()
		if arg_5_0:GetGameState() == MatrixConst.STATE_TYPE.SUCCESS then
			arg_5_0:Go("matrixOverEvaluate")
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.statisticsBtn_, nil, function()
		JumpTools.OpenPageByJump("battleStatisticsMatrixOver")
	end)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0:Refresh()
end

function var_0_0.OnExit(arg_11_0)
	return
end

function var_0_0.ParseTime(arg_12_0, arg_12_1)
	local var_12_0 = math.floor(arg_12_1 / 3600)
	local var_12_1 = math.floor(arg_12_1 % 3600 / 60)
	local var_12_2 = arg_12_1 % 60

	var_12_0 = var_12_0 < 10 and "0" .. var_12_0 or var_12_0
	var_12_1 = var_12_1 < 10 and "0" .. var_12_1 or var_12_1
	var_12_2 = var_12_2 < 10 and "0" .. var_12_2 or var_12_2

	return var_12_0 .. ":" .. var_12_1 .. ":" .. var_12_2
end

function var_0_0.Refresh(arg_13_0)
	if arg_13_0:GetGameState() == MatrixConst.STATE_TYPE.SUCCESS then
		arg_13_0.resultController_:SetSelectedIndex(0)

		arg_13_0.currentTimeText_.text = arg_13_0:ParseTime(arg_13_0:GetCurrentClearTime())
		arg_13_0.bestTimeText_.text = arg_13_0:ParseTime(arg_13_0:GetMinClearTime())

		local var_13_0 = arg_13_0:GetEvaluateList()

		if #var_13_0 > 0 and MatrixEvaluateCfg[var_13_0[1]] then
			local var_13_1 = MatrixEvaluateCfg[var_13_0[1]]

			arg_13_0.stageName_.text = GetI18NText(var_13_1.title)
		else
			arg_13_0.stageName_.text = arg_13_0:GetTierDes()
		end
	else
		arg_13_0.resultController_:SetSelectedIndex(1)

		arg_13_0.stageName_.text = arg_13_0:GetTierDes()
	end

	arg_13_0.m_rankScoreText.text = arg_13_0:GetMatrixOverScore()

	if arg_13_0:GetDifficulty() == 1 then
		arg_13_0.difficultyController_:SetSelectedIndex(0)
	else
		arg_13_0.difficultyController_:SetSelectedIndex(1)

		arg_13_0.regularData = arg_13_0:GetRegularAffix()
		arg_13_0.customData = arg_13_0:GetCustomAffix()

		local var_13_2 = 0
		local var_13_3 = 0

		for iter_13_0, iter_13_1 in ipairs(arg_13_0.regularData) do
			var_13_2 = var_13_2 + ActivityAffixPoolCfg[iter_13_1].point
		end

		for iter_13_2, iter_13_3 in ipairs(arg_13_0.customData) do
			var_13_2 = var_13_2 + ActivityAffixPoolCfg[iter_13_3].point
		end

		arg_13_0.m_difficultyScore.text = "" .. var_13_2
	end

	local var_13_4 = arg_13_0:GetMatrixHeroTeam()

	for iter_13_4 = 1, 3 do
		local var_13_5 = var_13_4[iter_13_4]

		if var_13_5 and var_13_5 ~= 0 then
			arg_13_0.heroItemList_[iter_13_4]:Refresh(var_13_5)
			arg_13_0.heroItemList_[iter_13_4]:SetActive(true)
		else
			arg_13_0.heroItemList_[iter_13_4]:SetActive(false)
		end
	end

	arg_13_0.affixData = arg_13_0:GetAffixList()

	arg_13_0.affixList_:StartScroll(#arg_13_0.affixData)

	arg_13_0.artifactData = arg_13_0:GetArtifactList()

	table.sort(arg_13_0.artifactData, function(arg_14_0, arg_14_1)
		local var_14_0 = MatrixItemCfg[arg_14_0.id]
		local var_14_1 = MatrixItemCfg[arg_14_1.id]

		if var_14_0.rare ~= var_14_1.rare then
			return var_14_0.rare > var_14_1.rare
		end

		return arg_14_0.id < arg_14_1.id
	end)
	arg_13_0.treasureList_:StartScroll(#arg_13_0.artifactData)

	arg_13_0.beaconData = arg_13_0:GetUseBeaconList()

	arg_13_0.beaconList_:StartScroll(#arg_13_0.beaconData)

	local var_13_6 = arg_13_0:GetMatrixCurrencyList()

	arg_13_0.scoreText_.text = var_13_6[CurrencyConst.CURRENCY_TYPE_MATRIX_PT] or 0
end

function var_0_0.AffixIndexItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.affixData[arg_15_1]

	arg_15_2:Refresh(var_15_0)
end

function var_0_0.ArtifactIndexItem(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0.artifactData[arg_16_1]

	arg_16_2:Refresh(var_16_0)
end

function var_0_0.BeaconIndexItem(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0.beaconData[arg_17_1]

	arg_17_2:Refresh(var_17_0)
end

function var_0_0.Dispose(arg_18_0)
	for iter_18_0, iter_18_1 in pairs(arg_18_0.heroItemList_) do
		iter_18_1:Dispose()
	end

	arg_18_0.heroItemList_ = nil

	arg_18_0.affixList_:Dispose()
	arg_18_0.treasureList_:Dispose()
	arg_18_0.beaconList_:Dispose()
	var_0_0.super.Dispose(arg_18_0)
end

function var_0_0.OnMatrixOverUpdate(arg_19_0)
	arg_19_0:Refresh()
end

function var_0_0.GetGameState(arg_20_0)
	return MatrixData:GetGameState()
end

function var_0_0.GetCurrentClearTime(arg_21_0)
	return MatrixData:GetCurrentClearTime()
end

function var_0_0.GetMinClearTime(arg_22_0)
	return MatrixData:GetMinClearTime()
end

function var_0_0.GetEvaluateList(arg_23_0)
	return MatrixData:GetEvaluateList()
end

function var_0_0.GetTierDes(arg_24_0)
	local var_24_0 = MatrixData:GetTierID()
	local var_24_1 = MatrixTierCfg[var_24_0]

	return string.format("%s-%s", var_24_1.tier, var_24_1.level)
end

function var_0_0.GetAffixList(arg_25_0)
	return MatrixData:GetAffixList()
end

function var_0_0.GetArtifactList(arg_26_0)
	return MatrixData:GetArtifactList()
end

function var_0_0.GetUseBeaconList(arg_27_0)
	return MatrixData:GetUseBeaconList()
end

function var_0_0.GetMatrixCurrencyList(arg_28_0)
	return MatrixData:GetMatrixCurrencyList()
end

function var_0_0.GetMatrixHeroTeam(arg_29_0)
	return MatrixData:GetMatrixHeroTeam()
end

function var_0_0.GetMatrixOverScore(arg_30_0)
	return MatrixData:GetMatrixOverScore()
end

function var_0_0.GetDifficulty(arg_31_0)
	return MatrixData:GetDifficulty()
end

function var_0_0.GetRegularAffix(arg_32_0)
	return MatrixData:GetDifficultyData():GetRegularAffix()
end

function var_0_0.GetCustomAffix(arg_33_0)
	return MatrixData:GetCustomAffix()
end

return var_0_0
