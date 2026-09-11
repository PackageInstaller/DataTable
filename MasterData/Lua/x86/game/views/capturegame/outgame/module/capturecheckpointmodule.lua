local CaptureCheckPointModule = class("CaptureCheckPointModule", ReduxView)

function CaptureCheckPointModule:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function CaptureCheckPointModule:Init()
	self:InitUI()
end

function CaptureCheckPointModule:BuildContext()
	self.staticContext = {
		slotId = -1
	}
	self.runtimeCtx = {}
end

function CaptureCheckPointModule:InitUI()
	self:BindCfgUI()
	self:BuildContext()
	self:AddListener()

	self.controller = self.scheduleController_:GetController("default0")
end

function CaptureCheckPointModule:AddListener()
	self:AddBtnListener(self.captureBtn_, nil, function()
		self:OnSectionClick()
	end)
end

function CaptureCheckPointModule:OnSectionClick()
	if not ActivityData:GetActivityIsOpen(self.staticContext.sectionId) then
		ShowTips(GetTips("CAPTURE_GAME_TIME_UNREACHED"))

		return
	end

	if PlayerPrefs.GetInt("openAllCaptureGame") ~= 1 and not CaptureGameTools:CaptureGameCanOpen(self.staticContext.sectionId) then
		ShowTips(GetTips("CAPTURE_GAME_PRE_SECTION_UNREACHED"))

		do return end

		if self.staticContext.clickDispatch then
			self.staticContext.clickDispatch(self.staticContext.slotId)
		end
	end
end

function CaptureCheckPointModule:RegisterClickEvent(arg_8_1)
	self.staticContext.clickDispatch = arg_8_1
end

function CaptureCheckPointModule:RenderView(arg_9_1)
	self.runtimeCtx.gameData = arg_9_1.gameData
	self.staticContext.slotId = arg_9_1.id
	self.staticContext.sectionId = arg_9_1.gameData.sectionId
	self.regionTxt_.text = arg_9_1.gameData.title

	self:RenderLockStatus()

	self.transform_.localPosition = Vector3.New(arg_9_1.gameData.view_position[1], arg_9_1.gameData.view_position[2], 0)

	local var_9_0 = self:GetSectionCount()

	self.controller:SetSelectedState("state" .. self:GetSectionCompleteCount())

	for iter_9_0 = 1, 3 do
		SetActive(self[string.format("schedule%d_", iter_9_0)], iter_9_0 <= var_9_0)
	end

	self:UnbindRedPoint()
	self:BindRedPoint()
end

function CaptureCheckPointModule:RenderLockStatus()
	local var_10_0 = ActivityData:GetActivityIsOpen(self.staticContext.sectionId)
	local var_10_1 = var_10_0

	if PlayerPrefs.GetInt("openAllCaptureGame") ~= 1 then
		var_10_1 = var_10_1 and CaptureGameTools:CaptureGameCanOpen(self.staticContext.sectionId)
	end

	self.lockObj_:SetActive(not var_10_1)

	if var_10_1 then
		local var_10_2 = self:GetSectionCompleteCount() == self:GetSectionCount()

		self.compObj_:SetActive(var_10_2)
		self.procObj_:SetActive(not var_10_2)
	else
		self.compObj_:SetActive(false)
		self.procObj_:SetActive(false)
	end

	if not var_10_0 then
		self:AddTimer()
	elseif not var_10_1 then
		self.lockTxt_.text = GetTips("CAPTURE_GAME_PRE_SECTION_UNREACHED_SMALL")
	end
end

function CaptureCheckPointModule:GetSectionCompleteCount()
	local var_11_0 = 0
	local var_11_1 = self.runtimeCtx.gameData.sub_section_list or {}

	for iter_11_0 = 1, 3 do
		if var_11_1[iter_11_0] and CaptureGameData:CheckSectionTaskComplete(self.runtimeCtx.gameData.sectionId, var_11_1[iter_11_0]) then
			var_11_0 = var_11_0 + 1
		end
	end

	return var_11_0
end

function CaptureCheckPointModule:GetSectionCount()
	return #(self.runtimeCtx.gameData.sub_section_list or {})
end

function CaptureCheckPointModule:SetActive(arg_13_1)
	self.gameObject_:SetActive(arg_13_1)

	if not arg_13_1 then
		self:UnbindRedPoint()
		self:StopTimer()
	end
end

function CaptureCheckPointModule:ChangeParent(arg_14_1)
	self.transform_.parent = arg_14_1
end

function CaptureCheckPointModule:GetCameraPivot()
	return self.cameraPivot_
end

function CaptureCheckPointModule:GetSectionCfg()
	return self.runtimeCtx.gameData
end

function CaptureCheckPointModule:AddTimer()
	self:StopTimer()

	local var_17_0 = ActivityData:GetActivityData(self.staticContext.sectionId)

	if manager.time:GetServerTime() < var_17_0.startTime then
		self:RefreshTimeText(var_17_0.startTime)
	else
		self:RefreshTimeText(var_17_0.stopTime)
	end

	self.timer_ = Timer.New(function()
		local var_18_0 = ActivityData:GetActivityData(self.staticContext.sectionId)
		local var_18_1 = manager.time:GetServerTime()

		if var_18_1 < var_18_0.startTime then
			self:RefreshTimeText(var_18_0.startTime)
		else
			self:RenderLockStatus()
			self:StopTimer()
		end

		if var_18_1 >= var_18_0.stopTime then
			self:RenderLockStatus()
			self:StopTimer()
		end
	end, 1, -1)

	self.timer_:Start()
end

function CaptureCheckPointModule:RefreshTimeText(arg_19_1)
	self.lockTxt_.text = manager.time:GetLostTimeStrWith2Unit(arg_19_1)
end

function CaptureCheckPointModule:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function CaptureCheckPointModule:BindRedPoint()
	manager.redPoint:bindUIandKey(self.noticeContainer.transform, table.concat({
		RedPointConst.CAPTURE_GAME_UNLOCK_SECTION,
		"_",
		0,
		[3] = self.staticContext.sectionId
	}))
end

function CaptureCheckPointModule:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.noticeContainer.transform)
end

function CaptureCheckPointModule:Exit()
	self:StopTimer()
	self:UnbindRedPoint()
end

function CaptureCheckPointModule:Dispose()
	self:StopTimer()
	self:UnbindRedPoint()
	CaptureCheckPointModule.super.Dispose(self)
end

return CaptureCheckPointModule
