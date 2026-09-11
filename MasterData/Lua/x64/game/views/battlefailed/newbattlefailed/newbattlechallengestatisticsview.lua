local NewBattleChallengeStatisticsView = class("NewBattleChallengeStatisticsView", ReduxView)

function NewBattleChallengeStatisticsView:UIName()
	return "Widget/System/BattleResult/BattleFailed/BattleChallengeStatisticsUI"
end

function NewBattleChallengeStatisticsView:UIParent()
	return manager.ui.uiPop.transform
end

function NewBattleChallengeStatisticsView:Init()
	self:InitUI()
	self:AddUIListener()
end

function NewBattleChallengeStatisticsView:InitUI()
	self:BindCfgUI()

	self.toggles_ = {
		self.lvBtn_,
		self.equipBtn_,
		self.transitionBtn_
	}
	self.items_ = {
		NewBattleChallengeStatisticsItem.New(self.itemGo1_),
		NewBattleChallengeStatisticsItem.New(self.itemGo2_),
		NewBattleChallengeStatisticsItem.New(self.itemGo3_)
	}
end

function NewBattleChallengeStatisticsView:AddUIListener()
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:Back()
	end)

	for iter_5_0, iter_5_1 in ipairs(self.toggles_) do
		self:AddToggleListener(iter_5_1, function(arg_7_0)
			if arg_7_0 then
				self:Refresh(iter_5_0)

				local var_7_0 = BattleFieldData:GetServerBattleID() or 0

				SDKTools.SendMessageToSDK("combat_over_lose_recomme_detail_", {
					battle_id_str = var_7_0,
					direction_type = iter_5_0
				})
			end
		end)
	end
end

function NewBattleChallengeStatisticsView:OnEnter()
	self.index = self.params_.index
	self.stageData_ = self.params_.stageData
	self.heroList_ = self.stageData_.heroList_

	self:RefreshBtn()
	self:Refresh(self.index)
end

function NewBattleChallengeStatisticsView:Refresh(arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(self.heroList_) do
		self.items_[iter_9_0]:SetData(arg_9_1, iter_9_1)
	end

	self.toggles_[arg_9_1].isOn = true
end

function NewBattleChallengeStatisticsView:RefreshBtn()
	self.userData = PlayerData:GetPlayerInfo()

	if self.userData.userLevel >= 60 then
		SetActive(self.transitionBtn_.gameObject, true)
	elseif self.userData.userLevel >= 20 and self.userData.userLevel < 60 then
		SetActive(self.transitionBtn_.gameObject, false)
		SetActive(self.equipBtn_.gameObject, true)
	elseif self.userData.userLevel < 20 then
		SetActive(self.equipBtn_.gameObject, false)
	end
end

function NewBattleChallengeStatisticsView:OnExit()
	return
end

function NewBattleChallengeStatisticsView:Dispose()
	for iter_12_0 = 1, #self.items_ do
		self.items_[iter_12_0]:Dispose()
	end

	NewBattleChallengeStatisticsView.super.Dispose(self)
end

return NewBattleChallengeStatisticsView
