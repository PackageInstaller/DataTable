local DestroyBoxGameView = class("DestroyBoxGameView", ReduxView)

function DestroyBoxGameView:UIName()
	return DestroyBoxGameUICfg[DestroyBoxGameUICfg.get_id_list_by_main_activity_id[self.params_.activityID][1]].main_prefab
end

function DestroyBoxGameView:UIParent()
	return manager.ui.uiMain.transform
end

function DestroyBoxGameView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.viewList_ = {
		DestroyBoxGameNormalView.New(self.challengeGo3_),
		DestroyBoxGameChallengeView.New(self.challengeGo1_, 1),
		DestroyBoxGameChallengeView.New(self.challengeGo2_, 2)
	}
	self.switchSelectItemHandler_ = handler(self, self.SwitchSelectItem)
end

function DestroyBoxGameView:OnEnter()
	self.mainActivityID_ = self.params_.activityID

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey(DestroyBoxGameUICfg[DestroyBoxGameUICfg.get_id_list_by_main_activity_id[self.mainActivityID_][1]].desc)
	self:RefreshTime()

	for iter_4_0, iter_4_1 in ipairs(self.viewList_) do
		iter_4_1:OnEnter(self.mainActivityID_)
	end

	self:SwitchSelectItem()
	manager.notify:RegistListener(DESTROY_BOX_GAME_SELECT_STAGE, self.switchSelectItemHandler_)
	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, string.format("%s_%s", RedPointConst.DESTROY_BOX_GAME_REWARD, self.mainActivityID_))
end

function DestroyBoxGameView:OnExit()
	manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, string.format("%s_%s", RedPointConst.DESTROY_BOX_GAME_REWARD, self.mainActivityID_))
	manager.notify:RemoveListener(DESTROY_BOX_GAME_SELECT_STAGE, self.switchSelectItemHandler_)
	manager.windowBar:HideBar()
	self:StopTimer()

	for iter_5_0, iter_5_1 in ipairs(self.viewList_) do
		iter_5_1:OnExit()
	end
end

function DestroyBoxGameView:Dispose()
	self.switchSelectHandler_ = nil

	for iter_6_0, iter_6_1 in ipairs(self.viewList_) do
		iter_6_1:Dispose()
	end

	self.viewList_ = nil

	DestroyBoxGameView.super.Dispose(self)
end

function DestroyBoxGameView:AddListeners()
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("destroyBoxGameReward", {
			mainActivityID = self.mainActivityID_
		})
	end)
	self:AddBtnListener(self.rankingBtn_, nil, function()
		self:Go("/DestroyBoxRankView", {
			type = RankBaseConst.RANK_TYPE.ALL,
			subType = RankBaseConst.SUB_TYPE.SCORE,
			activityID = self.mainActivityID_
		})
	end)
end

function DestroyBoxGameView:SwitchSelectItem()
	local var_10_0 = DestroyBoxGameData:GetSelectID(self.mainActivityID_)

	for iter_10_0, iter_10_1 in ipairs(self.viewList_) do
		iter_10_1:SwitchSelectItem(var_10_0)
	end
end

function DestroyBoxGameView:RefreshTime()
	self:StopTimer()

	local var_11_0 = ActivityData:GetActivityData(self.mainActivityID_).stopTime

	self.timeText_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(var_11_0)
	self.timer_ = Timer.New(function()
		self.timeText_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(var_11_0)
	end, 1, -1)

	self.timer_:Start()
end

function DestroyBoxGameView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return DestroyBoxGameView
