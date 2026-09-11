local MoonCakeBagNormalItem = class("MoonCakeBagNormalItem", ReduxView)

function MoonCakeBagNormalItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:InitUI()
end

function MoonCakeBagNormalItem:InitUI()
	self:BindCfgUI()
	self:AddListeners()
end

function MoonCakeBagNormalItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickHandler_ then
			self.clickHandler_(self.info_, self.index_)
		end
	end)
end

function MoonCakeBagNormalItem:Dispose()
	self.clickHandler_ = nil

	MoonCakeBagNormalItem.super.Dispose(self)
end

function MoonCakeBagNormalItem:SetData(arg_6_1, arg_6_2)
	self.itemID_ = arg_6_1
	self.index_ = arg_6_2
	self.nameText_.text = ItemTools.getItemName(arg_6_1)

	local var_6_0 = ItemTools.getItemNum(arg_6_1)

	self.numText_.text = var_6_0
	self.icon_.sprite = ItemTools.getItemSprite(arg_6_1)
	self.info_ = self.info_ or {}
	self.info_.id = self.itemID_
	self.info_.number = var_6_0
end

function MoonCakeBagNormalItem:SetClickHandler(arg_7_1)
	self.clickHandler_ = arg_7_1
end

return MoonCakeBagNormalItem
