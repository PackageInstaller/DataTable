local ValentineGameV2RewardItem = class("ValentineGameV2RewardItem", ReduxView)

function ValentineGameV2RewardItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ValentineGameV2RewardItem:Init()
	self:InitUI()
end

function ValentineGameV2RewardItem:InitUI()
	self:BindCfgUI()

	self.commonItem_ = CommonItem.New(self.commonItemGo_)
end

function ValentineGameV2RewardItem:SetData(arg_4_1)
	self.commonItem_:RefreshData((rewardToItemTemplate(formatReward(arg_4_1))))
	self.commonItem_:RegistCallBack(function(arg_5_0)
		ShowPopItem(POP_ITEM, arg_5_0)
	end)
end

function ValentineGameV2RewardItem:Dispose()
	if self.commonItem_ then
		self.commonItem_:Dispose()

		self.commonItem_ = nil
	end

	ValentineGameV2RewardItem.super.Dispose(self)
end

return ValentineGameV2RewardItem
