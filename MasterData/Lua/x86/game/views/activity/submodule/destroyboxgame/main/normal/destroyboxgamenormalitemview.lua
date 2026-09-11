local DestroyBoxGameNormalItemView = class("DestroyBoxGameNormalItemView", ReduxView)

function DestroyBoxGameNormalItemView:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.boxStateController_ = ControllerUtil.GetController(self.transform_, "boxState")

	if arg_1_3 % 2 == 0 then
		-- block empty
	end

	self:Show(true)
end

function DestroyBoxGameNormalItemView:OnEnter(arg_2_1)
	self.id_ = arg_2_1
	self.activityID_ = DestroyBoxGameCfg[self.id_].activity_id

	local var_2_0 = table.keyof(DestroyBoxGameData:GetDifficultList(DestroyBoxGameCfg[self.id_].main_activity_id)[DestroyBoxGameCfg[self.id_].difficult], self.id_)

	self.numText_.text = string.format("%02d", var_2_0)
	self.index_ = var_2_0
	self.isClearStage_ = DestroyBoxGameData:IsClearStage(arg_2_1)
	self.isFinishPreStage_ = DestroyBoxGameData:IsFinishPreStage(arg_2_1)

	self:RefreshScore()
	self:AddTimer()
	self:AddRedPoint()
end

function DestroyBoxGameNormalItemView:RefreshScore()
	local var_3_0 = DestroyBoxGameData:GetStageData(self.id_)

	self.text8Text_.text = var_3_0 and var_3_0.maxScore or 0
end

function DestroyBoxGameNormalItemView:OnExit()
	self:StopTimer()
	self:RemoveRedPoint()
end

function DestroyBoxGameNormalItemView:AddRedPoint()
	manager.redPoint:bindUIandKey(self.transform_, string.format("%s_%s_%s", RedPointConst.DESTROY_BOX_GAME_STAGE_OPEN, DestroyBoxGameCfg[self.id_].difficult, self.activityID_))
end

function DestroyBoxGameNormalItemView:RemoveRedPoint()
	manager.redPoint:unbindUIandKey(self.transform_, string.format("%s_%s_%s", RedPointConst.DESTROY_BOX_GAME_STAGE_OPEN, DestroyBoxGameCfg[self.id_].difficult, self.activityID_))
end

function DestroyBoxGameNormalItemView:Dispose()
	DestroyBoxGameNormalItemView.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function DestroyBoxGameNormalItemView:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if self.isTimeLock_ then
			local var_9_0 = ActivityData:GetActivityData(DestroyBoxGameCfg[self.id_].activity_id)
			local var_9_1 = manager.time:GetServerTime()

			if var_9_1 < var_9_0.startTime then
				ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr2(var_9_0.startTime, nil, true)))
			elseif var_9_1 >= var_9_0.stopTime then
				ShowTips("TIME_OVER")
			end

			return
		elseif not self.isFinishPreStage_ then
			local var_9_2 = DestroyBoxGameCfg[self.id_].unlock_condition
			local var_9_3 = DestroyBoxGameCfg[DestroyBoxGameCfg[self.id_].unlock_condition[1]]
			local var_9_4 = DestroyBoxGameCfg[DestroyBoxGameCfg[self.id_].unlock_condition[1]].difficult

			if DestroyBoxGameCfg[DestroyBoxGameCfg[self.id_].unlock_condition[1]].difficult == 1 then
				var_9_4 = GetTips("HARDLEVEL_EASY")
			elseif var_9_4 == 2 then
				var_9_4 = GetTips("HARDLEVEL_HARD")
			end

			if var_9_2[2] > 1 then
				ShowTips(string.format(GetTips("DESTROY_BOX_GAME_UNLOCK_STAGE_1"), ActivityCfg[var_9_3.activity_id].remark, var_9_4, var_9_2[2]))
			else
				ShowTips(string.format(GetTips("DESTROY_BOX_GAME_UNLOCK_STAGE"), ActivityCfg[var_9_3.activity_id].remark, var_9_4))
			end

			return
		end

		DestroyBoxGameAction.ClickBoxStageItem(self.activityID_, self.id_)

		if DestroyBoxGameData:GetSelectID(DestroyBoxGameCfg[self.id_].main_activity_id) ~= self.id_ then
			DestroyBoxGameData:SetSelectIDAndDifficult(DestroyBoxGameCfg[self.id_].main_activity_id, self.id_)
		end

		self:GotoBattle(DestroyBoxGameCfg[self.id_].main_activity_id)
	end)
end

function DestroyBoxGameNormalItemView:GotoBattle(arg_10_1)
	local var_10_0 = ActivityData:GetActivityData(arg_10_1)
	local var_10_1 = manager.time:GetServerTime()

	if var_10_1 < var_10_0.startTime then
		ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr2(var_10_0.startTime, nil, true)))

		return
	elseif var_10_1 >= var_10_0.stopTime then
		ShowTips("TIME_OVER")

		return
	end

	local var_10_2 = DestroyBoxGameCfg[self.id_]

	DestroyBoxGameAction.ClickBoxStageItem(DestroyBoxGameCfg[self.id_].activity_id, self.id_)
	self:Go("/sectionSelectHero", {
		canChangeTeam = false,
		activityID = var_10_2.activity_id,
		section = var_10_2.stage_id,
		sectionType = BattleConst.STAGE_TYPE_NEW.DESTROY_BOX_GAME
	})
end

function DestroyBoxGameNormalItemView:Show(arg_11_1)
	SetActive(self.gameObject_, arg_11_1)
end

function DestroyBoxGameNormalItemView:SwitchDifficult()
	self:RemoveRedPoint()

	self.id_ = DestroyBoxGameCfg.get_id_list_by_activity_id[DestroyBoxGameCfg[self.id_].activity_id][DestroyBoxGameData:GetSelectDifficult(DestroyBoxGameCfg[self.id_].main_activity_id)]

	self:AddRedPoint()

	self.isClearStage_ = DestroyBoxGameData:IsClearStage(self.id_)
	self.isFinishPreStage_ = DestroyBoxGameData:IsFinishPreStage(self.id_)

	self:RefreshScore()
	self:AddTimer()
end

function DestroyBoxGameNormalItemView:RefreshBoxState()
	if self.isClearStage_ then
		self.boxStateController_:SetSelectedState("clear")
	elseif not self.isFinishPreStage_ or self.isTimeLock_ then
		self.boxStateController_:SetSelectedState("lock")
	else
		self.boxStateController_:SetSelectedState("unlock")
	end
end

function DestroyBoxGameNormalItemView:SwitchSelectItem(arg_14_1)
	if self.id_ == arg_14_1 then
		-- block empty
	end
end

function DestroyBoxGameNormalItemView:AddTimer()
	self:StopTimer()

	local var_15_0 = DestroyBoxGameCfg[self.id_]

	self.isTimeLock_ = ActivityTools.GetActivityStatus(DestroyBoxGameCfg[self.id_].activity_id) ~= 1

	self:RefreshBoxState()

	if self.isFinishPreStage_ then
		self.timer_ = Timer.New(function()
			local var_16_0 = ActivityTools.GetActivityStatus(var_15_0.activity_id) ~= 1

			if var_16_0 ~= self.isTimeLock_ then
				self.isTimeLock_ = var_16_0

				self:RefreshBoxState()
			end
		end, 1, -1)

		self.timer_:Start()
	end
end

function DestroyBoxGameNormalItemView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return DestroyBoxGameNormalItemView
