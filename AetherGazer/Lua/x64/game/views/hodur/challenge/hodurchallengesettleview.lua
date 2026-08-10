local var_0_0 = class("HodurChallengeSettleView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Hodur/Activity_Hodur_Settle"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.affixController_ = arg_3_0.mainControllerEx_:GetController("Mechanism")
	arg_3_0.bossList_ = {}

	for iter_3_0 = 1, 4 do
		local var_3_0 = {}

		ComponentBinder.GetInstance():BindCfgUI(var_3_0, arg_3_0["bossItem_" .. iter_3_0])

		var_3_0.gameObject_ = arg_3_0["affixItem_" .. iter_3_0]
		var_3_0.index = iter_3_0
		var_3_0.selectController_ = var_3_0.mainControllerEx_:GetController("select")
		var_3_0.lockController_ = var_3_0.mainControllerEx_:GetController("lock")
		var_3_0.numController_ = var_3_0.mainControllerEx_:GetController("num")

		var_3_0.selectController_:SetSelectedState("off")
		var_3_0.numController_:SetSelectedState("on")

		arg_3_0.bossList_[iter_3_0] = var_3_0
	end

	arg_3_0.heroItemList_ = {}

	for iter_3_1 = 1, 3 do
		arg_3_0.heroItemList_[iter_3_1] = HodurChallengeHeroItem.New(arg_3_0["heroGo_" .. iter_3_1])
	end

	arg_3_0.itemList_ = {}
	arg_3_0.rollingScore_ = arg_3_0.rollingTextGo_:GetComponent("RollingNumberText")
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		local var_6_0 = HodurTools.GetChallengeAffix()

		HodurSystemData:CacheAffixList(var_6_0)
		JumpTools.OpenPageByJump("/hodurChallengeView", {
			chapter_id = 4,
			activity_id = ActivityConst.ACTIVITY_HODUR_MAIN
		})
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.chapterID_ = arg_7_0.params_.chapterID

	arg_7_0:RefreshUI()
	arg_7_0:ShowTips(false)
end

function var_0_0.OnTop(arg_8_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnBehind(arg_9_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnExit(arg_10_0)
	HodurSystemData:ClearCacheChallengeData()
end

function var_0_0.RefreshUI(arg_11_0)
	arg_11_0:RefreshHero()
	arg_11_0:RefreshAffixInfo()
	arg_11_0:RefreshChapterState()
	arg_11_0:RefreshBossItem()
end

function var_0_0.RefreshHero(arg_12_0)
	arg_12_0.heroList_ = HodurTools.GetChallengeHero()

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.heroItemList_) do
		local var_12_0 = arg_12_0.heroList_[iter_12_0]
		local var_12_1
		local var_12_2

		if var_12_0 then
			var_12_1, var_12_2 = HodurTools.GetChallengeHeroHP(var_12_0)
		end

		iter_12_1:SetData(var_12_0, var_12_1, var_12_2)
	end
end

function var_0_0.RefreshAffixInfo(arg_13_0)
	local var_13_0 = HodurTools.GetChallengeAffix()

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		local var_13_1 = arg_13_0.itemList_[iter_13_0]

		if not var_13_1 then
			var_13_1 = HodurChallengeSelectAffixItem.New(Object.Instantiate(arg_13_0.affixGo_, arg_13_0.affixContentTrs_))
			arg_13_0.itemList_[iter_13_0] = var_13_1
		end

		var_13_1:SetData(iter_13_1)
		var_13_1:SetActive(true)
		var_13_1:SetClickHandler(function(arg_14_0)
			arg_13_0:OnClickAffixItem(arg_14_0, var_13_1)
		end)
	end

	for iter_13_2 = #var_13_0 + 1, #arg_13_0.itemList_ do
		arg_13_0.itemList_[iter_13_2]:SetActive(false)
	end

	local var_13_2 = HodurTools.GetChallengeAffix()
	local var_13_3 = #var_13_2

	if var_13_3 == nil then
		var_13_3 = 0
	end

	local var_13_4 = 100

	for iter_13_3, iter_13_4 in ipairs(var_13_2) do
		local var_13_5 = PublicBuffCfg[iter_13_4]

		if var_13_5 then
			var_13_4 = var_13_4 + ActivityAffixPoolCfg[var_13_5.buff_class_id].point
		end
	end

	local var_13_6 = string.format("%d%%", var_13_4)

	arg_13_0.efficiencyText_.text = var_13_6

	if var_13_3 == 0 then
		arg_13_0.affixController_:SetSelectedState("off")
	else
		arg_13_0.affixController_:SetSelectedState("on")
	end
end

function var_0_0.RefreshChapterState(arg_15_0)
	local var_15_0 = HodurTools.GetChallengeCurScore()

	arg_15_0.rollingScore_:Change(0, var_15_0)
end

function var_0_0.RefreshBossItem(arg_16_0)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0.bossList_) do
		if HodurTools.GetChallengeStageFinish(iter_16_1.index) then
			iter_16_1.lockController_:SetSelectedState("unlock")

			local var_16_0 = HodurTools.GetChallengeStageCurScore(iter_16_1.index)

			iter_16_1.scoreText_.text = tostring(var_16_0)

			iter_16_1.numController_:SetSelectedState("on")
		else
			iter_16_1.lockController_:SetSelectedState("lock")
			iter_16_1.numController_:SetSelectedState("off")
		end
	end
end

function var_0_0.OnClickAffixItem(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_2.selected_ then
		arg_17_2:SetSelected(false)
		arg_17_0:ShowTips(false)

		arg_17_0.selectAffix_ = nil
	else
		arg_17_2:SetSelected(true)
		arg_17_0:ShowTips(true, arg_17_1)

		arg_17_0.selectAffix_ = arg_17_1

		for iter_17_0, iter_17_1 in ipairs(arg_17_0.itemList_) do
			if iter_17_1 ~= arg_17_2 and iter_17_1.selected_ then
				iter_17_1:SetSelected(false)
			end
		end
	end
end

function var_0_0.ShowTips(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0.showTips_ = arg_18_1

	SetActive(arg_18_0.tipsGo_, arg_18_1)

	if arg_18_1 then
		arg_18_0.affixNameText_.text = AffixTypeCfg[arg_18_2].name
		arg_18_0.affixDescText_.text = DescriptionCfg[AffixTypeCfg[arg_18_2].description[1]].description
	end
end

function var_0_0.Dispose(arg_19_0)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0.itemList_) do
		iter_19_1:Dispose()
	end

	for iter_19_2, iter_19_3 in ipairs(arg_19_0.heroItemList_) do
		iter_19_3:Dispose()
	end

	var_0_0.super.Dispose(arg_19_0)
	arg_19_0:RemoveAllListeners()
end

return var_0_0
