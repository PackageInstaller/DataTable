local SummerPubStageSectionView = class("SummerPubStageSectionView", ReduxView)

function SummerPubStageSectionView:UIName()
	return "Widget/System/Activity_SummerPub/MainPub/Activity_SummerPub_StageBaseUI"
end

function SummerPubStageSectionView:UIParent()
	return manager.ui.uiMain.transform
end

function SummerPubStageSectionView:Init()
	self:InitUI()
	self:AddListeners()
end

function SummerPubStageSectionView:InitUI()
	self:BindCfgUI()

	self.foodList_ = LuaList.New(handler(self, self.RefreshRewardItem), self.rewardUIListGo_, SummerCookMenuFoodItem)
	self.hideDropPanelCtr_ = self.controllerEx_:GetController("hideDropPanel")
	self.hideStafeDescCtr_ = self.controllerEx_:GetController("hideStageDesc")
	self.stageBgCtr_ = self.controllerEx_:GetController("stageBg")
	self.startBtnLockCtr_ = self.controllerEx_:GetController("startBtnLock")
	self.hideAreaBtnCtr_ = self.controllerEx_:GetController("hideAreaBtn")
	self.tipsController_ = self.controllerEx_:GetController("tips")
	self.StageIndex_ = 1
end

function SummerPubStageSectionView:AddListeners()
	self:AddBtnListener(self.battleBtn_, nil, function()
		self.Back()
		SummerPubAction.OpenBattle(self.levelID_, self.StageIndex_, self.stageType_)
	end)
	self:AddBtnListener(self.hardBattleBtn_, nil, function()
		self.Back()
		SummerPubAction.OpenBattle(self.levelID_, self.StageIndex_, self.stageType_)
	end)
	self:AddBtnListener(self.areaBtn1_, nil, function()
		self:setDefaultStage()
		self:unlockDifficultBtn()
	end)
	self:AddBtnListener(self.areaBtn2_, nil, function()
		if SummerPubData:GetClearNumByStageID(self.levelID_, SummerPubConst.PIN_BALL_STAGE_TYPE.NORMAL) > 0 then
			self.StageIndex_ = 2

			self.stageBgCtr_:SetSelectedState("hard")
			self.areaBtnCtr2_:GetController("default"):SetSelectedState("select")
			self.areaBtnCtr1_:GetController("default"):SetSelectedState("default")
			self.startBtnLockCtr_:SetSelectedState("hard")
			self.hideDropPanelCtr_:SetSelectedState("true")
		else
			ShowTips(string.format(GetTips("NYA_SUMMER_CHALLENGE_LOCKED")))
		end
	end)
	self:AddBtnListener(self.btnMask_, nil, function()
		self:OnMaskClick()
	end)
end

function SummerPubStageSectionView:setDefaultStage()
	self.StageIndex_ = 1

	self.stageBgCtr_:SetSelectedState("default")
	self.areaBtnCtr1_:GetController("default"):SetSelectedState("select")

	if not SummerPubData:GetLevelIDIsOpen(self.levelID_) then
		self.startBtnLockCtr_:SetSelectedState("true")
	elseif self.StageIndex_ == SummerPubConst.PIN_BALL_STAGE_TYPE.HARD then
		self.startBtnLockCtr_:SetSelectedState("hard")
	else
		self.startBtnLockCtr_:SetSelectedState("false")
	end

	if self.systemCfg_.drop_lib_id == 0 then
		self.hideDropPanelCtr_:SetSelectedState("true")
	else
		self.hideDropPanelCtr_:SetSelectedState("false")
	end
end

function SummerPubStageSectionView:OnEnter()
	self.levelID_ = self.params_.levelID
	self.systemCfg_ = SummerPubLevelCfg[self.levelID_]
	self.stageType_ = self.params_.battleType

	self:RefreshData()
	self:RefreshUI()
end

function SummerPubStageSectionView:OnEnterOver()
	self:unlockDifficultBtn()
end

function SummerPubStageSectionView:unlockDifficultBtn()
	if SummerPubData:GetClearNumByStageID(self.levelID_, SummerPubConst.PIN_BALL_STAGE_TYPE.NORMAL) > 0 then
		self.areaBtnCtr2_:GetController("default"):SetSelectedState("default")

		if (getData("summer_pub_main", "stage_anim_" .. self.levelID_) or 0) == 0 then
			self.areaUnlockAnim_:Play("UI_areaBtn02_cx", 0, 0)
			self.areaUnlockAnim_:Update(0)
			saveData("summer_pub_main", "stage_anim_" .. self.levelID_, 1)
		end
	else
		self.areaBtnCtr2_:GetController("default"):SetSelectedState("lock")
	end
end

function SummerPubStageSectionView:OnTop()
	self.tipsController_:SetSelectedState(tostring(false))
end

function SummerPubStageSectionView:OnUpdate()
	if self.levelID_ == self.params_.levelID then
		return
	end

	self.levelID_ = self.params_.levelID
	self.systemCfg_ = SummerPubLevelCfg[self.levelID_]

	self:RefreshData()
	self:RefreshUI()
	self:unlockDifficultBtn()
end

function SummerPubStageSectionView:RefreshData()
	self.sectionName_.text = GetI18NText(self.systemCfg_.name)
	self.sectionImage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, self.systemCfg_.background_1))
	self.textStory_.text = GetI18NText(self.systemCfg_.tips)

	self:setDefaultStage()

	if self.systemCfg_.type ~= SummerPubConst.STAGE_TYPE.BALL then
		self.hideAreaBtnCtr_:SetSelectedState("true")
	else
		self.hideAreaBtnCtr_:SetSelectedState("false")
	end

	self.isFirstClear_ = true
end

function SummerPubStageSectionView:RefreshReward()
	self.rewardList_ = getRewardFromDropCfg(self.systemCfg_.drop_lib_id, self.isFirstClear_)

	self.foodList_:StartScroll(#self.rewardList_)
end

function SummerPubStageSectionView:HaveCostCntFlag()
	return false
end

function SummerPubStageSectionView:RefreshUI()
	self:RefreshReward()
end

function SummerPubStageSectionView:RefreshRewardItem(arg_21_1, arg_21_2)
	arg_21_2:RegisterClick(handler(self, self.OnFoodClick))
	arg_21_2:SetData(self.rewardList_[arg_21_1].id)
	arg_21_2:RefreshUnlockContronl(true)

	if SummerPubData:GetClearNumByStageID(self.levelID_, self.StageIndex_) > 0 then
		arg_21_2:RefreshDoneContronl(true)
	else
		arg_21_2:RefreshDoneContronl(false)
	end
end

function SummerPubStageSectionView:OnExit()
	manager.windowBar:HideBar()
end

function SummerPubStageSectionView:Dispose()
	self.foodList_:Dispose()

	self.foodList_ = nil

	SummerPubStageSectionView.super.Dispose(self)
end

function SummerPubStageSectionView:OnFoodClick(arg_24_1, arg_24_2)
	self.selectedItemId_ = arg_24_1

	self.tipsController_:SetSelectedState(tostring(arg_24_2))

	if arg_24_2 then
		self.foodName_.text = ItemCfg[arg_24_1].name
		self.foodDesc_.text = ItemCfg[arg_24_1].desc
	end
end

function SummerPubStageSectionView:OnMaskClick()
	for iter_25_0, iter_25_1 in pairs((self.foodList_:GetItemList())) do
		iter_25_1:RefreshSelect(false)
	end

	self.tipsController_:SetSelectedState(tostring(false))

	self.selectedItemId_ = nil
end

return SummerPubStageSectionView
