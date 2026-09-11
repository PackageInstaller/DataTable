RewardPoolItem = import("game.views.common.RewardPoolItem")

local HeroTrialRewardItem_1_7 = class("HeroTrialRewardItem_1_7", RewardPoolItem)

function HeroTrialRewardItem_1_7:OnCtor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	self.parentGo_ = Object.Instantiate(arg_1_2, arg_1_1.transform)

	self:BindCfgUI(self.parentGo_)
	HeroTrialRewardItem_1_7.super.OnCtor(self, arg_1_1, arg_1_3, arg_1_4, arg_1_5, arg_1_6)

	if arg_1_4 then
		self.commonItem_:SetScale(Vector3(0.55, 0.569, 1))
	end

	self.receivedMarkGo_.transform:SetAsLastSibling()
end

function HeroTrialRewardItem_1_7:SetParent()
	self.commonItemGo_.transform:SetParent(self.parentGo_.transform)
end

function HeroTrialRewardItem_1_7:SetData(arg_3_1, arg_3_2)
	HeroTrialRewardItem_1_7.super.SetData(self, arg_3_1, arg_3_2)
	self:RefreshText(arg_3_1.num)
end

function HeroTrialRewardItem_1_7:RefreshText(arg_4_1)
	self:ShowFloor(ItemConst.ITEM_FLOOR.BLACK)
	self.commonItem_:HideNum()

	self.cntText_.text = arg_4_1
end

function HeroTrialRewardItem_1_7:Dispose()
	self.commonItem_:ResetTransform()
	HeroTrialRewardItem_1_7.super.Dispose(self)
	Object.Destroy(self.parentGo_)

	self.parentGo_ = nil
end

function HeroTrialRewardItem_1_7:Show(arg_6_1)
	SetActive(self.parentGo_, arg_6_1)
	HeroTrialRewardItem_1_7.super.Show(self, arg_6_1)
end

function HeroTrialRewardItem_1_7:RefreshReceive(arg_7_1)
	SetActive(self.receivedMarkGo_, arg_7_1)
end

return HeroTrialRewardItem_1_7
