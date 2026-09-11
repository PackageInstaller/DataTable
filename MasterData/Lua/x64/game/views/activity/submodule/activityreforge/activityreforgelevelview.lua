local ActivityReforgeLevelView = class("ActivityReforgeLevelView", ReduxView)

function ActivityReforgeLevelView:UIName()
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ActivityReforge/NorseUI_3_0_ActivityReforgeLevelUI"
end

function ActivityReforgeLevelView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityReforgeLevelView:Init()
	self:InitUI()
	self:AddUIListeners()

	self.isShowRewardPanel_ = false
	self.isSelectLevel_ = false
	self.levelID_ = 0
end

function ActivityReforgeLevelView:InitUI()
	self:BindCfgUI()

	self.levelItemList_ = {}
	self.levelItemClickHandler_ = handler(self, self.OnLevelItemClick)

	for iter_4_0 = 1, 6 do
		self.levelItemList_[iter_4_0] = ActivityReforgeLevelViewItem.New(self["levelItemGo" .. iter_4_0 .. "_"], self.levelItemClickHandler_)
	end

	self.isPassController_ = self.controllerEx_:GetController("ispass")
	self.isBattlingController_ = self.controllerEx_:GetController("isbattling")
	self.isSelectController_ = self.controllerEx_:GetController("isselect")
	self.isGetAllRewardController_ = self.controllerEx_:GetController("isGetAllReward")
	self.levelIndexController_ = self.controllerEx_:GetController("levelIndex")
	self.timeInfoItem_ = ActivityReforgeLevelFinishItem.New(self.timeInfoGo_)
	self.pointInfoItem_ = ActivityReforgeLevelFinishItem.New(self.pointInfoGo_)
	self.goldInfoItem_ = ActivityReforgeLevelFinishItem.New(self.goldInfoGo_)
end

function ActivityReforgeLevelView:OnLevelItemClick(arg_5_1)
	self.curLevelItemIndex_ = arg_5_1
	self.levelID_ = self.cfg_.level_list[self.curLevelItemIndex_]
	self.isSelectLevel_ = true

	self.isSelectController_:SetSelectedState("true")
	self:RefreshLevelItemSelect()
	self:RefreshLevelInfoUI()
end

function ActivityReforgeLevelView:RefreshLevelItem()
	for iter_6_0 = 1, 6 do
		if iter_6_0 <= #self.cfg_.level_list then
			self.levelItemList_[iter_6_0]:SetActive(true)
			self.levelItemList_[iter_6_0]:SetData(iter_6_0, self.chapterActivityID_, self.cfg_.level_list[iter_6_0])
			self.levelItemList_[iter_6_0]:RefreshSelect(self.curLevelItemIndex_)
		else
			self.levelItemList_[iter_6_0]:SetActive(false)
		end
	end
end

function ActivityReforgeLevelView:RefreshLevelItemSelect()
	for iter_7_0 = 1, #self.cfg_.level_list do
		self.levelItemList_[iter_7_0]:RefreshSelect(self.curLevelItemIndex_)
	end
end

