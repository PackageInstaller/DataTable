local SectionExtraAttachBaseView = class("SectionExtraAttachBaseView", ReduxView)

function SectionExtraAttachBaseView:Ctor(arg_1_1, arg_1_2)
	return
end

function SectionExtraAttachBaseView:OnEnter()
	SetActive(self.gameObject_, true)
end

function SectionExtraAttachBaseView:OnExit()
	SetActive(self.gameObject_, false)
end

function SectionExtraAttachBaseView:Dispose()
	return
end

function SectionExtraAttachBaseView:Dispose()
	SectionExtraAttachBaseView.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function SectionExtraAttachBaseView:RefreshUI()
	return
end

return SectionExtraAttachBaseView
