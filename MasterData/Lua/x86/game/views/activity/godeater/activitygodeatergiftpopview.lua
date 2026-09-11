local ActivityGodEaterGiftPopView = class("ActivityGodEaterGiftPopView", ReduxView)

function ActivityGodEaterGiftPopView:UIName()
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_Main/V4_2_GodEaterUI_GiftPopUI"
end

function ActivityGodEaterGiftPopView:UIParent()
	return manager.ui.uiPop.transform
end

function ActivityGodEaterGiftPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ActivityGodEaterGiftPopView:InitUI()
	self:BindCfgUI()

	self.controller_ = self.controllerEx_:GetController("isGet")
	self.rewardItems = {}

	for iter_4_0 = 0, self.displayRewards_.childCount - 1 do
		table.insert(self.rewardItems, CommonItemView.New(self.displayRewards_:GetChild(iter_4_0).gameObject, true))
	end
end

local function var_0_1(arg_5_0)
	ShowPopItem(POP_ITEM, arg_5_0)
end

function ActivityGodEaterGiftPopView:OnEnter()
	self.activityID_ = ActivityConst.ACTIVITY_GODEATER_HERO_GIFT
	self.giftID_ = ActivityPointRewardCfg.get_id_list_by_activity_id[self.activityID_][1]
	self.desText_.text = GetTips("ACTIVITY_GODEATER_HERO_GIFT_DES")

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrans_)
	self:RefreshUI()
end

function ActivityGodEaterGiftPopView:RefreshUI()
	local var_7_0 = GodEaterData:GetHeroGiftIsGet(self.giftID_)

	if var_7_0 then
		self.controller_:SetSelectedState("received")
	else
		self.controller_:SetSelectedState("receive")
	end

	local var_7_1 = ActivityPointRewardCfg[self.giftID_].reward_item_list

	for iter_7_0, iter_7_1 in ipairs(self.rewardItems) do
		local var_7_2 = rewardToItemTemplate((formatReward(var_7_1[iter_7_0])))

		var_7_2.animatorType = ItemConst.ITEM_ANIMATOR_TYPE.NULL
		var_7_2.grayFlag = var_7_0
		var_7_2.clickFun = var_0_1

		iter_7_1:SetData(var_7_2)
	end
end

function ActivityGodEaterGiftPopView:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if ActivityData:GetActivityIsOpen(self.activityID_) then
			if GodEaterData:GetHeroGiftIsGet(self.giftID_) then
				ShowTips("ACTIVITY_GODEATER_HERO_GIFT_IS_GET")
			else
				ActivityAction.ReceivePointRewardWithCallBack({
					self.giftID_
				}, function()
					manager.redPoint:setTip(RedPointConst.ACTIVITY_GODEATER_HERO_GIFT, 0)
					GodEaterData:SetHeroGiftIsGet(self.giftID_)
					self:RefreshUI()
				end)
			end
		else
			ShowTips("TIME_OVER")
		end
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListener(self.bgBtn2_, nil, function()
		JumpTools.Back()
	end)
end

function ActivityGodEaterGiftPopView:Dispose()
	for iter_13_0, iter_13_1 in ipairs(self.rewardItems) do
		iter_13_1:Dispose()
	end

	ActivityGodEaterGiftPopView.super.Dispose(self)
end

return ActivityGodEaterGiftPopView
