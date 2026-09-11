local ChapterBaseVirtualItemView = class("ChapterBaseVirtualItemView", ReduxView)

function ChapterBaseVirtualItemView:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform
end

function ChapterBaseVirtualItemView:OnEnter()
	self:Show(true)
end

function ChapterBaseVirtualItemView:Show(arg_3_1)
	SetActive(self.gameObject_, arg_3_1)
end

function ChapterBaseVirtualItemView:OnExit()
	self:Show(false)
end

function ChapterBaseVirtualItemView:Dispose()
	ChapterBaseVirtualItemView.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

function ChapterBaseVirtualItemView:SetSiblingIndex(arg_6_1)
	self.transform_:SetSiblingIndex(arg_6_1)
end

function ChapterBaseVirtualItemView:GetLocalPosition()
	return self.transform_.localPosition
end

return ChapterBaseVirtualItemView
