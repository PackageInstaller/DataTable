local UITimeMgr = class("UITimeMgr")

function UITimeMgr:Ctor()
	return
end

function UITimeMgr:StartUITimer()
	self.uiTimeRecord_ = {}
	self.startEnterTime_ = {}
	self.timer_ = Timer.New(handler(self, self.SendMessage), 60, -1)

	self.timer_:Start()
end

function UITimeMgr:OnEnterRoute(arg_3_1, arg_3_2)
	if UITimeConst[arg_3_1] or arg_3_2 then
		local var_3_0 = arg_3_2 and arg_3_1 or UITimeConst[arg_3_1]

		if self.startEnterTime_[arg_3_2 and arg_3_1 or UITimeConst[arg_3_1]] then
			self:OnExitRoute(arg_3_1, arg_3_2)
		end

		self.startEnterTime_[var_3_0] = manager.time:GetServerTime()
	end
end

function UITimeMgr:OnEnterStory(arg_4_1)
	self.startEnterTime_["story_" .. arg_4_1] = manager.time:GetServerTime()
end

function UITimeMgr:OnExitRoute(arg_5_1, arg_5_2)
	self:ExitRecord(arg_5_2 and arg_5_1 or UITimeConst[arg_5_1])
end

function UITimeMgr:OnExitStory(arg_6_1)
	self:ExitRecord("story_" .. arg_6_1)
end

function UITimeMgr:ExitRecord(arg_7_1)
	if self.startEnterTime_[arg_7_1] then
		local var_7_0 = manager.time:GetServerTime() - self.startEnterTime_[arg_7_1]

		var_7_0 = var_7_0 > 0 and var_7_0 or 0
		self.startEnterTime_[arg_7_1] = nil

		if self.uiTimeRecord_[arg_7_1] then
			self.uiTimeRecord_[arg_7_1].time = self.uiTimeRecord_[arg_7_1].time + var_7_0
		else
			self.uiTimeRecord_[arg_7_1] = {
				id = tostring(arg_7_1),
				time = var_7_0
			}
		end
	end
end

function UITimeMgr:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function UITimeMgr:SendMessage()
	if self.uiTimeRecord_ and next(self.uiTimeRecord_) then
		manager.net:Push(38016, {
			log_list = self.uiTimeRecord_
		})
	end

	self.uiTimeRecord_ = {}
end

function UITimeMgr:OnLogout()
	self:SendMessage()
	self:StopTimer()

	self.uiTimeRecord_ = {}
	self.startEnterTime_ = {}
end

function UITimeMgr:Dispose()
	self:OnLogout()
end

return UITimeMgr
