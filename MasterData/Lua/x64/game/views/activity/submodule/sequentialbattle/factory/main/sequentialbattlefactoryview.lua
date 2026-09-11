local SequentialBattleFactoryView = class("SequentialBattleFactoryView", ReduxView)

function SequentialBattleFactoryView:UIName()
	return SequentialBattleUICfg[SequentialBattleUICfg.get_id_list_by_main_activity_id[self:GetActivityID()][1]].main_prefab
end

function SequentialBattleFactoryView:UIParent()
	return manager.ui.uiMain.transform
end

function SequentialBattleFactoryView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.selectChapterHandler_ = handler(self, self.Update)
	self.difficultItemList_ = {}

	for iter_3_0, iter_3_1 in ipairs(ActivityCfg[self:GetActivityID()].sub_activity_list) do
		self.difficultItemList_[iter_3_0] = SequentialBattleChapterItem.New(self.difficultItem_, self.difficultParent_, iter_3_1)
	end

	self.adaptImg_ = self:FindCom("AdaptImage", nil, self.portraitImage_.transform)
end

function SequentialBattleFactoryView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("SEQUENTIAL_BATTLE_DESC")
	self:Update()
	manager.notify:RegistListener(SEQUENTIAL_BATTLE_SELECT_CHAPTER, self.selectChapterHandler_)

	for iter_4_0, iter_4_1 in ipairs(self.difficultItemList_) do
		iter_4_1:OnEnter()
	end

	self:AddTimer()
	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE_REWARD, self:GetActivityID()))
end

function SequentialBattleFactoryView:OnExit()
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(SEQUENTIAL_BATTLE_SELECT_CHAPTER, self.selectChapterHandler_)
	manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE_REWARD, self:GetActivityID()))

	for iter_5_0, iter_5_1 in ipairs(self.difficultItemList_) do
		iter_5_1:OnExit()
	end

	self.selectID_ = nil

	self:StopTimer()
end

function SequentialBattleFactoryView:Dispose()
	SequentialBattleFactoryView.super.Dispose(self)

	for iter_6_0, iter_6_1 in ipairs(self.difficultItemList_) do
		iter_6_1:Dispose()
	end

	self.difficultItemList_ = nil
end

function SequentialBattleFactoryView:AddListeners()
	self:AddBtnListener(self.buffBtn_, nil, function()
		JumpTools.OpenPageByJump("sequentialBattleBuffInfo", {
			buffInfoActivityID = self.selectID_
		})
	end)
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("sequentialBattleReward", {
			rewardActivityID = self:GetActivityID(),
			selectID = self.selectID_
		})
	end)
	self:AddBtnListener(self.battleBtn_, nil, function()
		if ActivityData:GetActivityData(self.selectID_).stopTime <= manager.time:GetServerTime() then
			ShowTips("TIME_OVER")

			return
		end

		SequentialBattleTools.CheckHeroTeamList(self.selectID_)
		self:Go("/sequentialBattleFactoryTeam", {
			activityID = self.selectID_
		})
	end)
end

function SequentialBattleFactoryView:Update()
	self:RefreshData()
	self:RefreshUI()
	SequentialBattleAction.ClickDayRedPoint(self.selectID_)
end

function SequentialBattleFactoryView:RefreshData()
	self.selectID_ = SequentialBattleData:GetSelectChapterID((self:GetActivityID()))
end

function SequentialBattleFactoryView:RefreshUI()
	self:RefreshSelectChapter()
	self:RefreshReward()
	self:RefreshRightPanel()
end

function SequentialBattleFactoryView:RefreshRightPanel()
	self.portraitImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/MardukUI/boss/Portrait/" .. SequentialBattleChapterCfg[self.selectID_].portrait)

	self.adaptImg_:AdaptImg()

	self.nameText_.text = GetI18NText(SequentialBattleChapterCfg[self.selectID_].stage_name)
	self.descText_.text = GetI18NText(SequentialBattleChapterCfg[self.selectID_].stage_desc)
end

function SequentialBattleFactoryView:RefreshSelectChapter()
	for iter_15_0, iter_15_1 in ipairs(self.difficultItemList_) do
		iter_15_1:RefreshSelect(self.selectID_)
	end
end

function SequentialBattleFactoryView:RefreshReward()
	return
end

function SequentialBattleFactoryView:GetActivityID()
	return self.params_.activityID or ActivityConst.FACTORY_SEQUENTIAL_BATTLE
end

function SequentialBattleFactoryView:AddTimer()
	local var_18_0 = ActivityData:GetActivityData((self:GetActivityID())).stopTime

	self:StopTimer()

	if var_18_0 <= manager.time:GetServerTime() then
		self.timeText_.text = GetTips("TIME_OVER")

		return
	end

	self.timeText_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(var_18_0, true)
	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= var_18_0 then
			self:StopTimer()

			self.timeText_.text = GetTips("TIME_OVER")

			return
		end

		self.timeText_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(var_18_0, true)
	end, 1, -1)

	self.timer_:Start()
end

function SequentialBattleFactoryView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return SequentialBattleFactoryView
