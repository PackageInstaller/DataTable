local MailImageItemView = class("MailImageItemView", ReduxView)

function MailImageItemView:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.onResize_ = arg_1_2

	self:InitUI()
end

function MailImageItemView:Dispose()
	self:RemoveListeners()
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil

	MailImageItemView.super.Dispose(self)
end

function MailImageItemView:InitUI()
	self.bg_ = self:FindCom(typeof(Image), "")
	self.richText_ = self:FindCom("RichText", "RichText")
	self.btn_ = self:FindCom(typeof(Button), "")
end

function MailImageItemView:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.data_.event_type > 0 then
			if self.data_.event_type == 1 and self.data_.event_arg ~= "" then
				OperationAction.OpenNormalUrl(self.data_.event_arg)
			elseif self.data_.event_type == 2 and self.data_.event_arg ~= "" then
				local var_5_0 = {}

				for iter_5_0, iter_5_1 in ipairs((string.split(self.data_.event_arg, ","))) do
					table.insert(var_5_0, tonumber(iter_5_1) or iter_5_1)
				end

				JumpTools.JumpToPage2(var_5_0)
			end
		end
	end)
	self.richText_:AddListener(function(arg_6_0, arg_6_1)
		if arg_6_0 == 1 then
			OperationAction.OpenNormalUrl(arg_6_1)
		elseif arg_6_0 == 2 then
			local var_6_0 = {}

			for iter_6_0, iter_6_1 in ipairs((string.split(arg_6_1, ","))) do
				table.insert(var_6_0, tonumber(iter_6_1) or iter_6_1)
			end

			JumpTools.JumpToPage2(var_6_0)
		end
	end)
end

function MailImageItemView:RemoveListeners()
	self.btn_.onClick:RemoveAllListeners()
	self.richText_:RemoveAllListeners()
end

function MailImageItemView:SetData(arg_8_1)
	self.data_ = arg_8_1

	self:RefreshUI()
end

function MailImageItemView:RefreshUI()
	if self.data_.text then
		self.richText_.text = self.data_.text
	end

	self:GetImageByUrl(self.data_.image, function(arg_10_0, arg_10_1)
		if arg_10_0 ~= self.data_.image then
			return
		end

		if self.gameObject_ == nil then
			return
		end

		self.bg_.sprite = arg_10_1

		self.bg_:SetNativeSize()

		if self.onResize_ ~= nil then
			self.onResize_()
		end

		self:AddListeners()
	end)
	SetActive(self.gameObject_, true)
end

function MailImageItemView:GetImageByUrl(arg_11_1, arg_11_2)
	if string.find(arg_11_1, "game://") then
		getSpriteWithoutAtlasAsync(string.gsub(arg_11_1, "game://", ""), function(arg_12_0)
			arg_11_2(arg_11_1, arg_12_0)
		end)
	else
		BulletinBoardMgr.inst:GetSprite("mail", self.data_.image, function(arg_13_0)
			arg_11_2(arg_11_1, arg_13_0)
		end)
	end
end

function MailImageItemView:GetHeight()
	return self.bg_.transform.rect.height
end

return MailImageItemView
