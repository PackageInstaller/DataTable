local ZumaGameSettleView = class("ZumaGameSettleView", ReduxView)
local var_0_1 = {
	progress = {
		noStar = "noStar",
		name = "Progress",
		star2 = "state3",
		star1 = "state2",
		star0 = "state1",
		star3 = "state4"
	},
	state = {
		lose = "state0",
		name = "state",
		win = "state1"
	},
	gameState = {
		haveReward = "state0",
		name = "default",
		noReward = "state2"
	}
}

function ZumaGameSettleView:UIName()
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ZumaUI/NorseUI_3_0_ZumaResultPopup"
end

function ZumaGameSettleView:UIParent()
	return manager.ui.uiPop.transform
end

function ZumaGameSettleView:OnTop()
	manager.windowBar:SwitchBar({})
end

function ZumaGameSettleView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ZumaGameSettleView:InitUI()
	self:BindCfgUI()

	self.progressController = self.controllerexcollection_:GetController(var_0_1.progress.name)
	self.stateController = self.controllerexcollection_:GetController(var_0_1.state.name)
	self.gameStateController = self.controllerexcollection_:GetController(var_0_1.gameState.name)
	self.iconImg_.sprite = ItemTools.getItemSprite(ZumaConst.TalentCostID)
end

function ZumaGameSettleView:AddUIListener()
	self:AddBtnListener(self.confirmbtnBtn_, nil, function()
		DestroyLua()
		LuaExchangeHelper.GoToMain()
	end)
end

function ZumaGameSettleView:OnEnter()
	self:RefreshUI()
end

function ZumaGameSettleView:OnExit()
	return
end

function ZumaGameSettleView:RefreshUI()
	local var_10_0 = self.params_.isWin or false

	self.stateController:SetSelectedState((var_10_0 or nil) and (var_0_1.state.win or var_0_1.state.lose))

	local var_10_1 = ZumaData:GetZumaScore()

	self.scoreTxt_.text = var_10_1

	if var_10_0 then
		self:RefreshWinUi()
		manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_enter", "")
		manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_dati_bingo", "")
	else
		manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_fail", "")
		manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_dati_error", "")
	end

	local var_10_2 = ZumaData:GetZumaGameId()

	ZumaAction.QueryZumaCompelet(ActivityZumaLevelCfg[var_10_2].main_activity_id, var_10_2, var_10_0 and 1 or 2, var_10_1, (ZumaToLuaBridge.GetZumaGamePlayTime()))
end

function ZumaGameSettleView:RefreshWinUi()
	local var_11_0 = ZumaData:GetZumaGameId()
	local var_11_1 = ActivityZumaLevelCfg[var_11_0]
	local var_11_2, var_11_3 = ZumaData:GetZumaFinishPointList(ZumaData:GetZumaScore(), ActivityZumaLevelCfg[var_11_0].activity_point_reward)
	local var_11_4 = ZumaData:GetZumaStageScore(var_11_0)
	local var_11_5, var_11_6 = ZumaData:GetZumaFinishPointList(var_11_4 or 0, ActivityZumaLevelCfg[var_11_0].activity_point_reward)
	local var_11_7 = math.max(var_11_3 - var_11_6, 0)

	if var_11_1.difficult == 3 then
		self.progressController:SetSelectedState(var_0_1.progress.noStar)
	elseif #var_11_2 == 0 then
		self.progressController:SetSelectedState(var_0_1.progress.star0)
	elseif #var_11_2 == 1 then
		self.progressController:SetSelectedState(var_0_1.progress.star1)
	elseif #var_11_2 == 2 then
		self.progressController:SetSelectedState(var_0_1.progress.star2)
	elseif #var_11_2 == 3 then
		self.progressController:SetSelectedState(var_0_1.progress.star3)
	end

	local var_11_8 = 0

	var_11_8 = var_11_4 == nil and var_11_1.first_reward + var_11_7 or var_11_1.repeat_reward + var_11_7

	if var_11_8 ~= 0 then
		self.gameStateController:SetSelectedState(var_0_1.gameState.haveReward)
	else
		self.gameStateController:SetSelectedState(var_0_1.gameState.noReward)
	end

	self.rewardNumsTxt_.text = var_11_8
end

function ZumaGameSettleView:Dispose()
	ZumaGameSettleView.super.Dispose(self)
end

return ZumaGameSettleView
