local CaptureResultTaskModule = class("CaptureResultTaskModule", ReduxView)

function CaptureResultTaskModule:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function CaptureResultTaskModule:Init()
	self:InitUI()
end

function CaptureResultTaskModule:InitUI()
	self:BindCfgUI()

	self.controller_ = self.completeController_:GetController("default0")
	self.isHide = false
end

function CaptureResultTaskModule:RenderItem(arg_4_1, arg_4_2)
	if not arg_4_1 then
		self:Hide(true)

		return
	end

	self:Hide(false)

	self.taskText_.text = CaptureGameHelper:GetConditionByTask(arg_4_1).description

	self.controller_:SetSelectedState(arg_4_2 and "yes" or "no")
end

function CaptureResultTaskModule:HideLine()
	SetActive(self.lineObj_, false)
end

function CaptureResultTaskModule:Hide(arg_6_1)
	if arg_6_1 ~= self.isHide then
		SetActive(self.gameObject_, not arg_6_1)
	end
end

function CaptureResultTaskModule:Dispose()
	self.controller_ = nil

	CaptureResultTaskModule.super.Dispose(self)
end

return CaptureResultTaskModule
