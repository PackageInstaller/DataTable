local NewHeroChipListItem = class("NewHeroChipListItem", ReduxView)

function NewHeroChipListItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.chipItemGo_ = arg_1_2

	self:BindCfgUI()

	self.chipItemList_ = {}
end

function NewHeroChipListItem:RefreshUI()
	for iter_2_0, iter_2_1 in ipairs(self.chipList_) do
		local var_2_0 = self.chipItemList_[iter_2_0]

		if self.chipItemList_[iter_2_0] == nil then
			var_2_0 = NewHeroChipItem.New((Object.Instantiate(self.chipItemGo_, self.chipContent_)))
			self.chipItemList_[iter_2_0] = var_2_0

			var_2_0:SetCallBack(self.chipClickCallBack_)
		end

		SetActive(var_2_0.gameObject_, true)
		var_2_0:SetData(self.chipList_[iter_2_0], self.curChipID_)
	end

	for iter_2_2 = #self.chipList_ + 1, #self.chipItemList_ do
		SetActive(self.chipItemList_[iter_2_2].gameObject_, false)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.chipContent_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)
end

function NewHeroChipListItem:SetData(arg_3_1, arg_3_2, arg_3_3)
	self.heroID_ = arg_3_1
	self.chipList_ = arg_3_2
	self.curChipID_ = arg_3_3

	self:RefreshUI()
end

function NewHeroChipListItem:SetChipClickCallBack(arg_4_1)
	self.chipClickCallBack_ = arg_4_1
end

function NewHeroChipListItem:SetIsShow(arg_5_1)
	SetActive(self.gameObject_, arg_5_1)
end

function NewHeroChipListItem:Dispose()
	NewHeroChipListItem.super.Dispose(self)

	for iter_6_0, iter_6_1 in pairs(self.chipItemList_) do
		iter_6_1:Dispose()
	end

	self.chipItemList_ = nil
	self.chipClickCallBack_ = nil
end

return NewHeroChipListItem
