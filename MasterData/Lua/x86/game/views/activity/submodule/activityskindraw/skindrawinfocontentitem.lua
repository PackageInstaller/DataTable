local SkinDrawInfoContentItem = class("SkinDrawInfoContentItem", ReduxView)

function SkinDrawInfoContentItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function SkinDrawInfoContentItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SkinDrawInfoContentItem:InitUI()
	self:BindCfgUI()

	self.item_ = {}
end

function SkinDrawInfoContentItem:AddUIListeners()
	return
end

function SkinDrawInfoContentItem:RefreshData(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self.data_ = arg_5_1
	self.isLast_ = arg_5_3
	self.activityID_ = arg_5_2
	self.mainActivityID_ = ActivityCfg.get_id_list_by_sub_activity_list[self.activityID_][1]
	self.isOath_ = arg_5_4.isOath
	self.checkPoolStage_ = arg_5_4.checkPoolStage
	self.poolID_ = arg_5_4.poolID

	self:RefreshUI()
end

function SkinDrawInfoContentItem:RefreshUI()
	self:RefreshContent()
	self:RefreshTitle()
	self:RefreshPool()
end

function SkinDrawInfoContentItem:RefreshTitle()
	SetActive(self.UpGo_, false)
	self:Show(true)

	self.labelTxt_.text = GetI18NText(self.data_.name)
	self.tips01.text = ""
	self.tips02.text = ""
end

function SkinDrawInfoContentItem:RefreshPool()
	if self.isOath_ then
		self:RefreshOathPool()
	else
		self:RefreshNormalPool()
	end
end

function SkinDrawInfoContentItem:GetSkinDrawPoolHasGift()
	if ActivityLimitedDrawPoolCfg[self.data_.list[1]] and ActivityLimitedDrawPoolCfg[self.data_.list[1]].reward[1] then
		if ActivitySkinDrawTools.GetIsSkinGift(ActivityLimitedDrawPoolCfg[self.data_.list[1]].reward[1][1]) then
			local var_9_0 = clone(self.data_.list)

			table.remove(var_9_0, 1)

			return var_9_0, true
		else
			return self.data_.list, false
		end
	end
end

function SkinDrawInfoContentItem:RefreshNormalPool()
	local var_10_0, var_10_1 = self:GetSkinDrawPoolHasGift()

	self:RefreshGiftItem(var_10_1, ActivitySkinDrawTools.GetDrawGiftItem(self.mainActivityID_))

	for iter_10_0 = 1, #var_10_0 do
		local var_10_2 = ActivityLimitedDrawPoolCfg[var_10_0[iter_10_0]]
		local var_10_3 = ActivitySkinDrawData:GetDrawInfo(self.activityID_, var_10_0[iter_10_0])

		self.item_[iter_10_0] = self.item_[iter_10_0] or SkinDrawInfoItem.New((Object.Instantiate(self.rewardItem_, self.contentTrs_2)))

		local var_10_4 = var_10_2.total

		self.item_[iter_10_0]:RefreshData(var_10_2.reward[1][1], var_10_2.reward[1][2], ((var_10_3 or nil) and (var_10_3.num or var_10_4)) .. "/" .. var_10_4)

		if self.checkPoolStage_ then
			self.item_[iter_10_0]:SetLock(var_10_2.pool_stage > self.checkPoolStage_)
		end
	end

	for iter_10_1 = #var_10_0 + 1, #self.item_ do
		self.item_[iter_10_1]:Show(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrs_)
end

function SkinDrawInfoContentItem:GetOathRewardData()
	local var_11_0, var_11_1 = ActivityOathDrawData:GetGiftID()

	if var_11_1 == self.data_.list[1] then
		local var_11_2 = clone(self.data_.list)

		table.remove(var_11_2, 1)

		return var_11_2, self.data_.list[1]
	else
		return self.data_.list, nil
	end
end

function SkinDrawInfoContentItem:RefreshOathPool()
	local var_12_0, var_12_1 = self:GetOathRewardData()

	self:RefreshGiftItem(var_12_1 ~= nil, OathDrawTools.GetDrawGiftItem(self.mainActivityID_))

	for iter_12_0 = 1, #var_12_0 do
		local var_12_2 = ActivityLimitedDrawPoolCfg[var_12_0[iter_12_0]]
		local var_12_3 = ActivityOathDrawData:GetDrawInfo(self.activityID_, var_12_0[iter_12_0])

		self.item_[iter_12_0] = self.item_[iter_12_0] or SkinDrawInfoItem.New((Object.Instantiate(self.rewardItem_, self.contentTrs_2)))

		local var_12_4 = var_12_2.total

		self.item_[iter_12_0]:RefreshData(var_12_2.reward[1][1], var_12_2.reward[1][2], ((var_12_3 or nil) and (var_12_3.num or var_12_4)) .. "/" .. var_12_4)
	end

	for iter_12_1 = #var_12_0 + 1, #self.item_ do
		self.item_[iter_12_1]:Show(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrs_)
end

function SkinDrawInfoContentItem:RefreshGiftItem(arg_13_1, arg_13_2)
	if arg_13_1 then
		if not self.giftItem or self.giftItemPath_ ~= arg_13_2 then
			self.giftItemPath_ = arg_13_2

			local var_13_0 = Object.Instantiate(Asset.Load(arg_13_2), self.contentTrs_2)

			self.giftItem = self.isOath_ and ActivityOathGiftItem.New(var_13_0) or ActivitySkinDrawGiftItem.New(var_13_0)
		end

		self.giftOccupyItem = self.giftOccupyItem or SkinDrawInfoItem.New((Object.Instantiate(self.rewardItem_, self.contentTrs_2)))

		local var_13_1 = self.data_.list[1]
		local var_13_2

		if self.isOath_ then
			var_13_2 = ActivityOathDrawData:GetDrawInfo(self.activityID_, var_13_1) or ActivitySkinDrawData:GetDrawInfo(self.activityID_, var_13_1)
		end

		local var_13_3 = ActivityLimitedDrawPoolCfg[var_13_1]
		local var_13_4 = ((var_13_2 or nil) and (var_13_2.num or var_13_3.total)) .. "/" .. var_13_3.total

		if self.isOath_ then
			self.giftItem:SetData(var_13_1, self.activityID_, var_13_4, self.poolID_, true)
		else
			self.giftItem:SetData(var_13_3.reward[1][1], var_13_3.reward[1][2], var_13_4, self.poolID_)
		end

		self.giftItem.transform_:SetAsFirstSibling()
		self.giftItem:Show(true)
		self.giftItem:SetInPopView(true)
		self.giftOccupyItem.transform_:SetAsFirstSibling()
		self.giftOccupyItem:RefreshOccupyData()
	else
		if self.giftItem then
			self.giftItem:Show(false)
			self.giftItem:SetInPopView(false)
		end

		if self.giftOccupyItem then
			self.giftOccupyItem:Show(false)
		end
	end
end

function SkinDrawInfoContentItem:RefreshContent()
	if self.isLast_ then
		self.contentTrs_2:GetComponent("GridLayoutGroup").padding.bottom = 20
	end
end

function SkinDrawInfoContentItem:Show(arg_15_1)
	SetActive(self.gameObject_, arg_15_1)
end

function SkinDrawInfoContentItem:OnExit()
	for iter_16_0 = 1, #self.item_ do
		self.item_[iter_16_0]:OnExit()
	end

	if self.giftItem then
		self.giftItem:Show(false)
	end

	if self.giftOccupyItem then
		self.giftOccupyItem:Show(false)
	end
end

function SkinDrawInfoContentItem:Dispose()
	self:RemoveAllListeners()

	for iter_17_0 = 1, #self.item_ do
		self.item_[iter_17_0]:Dispose()
	end

	self.giftItemPath_ = nil

	if self.giftItem then
		self.giftItem:Dispose()
	end

	if self.giftOccupyItem then
		self.giftOccupyItem:Dispose()
	end

	self.super.Dispose(self)
end

return SkinDrawInfoContentItem
