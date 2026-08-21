local var_0_0 = class("CaptureActivityMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/SummerUI_3_4/SummerUI_3_4_CaptureUI/Main/SummerUI_3_4_CaptureModeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.BuildContext(arg_4_0)
	arg_4_0.staticContext = {
		isInFreeCapture = false,
		freeTabController = arg_4_0.controller_:GetController("default5"),
		freeBtnController = arg_4_0.controller_:GetController("default2"),
		completeTabController = arg_4_0.controller_:GetController("default0"),
		lockPictureController = arg_4_0.controller_:GetController("default4")
	}
	arg_4_0.runtimeContext = {
		id = -1,
		mainStageId = -1,
		taskList = {},
		gameMode = CaptureGameConst.CaptureGameMode.Single
	}
	arg_4_0.scrollHelper = LuaList.New(handler(arg_4_0, arg_4_0.RenderItem), arg_4_0.taskListObj_, CaptureSectionTaskModule)
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
	arg_5_0:BuildContext()
	arg_5_0:AddListener()
end

function var_0_0.AddListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.captureBtn_, nil, function()
		arg_6_0:OnCaptureClick()
	end)
	arg_6_0:AddBtnListener(arg_6_0.normalBtn_, nil, function()
		arg_6_0:OnNormalBtnClick()
	end)
	arg_6_0:AddBtnListener(arg_6_0.freeBtn_, nil, function()
		arg_6_0:OnFreeBtnClick()
	end)
	arg_6_0:AddBtnListener(arg_6_0.maskBtn_, nil, function()
		arg_6_0:Back()
	end)
end

function var_0_0.OnCaptureClick(arg_11_0)
	CaptureGameTools:EnterCaptureGame(arg_11_0.runtimeContext.mainStageId, arg_11_0.runtimeContext.id, arg_11_0:IsOnFree())
end

function var_0_0.RenderItem(arg_12_0, arg_12_1, arg_12_2)
	arg_12_2:RenderView(arg_12_0.runtimeContext.taskList[arg_12_1], arg_12_0.runtimeContext.mainStageId, arg_12_0.runtimeContext.id)
end

function var_0_0.OnNormalBtnClick(arg_13_0)
	if not arg_13_0:IsOnFree() then
		return
	end

	arg_13_0:SwitchToFreeStyle(false)
end

function var_0_0.OnFreeBtnClick(arg_14_0)
	if not CaptureGameData:CheckFreeCaptureOpen(arg_14_0.runtimeContext.gameMode == CaptureGameConst.CaptureGameMode.Single) then
		return
	end

	if arg_14_0:IsOnFree() then
		return
	end

	arg_14_0:SwitchToFreeStyle(true)
end

function var_0_0.OnEnter(arg_15_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		arg_15_0:Back()
	end)
	arg_15_0:RenderView()
end

function var_0_0.OnExit(arg_17_0)
	return
end

function var_0_0.RenderView(arg_18_0)
	local var_18_0 = CaptureGameData:GetSectionData()

	if var_18_0 then
		arg_18_0.runtimeContext.id = var_18_0.subSectionId
		arg_18_0.runtimeContext.mainStageId = var_18_0.mainStageId

		local var_18_1 = ActivitySwimSkinSectionCfg[var_18_0.mainStageId]

		arg_18_0.runtimeContext.gameMode = var_18_1.mode

		if not var_18_0.isFree then
			arg_18_0.runtimeContext.taskList = CaptureGameHelper:GetTaskBySectionId(var_18_0.subSectionId)

			arg_18_0.scrollHelper:StartScroll(#arg_18_0.runtimeContext.taskList)
		end

		arg_18_0:SwitchToFreeStyle(var_18_0.isFree)
	else
		arg_18_0.runtimeContext.id = arg_18_0.params_.id
		arg_18_0.runtimeContext.mainStageId = arg_18_0.params_.mainStageId
		arg_18_0.runtimeContext.gameMode = arg_18_0.params_.mode
		arg_18_0.runtimeContext.taskList = CaptureGameHelper:GetTaskBySectionId(arg_18_0.params_.id)

		arg_18_0.scrollHelper:StartScroll(#arg_18_0.runtimeContext.taskList)
		arg_18_0:SwitchToFreeStyle(false)
	end

	local var_18_2 = CaptureGameData:CheckSectionTaskComplete(arg_18_0.runtimeContext.mainStageId, arg_18_0.runtimeContext.id)

	arg_18_0.staticContext.completeTabController:SetSelectedState(var_18_2 and "state1" or "state0")
	arg_18_0.staticContext.lockPictureController:SetSelectedState(CaptureGameData:CheckFreeCaptureOpen(arg_18_0.runtimeContext.gameMode == CaptureGameConst.CaptureGameMode.Single) and "state1" or "state0")
end

function var_0_0.SwitchToFreeStyle(arg_19_0, arg_19_1)
	if arg_19_1 then
		SetActive(arg_19_0.taskListObj_, false)
		SetActive(arg_19_0.noTaskObj_, true)
		arg_19_0.staticContext.freeBtnController:SetSelectedState("state1")
		arg_19_0.staticContext.freeTabController:SetSelectedState("state1")
	else
		SetActive(arg_19_0.taskListObj_, true)
		SetActive(arg_19_0.noTaskObj_, false)
		arg_19_0.staticContext.freeBtnController:SetSelectedState("state0")
		arg_19_0.staticContext.freeTabController:SetSelectedState("state0")
	end

	arg_19_0.staticContext.isInFreeCapture = arg_19_1
end

function var_0_0.IsOnFree(arg_20_0)
	return arg_20_0.staticContext.isInFreeCapture
end

function var_0_0.CheckCanFree(arg_21_0)
	return
end

function var_0_0.Dispose(arg_22_0)
	arg_22_0.scrollHelper:Dispose()
	var_0_0.super.Dispose(arg_22_0)
end

return var_0_0
