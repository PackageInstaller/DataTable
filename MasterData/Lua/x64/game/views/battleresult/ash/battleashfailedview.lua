local BattleAshFailedView = class("BattleAshFailedView", ReduxView)

function BattleAshFailedView:UIName()
	return "Widget/System/Activity_EkChuah/EkChuah_BattleUI/EkChuah_BattleLoseUI"
end

function BattleAshFailedView:UIParent()
	return manager.ui.uiMain.transform
end

function BattleAshFailedView:Init()
	self:InitUI()
	self:AddListener()
end

function BattleAshFailedView:InitUI()
	self:BindCfgUI()
end

function BattleAshFailedView:AddListener()
	self:AddBtnListener(self.cancelBtn_, nil, function()
		self:OnCancelClick()
	end)
	self:AddBtnListener(self.confirmBrn_, nil, function()
		self:OnRestartClick()
	end)
end

function BattleAshFailedView:GetBattleTime()
	return manager.time:DescCdTime2(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
end

function BattleAshFailedView:OnEnter()
	BattleInstance.hideBattlePanel()

	self.timeTxt_.text = self:GetBattleTime()
	self.stageTxt_.text = BattleAshShootStageCfg[AshShootStageCfg[AshSystemAction:GetLastBattleData().stageId].stage_id].name
end

function BattleAshFailedView:OnRestartClick()
	LuaExchangeHelper.GameOver(2, CustomLoadingConst.ASHGAME_Loading)
	BattleController.GetInstance():LaunchBattle(self.params_.stageData, nil, nil, true)
	LuaForCursor.SwitchCursor(false)
end

function BattleAshFailedView:OnCancelClick()
	BattleInstance.QuitBattle(self.params_.stageData, true, true)
end

return BattleAshFailedView
