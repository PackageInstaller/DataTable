local PopsoureceItem = class("PopsoureceItem", ReduxView)

function PopsoureceItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function PopsoureceItem:Init()
	self:InitUI()
end

function PopsoureceItem:InitUI()
	self:BindCfgUI()
	self:AddListeners()

	self.itemStateControll = self.accessbtnControllerexcollection_:GetController("btnState")
end

function PopsoureceItem:Dispose()
	PopsoureceItem.super.Dispose(self)
	self:StopTimer()
end

function PopsoureceItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if self.state == 3 then
			if self.callback_ ~= nil then
				self.callback_()
			end

			JumpTools.JumpToPage2(self.data_)
		end
	end)
end

function PopsoureceItem:RemoveListeners()
	self.button_.onClick:RemoveAllListeners()
end

function PopsoureceItem:SetJumpCallback(arg_8_1)
	self.callback_ = arg_8_1
end

function PopsoureceItem:RefreshUI(arg_9_1, arg_9_2)
	self.data_ = arg_9_2

	if arg_9_2[1] == 0 then
		self.state = 1
		self.nameText_.text, self.frontText_.text = GetI18NText(self.data_[3]), GetI18NText(self.data_[2])

		self.itemStateControll:SetSelectedState("display")
	elseif SystemLinkCfg[arg_9_2[1]].text_invalid ~= 0 then
		self.state = 2
		self.nameText_.text, self.frontText_.text = JumpTools.GetName(self.data_)

		self.itemStateControll:SetSelectedState("display")
	else
		self.state = 3
		self.nameText_.text, self.frontText_.text = JumpTools.GetName(self.data_)

		local var_9_0 = SystemLinkCfg[self.data_[1]].activity_id

		if type(SystemLinkCfg[self.data_[1]].paramName) == "table" then
			local var_9_1 = table.keyof(SystemLinkCfg[self.data_[1]].paramName, "activityId") or table.keyof(SystemLinkCfg[self.data_[1]].paramName, "activityID")

			if var_9_1 then
				var_9_0 = self.data_[var_9_1 + 1]
			end
		end

		if var_9_0 and var_9_0 ~= 0 then
			local var_9_2, var_9_3, var_9_4 = JumpTools.GetActivityTime(var_9_0)

			self.startTime_ = var_9_2
			self.stopTime_ = var_9_3

			if var_9_3 > manager.time:GetServerTime() then
				self:AddTimer()
			end
		end

		self:RefreshLock()
	end
end

function PopsoureceItem:RefreshLock()
	if JumpTools.GetLinkIsLocked(self.data_) then
		self.itemStateControll:SetSelectedState("locked")
	else
		self.itemStateControll:SetSelectedState("unlocked")
	end
end

function PopsoureceItem:AddTimer()
	self:StopTimer()

	self.timer_ = not self.timer_ and Timer.New(function()
		self:RefreshLock()

		if manager.time:GetServerTime() > self.stopTime_ then
			self:StopTimer()
		end
	end, 1, -1)

	self.timer_:Start()
end

function PopsoureceItem:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return PopsoureceItem
