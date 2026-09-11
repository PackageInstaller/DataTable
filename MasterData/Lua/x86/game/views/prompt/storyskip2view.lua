local StorySkip2View = class("StorySkip2View", ReduxView)

function StorySkip2View:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function StorySkip2View:Init()
	self:InitUI()
	self:AddUIListeners()
end

function StorySkip2View:InitUI()
	self:BindCfgUI()
end

function StorySkip2View:AddUIListeners()
	self:AddBtnListener(self.okBtn_, nil, function()
		manager.ui:SetUISeparateRender(false)

		if self.handler_ then
			self.handler_()

			self.handler_ = nil
		end
	end)
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		self:CancelFun()
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		self:CancelFun()
	end)
end

function StorySkip2View:CancelFun()
	SetActive(self.gameObject_, false)
	manager.ui:SetUISeparateRender(false)

	if self.handler_ then
		self.handler_(true)

		self.handler_ = nil
	end
end

function StorySkip2View:SetCallback(arg_9_1)
	self.handler_ = arg_9_1
end

function StorySkip2View:SetContentTitle(arg_10_1, arg_10_2)
	self.content_ = arg_10_2
	self.title_ = arg_10_1

	self:OnEnter()
end

function StorySkip2View:OnEnter()
	self.titleText_.text = GetI18NText(self.title_) or ""
	self.contentText_.text = self.content_ or ""
end

function StorySkip2View:Dispose()
	Object.Destroy(self.gameObject_)
	StorySkip2View.super.Dispose(self)
end

return StorySkip2View
