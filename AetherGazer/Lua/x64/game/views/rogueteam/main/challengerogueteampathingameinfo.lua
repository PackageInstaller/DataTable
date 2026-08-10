local var_0_0 = class("ChallengeRogueTeamPathInGameInfo", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Roulike/item/RoulikeInGameInfoBox"
end

function var_0_0.Init(arg_2_0)
	arg_2_0.gameObject_ = GameObject.Instantiate(Asset.Load(arg_2_0:UIName()), manager.ui.uiPop.transform)
	arg_2_0.transform_ = arg_2_0.gameObject_.transform

	arg_2_0:BindCfgUI()
	arg_2_0:AdaptScreen()

	arg_2_0.heroItemList_ = {}

	for iter_2_0 = 1, 3 do
		local var_2_0 = arg_2_0["heroItemGo" .. iter_2_0 .. "_"]

		arg_2_0.heroItemList_[iter_2_0] = ChallengeRogueTeamPathHero.New(var_2_0)
	end

	arg_2_0.buffItemList_ = {}
	arg_2_0.schoolItemList_ = {}

	arg_2_0:AddUIListener()
	arg_2_0:SetBuffContentActive(false)
	arg_2_0:SetSchoolContentActive(false)

	arg_2_0.bgController_ = arg_2_0.controller_:GetController("bg")
	arg_2_0.emptyController_ = arg_2_0.controller_:GetController("empty")
	arg_2_0.schoolEmptyController_ = arg_2_0.controller_:GetController("empty01")
	arg_2_0.campBoxView_ = ChallengeRogueTeamCampBox.New(arg_2_0.suitSkillGo_)
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.schoolBtn_, nil, function()
		if ChallengeRogueTeamData:SuitSkillGetID() ~= 0 then
			JumpTools.OpenPageByJump("/challengeRogueTeamBag", {
				leftTabIndex = 2,
				tabIndex = 1
			})
		else
			arg_3_0:SetSchoolContentActive(true)
			arg_3_0:RefreshSchoolContent()
		end
	end)
	arg_3_0:AddBtnListener(arg_3_0.treasureBtn_, nil, function()
		JumpTools.OpenPageByJump("/challengeRogueTeamBag", {
			leftTabIndex = 2,
			tabIndex = 1
		})
	end)
	arg_3_0:AddBtnListener(arg_3_0.relicBtn_, nil, function()
		JumpTools.OpenPageByJump("/challengeRogueTeamBag", {
			leftTabIndex = 3
		})
	end)
	arg_3_0:AddBtnListener(arg_3_0.maskBtn_, nil, function()
		arg_3_0:SetBuffContentActive(false)
		arg_3_0:SetSchoolContentActive(false)
	end)
	arg_3_0:AddBtnListener(arg_3_0.buffBtn_, nil, function()
		if not arg_3_0.buffTipGo_.activeInHierarchy then
			arg_3_0:RefreshBuffContent()
		end

		arg_3_0:SetBuffContentActive(true)
	end)
	arg_3_0:AddBtnListener(arg_3_0.teamBtn_, nil, function()
		local var_9_0 = ReserveParams.New(ReserveConst.RESERVE_TYPE.CHALLENGE_ROGUE_TEAM, 0, 1, {
			stageType = BattleConst.STAGE_TYPE_NEW.CHALLENGE_ROGUE_TEAM
		})

		arg_3_0:Go("/challengeRogueTeamSectionSelectHero", {
			heroModify = true,
			sectionType = BattleConst.STAGE_TYPE_NEW.CHALLENGE_ROGUE_TEAM,
			heroDataType = HeroConst.HERO_DATA_TYPE.CHALLENGEROUGETEAM,
			reserveParams = var_9_0
		})
	end)
end

function var_0_0.SetBuffContentActive(arg_10_0, arg_10_1)
	SetActive(arg_10_0.buffTipGo_, arg_10_1)
	SetActive(arg_10_0.maskBtn_.gameObject, arg_10_1)
end

function var_0_0.SetSchoolContentActive(arg_11_0, arg_11_1)
	SetActive(arg_11_0.schoolTipsContent_.gameObject, arg_11_1)
	SetActive(arg_11_0.maskBtn_.gameObject, arg_11_1)
end

