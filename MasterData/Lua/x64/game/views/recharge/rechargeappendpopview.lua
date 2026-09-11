local RechargeAppendPopView = class("RechargeAppendPopView", ReduxView)

function RechargeAppendPopView:UIName()
	return "Widget/System/Recharge/items/RechargeTotalRechargePopUI"
end

function RechargeAppendPopView:UIParent()
	return manager.ui.uiPop.transform
end

function RechargeAppendPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RechargeAppendPopView:InitUI()
	self:BindCfgUI()

	self.rewardList_ = LuaList.New(handler(self, self.IndexItem), self.itemListGo_, CommonItemView)
end

function RechargeAppendPopView:IndexItem(arg_5_1, arg_5_2)
	local var_5_0 = clone(ItemTemplateData)

	var_5_0.id = self.rewardDataList_[arg_5_1].id
	var_5_0.number = self.rewardDataList_[arg_5_1].num

	function var_5_0.clickFun()
		ShowPopItem(POP_ITEM, {
			var_5_0.id,
			var_5_0.number
		})
	end

	arg_5_2:SetData(var_5_0)
end

function RechargeAppendPopView:AddUIListener()
	self:AddBtnListener(self.btnConfirm_, nil, function()
		PayAction.GetTotalRechargeBonus(self.params_.appendRewardIdList, true)
		self:Back()
	end)
end

function RechargeAppendPopView:OnEnter()
	self.rewardDataList_ = mergeReward(formatRewardCfgList(self.params_.appendRewardList))

	self.rewardList_:StartScroll(#self.rewardDataList_)

	self.descText_.text = GetTips("VERSION_RECHARGE_POP_TIPS")
end

function RechargeAppendPopView:Dispose()
	if self.rewardList_ then
		self.rewardList_:Dispose()
	end

	RechargeAppendPopView.super.Dispose(self)
end

return RechargeAppendPopView
