local CaptureSectionModule = class("CaptureSectionModule", ReduxView)

function CaptureSectionModule:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CaptureSectionModule:Init()
	self:BindCfgUI()
end

function CaptureSectionModule:RenderView(arg_3_1, arg_3_2, arg_3_3)
	self.taskText_.text = ActivitySwimSkinSubActivityTaskCfg[arg_3_1].description

	SetActive(self.successObj_, CaptureGameData:GetSectionTaskCompleteMap(arg_3_2, arg_3_3)[arg_3_1] or false)
end

function CaptureSectionModule:Dispose()
	CaptureSectionModule.super.Dispose(self)
end

return CaptureSectionModule
