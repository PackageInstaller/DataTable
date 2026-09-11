local SequentialBattleChapterItem = class("SequentialBattleChapterItem", ReduxView)

function SequentialBattleChapterItem:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform
	self.activityID_ = arg_1_3

	self:BindCfgUI()
	self:AddListeners()

	self.selectController_ = ControllerUtil.GetController(self.transform_, "name")
	self.lockController_ = ControllerUtil.GetController(self.transform_, "lock")
	self.finishController_ = ControllerUtil.GetController(self.transform_, "finish")

	if SequentialBattleData:GetChapterData(self.activityID_) == nil then
		SequentialBattleData:InitChapterData(self.activityID_)
	end
end

function SequentialBattleChapterItem:OnEnter()
	manager.redPoint:bindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE_DAY, self.activityID_))
	self:AddTimer()

	self.nameText1_.text = GetI18NText(SequentialBattleChapterCfg[self.activityID_].stage_name)
	self.nameText2_.text = GetI18NText(SequentialBattleChapterCfg[self.activityID_].stage_name)

	self:RefreshFinishStatus()
	SetActive(self.gameObject_, true)
end

function SequentialBattleChapterItem:OnExit()
	self:StopTimer()
	manager.redPoint:unbindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE_DAY, self.activityID_))
end

function SequentialBattleChapterItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if self.lock_ then
			local var_5_0 = ActivityData:GetActivityData(self.activityID_)

			if manager.time:GetServerTime() < var_5_0.startTime then
				ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_5_0.startTime)))
			else
				ShowTips("TIME_OVER")
			end

			return
		else
			SequentialBattleData:SetSelectChapterID(SequentialBattleChapterCfg[self.activityID_].main_id, self.activityID_)
			manager.notify:Invoke(SEQUENTIAL_BATTLE_SELECT_CHAPTER)
		end
	end)
end

function SequentialBattleChapterItem:RefreshSelect(arg_6_1)
	if self.activityID_ == arg_6_1 then
		self.selectController_:SetSelectedState("Select")
	else
		self.selectController_:SetSelectedState("no")
	end
end

function SequentialBattleChapterItem:RefreshLock()
	if self.lock_ then
		self.lockController_:SetSelectedState("on")
	else
		self.lockController_:SetSelectedState("off")
	end
end

function SequentialBattleChapterItem:RefreshFinishStatus()
	if table.length(SequentialBattleData:GetChapterData(self.activityID_).historyFinishStage) < #SequentialBattleChapterCfg[self.activityID_].stage_id then
		self.finishController_:SetSelectedState("false")
	else
		self.finishController_:SetSelectedState("true")
	end
end

function SequentialBattleChapterItem:Dispose()
	SequentialBattleChapterItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function SequentialBattleChapterItem:AddTimer()
	self:StopTimer()

	local var_10_0 = ActivityData:GetActivityData(self.activityID_)

	self.lock_ = manager.time:GetServerTime() < var_10_0.startTime or manager.time:GetServerTime() > var_10_0.stopTime

	self:RefreshLock()

	local var_10_1 = GetTips("OPEN_TIME")

	self.unlockText_.text = manager.time:GetServerTime() > var_10_0.stopTime and GetTips("TIME_OVER") or string.format(var_10_1, manager.time:GetLostTimeStr(var_10_0.startTime))
	self.timer_ = Timer.New(function()
		local var_11_0 = manager.time:GetServerTime()

		if var_11_0 >= var_10_0.startTime and var_11_0 < var_10_0.stopTime then
			if self.lock_ == true then
				self.lock_ = false

				self:RefreshLock()
			else
				self.lock_ = false
			end
		elseif var_11_0 > var_10_0.stopTime then
			self:StopTimer()

			self.lock_ = true

			self:RefreshLock()

			self.unlockText_.text = GetTips("TIME_OVER")
		elseif var_11_0 < var_10_0.startTime then
			self.unlockText_.text = string.format(var_10_1, manager.time:GetLostTimeStr(var_10_0.startTime))
		end
	end, 1, -1)

	self.timer_:Start()
end

function SequentialBattleChapterItem:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return SequentialBattleChapterItem
