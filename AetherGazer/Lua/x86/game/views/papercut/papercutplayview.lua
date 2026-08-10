local var_0_0 = class("PaperCutPlayView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/EmptyDream/PaperCut/PaperCutPlayUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.statusController_ = ControllerUtil.GetController(arg_4_0.transform_, "status")
end

function var_0_0.OnEnter(arg_5_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		PaperCutTool:GameOver()
		arg_5_0:Back()
	end)
	manager.windowBar:RegistHomeCallBack(function()
		PaperCutTool:GameOver()

		if arg_5_0.params_.goHomeHandler ~= nil then
			arg_5_0.params_.goHomeHandler()
		end
	end)
	arg_5_0.statusController_:SetSelectedState("prepare")

	arg_5_0.activityID_ = arg_5_0.params_.activityID
	arg_5_0.titleText_.text = GetI18NText(PaperCutCfg[arg_5_0.activityID_].name)

	PaperCutTool:RegisterCompleteHandler(handler(arg_5_0, arg_5_0.OnCompleted))
	PaperCutTool:RegisterStartDrawHandler(handler(arg_5_0, arg_5_0.OnStartDraw))
end

function var_0_0.OnCompleted(arg_8_0)
	JumpTools.OpenPageByJump("paperCutResult", {
		activityID = arg_8_0.activityID_
	})
end

function var_0_0.OnStartDraw(arg_9_0)
	manager.windowBar:HideBar()
	arg_9_0.statusController_:SetSelectedState("playing")
end

function var_0_0.OnExit(arg_10_0)
	manager.windowBar:HideBar()
end

return var_0_0
