local ChapterChallengeLnkItem = class("ChapterChallengeLnkItem", ReduxView)

function ChapterChallengeLnkItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.image_.immediate = true

	self:AddListeners()

	self.lockController_ = ControllerUtil.GetController(self.transform_, "lock")
	self.rewardItemList_ = {}

	for iter_1_0 = 1, 2 do
		self.rewardItemList_[iter_1_0] = CommonItemView.New(self["item" .. iter_1_0 .. "Go_"], true)
	end
end

function ChapterChallengeLnkItem:OnEnter()
	return
end

function ChapterChallengeLnkItem:OnExit()
	manager.redPoint:unbindUIandKey(self.transform_)
	self:StopTimer()
end

function ChapterChallengeLnkItem:Dispose()
	ChapterChallengeLnkItem.super.Dispose(self)

	for iter_4_0 = 1, 2 do
		if self.rewardItemList_[iter_4_0] then
			self.rewardItemList_[iter_4_0]:Dispose()

			self.rewardItemList_[iter_4_0] = nil
		end
	end

	self.gameObject_ = nil
	self.transform_ = nil
end

function ChapterChallengeLnkItem:SetData(arg_5_1)
	self.chapterClientID_ = arg_5_1
	self.isLock_ = JumpTools.GetLinkIsLocked(ChapterClientCfg[arg_5_1].jump_system)
	self.asset_pend_key = ChapterClientCfg[arg_5_1].asset_pend_key
	self.isAssetPendLock_ = not manager.assetPend:CheckAssetPend(self.asset_pend_key)
	self.image_.spriteAsync = SpritePathCfg.ChapterPaint.path .. ChapterClientCfg[arg_5_1].chapter_paint_2
	self.nameText_.text = ChapterClientCfg[arg_5_1].name

	self:RefreshLockState()
	self:RefreshRewardItem()
	self:AddTimer()
	manager.redPoint:bindUIandKey(self.transform_, ChapterTools.GetRedPoint(arg_5_1))
	self:Show(true)
end

function ChapterChallengeLnkItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if not self.isLock_ then
			SystemRedPoint:CancelNewTagByChapterId(self.chapterClientID_)
		end

		if self.isAssetPendLock_ then
			manager.assetPend:ShowAssetPendMessageBox(self.asset_pend_key)

			return
		end

		JumpTools.JumpToPage2(ChapterClientCfg[self.chapterClientID_].jump_system)
	end)
end

function ChapterChallengeLnkItem:AddTimer()
	self:StopTimer()
	self:RefreshTimeStamp(true)

	self.timer_ = Timer.New(function()
		self:RefreshTimeStamp()
	end, 1, -1)

	self.timer_:Start()
end

function ChapterChallengeLnkItem:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ChapterChallengeLnkItem:RefreshTimeStamp(arg_11_1)
	local var_11_0 = ChapterTools.GetChallengeNextRefreshTimeStamp(self.chapterClientID_)

	if arg_11_1 then
		if var_11_0 == 0 or self.isLock_ then
			SetActive(self.timeGo_, false)
		else
			SetActive(self.timeGo_, true)
		end
	end

	if var_11_0 ~= 0 then
		self.timeText_.text = manager.time:GetLostTimeStrWith2Unit(var_11_0, true)
	end
end

function ChapterChallengeLnkItem:RefreshLockState()
	if ChapterClientCfg[self.chapterClientID_ or 0] then
		self.asset_pend_key = ChapterClientCfg[self.chapterClientID_ or 0].asset_pend_key
		self.isAssetPendLock_ = not manager.assetPend:CheckAssetPend(self.asset_pend_key)
	end

	if self.isLock_ then
		self.lockController_:SetSelectedState("true")
	elseif self.isAssetPendLock_ then
		self.lockController_:SetSelectedState("assetpend")
	else
		self.lockController_:SetSelectedState("false")
	end
end

function ChapterChallengeLnkItem:RefreshRewardItem()
	if self.isLock_ then
		SetActive(self.itemRootGo_, false)
	else
		SetActive(self.itemRootGo_, true)

		local var_13_0 = ChapterTools.GetSystemRewardInfo(self.chapterClientID_)

		for iter_13_0 = 1, 2 do
			if var_13_0[iter_13_0] then
				local var_13_1 = clone(ItemTemplateData)

				var_13_1.id = var_13_0[iter_13_0]
				var_13_1.number = nil

				self.rewardItemList_[iter_13_0]:SetData(var_13_1)
			else
				self.rewardItemList_[iter_13_0]:SetData(nil)
			end
		end
	end
end

function ChapterChallengeLnkItem:Show(arg_14_1)
	SetActive(self.gameObject_, arg_14_1)
end

return ChapterChallengeLnkItem
