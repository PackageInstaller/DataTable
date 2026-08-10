local var_0_0 = class("T0SceneCaptureSettingView", ReduxView)
local var_0_1 = "Widget/System/Main_T0SceneGame/%s/%s_CaptureFilterUI"

function var_0_0.UIName(arg_1_0)
	return string.format(var_0_1, T0WorldMgr:GetHeroID(), T0WorldMgr:GetHeroID())
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
		tabController = arg_4_0.tabController_:GetController("tab")
	}
end

function var_0_0.AddListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.animTabBtn_, nil, function()
		arg_5_0:EnterPage(arg_5_0.staticContext.page.Anim.idx)
	end)
	arg_5_0:AddBtnListener(arg_5_0.faceTabBtn_, nil, function()
		arg_5_0:EnterPage(arg_5_0.staticContext.page.Face.idx)
	end)
	arg_5_0:AddBtnListener(arg_5_0.filterTabBtn_, nil, function()
		arg_5_0:EnterPage(arg_5_0.staticContext.page.Filter.idx)
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnMask_, nil, function()
		JumpTools.Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.closeBtn_, nil, function()
		T0WorldOpenCaptureFilter(false)
	end)
end

function var_0_0.OnCaptureSwitchChange(arg_11_0, arg_11_1)
	local var_11_0 = T0WorldCaptureSwitchCfg[arg_11_1]

	for iter_11_0, iter_11_1 in pairs(arg_11_0.staticContext.page) do
		if iter_11_1.idx == var_11_0.switchType and iter_11_1.opened then
			iter_11_1.entity:Render()
		end
	end
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0:RegistEventListener(T0_WORLD_CAPTURE_SWITCH_CHANGE, handler(arg_12_0, arg_12_0.OnCaptureSwitchChange))
	arg_12_0:EnterPage(arg_12_0.staticContext.page.Anim.idx)
end

function var_0_0.EnterPage(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.staticContext.page) do
		if iter_13_1.idx == arg_13_1 then
			if not iter_13_1.opened then
				arg_13_0:InstOrCreatePage(iter_13_1, iter_13_1.idx)
				iter_13_1.entity:OnEnter(iter_13_1.idx)

				iter_13_1.opened = true

				arg_13_0.staticContext.tabController:SetSelectedState(iter_13_1.state)
			end
		elseif iter_13_1.opened then
			iter_13_1.entity:OnExit()

			iter_13_1.opened = false
		end
	end
end

function var_0_0.InstOrCreatePage(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1.entity == nil then
		arg_14_1.entity = arg_14_1.script.New(arg_14_0.pageContainer_, arg_14_2)
	end
end

function var_0_0.OnExit(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0.staticContext.page) do
		if iter_15_1.opened then
			iter_15_1.entity:OnExit()

			iter_15_1.opened = false
		end
	end

	arg_15_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_16_0)
	for iter_16_0, iter_16_1 in pairs(arg_16_0.staticContext.page) do
		if iter_16_1.entity then
			iter_16_1.entity:Dispose()

			iter_16_1.entity = nil
		end
	end

	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
