local SpringWelfareTaskRewardItem = class("SpringWelfareTaskRewardItem", ReduxView)
local ItemTools = import("game.tools.ItemTools")

function SpringWelfareTaskRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	SetActive(self.gameObject_, true)
	self:Init()
end

function SpringWelfareTaskRewardItem:Init()
	self:InitUI()
	self:AddListeners()

	self.commonItem_ = CommonItem.New(self.gameObject_)
end

function SpringWelfareTaskRewardItem:Dispose()
	self.commonItem_:Dispose()
	SpringWelfareTaskRewardItem.super.Dispose(self)
end

function SpringWelfareTaskRewardItem:InitUI()
	return
end

function SpringWelfareTaskRewardItem:AddListeners()
	return
end

function SpringWelfareTaskRewardItem:SetData(arg_6_1)
	self.commonItem_:RefreshData(formatReward(arg_6_1))
	self.commonItem_:RegistCallBack(function()
		ShowPopItem(POP_ITEM, arg_6_1)
	end)
	SetActive(self.gameObject_, true)
end

function SpringWelfareTaskRewardItem:UpdateCommonItemAni()
	self.commonItem_:UpdateAnimator()
end

function SpringWelfareTaskRewardItem:Show(arg_9_1)
	SetActive(self.gameObject_, arg_9_1)
end

function SpringWelfareTaskRewardItem:ShowSelect(arg_10_1)
	self.commonItem_:ShowSelect(arg_10_1 and 1 or 0)
end

return SpringWelfareTaskRewardItem
