local HodurMainlineView = class("HodurMainlineView", ReduxView)

function HodurMainlineView:UIName()
	return "Widget/System/Activity_Hodur/Activity_Hodur_CheckpointMainUI"
end

function HodurMainlineView:UIParent()
	return manager.ui.uiMain.transform
end

function HodurMainlineView:Init()
	self:InitUI()
	self:AddUIListener()

	self.chapterID_ = nil
	self.stageList_ = {}
	self.contentItemList_ = {}
	self.heroInfoModule_ = HodurMainlineHeroModule.New(self.heroModuleGo_)
	self.selectModule_ = HodurSelectModule.New(self.eventModuleGo_)
	self.selectController_ = self.mainControllerEx_:GetController("select")
end

function HodurMainlineView:InitUI()
	self:BindCfgUI()
end

function HodurMainlineView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self.scrollView_.enabled = true

		if self.isOpenInfoView_ then
			self:ShowSelectView(false)
		end
	end)
	self:AddBtnListener(self.resetBtn_, nil, function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("HODUR_RESET_CHAPTER_TIP"),
			OkCallback = function()
				HodurAction.ResetChapter(self.chapterID_)
				self:RefreshUI()
			end,
			CancelCallback = function()
				return
			end
		})
	end)
end

function HodurMainlineView:OnEnter()
	self.scrollView_.enabled = true

	SetActive(self.affixFlyGo_, false)

	self.chapterID_ = self.params_.chapter_id
	self.activityID_ = self.params_.activity_id
	self.stageList_ = ActivityHodurChapterCfg[self.chapterID_].stage_list

	self:RefreshUI()
	self:ShowSelectView(false)

	if not self.isSelect then
		self.content1_.transform.localPosition = Vector3(HodurSystemData:GetCachePos(self.chapterID_) or 0, self.content1_.transform.localPosition.y, self.content1_.transform.localPosition.z)
	end
end

function HodurMainlineView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function HodurMainlineView:OnBehind()
	manager.windowBar:HideBar()
end

function HodurMainlineView:OnExit()
	self.heroInfoModule_:ShowTips(false)
	self:RemoveTween()
	self:CachePos()
end

function HodurMainlineView:RefreshUI()
	self:RefreshStageList()
	self:RefreshHeroInfo()
end

function HodurMainlineView:RefreshStageList()
	local var_15_9001
	local var_15_9000
	local var_15_0 = #self.stageList_ or 0

	for iter_15_0, iter_15_1 in ipairs(self.stageList_) do
		if self.contentItemList_[iter_15_0] == nil then
			self.contentItemList_[iter_15_0] = HodurMainlineContentItem.New((Object.Instantiate(self.contentItemGo_, self.contentTrs_)))
		end

		self.contentItemList_[iter_15_0]:SetData(var_15_9001, var_15_9000, iter_15_0, iter_15_0 == var_15_0, self.chapterID_)
		self.contentItemList_[iter_15_0]:SetCallback(handler(self, self.OnClickStage), handler(self, self.OnClickEvent))
		self.contentItemList_[iter_15_0]:SetActive(true)
	end

	for iter_15_2 = var_15_0 + 1, #self.contentItemList_ do
		self.contentItemList_[iter_15_2]:SetActive(false)
	end

	if HodurTools.GetChapterStateEmpty(self.chapterID_) then
		SetActive(self.resetBtn_.gameObject, false)
	else
		SetActive(self.resetBtn_.gameObject, true)
	end
end

function HodurMainlineView:RefreshHeroInfo()
	self.heroInfoModule_:SetData(self.chapterID_)
end

