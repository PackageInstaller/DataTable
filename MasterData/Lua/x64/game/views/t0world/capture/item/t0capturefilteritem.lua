local T0CaptureFilterItem = class("T0CaptureFilterItem", ReduxView)

function T0CaptureFilterItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function T0CaptureFilterItem:Init()
	self:InitUI()
end

function T0CaptureFilterItem:InitUI()
	self:BindCfgUI()
	self:AddListener()

	self.controller = self.controllerEx_:GetController("state")
end

function T0CaptureFilterItem:AddListener()
	self:AddBtnListener(self.button_, nil, function()
		self:OnPoseItemClick()
	end)
end

function T0CaptureFilterItem:Render(arg_6_1)
	self.switchID = arg_6_1
	self.name_.text = GetI18NText(T0WorldCaptureSwitchCfg[arg_6_1].title)

	if T0WorldMgr:GetUseSettingByType(T0WorldCaptureSwitchCfg[arg_6_1].switchType) == self.switchID then
		self.controller:SetSelectedState("select")
	else
		self.controller:SetSelectedState("false")
	end
end

function T0CaptureFilterItem:OnPoseItemClick()
	if T0WorldMgr:GetUseSettingByType(T0WorldCaptureSwitchCfg[self.switchID].switchType) == self.switchID then
		return
	end

	T0WorldMgr:SetCaptureSwitch(self.switchID)
end

function T0CaptureFilterItem:Dispose()
	T0CaptureFilterItem.super.Dispose(self)
end

return T0CaptureFilterItem
