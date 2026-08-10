local var_0_0 = class("CaptureGameSettingView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/SummerUI_3_4/SummerUI_3_4_CaptureUI/Module/Setting/SummerUI_3_4_CaptureFilterUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AddListener()

	arg_4_0.staticContext = {
		page = {
			Pose = {
				opened = false,
				idx = 1,
				state = "pose",
				script = CaptureHeroAnimationModule
			},
			Hero = {
				opened = false,
				idx = 2,
				state = "team",
				script = CaptureHeroSelectModule
			},
			Setting = {
				opened = false,
				idx = 3,
				state = "camera",
				script = CaptureSettingModule
			},
			Lens = {
				opened = false,
				idx = 4,
				state = "filter",
				script = CaptureLensModule
			}
		},
		tabController = arg_4_0.tabController_:GetController("tab"),
		onCameraClickHandler = handler(arg_4_0, arg_4_0.OnCameraClick)
	}
end

function var_0_0.AddListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.poseTab_, nil, function()
		arg_5_0:OnPoseTabClick()
	end)
	arg_5_0:AddBtnListener(arg_5_0.teamTab_, nil, function()
		arg_5_0:OnTeamTabClick()
	end)
	arg_5_0:AddBtnListener(arg_5_0.cameraTab_, nil, function()
		arg_5_0:OnSettingTabClick()
	end)
	arg_5_0:AddBtnListener(arg_5_0.filterTab_, nil, function()
		arg_5_0:OnLensTabClick()
	end)
end

function var_0_0.AddEventListeners(arg_10_0)
	manager.notify:RegistListener(CAPTURE_GAME_CAMERA_CLICK, arg_10_0.staticContext.onCameraClickHandler)
end

function var_0_0.RemoveEventListeners(arg_11_0)
	manager.notify:RemoveListener(CAPTURE_GAME_CAMERA_CLICK, arg_11_0.staticContext.onCameraClickHandler)
end

function var_0_0.BuildContext(arg_12_0)
	arg_12_0.context = {}
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0:AddEventListeners()
	arg_13_0:RenderTab(0)

	local var_13_0 = arg_13_0.staticContext.page.Pose.idx

	if not CaptureGameMgr:IsSingleMode() then
		local var_13_1 = CaptureGameMgr:GetPlaceHolderMgr():GetCurrentSelect()

		if CaptureGameMgr:GetPlaceHolderMgr():HolderSelectedSkin(var_13_1) == -1 then
			var_13_0 = arg_13_0.staticContext.page.Hero.idx
		end
	end

	arg_13_0:EnterPage(var_13_0)
end

function var_0_0.OnExit(arg_14_0)
	arg_14_0:RemoveEventListeners()
	arg_14_0:EnterPage(-1)
	CaptureGameMgr:OpenSettingPanel(false)
end

function var_0_0.Dispose(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0.staticContext.page) do
		if iter_15_1.entity then
			iter_15_1.entity:Dispose()

			iter_15_1.entity = nil
		end
	end

	arg_15_0.staticContext.tabController = nil

	var_0_0.super.Dispose(arg_15_0)
end

function var_0_0.OnCameraClick(arg_16_0)
	arg_16_0:Back()
end

function var_0_0.OnPoseTabClick(arg_17_0)
	arg_17_0:EnterPage(arg_17_0.staticContext.page.Pose.idx)
end

function var_0_0.OnTeamTabClick(arg_18_0)
	arg_18_0:EnterPage(arg_18_0.staticContext.page.Hero.idx)
end

function var_0_0.OnSettingTabClick(arg_19_0)
	arg_19_0:EnterPage(arg_19_0.staticContext.page.Setting.idx)
end

function var_0_0.OnLensTabClick(arg_20_0)
	arg_20_0:EnterPage(arg_20_0.staticContext.page.Lens.idx)
end

function var_0_0.RenderTab(arg_21_0)
	if CaptureGameMgr:IsSingleMode() then
		SetActive(arg_21_0.teamTab_.gameObject, false)
	else
		SetActive(arg_21_0.teamTab_.gameObject, true)
	end
end

function var_0_0.EnterPage(arg_22_0, arg_22_1)
	for iter_22_0, iter_22_1 in pairs(arg_22_0.staticContext.page) do
		if iter_22_1.idx == arg_22_1 then
			if not iter_22_1.opened then
				arg_22_0:InstOrCreatePage(iter_22_1)
				iter_22_1.entity:OnEnter()

				iter_22_1.opened = true

				arg_22_0.staticContext.tabController:SetSelectedState(iter_22_1.state)
			end
		elseif iter_22_1.opened then
			iter_22_1.entity:OnExit()

			iter_22_1.opened = false
		end
	end
end

function var_0_0.InstOrCreatePage(arg_23_0, arg_23_1)
	if arg_23_1.entity == nil then
		arg_23_1.entity = arg_23_1.script.New(arg_23_0.pageContainer_)
	end
end

return var_0_0
