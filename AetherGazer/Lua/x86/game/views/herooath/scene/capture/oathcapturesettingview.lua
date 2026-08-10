baseSettingView = import("game.views.t0World.Capture.T0SceneCaptureSettingView")

local var_0_0 = class("OathCaptureSettingView", baseSettingView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_Oath/OathCaptureView/Hero_Oath_CaptureFilterUI"
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddListener()

	arg_2_0.staticContext = {
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
		tabController = arg_2_0.tabController_:GetController("tab")
	}
end

function var_0_0.AddListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.animTabBtn_, nil, function()
		arg_3_0:EnterPage(arg_3_0.staticContext.page.Anim.idx)
	end)
	arg_3_0:AddBtnListener(arg_3_0.faceTabBtn_, nil, function()
		arg_3_0:EnterPage(arg_3_0.staticContext.page.Face.idx)
	end)
	arg_3_0:AddBtnListener(arg_3_0.filterTabBtn_, nil, function()
		arg_3_0:EnterPage(arg_3_0.staticContext.page.Filter.idx)
	end)
	arg_3_0:AddBtnListener(arg_3_0.btnMask_, nil, function()
		JumpTools.Back()
	end)
	arg_3_0:AddBtnListener(arg_3_0.closeBtn_, nil, function()
		OathToLuaBridge.OathOpenCaptureFilter(false)
	end)
end

function var_0_0.OnCaptureSwitchChange(arg_9_0, arg_9_1)
	local var_9_0 = WeddingCaptureSwitchCfg[arg_9_1]

	for iter_9_0, iter_9_1 in pairs(arg_9_0.staticContext.page) do
		if iter_9_1.idx == var_9_0.switchType and iter_9_1.opened then
			iter_9_1.entity:Render()
		end
	end
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0:RegistEventListener(OATH_SCENE_CAPTURE_SWITCH_CHANGE, handler(arg_10_0, arg_10_0.OnCaptureSwitchChange))
	arg_10_0:EnterPage(arg_10_0.staticContext.page.Anim.idx)
end

return var_0_0
