local ActivityRaceStageItem = class("ActivityRaceStageItem", ReduxView)

function ActivityRaceStageItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.lockController_ = ControllerUtil.GetController(self.transform_, "lock")
	self.selctController_ = ControllerUtil.GetController(self.transform_, "select")
	self.indexController_ = ControllerUtil.GetController(self.transform_, "index")

	SetActive(self.gameObject_, true)
end

function ActivityRaceStageItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if self.isLock_ then
			ShowTips(string.format(GetTips("ACTIVITY_RACE_UNLOCK"), GetI18NText(BattleActivityRaceStageCfg[ActivityRaceCfg[self.activityID_].stage_list[table.keyof(ActivityRaceCfg[self.activityID_].stage_list, self.stageID_) - 1]].name)))

			return
		end

		if manager.time:GetServerTime() >= self.stopTime_ then
			ShowTips("TIME_OVER")

			return
		end

		ActivityRaceData:SetSelectActivityID(self.activityID_)

		if self.selectCallBack_ ~= nil then
			self.selectCallBack_(self.index_, self.stageID_)
		end

		ActivityRaceData:SetTempActivityID(self.activityID_)
		self:Go("activityRaceSectionInfo", {
			section = self.stageID_,
			stageIndex = self.index_,
			sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_RACE,
			activityID = self.activityID_
		})
	end)
end

function ActivityRaceStageItem:SetData(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	self.activityID_ = arg_4_1
	self.stageID_ = arg_4_2
	self.index_ = arg_4_3
	self.isLock_ = arg_4_4
	self.isBossStage_ = self.stageID_ == ActivityRaceCfg[self.activityID_].stage_list[#ActivityRaceCfg[self.activityID_].stage_list]
	self.stopTime_ = ActivityData:GetActivityData(self.activityID_).stopTime

	self:RefreshUI()
end

function ActivityRaceStageItem:SetSelectCallBack(arg_5_1)
	self.selectCallBack_ = arg_5_1
end

function ActivityRaceStageItem:RefreshUI()
	if not self.isBossStage_ then
		self.indexController_:SetSelectedState(tostring(self.index_))
	end

	self.lockController_:SetSelectedState(tostring(self.isLock_))
	self:RefreshTitle()
	self:RefreshScore()
	self:RefreshCompleted()
end

function ActivityRaceStageItem:RefreshTitle()
	self.titleText_.text = GetI18NText(BattleActivityRaceStageCfg[self.stageID_].name)
end

function ActivityRaceStageItem:RefreshCompleted()
	if self.completedImageGo_ ~= nil then
		if ActivityRaceData:GetStateList()[self.activityID_].completedStageList[self.stageID_] == true then
			SetActive(self.completedImageGo_, true)
		else
			SetActive(self.completedImageGo_, false)
		end
	end
end

function ActivityRaceStageItem:RefreshScore()
	if self.isBossStage_ then
		SetActive(self.scorePanelGo_, true)

		self.scoreText_.text = ActivityRaceData:GetStateList()[self.activityID_].score
	else
		SetActive(self.scorePanelGo_, false)
	end
end

function ActivityRaceStageItem:RefreshSelect(arg_10_1)
	if arg_10_1 == self.stageID_ then
		self.selctController_:SetSelectedState("true")
	else
		self.selctController_:SetSelectedState("false")
	end
end

function ActivityRaceStageItem:OnExit()
	self.selctController_:SetSelectedState("false")
end

function ActivityRaceStageItem:Dispose()
	ActivityRaceStageItem.super.Dispose(self)
end

return ActivityRaceStageItem
