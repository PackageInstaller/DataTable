local StoryKipView = class("StoryKipView", ReduxView)

function StoryKipView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function StoryKipView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function StoryKipView:InitUI()
	self:BindCfgUI()

	self.textTyper_ = self.m_content.transform:GetComponent("TextTypeWrite")
	self.skipBtnCon_ = ControllerUtil.GetController(self.transform_, "skip")
end

function StoryKipView:AddUIListeners()
	self:AddBtnListener(self.m_sureBtn, nil, function()
		self:Back()

		if self.handler_ then
			self.handler_()

			self.handler_ = nil
		end
	end)
	self:AddBtnListener(self.m_cancelBtn, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.m_maskBtn, nil, function()
		if self.textTyper_:isTypeing() then
			self.textTyper_:ShowAllText()
		elseif self.handler_ then
			self.handler_()

			self.handler_ = nil
		end
	end)
end

function StoryKipView:SetCallback(arg_8_1)
	self.handler_ = arg_8_1
end

function StoryKipView:SetContentTitle(arg_9_1, arg_9_2)
	self.content_ = arg_9_2
	self.title_ = arg_9_1

	self:OnEnter()
end

function StoryKipView:OnEnter()
	self.skipBtnCon_:SetSelectedState(0)
	self.textTyper_:StartTyping(self.content_ or "", function()
		self.skipBtnCon_:SetSelectedState(1)
	end)
	self.textTyper_:ClearLinePrefixSymbol()

	self.m_title.text = GetI18NText(self.title_) or ""
end

function StoryKipView:Dispose()
	Object.Destroy(self.gameObject_)
	StoryKipView.super.Dispose(self)
end

return StoryKipView
