local AutoChessEnterView_4_8 = class("AutoChessEnterView_4_8", (import("game.views.activity.Main.toggle.ActivityMainBasePanel")))

function AutoChessEnterView_4_8:GetUIName()
	return "Widget/System/Activity_Xihe/Activity_Xihe_MainUI"
end

function AutoChessEnterView_4_8:Init()
	self:InitUI()
	self:AddListeners()
end

function AutoChessEnterView_4_8:InitUI()
	self:BindCfgUI()
end

function AutoChessEnterView_4_8:AddListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		if self.curLv < self.maxLv and not getData("auto_chess_pop", "PREVIOUS") then
			JumpTools.OpenPageByJump("autoChessQuitPopView", {
				gameType = AutoChessConst.GAME_TYPE.ONLINE,
				type = AutoChessConst.POP_TYPE.PREVIOUS_ADVICE,
				okCb = function()
					JumpTools.GoToSystem("/chapterMap", {
						chapterToggle = BattleConst.TOGGLE.RESIDENT_ACT,
						activityID = ActivityConst.ACTIVITY_AUTO_CHESS_MAIN
					})
				end,
				cancelCb = function()
					JumpTools.OpenPageByJump("/autoChessRemakeMainView")
				end
			})
		else
			JumpTools.OpenPageByJump("/autoChessRemakeMainView")
		end

		saveData("auto_chess_pop", "PREVIOUS", true)
	end)
	self:AddBtnListener(self.infoBtn_, nil, function()
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_main_homepage_rules",
			activity_id = AutoChessData:GetActivityID()
		})
		JumpTools.OpenPageByJump("gameHelp", {
			key = "AUTO_CHESS_2_ENTRANCE_TIP",
			content = GetTips("AUTO_CHESS_2_ENTRANCE_TIP")
		})
	end)
	self:AddBtnListener(self.jumpBtn_, nil, function()
		JumpTools.GoToSystem("/chapterMap", {
			chapterToggle = BattleConst.TOGGLE.RESIDENT_ACT,
			activityID = ActivityConst.ACTIVITY_AUTO_CHESS_MAIN
		})
	end)
	self:AddBtnListener(self.limitTaskBtn_, nil, function()
		JumpTools.OpenPageByJump("/autoChessLimitTaskView_4_8", {
			activityID = ActivityConst.ACTIVITY_AUTO_CHESS_4_8_LIMITED_TASK
		})
	end)
end

function AutoChessEnterView_4_8:OnEnter()
	self.super.OnEnter(self)
	self:BindRedPoint()

	self.curLv, self.maxLv = TaskTools.GetTaskNumInfo(ActivityConst.ACTIVITY_AUTO_CHESS_MAIN)
	self.processText_.text = string.format("<size=48>%d</size>/%d", self.curLv, self.maxLv)
	self.processImg_.fillAmount = self.curLv / self.maxLv

	self:RefreshTime()
end

function AutoChessEnterView_4_8:RefreshTime()
	local var_12_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_AUTO_CHESS_4_8_LIMITED_TASK)

	self.timeText_.text = manager.time:GetLostTimeStr2(var_12_0.stopTime)

	SetActive(self.limitTaskBtn_.gameObject, ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_4_8_LIMITED_TASK))

	if self.limittimer_ == nil then
		self.limittimer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_4_8_LIMITED_TASK) then
				self.timeText_.text = manager.time:GetLostTimeStr2(var_12_0.stopTime)
			else
				SetActive(self.limitTaskBtn_.gameObject, false)
				self:LimitStopTimer()
			end
		end, 1, -1)

		self.limittimer_:Start()
	end
end

function AutoChessEnterView_4_8:LimitStopTimer()
	if self.limittimer_ then
		self.limittimer_:Stop()

		self.limittimer_ = nil
	end
end

function AutoChessEnterView_4_8:BindRedPoint()
	manager.redPoint:bindUIandKey(self.goBtn_.transform, RedPointConst.AUTO_CHESS_4_8_GO_BTN)
	manager.redPoint:bindUIandKey(self.limitTaskBtn_.transform, RedPointConst.AUTO_CHESS_4_8_LIMIT_TASK .. ActivityConst.ACTIVITY_AUTO_CHESS_4_8_LIMITED_TASK)
end

function AutoChessEnterView_4_8:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.goBtn_.transform, RedPointConst.AUTO_CHESS_4_8_GO_BTN)
	manager.redPoint:unbindUIandKey(self.limitTaskBtn_.transform, RedPointConst.AUTO_CHESS_4_8_LIMIT_TASK .. ActivityConst.ACTIVITY_AUTO_CHESS_4_8_LIMITED_TASK)
end

function AutoChessEnterView_4_8:OnTop()
	return
end

function AutoChessEnterView_4_8:OnExit()
	if self.move then
		Object.Destroy(self.move)

		self.move = nil
	end

	self:LimitStopTimer()
	self:UnBindRedPoint()
	AutoChessEnterView_4_8.super.OnExit(self)
end

function AutoChessEnterView_4_8:Dispose()
	AutoChessEnterView_4_8.super.Dispose(self)
end

return AutoChessEnterView_4_8
