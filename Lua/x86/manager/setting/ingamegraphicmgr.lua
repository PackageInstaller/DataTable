local var_0_0 = singletonClass("IngameGraphicMgr")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.ingameSetting_ = UnityEngine.Rendering.ReplicaExt.IngameGraphicSetting.Instance
end

function var_0_0.ChangeShadowQuality(arg_2_0, arg_2_1)
	if arg_2_0.ingameSetting_ then
		arg_2_0.ingameSetting_:ChangeShadowQuality(arg_2_1 - 1)
	else
		Debug.LogError("未找到IngameGraphicSetting！！请联系sqjc")
	end
end

function var_0_0.ChangePostProcessQuality(arg_3_0, arg_3_1)
	if arg_3_0.ingameSetting_ then
		arg_3_0.ingameSetting_:ChangePostProcessQuality(arg_3_1 - 1)
	else
		Debug.LogError("未找到IngameGraphicSetting！！请联系sqjc")
	end
end

function var_0_0.ChangeRenderScale(arg_4_0, arg_4_1)
	if arg_4_0.ingameSetting_ then
		arg_4_0.ingameSetting_:ChangeRenderScale(arg_4_1)
	else
		Debug.LogError("未找到IngameGraphicSetting！！请联系sqjc")
	end
end

function var_0_0.ChangeVerticalSync(arg_5_0, arg_5_1)
	if arg_5_0.ingameSetting_ then
		arg_5_0.ingameSetting_:ChangeVerticalSync(arg_5_1 == 1 and true or false)
	else
		Debug.LogError("未找到IngameGraphicSetting！！请联系sqjc")
	end
end

function var_0_0.ChangeDof(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1 == 1

	if arg_6_0.ingameSetting_ then
		arg_6_0.ingameSetting_:ChangeDof(var_6_0)
	else
		Debug.LogError("未找到IngameGraphicSetting！！请联系sqjc")
	end
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.ingameSetting_ = nil
end

return var_0_0
