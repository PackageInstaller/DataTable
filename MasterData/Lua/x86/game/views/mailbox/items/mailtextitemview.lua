local MailTextItemView = class("MailTextItemView", ReduxView)

function MailTextItemView:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.onResize_ = arg_1_2

	self:InitUI()
	self:AddListeners()
end

function MailTextItemView:Dispose()
	self:RemoveListeners()
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil

	MailTextItemView.super.Dispose(self)
end

function MailTextItemView:InitUI()
	self.richText_ = self:FindCom("RichText", "")
end

function MailTextItemView:AddListeners()
	self.richText_:AddListener(function(arg_5_0, arg_5_1)
		if arg_5_0 == "1" then
			OperationAction.OpenNormalUrl(arg_5_1)
		elseif arg_5_0 == "2" then
			local var_5_0 = {}

			for iter_5_0, iter_5_1 in ipairs((string.split(arg_5_1, ","))) do
				table.insert(var_5_0, tonumber(iter_5_1) or iter_5_1)
			end

			JumpTools.JumpToPage2(var_5_0)
		end
	end)
end

function MailTextItemView:RemoveListeners()
	self.richText_:RemoveAllListeners()
end

function MailTextItemView:SetData(arg_7_1)
	self.data_ = arg_7_1

	self:RefreshUI()
end

function MailTextItemView:RefreshUI()
	self.richText_.text = string.gsub(self.data_.text, "\\n", "\n")

	self.transform_:SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, (self:GetTextHeight()))
	SetActive(self.gameObject_, true)

	if self.onResize_ ~= nil then
		self.onResize_()
	end
end

function MailTextItemView:GetTextHeight()
	local var_9_0 = self.gameObject_:GetComponent(typeof(Text))

	return var_9_0.cachedTextGenerator:GetPreferredHeight(var_9_0.text, (var_9_0:GetGenerationSettings(self.transform_.rect.size))) * (1 / var_9_0.pixelsPerUnit)
end

function MailTextItemView:GetHeight()
	return self:GetTextHeight()
end

return MailTextItemView
