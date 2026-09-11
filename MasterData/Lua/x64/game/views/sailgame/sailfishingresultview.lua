local SailFishingResultView = class("SailFishingResultView", ReduxView)

function SailFishingResultView:UIName()
	return "UI/VersionUI/XuHeng3rdUI/XH3rdVoyagesUI/XH3rdFishingSettlementUI"
end

function SailFishingResultView:UIParent()
	return manager.ui.uiPop.transform
end

function SailFishingResultView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SailFishingResultView:InitUI()
	self:BindCfgUI()
end

function SailFishingResultView:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		SailGameTools.GoToGameView(self.activityID_)
	end)
end

function SailFishingResultView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.score_ = self.params_.score

	self:RefreshUI()
end

function SailFishingResultView:RefreshUI()
	for iter_8_0 = #ActivityPointRewardCfg.get_id_list_by_activity_id[self.activityID_], 1, -1 do
		if ActivityPointRewardCfg[ActivityPointRewardCfg.get_id_list_by_activity_id[self.activityID_][iter_8_0]].need <= self.score_ then
			self.rewardCfg_ = ActivityPointRewardCfg[ActivityPointRewardCfg.get_id_list_by_activity_id[self.activityID_][iter_8_0]].reward_item_list[1]

			break
		end
	end

	self.scoreText_.text = self.score_

	local var_8_0 = ItemTools.getItemSprite(self.rewardCfg_[1])

	if var_8_0 then
		self.rewardIcon_.sprite = var_8_0
	end

	self.rewardNumText_.text = self.rewardCfg_[2]
end

return SailFishingResultView
