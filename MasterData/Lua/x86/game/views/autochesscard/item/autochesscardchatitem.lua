local AutoChessCardChatItem = class("AutoChessCardChatItem", ReduxView)

function AutoChessCardChatItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.cardID_ = 0

	self:Init()
end

function AutoChessCardChatItem:Init()
	self:BindCfgUI()
	self:InitUI()
	self:AddListeners()
end

function AutoChessCardChatItem:InitUI()
	self.wishStateController_ = self.controller_:GetController("wishState")
	self.cardItem_ = AutoChessCardItem.New(self.cardGo_)
end

function AutoChessCardChatItem:AddListeners()
	return
end

function AutoChessCardChatItem:SetData(arg_5_1, arg_5_2)
	self.cardID_ = arg_5_1

	self.cardItem_:SetData(arg_5_1, arg_5_2)
	self:RefreshUI()
end

function AutoChessCardChatItem:RefreshUI()
	if self.cardID_ == 0 then
		self.wishStateController_:SetSelectedState("none")

		return
	end

	if self.cardID_ == AutoChessCardData:GetDesireInfo().CardID then
		self.wishStateController_:SetSelectedState("heart")
	elseif AutoChessCardData:GetCardNum(self.cardID_) > 0 then
		self.wishStateController_:SetSelectedState("none")
	else
		self.wishStateController_:SetSelectedState("add")
	end
end

function AutoChessCardChatItem:SetClickHandler(arg_7_1)
	self.cardItem_:SetClickHandler(arg_7_1)
end

function AutoChessCardChatItem:SetGreyState(arg_8_1)
	self.cardItem_:SetGreyState(arg_8_1)
end

function AutoChessCardChatItem:SetActive(arg_9_1)
	SetActive(self.gameObject_, arg_9_1)
end

function AutoChessCardChatItem:Dispose()
	self.cardItem_:Dispose()
	AutoChessCardChatItem.super.Dispose(self)
end

return AutoChessCardChatItem
