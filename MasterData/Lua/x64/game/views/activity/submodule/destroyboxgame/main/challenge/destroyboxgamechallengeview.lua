local DestroyBoxGameChallengeView = class("DestroyBoxGameChallengeView", ReduxView)

function DestroyBoxGameChallengeView:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.index_ = arg_1_2

	self:BindCfgUI()
	self:AddListeners()

	self.boxStateController_ = ControllerUtil.GetController(self.transform_, "lock")
	self.rewardStateController_ = ControllerUtil.GetController(self.transform_, "rewardState")
	self.rewardItem_ = CommonItemView.New(self.itemGo_)
end

function DestroyBoxGameChallengeView:OnEnter(arg_2_1)
	self.mainActivityID_ = arg_2_1
	self.id_ = DestroyBoxGameData:GetDifficultList(arg_2_1)[DestroyBoxGameData.SPECTIAL_HARD_LEVEL][self.index_]
	self.activityID_ = DestroyBoxGameCfg[self.id_].activity_id
	self.rewardID_ = DestroyBoxGameRewardCfg.get_id_list_by_activity_id[DestroyBoxGameCfg[self.id_].activity_id][1]

	local var_2_0 = clone(ItemTemplateData)

	var_2_0.id = DestroyBoxGameRewardCfg[DestroyBoxGameRewardCfg.get_id_list_by_activity_id[DestroyBoxGameCfg[self.id_].activity_id][1]].item_list[1][1]
	var_2_0.number = DestroyBoxGameRewardCfg[DestroyBoxGameRewardCfg.get_id_list_by_activity_id[DestroyBoxGameCfg[self.id_].activity_id][1]].item_list[1][2]
	var_2_0.hideBottomRightTextFlag = true

	function var_2_0:clickFun()
		if self.receiveRewardState_ == 1 then
			self:ReceiveReward()
		else
			ShowPopItem(POP_ITEM, {
				self.id,
				self.number
			})
		end
	end

	self.rewardItem_:SetData(var_2_0)
	self:RefreshData()
	self:RefreshUI()
	self:AddTimer()
	manager.redPoint:bindUIandKey(self.transform_, string.format("%s_%s_%s", RedPointConst.DESTROY_BOX_GAME_STAGE, DestroyBoxGameCfg[self.id_].difficult, self.activityID_))
end

function DestroyBoxGameChallengeView:OnExit()
	manager.redPoint:unbindUIandKey(self.transform_, string.format("%s_%s_%s", RedPointConst.DESTROY_BOX_GAME_STAGE, DestroyBoxGameCfg[self.id_].difficult, self.activityID_))
	self:StopTimer()
end

function DestroyBoxGameChallengeView:Dispose()
	DestroyBoxGameChallengeView.super.Dispose(self)
	self.rewardItem_:Dispose()

	self.transform_ = nil
	self.gameObject_ = nil
end

function DestroyBoxGameChallengeView:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if not self.isTimeLock_ and not not self.isFinishPreStage_ then
			DestroyBoxGameAction.ClickBoxStageItem(self.activityID_, self.id_)
		else
			return
		end

		local var_7_0 = DestroyBoxGameCfg[self.id_].main_activity_id

		if DestroyBoxGameData:GetSelectID(DestroyBoxGameCfg[self.id_].main_activity_id) ~= self.id_ then
			DestroyBoxGameData:SetSelectIDAndDifficult(var_7_0, self.id_)
		end

		if self.receiveRewardState_ == 1 then
			self:ReceiveReward()
		else
			self:GotoBattle(var_7_0)
		end
	end)
end

function DestroyBoxGameChallengeView:GotoBattle(arg_8_1)
	local var_8_0 = ActivityData:GetActivityData(arg_8_1)
	local var_8_1 = manager.time:GetServerTime()

	if var_8_1 < var_8_0.startTime then
		ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr2(var_8_0.startTime, nil, true)))

		return
	elseif var_8_1 >= var_8_0.stopTime then
		ShowTips("TIME_OVER")

		return
	end

	local var_8_2 = DestroyBoxGameCfg[self.id_]

	DestroyBoxGameAction.ClickBoxStageItem(DestroyBoxGameCfg[self.id_].activity_id, self.id_)
	self:Go("/sectionSelectHero", {
		canChangeTeam = false,
		activityID = var_8_2.activity_id,
		section = var_8_2.stage_id,
		sectionType = BattleConst.STAGE_TYPE_NEW.DESTROY_BOX_GAME
	})
