local var_0_0 = class("ChatStickerView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.categoryItemList_ = {}
	arg_1_0.stickerUIList_ = LuaList.New(handler(arg_1_0, arg_1_0.RefreshItem), arg_1_0.uiList_, ChatStickerItem)

	for iter_1_0, iter_1_1 in ipairs(ChatStickerCategoryCfg.all) do
		if iter_1_1 == 0 or ChatStickerTools.GetStickerCntInCategory(iter_1_1) > 0 then
			table.insert(arg_1_0.categoryItemList_, ChatStickerCategoryItem.New(arg_1_0.categoryItem_, arg_1_0.categoryParent_, iter_1_1))
		end
	end

	arg_1_0.changeStickerCategoryHandler_ = handler(arg_1_0, arg_1_0.ChangeStickerCategory)
	arg_1_0.selectCategoryID_ = ChatStickerCategoryCfg.all[1]
end

function var_0_0.OnEnter(arg_2_0)
	manager.notify:RegistListener(CHAT_CHANGE_STICKER_CATEGORY, arg_2_0.changeStickerCategoryHandler_)
end

function var_0_0.OnExit(arg_3_0)
	manager.notify:RemoveListener(CHAT_CHANGE_STICKER_CATEGORY, arg_3_0.changeStickerCategoryHandler_)
end

function var_0_0.RefreshItem(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0.stickerIDList_

	if arg_4_0.selectCategoryID_ == 0 then
		if arg_4_1 == 1 then
			arg_4_2:RefreshData(0)
		else
			arg_4_2:RefreshData(var_4_0[arg_4_1 - 1])
		end
	else
		arg_4_2:RefreshData(var_4_0[arg_4_1])
	end
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)

	arg_5_0.changeStickerCategoryHandler_ = nil

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.categoryItemList_) do
		iter_5_1:Dispose()
	end

	arg_5_0.categoryItemList_ = nil

	arg_5_0.stickerUIList_:Dispose()

	arg_5_0.stickerUIList_ = nil
	arg_5_0.transform_ = nil
	arg_5_0.gameObject_ = nil
end

function var_0_0.Show(arg_6_0, arg_6_1)
	SetActive(arg_6_0.gameObject_, arg_6_1)

	if arg_6_1 then
		arg_6_0:ChangeStickerCategory(arg_6_0.selectCategoryID_)
	end
end

function var_0_0.ChangeStickerCategory(arg_7_0, arg_7_1)
	arg_7_0.selectCategoryID_ = arg_7_1 or arg_7_0.selectCategoryID_

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.categoryItemList_) do
		iter_7_1:RefreshSelectID(arg_7_0.selectCategoryID_)
	end

	if arg_7_0.selectCategoryID_ == 0 then
		arg_7_0.stickerIDList_ = ChatStickerData:GetCustomStickerList()
	else
		arg_7_0.stickerIDList_ = ChatStickerTools.SortChatSticker(arg_7_0.selectCategoryID_)
	end

	arg_7_0:RefreshChateSticker()
end

function var_0_0.RefreshChateSticker(arg_8_0)
	local var_8_0 = #arg_8_0.stickerIDList_

	if arg_8_0.selectCategoryID_ == 0 then
		var_8_0 = var_8_0 + 1
	end

	arg_8_0.stickerUIList_:StartScroll(var_8_0)
end

return var_0_0
