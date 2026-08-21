local var_0_0 = class("BattleMatrixResultView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/MatrixlUI/BattleVariableUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListener()

	arg_3_0.affixList = LuaList.New(handler(arg_3_0, arg_3_0.IndexAffixItem), arg_3_0.affixListGo_, BattleMatrixAffixItem)
end

function var_0_0.OnEnter(arg_4_0)
	BattleInstance.hideBattlePanel()

	arg_4_0.stageData = arg_4_0.params_.stageData

	arg_4_0:RefreshUI()

	if arg_4_0.params_.battleResult.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
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

function var_0_0.NeedOnceMore(arg_6_0)
	return false
end

function var_0_0.OnTop(arg_7_0)
	SetActive(arg_7_0.gameObject_, true)

	arg_7_0.toStat_ = false
end

function var_0_0.OnBehind(arg_8_0)
	if arg_8_0.toStat_ then
		SetActive(arg_8_0.gameObject_, false)
	end
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.rewardItems_) do
		iter_10_1:Dispose()
	end

	arg_10_0.rewardItems_ = nil

	arg_10_0.affixList:Dispose()

	for iter_10_2, iter_10_3 in ipairs(arg_10_0.rewardItemGos_) do
		Object.Destroy(iter_10_3)
	end

	arg_10_0.rewardItemGos_ = nil
	arg_10_0.heroGo_ = nil
	arg_10_0.heroImg_ = nil
	arg_10_0.hpText_ = nil
	arg_10_0.rewardList_ = nil
	arg_10_0.stareText_ = nil
	arg_10_0.lvText_ = nil
	arg_10_0.mask_ = nil
	arg_10_0.btnBack_ = nil
	arg_10_0.btnBattleCount_ = nil

	var_0_0.super.Dispose(arg_10_0)
end

function var_0_0.InitUI(arg_11_0)
	arg_11_0:BindCfgUI()

	arg_11_0.itemPrefeb = Asset.Load("UI/Common/CommonItem")
	arg_11_0.rewardItems_ = {}
	arg_11_0.rewardItemGos_ = {}
	arg_11_0.heroGo_ = {}
	arg_11_0.heroImg_ = {}
	arg_11_0.hpText_ = {}

	for iter_11_0 = 1, 3 do
		arg_11_0.heroGo_[iter_11_0] = arg_11_0["hero" .. iter_11_0]
		arg_11_0.heroImg_[iter_11_0] = arg_11_0["heroMaskIcon" .. iter_11_0]
		arg_11_0.hpText_[iter_11_0] = arg_11_0[string.format("hpText%s_", iter_11_0)]
	end

	LeanTween.alphaCanvas(arg_11_0.mask_, 0, 0.1):setOnComplete(LuaHelper.VoidAction(function()
		arg_11_0.mask_.blocksRaycasts = false
	end))
end

function var_0_0.GetRewardData(arg_13_0)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.params_.rewardList) do
		table.insert(var_13_0, iter_13_1)
	end

	return var_13_0
end

function var_0_0.ShowVitalityBox(arg_14_0, arg_14_1)
	if needShowVitalityFullBox(arg_14_0:GetRewardData()) then
		showVitalitySendMail(arg_14_1)
	else
		arg_14_1()
	end
end

function var_0_0.ShowEquipBox(arg_15_0, arg_15_1)
	if needShowBagFullBox(arg_15_0:GetRewardData()) then
		showEquipSendMail(arg_15_1)
	else
		arg_15_1()
	end
end

function var_0_0.AddListener(arg_16_0)
	arg_16_0:AddBtnListener(arg_16_0.btnBack_, nil, function()
		arg_16_0:CloseFunc()
	end)
	arg_16_0:AddBtnListener(arg_16_0.btnBattleCount_, nil, function()
		arg_16_0.toStat_ = true

		JumpTools.OpenPageByJump("battleStatisticsMatrix", {
			stageData = arg_16_0.stageData,
			battleTime = arg_16_0:GetBattleTime()
		})
	end)
end

function var_0_0.CloseFunc(arg_19_0)
	arg_19_0:ShowVitalityBox(function()
		arg_19_0:ShowEquipBox(function()
			BattleInstance.QuitBattle(arg_19_0.stageData)
		end)
	end)
end

function var_0_0.RemoveListener(arg_22_0)
	arg_22_0.btnBack_.onClick:RemoveAllListeners()
	arg_22_0.btnBattleCount_.onClick:RemoveAllListeners()
end

