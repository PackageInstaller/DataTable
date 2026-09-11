local MomoTalkSettingItem = class("MomoTalkSettingItem", ReduxView)

function MomoTalkSettingItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:InitController()
	self:AddListeners()
end

function MomoTalkSettingItem:InitController()
	if self.controllerEx_ then
		self.iconSelectController_ = self.controllerEx_:GetController("select")
		self.iconLockController_ = self.controllerEx_:GetController("lock")
		self.iconUseController_ = self.controllerEx_:GetController("use")
		self.itemTypeController_ = self.controllerEx_:GetController("type")
	end
end

function MomoTalkSettingItem:AddListeners()
	if self.iconBtn_ then
		self:AddBtnListener(self.iconBtn_, nil, function()
			if self.onClick_ then
				self.onClick_(self.id_)
			end
		end)
	end
end

function MomoTalkSettingItem:SetData(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self.data_ = arg_5_1
	self.id_ = arg_5_1 and arg_5_1.id
	self.onClick_ = arg_5_4

	local var_5_0 = arg_5_1 and arg_5_1.type == "bubble"

	self:SetControllerState(self.itemTypeController_, arg_5_1 and arg_5_1.type == "bubble" and "chatBubble" or "head")

	if self.iconImg_ then
		SetActive(self.iconImg_.gameObject, not var_5_0)
	end

	if self.chatBubbleCont_ then
		SetActive(self.chatBubbleCont_.gameObject, var_5_0)
	end

	if var_5_0 then
		self:RefreshBubble(arg_5_1, arg_5_2, arg_5_3)
	else
		self:RefreshHead(arg_5_1, arg_5_2, arg_5_3)
	end
end

function MomoTalkSettingItem:RefreshHead(arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_1 and arg_6_1.state == 1

	self:DestroyBubble()

	if self.iconImg_ and arg_6_1 then
		self.iconImg_.sprite = MomoTalkTools.GetMonoAvatarIcon(arg_6_1.id)
		self.iconImg_.color = LuaHelper.StringToColor("#FFFFFF")
	end

	self:SetControllerState(self.iconSelectController_, arg_6_2 and "select" or "default")
	self:SetControllerState(self.iconLockController_, var_6_0 and "default" or "lock")
	self:SetControllerState(self.iconUseController_, arg_6_3 and "used" or "default")
end

function MomoTalkSettingItem:RefreshBubble(arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_1 and arg_7_1.state == 1
	local var_7_1 = arg_7_1 and ChatBubbleCfg[arg_7_1.id]

	if not (arg_7_1 and ChatBubbleCfg[arg_7_1.id]) then
		return
	end

	if self.chatBubbleTxt_ then
		self.chatBubbleTxt_.text = ItemCfg[arg_7_1.id] and GetI18NText(ItemCfg[arg_7_1.id].name) or ""
	end

	local var_7_3 = var_7_1.color2 or var_7_1.color1 or "FFFFFF"

	if var_7_1.type and var_7_1.type == 2 then
		if self.chatBubbleCont_ then
			SetActive(self.chatBubbleCont_.gameObject, true)
		end

		if self.chatBubbleImg_ then
			self.chatBubbleImg_.enabled = false
		end

		if self.chatBubbleCont_ and self.dynamicBubbleName_ ~= var_7_1.image1 then
			if not isNil(self.dynamicBubble_) then
				self:DestroyBubble()
			end

			self.dynamicBubbleName_ = var_7_1.image1
			self.dynamicBubble_ = DynamicPortraitPool.GetInstance():GetBubble(var_7_1.image1, self.chatBubbleCont_)
		end

		if self.chatBubblePrevImg_ then
			self.chatBubblePrevImg_.color = LuaHelper.StringToColor("#" .. var_7_3)

			self.chatBubblePrevImg_.transform:SetAsLastSibling()
		end

		if self.chatBubbleTxt_ then
			self.chatBubbleTxt_.color = LuaHelper.StringToColor("#" .. var_7_3)
		end
	else
		self:DestroyBubble()

		if self.chatBubbleCont_ then
			SetActive(self.chatBubbleCont_.gameObject, false)
		end

		if self.chatBubbleImg_ then
			self.chatBubbleImg_.enabled = true
			self.chatBubbleImg_.sprite = ItemTools.getItemSprite(arg_7_1.id)
		end

		if self.chatBubbleTxt_ then
			var_7_3 = var_7_1.color1 or var_7_3
			self.chatBubbleTxt_.color = LuaHelper.StringToColor("#" .. var_7_3)
		end
	end

	self:SetControllerState(self.iconSelectController_, arg_7_2 and "select" or "default")
	self:SetControllerState(self.iconLockController_, var_7_0 and "default" or "lock")
	self:SetControllerState(self.iconUseController_, arg_7_3 and "used" or "default")
end

function MomoTalkSettingItem:SetControllerState(arg_8_1, arg_8_2)
	if arg_8_1 then
		arg_8_1:SetSelectedState(arg_8_2)
	end
end

function MomoTalkSettingItem:Dispose()
	self:DestroyBubble()
	self:RemoveAllListeners()
	MomoTalkSettingItem.super.Dispose(self)
end

function MomoTalkSettingItem:DestroyBubble()
	if not isNil(self.dynamicBubble_) then
		DynamicPortraitPool.GetInstance():ReturnBubble(self.dynamicBubbleName_, self.dynamicBubble_)
	end

	self.dynamicBubble_ = nil
	self.dynamicBubbleName_ = nil
end

return MomoTalkSettingItem
