local HanafudaGameOverPopView = class("HanafudaGameOverPopView", ReduxView)

function HanafudaGameOverPopView:UIName()
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionHanafudaUI/JapanRegionHanafudaWinUI"
end

function HanafudaGameOverPopView:UIParent()
	return manager.ui.uiPop.transform
end

function HanafudaGameOverPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function HanafudaGameOverPopView:InitUI()
	self:BindCfgUI()

	self.wincontroller_ = ControllerUtil.GetController(self.transform_, "result")
end

function HanafudaGameOverPopView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
end

function HanafudaGameOverPopView:OnEnter()
	self.callback_ = self.params_.callback
	self.playerScore = HanafudaData:GetScoreByType(HanafudaData.CARD_PLACE_TYPE.PLAYER)
	self.enemyScore = HanafudaData:GetScoreByType(HanafudaData.CARD_PLACE_TYPE.ENEMY)

	self:RefreshUI()
end

function HanafudaGameOverPopView:RefreshUI()
	self.rewardText_.text = math.max(0, (math.min(GameSetting.activity_kagutsuchi_fatigue_hanafuda_card_recover.value[1], GameSetting.activity_kagutsuchi_battle_fatigue_max.value[1] - KagutsuchiWorkData:GetStamina())))
	self.currencyImg_.sprite = ItemTools.getItemSprite(CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_FATIGUE.item_id)
	self.playerScoreText_.text = self.playerScore
	self.enemyScoreText_.text = self.enemyScore

	if self.playerScore >= self.enemyScore then
		SDKTools.SendMessageToSDK("activity_kagutsuchi_hanafuda_card", {
			result = 1,
			reach_group_id = table.toString(HanafudaData:GetPlayerCombineIDList()),
			activity_id = HanafudaData:GetActivityID()
		})
		manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_fish_win", "")
		self.wincontroller_:SetSelectedState("win")
	elseif self.playerScore < self.enemyScore then
		SDKTools.SendMessageToSDK("activity_kagutsuchi_hanafuda_card", {
			result = 2,
			reach_group_id = table.toString(HanafudaData:GetPlayerCombineIDList()),
			activity_id = HanafudaData:GetActivityID()
		})
		manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_fish_fail", "")
		self.wincontroller_:SetSelectedState("lose")
	end
end

function HanafudaGameOverPopView:OnExit()
	HanafudaData:ResetGameData()
	HanafudaData:ResetGameState()
	self.callback_()
end

function HanafudaGameOverPopView:Dispose()
	HanafudaGameOverPopView.super.Dispose(self)
end

return HanafudaGameOverPopView