function var_0_0.RefreshBuffContent(arg_12_0)
	local var_12_0 = ChallengeRogueTeamData:GetBuffItemDataList()

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.buffItemList_) do
		SetActive(iter_12_1.gameObject_, false)
	end

	for iter_12_2, iter_12_3 in ipairs(var_12_0) do
		if not arg_12_0.buffItemList_[iter_12_2] then
			local var_12_1 = GameObject.Instantiate(arg_12_0.buffItemGo_, arg_12_0.buffContentTrs_)
			local var_12_2 = ChallengeRogueTeamBagBuffItem.New(var_12_1)

			arg_12_0.buffItemList_[iter_12_2] = var_12_2
		end

		arg_12_0.buffItemList_[iter_12_2]:SetData(iter_12_2, iter_12_3)
		SetActive(arg_12_0.buffItemList_[iter_12_2].gameObject_, true)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_0.buffContentTrs_)

	arg_12_0.buffScrollRect_.enabled = #var_12_0 > 8

	arg_12_0.bgController_:SetSelectedState(tostring(#var_12_0 > 8))
	arg_12_0.emptyController_:SetSelectedState(tostring(#var_12_0 == 0))
end

function var_0_0.RefreshSchoolContent(arg_13_0)
	local var_13_0 = RogueTeamCfg[ChallengeRogueTeamData:GetCacheTemplateID()].item_temp
	local var_13_1, var_13_2 = ChallengeRogueTeamData:GetAllCampTreasureIDListByTemp(var_13_0)
	local var_13_3

	var_13_3, campCountMap = ChallengeRogueTeamTools.GetTreasureSortedCmapAndCnt(var_13_2)

	for iter_13_0 = 1, #var_13_3 do
		if iter_13_0 > 4 then
			break
		end

		if not arg_13_0.schoolItemList_[iter_13_0] then
			local var_13_4 = Object.Instantiate(arg_13_0.schoolItemGo_, arg_13_0.schoolTipsBGContent_)

			arg_13_0.schoolItemList_[iter_13_0] = ChallengeRogueTeamPathInGameCampTipsItem.New(var_13_4)
		end

		arg_13_0.schoolItemList_[iter_13_0]:SetData(var_13_3[iter_13_0], campCountMap[var_13_3[iter_13_0]])
		SetActive(arg_13_0.schoolItemList_[iter_13_0].gameObject_, true)
	end

	for iter_13_1 = #arg_13_0.schoolItemList_, #var_13_3 + 1, -1 do
		SetActive(arg_13_0.schoolItemList_[iter_13_1].gameObject_, false)
	end

	arg_13_0.schoolEmptyController_:SetSelectedState(tostring(#var_13_3 == 0))
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_0.schoolTipsBGContent_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_0.schoolTipsContent_)
end

function var_0_0.Refresh(arg_14_0)
	local var_14_0, var_14_1, var_14_2, var_14_3 = ChallengeRogueTeamData:GetReserveHeroList()

	for iter_14_0 = 1, 3 do
		arg_14_0.heroItemList_[iter_14_0]:SetData(iter_14_0, var_14_0[iter_14_0], var_14_3[iter_14_0])
	end

	arg_14_0.treasureNumText_.text = #ChallengeRogueTeamData:TreasureGetList()
	arg_14_0.relicNumText_.text = #ChallengeRogueTeamData:UIGetRelicIDList()
end

function var_0_0.RefreshTreasureBox(arg_15_0, arg_15_1)
	arg_15_0.campBoxView_:RefreshTreasure(arg_15_1)

	arg_15_0.treasureNumText_.text = #ChallengeRogueTeamData:TreasureGetList()
end

function var_0_0.RefreshSuitSkillBox(arg_16_0)
	arg_16_0.campBoxView_:RefreshSuitSkill()
end

function var_0_0.Dispose(arg_17_0)
	if arg_17_0.heroItemList_ then
		for iter_17_0, iter_17_1 in ipairs(arg_17_0.heroItemList_) do
			iter_17_1:Dispose()
		end

		arg_17_0.heroItemList_ = nil
	end

	if arg_17_0.buffItemList_ then
		for iter_17_2, iter_17_3 in ipairs(arg_17_0.buffItemList_) do
			iter_17_3:Dispose()
		end

		arg_17_0.buffItemList_ = nil
	end

	if arg_17_0.schoolItemList_ then
		for iter_17_4, iter_17_5 in ipairs(arg_17_0.schoolItemList_) do
			iter_17_5:Dispose()
		end

		arg_17_0.schoolItemList_ = nil
	end

	if arg_17_0.campBoxView_ then
		arg_17_0.campBoxView_:Dispose()

		arg_17_0.campBoxView_ = nil
	end

	var_0_0.super.Dispose(arg_17_0)
	Object.Destroy(arg_17_0.gameObject_)

	arg_17_0.transform_ = nil
	arg_17_0.gameObject_ = nil
end

function var_0_0.ShowBox(arg_18_0)
	if isNil(arg_18_0.gameObject_) then
		arg_18_0:Init()
	end

	SetActive(arg_18_0.gameObject_, true)

	arg_18_0.isShow_ = true

	arg_18_0.transform_:SetAsLastSibling()
	arg_18_0.campBoxView_:ShowTreasure()
	arg_18_0.campBoxView_:ShowSuitSkill()
	arg_18_0:Refresh()
	SetActive(arg_18_0.teamEffectGo_, false)
	SetActive(arg_18_0.relicEffectGo_, false)
	SetActive(arg_18_0.buffEffectGo_, false)
end

function var_0_0.HideBox(arg_19_0)
	arg_19_0:SetBuffContentActive(false)
	arg_19_0:SetSchoolContentActive(false)
	SetActive(arg_19_0.gameObject_, false)

	arg_19_0.isShow_ = false
end

function var_0_0.PlayAddHeroEffect(arg_20_0)
	SetActive(arg_20_0.teamEffectGo_, true)
	manager.ui:UIEventEnabled(false)

	arg_20_0.timer_ = Timer.New(function()
		ChallengeRogueTeamData:RemoveServerTriggerQueue()
		ChallengeRogueTeamAction.RemovePopWindowCnt()
		manager.ui:UIEventEnabled(true)
		SetActive(arg_20_0.teamEffectGo_, false)
		manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW)
	end, 0.5, 1)

	arg_20_0.timer_:Start()
end

function var_0_0.PlayHeroTeamEffect(arg_22_0, arg_22_1)
	for iter_22_0 = 1, 3 do
		arg_22_0.heroItemList_[iter_22_0]:PlayEffect(arg_22_1.value.isAddHp)
	end

	manager.ui:UIEventEnabled(false)

	arg_22_0.timer_ = Timer.New(function()
		ChallengeRogueTeamData:RemoveServerTriggerQueue()
		ChallengeRogueTeamAction.RemovePopWindowCnt()
		manager.ui:UIEventEnabled(true)

		for iter_23_0, iter_23_1 in ipairs(arg_22_1.value.heroHPList) do
			ChallengeRogueTeamData:UISetTeamHPData(iter_23_1.heroID, iter_23_1.tempID, iter_23_1.hpRatio)
		end

		manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW)
	end, 0.5, 1)

	arg_22_0.timer_:Start()
end

function var_0_0.PlayRelicEffect(arg_24_0, arg_24_1)
	SetActive(arg_24_0.relicEffectGo_, true)

	if ChallengeRogueTeamTools.HasNeedShowRelicBuff(arg_24_1.value.itemList) then
		SetActive(arg_24_0.buffEffectGo_, true)
	end

	manager.ui:UIEventEnabled(false)

	local var_24_0 = arg_24_1.value.itemList[1]

	if var_24_0.operate == ChallengeRogueTeamConst.ITEM_OPERATE.ADD then
		for iter_24_0, iter_24_1 in ipairs(arg_24_1.value.itemList) do
			ChallengeRogueTeamData:UIAddRelicID(iter_24_1.id)
		end
	elseif var_24_0.operate == ChallengeRogueTeamConst.ITEM_OPERATE.DELETE then
		for iter_24_2, iter_24_3 in ipairs(arg_24_1.value.itemList) do
			ChallengeRogueTeamData:UIRemoveRelicID(iter_24_3.id)
		end
	end

	arg_24_0.relicNumText_.text = #ChallengeRogueTeamData:UIGetRelicIDList()
	arg_24_0.timer_ = Timer.New(function()
		ChallengeRogueTeamData:RemoveServerTriggerQueue()
		ChallengeRogueTeamAction.RemovePopWindowCnt()
		manager.ui:UIEventEnabled(true)
		SetActive(arg_24_0.relicEffectGo_, false)
		SetActive(arg_24_0.buffEffectGo_, false)
		manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW)
	end, 0.5, 1)

	arg_24_0.timer_:Start()
end

function var_0_0.PlayBuffEffect(arg_26_0)
	SetActive(arg_26_0.buffEffectGo_, true)
	manager.ui:UIEventEnabled(false)

	arg_26_0.timer_ = Timer.New(function()
		ChallengeRogueTeamData:RemoveServerTriggerQueue()
		ChallengeRogueTeamAction.RemovePopWindowCnt()
		manager.ui:UIEventEnabled(true)
		SetActive(arg_26_0.buffEffectGo_, false)
		manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW)
	end, 0.5, 1)

	arg_26_0.timer_:Start()
end

return var_0_0
