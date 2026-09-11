local IlluIllustrationTitleItem = class("IlluIllustrationTitleItem", (import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")))

function IlluIllustrationTitleItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()
end

function IlluIllustrationTitleItem:AddListeners()
	return
end

function IlluIllustrationTitleItem:GetItemHeight()
	return 0
end

function IlluIllustrationTitleItem:SetData(arg_4_1, arg_4_2)
	self:Show(true)

	self.index_ = arg_4_2
	self.data_ = arg_4_1
	self.chapterID_ = arg_4_1.chapterID
	self.objectType_ = arg_4_1.objectType
	self.titleText_.text = ChapterClientCfg[self.chapterID_].name
end

function IlluIllustrationTitleItem:Show(arg_5_1)
	SetActive(self.gameObject_, arg_5_1)
end

function IlluIllustrationTitleItem:GetObjectType()
	return self.objectType_
end

function IlluIllustrationTitleItem:Dispose()
	IlluIllustrationTitleItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

return IlluIllustrationTitleItem
