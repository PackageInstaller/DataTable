local ChatStickerItem = class("ChatStickerItem", ReduxView)

function ChatStickerItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.lockController_ = ControllerUtil.GetController(self.transform_, "lock")
end

function ChatStickerItem:RefreshData(arg_2_1)
	local var_2_0 = ChatStickerCfg[arg_2_1]

	if not ChatStickerCfg[arg_2_1] then
		return
	end

	self.isLock_ = var_2_0.free == 0 and ChatStickerData:IsLockSticker(arg_2_1) or false

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

	self:DestroySticker()

	if var_2_0.type == 1 then
		self.imageIcon_.sprite = getSpriteViaConfig("ChatSticker", var_2_0.icon)
		self.imageIcon_.enabled = true
	else
		self.dynamicStickerGo_ = Object.Instantiate(Asset.Load(var_2_0.icon), self.dynamicTf_)
		self.imageIcon_.enabled = false
	end
end

function ChatStickerItem:AddListeners()
	self:AddBtnListener(self.buttonItem_, nil, function()
		if self.id_ == 0 then
			ChatStickerData:InitStickerUIList()
			JumpTools.OpenPageByJump("chatCustomSticker")

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

		manager.notify:Invoke(CHAT_SEND_STICKER, self.id_)
	end)
end

function ChatStickerItem:DestroySticker()
	if self.dynamicStickerGo_ then
		Object.Destroy(self.dynamicStickerGo_)

		self.dynamicStickerGo_ = nil
	end
end

function ChatStickerItem:Dispose()
	ChatStickerItem.super.Dispose(self)
	self:DestroySticker()

	self.transform_ = nil
	self.gameObject_ = nil
end

return ChatStickerItem
