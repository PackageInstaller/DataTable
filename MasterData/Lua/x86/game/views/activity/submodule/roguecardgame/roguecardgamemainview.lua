ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local RogueCardGameMainView = class("RogueCardGameMainView", ActivityMainBasePanel)

function RogueCardGameMainView:GetUIName()
	return "Widget/System/Activity_JokerCard/Activity_JokerCard_MainUI"
end

function RogueCardGameMainView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function RogueCardGameMainView:InitUI()
	self:BindCfgUI()

	self.skinCon_ = self.skinDLCController_:GetController("state")
	self.onRefreshDLCHandler = handler(self, self.OnRefreshDLC)
end

function RogueCardGameMainView:AddUIListeners()
	self:AddBtnListener(self.infoBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			content = GetI18NText(ActivityToggleCfg[ActivityToggleCfg.get_id_list_by_activity_id[self.activityID_][1]].desc)
		})
	end)
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/rogueCardGameLimitTaskView", {
			activityID = ActivityConst.ACTIVITY_ROGUECARD_TASK
		})
	end)
	self:AddBtnListener(self.dlcBtn_, nil, function()
		JumpTools.OpenPageByJump("rogueCardGameSkinDLCPopView")
	end)
	self:AddBtnListener(self.goBtn_, nil, function()
		local var_8_0 = RogueCardGameData:GetChallengeBattleId()

		if var_8_0 and tonumber(var_8_0) > 0 then
			RogueCardGameAction.GetStageSaveDataJumpChallenge(var_8_0, 2)
		end

		if PlayerData:GetStoryList()[GameSetting.rogue_card_start_story.value[1]] then
			JumpTools.OpenPageByJump("/rogueCardGameHomeView", {
				isHome = true
			})
		else
			manager.story:StartStoryById(GameSetting.rogue_card_start_story.value[1], function(arg_9_0)
				JumpTools.OpenPageByJump("/rogueCardGameHomeView", {
					isHome = true
				})
			end, false)
		end
	end)
end

function RogueCardGameMainView:OnEnter()
	RogueCardGameMainView.super.OnEnter(self)
	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, self.onRefreshDLCHandler)
	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, RedPointConst.ACTIVITY_ROGUECARD_LIMIT_TASK .. ActivityConst.ACTIVITY_ROGUECARD_TASK)
	manager.redPoint:bindUIandKey(self.goBtn_.transform, RedPointConst.ACTIVITY_ROGUECARD_5_0 .. ActivityConst.ACTIVITY_ROGUECARD_5_0)
	manager.redPoint:bindUIandKey(self.dlcBtn_.transform, RedPointConst.ACTIVITY_ROGUECARD_SKIN_DLC_GIFT .. ActivityConst.ACTIVITY_ROGUECARD_SKIN)
	self:BindRedPoint()
	self:RefreshView()
end

function RogueCardGameMainView:RefreshTimeText()
	if self.timeText_ then
		self.timeText_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(self.stopTime_, true)
	end
end

function RogueCardGameMainView:RefreshView()
	self:AddTimer()
	self:RefreshDLCState()
end

function RogueCardGameMainView:RefreshDLCState()
	local var_13_1 = 0
	local var_13_2 = false

	for iter_13_0, iter_13_1 in ipairs(AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_ROGUECARD_SKIN] or {}) do
		local var_13_3 = TaskData2:GetTaskProgress(iter_13_1) >= AssignmentCfg[iter_13_1].need

		if TaskData2:GetTaskComplete(iter_13_1) then
			var_13_1 = var_13_1 + 1
		elseif var_13_3 then
			var_13_2 = true
		end
	end

	if var_13_1 == 2 then
		self.skinCon_:SetSelectedIndex(2)
	elseif var_13_2 then
		self.skinCon_:SetSelectedIndex(1)
	else
		self.skinCon_:SetSelectedIndex(0)
	end
end

function RogueCardGameMainView:OnRefreshDLC()
	self:RefreshDLCState()
end

function RogueCardGameMainView:AddTimer()
	self:taskStopTimer()

	local var_15_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_ROGUECARD_TASK)
	local var_15_1 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_ROGUECARD_SKIN)

	self.taskTimeText_.text = manager.time:GetLostTimeStr(var_15_0.stopTime, true)
	self.skinTimeText_.text = manager.time:GetLostTimeStr(var_15_1.stopTime, true)
	self.tasktimer_ = Timer.New(function()
		self.taskTimeText_.text = manager.time:GetLostTimeStr(var_15_0.stopTime, true)
		self.skinTimeText_.text = manager.time:GetLostTimeStr(var_15_1.stopTime, true)
	end, 1, -1)

	self.tasktimer_:Start()
end

function RogueCardGameMainView:taskStopTimer()
	if self.tasktimer_ then
		self.tasktimer_:Stop()

		self.tasktimer_ = nil
	end
end

function RogueCardGameMainView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function RogueCardGameMainView:Show(arg_19_1)
	SetActive(self.gameObject_, arg_19_1)

	if arg_19_1 then
		self:UpdatePreview()
		self:RefreshView()
	end
end

function RogueCardGameMainView:BindRedPoint()
	return
end

function RogueCardGameMainView:UnBindRedPoint()
	return
end

function RogueCardGameMainView:OnTop()
	self:UpdateBar()
end

function RogueCardGameMainView:OnExit()
	manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, RedPointConst.ACTIVITY_ROGUECARD_LIMIT_TASK .. ActivityConst.ACTIVITY_ROGUECARD_TASK)
	manager.redPoint:unbindUIandKey(self.goBtn_.transform, RedPointConst.ACTIVITY_ROGUECARD_5_0 .. ActivityConst.ACTIVITY_ROGUECARD_5_0)
	manager.redPoint:unbindUIandKey(self.dlcBtn_.transform, RedPointConst.ACTIVITY_ROGUECARD_SKIN_DLC_GIFT .. ActivityConst.ACTIVITY_ROGUECARD_SKIN)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, self.onRefreshDLCHandler)
	self:taskStopTimer()
	self:UnBindRedPoint()
	RogueCardGameMainView.super.OnExit(self)
end

function RogueCardGameMainView:Dispose()
	self:RemoveAllListeners()
	RogueCardGameMainView.super.Dispose(self)
end

return RogueCardGameMainView
