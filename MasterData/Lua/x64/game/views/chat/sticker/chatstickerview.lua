local ChatStickerView = class("ChatStickerView", ReduxView)

function ChatStickerView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.categoryItemList_ = {}
	self.stickerUIList_ = LuaList.New(handler(self, self.RefreshItem), self.uiList_, ChatStickerItem)

	for iter_1_0, iter_1_1 in ipairs(ChatStickerCategoryCfg.all) do
		if iter_1_1 == 0 or ChatStickerTools.GetStickerCntInCategory(iter_1_1) > 0 then
			table.insert(self.categoryItemList_, ChatStickerCategoryItem.New(self.categoryItem_, self.categoryParent_, iter_1_1))
		end
	end

	self.changeStickerCategoryHandler_ = handler(self, self.ChangeStickerCategory)
	self.selectCategoryID_ = ChatStickerCategoryCfg.all[1]
end

function ChatStickerView:OnEnter()
	manager.notify:RegistListener(CHAT_CHANGE_STICKER_CATEGORY, self.changeStickerCategoryHandler_)
end

function ChatStickerView:OnExit()
	manager.notify:RemoveListener(CHAT_CHANGE_STICKER_CATEGORY, self.changeStickerCategoryHandler_)
end

function ChatStickerView:RefreshItem(arg_4_1, arg_4_2)
	if self.selectCategoryID_ == 0 then
		if arg_4_1 == 1 then
			arg_4_2:RefreshData(0)
		else
			arg_4_2:RefreshData(self.stickerIDList_[arg_4_1 - 1])
		end
	else
		arg_4_2:RefreshData(self.stickerIDList_[arg_4_1])
	end
end

function ChatStickerView:Dispose()
	ChatStickerView.super.Dispose(self)

	self.changeStickerCategoryHandler_ = nil

	for iter_5_0, iter_5_1 in ipairs(self.categoryItemList_) do
		iter_5_1:Dispose()
	end

	self.categoryItemList_ = nil

	self.stickerUIList_:Dispose()

	self.stickerUIList_ = nil
	self.transform_ = nil
	self.gameObject_ = nil
end

function ChatStickerView:Show(arg_6_1)
	SetActive(self.gameObject_, arg_6_1)

	if arg_6_1 then
		self:ChangeStickerCategory(self.selectCategoryID_)
	end
end

function ChatStickerView:ChangeStickerCategory(arg_7_1)
	self.selectCategoryID_ = arg_7_1 or self.selectCategoryID_

	for iter_7_0, iter_7_1 in ipairs(self.categoryItemList_) do
		iter_7_1:RefreshSelectID(self.selectCategoryID_)
	end

	self.stickerIDList_ = self.selectCategoryID_ == 0 and ChatStickerData:GetCustomStickerList() or ChatStickerTools.SortChatSticker(self.selectCategoryID_)

	self:RefreshChateSticker()
end

function ChatStickerView:RefreshChateSticker()
	local var_8_0 = #self.stickerIDList_

	if self.selectCategoryID_ == 0 then
		var_8_0 = var_8_0 + 1
	end

	self.stickerUIList_:StartScroll(var_8_0)
end

return ChatStickerView
