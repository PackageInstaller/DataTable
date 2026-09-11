local ChatStickerCategoryItem = class("ChatStickerCategoryItem", ReduxView)

function ChatStickerCategoryItem:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform
	self.id_ = arg_1_3

	SetActive(self.gameObject_, true)
	self:BindCfgUI()
	self:AddListeners()

	self.icon_.sprite = getSpriteViaConfig("ChatSticker", ChatStickerCategoryCfg[arg_1_3].icon)
	self.controller_ = ControllerUtil.GetController(self.transform_, "select") or self.itemControllerEx_:GetController("select")
end

function ChatStickerCategoryItem:OnEnter()
	return
end

function ChatStickerCategoryItem:OnExit()
	return
end

function ChatStickerCategoryItem:Dispose()
	ChatStickerCategoryItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function ChatStickerCategoryItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		manager.notify:Invoke(CHAT_CHANGE_STICKER_CATEGORY, self.id_)
	end)
end

function ChatStickerCategoryItem:RefreshSelectID(arg_7_1)
	if self.id_ == arg_7_1 then
		self.controller_:SetSelectedState("true")
	else
		self.controller_:SetSelectedState("false")
	end
end

return ChatStickerCategoryItem
