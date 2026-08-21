-- chunkname: @IQIGame\\UI\\Chapter\\MultipleParentView.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.__delegateOnSweepDupResultEvent()
		self:OnSweepDupResultEvent()
	end

	self:AddListeners()
end

function m:AddListeners()
	EventDispatcher.AddEventListener(EventID.SweepDupResultEvent, self.__delegateOnSweepDupResultEvent)
end

function m:RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.SweepDupResultEvent, self.__delegateOnSweepDupResultEvent)
end

function m:SetData(activityPod, isShowTime)
	self.activityCfg = CfgActivityTable[activityPod.cid]
	self.isShowTime = isShowTime
	self.activityPod = activityPod

	local dupDropPOD = activityPod.dupDropPOD

	if not dupDropPOD then
		self:Hide()

		return
	end

	UGUIUtil.SetText(self.CountText, self.activityCfg.ExtraParam[2] - dupDropPOD.dayNum .. "/" .. self.activityCfg.ExtraParam[2])

	if isShowTime then
		LuaUtility.SetGameObjectShow(self.RemaintimeParent, true)
		self:RefreshCountdown()
	else
		LuaUtility.SetGameObjectShow(self.RemaintimeParent, false)
	end
end

function m:RefreshCountdown()
	self:UpdateSurplusTime()

	if self.timer == nil then
		self.timer = Timer.New(function()
			self:UpdateSurplusTime()
		end, 1, -1)

		self.timer:Start()
	end
end

function m:UpdateSurplusTime()
	local surplusTime = cfgDateTimeToTimeStamp(self.activityCfg.OpenTime) + self.activityCfg.Duration[1] - PlayerModule.GetServerTime()

	UGUIUtil.SetText(self.TimeText, DateTimeFormat(surplusTime, self:GetTimeSurplusState(surplusTime)))
end

function m:GetTimeSurplusState(second)
	if second <= 3600 then
		return MazeApi:GetTimeFormat(1)
	elseif second <= 86400 then
		return MazeApi:GetTimeFormat(2)
	else
		return MazeApi:GetTimeFormat(3)
	end
end

function m:OnSweepDupResultEvent()
	if self.activityPod == nil then
		return
	end

	local tempAcitvityPod = ActivityModule.GetActivityPodByID(self.activityPod.cid)

	if tempAcitvityPod == nil then
		return
	end

	self:SetData(tempAcitvityPod, self.isShowTime)
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:StopTimer()
	if self.timer ~= nil then
		self.timer:Stop()
	end

	self.timer = nil
end

function m:Dispose()
	self:RemoveListeners()
	self:StopTimer()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