function var_0_0.RefreshUI(arg_23_0)
	arg_23_0:SetLevelTitle()
	arg_23_0:RefreshRewardItemS()
	arg_23_0:RefreshHeroS()
	arg_23_0:RefreshBattleTime()
end

function var_0_0.SetLevelTitle(arg_24_0)
	local var_24_0 = MatrixData:GetTierID()
	local var_24_1 = MatrixTierCfg[var_24_0]

	arg_24_0.stareText_.text = string.format("%s-%s", var_24_1.tier, var_24_1.level)

	local var_24_2 = arg_24_0.stageData:GetStageId()
	local var_24_3 = BattleMatrixStageCfg[var_24_2]

	arg_24_0.lvText_.text = GetI18NText(var_24_3.name)

	local var_24_4 = MatrixData:GetDifficulty()

	arg_24_0.difficultText_.text = string.format("<color=#%s>(%s)</color>", MatrixConst.DIFFICULTY_COLOR[var_24_4], GetTips(BattleConst.HARD_LANGUAGE[var_24_4]))
	arg_24_0.timeText_.text = manager.time:DescCTime(BattleFieldData:GetBattleResultData().useSecond, "%M:%S")
	arg_24_0.affixData = MatrixData:GetAffixList()

	arg_24_0.affixList:StartScroll(math.max(#arg_24_0.affixData, 3))
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_0.titleTransform_)
end

function var_0_0.RefreshRewardItemS(arg_25_0)
	local var_25_0 = {}

	if arg_25_0.params_.rewardList then
		for iter_25_0, iter_25_1 in pairs(arg_25_0.params_.rewardList) do
			table.insert(var_25_0, iter_25_1)
		end

		var_25_0 = formatRewardCfgList(var_25_0)
		var_25_0 = mergeReward(var_25_0)
		var_25_0 = sortReward(var_25_0)
	end

	for iter_25_2 = 1, #var_25_0 do
		if not arg_25_0.rewardItems_[iter_25_2] then
			local var_25_1 = Object.Instantiate(arg_25_0.itemPrefeb, arg_25_0.rewardList_)

			arg_25_0.rewardItems_[iter_25_2] = CommonItem.New(var_25_1)

			arg_25_0.rewardItems_[iter_25_2]:RegistCallBack(function(arg_26_0)
				ShowPopItem(POP_ITEM, {
					arg_26_0.id,
					arg_26_0.number
				})
			end)

			arg_25_0.rewardItemGos_[iter_25_2] = var_25_1

			arg_25_0.rewardItems_[iter_25_2]:ShowFloor(ItemConst.ITEM_FLOOR.BLACK)
		end

		arg_25_0.rewardItems_[iter_25_2]:RefreshData(var_25_0[iter_25_2])
		arg_25_0.rewardItems_[iter_25_2]:SetBottomText("<color=#%s>" .. var_25_0[iter_25_2].num .. "</color>")
	end
end

function var_0_0.RefreshHeroS(arg_27_0)
	local var_27_0 = arg_27_0.stageData:GetHeroTeam()

	for iter_27_0 = 1, 3 do
		if not var_27_0[iter_27_0] or var_27_0[iter_27_0] == 0 then
			SetActive(arg_27_0.heroGo_[iter_27_0], false)
		else
			SetActive(arg_27_0.heroGo_[iter_27_0], true)

			local var_27_1 = SkinCfg[MatrixData:GetHeroSkin(var_27_0[iter_27_0])]

			arg_27_0.heroImg_[iter_27_0].sprite = getSpriteViaConfig("HeroIcon", var_27_1.picture_id)

			local var_27_2 = MatrixData:GetHeroData(var_27_0[iter_27_0])
			local var_27_3 = var_27_2:GetHeroHP()
			local var_27_4 = var_27_2:GetHeroMaxHP()

			arg_27_0.hpText_[iter_27_0].text = string.format("<color=#FF9500>%s</color>/%s", var_27_3, var_27_4)
			arg_27_0[string.format("hpSlider%s_", iter_27_0)].value = var_27_3 / var_27_4
		end
	end
end

function var_0_0.RefreshBattleTime(arg_28_0)
	arg_28_0.battleTimeText_.text = arg_28_0:GetBattleTime()
end

function var_0_0.GetBattleTime(arg_29_0)
	local var_29_0 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime

	return manager.time:DescCdTime2(var_29_0)
end

function var_0_0.IndexAffixItem(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_0.affixData[arg_30_1]

	arg_30_2:SetData(var_30_0)
end

return var_0_0
