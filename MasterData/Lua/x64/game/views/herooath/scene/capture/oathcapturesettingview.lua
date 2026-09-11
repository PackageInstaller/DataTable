baseSettingView = import("game.views.t0World.Capture.T0SceneCaptureSettingView")

local OathCaptureSettingView = class("OathCaptureSettingView", baseSettingView)

function OathCaptureSettingView:UIName()
	return "Widget/System/Hero_Oath/OathCaptureView/Hero_Oath_CaptureFilterUI"
end

function OathCaptureSettingView:InitUI()
	self:BindCfgUI()
	self:AddListener()

	self.staticContext = {
		page = {
			Anim = {
				opened = false,
				idx = 1,
				state = "anim",
				script = OathCaptureModule
			},
			Face = {
				opened = false,
				idx = 2,
				state = "face",
				script = OathCaptureModule
			},
			Filter = {
				opened = false,
				idx = 3,
				state = "filter",
				script = OathCaptureModule
			}
		},
		tabController = self.tabController_:GetController("tab")
	}
end

function OathCaptureSettingView:AddListener()
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
		OathToLuaBridge.OathOpenCaptureFilter(false)
	end)
end

function OathCaptureSettingView:OnCaptureSwitchChange(arg_9_1)
	for iter_9_0, iter_9_1 in pairs(self.staticContext.page) do
		if iter_9_1.idx == WeddingCaptureSwitchCfg[arg_9_1].switchType and iter_9_1.opened then
			iter_9_1.entity:Render()
		end
	end
end

function OathCaptureSettingView:OnEnter()
	self:RegistEventListener(OATH_SCENE_CAPTURE_SWITCH_CHANGE, handler(self, self.OnCaptureSwitchChange))
	self:EnterPage(self.staticContext.page.Anim.idx)
end

return OathCaptureSettingView
