local CaptureMainTaskModule = class("CaptureMainTaskModule", ReduxView)

function CaptureMainTaskModule:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function CaptureMainTaskModule:Init()
	self:InitUI()
end

function CaptureMainTaskModule:InitUI()
	self:BindCfgUI()

	self.controller_ = self.taskController_:GetController("default0")
	self.isComplete = nil
	self.isHide = false
end

function CaptureMainTaskModule:RenderItem(arg_4_1)
	if not arg_4_1 then
		self:Hide(true)

		return
	end

	self:Hide(false)

	self.taskTxt_.text = CaptureGameHelper:GetConditionByTask(arg_4_1).description

	local var_4_0 = CaptureGameMgr:GetTaskMgr():CheckTaskCompelete(arg_4_1)

	if self.isComplete ~= nil and not self.isHide and not self.isComplete and var_4_0 then
		manager.audio:PlayEffect("ui_system", "ui_tips01")
	end

	self.isComplete = var_4_0 or false

	self.controller_:SetSelectedState(var_4_0 and "yes" or "no")
end

function CaptureMainTaskModule:HideLine()
	SetActive(self.lineObj_, false)
end

function CaptureMainTaskModule:Hide(arg_6_1)
	if arg_6_1 ~= self.isHide then
		SetActive(self.gameObject_, not arg_6_1)
	end
end

function CaptureMainTaskModule:Dispose()
	self.controller_ = nil

	CaptureMainTaskModule.super.Dispose(self)
end

return CaptureMainTaskModule
