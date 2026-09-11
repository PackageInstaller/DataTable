local BilliardBattleResultFoodItem = class("BilliardBattleResultFoodItem", ReduxView)

function BilliardBattleResultFoodItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function BilliardBattleResultFoodItem:Init()
	self:BindCfgUI()
	self:AddUIListener()
end

function BilliardBattleResultFoodItem:AddUIListener()
	self:AddBtnListener(self.foodBtn_, nil, function()
		self:OnBtnClick()
	end)
end

function BilliardBattleResultFoodItem:OnBtnClick()
	self.parent:OnChildClick(self)
end

function BilliardBattleResultFoodItem:Render(arg_6_1, arg_6_2)
	self.parent = arg_6_2
	self.itemId = arg_6_1
	self.foodIcon_.sprite = pureGetSpriteWithoutAtlas(ItemTools.getItemSprite(self.itemId))
end

function BilliardBattleResultFoodItem:GetItemId()
	return self.itemId
end

function BilliardBattleResultFoodItem:GetTipTrans()
	return self.tipsTrans_
end

return BilliardBattleResultFoodItem
