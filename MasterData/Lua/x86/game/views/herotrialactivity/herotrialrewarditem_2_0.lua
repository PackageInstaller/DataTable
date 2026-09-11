RewardPoolItem = import("game.views.common.RewardPoolItem")

local HeroTrialRewardItem_2_0 = class("HeroTrialRewardItem_2_0", RewardPoolItem)

function HeroTrialRewardItem_2_0:OnCtor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	self.parentGo_ = Object.Instantiate(arg_1_2, arg_1_1.transform, arg_1_4)

	self:BindCfgUI(self.parentGo_)
	HeroTrialRewardItem_2_0.super.OnCtor(self, arg_1_1, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	self.receivedMarkGo_.transform:SetAsLastSibling()
end

function HeroTrialRewardItem_2_0:SetParent()
	self.commonItemGo_.transform:SetParent(self.parentGo_.transform)
end

function HeroTrialRewardItem_2_0:SetData(arg_3_1, arg_3_2)
	HeroTrialRewardItem_2_0.super.SetData(self, arg_3_1, arg_3_2)
	self:RefreshText(arg_3_1.num)
end

function HeroTrialRewardItem_2_0:RefreshText(arg_4_1)
	self:ShowFloor(ItemConst.ITEM_FLOOR.BLACK)
	self.commonItem_:HideNum()

	self.cntText_.text = arg_4_1
end

function HeroTrialRewardItem_2_0:Dispose()
	self.commonItem_:ResetTransform()
	HeroTrialRewardItem_2_0.super.Dispose(self)
	Object.Destroy(self.parentGo_)

	self.parentGo_ = nil
end

function HeroTrialRewardItem_2_0:Show(arg_6_1)
	SetActive(self.parentGo_, arg_6_1)
	HeroTrialRewardItem_2_0.super.Show(self, arg_6_1)
end

function HeroTrialRewardItem_2_0:RefreshReceive(arg_7_1)
	SetActive(self.receivedMarkGo_, arg_7_1)
end

return HeroTrialRewardItem_2_0
