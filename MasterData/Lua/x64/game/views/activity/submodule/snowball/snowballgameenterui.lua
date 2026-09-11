local SnowballGameEnterUI = class("SnowballGameEnterUI", ReduxView)

function SnowballGameEnterUI:UIName()
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionSnowballUI/SnowballGameEnterUI"
end

function SnowballGameEnterUI:UIParent()
	return manager.ui.uiMain.transform
end

function SnowballGameEnterUI:Init()
	self:BindCfgUI()
	self:AddBtnListener(self.startBtn_, nil, handler(self, self.StartGame))

	self.modeController = ControllerUtil.GetController(self.transform_, "mode")
end

local var_0_1 = {
	"normal",
	"hard",
	"infinite"
}

function SnowballGameEnterUI:OnEnter()
	self.level = self.params_.level
	self.title_.text = SnowballGameCfg[self.level].level_desc
	self.levelTime_.text = GetTipsF("%d s", SnowballGameCfg[self.level].time_limit)

	self.modeController:SetSelectedState(var_0_1[SnowballGameCfg[self.level].level_mode])
end

function SnowballGameEnterUI:OnExit()
	manager.windowBar:HideBar()
end

function SnowballGameEnterUI:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function SnowballGameEnterUI:OnBehind()
	manager.windowBar:HideBar()
end

local function var_0_2(arg_8_0)
	local var_8_0 = {}

	var_8_0.playerEID = SnowballGameMgr.GetInstance():GetPlayerEID()
	var_8_0.level = arg_8_0

	gameContext:Go("/snowballGameControlUI", var_8_0, nil, true)
end

function SnowballGameEnterUI:StartGame()
	SnowballGameAction.EnterGameAction(self.level, var_0_2)
end

return SnowballGameEnterUI