function HodurMainlineView:OnClickStage(arg_17_1)
	if not HodurTools.GetStageUnlock(arg_17_1, self.chapterID_) then
		local var_17_0, var_17_1, var_17_2 = HodurTools.GetStageUnlock(arg_17_1, self.chapterID_)

		if var_17_1 and not var_17_2 then
			ShowTips(string.format(GetTips("HODUR_STAGE_LOCK"), ActivityHodurEventCfg[ActivityHodurCfg[arg_17_1].event_lock].event_title))

			return
		end

		ShowTips(GetTips("ACTIVITY_MONSTER_COSPLAY_STAGE_CONDITION"))

		return
	end

	self.selectModule_:SetData(HodurConst.INFO_VIEW_TYPE.STAGE, arg_17_1, self.chapterID_)

	for iter_17_0, iter_17_1 in pairs(self.contentItemList_) do
		if iter_17_1:SetSelect(HodurConst.INFO_VIEW_TYPE.STAGE, arg_17_1) then
			self:OnSelectLevelItem(iter_17_1)
		end
	end

	self:ShowSelectView(true)
end

function HodurMainlineView:OnClickEvent(arg_18_1)
	self.selectModule_:SetData(HodurConst.INFO_VIEW_TYPE.EVENT, arg_18_1, self.chapterID_)

	for iter_18_0, iter_18_1 in pairs(self.contentItemList_) do
		if iter_18_1:SetSelect(HodurConst.INFO_VIEW_TYPE.EVENT, arg_18_1) then
			self:OnSelectLevelItem(iter_18_1)
		end
	end

	self:ShowSelectView(true)
end

function HodurMainlineView:ShowSelectView(arg_19_1)
	self.isOpenInfoView_ = arg_19_1

	if arg_19_1 then
		self.selectController_:SetSelectedState("show")
		self.selectModule_:OnEnter()
	else
		self.selectController_:SetSelectedState("hide")

		for iter_19_0, iter_19_1 in pairs(self.contentItemList_) do
			iter_19_1:SetSelectFalse()
		end

		self.selectModule_:OnExit()
	end

	self.isSelect = arg_19_1
end

function HodurMainlineView:OnSelectLevelItem(arg_20_1)
	if arg_20_1 then
		self.isSelect = true
		self.scrollView_.enabled = false

		self:RemoveTween()

		self.tween_ = LeanTween.value(self.content1_, self.content1_.transform.localPosition.x, -arg_20_1.transform_.localPosition.x + self.scrollViewTrans_.rect.width / 2 - arg_20_1.transform_.rect.width / 2, 0.2):setOnUpdate(LuaHelper.FloatAction(function(arg_21_0)
			self.content1_.transform.localPosition = Vector3(arg_21_0, 0, 0)
		end))
	end
end

function HodurMainlineView:CachePos()
	HodurSystemData:CachePos(self.chapterID_, self.content1_.transform.localPosition.x)
end

function HodurMainlineView:AffixFly(arg_23_1)
	self.affixFlyGo_.transform.position = self["affixFlyFormTrs_" .. arg_23_1].position

	SetActive(self.affixFlyGo_, true)
	LeanTween.move(self.affixFlyGo_, self.affixFlyTargetTrs_.position, 0.4):setEase(LeanTweenType.easeOutCubic):setOnComplete(LuaHelper.VoidAction(function()
		SetActive(self.affixFlyGo_, false)
	end))
end

function HodurMainlineView:RemoveTween()
	if self.tween_ then
		self.tween_:setOnUpdate(nil)
		LeanTween.cancel(self.content1_)

		self.tween_ = nil
	end
end

function HodurMainlineView:OnHodurSelectEvent(arg_26_1)
	self:AffixFly(arg_26_1)
	self.selectModule_:RefreshEventUI()
	self:RefreshUI()
end

function HodurMainlineView:OnHodurResetChapter()
	self:RefreshUI()
end

function HodurMainlineView:Dispose()
	self:RemoveTween()

	if self.heroInfoModule_ then
		self.heroInfoModule_:Dispose()

		self.heroInfoModule_ = nil
	end

	if self.eventModule_ then
		self.eventModule_:Dispose()

		self.eventModule_ = nil
	end

	if self.selectModule_ then
		self.selectModule_:Dispose()

		self.selectModule_ = nil
	end

	for iter_28_0, iter_28_1 in pairs(self.contentItemList_) do
		iter_28_1:Dispose()
	end

	self.contentItemList_ = {}

	HodurMainlineView.super.Dispose(self)
	self:RemoveAllListeners()
end

return HodurMainlineView
