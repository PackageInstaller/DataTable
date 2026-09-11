local ActivityHeroEnhanceSectionAttachView = class("ActivityHeroEnhanceSectionAttachView", ReduxView)

function ActivityHeroEnhanceSectionAttachView:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(Asset.Load(arg_1_2), arg_1_1.transform)
	self.transform_ = self.gameObject_.transform

	self:InitUI()
end

function ActivityHeroEnhanceSectionAttachView:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.heroItem_ = ActivityHeroEnhanceHeroItem.New(self.heroGo_)
	self.talentList_ = LuaList.New(handler(self, self.IndexTalentItem), self.talentListGo_, ActivityHeroEnhanceTalentItem)
end

function ActivityHeroEnhanceSectionAttachView:AddUIListener()
	return
end

function ActivityHeroEnhanceSectionAttachView:IndexTalentItem(arg_4_1, arg_4_2)
	arg_4_2:SetData(self.activityId_, self.talentIdList_[arg_4_1])

	if self.talentIdList_[arg_4_1] then
		arg_4_2:SetLock((ActivityHeroEnhanceTools.IsTalentLock(self.activityId_, self.talentIdList_[arg_4_1])))
		arg_4_2:SetFirstAddFlag(false)
	else
		local var_4_0 = arg_4_1

		arg_4_2:SetLock((ActivityHeroEnhanceTools.IsCfgTalentStageLock(ActivityHeroEnhanceCfg[self.cfgId_], arg_4_1, true)))
		arg_4_2:SetFirstAddFlag(ActivityHeroEnhanceTools.IsCfgTalentStageFirstCanAdd(ActivityHeroEnhanceCfg[self.cfgId_], var_4_0))
	end

	arg_4_2:SetClickHandler(function(arg_5_0)
		JumpTools.OpenPageByJump("/activityHeroEnhanceHero", {
			activityID = self.activityId_,
			cfgId = self.cfgId_,
			stageToView = arg_4_1,
			talentIdToView = arg_5_0
		})
	end)
	arg_4_2:RefreshUI()
end

function ActivityHeroEnhanceSectionAttachView:SetData(arg_6_1, arg_6_2)
	self.cfgId_ = arg_6_1
	self.activityId_ = ActivityHeroEnhanceCfg[arg_6_1].activity_id
	self.talentIdList_ = arg_6_2

	self.heroItem_:SetData(arg_6_1)
end

function ActivityHeroEnhanceSectionAttachView:RefreshUI()
	self.heroItem_:SetIgnorePass(true)
	self.heroItem_:RefreshUI()
	self.talentList_:StartScroll((ActivityHeroEnhanceTools.GetCfgTalentMaxStage(ActivityHeroEnhanceCfg[self.cfgId_])))
end

function ActivityHeroEnhanceSectionAttachView:Dispose()
	self.heroItem_:Dispose()
	self.talentList_:Dispose()
	ActivityHeroEnhanceSectionAttachView.super.Dispose(self)
end

return ActivityHeroEnhanceSectionAttachView
