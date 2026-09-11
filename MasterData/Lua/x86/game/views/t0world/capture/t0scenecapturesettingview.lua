local T0SceneCaptureSettingView = class("T0SceneCaptureSettingView", ReduxView)
local var_0_1 = "Widget/System/Main_T0SceneGame/%s/%s_CaptureFilterUI"

function T0SceneCaptureSettingView:UIName()
	return string.format(var_0_1, T0WorldMgr:GetHeroID(), T0WorldMgr:GetHeroID())
end

function T0SceneCaptureSettingView:UIParent()
	return manager.ui.uiPop.transform
end

function T0SceneCaptureSettingView:Init()
	self:InitUI()
end

function T0SceneCaptureSettingView:InitUI()
	self:BindCfgUI()
	self:AddListener()

	self.staticContext = {
		page = {
			Anim = {
				opened = false,
				idx = 1,
				state = "anim",
				script = T0CaptureModule
			},
			Face = {
				opened = false,
				idx = 2,
				state = "face",
				script = T0CaptureModule
			},
			Filter = {
				opened = false,
				idx = 3,
				state = "filter",
				script = T0CaptureModule
			}
		},
		tabController = self.tabController_:GetController("tab")
	}
end

function T0SceneCaptureSettingView:AddListener()
	self:AddBtnListener(self.animTabBtn_, nil, function()
		self:EnterPage(self.staticContext.page.Anim.idx)
	end)
	self:AddBtnListener(self.faceTabBtn_, nil, function()
		self:EnterPage(self.staticContext.page.Face.idx)
	end)
	self:AddBtnListener(self.filterTabBtn_, nil, function()
		self:EnterPage(self.staticContext.page.Filter.idx)
	end)
	self:AddBtnListener(self.btnMask_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListener(self.closeBtn_, nil, function()
		T0WorldOpenCaptureFilter(false)
	end)
end

function T0SceneCaptureSettingView:OnCaptureSwitchChange(arg_11_1)
	for iter_11_0, iter_11_1 in pairs(self.staticContext.page) do
		if iter_11_1.idx == T0WorldCaptureSwitchCfg[arg_11_1].switchType and iter_11_1.opened then
			iter_11_1.entity:Render()
		end
	end
end

function T0SceneCaptureSettingView:OnEnter()
	self:RegistEventListener(T0_WORLD_CAPTURE_SWITCH_CHANGE, handler(self, self.OnCaptureSwitchChange))
	self:EnterPage(self.staticContext.page.Anim.idx)
end

function T0SceneCaptureSettingView:EnterPage(arg_13_1)
	for iter_13_0, iter_13_1 in pairs(self.staticContext.page) do
		if iter_13_1.idx == arg_13_1 then
			if not iter_13_1.opened then
				self:InstOrCreatePage(iter_13_1, iter_13_1.idx)
				iter_13_1.entity:OnEnter(iter_13_1.idx)

				iter_13_1.opened = true

				self.staticContext.tabController:SetSelectedState(iter_13_1.state)
			end
		elseif iter_13_1.opened then
			iter_13_1.entity:OnExit()

			iter_13_1.opened = false
		end
	end
end

function T0SceneCaptureSettingView:InstOrCreatePage(arg_14_1, arg_14_2)
	if arg_14_1.entity == nil then
		arg_14_1.entity = arg_14_1.script.New(self.pageContainer_, arg_14_2)
	end
end

function T0SceneCaptureSettingView:OnExit()
	for iter_15_0, iter_15_1 in pairs(self.staticContext.page) do
		if iter_15_1.opened then
			iter_15_1.entity:OnExit()

			iter_15_1.opened = false
		end
	end

	self:RemoveAllEventListener()
end

function T0SceneCaptureSettingView:Dispose()
	for iter_16_0, iter_16_1 in pairs(self.staticContext.page) do
		if iter_16_1.entity then
			iter_16_1.entity:Dispose()

			iter_16_1.entity = nil
		end
	end

	T0SceneCaptureSettingView.super.Dispose(self)
end

return T0SceneCaptureSettingView
