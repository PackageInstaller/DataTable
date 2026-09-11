local ActivityReforgeChapterView = class("ActivityReforgeChapterView", ReduxView)

function ActivityReforgeChapterView:UIName()
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ActivityReforge/NorseUI_3_0_ActivityReforgeChapterUI"
end

function ActivityReforgeChapterView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityReforgeChapterView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityReforgeChapterView:InitUI()
	self.gameHelpKey_ = "ACTIVITY_REFORGE_GAMEHELPKEY"

	self:BindCfgUI()

	self.curSelectIndex_ = 1
	self.btnControllerList_ = {}

	for iter_4_0 = 1, 4 do
		self.btnControllerList_[iter_4_0] = self["chapterListContEx" .. iter_4_0 .. "_"]:GetController("status")
	end

	self.bossChartController_ = self.controllerEx_:GetController("bosschart")
end

function ActivityReforgeChapterView:AddUIListeners()
	self:AddBtnListener(self.goldInfoBtn_, nil, function()
		JumpTools.OpenPageByJump("activityReforgeGoldInfoView")
	end)
	self:AddBtnListener(self.taskBtn_, nil, function()
		JumpTools.OpenPageByJump("/activityReforgeTaskView", {
			activityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.skillBtn_, nil, function()
		JumpTools.OpenPageByJump("/activityReforgeSkillView", {
			viewType = 1,
			activityID = self.activityID_,
			chapterActivityID = self.chapterActivityID_,
			levelID = self.levelID_
		})
	end)
	self:AddBtnListener(self.levelBtn_, nil, function()
		JumpTools.OpenPageByJump("/activityReforgeLevelView", {
			activityID = self.activityID_,
			chapterActivityID = self.chapterIDList_[self.curSelectIndex_]
		})
	end)

	for iter_5_0 = 1, 4 do
		self:AddBtnListener(self["chapterBtn" .. iter_5_0 .. "_"], nil, function()
			if iter_5_0 ~= self.curSelectIndex_ then
				return
			end

			JumpTools.OpenPageByJump("/activityReforgeLevelView", {
				activityID = self.activityID_,
				chapterActivityID = self.chapterIDList_[iter_5_0]
			})
		end)
		self:AddBtnListener(self["chapterListBtn" .. iter_5_0 .. "_"], nil, function()
			if iter_5_0 == self.curSelectIndex_ then
				return
			end

			if ActivityTools.GetActivityIsOpenWithTip(self.chapterIDList_[iter_5_0]) then
				if ActivityReforgeData:GetChapterIsUnlock(self.chapterIDList_[iter_5_0]) then
					self.curSelectIndex_ = iter_5_0

					self:RefreshUI()
					self.bossAni_:Play("boss02_refresh")
				else
					ShowTips("ACTIVITY_REFORGE_CHPATER_LOCK")
				end
			end
		end)
	end
end

function ActivityReforgeChapterView:OnEnter()
	self.activityID_ = self.params_.ActivityID
	self.chapterIDList_ = ActivityCfg[self.activityID_].sub_activity_list
	self.goldMaxNum_.text = ActivityReforgeData:GetGoldMaxNum(self.activityID_)

	self:CreateTimer()
	self:RefreshUI()
	self:BindRedPoint()
	self:CheckCacheAddGoldNum()
end

function ActivityReforgeChapterView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.skillBtn_.transform, RedPointConst.ACTIVITY_REFORGE_SKILL .. self.activityID_)
	manager.redPoint:bindUIandKey(self.taskBtn_.transform, RedPointConst.ACTIVITY_REFORGE_TASK .. self.activityID_)

	for iter_13_0 = 1, 4 do
		manager.redPoint:bindUIandKey(self["chapterListBtn" .. iter_13_0 .. "_"].transform, RedPointConst.ACTIVITY_REFORGE_NEW_CHPATER .. self.chapterIDList_[iter_13_0])
	end
end

function ActivityReforgeChapterView:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.skillBtn_.transform, RedPointConst.ACTIVITY_REFORGE_SKILL .. self.activityID_)
	manager.redPoint:unbindUIandKey(self.taskBtn_.transform, RedPointConst.ACTIVITY_REFORGE_TASK .. self.activityID_)

	for iter_14_0 = 1, 4 do
		manager.redPoint:unbindUIandKey(self["chapterListBtn" .. iter_14_0 .. "_"].transform, RedPointConst.ACTIVITY_REFORGE_NEW_CHPATER .. self.chapterIDList_[iter_14_0])
	end
