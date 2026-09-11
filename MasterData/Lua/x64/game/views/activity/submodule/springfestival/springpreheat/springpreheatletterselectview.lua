local SpringPreheatLetterSelectView = class("SpringPreheatLetterSelectView", ReduxView)

function SpringPreheatLetterSelectView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaWishingTree/IndiaWishingTreePopUI2"
end

function SpringPreheatLetterSelectView:UIParent()
	return manager.ui.uiPop.transform
end

function SpringPreheatLetterSelectView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.textItemList_ = LuaList.New(handler(self, self.IndexTextItem), self.textListGo_, SpringPreheatLetterSelectTextItem)
	self.stickerList_ = LuaList.New(handler(self, self.IndexStickerItem), self.stickerListGo_, SpringPreheatLetterSelectStickerItem)
	self.textToggleList_ = LuaList.New(handler(self, self.IndexTextToggle), self.textToggleListGo_, SpringPreheatLetterSelectTextToggleItem)
	self.previewTextItem_ = SpringPreheatLetterTextItem.New(self.previewTextGo_)

	self.previewTextItem_:SetPreviewMode(true)

	self.viewController_ = ControllerUtil.GetController(self.transform_, "view")
	self.btnController_ = ControllerUtil.GetController(self.transform_, "btn")
end

function SpringPreheatLetterSelectView:OnEnter()
	if self:IsStickerMode() then
		self.stickerUsedList_ = self.params_.usedList
		self.stickerIndex_ = self.params_.index
		self.oldStickerId_ = self.params_.info.stickerId
		self.oldStickerSize_ = self.params_.info.size
		self.allStickerList_ = self:GetAllSticker()
	else
		self.paragIdx_ = self.params_.paragIdx

		self.previewTextItem_:SetData(self.paragIdx_, nil, nil, true)

		if self.params_.letterInfo then
			self.previewTextItem_:SetLetterInfo(self.params_.letterInfo)
		end

		self.previewTextItem_:UpdateAnim(false)
		self:SetToggleIndex(self.params_.optionIdx or 1)
	end

	self.lastClickItem_ = nil
	self.lastClickToggle_ = nil

	self:RefreshUI()
end

function SpringPreheatLetterSelectView:OnTop()
	if not self:IsStickerMode() then
		if self.params_.updateAni then
			self.playPreviewTextAni_ = true
			self.params_.updateAni = false
		end

		self:SetToggleIndex(self.params_.optionIdx or 1)

		self.lastClickItem_ = nil
		self.lastClickToggle_ = nil

		self:RefreshUI()
	end
end

function SpringPreheatLetterSelectView:OnExit()
	if self.lastClickItem_ then
		self.lastClickItem_:SetSelected(false)
	end

	if self.lastClickToggle_ then
		self.lastClickToggle_:SetSelected(false)
		self.lastClickToggle_:RefreshUI()
	end

	self.playPreviewTextAni_ = false
end

function SpringPreheatLetterSelectView:Dispose()
	self.textItemList_:Dispose()
	self.textToggleList_:Dispose()
	self.stickerList_:Dispose()
	self.previewTextItem_:Dispose()
	SpringPreheatLetterSelectView.super.Dispose(self)
end

function SpringPreheatLetterSelectView:AddListeners()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.confirmBtn_, nil, function()
		self:OnClickOkBtn()
	end)
end

function SpringPreheatLetterSelectView:OnClickOkBtn()
	if self:IsStickerMode() then
		if self.params_.onChangeSticker and self.stickerId_ ~= self.oldStickerID_ then
			self.params_.onChangeSticker(self.stickerIndex_, self.stickerId_, self.oldStickerSize_)
		end

		self:Back()
	else
		self:OnClickChangeLetterBtn()
	end
end

