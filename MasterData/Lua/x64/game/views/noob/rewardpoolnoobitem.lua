local RewardPoolNoobItem = class("RewardPoolNoobItem", (import("game.views.common.RewardPoolItem")))

function RewardPoolNoobItem:GetParentItemPath()
	return "UI/Activity/NewbieCommonItem"
end

function RewardPoolNoobItem:OnCtor(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
	self.parentGo_ = Object.Instantiate(arg_2_1 == nil and Asset.Load(self:GetParentItemPath()) or arg_2_1, arg_2_2.transform)

	self:BindCfgUI(self.parentGo_)
	RewardPoolNoobItem.super.OnCtor(self, self.parentGo_, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
end

function RewardPoolNoobItem:SetParent()
	self.commonItemGo_.transform:SetParent(self.parentGo_.transform)
end

function RewardPoolNoobItem:SetData(arg_4_1, arg_4_2)
	RewardPoolNoobItem.super.SetData(self, arg_4_1, arg_4_2)
	self:RefreshText(arg_4_1.num)
end

function RewardPoolNoobItem:RefreshText(arg_5_1)
	self:ShowFloor(ItemConst.ITEM_FLOOR.BLACK)
	self.commonItem_:HideNum()

	self.cntText_.text = arg_5_1
end

function RewardPoolNoobItem:Dispose()
	self.commonItem_:ResetTransform()
	RewardPoolNoobItem.super.Dispose(self)
	Object.Destroy(self.parentGo_)

	self.parentGo_ = nil
end

function RewardPoolNoobItem:Show(arg_7_1)
	SetActive(self.parentGo_, arg_7_1)
	RewardPoolNoobItem.super.Show(self, arg_7_1)
end

function RewardPoolNoobItem:SetTextColor(arg_8_1)
	self.cntText_.color = arg_8_1
end

return RewardPoolNoobItem
