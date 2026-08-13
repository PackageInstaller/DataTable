local var_0_0 = {}

GraphApiHelper = GraphApiHelper
var_0.SaveKey_Graphics_API = "Force_Graphics_API"
var_0.Api = {
	Force_Vulkan = 1,
	Force_OpenGLES = 2
}

function var_0.GetGraphApiSaveValue()
	PlayerPrefs = var_1_10000

	return var_1_10000.GetInt(var_0.SaveKey_Graphics_API, 0)
end

function var_0.IsForceVulkan()
	return var_0.GetGraphApiSaveValue() == var_0.Api.Force_Vulkan
end

function var_0.IsForceOpenGLES()
	return var_0.GetGraphApiSaveValue() == var_0.Api.Force_OpenGLES
end

function var_0.SetForceGraphApi(arg_4_0)
	table = var_1_10001

	if not var_1_10001.contains(var_0.Api, arg_4_0) then
		arg_4_0 = 0
	end

	warning = var_1_10002

	var_1_10002("Set Graphi Api " .. arg_4_0)

	PlayerPrefs = var_1_10002

	var_1_10002.SetInt(var_0.SaveKey_Graphics_API, arg_4_0)

	PlayerPrefs = var_2

	var_2.Save()

	return
end

function var_0.GetCurGraphApi()
	tostring = var_1_10000
	SystemInfo = var_1_10002

	return var_1_10000(var_1_10002.graphicsDeviceType)
end

function var_0.IsUsingVulkan()
	local var_6_0 = var_0.GetCurGraphApi()

	string = var_1_10001

	local var_6_1 = var_1_10001.find

	string = var_1_10003

	return var_6_1(var_1_10003.lower(var_6_0), "vulkan")
end

return var_0