end

function ActivityReforgeChapterView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey(self.gameHelpKey_)
end

function ActivityReforgeChapterView:OnExit()
	manager.windowBar:HideBar()
	self:UnBindRedPoint()
	self:StopTimer()
	self:StopAddGoldNumTimer()
end

function ActivityReforgeChapterView:CreateTimer()
	self.activityID_ = self.activityID_
	self.stopTime_ = ActivityData:GetActivityData(self.activityID_).stopTime

	if manager.time:GetServerTime() < self.stopTime_ then
		self.timeText_.text = manager.time:GetLostTimeStrWith2Unit(self.stopTime_)
	else
		self:StopTimer()

		self.timeText_.text = GetTips("TIME_OVER")
	end

	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			if manager.time:GetServerTime() < self.stopTime_ then
				self.timeText_.text = manager.time:GetLostTimeStrWith2Unit(self.stopTime_)
			else
				self:StopTimer()

				self.timeText_.text = GetTips("TIME_OVER")
			end
		end, 1, -1)

		self.timer_:Start()
	end
end

function ActivityReforgeChapterView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ActivityReforgeChapterView:StopAddGoldNumTimer()
	if self.addGoldNumCacheTimer_ then
		self.addGoldNumCacheTimer_:Stop()

		self.addGoldNumCacheTimer_ = nil
	end
end

function ActivityReforgeChapterView:RefreshUI()
	for iter_21_0 = 1, 4 do
		if ActivityReforgeData:GetChapterIsUnlock(self.chapterIDList_[iter_21_0]) then
			if self.curSelectIndex_ == iter_21_0 then
				self.btnControllerList_[iter_21_0]:SetSelectedState("on")
			else
				self.btnControllerList_[iter_21_0]:SetSelectedState("off")
			end
		else
			self.btnControllerList_[iter_21_0]:SetSelectedState("lock")
		end
	end

	self.nameText_.text = ActivityReforgeChapterCfg[self.chapterIDList_[self.curSelectIndex_]].chapter_name
	self.desText_.text = ActivityReforgeChapterCfg[self.chapterIDList_[self.curSelectIndex_]].chapter_des

	self.bossChartController_:SetSelectedState(self.curSelectIndex_)
end

function ActivityReforgeChapterView:CheckCacheAddGoldNum()
	local var_22_0 = ActivityReforgeData:GetCacheAddGoldNum()

	if var_22_0 > 0 then
		self.goldAddText_.text = "+" .. var_22_0

		SetActive(self.goldAddGo_, true)
		self:StopAddGoldNumTimer()

		self.addGoldNumCacheTimer_ = Timer.New(function()
			self:StopAddGoldNumTimer()
			SetActive(self.goldAddGo_, false)

			self.goldMaxNum_.text = ActivityReforgeData:SubGoldMaxNum(self.activityID_, var_22_0)

			ActivityReforgeData:ClearCacheAddGoldNum()
		end, 2, 1)

		self.addGoldNumCacheTimer_:Start()
	else
		SetActive(self.goldAddGo_, false)
	end
end

function ActivityReforgeChapterView:Dispose()
	self:StopTimer()
	self:StopAddGoldNumTimer()
	self.super.Dispose(self)
end

return ActivityReforgeChapterView
