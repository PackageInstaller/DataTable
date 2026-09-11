local CaptureGameSettingView = class("CaptureGameSettingView", ReduxView)

function CaptureGameSettingView:UIName()
	return "Widget/Version/SummerUI_3_4/SummerUI_3_4_CaptureUI/Module/Setting/SummerUI_3_4_CaptureFilterUI"
end

function CaptureGameSettingView:UIParent()
	return manager.ui.uiPop.transform
end

function CaptureGameSettingView:Init()
	self:InitUI()
end

function CaptureGameSettingView:InitUI()
	self:BindCfgUI()
	self:AddListener()

	self.staticContext = {
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
		tabController = self.tabController_:GetController("tab"),
		onCameraClickHandler = handler(self, self.OnCameraClick)
	}
end

function CaptureGameSettingView:AddListener()
	self:AddBtnListener(self.poseTab_, nil, function()
		self:OnPoseTabClick()
	end)
	self:AddBtnListener(self.teamTab_, nil, function()
		self:OnTeamTabClick()
	end)
	self:AddBtnListener(self.cameraTab_, nil, function()
		self:OnSettingTabClick()
	end)
	self:AddBtnListener(self.filterTab_, nil, function()
		self:OnLensTabClick()
	end)
end

function CaptureGameSettingView:AddEventListeners()
	manager.notify:RegistListener(CAPTURE_GAME_CAMERA_CLICK, self.staticContext.onCameraClickHandler)
end

function CaptureGameSettingView:RemoveEventListeners()
	manager.notify:RemoveListener(CAPTURE_GAME_CAMERA_CLICK, self.staticContext.onCameraClickHandler)
end

function CaptureGameSettingView:BuildContext()
	self.context = {}
end

function CaptureGameSettingView:OnEnter()
	self:AddEventListeners()
	self:RenderTab(0)

	local var_13_0 = self.staticContext.page.Pose.idx

	if not CaptureGameMgr:IsSingleMode() then
		if CaptureGameMgr:GetPlaceHolderMgr():HolderSelectedSkin((CaptureGameMgr:GetPlaceHolderMgr():GetCurrentSelect())) == -1 then
			var_13_0 = self.staticContext.page.Hero.idx
		end
	end

	self:EnterPage(var_13_0)
end

function CaptureGameSettingView:OnExit()
	self:RemoveEventListeners()
	self:EnterPage(-1)
	CaptureGameMgr:OpenSettingPanel(false)
end

function CaptureGameSettingView:Dispose()
	for iter_15_0, iter_15_1 in pairs(self.staticContext.page) do
		if iter_15_1.entity then
			iter_15_1.entity:Dispose()

			iter_15_1.entity = nil
		end
	end

	self.staticContext.tabController = nil

	CaptureGameSettingView.super.Dispose(self)
end

function CaptureGameSettingView:OnCameraClick()
	self:Back()
end

function CaptureGameSettingView:OnPoseTabClick()
	self:EnterPage(self.staticContext.page.Pose.idx)
end

function CaptureGameSettingView:OnTeamTabClick()
	self:EnterPage(self.staticContext.page.Hero.idx)
end

function CaptureGameSettingView:OnSettingTabClick()
	self:EnterPage(self.staticContext.page.Setting.idx)
end

function CaptureGameSettingView:OnLensTabClick()
	self:EnterPage(self.staticContext.page.Lens.idx)
end

function CaptureGameSettingView:RenderTab()
	if CaptureGameMgr:IsSingleMode() then
		SetActive(self.teamTab_.gameObject, false)
	else
		SetActive(self.teamTab_.gameObject, true)
	end
end

function CaptureGameSettingView:EnterPage(arg_22_1)
	for iter_22_0, iter_22_1 in pairs(self.staticContext.page) do
		if iter_22_1.idx == arg_22_1 then
			if not iter_22_1.opened then
				self:InstOrCreatePage(iter_22_1)
				iter_22_1.entity:OnEnter()

				iter_22_1.opened = true

				self.staticContext.tabController:SetSelectedState(iter_22_1.state)
			end
		elseif iter_22_1.opened then
			iter_22_1.entity:OnExit()

			iter_22_1.opened = false
		end
	end
end

function CaptureGameSettingView:InstOrCreatePage(arg_23_1)
	if arg_23_1.entity == nil then
		arg_23_1.entity = arg_23_1.script.New(self.pageContainer_)
	end
end

return CaptureGameSettingView
