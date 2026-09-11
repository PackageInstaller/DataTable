local ChessBoardShopItem = class("ChessBoardShopItem", ReduxView)
local var_0_1 = "D46068"
local var_0_2 = {
	selectState = {
		off = "off",
		name = "select",
		on = "on"
	}
}

function ChessBoardShopItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ChessBoardShopItem:Init()
	self:InitUI()

	self.controller_ = self.controllerexcollection_:GetController(var_0_2.selectState.name)
end

function ChessBoardShopItem:InitUI()
	self:BindCfgUI()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickHandle_ then
			self.clickHandle_(self.propID_)
		end
	end)
end

function ChessBoardShopItem:Refresh(arg_5_1)
	self.propID_ = arg_5_1
	self.nameText_.text = ChessBoardPropCfg[arg_5_1].name
	self.iconImg_.sprite = ChessBoardTools.GetPropImage(ChessBoardPropCfg[arg_5_1].icon)
	self.priceText_.text = ChessBoardPropCfg[self.propID_].cost > manager.ChessBoardManager:GetHeroAttribute("CHESSBOARD_ATTRIBUTE_ID_GOLD") and "<color=#" .. var_0_1 .. ">" .. ChessBoardPropCfg[arg_5_1].cost .. "</color>" or ChessBoardPropCfg[arg_5_1].cost
end

function ChessBoardShopItem:RefreshSelect(arg_6_1)
	self.controller_:SetSelectedState((self.propID_ == arg_6_1 or nil) and (var_0_2.selectState.on or var_0_2.selectState.off))
end

function ChessBoardShopItem:SetClickHandle(arg_7_1)
	self.clickHandle_ = arg_7_1
end

function ChessBoardShopItem:Dispose()
	ChessBoardShopItem.super.Dispose(self)
end

return ChessBoardShopItem
