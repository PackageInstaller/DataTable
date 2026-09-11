local BulletinTextItemView = class("BulletinTextItemView", ReduxView)

function BulletinTextItemView:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:SetViewProp("bulletinID", arg_1_2)
	self:SetViewProp("contentIndex", arg_1_3)
	self:InitUI()
	self:AddListeners()
	self:RefreshUI()
end

function BulletinTextItemView:Dispose()
	self:RemoveListeners()
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil

	BulletinTextItemView.super.Dispose(self)
end

function BulletinTextItemView:InitUI()
	self.richText_ = self:FindCom("RichText", "")
end

function BulletinTextItemView:AddListeners()
	self.richText_:AddListener(function(arg_5_0, arg_5_1)
		if arg_5_0 == "1" then
			BulletinAction.OpenOperationUrl(arg_5_1)
		elseif arg_5_0 == "2" then
			local var_5_0 = {}

			for iter_5_0, iter_5_1 in ipairs((string.split(arg_5_1, ","))) do
				table.insert(var_5_0, tonumber(iter_5_1) or iter_5_1)
			end

			JumpTools.JumpToPage2(var_5_0)
		end
	end)
end

function BulletinTextItemView:RemoveListeners()
	self.richText_:RemoveAllListeners()
end

function BulletinTextItemView:RefreshUI()
	self.richText_.text = GetI18NText(self:GetContent(self:GetViewProp("bulletinID"), self:GetViewProp("contentIndex")).text)

	SetActive(self.gameObject_, true)
end

function BulletinTextItemView:GetContent(arg_8_1, arg_8_2)
	local var_8_0 = SettingData:GetCurrentLanguage()

	for iter_8_0, iter_8_1 in pairs(BulletinData.GetBulletinPageList()) do
		if iter_8_1.id == arg_8_1 then
			if var_8_0 and iter_8_1.i18n_info_content[var_8_0] then
				return iter_8_1.i18n_info_content[var_8_0][arg_8_2]
			else
				return iter_8_1.content[arg_8_2]
			end
		end
	end
end

return BulletinTextItemView