function ActivityReforgeLevelView:AddUIListeners()
	self:AddBtnListener(self.goldInfoBtn_, nil, function()
		JumpTools.OpenPageByJump("activityReforgeGoldInfoView")
	end)
	self:AddBtnListener(self.startBtn_, nil, function()
		if ActivityReforgeData:GetCurLevel() ~= 0 then
			ShowMessageBox({
				content = GetTips("ACTIVITY_REFORGE_RESTART_LEVEL_TIPS"),
				OkCallback = function()
					ActivityReforgeAction.StartLevel(self.chapterActivityID_, self.levelID_, function()
						JumpTools.OpenPageByJump("/activityReforgeWaveView", {
							activityID = self.activityID_,
							chapterActivityID = self.chapterActivityID_,
							levelID = self.levelID_
						})
					end)
				end
			})
		else
			ActivityReforgeAction.StartLevel(self.chapterActivityID_, self.levelID_, function()
				JumpTools.OpenPageByJump("/activityReforgeWaveView", {
					activityID = self.activityID_,
					chapterActivityID = self.chapterActivityID_,
					levelID = self.levelID_
				})
			end)
		end
	end)
	self:AddBtnListener(self.giveUpBtn_, nil, function()
		ShowMessageBox({
			content = GetTips("ACTIVITY_REFORGE_IS_GIVEUP_CURLEVEL"),
			OkCallback = function()
				ActivityReforgeAction.GiveUpCurLevel(self.chapterActivityID_, self.cfg_.level_list[self.curLevelItemIndex_])
			end
		})
	end)
	self:AddBtnListener(self.continueBtn_, nil, function()
		local var_16_0 = ActivityReforgeData:GetCurLastWinWaveID()

		if ActivityReforgeData:GetCurLevel() ~= 0 and var_16_0 == 0 then
			JumpTools.OpenPageByJump("/activityReforgeWaveView", {
				activityID = self.activityID_,
				chapterActivityID = self.chapterActivityID_,
				levelID = self.levelID_
			})
		elseif ActivityReforgeLevelCfg[self.levelID_].wave_list[#ActivityReforgeLevelCfg[self.levelID_].wave_list] == var_16_0 then
			JumpTools.OpenPageByJump("activityReforgeBattleInfoView", {
				activityID = self.activityID_,
				chapterActivityID = self.chapterActivityID_,
				levelID = self.levelID_,
				waveID = var_16_0
			})
		else
			JumpTools.OpenPageByJump("/activityReforgeTrimView", {
				activityID = self.activityID_,
				chapterActivityID = self.chapterActivityID_,
				levelID = self.levelID_
			})
		end
	end)
	self:AddBtnListener(self.rewardBtn_, nil, function()
		self.isShowRewardPanel_ = not self.isShowRewardPanel_

		SetActive(self.rewardPanel_, self.isShowRewardPanel_)
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		if self.isSelectLevel_ then
			self.curLevelItemIndex_ = 0
			self.levelID_ = 0
			self.isSelectLevel_ = false

			self.isSelectController_:SetSelectedState("false")
			self:RefreshLevelItemSelect()
		end
	end)
end

function ActivityReforgeLevelView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.chapterActivityID_ = self.params_.chapterActivityID
	self.cfg_ = ActivityReforgeChapterCfg[self.chapterActivityID_]
	self.curLevelItemIndex_ = 0
	self.levelID_ = 0
	self.isSelectLevel_ = false

	self.isSelectController_:SetSelectedState("false")
	self:RefreshUI()
	self:CheckCacheAddGoldNum()
end

function ActivityReforgeLevelView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_REFORGE_GAMEHELPKEY")
end

function ActivityReforgeLevelView:OnExit()
	self:StopAddGoldNumTimer()
	manager.windowBar:HideBar()
end

function ActivityReforgeLevelView:RefreshUI()
	self.goldMaxNum_.text = ActivityReforgeData:GetGoldMaxNum(self.activityID_)
	self.rewardNum_.text = "+" .. self.cfg_.reward_money

	local var_22_0 = ActivityReforgeData:GetChapterFinishLevelNum(self.chapterActivityID_)

	self.passSlider_.value = var_22_0 / #self.cfg_.level_list
	self.passNum_.text = var_22_0 .. "/" .. #self.cfg_.level_list
	self.chapterName_.text = self.cfg_.chapter_name

	if var_22_0 >= #self.cfg_.level_list then
		self.isGetAllRewardController_:SetSelectedState("true")
	else
		self.isGetAllRewardController_:SetSelectedState("false")
	end

	self:RefreshLevelItem()
	self:RefreshLevelInfoUI()
end

function ActivityReforgeLevelView:RefreshLevelInfoUI()
	if self.isSelectLevel_ == false then
		return
	end

	if self.levelID_ == ActivityReforgeData:GetCurLevel() then
		self.isBattlingController_:SetSelectedState("true")
	else
		self.isBattlingController_:SetSelectedState("false")
	end

	self.isPassController_:SetSelectedState("false")

	if ActivityReforgeData:GetLevelIsFinish(self.chapterActivityID_, self.levelID_) then
		ActivityReforgeAction.RequestAllPlayerLevelData(self.chapterActivityID_, self.levelID_, function()
			self:RefreshLevelFinishUI()
		end)
	end

	local var_23_0 = ActivityReforgeLevelCfg[self.levelID_]

	self.levelName_.text = ActivityReforgeLevelCfg[self.levelID_].name
	self.levelDes_.text = var_23_0.description
	self.levelRewardNum_.text = "+" .. var_23_0.reward_money

	self.levelIndexController_:SetSelectedState(table.indexof(self.cfg_.level_list, self.levelID_))
end

function ActivityReforgeLevelView:RefreshLevelFinishUI()
	self.isPassController_:SetSelectedState("true")

	local var_25_0 = ActivityReforgeData:GetBestFinishLevelServerData(self.levelID_)
	local var_25_1 = ActivityReforgeData:GetLevelAllPlayerServerData(self.levelID_)

	self.levelName_.text = ActivityReforgeLevelCfg[self.levelID_].name

	self.timeInfoItem_:SetData(1, ActivityReforgeGameSettingCfg[self.activityID_].bar_num_min, self.levelID_, var_25_0.minUseSeconds, var_25_1.minUseSeconds.rangeValue, var_25_1.minUseSeconds.rangeLength)
	self.pointInfoItem_:SetData(2, ActivityReforgeGameSettingCfg[self.activityID_].bar_num_min, self.levelID_, var_25_0.minLosePoint, var_25_1.minLosePoint.rangeValue, var_25_1.minLosePoint.rangeLength)
	self.goldInfoItem_:SetData(3, ActivityReforgeGameSettingCfg[self.activityID_].bar_num_min, self.levelID_, var_25_0.minUseGold, var_25_1.minUseGold.rangeValue, var_25_1.minUseGold.rangeLength)
end

function ActivityReforgeLevelView:OnActivityReforgeGiveUpLevel()
	self:RefreshLevelItem()
	self:RefreshLevelInfoUI()
end

function ActivityReforgeLevelView:CheckCacheAddGoldNum()
	local var_27_0 = ActivityReforgeData:GetCacheAddGoldNum()

	if var_27_0 > 0 then
		self.goldAddText_.text = "+" .. var_27_0

		SetActive(self.goldAddGo_, true)
		self:StopAddGoldNumTimer()

		self.addGoldNumCacheTimer_ = Timer.New(function()
			self:StopAddGoldNumTimer()
			SetActive(self.goldAddGo_, false)

			self.goldMaxNum_.text = ActivityReforgeData:SubGoldMaxNum(self.activityID_, var_27_0)

			ActivityReforgeData:ClearCacheAddGoldNum()
		end, 2, 1)

		self.addGoldNumCacheTimer_:Start()
	else
		SetActive(self.goldAddGo_, false)
	end
end

function ActivityReforgeLevelView:StopAddGoldNumTimer()
	if self.addGoldNumCacheTimer_ then
		self.addGoldNumCacheTimer_:Stop()

		self.addGoldNumCacheTimer_ = nil
	end
end

function ActivityReforgeLevelView:Dispose()
	for iter_30_0 = 1, 6 do
		self.levelItemList_[iter_30_0]:Dispose()
	end

	self.levelItemList_ = nil
	self.levelItemClickHandler_ = nil

	self.timeInfoItem_:Dispose()
	self.pointInfoItem_:Dispose()
	self.goldInfoItem_:Dispose()

	self.timeInfoItem_ = nil
	self.pointInfoItem_ = nil
	self.goldInfoItem_ = nil

	self:StopAddGoldNumTimer()
	self.super.Dispose(self)
end

return ActivityReforgeLevelView
