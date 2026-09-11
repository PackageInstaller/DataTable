local StoryForceSkipView = class("StoryForceSkipView", ReduxView)

function StoryForceSkipView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function StoryForceSkipView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function StoryForceSkipView:InitUI()
	self:BindCfgUI()
end

function StoryForceSkipView:AddUIListeners()
	self:AddBtnListener(self.maskBtn_, nil, function()
		if self.handler_ then
			self.handler_()

			self.handler_ = nil
		end
	end)
end

function StoryForceSkipView:SetCallback(arg_6_1)
	self.handler_ = arg_6_1
end

function StoryForceSkipView:SetContentTitle(arg_7_1, arg_7_2)
	self.content_ = arg_7_2
	self.title_ = arg_7_1

	self:OnEnter()
end

function StoryForceSkipView:OnEnter()
	self.titleText_.text = GetI18NText(self.title_) or ""
	self.contentText_.text = self.content_ or ""
end

function StoryForceSkipView:Dispose()
	Object.Destroy(self.gameObject_)
	StoryForceSkipView.super.Dispose(self)
end

return StoryForceSkipView
