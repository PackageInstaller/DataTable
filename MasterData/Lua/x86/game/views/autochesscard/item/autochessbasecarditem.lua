local AutoChessBaseCardItem = class("AutoChessBaseCardItem", ReduxView)

function AutoChessBaseCardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.cardID_ = 0

	self:Init()
end

function AutoChessBaseCardItem:Init()
	self:BindCfgUI()
	self:InitUI()
	self:AddListeners()
end

function AutoChessBaseCardItem:InitUI()
	if self.controller_ then
		self.positionController_ = self.controller_:GetController("position")
	end
end

function AutoChessBaseCardItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickHandler_ then
			self.clickHandler_()
		end
	end)
end

function AutoChessBaseCardItem:SetData(arg_6_1, arg_6_2)
	self.cardID_ = arg_6_1

	self:RefreshUI()

	if not arg_6_2 then
		self:SetImg()
	end
end

function AutoChessBaseCardItem:SetClickHandler(arg_7_1)
	self.clickHandler_ = arg_7_1
end

function AutoChessBaseCardItem:RefreshUI()
	local var_8_1 = string.split(AutoChessCardTools.GetCardName(self.cardID_), "·")

	self.txtName_.text = var_8_1[2] or var_8_1[1]

	if var_8_1[2] then
		SetActive(self.txtNick_.gameObject, true)

		self.txtNick_.text = var_8_1[1]
	else
		SetActive(self.txtNick_.gameObject, false)
	end
end

function AutoChessBaseCardItem:SetImg()
	self.img_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_AutoChess_Chess/RoleBattle/" .. AutoChessCardCfg[self.cardID_].pic)
end

function AutoChessBaseCardItem:SetPositionState(arg_10_1)
	if self.positionController_ then
		self.positionController_:SetSelectedState(arg_10_1)
	end
end

function AutoChessBaseCardItem:SetActive(arg_11_1)
	SetActive(self.gameObject_, arg_11_1)
end

function AutoChessBaseCardItem:Dispose()
	AutoChessBaseCardItem.super.Dispose(self)
end

return AutoChessBaseCardItem
