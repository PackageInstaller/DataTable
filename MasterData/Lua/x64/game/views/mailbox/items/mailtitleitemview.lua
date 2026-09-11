local MailTitleItemView = class("MailTitleItemView", ReduxView)

function MailTitleItemView:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.onResize_ = arg_1_2

	self:InitUI()
	self:AddListeners()
end

function MailTitleItemView:Dispose()
	if self.time_ then
		self.timt_:Stop()

		self.time_ = nil
	end

	self:RemoveListeners()
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil

	MailTitleItemView.super.Dispose(self)
end

function MailTitleItemView:InitUI()
	self.titleText_ = self:FindCom(typeof(Text), "titleText")
	self.timeText_ = self:FindCom(typeof(Text), "time/text")
	self.blueImg_ = self:FindCom(typeof(RectTransform), "blueImg")
	self.titleTrs_ = self:FindCom(typeof(RectTransform), "titleText")
end

function MailTitleItemView:AddListeners()
	return
end

function MailTitleItemView:RemoveListeners()
	return
end

function MailTitleItemView:SetData(arg_6_1)
	self.data_ = arg_6_1

	self:RefreshUI()
end

function MailTitleItemView:RefreshUI()
	self.titleText_.text = self.data_.text

	self.titleText_:GetComponent(typeof(ContentSizeFitter)):Validate()
	SetActive(self.gameObject_, true)

	if self.onResize_ ~= nil then
		self.onResize_()
	end
end

function MailTitleItemView:GetHeight()
	return 1
end

return MailTitleItemView
