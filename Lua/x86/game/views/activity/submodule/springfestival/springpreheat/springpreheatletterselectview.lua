local var_0_0 = class("SpringPreheatLetterSelectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaWishingTree/IndiaWishingTreePopUI2"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.textItemList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexTextItem), arg_3_0.textListGo_, SpringPreheatLetterSelectTextItem)
	arg_3_0.stickerList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexStickerItem), arg_3_0.stickerListGo_, SpringPreheatLetterSelectStickerItem)
	arg_3_0.textToggleList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexTextToggle), arg_3_0.textToggleListGo_, SpringPreheatLetterSelectTextToggleItem)
	arg_3_0.previewTextItem_ = SpringPreheatLetterTextItem.New(arg_3_0.previewTextGo_)

	arg_3_0.previewTextItem_:SetPreviewMode(true)

	arg_3_0.viewController_ = ControllerUtil.GetController(arg_3_0.transform_, "view")
	arg_3_0.btnController_ = ControllerUtil.GetController(arg_3_0.transform_, "btn")
end

function var_0_0.OnEnter(arg_4_0)
	if arg_4_0:IsStickerMode() then
		arg_4_0.stickerUsedList_ = arg_4_0.params_.usedList
		arg_4_0.stickerIndex_ = arg_4_0.params_.index
		arg_4_0.oldStickerId_ = arg_4_0.params_.info.stickerId
		arg_4_0.oldStickerSize_ = arg_4_0.params_.info.size
		arg_4_0.allStickerList_ = arg_4_0:GetAllSticker()
	else
		arg_4_0.paragIdx_ = arg_4_0.params_.paragIdx

		arg_4_0.previewTextItem_:SetData(arg_4_0.paragIdx_, nil, nil, true)

		if arg_4_0.params_.letterInfo then
			arg_4_0.previewTextItem_:SetLetterInfo(arg_4_0.params_.letterInfo)
		end

		arg_4_0.previewTextItem_:UpdateAnim(false)
		arg_4_0:SetToggleIndex(arg_4_0.params_.optionIdx or 1)
	end

	arg_4_0.lastClickItem_ = nil
	arg_4_0.lastClickToggle_ = nil

	arg_4_0:RefreshUI()
end

function var_0_0.OnTop(arg_5_0)
	if not arg_5_0:IsStickerMode() then
		if arg_5_0.params_.updateAni then
			arg_5_0.playPreviewTextAni_ = true
			arg_5_0.params_.updateAni = false
		end

		arg_5_0:SetToggleIndex(arg_5_0.params_.optionIdx or 1)

		arg_5_0.lastClickItem_ = nil
		arg_5_0.lastClickToggle_ = nil

		arg_5_0:RefreshUI()
	end
end

function var_0_0.OnExit(arg_6_0)
	if arg_6_0.lastClickItem_ then
		arg_6_0.lastClickItem_:SetSelected(false)
	end

	if arg_6_0.lastClickToggle_ then
		arg_6_0.lastClickToggle_:SetSelected(false)
		arg_6_0.lastClickToggle_:RefreshUI()
	end

	arg_6_0.playPreviewTextAni_ = false
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.textItemList_:Dispose()
	arg_7_0.textToggleList_:Dispose()
	arg_7_0.stickerList_:Dispose()
	arg_7_0.previewTextItem_:Dispose()
	var_0_0.super.Dispose(arg_7_0)
end

function var_0_0.AddListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.maskBtn_, nil, function()
		arg_8_0:Back()
	end)
	arg_8_0:AddBtnListener(arg_8_0.backBtn_, nil, function()
		arg_8_0:Back()
	end)
	arg_8_0:AddBtnListener(arg_8_0.confirmBtn_, nil, function()
		arg_8_0:OnClickOkBtn()
	end)
end

function var_0_0.OnClickOkBtn(arg_12_0)
	if arg_12_0:IsStickerMode() then
		if arg_12_0.params_.onChangeSticker and arg_12_0.stickerId_ ~= arg_12_0.oldStickerID_ then
			arg_12_0.params_.onChangeSticker(arg_12_0.stickerIndex_, arg_12_0.stickerId_, arg_12_0.oldStickerSize_)
		end

		arg_12_0:Back()
	else
		arg_12_0:OnClickChangeLetterBtn()
	end
end

