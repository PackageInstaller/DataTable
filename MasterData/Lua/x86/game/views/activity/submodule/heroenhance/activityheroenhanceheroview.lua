local ActivityHeroEnhanceHeroView = class("ActivityHeroEnhanceHeroView", ReduxView)

function ActivityHeroEnhanceHeroView:UIName()
	return ActivityHeroEnhanceTools.GetHeroUIName(self.params_.activityID)
end

function ActivityHeroEnhanceHeroView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityHeroEnhanceHeroView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ActivityHeroEnhanceHeroView:InitUI()
	self:BindCfgUI()

	self.heroList_ = LuaList.New(handler(self, self.IndexHeroItem), self.heroUiListGo_, ActivityHeroEnhanceHeroItem)
	self.middleView_ = ActivityHeroEnhanceTalentView.New(self.talentUIGo_)
	self.detailView_ = ActivityHeroEnhanceTalentDetailView.New(self.talentDetailGo_)
	self.statusController_ = self.controller_:GetController("status")

	self.statusController_:SetSelectedState("main")
	SetActive(self.talentDetailGo_, false)
end

function ActivityHeroEnhanceHeroView:AddUIListener()
	self:AddBtnListener(nil, self.goBtn_, function()
		self:OnClickGoBtn()
	end)
	self:AddBtnListener(nil, self.bgBtn_, function()
		self:OnClickBgBtn()
	end)
	self.middleView_:SetClickTalentHandler(function(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
		if arg_8_2 then
			self:SelectGroup(arg_8_1)
		else
			arg_8_0:SelectIdx(arg_8_5)
			self:SelectTalent(arg_8_4)

			self.lastTalentIdx_ = arg_8_5
		end
	end)
	self.detailView_:SetClickBtnHandler(function(arg_9_0, arg_9_1)
		if arg_9_0 then
			self:OnClickUseTalent(arg_9_1)
		else
			self:OnClickDropTalent(arg_9_1)
		end
	end)
end

function ActivityHeroEnhanceHeroView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		self:Back()
	end)

	self.activityId_ = self.params_.activityID
	self.cfgIdList_ = ActivityHeroEnhanceTools.GetCfgIdList(self.activityId_)

	if not self.cfgId_ then
		if ActivityHeroEnhanceHeroView.enterBattleCfgId_ then
			self.cfgId_ = ActivityHeroEnhanceHeroView.enterBattleCfgId_
			ActivityHeroEnhanceHeroView.enterBattleCfgId_ = nil

			self:SelectHero((table.indexof(self.cfgIdList_, self.cfgId_)))
		else
			self.cfgId_ = self.cfgIdList_[1]
		end
	end

	local var_10_0 = self.params_.stageToView
	local var_10_1 = self.params_.talentIdToView

	if self.params_.talentIdToView or var_10_0 then
		self.cfgId_ = self.params_.cfgId

		local var_10_2 = ActivityHeroEnhanceTools.GetCfgTalentListByStage(ActivityHeroEnhanceCfg[self.cfgId_], var_10_0)

		var_10_1 = var_10_1 or var_10_2[1]

		self:SelectGroup(var_10_0, (table.indexof(var_10_2, var_10_1)))

		self.params_.talentIdToView = nil
		self.params_.stageToView = nil
		self.params_.cfgId = nil
		self.section_CfgId_ = self.cfgId_
		self.cfgIdList_ = {
			self.section_CfgId_
		}
	else
		self:OnClickBgBtn()
	end

	self:RefreshUI()
	self.middleView_:OnEnter()
end

function ActivityHeroEnhanceHeroView:OnExit()
	manager.windowBar:HideBar()
	self:UpdateRedPointUI(true)
	self.middleView_:OnExit()

	self.lastGroupIdx_ = nil
	self.lastTalentIdx_ = nil
end

