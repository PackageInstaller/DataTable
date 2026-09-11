local SailGameSettlementView = class("SailGameSettlementView", ReduxView)

function SailGameSettlementView:UIName()
	return ""
end

function SailGameSettlementView:UIParent()
	return manager.ui.uiPop.transform
end

function SailGameSettlementView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SailGameSettlementView:InitUI()
	self:BindCfgUI()
end

function SailGameSettlementView:AddUIListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		JumpTools.OpenPageByJump("/sailMain", {
			activityID = self.activityID_
		})
	end)
end

function SailGameSettlementView:OnEnter()
	self.activityID_ = self.params_.activityID

	local var_7_0 = 0

	for iter_7_0, iter_7_1 in ipairs(SailGameData:GetCurGameData(self.activityID_).eventList) do
		var_7_0 = var_7_0 + iter_7_1.rewardNum
	end

	self.rewardNumText_.text = var_7_0
	self.rewardIcon_.sprite = ItemTools.getItemSprite(CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_SKADI_SEA_COIN.item_id)
end

return SailGameSettlementView
