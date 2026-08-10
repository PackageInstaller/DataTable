local var_0_0 = class("SnowballGameEnterUI", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionSnowballUI/SnowballGameEnterUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddBtnListener(arg_3_0.startBtn_, nil, handler(arg_3_0, arg_3_0.StartGame))

	arg_3_0.modeController = ControllerUtil.GetController(arg_3_0.transform_, "mode")
end

local var_0_1 = {
	"normal",
	"hard",
	"infinite"
}

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.level = arg_4_0.params_.level

	local var_4_0 = SnowballGameCfg[arg_4_0.level]

	arg_4_0.title_.text = var_4_0.level_desc
	arg_4_0.levelTime_.text = GetTipsF("%d s", var_4_0.time_limit)

	arg_4_0.modeController:SetSelectedState(var_0_1[var_4_0.level_mode])
end

function var_0_0.OnExit(arg_5_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnTop(arg_6_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnBehind(arg_7_0)
	manager.windowBar:HideBar()
end

local function var_0_2(arg_8_0)
	gameContext:Go("/snowballGameControlUI", {
		playerEID = SnowballGameMgr.GetInstance():GetPlayerEID(),
		level = arg_8_0
	}, nil, true)
end

function var_0_0.StartGame(arg_9_0)
	SnowballGameAction.EnterGameAction(arg_9_0.level, var_0_2)
end

return var_0_0
