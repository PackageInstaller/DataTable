RewardPoolItem = import("game.views.common.RewardPoolItem")

local CultivateHeroPoolRewardItem = class("CultivateHeroPoolRewardItem", RewardPoolItem)

function CultivateHeroPoolRewardItem:OnCtor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	self.parentGo_ = Object.Instantiate(arg_1_2, arg_1_1.transform, arg_1_4)

	self:BindCfgUI(self.parentGo_)
	CultivateHeroPoolRewardItem.super.OnCtor(self, self.parentGo_, arg_1_3, arg_1_4, arg_1_5, arg_1_6)

	if self.receivedMarkGo_ then
		self.receivedMarkGo_.transform:SetAsLastSibling()
	end

	self.parentGo_.transform.localScale = Vector3.one
end

function CultivateHeroPoolRewardItem:SetParent()
	self.commonItemGo_.transform:SetParent(self.parentGo_.transform)
end

function CultivateHeroPoolRewardItem:SetData(arg_3_1, arg_3_2)
	CultivateHeroPoolRewardItem.super.SetData(self, arg_3_1, arg_3_2)
	self:RefreshText(arg_3_1.num)
end

function CultivateHeroPoolRewardItem:RefreshText(arg_4_1)
	self:ShowFloor(ItemConst.ITEM_FLOOR.BLACK)
	self.commonItem_:HideNum()

	self.cntText_.text = arg_4_1
end

function CultivateHeroPoolRewardItem:Dispose()
	self.commonItem_:ResetTransform()
	CultivateHeroPoolRewardItem.super.Dispose(self)
	Object.Destroy(self.parentGo_)

	self.parentGo_ = nil
end

function CultivateHeroPoolRewardItem:Show(arg_6_1)
	SetActive(self.parentGo_, arg_6_1)
	CultivateHeroPoolRewardItem.super.Show(self, arg_6_1)
end

function CultivateHeroPoolRewardItem:RefreshReceive(arg_7_1)
	SetActive(self.receivedMarkGo_, arg_7_1)
end

return CultivateHeroPoolRewardItem
