local BloodCardBuildTitleItem = class("BloodCardBuildTitleItem", (import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")))

function BloodCardBuildTitleItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.cardItemList_ = {}
end

function BloodCardBuildTitleItem:AddListeners()
	return
end

function BloodCardBuildTitleItem:SetData(arg_3_1, arg_3_2)
	self:Show(true)

	self.index_ = arg_3_2
end

function BloodCardBuildTitleItem:Show(arg_4_1)
	SetActive(self.gameObject_, arg_4_1)
end

function BloodCardBuildTitleItem:Dispose()
	for iter_5_0, iter_5_1 in ipairs(self.cardItemList_) do
		iter_5_1:Dispose()
	end

	self.cardItemList_ = nil

	BloodCardBuildTitleItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

return BloodCardBuildTitleItem
