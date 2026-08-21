GraphApiHelper = {}

local var_0_0 = GraphApiHelper

GraphApiHelper.SaveKey_Graphics_API = "Force_Graphics_API"
GraphApiHelper.Api = {
	Force_Vulkan = 1,
	Force_OpenGLES = 2
}

function GraphApiHelper.GetGraphApiSaveValue()
	return PlayerPrefs.GetInt(var_0_0.SaveKey_Graphics_API, 0)
end

function GraphApiHelper.IsForceVulkan()
	return var_0_0.GetGraphApiSaveValue() == var_0_0.Api.Force_Vulkan
end

function GraphApiHelper.IsForceOpenGLES()
	return var_0_0.GetGraphApiSaveValue() == var_0_0.Api.Force_OpenGLES
end

function GraphApiHelper.SetForceGraphApi(arg_4_0)
	if not table.contains(var_0_0.Api, arg_4_0) then
		arg_4_0 = 0
	end

	warning("Set Graphi Api " .. arg_4_0)
	PlayerPrefs.SetInt(var_0_0.SaveKey_Graphics_API, arg_4_0)
	PlayerPrefs.Save()

	return
end

function GraphApiHelper.GetCurGraphApi()
	return tostring(SystemInfo.graphicsDeviceType)
end

function GraphApiHelper.IsUsingVulkan()
	return string.find(string.lower((var_0_0.GetCurGraphApi())), "vulkan")
end

return GraphApiHelper
