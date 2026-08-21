local var_0_0 = class("T0CaptureSceneItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListener()

	arg_3_0.controller = arg_3_0.controllerEx_:GetController("state")
end

function var_0_0.AddListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.button_, nil, function()
		manager.transition:OnlyShowEffect(true, function()
			T0WorldMgr:SetCaptureScene(arg_4_0.sceneType)
			manager.transition:OnlyShowEffect(false)
		end)
	end)
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1)
	arg_7_0.sceneType = arg_7_1

	local var_7_0 = T0WorldMgr:GetCaptureSceneName(arg_7_1)

	arg_7_0.nameText_.text = GetTips(var_7_0)

	arg_7_0:SetActive(true)
end

function var_0_0.SetActive(arg_8_0, arg_8_1)
	if arg_8_1 then
		SetActive(arg_8_0.gameObject_, true)
	else
		SetActive(arg_8_0.gameObject_, false)
	end
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
