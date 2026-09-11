local CustomStickerCollectSuitItem = class("CustomStickerCollectSuitItem", ReduxView)

function CustomStickerCollectSuitItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CustomStickerCollectSuitItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function CustomStickerCollectSuitItem:InitUI()
	self:BindCfgUI()

	self.stPool_ = {}
	self.stTail_ = 1
	self.fgPool_ = {}
	self.fgTail_ = 1
	self.bgPool_ = {}
	self.bgTail_ = 1
	self.rewardState_ = "lock"
	self.rewardController_ = self.mainControllerEx_:GetController("reward")
end

function CustomStickerCollectSuitItem:AddUIListener()
	self:AddBtnListener(self.viewBtn_, nil, function()
		JumpTools.OpenPageByJump("customStickerPreviewPop", {
			suit = true,
			cfg = StickerSuitCfg[self.suitID_]
		})
	end)
	self:AddBtnListener(self.rewardBtn_, nil, function()
		if self.rewardState_ == "unlock" then
			PlayerAction.RequestToRewardStickerSuit(self.suitID_)

			self.rewardState_ = "rewarded"

			self.rewardController_:SetSelectedState(self.rewardState_)
		else
			local var_6_0 = {}

			var_6_0.rewardList = StickerSuitCfg[self.suitID_].reward

			JumpTools.OpenPageByJump("rewardPreview", var_6_0, ViewConst.SYSTEM_ID.REWARD_PREVIEW)
		end
	end)
end

function CustomStickerCollectSuitItem:SetData(arg_7_1)
	self.suitID_ = arg_7_1
	self.stTail_, self.fgTail_, self.bgTail_ = 1, 1, 1

	local var_7_0 = 0

	for iter_7_0, iter_7_1 in ipairs(StickerSuitCfg[arg_7_1].content) do
		local var_7_1 = ProfileDecorateItemCfg[iter_7_1]

		if ProfileDecorateItemCfg[iter_7_1].item_type == 4 then
			self.bgPool_[self.bgTail_] = self.bgPool_[self.bgTail_] or CustomStickerListItem.New((Object.Instantiate(self.bgGo_, self.rootTrs_)))

			local var_7_2 = PlayerData:GetStickerBg(iter_7_1).lock

			self.bgPool_[self.bgTail_]:SetData(ProfileDecorateItemCfg[iter_7_1], false, false, true, var_7_2, false, function()
				JumpTools.OpenPageByJump("customStickerCollectPop", {
					stickerID = var_7_1.id
				})
			end, true)

			self.bgTail_ = self.bgTail_ + 1

			if not var_7_2 then
				var_7_0 = var_7_0 + 1
			end
		elseif ProfileDecorateItemCfg[iter_7_1].item_type == 5 then
			self.stPool_[self.stTail_] = self.stPool_[self.stTail_] or CustomStickerListItem.New((Object.Instantiate(self.stGo_, self.rootTrs_)))

			local var_7_3 = PlayerData:GetSticker(iter_7_1).lock

			self.stPool_[self.stTail_]:SetData(ProfileDecorateItemCfg[iter_7_1], false, false, true, var_7_3, false, function()
				JumpTools.OpenPageByJump("customStickerCollectPop", {
					stickerID = var_7_1.id
				})
			end, true)

			self.stTail_ = self.stTail_ + 1

			if not var_7_3 then
				var_7_0 = var_7_0 + 1
			end
		elseif ProfileDecorateItemCfg[iter_7_1].item_type == 6 then
			self.fgPool_[self.fgTail_] = self.fgPool_[self.fgTail_] or CustomStickerListItem.New((Object.Instantiate(self.fgGo_, self.rootTrs_)))

			local var_7_4 = PlayerData:GetStickerFg(iter_7_1).lock

			self.fgPool_[self.fgTail_]:SetData(ProfileDecorateItemCfg[iter_7_1], false, false, true, var_7_4, false, function()
				JumpTools.OpenPageByJump("customStickerCollectPop", {
					stickerID = var_7_1.id
				})
			end, true)

			self.fgTail_ = self.fgTail_ + 1

			if not var_7_4 then
				var_7_0 = var_7_0 + 1
			end
		end
	end

	self.titleImg_.spriteAsync = "TextureConfig/Sticker/Suit_l/Suit_l_" .. StickerSuitCfg[arg_7_1].resource
	self.titleText_.text = StickerSuitCfg[arg_7_1].name
	self.suitNumText_.text = var_7_0 .. "/" .. #StickerSuitCfg[arg_7_1].content

	self.rootTrs_:SetAnchoredPositionX(0)

	self.rewardState_ = PlayerData:CheckStickerSuitReward(self.suitID_) and "rewarded" or #StickerSuitCfg[arg_7_1].content <= var_7_0 and "unlock" or "lock"

	self.rewardController_:SetSelectedState(self.rewardState_)

	for iter_7_2 = #self.fgPool_, 1, -1 do
		if iter_7_2 >= self.fgTail_ then
			SetActive(self.fgPool_[iter_7_2].gameObject_, false)
		else
			SetActive(self.fgPool_[iter_7_2].gameObject_, true)
			self.fgPool_[iter_7_2].transform_:SetAsFirstSibling()
		end
	end

	for iter_7_3 = #self.bgPool_, 1, -1 do
		if iter_7_3 >= self.bgTail_ then
			SetActive(self.bgPool_[iter_7_3].gameObject_, false)
		else
			SetActive(self.bgPool_[iter_7_3].gameObject_, true)
			self.bgPool_[iter_7_3].transform_:SetAsFirstSibling()
		end
	end

	for iter_7_4 = 1, #self.stPool_ do
		if iter_7_4 >= self.stTail_ then
			SetActive(self.stPool_[iter_7_4].gameObject_, false)
		else
			SetActive(self.stPool_[iter_7_4].gameObject_, true)
			self.stPool_[iter_7_4].transform_:SetAsLastSibling()
		end
	end
end

function CustomStickerCollectSuitItem:Dispose()
	CustomStickerCollectSuitItem.super.Dispose(self)

	for iter_11_0 = 1, #self.fgPool_ do
		if self.fgPool_[iter_11_0] then
			self.fgPool_[iter_11_0]:Dispose()

			self.fgPool_[iter_11_0] = nil
		end
	end

	for iter_11_1 = 1, #self.bgPool_ do
		if self.bgPool_[iter_11_1] then
			self.bgPool_[iter_11_1]:Dispose()

			self.bgPool_[iter_11_1] = nil
		end
	end

	for iter_11_2 = 1, #self.stPool_ do
		if self.stPool_[iter_11_2] then
			self.stPool_[iter_11_2]:Dispose()

			self.stPool_[iter_11_2] = nil
		end
	end
end

return CustomStickerCollectSuitItem
