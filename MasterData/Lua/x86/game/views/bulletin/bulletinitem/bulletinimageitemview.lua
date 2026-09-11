local BulletinImageItemView = class("BulletinImageItemView", ReduxView)

function BulletinImageItemView:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:SetViewProp("bulletinID", arg_1_2)
	self:SetViewProp("contentIndex", arg_1_3)
	self:InitUI()
	self:RefreshUI()
end

function BulletinImageItemView:Dispose()
	self:RemoveListeners()
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil

	BulletinImageItemView.super.Dispose(self)
end

function BulletinImageItemView:InitUI()
	self.bg_ = self:FindCom(typeof(Image), "")
	self.richText_ = self:FindCom("RichText", "RichText")
	self.btn_ = self:FindCom(typeof(Button), "")
end

function BulletinImageItemView:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		local var_5_0 = self:GetContent(self:GetViewProp("bulletinID"), self:GetViewProp("contentIndex"))

		if var_5_0.event then
			if var_5_0.event[1] == 1 and var_5_0.event[2] ~= "" then
				BulletinAction.OpenOperationUrl(var_5_0.event[2])
			elseif var_5_0.event[1] == 2 and var_5_0.event[2] ~= "" then
				local var_5_1 = {}

				for iter_5_0, iter_5_1 in ipairs((string.split(var_5_0.event[2], ","))) do
					table.insert(var_5_1, tonumber(iter_5_1) or iter_5_1)
				end

				JumpTools.JumpToPage2(var_5_1)
			end
		end
	end)
	self.richText_:AddListener(function(arg_6_0, arg_6_1)
		if arg_6_0 == 1 then
			BulletinAction.OpenOperationUrl(arg_6_1)
		elseif arg_6_0 == 2 then
			local var_6_0 = {}

			for iter_6_0, iter_6_1 in ipairs((string.split(arg_6_1, ","))) do
				table.insert(var_6_0, tonumber(iter_6_1) or iter_6_1)
			end

			JumpTools.JumpToPage2(var_6_0)
		end
	end)
end

function BulletinImageItemView:RemoveListeners()
	self.btn_.onClick:RemoveAllListeners()
	self.richText_:RemoveAllListeners()
end

function BulletinImageItemView:RefreshUI()
	local var_8_0 = self:GetContent(self:GetViewProp("bulletinID"), self:GetViewProp("contentIndex"))

	if var_8_0.text then
		self.richText_.text = GetI18NText(var_8_0.text)
	end

	SetForceShowQuanquan(true)
	self:GetImageByUrl(var_8_0.spriteUrl, function(arg_9_0, arg_9_1)
		SetForceShowQuanquan(false)

		if arg_9_0 ~= var_8_0.spriteUrl then
			return
		end

		if self.gameObject_ == nil then
			return
		end

		self.bg_.sprite = arg_9_1

		self.bg_:SetNativeSize()
		self:AddListeners()
	end)
	SetActive(self.gameObject_, true)
end

function BulletinImageItemView:GetImageByUrl(arg_10_1, arg_10_2)
	if string.find(arg_10_1, "game://") then
		getSpriteWithoutAtlasAsync(string.gsub(arg_10_1, "game://", ""), function(arg_11_0)
			arg_10_2(arg_10_1, arg_11_0)
		end)
	else
		BulletinBoardMgr.inst:GetSprite(self:GetViewProp("bulletinID"), arg_10_1, function(arg_12_0)
			arg_10_2(arg_10_1, arg_12_0)
		end)
	end
end

function BulletinImageItemView:GetContent(arg_13_1, arg_13_2)
	local var_13_0 = SettingData:GetCurrentLanguage()

	for iter_13_0, iter_13_1 in pairs(BulletinData.GetBulletinPageList()) do
		if iter_13_1.id == arg_13_1 then
			if var_13_0 and iter_13_1.i18n_info_content[var_13_0] then
				return iter_13_1.i18n_info_content[var_13_0][arg_13_2]
			else
				return iter_13_1.content[arg_13_2]
			end
		end
	end
end

return BulletinImageItemView
