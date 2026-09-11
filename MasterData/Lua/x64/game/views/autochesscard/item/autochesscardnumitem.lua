local AutoChessCardNumItem = class("AutoChessCardNumItem", ReduxView)

function AutoChessCardNumItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.cardID_ = 0

	self:Init()
end

function AutoChessCardNumItem:Init()
	self:BindCfgUI()
	self:InitUI()
	self:AddListeners()
end

function AutoChessCardNumItem:InitUI()
	self.selectHandler_ = nil
	self.isSelect_ = false
	self.selectController_ = self.controller_:GetController("select")
	self.ownNumController_ = self.controller_:GetController("ownNum")
	self.cardItem_ = AutoChessCardItem.New(self.cardGo_)
end

function AutoChessCardNumItem:AddListeners()
	return
end

function AutoChessCardNumItem:SetData(arg_5_1, arg_5_2, arg_5_3)
	self.cardID_ = arg_5_1
	self.isSelect_ = arg_5_2

	self.selectController_:SetSelectedState(tostring(self.isSelect_))
	self.cardItem_:SetData(arg_5_1, arg_5_3)
	self.cardItem_:SetClickHandler(handler(self, self.OnClick))
	self:RefreshUI()
end

function AutoChessCardNumItem:RefreshUI()
	local var_6_0 = AutoChessCardData:GetCardNum(self.cardID_) - 1
	local var_6_1 = AutoChessCardData:GetDesireInfo()

	if var_6_1 and table.indexof(var_6_1.CardList, self.cardID_) ~= false then
		var_6_0 = var_6_0 + 1
	end

	self.txtNum_.text = self.isSelect_ and var_6_0 - 1 or var_6_0
end

function AutoChessCardNumItem:SetSelectHandler(arg_7_1)
	self.selectHandler_ = arg_7_1
end

function AutoChessCardNumItem:SetOwnNumState(arg_8_1)
	self.ownNumController_:SetSelectedState(arg_8_1)
end

function AutoChessCardNumItem:OnClick()
	self.isSelect_ = not self.isSelect_

	self.selectController_:SetSelectedState(tostring(self.isSelect_))

	if self.selectHandler_ then
		self.selectHandler_(self.isSelect_, self.cardID_)
	end
end

function AutoChessCardNumItem:Dispose()
	self.cardItem_:Dispose()
	AutoChessCardNumItem.super.Dispose(self)
end

return AutoChessCardNumItem
