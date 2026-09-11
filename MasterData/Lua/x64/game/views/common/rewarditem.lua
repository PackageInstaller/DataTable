local RewardItem = class("RewardItem", ReduxView)
local ItemTools = import("game.tools.ItemTools")

function RewardItem:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	if arg_1_3 then
		self.commonItem_ = manager.commonItemPool:Get(arg_1_2)
		self.gameObject_ = self.commonItem_.gameObject_
		self.transform_ = self.gameObject_.transform
	else
		self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
		self.transform_ = self.gameObject_.transform
		self.commonItem_ = CommonItem.New(self.gameObject_)
	end

	self.fromPool_ = arg_1_3

	self:Init()
end

function RewardItem:Init()
	self:InitUI()
	self:AddListeners()
end

function RewardItem:Dispose()
	self:RemoveListeners()

	if self.fromPool_ then
		self.commonItem_.mainAni_.speed = 1

		manager.commonItemPool:Release(self.commonItem_)
	else
		self.commonItem_:Dispose()
		Object.Destroy(self.gameObject_)

		self.gameObject_ = nil
	end

	RewardItem.super.Dispose(self)
end

function RewardItem:InitUI()
	return
end

function RewardItem:AddListeners()
	return
end

function RewardItem:RemoveListeners()
	return
end

function RewardItem:SetData(arg_7_1)
	self.commonItem_:RefreshData((rewardToItemTemplate(formatReward(arg_7_1))))
	self.commonItem_:RegistCallBack(function(arg_8_0)
		ShowPopItem(POP_ITEM, arg_8_0)
		OperationRecorder.Record(self.class.__cname, "open_pop_item")
	end)
	self.commonItem_:SetSelectType("equip")
	SetActive(self.gameObject_, true)
end

function RewardItem:UpdateCommonItemAni()
	self.commonItem_:UpdateAnimator()
end

function RewardItem:Show(arg_10_1)
	SetActive(self.gameObject_, arg_10_1)
end

function RewardItem:ShowSelect(arg_11_1)
	self.commonItem_:ShowSelect(arg_11_1 and 1 or 0)
end

return RewardItem
