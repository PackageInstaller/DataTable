local var_0_0 = class("AshProcessView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_EkChuah/EkChuah_IllustratedUI/Activity_EkChuah_illustratedUI"
end

local var_0_1 = {
	PLOT = 1,
	ILL = 2
}

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.GetCustomScene(arg_3_0)
	return HeroRaiseTrackConst.CustomScene.Cowboy
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListeners()
end

function var_0_0.OnAshAvgEnd(arg_5_0)
	local var_5_0 = arg_5_0:GetCustomSceneController()

	if var_5_0 then
		var_5_0:OnInit()
	end

	arg_5_0:OnEnter()
	arg_5_0:OnTop()
end

function var_0_0.InitUI(arg_6_0)
	arg_6_0:BindCfgUI()

	arg_6_0.context = {
		page = {
			[var_0_1.ILL] = nil,
			[var_0_1.PLOT] = nil
		},
		pageScript = {
			[var_0_1.ILL] = AshIllustratedPanel,
			[var_0_1.PLOT] = AshPlotPanel
		},
		pageContainer = {
			[var_0_1.ILL] = arg_6_0.illTrans_,
			[var_0_1.PLOT] = arg_6_0.plotTrans_
		},
		pageState = {
			[var_0_1.ILL] = "IllustratedPanel",
			[var_0_1.PLOT] = "plotPanel"
		}
	}
	arg_6_0.controller = arg_6_0.controllerEx_:GetController("panelSwitch")
end

function var_0_0.AddUIListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.plotBtn_, nil, function()
		arg_7_0:SwitchPage(var_0_1.PLOT)
	end)
	arg_7_0:AddBtnListener(arg_7_0.illBtn_, nil, function()
		arg_7_0:SwitchPage(var_0_1.ILL)
	end)
end

function var_0_0.SwitchPage(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.context.curPage
	local var_10_1

	if arg_10_0.context.curPage == nil then
		var_10_1 = arg_10_1
	else
		if arg_10_0.context.curPage ~= arg_10_1 then
			var_10_1 = arg_10_1
		end

		if arg_10_2 then
			var_10_1 = arg_10_1
		end
	end

	if var_10_0 and var_10_1 and var_10_0 ~= var_10_1 then
		arg_10_0.context.page[var_10_0]:ExitPanel(arg_10_0)
	end

	if var_10_1 then
		if not arg_10_0.context.page[var_10_1] then
			arg_10_0.context.page[var_10_1] = arg_10_0.context.pageScript[var_10_1].New(arg_10_0.context.pageContainer[var_10_1])
		end

		arg_10_0.context.curPage = var_10_1

		arg_10_0.context.page[var_10_1]:EnterPanel(arg_10_0)
		arg_10_0.controller:SetSelectedState(arg_10_0.context.pageState[var_10_1])
	end
end

function var_0_0.OnEnter(arg_11_0)
	if AshSystemData:GetStoryState() then
		return
	end

	manager.ui.mainCamera:GetComponent("CameraExtension").shadowRotationImmediately = true

	local var_11_0 = arg_11_0:GetCustomSceneController()

	var_11_0:CloseCutScene()

	if var_11_0.SwitchBgState then
		var_11_0:SwitchBgState(1)
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		arg_11_0:GetCustomSceneController():ShowCutScene(function()
			arg_11_0:Back()
		end)
	end)
	arg_11_0:SwitchPage(var_0_1.PLOT, true)
end

function var_0_0.OnTop(arg_14_0)
	if AshSystemData:GetStoryState() then
		return
	end

	arg_14_0:SwitchPage(arg_14_0.context.curPage, true)

	local var_14_0 = arg_14_0:GetCustomSceneController()

	if var_14_0.SwitchBgState then
		var_14_0:SwitchBgState(1)
	end
end

function var_0_0.OnExit(arg_15_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_16_0)
	for iter_16_0, iter_16_1 in pairs(var_0_1) do
		if arg_16_0.context.page[iter_16_1] then
			arg_16_0.context.page[iter_16_1]:Dispose()

			arg_16_0.context.page[iter_16_1] = nil
		end
	end

	arg_16_0.super.Dispose(arg_16_0)
end

return var_0_0
