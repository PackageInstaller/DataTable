local BattleFirstPassItem = class("BattleFirstPassItem", ReduxView)

function BattleFirstPassItem:OnCtor(arg_1_1)
	BattleFirstPassItem.gameObject_ = arg_1_1
	BattleFirstPassItem.transform_ = self.gameObject_.transform

	self:Init()
end

function BattleFirstPassItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function BattleFirstPassItem:InitUI()
	self:BindCfgUI()

	self.typeCon_ = ControllerUtil.GetController(self.transform_, "type")
end

function BattleFirstPassItem:AddUIListeners()
	self:AddBtnListener(self.Btn_, nil, function()
		local var_5_0 = manager.time:GetServerTime()

		if var_5_0 < self.startTime_ then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(self.startTime_)))
		elseif var_5_0 < self.stopTime_ then
			if self.clickFunc_ then
				self.clickFunc_(self.id_)
			end
		else
			ShowTips("TIP_EXPIRED")
		end
	end)
end

function BattleFirstPassItem:OnEnter()
	return
end

function BattleFirstPassItem:RefreshUI(arg_7_1, arg_7_2)
	self.activityID_ = arg_7_1
	self.id_ = arg_7_2
	self.cfg_ = ActivityFirstClearCfg[self.id_]
	self.startTime_ = self:GetStarTime()
	self.stopTime_ = self:GetStopTime()

	self:RefreshTitle()
	self:RefreshTime()
	self:RefreshRedPoint()
	self:RefreshClear()
end

function BattleFirstPassItem:GetStarTime()
	return ActivityData:GetActivityData(self.id_).startTime
end

function BattleFirstPassItem:GetStopTime()
	return ActivityData:GetActivityData(self.id_).stopTime
end

function BattleFirstPassItem:RefreshTitle()
	self.title_.text = "「" .. GetI18NText(self.cfg_.name) .. "」"
end

function BattleFirstPassItem:RefreshTime()
	local var_11_0
	local var_11_1 = manager.time:GetServerTime()

	self:StopTimer()

	if var_11_1 < self.startTime_ then
		self.timeCntText_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(self.startTime_))
		self.timer_ = Timer.New(function()
			var_11_0 = self.startTime_ - manager.time:GetServerTime()

			if var_11_0 <= 0 then
				self:StopTimer()
				self:SetSelected(self.select_)
				self:RefreshTime()

				return
			end

			self.timeCntText_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(self.startTime_))
		end, 1, -1)

		self.timer_:Start()
	elseif var_11_1 < self.stopTime_ then
		self.timer_ = Timer.New(function()
			var_11_0 = self.stopTime_ - manager.time:GetServerTime()

			if var_11_0 <= 0 then
				self:StopTimer()
				self:SetSelected(self.select_)
				self:RefreshTime()

				return
			end
		end, 1, -1)

		self.timer_:Start()
	else
		self.timeCntText_.text = GetTips("TIME_OVER")
	end
end

function BattleFirstPassItem:RefreshRedPoint()
	SetActive(self.redGo_, manager.redPoint:getTipValue(RedPointConst.BATTLE_FIRST_PASS .. self.id_) > 0)
end

function BattleFirstPassItem:RefreshClear()
	local var_15_0 = BattleFirstPassData:GetBattleData(self.activityID_, self.id_)

	if var_15_0 then
		SetActive(self.clearGo_, var_15_0.battleState ~= ActivityConst.BATTLE_FIRST_PASS_STATE.UNFINISHED)
	end
end

function BattleFirstPassItem:GetID()
	return self.id_
end

function BattleFirstPassItem:GetTitle()
	return self.cfg_.name
end

function BattleFirstPassItem:SetSelected(arg_18_1)
	self.select_ = arg_18_1

	local var_18_0 = manager.time:GetServerTime()

	if var_18_0 < self.startTime_ or var_18_0 >= self.stopTime_ then
		self.typeCon_:SetSelectedState("close")

		return
	elseif arg_18_1 then
		self.typeCon_:SetSelectedState("selected")
		BattleFirstPassAction:SetOnceRedPointOff(self.activityID_, self.id_)
		self:RefreshRedPoint()
	else
		self.typeCon_:SetSelectedState("open")
	end
end

function BattleFirstPassItem:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function BattleFirstPassItem:RegisterClickListener(arg_20_1)
	self.clickFunc_ = arg_20_1
end

function BattleFirstPassItem:OnExit()
	self:StopTimer()

	self.clickFunc_ = nil
end

function BattleFirstPassItem:Dispose()
	self:RemoveAllListeners()
	BattleFirstPassItem.super.Dispose(self)
end

return BattleFirstPassItem
