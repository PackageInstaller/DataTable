local var_0_0 = class("T0SceneChangeView", ReduxView)

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

	arg_3_0.expandController = arg_3_0.controller_:GetController("expand")
	arg_3_0.expandsceneList = {}

	arg_3_0:Render()
end

function var_0_0.AddListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.changeBtn_, nil, function()
		arg_4_0:SetExpandState(true)
	end)
	arg_4_0:AddBtnListener(arg_4_0.closeBtn_, nil, function()
		arg_4_0:SetExpandState(false)
	end)
end

function var_0_0.SetExpandState(arg_7_0, arg_7_1)
	if arg_7_1 then
		arg_7_0.expandController:SetSelectedState("expand")
	else
		arg_7_0.expandController:SetSelectedState("normal")
	end
end

function var_0_0.Render(arg_8_0)
	local var_8_0 = T0WorldMgr:GetUseSceneType()
	local var_8_1 = T0WorldMgr:GetCaptureSceneName(var_8_0)

	arg_8_0.useSceneName_.text = GetTips(var_8_1)

	for iter_8_0, iter_8_1 in pairs(arg_8_0.expandsceneList or {}) do
		if iter_8_1 then
			iter_8_1:SetActive(false)
		end
	end

	local var_8_2 = 1
	local var_8_3 = T0WorldTools.GetCaptureSceneList()

	for iter_8_2, iter_8_3 in pairs(var_8_3) do
		if iter_8_2 ~= var_8_0 then
			local var_8_4 = arg_8_0.expandsceneList[var_8_2]

			if not var_8_4 then
				var_8_4 = arg_8_0:CreateSceneItem()
				arg_8_0.expandsceneList[var_8_2] = var_8_4
			end

			var_8_4:RefreshUI(iter_8_2)

			var_8_2 = var_8_2 + 1
		end
	end
end

function var_0_0.CreateSceneItem(arg_9_0)
	local var_9_0 = Object.Instantiate(arg_9_0.sceneObj_, arg_9_0.selectContent_)

	return (T0CaptureSceneItem.New(var_9_0))
end

function var_0_0.Dispose(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.expandsceneList) do
		if iter_10_1 then
			iter_10_1:Dispose()

			iter_10_1 = nil
		end
	end

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