function var_0_0.IndexTextItem(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = SpringPreheatData:GetPlayerLetter()
	local var_13_1 = SpringPreheatData:GetLetterOptionText(var_13_0.id, arg_13_0.paragIdx_, arg_13_0.sentenceIdx_, arg_13_1)
	local var_13_2 = arg_13_0.previewTextItem_:GetLetterInfo()[arg_13_0.sentenceIdx_]

	arg_13_2:SetLetterTextId(var_13_1)
	arg_13_2:SetClickHandler(handler(arg_13_0, arg_13_0.OnClickTextItem))

	if var_13_2 == arg_13_2.textId or var_13_2 == 0 and arg_13_1 == 1 and arg_13_0.lastClickItem_ == nil then
		arg_13_0.lastClickItem_ = arg_13_2
		arg_13_0.textId_ = arg_13_2.textId

		arg_13_2:SetSelected(true)
		arg_13_0:RefreshPreviewTextUI()
	end

	arg_13_2:SetSelected(arg_13_0.textId_ == arg_13_2.textId)
	arg_13_2:RefreshUI()
end

function var_0_0.OnClickTextItem(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0.lastClickItem_ and arg_14_0.lastClickItem_ ~= arg_14_1 then
		arg_14_0.lastClickItem_:SetSelected(false)
		arg_14_0.lastClickItem_:RefreshUI()
	end

	arg_14_1:SetSelected(true)
	arg_14_1:RefreshUI()

	arg_14_0.textId_ = arg_14_2
	arg_14_0.lastClickItem_ = arg_14_1
	arg_14_0.playPreviewTextAni_ = true

	arg_14_0:RefreshPreviewTextUI()
end

function var_0_0.IndexTextToggle(arg_15_0, arg_15_1, arg_15_2)
	arg_15_2:SetIndex(arg_15_1)
	arg_15_2:SetClickHandler(handler(arg_15_0, arg_15_0.OnClickTextToggle))

	if arg_15_1 == arg_15_0.toggleIndex_ and arg_15_0.lastClickToggle_ == nil then
		arg_15_0.lastClickToggle_ = arg_15_2

		arg_15_0:SetToggleIndex(arg_15_1)
	end

	arg_15_2:SetSelected(arg_15_1 == arg_15_0.toggleIndex_)
	arg_15_2:RefreshUI()
end

function var_0_0.OnClickTextToggle(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_0.lastClickToggle_ == arg_16_1 then
		return
	end

	if arg_16_0.lastClickToggle_ then
		arg_16_0.lastClickToggle_:SetSelected(false)
		arg_16_0.lastClickToggle_:RefreshUI()
	end

	arg_16_1:SetSelected(true)
	arg_16_1:RefreshUI()
	arg_16_0:SetToggleIndex(arg_16_2)

	arg_16_0.lastClickToggle_ = arg_16_1

	if arg_16_0.lastClickItem_ then
		arg_16_0.lastClickItem_:SetSelected(false)

		arg_16_0.lastClickItem_ = nil
	end

	arg_16_0.playPreviewTextAni_ = true

	arg_16_0:RefreshTextListUI()
end

function var_0_0.IndexStickerItem(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_1 == 1 and 0 or arg_17_0.allStickerList_[arg_17_1 - 1].id

	arg_17_2:RefreshItem(var_17_0)

	if arg_17_1 == 1 and arg_17_0.lastClickItem_ == nil then
		arg_17_0.lastClickItem_ = arg_17_2
		arg_17_0.stickerId_ = 0
	end

	if arg_17_0.stickerId_ == var_17_0 then
		arg_17_0.lastClickItem_ = arg_17_2
	end

	local var_17_1 = arg_17_0:IsUsed(var_17_0)

	arg_17_2:SetUsed(var_17_1)
	arg_17_2:SetSelected(var_17_0 == arg_17_0.stickerId_)
	arg_17_2:RegisterClickListener(function()
		arg_17_0:OnClickStickerItem(arg_17_2, var_17_0, arg_17_1)
	end)
end

function var_0_0.OnClickStickerItem(arg_19_0, arg_19_1, arg_19_2)
	if not arg_19_1:TrySelect() then
		ShowTips("SPRING_PREHEAT_STICKER_LOCKED")

		return
	end

	if arg_19_0.lastClickItem_ and arg_19_1 ~= arg_19_0.lastClickItem_ then
		arg_19_0.lastClickItem_:SetSelected(false)
	end

	arg_19_0.stickerId_ = arg_19_2
	arg_19_0.lastClickItem_ = arg_19_1
end

function var_0_0.RefreshUI(arg_20_0)
	arg_20_0.viewController_:SetSelectedState(arg_20_0:IsStickerMode() and "sticker" or "text")

	if arg_20_0:IsStickerMode() then
		arg_20_0:RefreshStickersUI()
	else
		local var_20_0 = SpringPreheatData:GetOptionCount(arg_20_0.paragIdx_)

		arg_20_0.textToggleList_:StartScroll(var_20_0)
		arg_20_0.textToggleList_:Refresh()
		arg_20_0:RefreshTextListUI()
		arg_20_0:RefreshPreviewTextUI()

		arg_20_0.titleText_.text = GetTips(string.format("SPRING_PREHEAT_WORD_TITLE_%d", arg_20_0.paragIdx_))
	end
end

function var_0_0.RefreshTextListUI(arg_21_0)
	local var_21_0 = arg_21_0:GetTextIdList(arg_21_0.sentenceIdx_)

	arg_21_0.textItemList_:StartScroll(#var_21_0)
	arg_21_0.textItemList_:Refresh()
	arg_21_0:RefreshPreviewTextUI()
end

function var_0_0.RefreshStickersUI(arg_22_0)
	arg_22_0.stickerList_:StartScroll(#arg_22_0.allStickerList_ + 1)

	arg_22_0.titleText_.text = GetTips("SPRING_PREHEAT_STICKER_TITLE")
end

function var_0_0.RefreshPreviewTextUI(arg_23_0)
	if arg_23_0.previewTextItem_:GetLetterInfo()[arg_23_0.sentenceIdx_] ~= arg_23_0.textId_ then
		if arg_23_0.playPreviewTextAni_ then
			arg_23_0.previewTextItem_:UpdateAnim(true, "IndiaWishingTreePopUI2_text")

			arg_23_0.playPreviewTextAni_ = false
		end

		arg_23_0.previewTextItem_:SetLetterInfo({
			[arg_23_0.sentenceIdx_] = arg_23_0.textId_
		})
		arg_23_0.previewTextItem_:RefreshUI()
	end

	arg_23_0.btnController_:SetSelectedState(arg_23_0.previewTextItem_:IsComplete() and "yes" or "no")
end

function var_0_0.OnClickChangeLetterBtn(arg_24_0)
	if not arg_24_0.previewTextItem_:IsComplete() then
		return
	end

	if arg_24_0.params_.onChangeFullLetter then
		arg_24_0.params_.onChangeFullLetter(arg_24_0.previewTextItem_:GetLetterInfo())
	end

	arg_24_0:Back()
end

function var_0_0.SetToggleIndex(arg_25_0, arg_25_1)
	arg_25_0.toggleIndex_ = arg_25_1
	arg_25_0.sentenceIdx_ = SpringPreheatData:GetSentenceIdx(arg_25_0.paragIdx_, arg_25_0.toggleIndex_)
	arg_25_0.textId_ = arg_25_0.previewTextItem_:GetLetterInfo()[arg_25_0.sentenceIdx_]
end

function var_0_0.GetActivityID(arg_26_0)
	return arg_26_0.params_.activityId
end

function var_0_0.IsStickerMode(arg_27_0)
	return arg_27_0.params_.isStickerMode
end

function var_0_0.GetTextIdList(arg_28_0, arg_28_1)
	local var_28_0 = SpringPreheatData:GetPlayerLetter()
	local var_28_1 = arg_28_0.paragIdx_

	return (SpringPreheatData:GetLetterOptionList(var_28_0.id, var_28_1, arg_28_1))
end

function var_0_0.GetAllSticker(arg_29_0)
	local var_29_0 = {}

	for iter_29_0, iter_29_1 in ipairs(PlayerData:GetStickerList()) do
		local var_29_1 = ItemCfg[iter_29_1]
		local var_29_2 = PlayerData:GetSticker(iter_29_1)

		if var_29_1.sub_type ~= 1302 or not var_29_2.lock then
			table.insert(var_29_0, var_29_2)
		end
	end

	table.sort(var_29_0, function(arg_30_0, arg_30_1)
		local var_30_0 = arg_29_0:IsUsed(arg_30_0.id)
		local var_30_1 = arg_29_0:IsUsed(arg_30_1.id)

		if var_30_0 and var_30_1 then
			return table.indexof(arg_29_0.stickerUsedList_, arg_30_0.id) < table.indexof(arg_29_0.stickerUsedList_, arg_30_1.id)
		elseif var_30_0 or var_30_1 then
			return var_30_0
		end

		if arg_30_0.unlock ~= arg_30_1.unlock then
			return arg_30_0.unlock > arg_30_1.unlock
		end

		return arg_30_0.id < arg_30_1.id
	end)

	return var_29_0
end

function var_0_0.IsUsed(arg_31_0, arg_31_1)
	for iter_31_0, iter_31_1 in ipairs(arg_31_0.stickerUsedList_) do
		if arg_31_1 == iter_31_1 then
			return true
		end
	end

	return false
end

return var_0_0
