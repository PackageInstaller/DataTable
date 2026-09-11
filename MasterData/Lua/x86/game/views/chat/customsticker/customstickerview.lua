local CustomStickerView = class("CustomStickerView", ReduxView)

function CustomStickerView:UIName()
	return "Widget/System/Chat/ChatCustomStickerUI"
end

function CustomStickerView:UIParent()
	return manager.ui.uiPop.transform
end

function CustomStickerView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.stickerUIList_ = LuaList.New(handler(self, self.RefreshItem), self.uiList_, CustomStickerItem)
	self.changedHandler_ = handler(self, self.RefreshUI)
end

function CustomStickerView:OnEnter()
	self.sortStickerIDList_ = ChatStickerTools.SortAllChatSticker()

	self.stickerUIList_:StartScroll(#self.sortStickerIDList_)
	manager.notify:RegistListener(CHAT_CUSTOM_STICKER_CHANGED, self.changedHandler_)
	self:RefreshUI()
end

function CustomStickerView:OnExit()
	manager.notify:RemoveListener(CHAT_CUSTOM_STICKER_CHANGED, self.changedHandler_)
end

function CustomStickerView:Dispose()
	CustomStickerView.super.Dispose(self)

	self.changedHandler_ = nil

	self.stickerUIList_:Dispose()

	self.stickerUIList_ = nil
end

function CustomStickerView:AddListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:CloseFun()
	end)
	self:AddBtnListener(self.okBtn_, nil, function()
		self:ExitAndSaveData()
		self:Back()
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		self:CloseFun()
	end)
end

function CustomStickerView:RefreshItem(arg_11_1, arg_11_2)
	arg_11_2:SetData(self.sortStickerIDList_[arg_11_1])
end

function CustomStickerView:RefreshUI()
	self.cntText_.text = string.format("%s/%s", #ChatStickerData:GetCustomStickerUIList(), GameSetting.chat_sticker_custom_max_cnt.value[1])
end

function CustomStickerView:CloseFun()
	if self:HasChanged() then
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("CHAT_CUSTOM_STICKER_CHANGED"),
			OkCallback = function()
				self:ExitAndSaveData()
				self:Back()
			end,
			CancelCallback = function()
				self:Back()
			end
		})
	else
		self:Back()
	end
end

function CustomStickerView:HasChanged()
	local var_16_0 = ChatStickerData:GetCustomStickerList()
	local var_16_1 = ChatStickerData:GetCustomStickerUIList()

	if #var_16_0 == #var_16_1 then
		for iter_16_0, iter_16_1 in ipairs(var_16_0) do
			if table.keyof(var_16_1, iter_16_1) == nil then
				return true
			end
		end

		return false
	end

	return true
end

function CustomStickerView:ExitAndSaveData()
	ChatAction.SaveCustomSticker(function(arg_18_0)
		if isSuccess(arg_18_0.result) then
			manager.notify:Invoke(CHAT_CHANGE_STICKER_CATEGORY)
		else
			ShowTips(arg_18_0.result)
		end
	end)
end

return CustomStickerView
