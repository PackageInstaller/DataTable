local IlluIllustrationWidget = class("IlluIllustrationWidget", (import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")))

function IlluIllustrationWidget:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.illuItemList_ = {}
end

function IlluIllustrationWidget:AddListeners()
	return
end

function IlluIllustrationWidget:GetItemHeight()
	return 0
end

function IlluIllustrationWidget:SetData(arg_4_1, arg_4_2, arg_4_3)
	self:Show(true)

	self.index_ = arg_4_2
	self.data_ = arg_4_1
	self.chapterID_ = arg_4_1.chapterID
	self.list = arg_4_1.list
	self.isEditor_ = arg_4_3
	self.objectType_ = arg_4_1.objectType

	for iter_4_0, iter_4_1 in ipairs(self.list) do
		if self.illuItemList_[iter_4_0] == nil then
			local var_4_0 = Object.Instantiate(self.itemGo_, self.transform_)

			self.illuItemList_[iter_4_0] = IlluIllustrationItem.New(var_4_0)
			var_4_0.name = iter_4_1
		end

		self.illuItemList_[iter_4_0]:RefreshUI(iter_4_1, self.isEditor_, arg_4_2)
		self.illuItemList_[iter_4_0]:Show(true)
	end

	for iter_4_2 = #self.list + 1, #self.illuItemList_ do
		self.illuItemList_[iter_4_2]:Show(false)
	end
end

function IlluIllustrationWidget:GetObjectType()
	return self.objectType_
end

function IlluIllustrationWidget:Show(arg_6_1)
	SetActive(self.gameObject_, arg_6_1)
end

function IlluIllustrationWidget:Dispose()
	for iter_7_0, iter_7_1 in ipairs(self.illuItemList_) do
		iter_7_1:Dispose()
	end

	self.illuItemList_ = nil

	IlluIllustrationWidget.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

return IlluIllustrationWidget
