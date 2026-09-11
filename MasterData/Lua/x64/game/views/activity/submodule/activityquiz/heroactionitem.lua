local HeroActionItem = class("HeroActionItem", ReduxView)

function HeroActionItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function HeroActionItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function HeroActionItem:InitUI()
	self:BindCfgUI()
end

function HeroActionItem:AddUIListeners()
	self:AddBtnListener(self.buttonItem_, nil, function()
		manager.notify:CallUpdateFunc(ACTIVITY_QUIZ_SEND_ACTION, self.act_)
	end)
end

function HeroActionItem:OnEnter()
	return
end

function HeroActionItem:Refresh(arg_7_1)
	self.act_ = arg_7_1
	self.imageIcon_.spriteSync = "TextureConfig/VersionUI/CORGUI_SandPlay_Com/SandPlay_Com_AnswerUI/" .. self.act_
end

function HeroActionItem:OnExit()
	self:RemoveAllEventListener()
end

function HeroActionItem:Dispose()
	self:RemoveAllListeners()
	self.super.Dispose(self)
end

return HeroActionItem
