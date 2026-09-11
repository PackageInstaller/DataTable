RewardPoolItem = import("game.views.common.RewardPoolItem")

local RewardPoolFactoryItem = class("RewardPoolFactoryItem", RewardPoolItem)

function RewardPoolFactoryItem:GetParentItemPath()
	return "UI/MardukUI/MardukCommonItem"
end

function RewardPoolFactoryItem:GetItemPath()
	return "UI/Common/CommonItem"
end

function RewardPoolFactoryItem:OnCtor(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	self.parentGo_ = Object.Instantiate(Asset.Load(self:GetParentItemPath()), arg_3_1.transform)

	self:BindCfgUI(self.parentGo_)
	RewardPoolFactoryItem.super.OnCtor(self, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)

	if arg_3_3 then
		self.commonItem_:SetScale(Vector3(0.55, 0.569, 1))
	end
end

function RewardPoolFactoryItem:SetParent()
	self.commonItemGo_.transform:SetParent(self.parentGo_.transform)
end

function RewardPoolFactoryItem:SetData(arg_5_1, arg_5_2)
	RewardPoolFactoryItem.super.SetData(self, arg_5_1, arg_5_2)
	self:RefreshText(arg_5_1[2])
end

function RewardPoolFactoryItem:RefreshText(arg_6_1)
	self:ShowFloor(ItemConst.ITEM_FLOOR.BLACK)
	self.commonItem_:HideNum()

	self.num_.text = arg_6_1
end

function RewardPoolFactoryItem:Dispose()
	self.commonItem_:ResetTransform()
	RewardPoolFactoryItem.super.Dispose(self)
	Object.Destroy(self.parentGo_)

	self.parentGo_ = nil
end

function RewardPoolFactoryItem:Show(arg_8_1)
	SetActive(self.parentGo_, arg_8_1)
	RewardPoolFactoryItem.super.Show(self, arg_8_1)
end

return RewardPoolFactoryItem
