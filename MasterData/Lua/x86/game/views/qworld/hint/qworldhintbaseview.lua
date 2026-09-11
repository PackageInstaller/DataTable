local QWorldHintBaseView = class("QWorldHintBaseView", ReduxView)

function QWorldHintBaseView:UIName()
	return
end

function QWorldHintBaseView:InitUI()
	return
end

function QWorldHintBaseView:SetData()
	return
end

function QWorldHintBaseView:RefreshUI()
	return
end

function QWorldHintBaseView:OnCtor()
	return
end

function QWorldHintBaseView:UIParent()
	return manager.ui.uiMessage.transform
end

function QWorldHintBaseView:Init()
	self.gameObject_ = Object.Instantiate(Asset.Load(self:UIName()), self:UIParent())
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:InitUI()
end

function QWorldHintBaseView:Show()
	if self.gameObject_ == nil then
		self:Init()
	end

	SetActive(self.gameObject_, true)
	self.transform_:SetAsLastSibling()
	self:RefreshUI()
	self:OnShow()
end

function QWorldHintBaseView:OnShow()
	return
end

function QWorldHintBaseView:Hide()
	if self.gameObject_ then
		SetActive(self.gameObject_, false)
	end

	self:OnHide()
end

function QWorldHintBaseView:OnHide()
	return
end

function QWorldHintBaseView:Dispose()
	if self.gameObject_ then
		Object.Destroy(self.gameObject_)

		self.gameObject_ = nil
		self.transform_ = nil

		Asset.Unload(self:UIName())
	end

	QWorldHintBaseView.super.Dispose(self)
end

return QWorldHintBaseView
