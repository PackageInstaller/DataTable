local CustomStickerItem = class("CustomStickerItem", ReduxView)

function CustomStickerItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "select")
	self.lockController_ = ControllerUtil.GetController(self.transform_, "lock")
end

function CustomStickerItem:SetData(arg_2_1)
	local var_2_0 = ChatStickerCfg[arg_2_1]

	self.isLock_ = false

	if var_2_0.free == 0 then
		self.isLock_ = ChatStickerData:IsLockSticker(arg_2_1)
	end

	if self.isLock_ then
		self.lockController_:SetSelectedState("true")
	else
		self.lockController_:SetSelectedState("false")
	end

	if self.id_ == arg_2_1 then
		return
	end

	self.id_ = arg_2_1
	self.descSource_ = SettingData:GetCurrentLanguage() == "zh_cn" and var_2_0.desc_source or var_2_0.desc_source_1

	self:RefreshSelectState()
	self:DestroySticker()

	if var_2_0.type == 1 then
		self.icon_.sprite = getSpriteViaConfig("ChatSticker", var_2_0.icon)
		self.icon_.enabled = true
	else
		self.dynamicStickerGo_ = Object.Instantiate(Asset.Load(var_2_0.icon), self.dynamicTf_)
		self.icon_.enabled = false
	end
end

function CustomStickerItem:Dispose()
	CustomStickerItem.super.Dispose(self)
	self:DestroySticker()
end

function CustomStickerItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		local var_5_0 = ChatStickerData:GetCustomStickerUIList()

		if not table.keyof(var_5_0, self.id_) and GameSetting.chat_sticker_custom_max_cnt.value[1] <= #var_5_0 then
			ShowTips("CHAT_CUSTOM_STICKER_LIMIT_EXCEEDED")

			return
		end

		if self.isLock_ then
			if self.descSource_ == "" then
				ShowTips("CHAT_DYNAMIC_STICKER_LOCK")
			else
				ShowTips(self.descSource_)
			end

			return
		end

		ChatStickerData:ChangeCustomStickerUIList(self.id_)
		self:RefreshSelectState()
		manager.notify:Invoke(CHAT_CUSTOM_STICKER_CHANGED)
	end)
end

function CustomStickerItem:RefreshSelectState()
	if table.keyof(ChatStickerData:GetCustomStickerUIList(), self.id_) then
		self.controller_:SetSelectedState("true")
	else
		self.controller_:SetSelectedState("false")
	end
end

function CustomStickerItem:DestroySticker()
	if self.dynamicStickerGo_ then
		Object.Destroy(self.dynamicStickerGo_)

		self.dynamicStickerGo_ = nil
	end
end

return CustomStickerItem