function SpringPreheatLetterSelectView:IndexTextItem(arg_13_1, arg_13_2)
	local var_13_0 = self.previewTextItem_:GetLetterInfo()[self.sentenceIdx_]

	arg_13_2:SetLetterTextId((SpringPreheatData:GetLetterOptionText(SpringPreheatData:GetPlayerLetter().id, self.paragIdx_, self.sentenceIdx_, arg_13_1)))
	arg_13_2:SetClickHandler(handler(self, self.OnClickTextItem))

	if var_13_0 == arg_13_2.textId or var_13_0 == 0 and arg_13_1 == 1 and self.lastClickItem_ == nil then
		self.lastClickItem_ = arg_13_2
		self.textId_ = arg_13_2.textId

		arg_13_2:SetSelected(true)
		self:RefreshPreviewTextUI()
	end

	arg_13_2:SetSelected(self.textId_ == arg_13_2.textId)
	arg_13_2:RefreshUI()
end

function SpringPreheatLetterSelectView:OnClickTextItem(arg_14_1, arg_14_2)
	if self.lastClickItem_ and self.lastClickItem_ ~= arg_14_1 then
		self.lastClickItem_:SetSelected(false)
		self.lastClickItem_:RefreshUI()
	end

	arg_14_1:SetSelected(true)
	arg_14_1:RefreshUI()

	self.textId_ = arg_14_2
	self.lastClickItem_ = arg_14_1
	self.playPreviewTextAni_ = true

	self:RefreshPreviewTextUI()
end

function SpringPreheatLetterSelectView:IndexTextToggle(arg_15_1, arg_15_2)
	arg_15_2:SetIndex(arg_15_1)
	arg_15_2:SetClickHandler(handler(self, self.OnClickTextToggle))

	if arg_15_1 == self.toggleIndex_ and self.lastClickToggle_ == nil then
		self.lastClickToggle_ = arg_15_2

		self:SetToggleIndex(arg_15_1)
	end

	arg_15_2:SetSelected(arg_15_1 == self.toggleIndex_)
	arg_15_2:RefreshUI()
end

function SpringPreheatLetterSelectView:OnClickTextToggle(arg_16_1, arg_16_2)
	if self.lastClickToggle_ == arg_16_1 then
		return
	end

	if self.lastClickToggle_ then
		self.lastClickToggle_:SetSelected(false)
		self.lastClickToggle_:RefreshUI()
	end

	arg_16_1:SetSelected(true)
	arg_16_1:RefreshUI()
	self:SetToggleIndex(arg_16_2)

	self.lastClickToggle_ = arg_16_1

	if self.lastClickItem_ then
		self.lastClickItem_:SetSelected(false)

		self.lastClickItem_ = nil
	end

	self.playPreviewTextAni_ = true

	self:RefreshTextListUI()
end

function SpringPreheatLetterSelectView:IndexStickerItem(arg_17_1, arg_17_2)
	local var_17_0 = arg_17_1 == 1 and 0 or self.allStickerList_[arg_17_1 - 1].id

	arg_17_2:RefreshItem(arg_17_1 == 1 and 0 or self.allStickerList_[arg_17_1 - 1].id)

	if arg_17_1 == 1 and self.lastClickItem_ == nil then
		self.lastClickItem_ = arg_17_2
		self.stickerId_ = 0
	end

	if self.stickerId_ == var_17_0 then
		self.lastClickItem_ = arg_17_2
	end

	arg_17_2:SetUsed((self:IsUsed(var_17_0)))
	arg_17_2:SetSelected(var_17_0 == self.stickerId_)
	arg_17_2:RegisterClickListener(function()
		self:OnClickStickerItem(arg_17_2, var_17_0, arg_17_1)
	end)
end

function SpringPreheatLetterSelectView:OnClickStickerItem(arg_19_1, arg_19_2)
	if not arg_19_1:TrySelect() then
		ShowTips("SPRING_PREHEAT_STICKER_LOCKED")

		return
	end

	if self.lastClickItem_ and arg_19_1 ~= self.lastClickItem_ then
		self.lastClickItem_:SetSelected(false)
	end

	self.stickerId_ = arg_19_2
	self.lastClickItem_ = arg_19_1
end

