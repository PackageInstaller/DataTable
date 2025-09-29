-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/constdef/ShaderConstants.lua

module("logic.common.constdef.ShaderConstants", package.seeall)

local ShaderConstants = {}
local Shader = UnityEngine.Shader

ShaderConstants.KEY_SCREEN = "_SCREEN_ON"
ShaderConstants.ID_MainColorID = Shader.PropertyToID("_BaseColor")
ShaderConstants.ID_DarkenColorLerp = Shader.PropertyToID("_DarkenColorLerp")
ShaderConstants.ID_CustomBlendColor = Shader.PropertyToID("_CustomBlendColor")
ShaderConstants.ID_LuminanceRatio = Shader.PropertyToID("_LuminanceRatio")
ShaderConstants.ID_CustomColorId = Shader.PropertyToID("_CustomBlendColor")
ShaderConstants.ID_Transparency = Shader.PropertyToID("_Transparency")
ShaderConstants.ID_SelectOutline = Shader.PropertyToID("_SelectOutlineColor")
ShaderConstants.ID_SelectOutlineWidth = Shader.PropertyToID("_SelectOutline")
ShaderConstants.ID_WSMaskID = Shader.PropertyToID("_WSMask")
ShaderConstants.ID_Gradient = Shader.PropertyToID("_Gradient")
ShaderConstants.ID_Alpha = Shader.PropertyToID("_GlobalOpacity")

return ShaderConstants
