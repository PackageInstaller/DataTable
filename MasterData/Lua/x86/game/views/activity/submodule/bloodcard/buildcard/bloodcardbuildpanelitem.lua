local BloodCardBuildPanelItem = class("BloodCardBuildPanelItem", (import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")))

function BloodCardBuildPanelItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.cardItemList_ = {}
end

function BloodCardBuildPanelItem:AddListeners()
	return
end

function BloodCardBuildPanelItem:SetData(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6)
	self:Show(true)

	self.index_ = arg_3_2

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		if self.cardItemList_[iter_3_0] == nil then
			self.cardItemList_[iter_3_0] = BloodCardVisualCardView.New((Object.Instantiate(self.itemGo_, self.rectGo_)))
		end

		self.cardItemList_[iter_3_0]:SetData(iter_3_0, iter_3_1)
		self.cardItemList_[iter_3_0]:SetUseNum("true")
		self.cardItemList_[iter_3_0]:SetUsed(table.indexof(arg_3_4, iter_3_1) ~= false)
		self.cardItemList_[iter_3_0]:SetNone(table.indexof(arg_3_5, iter_3_1) ~= false)
		self.cardItemList_[iter_3_0]:SetGray(arg_3_3 == 0)
		self.cardItemList_[iter_3_0]:SelectCard(self.selectID_)
		self.cardItemList_[iter_3_0]:SetOwnNum(arg_3_6[iter_3_1] or 0)
		SetActive(self.cardItemList_[iter_3_0].gameObject_, true)
	end

	for iter_3_2 = #arg_3_1 + 1, #self.cardItemList_ do
		SetActive(self.cardItemList_[iter_3_2].gameObject_, false)
	end
end

function BloodCardBuildPanelItem:IsSelectID(arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(self.cardItemList_) do
		if iter_4_1.id_ == arg_4_1 then
			return iter_4_1
		end
	end
end

function BloodCardBuildPanelItem:SetSelectID(arg_5_1)
	self.selectID_ = arg_5_1

	for iter_5_0, iter_5_1 in ipairs(self.cardItemList_) do
		iter_5_1:SelectCard(arg_5_1)
	end
end

function BloodCardBuildPanelItem:RefreshNone(arg_6_1, arg_6_2)
	for iter_6_0, iter_6_1 in ipairs(self.cardItemList_) do
		if iter_6_1.id_ == arg_6_1 then
			iter_6_1:SetNone(arg_6_2)
		end
	end
end

function BloodCardBuildPanelItem:Show(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
end

function BloodCardBuildPanelItem:Dispose()
	for iter_8_0, iter_8_1 in ipairs(self.cardItemList_) do
		iter_8_1:Dispose()
	end

	self.cardItemList_ = nil

	BloodCardBuildPanelItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

return BloodCardBuildPanelItem
