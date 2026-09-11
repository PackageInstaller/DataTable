local LetterPopView = class("LetterPopView", ReduxView)

function LetterPopView:UIName()
	return "Widget/System/Mailbox/LetterPopUI"
end

function LetterPopView:UIParent()
	return manager.ui.uiPop.transform
end

function LetterPopView:OnCtor()
	return
end

function LetterPopView:Init()
	self:InitUI()
	self:AddListeners()
end

function LetterPopView:InitUI()
	self:BindCfgUI()
end

function LetterPopView:AddListeners()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function LetterPopView:OnEnter()
	self.letterId_ = self.params_.letterId

	self:RefreshView()
end

function LetterPopView:RefreshView()
	self.titleText_.text = GetI18NText(MailSpecialLetterCfg[self.letterId_].letter_title)
	self.roleImage_.sprite = ItemTools.getItemSprite(MailSpecialLetterCfg[self.letterId_].letter_belongs)
	self.contentText_.text = GetI18NText(MailSpecialLetterCfg[self.letterId_].letter_desc)
	self.nameText_.text = GetI18NText(MailSpecialLetterCfg[self.letterId_].letter_sender)
end

function LetterPopView:Dispose()
	LetterPopView.super.Dispose(self)
end

return LetterPopView
