-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/util/CameraUtils.lua

module("logic.common.util.CameraUtils", package.seeall)

local CameraUtils = {}
local ui3dcamera = false

function CameraUtils.setUI3DCamera(camera)
	ui3dcamera = camera
end

function CameraUtils.getUI3DCamera()
	return ui3dcamera
end

return CameraUtils