function SpringPreheatLetterSelectView:RefreshUI()
	self.viewController_:SetSelectedState(self:IsStickerMode() and "sticker" or "text")

	if self:IsStickerMode() then
		self:RefreshStickersUI()
	else
		self.textToggleList_:StartScroll((SpringPreheatData:GetOptionCount(self.paragIdx_)))
		self.textToggleList_:Refresh()
		self:RefreshTextListUI()
		self:RefreshPreviewTextUI()

		self.titleText_.text = GetTips(string.format("SPRING_PREHEAT_WORD_TITLE_%d", self.paragIdx_))
	end
end

function SpringPreheatLetterSelectView:RefreshTextListUI()
	self.textItemList_:StartScroll(#self:GetTextIdList(self.sentenceIdx_))
	self.textItemList_:Refresh()
	self:RefreshPreviewTextUI()
end

function SpringPreheatLetterSelectView:RefreshStickersUI()
	self.stickerList_:StartScroll(#self.allStickerList_ + 1)

	self.titleText_.text = GetTips("SPRING_PREHEAT_STICKER_TITLE")
end

function SpringPreheatLetterSelectView:RefreshPreviewTextUI()
	if self.previewTextItem_:GetLetterInfo()[self.sentenceIdx_] ~= self.textId_ then
		if self.playPreviewTextAni_ then
			self.previewTextItem_:UpdateAnim(true, "IndiaWishingTreePopUI2_text")

			self.playPreviewTextAni_ = false
		end

		self.previewTextItem_:SetLetterInfo({
			[self.sentenceIdx_] = self.textId_
		})
		self.previewTextItem_:RefreshUI()
	end

	self.btnController_:SetSelectedState(self.previewTextItem_:IsComplete() and "yes" or "no")
end

function SpringPreheatLetterSelectView:OnClickChangeLetterBtn()
	if not self.previewTextItem_:IsComplete() then
		return
	end

	if self.params_.onChangeFullLetter then
		self.params_.onChangeFullLetter(self.previewTextItem_:GetLetterInfo())
	end

	self:Back()
end

function SpringPreheatLetterSelectView:SetToggleIndex(arg_25_1)
	self.toggleIndex_ = arg_25_1
	self.sentenceIdx_ = SpringPreheatData:GetSentenceIdx(self.paragIdx_, self.toggleIndex_)
	self.textId_ = self.previewTextItem_:GetLetterInfo()[self.sentenceIdx_]
end

function SpringPreheatLetterSelectView:GetActivityID()
	return self.params_.activityId
end

function SpringPreheatLetterSelectView:IsStickerMode()
	return self.params_.isStickerMode
end

function SpringPreheatLetterSelectView:GetTextIdList(arg_28_1)
	return (SpringPreheatData:GetLetterOptionList(SpringPreheatData:GetPlayerLetter().id, self.paragIdx_, arg_28_1))
end

function SpringPreheatLetterSelectView:GetAllSticker()
	local var_29_0 = {}

	for iter_29_0, iter_29_1 in ipairs(PlayerData:GetStickerList()) do
		local var_29_1 = PlayerData:GetSticker(iter_29_1)

		if ItemCfg[iter_29_1].sub_type ~= 1302 or not var_29_1.lock then
			table.insert(var_29_0, var_29_1)
		end
	end

	table.sort(var_29_0, function(arg_30_0, arg_30_1)
		local var_30_0 = self:IsUsed(arg_30_0.id)
		local var_30_1 = self:IsUsed(arg_30_1.id)

		if var_30_0 and var_30_1 then
			return table.indexof(self.stickerUsedList_, arg_30_0.id) < table.indexof(self.stickerUsedList_, arg_30_1.id)
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

function SpringPreheatLetterSelectView:IsUsed(arg_31_1)
	for iter_31_0, iter_31_1 in ipairs(self.stickerUsedList_) do
		if arg_31_1 == iter_31_1 then
			return true
		end
	end

	return false
end

return SpringPreheatLetterSelectView
