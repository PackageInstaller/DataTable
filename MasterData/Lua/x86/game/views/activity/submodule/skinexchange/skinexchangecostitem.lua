local SkinExchangeCostItem = class("SkinExchangeCostItem", ReduxView)

function SkinExchangeCostItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function SkinExchangeCostItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SkinExchangeCostItem:InitUI()
	self:BindCfgUI()
end

function SkinExchangeCostItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		ShowPopItem(POP_SOURCE_ITEM, {
			self.id_
		})
	end)
end

function SkinExchangeCostItem:OnEnter()
	return
end

function SkinExchangeCostItem:RefreshUI(arg_7_1)
	self.info_ = arg_7_1
	self.id_ = self.info_[1]
	self.need_ = self.info_[2]
	self.icon_.sprite = ItemTools.getItemLittleSprite(self.id_)
	self.text_.text = CItemTools.getItemNum(self.id_) .. "/" .. self.need_
end

function SkinExchangeCostItem:OnExit()
	return
end

function SkinExchangeCostItem:Dispose()
	return
end

return SkinExchangeCostItem
