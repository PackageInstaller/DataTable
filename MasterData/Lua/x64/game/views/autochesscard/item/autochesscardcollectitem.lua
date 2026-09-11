local AutoChessCardCollectItem = class("AutoChessCardCollectItem", ReduxView)

function AutoChessCardCollectItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.cardID_ = 0

	self:Init()
end

function AutoChessCardCollectItem:Init()
	self:BindCfgUI()
	self:InitUI()
	self:AddListeners()
end

function AutoChessCardCollectItem:InitUI()
	self.greyController_ = self.controller_:GetController("grey")
	self.mixTagController_ = self.controller_:GetController("mixTag")
	self.cardItem_ = AutoChessCardItem.New(self.cardGo_)
end

function AutoChessCardCollectItem:AddListeners()
	return
end

function AutoChessCardCollectItem:SetData(arg_5_1, arg_5_2, arg_5_3)
	self.cardID_ = arg_5_1
	self.index_ = arg_5_2

	self.cardItem_:SetData(arg_5_1, arg_5_3)
	self.cardItem_:SetClickHandler(handler(self, self.OnClick))

	if AutoChessCardData:GetCardNum(arg_5_1) > 0 then
		self.greyController_:SetSelectedState("off")
	else
		self.greyController_:SetSelectedState("on")
	end

	self:RefershMixTag()
end

function AutoChessCardCollectItem:RefershMixTag()
	if AutoChessCardCfg[self.cardID_].type == AutoChessCardConst.CARD_TYPE.R then
		self.mixTagController_:SetSelectedState("off")

		return
	end

	if AutoChessCardTools.GetMixExpByCardType(self.cardID_) <= AutoChessCardTools.GetCardExp() and AutoChessCardData:GetCardNum(self.cardID_) < 1 then
		self.mixTagController_:SetSelectedState("on")
	else
		self.mixTagController_:SetSelectedState("off")
	end
end

function AutoChessCardCollectItem:SetSelectHandler(arg_7_1)
	self.selectHandler_ = arg_7_1
end

function AutoChessCardCollectItem:OnClick()
	if self.selectHandler_ then
		self.selectHandler_(self.cardID_, self.index_)
	end
end

function AutoChessCardCollectItem:Dispose()
	self.cardItem_:Dispose()
	AutoChessCardCollectItem.super.Dispose(self)
end

return AutoChessCardCollectItem
