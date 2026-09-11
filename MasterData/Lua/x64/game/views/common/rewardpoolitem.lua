local RewardPoolItem = class("RewardPoolItem", ReduxView)

function RewardPoolItem:GetItemPath()
	if self.isSmall_ then
		return "UI/Common/CommonItemSmall"
	else
		return "UI/Common/CommonItem"
	end
end

function RewardPoolItem:OnCtor(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	self.isSmall_ = arg_2_3
	self.gameObject_ = arg_2_1
	self.transform_ = self.gameObject_.transform

	SetActive(self.gameObject_, true)

	self.commonItemGo_ = manager.objectPool:Get(self:GetItemPath())
	self.commonItem_ = CommonItem.New(self.commonItemGo_)

	self:SetParent()
	self.commonItem_:ResetTransform()

	self.clickCallback_ = arg_2_5
	self.popType_ = arg_2_4 or POP_ITEM

	self:ShowFloor(ItemConst.ITEM_FLOOR.LONG)

	if arg_2_2 then
		self:SetData(arg_2_2, true)
	end
end

function RewardPoolItem:SetParent()
	self.commonItemGo_.transform:SetParent(self.transform_)
end

function RewardPoolItem:SetData(arg_4_1, arg_4_2)
	local var_4_0 = rewardToItemTemplate(arg_4_1)

	self.commonItem_:RefreshData(var_4_0)
	self.commonItem_:RegistCallBack(function()
		if self.clickCallback_ == nil or self.clickCallback_() then
			ShowPopItem(self.popType_, var_4_0)
		end
	end)

	if arg_4_2 ~= false then
		arg_4_2 = arg_4_2 or self.commonItemGo_.activeSelf == false
	end

	self:Show(true)

	if arg_4_2 then
		self.commonItem_:UpdateAnimator()
	else
		self.commonItem_:StopAnimator()
	end
end

function RewardPoolItem:Show(arg_6_1)
	SetActive(self.commonItemGo_, arg_6_1)
end

function RewardPoolItem:HideNum()
	self.commonItem_:HideNum()
	self.commonItem_:HideServantTxt()
end

function RewardPoolItem:ShowFloor(arg_8_1)
	self.commonItem_:ShowFloor(arg_8_1)
end

function RewardPoolItem:HideServantTxt()
	self.commonItem_:HideServantTxt()
end

function RewardPoolItem:Dispose()
	self.commonItem_.mainAni_.speed = 1

	self.commonItem_:Dispose()

	self.commonItem_ = nil

	for iter_10_0, iter_10_1 in pairs(self.commonItemGo_:GetComponentsInChildren(typeof(Animator), true):ToTable()) do
		iter_10_1.enabled = true
	end

	for iter_10_2, iter_10_3 in pairs(self.commonItemGo_:GetComponentsInChildren(typeof(CanvasGroup), true):ToTable()) do
		iter_10_3.alpha = 1
	end

	manager.objectPool:Return(self:GetItemPath(), self.commonItemGo_)
	RewardPoolItem.super.Dispose(self)
end

function RewardPoolItem:SetSiblingIndex(arg_11_1)
	self.commonItem_:SetIndex(arg_11_1)
end

return RewardPoolItem