end

function DestroyBoxGameChallengeView:RefreshData()
	self.targetScore_ = DestroyBoxGameRewardCfg[self.rewardID_].complete_num

	local var_9_0 = DestroyBoxGameData:GetStageData(self.id_)

	if var_9_0 then
		self.maxScore_ = var_9_0.maxScore

		if self.maxScore_ >= self.targetScore_ then
			self.receiveRewardState_ = 1
		end
	else
		self.maxScore_ = 0
	end

	self.receiveRewardState_ = table.keyof(DestroyBoxGameData:GetReceiveRewardList(self.mainActivityID_), self.rewardID_) and 2 or self.receiveRewardState_
	self.isFinishPreStage_ = DestroyBoxGameData:IsFinishPreStage(self.id_)
end

function DestroyBoxGameChallengeView:RefreshUI()
	self:RefreshRewardState()
	self:RefreshTips()
end

function DestroyBoxGameChallengeView:RefreshTips()
	self.curScoreText_.text = self.maxScore_
	self.targetScoreText_.text = string.format("/%s", self.targetScore_)

	local var_11_0 = DestroyBoxGameCfg[self.id_]
	local var_11_1 = DestroyBoxGameCfg[self.id_].unlock_condition
	local var_11_2 = DestroyBoxGameCfg[DestroyBoxGameCfg[self.id_].unlock_condition[1]]
	local var_11_3 = DestroyBoxGameCfg[DestroyBoxGameCfg[self.id_].unlock_condition[1]].difficult

	if DestroyBoxGameCfg[DestroyBoxGameCfg[self.id_].unlock_condition[1]].difficult == 1 then
		var_11_3 = GetTips("HARDLEVEL_EASY")
	elseif var_11_3 == 2 then
		var_11_3 = GetTips("HARDLEVEL_HARD")
	end

	self.titleText_.text = BattleDestroyBoxGameCfg[var_11_0.stage_id].name
	self.lockText_.text = string.format(GetTips("DESTROY_BOX_GAME_UNLOCK_STAGE_1"), ActivityCfg[var_11_2.activity_id].remark, var_11_3, var_11_1[2])
end

function DestroyBoxGameChallengeView:RefreshRewardState()
	self.rewardItem_:RefreshCompleted(false)

	if self.receiveRewardState_ == 2 then
		self.rewardItem_:RefreshCompleted(true)
		self.rewardStateController_:SetSelectedState("normal")
	elseif self.receiveRewardState_ == 1 then
		self.rewardStateController_:SetSelectedState("canReceive")
	else
		self.rewardStateController_:SetSelectedState("normal")
	end
end

function DestroyBoxGameChallengeView:RefreshBoxState()
	if not self.isFinishPreStage_ or self.isTimeLock_ then
		self.rewardStateController_:SetSelectedState("lock")

		if self.isFinishPreStage_ and self.isTimeLock_ then
			self.lockText_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr2(ActivityData:GetActivityData(DestroyBoxGameCfg[self.id_].activity_id).startTime, nil, true))
		end
	else
		self.rewardStateController_:SetSelectedState("normal")
	end
end

function DestroyBoxGameChallengeView:SwitchSelectItem(arg_14_1)
	if self.id_ == arg_14_1 then
		-- block empty
	end
end

function DestroyBoxGameChallengeView:ReceiveReward()
	DestroyBoxGameAction.RequestReward(self.mainActivityID_, {
		self.rewardID_
	}, function()
		self:RefreshData()
		self:RefreshRewardState()
	end)
end

function DestroyBoxGameChallengeView:AddTimer()
	self:StopTimer()

	local var_17_0 = DestroyBoxGameCfg[self.id_]

	self.isTimeLock_ = ActivityTools.GetActivityStatus(DestroyBoxGameCfg[self.id_].activity_id) ~= 1

	self:RefreshBoxState()

	if self.isFinishPreStage_ then
		self.timer_ = Timer.New(function()
			local var_18_0 = ActivityTools.GetActivityStatus(var_17_0.activity_id) ~= 1

			if var_18_0 ~= self.isTimeLock_ then
				self.isTimeLock_ = var_18_0

				self:RefreshBoxState()
			end
		end, 1, -1)

		self.timer_:Start()
	end
end

function DestroyBoxGameChallengeView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return DestroyBoxGameChallengeView
