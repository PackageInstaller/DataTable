local ItemBuyView = class("ItemBuyView", ReduxView)

function ItemBuyView:UIName()
	return "Widget/System/Pool/ItemExchangeUI"
end

function ItemBuyView:UIParent()
	return manager.ui.uiPop.transform
end

function ItemBuyView:Init()
	self:InitUI()
	self:AddUIListener()

	self.itemCon_ = ControllerUtil.GetController(self.transform_, "itemNum")
	self.textCon_ = ControllerUtil.GetController(self.transform_, "text")
end

function ItemBuyView:OnEnter()
	self.selectNum_ = 1

	if self.params_.item3.id then
		self.itemCon_:SetSelectedState("2")
	else
		self.itemCon_:SetSelectedState("1")
	end

	self:RefreshUI()
end

function ItemBuyView:InitUI()
	self:BindCfgUI()
end

function ItemBuyView:AddUIListener()
	self:AddBtnListener(self.okBtn_, nil, function()
		if self.params_.OkCallback then
			self.params_.OkCallback()
		end
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		if self.params_.CancelCallback then
			self.params_.CancelCallback()

			self.params_.CancelCallback = nil

			self:Back()
		else
			self:Back()
		end
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		if self.params_.CancelCallback then
			self.params_.CancelCallback()

			self.params_.CancelCallback = nil

			self:Back()
		else
			self:Back()
		end
	end)
end

function ItemBuyView:RefreshUI()
	self.item1nameText_.text = ItemTools.getItemName(self.params_.item1.id)
	self.item1iconImg_.sprite = ItemTools.getItemLittleSprite(self.params_.item1.id)
	self.item1numText_.text = self.params_.item1.num
	self.titleTxt_.text = self.params_.title
	self.item2nameText_.text = ItemTools.getItemName(self.params_.item2.id)
	self.item2iconImg_.sprite = ItemTools.getItemLittleSprite(self.params_.item2.id)
	self.item2numText_.text = self.params_.item2.num

	if self.params_.item3.id then
		self.item3nameText_.text = ItemTools.getItemName(self.params_.item3.id)
		self.item3iconImg_.sprite = ItemTools.getItemLittleSprite(self.params_.item3.id)
		self.item3numText_.text = self.params_.item3.num
		self.textText_.text = System.String.Format(GetTips("RECHARGE_DIAMOND_AND_DIAMOND_EXCHANGE_DRAWCARD"), tonumber(self.params_.item3.num), tonumber(self.params_.item2.num), tonumber(self.params_.item1.num), ItemTools.getItemName(self.params_.item1.id))
	else
		self.textText_.text = System.String.Format(GetTips("RECHARGE_DIAMOND_OR_DIAMOND_EXCHANGE_DRAWCARD"), tonumber(self.params_.item2.num), ItemTools.getItemName(self.params_.item2.id), tonumber(self.params_.item1.num), ItemTools.getItemName(self.params_.item1.id))
	end
end

return ItemBuyView
