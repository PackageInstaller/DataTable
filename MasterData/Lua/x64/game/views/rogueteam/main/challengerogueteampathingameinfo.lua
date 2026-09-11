local ChallengeRogueTeamPathInGameInfo = class("ChallengeRogueTeamPathInGameInfo", ReduxView)

function ChallengeRogueTeamPathInGameInfo:UIName()
	return "Widget/System/Activity_Roulike/item/RoulikeInGameInfoBox"
end

function ChallengeRogueTeamPathInGameInfo:Init()
	self.gameObject_ = GameObject.Instantiate(Asset.Load(self:UIName()), manager.ui.uiPop.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AdaptScreen()

	self.heroItemList_ = {}

	for iter_2_0 = 1, 3 do
		self.heroItemList_[iter_2_0] = ChallengeRogueTeamPathHero.New(self["heroItemGo" .. iter_2_0 .. "_"])
	end

	self.buffItemList_ = {}
	self.schoolItemList_ = {}

	self:AddUIListener()
	self:SetBuffContentActive(false)
	self:SetSchoolContentActive(false)

	self.bgController_ = self.controller_:GetController("bg")
	self.emptyController_ = self.controller_:GetController("empty")
	self.schoolEmptyController_ = self.controller_:GetController("empty01")
	self.campBoxView_ = ChallengeRogueTeamCampBox.New(self.suitSkillGo_)
end

function ChallengeRogueTeamPathInGameInfo:AddUIListener()
	self:AddBtnListener(self.schoolBtn_, nil, function()
		if ChallengeRogueTeamData:SuitSkillGetID() ~= 0 then
			JumpTools.OpenPageByJump("/challengeRogueTeamBag", {
				leftTabIndex = 2,
				tabIndex = 1
			})
		else
			self:SetSchoolContentActive(true)
			self:RefreshSchoolContent()
		end
	end)
	self:AddBtnListener(self.treasureBtn_, nil, function()
		JumpTools.OpenPageByJump("/challengeRogueTeamBag", {
			leftTabIndex = 2,
			tabIndex = 1
		})
	end)
	self:AddBtnListener(self.relicBtn_, nil, function()
		JumpTools.OpenPageByJump("/challengeRogueTeamBag", {
			leftTabIndex = 3
		})
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:SetBuffContentActive(false)
		self:SetSchoolContentActive(false)
	end)
	self:AddBtnListener(self.buffBtn_, nil, function()
		if not self.buffTipGo_.activeInHierarchy then
			self:RefreshBuffContent()
		end

		self:SetBuffContentActive(true)
	end)
	self:AddBtnListener(self.teamBtn_, nil, function()
		self:Go("/challengeRogueTeamSectionSelectHero", {
			heroModify = true,
			sectionType = BattleConst.STAGE_TYPE_NEW.CHALLENGE_ROGUE_TEAM,
			heroDataType = HeroConst.HERO_DATA_TYPE.CHALLENGEROUGETEAM,
			reserveParams = ReserveParams.New(ReserveConst.RESERVE_TYPE.CHALLENGE_ROGUE_TEAM, 0, 1, {
				stageType = BattleConst.STAGE_TYPE_NEW.CHALLENGE_ROGUE_TEAM
			})
		})
	end)
end

function ChallengeRogueTeamPathInGameInfo:SetBuffContentActive(arg_10_1)
	SetActive(self.buffTipGo_, arg_10_1)
	SetActive(self.maskBtn_.gameObject, arg_10_1)
end

function ChallengeRogueTeamPathInGameInfo:SetSchoolContentActive(arg_11_1)
	SetActive(self.schoolTipsContent_.gameObject, arg_11_1)
	SetActive(self.maskBtn_.gameObject, arg_11_1)
end

function ChallengeRogueTeamPathInGameInfo:RefreshBuffContent()
	local var_12_0 = ChallengeRogueTeamData:GetBuffItemDataList()

	for iter_12_0, iter_12_1 in ipairs(self.buffItemList_) do
		SetActive(iter_12_1.gameObject_, false)
	end

	for iter_12_2, iter_12_3 in ipairs(var_12_0) do
		self.buffItemList_[iter_12_2] = self.buffItemList_[iter_12_2] or ChallengeRogueTeamBagBuffItem.New((GameObject.Instantiate(self.buffItemGo_, self.buffContentTrs_)))

		self.buffItemList_[iter_12_2]:SetData(iter_12_2, iter_12_3)
		SetActive(self.buffItemList_[iter_12_2].gameObject_, true)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.buffContentTrs_)

	self.buffScrollRect_.enabled = #var_12_0 > 8

	self.bgController_:SetSelectedState(tostring(#var_12_0 > 8))
	self.emptyController_:SetSelectedState(tostring(#var_12_0 == 0))
end

function ChallengeRogueTeamPathInGameInfo:RefreshSchoolContent()
	local var_13_0, var_13_1 = ChallengeRogueTeamData:GetAllCampTreasureIDListByTemp(RogueTeamCfg[ChallengeRogueTeamData:GetCacheTemplateID()].item_temp)
	local var_13_2

	var_13_2, campCountMap = ChallengeRogueTeamTools.GetTreasureSortedCmapAndCnt(var_13_1)

	for iter_13_0 = 1, #var_13_2 do
		if iter_13_0 > 4 then
			break
		end

		self.schoolItemList_[iter_13_0] = self.schoolItemList_[iter_13_0] or ChallengeRogueTeamPathInGameCampTipsItem.New((Object.Instantiate(self.schoolItemGo_, self.schoolTipsBGContent_)))

		self.schoolItemList_[iter_13_0]:SetData(var_13_2[iter_13_0], campCountMap[var_13_2[iter_13_0]])
		SetActive(self.schoolItemList_[iter_13_0].gameObject_, true)
	end

	for iter_13_1 = #self.schoolItemList_, #var_13_2 + 1, -1 do
		SetActive(self.schoolItemList_[iter_13_1].gameObject_, false)
	end

	self.schoolEmptyController_:SetSelectedState(tostring(#var_13_2 == 0))
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.schoolTipsBGContent_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.schoolTipsContent_)
end

function ChallengeRogueTeamPathInGameInfo:Refresh()
	local var_14_0, var_14_1, var_14_2, var_14_3 = ChallengeRogueTeamData:GetReserveHeroList()

	for iter_14_0 = 1, 3 do
		self.heroItemList_[iter_14_0]:SetData(iter_14_0, var_14_0[iter_14_0], var_14_3[iter_14_0])
	end

	self.treasureNumText_.text = #ChallengeRogueTeamData:TreasureGetList()
	self.relicNumText_.text = #ChallengeRogueTeamData:UIGetRelicIDList()
end

function ChallengeRogueTeamPathInGameInfo:RefreshTreasureBox(arg_15_1)
	self.campBoxView_:RefreshTreasure(arg_15_1)

	self.treasureNumText_.text = #ChallengeRogueTeamData:TreasureGetList()
end

function ChallengeRogueTeamPathInGameInfo:RefreshSuitSkillBox()
	self.campBoxView_:RefreshSuitSkill()
end

function ChallengeRogueTeamPathInGameInfo:Dispose()
	if self.heroItemList_ then
		for iter_17_0, iter_17_1 in ipairs(self.heroItemList_) do
			iter_17_1:Dispose()
		end

		self.heroItemList_ = nil
	end

	if self.buffItemList_ then
		for iter_17_2, iter_17_3 in ipairs(self.buffItemList_) do
			iter_17_3:Dispose()
		end

		self.buffItemList_ = nil
	end

	if self.schoolItemList_ then
		for iter_17_4, iter_17_5 in ipairs(self.schoolItemList_) do
			iter_17_5:Dispose()
		end

		self.schoolItemList_ = nil
	end

	if self.campBoxView_ then
		self.campBoxView_:Dispose()

		self.campBoxView_ = nil
	end

	ChallengeRogueTeamPathInGameInfo.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function ChallengeRogueTeamPathInGameInfo:ShowBox()
	if isNil(self.gameObject_) then
		self:Init()
	end

	SetActive(self.gameObject_, true)

	self.isShow_ = true

	self.transform_:SetAsLastSibling()
	self.campBoxView_:ShowTreasure()
	self.campBoxView_:ShowSuitSkill()
	self:Refresh()
	SetActive(self.teamEffectGo_, false)
	SetActive(self.relicEffectGo_, false)
	SetActive(self.buffEffectGo_, false)
end

function ChallengeRogueTeamPathInGameInfo:HideBox()
	self:SetBuffContentActive(false)
	self:SetSchoolContentActive(false)
	SetActive(self.gameObject_, false)

	self.isShow_ = false
end

function ChallengeRogueTeamPathInGameInfo:PlayAddHeroEffect()
	SetActive(self.teamEffectGo_, true)
	manager.ui:UIEventEnabled(false)

	self.timer_ = Timer.New(function()
		ChallengeRogueTeamData:RemoveServerTriggerQueue()
		ChallengeRogueTeamAction.RemovePopWindowCnt()
		manager.ui:UIEventEnabled(true)
		SetActive(self.teamEffectGo_, false)
		manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW)
	end, 0.5, 1)

	self.timer_:Start()
end

function ChallengeRogueTeamPathInGameInfo:PlayHeroTeamEffect(arg_22_1)
	for iter_22_0 = 1, 3 do
		self.heroItemList_[iter_22_0]:PlayEffect(arg_22_1.value.isAddHp)
	end

	manager.ui:UIEventEnabled(false)

	self.timer_ = Timer.New(function()
		ChallengeRogueTeamData:RemoveServerTriggerQueue()
		ChallengeRogueTeamAction.RemovePopWindowCnt()
		manager.ui:UIEventEnabled(true)

		for iter_23_0, iter_23_1 in ipairs(arg_22_1.value.heroHPList) do
			ChallengeRogueTeamData:UISetTeamHPData(iter_23_1.heroID, iter_23_1.tempID, iter_23_1.hpRatio)
		end

		manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW)
	end, 0.5, 1)

	self.timer_:Start()
end

function ChallengeRogueTeamPathInGameInfo:PlayRelicEffect(arg_24_1)
	SetActive(self.relicEffectGo_, true)

	if ChallengeRogueTeamTools.HasNeedShowRelicBuff(arg_24_1.value.itemList) then
		SetActive(self.buffEffectGo_, true)
	end

	manager.ui:UIEventEnabled(false)

	if arg_24_1.value.itemList[1].operate == ChallengeRogueTeamConst.ITEM_OPERATE.ADD then
		for iter_24_0, iter_24_1 in ipairs(arg_24_1.value.itemList) do
			ChallengeRogueTeamData:UIAddRelicID(iter_24_1.id)
		end
	elseif arg_24_1.value.itemList[1].operate == ChallengeRogueTeamConst.ITEM_OPERATE.DELETE then
		for iter_24_2, iter_24_3 in ipairs(arg_24_1.value.itemList) do
			ChallengeRogueTeamData:UIRemoveRelicID(iter_24_3.id)
		end
	end

	self.relicNumText_.text = #ChallengeRogueTeamData:UIGetRelicIDList()
	self.timer_ = Timer.New(function()
		ChallengeRogueTeamData:RemoveServerTriggerQueue()
		ChallengeRogueTeamAction.RemovePopWindowCnt()
		manager.ui:UIEventEnabled(true)
		SetActive(self.relicEffectGo_, false)
		SetActive(self.buffEffectGo_, false)
		manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW)
	end, 0.5, 1)

	self.timer_:Start()
end

function ChallengeRogueTeamPathInGameInfo:PlayBuffEffect()
	SetActive(self.buffEffectGo_, true)
	manager.ui:UIEventEnabled(false)

	self.timer_ = Timer.New(function()
		ChallengeRogueTeamData:RemoveServerTriggerQueue()
		ChallengeRogueTeamAction.RemovePopWindowCnt()
		manager.ui:UIEventEnabled(true)
		SetActive(self.buffEffectGo_, false)
		manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW)
	end, 0.5, 1)

	self.timer_:Start()
end

return ChallengeRogueTeamPathInGameInfo
