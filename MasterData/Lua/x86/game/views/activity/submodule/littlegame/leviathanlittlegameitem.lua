local LeviathanLittleGameItem = class("LeviathanLittleGameItem", ReduxView)

function LeviathanLittleGameItem:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.index_ = arg_1_4
	self.chapterID_ = arg_1_2
	self.activityID_ = arg_1_3

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "name")
end

function LeviathanLittleGameItem:OnEnter()
	self.nameText_.text = GetI18NText(ActivityBubblesCfg[self.chapterID_].name)

	self:AddTimer()
end

function LeviathanLittleGameItem:OnExit()
	self:StopTimer()
end

function LeviathanLittleGameItem:Dispose()
	self.transform_ = nil
	self.gameObject_ = nil

	LeviathanLittleGameItem.super.Dispose(self)
end

function LeviathanLittleGameItem:AddListeners()
	self:AddBtnListener(self.btnBtn_, nil, function()
		local var_6_0

		if manager.time:GetServerTime() < self:GetOpenTimestamp() then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(self:GetOpenTimestamp())))

			do return end

			var_6_0 = {
				chapterID = self.chapterID_
			}
		end

		var_6_0.section = ActivityBubblesCfg[self.chapterID_].stage_id
		var_6_0.sectionType = BattleConst.STAGE_TYPE_NEW.LEVIATHAN_GAME

		self:Go("leviathanSectionInfo", var_6_0)

		if self.func_ then
			self.func_(self.index_)
		end
	end)
end

function LeviathanLittleGameItem:GetOpenTimestamp()
	return ActivityData:GetActivityData(self.chapterID_).startTime or 0
end

function LeviathanLittleGameItem:AddClickFunc(arg_8_1)
	self.func_ = arg_8_1
end

function LeviathanLittleGameItem:AddTimer()
	self:RefreshState()

	local var_9_0 = manager.time:GetServerTime() - self:GetOpenTimestamp()

	if var_9_0 >= 0 then
		return
	end

	self.timetextText_.text = string.format(GetTips("OPEN_TIME"), (manager.time:GetLostTimeStr(self:GetOpenTimestamp())))

	self:StopTimer()

	self.timer_ = Timer.New(function()
		var_9_0 = manager.time:GetServerTime() - self:GetOpenTimestamp()

		self:RefreshState()

		self.timetextText_.text = string.format(GetTips("OPEN_TIME"), (manager.time:GetLostTimeStr(self:GetOpenTimestamp())))

		if var_9_0 >= 0 then
			self:StopTimer()
		end
	end, 1, -1)

	self.timer_:Start()
end

function LeviathanLittleGameItem:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function LeviathanLittleGameItem:RefreshState()
	if self:IsClear() then
		self.controller_:SetSelectedState("clear")

		return
	end

	if manager.time:GetServerTime() >= self:GetOpenTimestamp() then
		self.controller_:SetSelectedState("normal")

		return
	end

	self.controller_:SetSelectedState("lock")
end

function LeviathanLittleGameItem:IsOpen()
	if manager.time:GetServerTime() >= self:GetOpenTimestamp() then
		return true
	end

	return false
end

function LeviathanLittleGameItem:IsClear()
	local var_14_0 = SummerLittleGameData:GetLeviathanState(self.chapterID_)

	if var_14_0 == 1 or var_14_0 == 2 then
		return true
	end

	return false
end

return LeviathanLittleGameItem
