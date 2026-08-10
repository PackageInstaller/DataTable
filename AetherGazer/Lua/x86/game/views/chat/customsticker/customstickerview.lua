local var_0_0 = class("CustomStickerView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Chat/ChatCustomStickerUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.stickerUIList_ = LuaList.New(handler(arg_3_0, arg_3_0.RefreshItem), arg_3_0.uiList_, CustomStickerItem)
	arg_3_0.changedHandler_ = handler(arg_3_0, arg_3_0.RefreshUI)
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.sortStickerIDList_ = ChatStickerTools.SortAllChatSticker()

	arg_4_0.stickerUIList_:StartScroll(#arg_4_0.sortStickerIDList_)
	manager.notify:RegistListener(CHAT_CUSTOM_STICKER_CHANGED, arg_4_0.changedHandler_)
	arg_4_0:RefreshUI()
end

function var_0_0.OnExit(arg_5_0)
	manager.notify:RemoveListener(CHAT_CUSTOM_STICKER_CHANGED, arg_5_0.changedHandler_)
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)

	arg_6_0.changedHandler_ = nil

	arg_6_0.stickerUIList_:Dispose()

	arg_6_0.stickerUIList_ = nil
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.closeBtn_, nil, function()
		arg_7_0:CloseFun()
	end)
	arg_7_0:AddBtnListener(arg_7_0.okBtn_, nil, function()
		arg_7_0:ExitAndSaveData()
		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.cancelBtn_, nil, function()
		arg_7_0:CloseFun()
	end)
end

function var_0_0.RefreshItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.sortStickerIDList_[arg_11_1]

	arg_11_2:SetData(var_11_0)
end

function var_0_0.RefreshUI(arg_12_0)
	arg_12_0.cntText_.text = string.format("%s/%s", #ChatStickerData:GetCustomStickerUIList(), GameSetting.chat_sticker_custom_max_cnt.value[1])
end

function var_0_0.CloseFun(arg_13_0)
	if arg_13_0:HasChanged() then
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("CHAT_CUSTOM_STICKER_CHANGED"),
			OkCallback = function()
				arg_13_0:ExitAndSaveData()
				arg_13_0:Back()
			end,
			CancelCallback = function()
				arg_13_0:Back()
			end
		})
	else
		arg_13_0:Back()
	end
end

function var_0_0.HasChanged(arg_16_0)
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

function var_0_0.ExitAndSaveData(arg_17_0)
	ChatAction.SaveCustomSticker(function(arg_18_0)
		if isSuccess(arg_18_0.result) then
			manager.notify:Invoke(CHAT_CHANGE_STICKER_CATEGORY)
		else
			ShowTips(arg_18_0.result)
		end
	end)
end

return var_0_0
