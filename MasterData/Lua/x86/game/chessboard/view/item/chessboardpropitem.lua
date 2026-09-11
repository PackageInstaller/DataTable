local ChessBoardPropItem = class("ChessBoardPropItem", ReduxView)
local var_0_1 = {
	showState = {
		selected = "selected",
		name = "state",
		grey = "grey",
		blank = "blank",
		normal = "normal"
	}
}

function ChessBoardPropItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.index = arg_1_2

	self:Init()
end

function ChessBoardPropItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function ChessBoardPropItem:InitUI()
	self:BindCfgUI()

	self.interactable_ = true
	self.controller_ = self.controllerexcollection_:GetController(var_0_1.showState.name)
end

function ChessBoardPropItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		self:OnClick()
	end)
end

function ChessBoardPropItem:OnClick()
	if self.interactable_ == false then
		return
	end

	if self.clickHandle_ then
		self.clickHandle_(self.propID, self.index)
	end

	if self.selectHandle_ then
		self.selectHandle_(self.index)
	end
end

function ChessBoardPropItem:Refresh(arg_7_1)
	self.propID = arg_7_1
	self.interactable_ = true

	if arg_7_1 then
		self.iconImg_.sprite = ChessBoardTools.GetPropImage(ChessBoardPropCfg[arg_7_1].icon)

		self:ChangeState(var_0_1.showState.normal)
	else
		self:ChangeState(var_0_1.showState.blank)
	end
end

function ChessBoardPropItem:ShowGetEffect()
	self.animator_:Play("ItemGet", 0)
end

function ChessBoardPropItem:SetSelectState(arg_9_1)
	if self.propID then
		self:ChangeState((arg_9_1 == self.index or nil) and (var_0_1.showState.selected or var_0_1.showState.normal))
	end
end

function ChessBoardPropItem:ChangeState(arg_10_1)
	self.controller_:SetSelectedState(arg_10_1)
end

function ChessBoardPropItem:SetClickHandle(arg_11_1)
	self.clickHandle_ = arg_11_1
end

function ChessBoardPropItem:SetSelectHandle(arg_12_1)
	self.selectHandle_ = arg_12_1
end

function ChessBoardPropItem:SetUnInteractable()
	if self.propID then
		self.controller_:SetSelectedState("grey")
	else
		self:ChangeState(var_0_1.showState.blank)
	end
end

function ChessBoardPropItem:StartArenaChance()
	if self.propID then
		if table.indexof(ChessBoardTools.GetChessBoardGameSetting("chessboard_dice_type_prop"), self.propID) then
			self:ChangeState(var_0_1.showState.normal)

			return
		else
			self.controller_:SetSelectedState("grey")
		end
	else
		self:ChangeState(var_0_1.showState.blank)
	end
end

function ChessBoardPropItem:GetPropID()
	return self.propID
end

function ChessBoardPropItem:Dispose()
	self.super.Dispose(self)
end

return ChessBoardPropItem
