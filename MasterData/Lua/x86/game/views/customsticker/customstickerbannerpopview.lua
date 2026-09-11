local CustomStickerBannerPopView = class("CustomStickerBannerPopView", ReduxView)

function CustomStickerBannerPopView:UIName()
	return "Widget/System/UserInfor/sticker_new/StickerBannerUI"
end

function CustomStickerBannerPopView:UIParent()
	return manager.ui.uiPop.transform
end

function CustomStickerBannerPopView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function CustomStickerBannerPopView:InitUI()
	self:BindCfgUI()

	self.curSuitID_ = 0
	self.curDynamicBg_ = nil
	self.stPool_ = {}
	self.stTail_ = 1
	self.fgPool_ = {}
	self.fgTail_ = 1
	self.bgPool_ = {}
	self.bgTail_ = 1
end

function CustomStickerBannerPopView:AddUIListeners()
	self:AddBtnListener(self.jumpBtn_, nil, function()
		JumpTools.OpenPageByJump("/customStickerCollect", {
			suit = self.curSuitID_
		})
	end)
	self:AddBtnListener(self.retBtn_, nil, function()
		self:Back()
	end)
end

function CustomStickerBannerPopView:OnEnter()
	self.curSuitID_ = self.params_.suit or 30601

	self:UpdateView()
end

function CustomStickerBannerPopView:UpdateView()
	local var_9_0

	self.stTail_, self.fgTail_, self.bgTail_ = 1, 1, 1

	for iter_9_0, iter_9_1 in ipairs(StickerSuitCfg[self.curSuitID_].content) do
		if ProfileDecorateItemCfg[iter_9_1].item_type == 4 then
			var_9_0 = var_9_0 or ProfileDecorateItemCfg[iter_9_1]
			self.bgPool_[self.bgTail_] = self.bgPool_[self.bgTail_] or CustomStickerListItem.New((Object.Instantiate(self.bgGo_, self.rootTrs_)))

			self.bgPool_[self.bgTail_]:SetData(ProfileDecorateItemCfg[iter_9_1], false, false, true, false, PlayerData:GetStickerBg(iter_9_1).lock, nil)

			self.bgTail_ = self.bgTail_ + 1
		elseif ProfileDecorateItemCfg[iter_9_1].item_type == 5 then
			self.stPool_[self.stTail_] = self.stPool_[self.stTail_] or CustomStickerListItem.New((Object.Instantiate(self.stGo_, self.rootTrs_)))

			self.stPool_[self.stTail_]:SetData(ProfileDecorateItemCfg[iter_9_1], false, false, true, false, PlayerData:GetSticker(iter_9_1).lock, nil)

			self.stTail_ = self.stTail_ + 1
		elseif ProfileDecorateItemCfg[iter_9_1].item_type == 6 then
			self.fgPool_[self.fgTail_] = self.fgPool_[self.fgTail_] or CustomStickerListItem.New((Object.Instantiate(self.fgGo_, self.rootTrs_)))

			self.fgPool_[self.fgTail_]:SetData(ProfileDecorateItemCfg[iter_9_1], false, false, true, false, PlayerData:GetStickerFg(iter_9_1).lock, nil)

			self.fgTail_ = self.fgTail_ + 1
		end
	end

	self.titleText_.text = StickerSuitCfg[self.curSuitID_].name

	for iter_9_2 = #self.fgPool_, 1, -1 do
		if iter_9_2 >= self.fgTail_ then
			SetActive(self.fgPool_[iter_9_2].gameObject_, false)
		else
			SetActive(self.fgPool_[iter_9_2].gameObject_, true)
			self.fgPool_[iter_9_2].transform_:SetAsFirstSibling()
		end
	end

	for iter_9_3 = #self.bgPool_, 1, -1 do
		if iter_9_3 >= self.bgTail_ then
			SetActive(self.bgPool_[iter_9_3].gameObject_, false)
		else
			SetActive(self.bgPool_[iter_9_3].gameObject_, true)
			self.bgPool_[iter_9_3].transform_:SetAsFirstSibling()
		end
	end

	for iter_9_4 = 1, #self.stPool_ do
		if iter_9_4 >= self.stTail_ then
			SetActive(self.stPool_[iter_9_4].gameObject_, false)
		else
			SetActive(self.stPool_[iter_9_4].gameObject_, true)
			self.stPool_[iter_9_4].transform_:SetAsLastSibling()
		end
	end

	self:DestroyDynamicBg()

	self.bgStaticImg_.enabled = false

	if var_9_0 then
		if var_9_0.type == 1 then
			self.bgStaticImg_.spriteAsync = "TextureConfig/Sticker/Background_l/Stickerbg_l_" .. var_9_0.resource
			self.bgStaticImg_.enabled = true
		elseif var_9_0.type == 2 then
			self.curDynamicBg_ = Object.Instantiate(Asset.Load("Widget/System/UserInfor/sticker_new/dynamicitem/Bg/Bgitem_" .. var_9_0.resource), self.bgDynamicTrs_)
			self.bgStaticImg_.enabled = false
		end
	end
end

function CustomStickerBannerPopView:DestroyDynamicBg()
	if self.curDynamicBg_ then
		Object.Destroy(self.curDynamicBg_)

		self.curDynamicBg_ = nil
	end
end

function CustomStickerBannerPopView:OnExit()
	manager.windowBar:HideBar()
end

function CustomStickerBannerPopView:Dispose()
	self:DestroyDynamicBg()

	if self.bgList_ then
		self.bgList_:Dispose()

		self.bgList_ = nil
	end

	for iter_12_0 = 1, #self.fgPool_ do
		if self.fgPool[iter_12_0] then
			self.fgPool[iter_12_0]:Dispose()

			self.fgPool[iter_12_0] = nil
		end
	end

	for iter_12_1 = 1, #self.bgPool_ do
		if self.bgPool_[iter_12_1] then
			self.bgPool_[iter_12_1]:Dispose()

			self.bgPool_[iter_12_1] = nil
		end
	end

	for iter_12_2 = 1, #self.stPool_ do
		if self.stPool_[iter_12_2] then
			self.stPool_[iter_12_2]:Dispose()

			self.stPool_[iter_12_2] = nil
		end
	end

	CustomStickerBannerPopView.super.Dispose(self)
end

return CustomStickerBannerPopView
