local SummerCookMenuFoodItem = class("SummerCookMenuFoodItem", ReduxView)

function SummerCookMenuFoodItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddUIListeners()

	self.lockController_ = self.transCon_:GetController("unlock")
	self.doneController_ = self.transCon_:GetController("done")
	self.selectController_ = self.transCon_:GetController("select")
end

function SummerCookMenuFoodItem:AddUIListeners()
	self:AddBtnListener(self.btnClick_, nil, function()
		if self.isUnLock_ then
			self.isSelected_ = not self.isSelected_

			self.selectController_:SetSelectedState(tostring(self.isSelected_))

			if self.onClick then
				self.onClick(self.itemId_, self.isSelected_, self.transform_)
			end
		else
			ShowTips(GetTips("COOKING_GAME_MATERIAL_NOT_ENOUGH"))
		end
	end)
end

function SummerCookMenuFoodItem:RefreshSelect(arg_4_1)
	if not self.isUnLock_ then
		return
	end

	self.isSelected_ = arg_4_1

	self.selectController_:SetSelectedState(tostring(self.isSelected_))
end

function SummerCookMenuFoodItem:RefreshDoneContronl(arg_5_1)
	self.doneController_:SetSelectedState(tostring(arg_5_1))
end

function SummerCookMenuFoodItem:RefreshUnlockContronl(arg_6_1)
	self.isUnLock_ = arg_6_1

	self.lockController_:SetSelectedState(tostring(arg_6_1))
end

function SummerCookMenuFoodItem:SetData(arg_7_1)
	self.isSelected_ = false

	self.selectController_:SetSelectedState(tostring(self.isSelected_))

	self.itemId_ = arg_7_1
	self.foodIcon_.sprite = ItemTools.getItemSprite(arg_7_1)
end

function SummerCookMenuFoodItem:SetLock(arg_8_1)
	self.isUnLock_ = arg_8_1

	self.lockController_:SetSelectedState(tostring(self.isUnLock_))

	if not (getData("summerCookMenuView", "hasShowUnlock" .. self.itemId_) or false) and self.isUnLock_ then
		self.ani_:Play("UI_fooditem_cx", 0, 0)
		self.ani_:Update(0)
		saveData("summerCookMenuView", "hasShowUnlock" .. self.itemId_, true)
	else
		self.ani_:Play("UI_fooditemNormal", 0, 0)
	end
end

function SummerCookMenuFoodItem:Dispose()
	SummerCookMenuFoodItem.super.Dispose(self)
end

function SummerCookMenuFoodItem:RegisterClick(arg_10_1)
	self.onClick = arg_10_1
end

return SummerCookMenuFoodItem
