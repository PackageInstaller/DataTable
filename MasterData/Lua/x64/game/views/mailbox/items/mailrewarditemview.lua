local MailRewardItemView = class("MailRewardItemView", ReduxView)

function MailRewardItemView:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.onResize_ = arg_1_2

	self:InitUI()

	self.rewardItemList_ = {}
end

function MailRewardItemView:Dispose()
	for iter_2_0 = #self.rewardItemList_, 1, -1 do
		self.rewardItemList_[iter_2_0]:Dispose()

		self.rewardItemList_[iter_2_0] = nil
	end

	self.rewardItemList_ = nil

	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil

	MailRewardItemView.super.Dispose(self)
end

function MailRewardItemView:InitUI()
	self.item_ = self:FindGo("CommonItem")
end

function MailRewardItemView:SetData(arg_4_1)
	self.data_ = arg_4_1

	self:RefreshUI()
end

function MailRewardItemView:RefreshUI()
	for iter_5_0, iter_5_1 in ipairs(self.data_.reward_item) do
		if self.rewardItemList_[iter_5_0] == nil then
			self.rewardItemList_[iter_5_0] = RewardItem.New(self.item_, self.gameObject_)

			self.rewardItemList_[iter_5_0]:UpdateCommonItemAni()
		end

		self.rewardItemList_[iter_5_0]:SetData({
			iter_5_1.id,
			iter_5_1.num
		})
	end

	SetActive(self.gameObject_, true)

	if self.onResize_ ~= nil then
		self.onResize_()
	end
end

function MailRewardItemView:GetHeight()
	return self.transform_.rect.height
end

return MailRewardItemView
