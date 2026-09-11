local PopSourceUnlockItemView = class("PopSourceUnlockItemView", ReduxView)

function PopSourceUnlockItemView:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform
	self.data_ = arg_1_3

	self:Init()
	SetActive(self.gameObject_, true)
end

function PopSourceUnlockItemView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "name")

	self:RefreshUI()
end

function PopSourceUnlockItemView:Dispose()
	self:StopTimer()
	self:RemoveListeners()

	self.callback_ = nil
	self.btn_ = nil
	self.sourceText_ = nil
	self.sourceContent_ = nil

	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil

	PopSourceUnlockItemView.super.Dispose(self)
end

function PopSourceUnlockItemView:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.callback_ ~= nil then
			self.callback_()
		end

		JumpTools.JumpToPage2(self.data_)
	end)
end

function PopSourceUnlockItemView:RemoveListeners()
	self.btn_.onClick:RemoveAllListeners()
end

function PopSourceUnlockItemView:SetJumpCallback(arg_7_1)
	self.callback_ = arg_7_1
end

function PopSourceUnlockItemView:RefreshUI()
	self.sourceContent_.text, self.sourceText_.text = JumpTools.GetName(self.data_)

	local var_8_0 = SystemLinkCfg[self.data_[1]].activity_id

	if type(SystemLinkCfg[self.data_[1]].paramName) == "table" then
		local var_8_1 = table.keyof(SystemLinkCfg[self.data_[1]].paramName, "activityId") or table.keyof(SystemLinkCfg[self.data_[1]].paramName, "activityID")

		if var_8_1 then
			var_8_0 = self.data_[var_8_1 + 1]
		end
	end

	if var_8_0 and var_8_0 ~= 0 then
		local var_8_2, var_8_3, var_8_4 = JumpTools.GetActivityTime(var_8_0)

		self.startTime_ = var_8_2
		self.stopTime_ = var_8_3

		if var_8_3 > manager.time:GetServerTime() then
			self:AddTimer()
		end
	end

	self:RefreshLock()
end

function PopSourceUnlockItemView:RefreshLock()
	if JumpTools.GetLinkIsLocked(self.data_) then
		self.controller_:SetSelectedState("true")
	else
		self.controller_:SetSelectedState("false")
	end
end

function PopSourceUnlockItemView:AddTimer()
	self:StopTimer()

	self.timer_ = Timer.New(function()
		self:RefreshLock()

		if manager.time:GetServerTime() > self.stopTime_ then
			self:StopTimer()
		end
	end, 1, -1)

	self.timer_:Start()
end

function PopSourceUnlockItemView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return PopSourceUnlockItemView