function ActivityHeroEnhanceHeroView:RefreshUI()
	self.heroList_:StartScroll(#self.cfgIdList_)
end

function ActivityHeroEnhanceHeroView:IndexHeroItem(arg_14_1, arg_14_2)
	arg_14_2:SetData(self.cfgIdList_[arg_14_1])
	arg_14_2:SetClickHandler(function(arg_15_0)
		self:OnClickHero(arg_14_1, arg_14_2, arg_15_0)
	end)

	local var_14_0, var_14_1 = self.heroList_:GetHeadAndTail()
	local var_14_2 = arg_14_1 == var_14_1

	if self:GetHeroSelectIdx() == nil and arg_14_1 == 1 then
		var_14_2 = false

		self:SelectHero(1)
	end

	arg_14_2:SetSelected(self:GetHeroSelectIdx() == arg_14_1)
	arg_14_2:RefreshUI()

	if var_14_2 then
		self:UpdateRedPointUI(false)
	end
end

function ActivityHeroEnhanceHeroView:OnClickHero(arg_16_1, arg_16_2, arg_16_3)
	if ActivityHeroEnhanceTools.IsCfgHeroLock(ActivityHeroEnhanceCfg[self.cfgIdList_[arg_16_1]]) then
		return
	end

	self:SelectHero(arg_16_1)

	if self.lastGroupIdx_ and self.lastTalentIdx_ then
		self:SelectGroup(self.lastGroupIdx_, self.lastTalentIdx_)
	end
end

function ActivityHeroEnhanceHeroView:SelectHero(arg_17_1)
	self:SetHeroSelectIdx(arg_17_1)

	self.cfgId_ = self.cfgIdList_[arg_17_1]
	self.heroId_ = ActivityHeroEnhanceCfg[self.cfgIdList_[arg_17_1]].hero_id

	self.middleView_:SetData(self.cfgIdList_[arg_17_1])
	self.middleView_:RefreshUI()

	for iter_17_0, iter_17_1 in pairs(self.heroList_:GetItemList()) do
		iter_17_1:SetSelected(self:GetHeroSelectIdx() == iter_17_0)
		iter_17_1:RefreshUI()
	end

	self:UpdateRedPointUI(false)
end

function ActivityHeroEnhanceHeroView:OnClickUseTalent(arg_18_1)
	ActivityHeroEnhanceAction.ActivateTalent(self.activityId_, self.heroId_, arg_18_1, function()
		self.middleView_:RefreshUI()
		self.detailView_:RefreshUI()
	end)
end

function ActivityHeroEnhanceHeroView:OnClickDropTalent(arg_20_1)
	ActivityHeroEnhanceAction.DeactivateTalent(self.activityId_, arg_20_1, function()
		self.middleView_:RefreshUI()
		self.detailView_:RefreshUI()
	end)
end

function ActivityHeroEnhanceHeroView:SelectGroup(arg_22_1, arg_22_2)
	local var_22_0 = ActivityHeroEnhanceTools.GetCfgTalentListByStage(ActivityHeroEnhanceCfg[self.cfgId_], arg_22_1)

	if arg_22_2 == nil then
		arg_22_2 = ActivityHeroEnhanceTools.GetTalentListActivatedIdx(self.activityId_, var_22_0)

		if arg_22_2 <= 0 then
			arg_22_2 = self.lastGroupIdx_ == arg_22_1 and (self.lastTalentIdx_ and self.lastTalentIdx_ or 1) or 1
		end
	end

	self.middleView_:SelectGroupIdx(arg_22_1, arg_22_2)
	self.middleView_:RefreshUI_SelectState()
	self:SelectTalent(var_22_0[arg_22_2])

	self.lastGroupIdx_ = arg_22_1
	self.lastTalentIdx_ = arg_22_2
end

function ActivityHeroEnhanceHeroView:SelectTalent(arg_23_1)
	self.detailView_:SetData(self.activityId_, arg_23_1)
	self.detailView_:RefreshUI()
	self:PlayEnterAni()
end

function ActivityHeroEnhanceHeroView:OnClickBgBtn()
	self.middleView_:SelectGroupIdx(0)
	self.middleView_:RefreshUI_SelectState()
	self:PlayExitAni()

	self.lastGroupIdx_ = nil
	self.lastTalentIdx_ = nil
end

function ActivityHeroEnhanceHeroView:OnClickGoBtn()
	local var_25_0 = self.cfgIdList_[self:GetHeroSelectIdx()]

	self:JumpToSection(var_25_0)
	ActivityHeroEnhanceAction.BanRedPoint(self.activityId_, (string.format("%s_%d_%s", RedPointConst.ACTIVITY_HERO_ENHANCE_STAGE_REWARD, ActivityHeroEnhanceCfg[var_25_0].hero_id, ActivityTools.GetRedPointKey(self.activityId_) .. self.activityId_)))
end

function ActivityHeroEnhanceHeroView:JumpToSection(arg_26_1)
	self.section_CfgId_ = nil

	JumpTools.OpenPageByJump("/activityHeroEnhanceSection", {
		activityID = self.params_.activityID,
		cfgId = arg_26_1
	})
end

function ActivityHeroEnhanceHeroView:PlayEnterAni()
	self.isEntered_ = true

	self.statusController_:SetSelectedState("detail")
	SetActive(self.talentDetailGo_, true)
end

function ActivityHeroEnhanceHeroView:PlayExitAni()
	self.isEntered_ = false

	self.statusController_:SetSelectedState("main")
	SetActive(self.talentDetailGo_, false)
end

function ActivityHeroEnhanceHeroView:Back()
	if self.isEntered_ then
		self:OnClickBgBtn()
	elseif self.section_CfgId_ then
		self:JumpToSection(self.section_CfgId_)
	else
		ActivityHeroEnhanceHeroView.super.Back(self)
	end
end

function ActivityHeroEnhanceHeroView:UpdateRedPointUI(arg_30_1)
	if self.redPointHistory_ then
		for iter_30_0, iter_30_1 in pairs(self.redPointHistory_) do
			manager.redPoint:unbindUIandKey(iter_30_0, iter_30_1)
		end
	end

	self.redPointHistory_ = {}

	if arg_30_1 then
		return
	end

	local var_30_0 = ActivityTools.GetRedPointKey(self.activityId_) .. self.activityId_

	for iter_30_2, iter_30_3 in ipairs(ActivityHeroEnhanceCfg.get_id_list_by_activity_id[self.activityId_]) do
		local var_30_1 = string.format("%s_%d_%s", RedPointConst.ACTIVITY_HERO_ENHANCE_STAGE_REWARD, ActivityHeroEnhanceCfg[iter_30_3].hero_id, var_30_0)

		if ActivityHeroEnhanceCfg[iter_30_3].hero_id == self.heroId_ then
			self.redPointHistory_[self.goBtn_.transform] = var_30_1
		end

		local var_30_2 = self:GetHeroItemByCfgId(iter_30_3)

		if var_30_2 then
			self.redPointHistory_[var_30_2:GetRedPointTransform()] = var_30_1
		end
	end

	for iter_30_4, iter_30_5 in pairs(self.redPointHistory_) do
		manager.redPoint:bindUIandKey(iter_30_4, iter_30_5)
	end
end

function ActivityHeroEnhanceHeroView:GetHeroItemByCfgId(arg_31_1)
	for iter_31_0, iter_31_1 in pairs(self.heroList_:GetItemList()) do
		if iter_31_1:GetCfgId() == arg_31_1 then
			return iter_31_1
		end
	end

	return nil
end

function ActivityHeroEnhanceHeroView:GetHeroSelectIdx()
	if self.section_CfgId_ and self.heroSelectIdx_ then
		return 1
	end

	return self.heroSelectIdx_
end

function ActivityHeroEnhanceHeroView:SetHeroSelectIdx(arg_33_1)
	if self.section_CfgId_ then
		self.heroSelectIdx_ = self.heroSelectIdx_ or table.indexof(ActivityHeroEnhanceTools.GetCfgIdList(self.activityId_), self.section_CfgId_)

		return
	end

	self.heroSelectIdx_ = arg_33_1
end

function ActivityHeroEnhanceHeroView:Dispose()
	self.middleView_:Dispose()
	self.detailView_:Dispose()
	self.heroList_:Dispose()
	ActivityHeroEnhanceHeroView.super.Dispose(self)
end

function ActivityHeroEnhanceHeroView:OnNewDay()
	self:RefreshUI()
end

function ActivityHeroEnhanceHeroView:OnActivityHeroEnhanceDataInit()
	self:OnNewDay()
end

return ActivityHeroEnhanceHeroView
