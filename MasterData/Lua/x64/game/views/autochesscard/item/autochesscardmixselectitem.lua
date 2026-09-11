local AutoChessCardMixSelectItem = class("AutoChessCardMixSelectItem", ReduxView)

function AutoChessCardMixSelectItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.cardID_ = 0

	self:Init()
end

function AutoChessCardMixSelectItem:Init()
	self:BindCfgUI()
	self:InitUI()
	self:AddListeners()
end

function AutoChessCardMixSelectItem:InitUI()
	self.selectHandler_ = nil
	self.isSelect_ = false
	self.selectController_ = self.controller_:GetController("select")
	self.cardItem_ = AutoChessCardItem.New(self.cardGo_)
end

function AutoChessCardMixSelectItem:AddListeners()
	return
end

function AutoChessCardMixSelectItem:SetData(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self.cardID_ = arg_5_1
	self.isSelect_ = arg_5_2
	self.index_ = arg_5_3

	self.selectController_:SetSelectedState(tostring(self.isSelect_))
	self.cardItem_:SetData(arg_5_1, arg_5_4)
	self.cardItem_:SetClickHandler(handler(self, self.OnClick))
end

function AutoChessCardMixSelectItem:SetSelectHandler(arg_6_1)
	self.selectHandler_ = arg_6_1
end

function AutoChessCardMixSelectItem:OnClick()
	self.isSelect_ = not self.isSelect_

	self.selectController_:SetSelectedState(tostring(self.isSelect_))

	if self.selectHandler_ then
		self.selectHandler_(self.isSelect_, self.cardID_, self.index_)
	end
end

function AutoChessCardMixSelectItem:Dispose()
	self.cardItem_:Dispose()
	AutoChessCardMixSelectItem.super.Dispose(self)
end

return AutoChessCardMixSelectItem
