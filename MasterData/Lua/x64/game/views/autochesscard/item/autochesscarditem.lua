local AutoChessCardItem = class("AutoChessCardItem", ReduxView)

function AutoChessCardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.cardID_ = 0

	self:Init()
end

function AutoChessCardItem:Init()
	self:BindCfgUI()
	self:InitUI()
	self:AddListeners()
end

function AutoChessCardItem:InitUI()
	self.switchController_ = self.controller_:GetController("switch")
	self.collapseController_ = self.controller_:GetController("collapse")
	self.newTagController_ = self.controller_:GetController("new")
	self.greyController_ = self.controller_:GetController("grey")
	self.cardURItem_ = AutoChessBaseURCardItem.New(self.cardURGo_)
	self.cardSRItem_ = AutoChessBaseCardItem.New(self.cardSRGo_)
	self.cardRItem_ = AutoChessBaseCardItem.New(self.cardRGo_)
end

function AutoChessCardItem:AddListeners()
	return
end

function AutoChessCardItem:SetData(arg_5_1, arg_5_2)
	self.cardID_ = arg_5_1

	self:RefreshUI(arg_5_2)
end

function AutoChessCardItem:RefreshUI(arg_6_1)
	if not AutoChessCardCfg[self.cardID_] then
		return
	end

	if self.switchController_ then
		self.switchController_:SetSelectedIndex(AutoChessCardCfg[self.cardID_].type - 1)
	end

	if AutoChessCardCfg[self.cardID_].type == AutoChessCardConst.CARD_TYPE.UR then
		self.cardURItem_:SetItem(self.cardID_, arg_6_1)
		self.cardURItem_:SetData(self.cardID_)
	elseif AutoChessCardCfg[self.cardID_].type == AutoChessCardConst.CARD_TYPE.SR then
		self.cardSRItem_:SetData(self.cardID_)
	else
		self.cardRItem_:SetData(self.cardID_)
	end
end

function AutoChessCardItem:SetActive(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
end

function AutoChessCardItem:SetClickHandler(arg_8_1)
	if not AutoChessCardCfg[self.cardID_] then
		return
	end

	if AutoChessCardCfg[self.cardID_].type == AutoChessCardConst.CARD_TYPE.UR then
		self.cardURItem_:SetClickHandler(arg_8_1)
	elseif AutoChessCardCfg[self.cardID_].type == AutoChessCardConst.CARD_TYPE.SR then
		self.cardSRItem_:SetClickHandler(arg_8_1)
	else
		self.cardRItem_:SetClickHandler(arg_8_1)
	end
end

function AutoChessCardItem:SetPositionState(arg_9_1)
	if arg_9_1 then
		if AutoChessCardCfg[self.cardID_].type == AutoChessCardConst.CARD_TYPE.UR then
			self.cardURItem_:SetPositionState("on")
		elseif AutoChessCardCfg[self.cardID_].type == AutoChessCardConst.CARD_TYPE.SR then
			self.cardSRItem_:SetPositionState("on")
		else
			self.cardRItem_:SetPositionState("on")
		end
	elseif AutoChessCardCfg[self.cardID_].type == AutoChessCardConst.CARD_TYPE.UR then
		self.cardURItem_:SetPositionState("off")
	elseif AutoChessCardCfg[self.cardID_].type == AutoChessCardConst.CARD_TYPE.SR then
		self.cardSRItem_:SetPositionState("off")
	else
		self.cardRItem_:SetPositionState("off")
	end
end

function AutoChessCardItem:SetCollapseState(arg_10_1, arg_10_2)
	if arg_10_1 then
		self.collapseController_:SetSelectedState("on")

		self.txtNum_.text = "×" .. arg_10_2
	else
		self.collapseController_:SetSelectedState("off")
	end
end

function AutoChessCardItem:SetNewTagState(arg_11_1)
	self.newTagController_:SetSelectedState(arg_11_1 and "on" or "off")
end

function AutoChessCardItem:SetGreyState(arg_12_1)
	self.greyController_:SetSelectedState(arg_12_1 and "on" or "off")
end

function AutoChessCardItem:Dispose()
	self.cardURItem_:Dispose()
	self.cardSRItem_:Dispose()
	self.cardRItem_:Dispose()
	AutoChessCardItem.super.Dispose(self)
end

return AutoChessCardItem
