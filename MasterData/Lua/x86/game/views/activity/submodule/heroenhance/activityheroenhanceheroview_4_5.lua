local ActivityHeroEnhanceHeroView_4_5 = class("ActivityHeroEnhanceHeroView_4_5", ReduxView)

function ActivityHeroEnhanceHeroView_4_5:UIName()
	return ActivityHeroEnhanceTools.GetHeroUIName(self.params_.activityID)
end

function ActivityHeroEnhanceHeroView_4_5:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityHeroEnhanceHeroView_4_5:Init()
	self:InitUI()
	self:AddUIListener()
end

function ActivityHeroEnhanceHeroView_4_5:InitUI()
	self:BindCfgUI()

	self.middleView_ = ActivityHeroEnhanceTalentView.New(self.talentUIGo_)
	self.detailView_ = ActivityHeroEnhanceTalentDetailView.New(self.talentDetailGo_)
	self.statusController_ = self.controller_:GetController("status")

	self.statusController_:SetSelectedState("main")
	SetActive(self.talentDetailGo_, false)
end

function ActivityHeroEnhanceHeroView_4_5:AddUIListener()
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

function ActivityHeroEnhanceHeroView_4_5:OnEnter()
	self.talentID_ = nil

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
		if ActivityHeroEnhanceHeroView_4_5.enterBattleCfgId_ then
			self.cfgId_ = ActivityHeroEnhanceHeroView_4_5.enterBattleCfgId_
			ActivityHeroEnhanceHeroView_4_5.enterBattleCfgId_ = nil

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

function ActivityHeroEnhanceHeroView_4_5:OnExit()
	manager.windowBar:HideBar()
	self:UpdateRedPointUI(true)
	self.middleView_:OnExit()

	self.lastGroupIdx_ = nil
	self.lastTalentIdx_ = nil
end

function ActivityHeroEnhanceHeroView_4_5:RefreshUI()
	self.middleView_:SetData(self.cfgId_)
	self.middleView_:RefreshUI()
	self:UpdateRedPointUI(false)
end

function ActivityHeroEnhanceHeroView_4_5:SelectGroup(arg_14_1, arg_14_2)
	local var_14_0 = ActivityHeroEnhanceTools.GetCfgTalentListByStage(ActivityHeroEnhanceCfg[self.cfgId_], arg_14_1)

	if arg_14_2 == nil then
		arg_14_2 = ActivityHeroEnhanceTools.GetTalentListActivatedIdx(self.activityId_, var_14_0)

		if arg_14_2 <= 0 then
			arg_14_2 = self.lastGroupIdx_ == arg_14_1 and (self.lastTalentIdx_ and self.lastTalentIdx_ or 1) or 1
		end
	end

	self.middleView_:SelectGroupIdx(arg_14_1, arg_14_2)
	self.middleView_:RefreshUI_SelectState()
	self:SelectTalent(var_14_0[arg_14_2])

	self.lastGroupIdx_ = arg_14_1
	self.lastTalentIdx_ = arg_14_2
end

function ActivityHeroEnhanceHeroView_4_5:SelectTalent(arg_15_1)
	if self.talentID_ == arg_15_1 then
		return
	end

	self.talentID_ = arg_15_1

	self.detailView_:SetData(self.activityId_, arg_15_1)
	self.detailView_:RefreshUI()
	self:PlayEnterAni()
end

function ActivityHeroEnhanceHeroView_4_5:OnClickBgBtn()
	self.middleView_:SelectGroupIdx(0)
	self.middleView_:RefreshUI_SelectState()
	self:PlayExitAni()

	self.lastGroupIdx_ = nil
	self.lastTalentIdx_ = nil
end

function ActivityHeroEnhanceHeroView_4_5:JumpToSection(arg_17_1)
	self.section_CfgId_ = nil

	JumpTools.OpenPageByJump("/activityHeroEnhanceSection_4_5", {
		activityID = self.params_.activityID,
		cfgId = arg_17_1
	})
end

function ActivityHeroEnhanceHeroView_4_5:PlayEnterAni()
	self.isEntered_ = true

	self.statusController_:SetSelectedState("detail")
	SetActive(self.talentDetailGo_, true)
end

function ActivityHeroEnhanceHeroView_4_5:PlayExitAni()
	self.isEntered_ = false

	self.statusController_:SetSelectedState("main")
	SetActive(self.talentDetailGo_, false)
end

function ActivityHeroEnhanceHeroView_4_5:Back()
	if self.isEntered_ then
		self:OnClickBgBtn()
	end

	if self.section_CfgId_ then
		self:JumpToSection(self.section_CfgId_)
	else
		ActivityHeroEnhanceHeroView_4_5.super.Back(self)
	end
end

function ActivityHeroEnhanceHeroView_4_5:UpdateRedPointUI(arg_21_1)
	return
end

function ActivityHeroEnhanceHeroView_4_5:Dispose()
	self.middleView_:Dispose()
	self.detailView_:Dispose()
	ActivityHeroEnhanceHeroView_4_5.super.Dispose(self)
end

function ActivityHeroEnhanceHeroView_4_5:OnNewDay()
	self:RefreshUI()
end

function ActivityHeroEnhanceHeroView_4_5:OnActivityHeroEnhanceDataInit()
	self:OnNewDay()
end

return ActivityHeroEnhanceHeroView_4_5
