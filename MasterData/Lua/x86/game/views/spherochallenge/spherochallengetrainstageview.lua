local SPHeroChallengeTrainStageView = class("SPHeroChallengeTrainStageView", ReduxView)

function SPHeroChallengeTrainStageView:UIName()
	return "Widget/System/SPHeroChallenge/SPHeroChallengeTrainStageUI"
end

function SPHeroChallengeTrainStageView:UIParent()
	return manager.ui.uiMain.transform
end

function SPHeroChallengeTrainStageView:OnCtor()
	return
end

function SPHeroChallengeTrainStageView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SPHeroChallengeTrainStageView:InitUI()
	self:BindCfgUI()

	self.offsetController = self.controller:GetController("offset")
	self.stateController = self.controller:GetController("state")
	self.affixItem = {}

	for iter_5_0 = 1, 3 do
		self.affixItem[iter_5_0] = SPHeroChallengeAffixItem.New(self["progressdesc" .. iter_5_0 .. "Go_"])

		self.affixItem[iter_5_0]:SetClickListener(function()
			self:CloseAllAffix()
		end)
	end
end

function SPHeroChallengeTrainStageView:CloseAllAffix()
	for iter_7_0, iter_7_1 in ipairs(self.affixItem) do
		iter_7_1:CloseAffix()
	end
end

function SPHeroChallengeTrainStageView:OnEnter()
	self.trainType = self.params_.trainType

	if self.params_.playAnimation then
		self.animator:Play("Fx_SPHeroChallengeTrainStageUI_cx", 0, 0)

		self.params_.playAnimation = nil
	end

	self.activityID = SPHeroChallengeData:GetActivityID()
	self.info = SPHeroChallengeData:GetCurActivityInfo()

	self:RefreshProficiency()
	self:RefreshTrainEffectDesc()
	self:RefreshStageInfo()
	self:RefreshBar()
	self:RefreshBackBtnState()
	self:RefreshTrainIconAndName()
end

function SPHeroChallengeTrainStageView:OnTop()
	return
end

function SPHeroChallengeTrainStageView:OnBehind()
	self:RefreshBackBtnState()
end

function SPHeroChallengeTrainStageView:RefreshBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.OpenPageByJump("/spHeroChallengeBattleToggleView", {
			groupIndex = SpHeroChallengeConst.ChapterType.train
		})
	end)
end

function SPHeroChallengeTrainStageView:OnExit()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
end

function SPHeroChallengeTrainStageView:AddUIListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		if self:IsOpenSectionView() then
			self:Back()
			self:RefreshBackBtnState()
		end
	end)
end

function SPHeroChallengeTrainStageView:RegisterEvents()
	return
end

function SPHeroChallengeTrainStageView:Dispose()
	if self.stageInfoList then
		for iter_17_0, iter_17_1 in pairs(self.stageInfoList) do
			iter_17_1:Dispose()
		end
	end

	if self.affixItem then
		for iter_17_2, iter_17_3 in ipairs(self.affixItem) do
			iter_17_3:Dispose()
		end
	end

	SPHeroChallengeTrainStageView.super.Dispose(self)
end

function SPHeroChallengeTrainStageView:RefreshProficiency()
	if self.info then
		local var_18_0, var_18_1 = self.info:GetTrainNumByType(self.trainType)

		self.sliderSlr_.value = string.format("%.2f", var_18_0 / var_18_1)
		self.curNumText_.text = math.min(var_18_0, var_18_1)
	end
end

function SPHeroChallengeTrainStageView:RefreshTrainEffectDesc()
	if self.affixItem then
		for iter_19_0, iter_19_1 in ipairs(self.affixItem) do
			iter_19_1:RefreshUI(self.trainType, iter_19_0)
		end
	end
end

function SPHeroChallengeTrainStageView:RefreshStageInfo()
	if not self.stageInfoList then
		self.stageInfoList = {}

		for iter_20_0 = 1, #BattleVerthandiExclusiveCfg.get_id_list_by_sub_type[self.trainType] do
			self.stageInfoList[iter_20_0] = SPHeroChallengeTrainStageItem.New(self["trainstageitem" .. iter_20_0 .. "Go_"])
		end
	end

	for iter_20_1 = 1, #BattleVerthandiExclusiveCfg.get_id_list_by_sub_type[self.trainType] do
		self.stageInfoList[iter_20_1]:RefreshUI(BattleVerthandiExclusiveCfg.get_id_list_by_sub_type[self.trainType][iter_20_1], self.stageID, iter_20_1)
		self.stageInfoList[iter_20_1]:RegisterClickCallBack(handler(self, self.ClickStageHandle))
	end
end

function SPHeroChallengeTrainStageView:ClickStageHandle(arg_21_1, arg_21_2)
	self.stageID = arg_21_1
	self.selectIndex = arg_21_2

	JumpTools.OpenPageByJump("spHeroChallengeSectionView", {
		section = self.stageID,
		sectionType = BattleConst.STAGE_TYPE_NEW.SP_HERO_CHALLENGE_BATTLE_3_1,
		activityId = self.params_.activityId,
		challengeType = SpHeroChallengeConst.ChapterType.train
	})
	self:RefreshBackBtnState(arg_21_2)
	self:RefreshStageInfo()
end

function SPHeroChallengeTrainStageView:IsOpenSectionView()
	return self:IsOpenRoute("spHeroChallengeSectionView")
end

function SPHeroChallengeTrainStageView:RefreshBackBtnState()
	if self:IsOpenSectionView() then
		SetActive(self.backBtn_.gameObject, true)

		if self.selectIndex then
			self.offsetController:SetSelectedState(tostring(self.selectIndex))
		end
	else
		SetActive(self.backBtn_.gameObject, false)
		self.offsetController:SetSelectedState("ori")
	end
end

function SPHeroChallengeTrainStageView:RefreshTrainIconAndName()
	local var_24_0, var_24_1 = SPHeroChallengeTools:GetTrainNameAndIcon(self.trainType)

	self.name.text = var_24_0
	self.icon.sprite = var_24_1
	self.descText_.text = var_24_0 .. GetTips("TIP_CLEARTIMES")

	self.stateController:SetSelectedState(tostring(self.trainType))
end

return SPHeroChallengeTrainStageView
