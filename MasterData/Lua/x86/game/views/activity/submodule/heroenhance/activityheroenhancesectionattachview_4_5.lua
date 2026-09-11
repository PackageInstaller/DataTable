local ActivityHeroEnhanceSectionAttachView_4_5 = class("ActivityHeroEnhanceSectionAttachView_4_5", ReduxView)

function ActivityHeroEnhanceSectionAttachView_4_5:OnCtor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.gameObject_ = Object.Instantiate(Asset.Load(arg_1_2), arg_1_1.transform)
	self.transform_ = self.gameObject_.transform
	self.activityId_ = arg_1_3
	self.btnCallback_ = arg_1_4

	self:InitUI()
end

function ActivityHeroEnhanceSectionAttachView_4_5:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.cfgIdList_ = ActivityHeroEnhanceTools.GetCfgIdList(self.activityId_)
	self.heroItemList_ = {}

	for iter_2_0, iter_2_1 in ipairs(self.cfgIdList_) do
		local var_2_0 = ActivityHeroEnhanceHeroItem_4_5.New(self["tabGo_" .. iter_2_0])

		var_2_0:SetData(iter_2_1)
		var_2_0:SetClickHandler(function(arg_3_0)
			self.btnCallback_(arg_3_0)
		end)
		table.insert(self.heroItemList_, var_2_0)
	end

	self.talentList_ = LuaList.New(handler(self, self.IndexTalentItem), self.talentListGo_, ActivityHeroEnhanceTalentItem)

	manager.redPoint:bindUIandKey(self.questBtn_.transform, RedPointConst.ACTIVITY_TASK .. "_" .. ActivityConst.ACTIVITY_HERO_ENHANCE_4_5_TASK)
end

function ActivityHeroEnhanceSectionAttachView_4_5:AddUIListener()
	self:AddBtnListener(self.questBtn_, nil, function()
		TaskTools:ShowActivityTaskPop(ActivityConst.ACTIVITY_HERO_ENHANCE_4_5_TASK, "Widget/Version/Alone_HeroEnhanceUI/Alone_HeroEnhance_PopUI")
	end)
	self:AddBtnListener(self.talentBtn_, nil, function()
		JumpTools.OpenPageByJump("/activityHeroEnhanceHeroView_4_5", {
			stageToView = 1,
			activityID = self.activityId_,
			cfgId = self.cfgId_,
			talentIdToView = self.talentIdList_[1]
		})
	end)
	self:AddBtnListener(self.trialBattleBtn_, nil, function()
		local var_7_0 = HeroTrialTools.GetLastOpenHeroTrial(ActivityHeroEnhanceCfg[self.cfgId_].hero_id)

		HeroTrialData:SetBattleWay(ActivityHeroTrialConst.BATTLE_WAY.HERO_VIEW, "/activityHeroEnhanceSection_4_5", {
			activityID = self.activityId_,
			cfgId = self.cfgId_
		})

		if var_7_0 ~= 0 and HeroTrialTools.GetActivityIsUnlock(var_7_0) and PlayerData:GetPlayerInfo().userLevel >= 35 then
			HeroTrialTools.EnterActivityBattle(var_7_0)
		else
			HeroTrialTools.EnterResidentBattle(HeroCfg[ActivityHeroEnhanceCfg[self.cfgId_].hero_id].trial_stage)
		end
	end)
end

function ActivityHeroEnhanceSectionAttachView_4_5:SetData(arg_8_1, arg_8_2)
	if self.cfgId_ ~= arg_8_1 then
		self.enterAnimator_:Play("Fx_tabgroup_cx", 0, 0)
	end

	self.cfgId_ = arg_8_1
	self.activityId_ = ActivityHeroEnhanceCfg[arg_8_1].activity_id
	self.talentIdList_ = arg_8_2
end

function ActivityHeroEnhanceSectionAttachView_4_5:ChooseCfg(arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(self.heroItemList_) do
		if iter_9_1:GetCfgId() == arg_9_1 then
			iter_9_1:SetSelected(true)
		else
			iter_9_1:SetSelected(false)
		end
	end
end

function ActivityHeroEnhanceSectionAttachView_4_5:IndexTalentItem(arg_10_1, arg_10_2)
	arg_10_2:SetData(self.activityId_, self.talentIdList_[arg_10_1])
	arg_10_2:SetMainTag(true)

	if self.talentIdList_[arg_10_1] then
		if self.talentIdList_[arg_10_1] == self.unlockTalent_ then
			arg_10_2:SetLock(true)
			arg_10_2:SetPlayAnim(true, function()
				self.unlockTalent_ = nil
			end)
			arg_10_2:SetFirstAddFlag(true)
		else
			arg_10_2:SetLock((ActivityHeroEnhanceTools.IsTalentLock(self.activityId_, self.talentIdList_[arg_10_1])))
			arg_10_2:SetFirstAddFlag(false)
		end
	else
		arg_10_2:SetLock((ActivityHeroEnhanceTools.IsCfgTalentStageLock(ActivityHeroEnhanceCfg[self.cfgId_], arg_10_1, true)))
		arg_10_2:SetFirstAddFlag(false)
	end

	arg_10_2:SetClickHandler(function(arg_12_0)
		JumpTools.OpenPageByJump("/activityHeroEnhanceHeroView_4_5", {
			activityID = self.activityId_,
			cfgId = self.cfgId_,
			stageToView = arg_10_1,
			talentIdToView = arg_12_0
		})
	end)
	arg_10_2:RefreshUI()
end

function ActivityHeroEnhanceSectionAttachView_4_5:RefreshUI()
	for iter_13_0, iter_13_1 in ipairs(self.heroItemList_) do
		iter_13_1:RefreshUI()
	end

	self.talentList_:StartScroll((ActivityHeroEnhanceTools.GetCfgTalentMaxStage(ActivityHeroEnhanceCfg[self.cfgId_])))

	self.heroImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. ActivityHeroEnhanceCfg[self.cfgId_].hero_id)

	self.heroImg_:AdaptImg()
end

function ActivityHeroEnhanceSectionAttachView_4_5:PlayTalentAnim(arg_14_1)
	self.unlockTalent_ = arg_14_1
end

function ActivityHeroEnhanceSectionAttachView_4_5:PlayAnim(arg_15_1, arg_15_2)
	local var_15_0

	for iter_15_0, iter_15_1 in ipairs(self.heroItemList_) do
		if iter_15_1:GetCfgId() == arg_15_1 then
			var_15_0 = iter_15_1

			break
		end
	end

	if var_15_0 then
		var_15_0:PlayAnim(arg_15_2)
	elseif arg_15_2 then
		arg_15_2()
	end
end

function ActivityHeroEnhanceSectionAttachView_4_5:Dispose()
	manager.redPoint:unbindUIandKey(self.questBtn_.transform, RedPointConst.ACTIVITY_TASK .. ActivityConst.ACTIVITY_HERO_ENHANCE_4_5_TASK)

	for iter_16_0, iter_16_1 in ipairs(self.heroItemList_) do
		iter_16_1:Dispose()
	end

	self.talentList_:Dispose()
	ActivityHeroEnhanceSectionAttachView_4_5.super.Dispose(self)
end

return ActivityHeroEnhanceSectionAttachView_4_5
