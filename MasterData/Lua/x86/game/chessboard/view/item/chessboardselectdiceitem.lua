local ChessBoardSelectDiceItem = class("ChessBoardSelectDiceItem", ReduxView)
local var_0_1 = {
	state = {
		on = "on",
		name = "status",
		select = "select",
		gray = "gray"
	}
}

function ChessBoardSelectDiceItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.index = arg_1_2

	self:Init()
end

function ChessBoardSelectDiceItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function ChessBoardSelectDiceItem:InitUI()
	self:BindCfgUI()

	self.controller_ = self.controllerexcollection_:GetController(var_0_1.state.name)

	self:ChangeState(var_0_1.state.on)
end

function ChessBoardSelectDiceItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_DICE_RANGE") >= self.index then
			if self.clickHandle_ and self.index then
				self.clickHandle_(self.index)
			end
		else
			ShowTips("CHESSBOARD_CURSE_DICE")
		end
	end)
end

function ChessBoardSelectDiceItem:RefreshUi()
	self:UpdateDefault()
end

function ChessBoardSelectDiceItem:RefreshSelect(arg_7_1)
	if self.index == arg_7_1 then
		self:ChangeState(var_0_1.state.select)
	else
		self:UpdateDefault()
	end
end

function ChessBoardSelectDiceItem:UpdateDefault()
	if manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_DICE_RANGE") >= self.index then
		self:ChangeState(var_0_1.state.on)
	else
		self:ChangeState(var_0_1.state.gray)
	end
end

function ChessBoardSelectDiceItem:ChangeState(arg_9_1)
	self.controller_:SetSelectedState(arg_9_1)
end

function ChessBoardSelectDiceItem:SetClickHandle(arg_10_1)
	self.clickHandle_ = arg_10_1
end

function ChessBoardSelectDiceItem:Dispose()
	self.super.Dispose(self)
end

return ChessBoardSelectDiceItem
