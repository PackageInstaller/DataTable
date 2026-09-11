local NewWarChessDiceFrameItem = class("NewWarChessDiceFrameItem", ReduxView)
local var_0_1 = {
	EQUAL = 3,
	BETWEEN = 4,
	EVEN = 6,
	ODD = 5,
	GREATER = 1,
	SMALLER = 2
}

function NewWarChessDiceFrameItem:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.clickHandler_ = arg_1_2
	self.index_ = arg_1_3
	self.frameIndex_ = 0
	self.diceIndex_ = 0

	self:ResetData()
	self:Init()
end

function NewWarChessDiceFrameItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function NewWarChessDiceFrameItem:InitUI()
	self:BindCfgUI()

	self.stateController_ = ControllerUtil.GetController(self.transform_, "name")
	self.pointController_ = ControllerUtil.GetController(self.transform_, "points")
	self.symbolController_ = ControllerUtil.GetController(self.transform_, "symbol")
	self.combolController_ = ControllerUtil.GetController(self.transform_, "combo")
end

function NewWarChessDiceFrameItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickHandler_ then
			self.clickHandler_(self.index_)
		else
			print("骰子框self.clickHandler_为空！！！！")
		end
	end)
end

function NewWarChessDiceFrameItem:SetData(arg_6_1)
	self.frameIndex_ = arg_6_1

	self:ResetData()

	if self.frameIndex_ == 0 then
		return
	else
		self.frameCfg_ = NewWarChessDiceCfg[self.frameIndex_]
		self.type_ = self.frameCfg_.type
		self.inputRange_ = self.frameCfg_.input_range
		self.limitType_ = self.frameCfg_.limit_type
	end

	self:RefreshUI()
end

function NewWarChessDiceFrameItem:SetInputDice(arg_7_1)
	self.diceData_ = NewWarChessData.GetDiceContinuousList()[arg_7_1]
	self.diceIndex_ = arg_7_1
	self.dicePoint_ = self.diceData_[1]

	self:RefreshUI()
end

function NewWarChessDiceFrameItem:ResetData()
	self.limitType_ = 0
	self.type_ = 0
	self.frameCfg_ = nil
	self.inputRange_ = {}

	self:ResetDiceData()
end

function NewWarChessDiceFrameItem:ResetDiceData()
	self.diceIndex_ = 0
	self.diceData_ = nil
	self.dicePoint_ = 0
end

function NewWarChessDiceFrameItem:CheckInputLimit(arg_10_1)
	local var_10_0 = NewWarChessData.GetDiceContinuousList()[arg_10_1][1]

	if self.dicePoint_ ~= 0 then
		return false
	end

	if self.limitType_ <= 4 then
		if var_10_0 < self.inputRange_[1] or var_10_0 > self.inputRange_[2] then
			return false
		end
	elseif self.limitType_ == var_0_1.ODD then
		return var_10_0 % 2 == 1
	elseif self.limitType_ == var_0_1.EVEN then
		return var_10_0 % 2 == 0
	end

	return true
end

function NewWarChessDiceFrameItem:RefreshUI()
	self.stateController_:SetSelectedIndex(self.dicePoint_)

	if self.dicePoint_ ~= 0 then
		self.combolController_:SetSelectedState("empty")
		self.symbolController_:SetSelectedState("empty")
		self.pointController_:SetSelectedIndex(0)

		return
	end

	if self.limitType_ <= 4 then
		self.combolController_:SetSelectedState("empty")
	else
		self.symbolController_:SetSelectedState("empty")
	end

	if self.limitType_ == var_0_1.GREATER then
		self.symbolController_:SetSelectedState("greater")
		self.pointController_:SetSelectedIndex(self.inputRange_[1])
	elseif self.limitType_ == var_0_1.SMALLER then
		self.symbolController_:SetSelectedState("smaller")
		self.pointController_:SetSelectedIndex(self.inputRange_[2])
	elseif self.limitType_ == var_0_1.EQUAL then
		self.symbolController_:SetSelectedState("empty")
		self.pointController_:SetSelectedIndex(self.inputRange_[1])
	elseif self.limitType_ == var_0_1.BETWEEN then
		self.symbolController_:SetSelectedState("empty")
		self.pointController_:SetSelectedIndex(0)
	elseif self.limitType_ == var_0_1.ODD then
		self.combolController_:SetSelectedState("odd")
		self.pointController_:SetSelectedIndex(0)
	elseif self.limitType_ == var_0_1.EVEN then
		self.combolController_:SetSelectedState("even")
		self.pointController_:SetSelectedIndex(0)
	else
		self.symbolController_:SetSelectedState("empty")
		self.combolController_:SetSelectedState("empty")
		self.pointController_:SetSelectedIndex(0)
	end
end

function NewWarChessDiceFrameItem:Dispose()
	self.clickHandler_ = nil

	Object.Destroy(self.gameObject_)
	NewWarChessDiceFrameItem.super.Dispose(self)
end

return NewWarChessDiceFrameItem
