-- chunkname: @framework/helper/transformhelper.lua

module("framework.helper.transformhelper", package.seeall)

local transformhelper = _M
local TransformHelper = SLFramework.TransformHelper

function transformhelper.setPos(transform, x, y, z)
	TransformHelper.SetPos(transform, x, y, z)
end

function transformhelper.setPosLerp(transform, x, y, z, lerp)
	TransformHelper.SetPosLerp(transform, x, y, z, lerp)
end

function transformhelper.setPosXY(transform, x, y)
	TransformHelper.SetPosXY(transform, x, y)
end

function transformhelper.getPos(transform)
	return TransformHelper.GetPos(transform, 0, 0, 0)
end

function transformhelper.setLocalPos(transform, x, y, z)
	TransformHelper.SetLocalPos(transform, x, y, z)
end

function transformhelper.setLocalLerp(transform, x, y, z, lerp)
	TransformHelper.SetLocalPosLerp(transform, x, y, z, lerp)
end

function transformhelper.setLocalPosXY(transform, x, y)
	TransformHelper.SetLocalPosXY(transform, x, y)
end

function transformhelper.getLocalPos(transform)
	return TransformHelper.GetLocalPos(transform, 0, 0, 0)
end

function transformhelper.setLocalScale(transform, x, y, z)
	TransformHelper.SetLocalScale(transform, x, y, z)
end

function transformhelper.setLocalScaleLerp(transform, x, y, z, lerp)
	TransformHelper.SetLocalScaleLerp(transform, x, y, z, lerp)
end

function transformhelper.getLocalScale(transform)
	return TransformHelper.GetLocalScale(transform, 0, 0, 0)
end

function transformhelper.setLocalRotation(transform, x, y, z)
	TransformHelper.SetLocalEulerAngles(transform, x, y, z)
end

function transformhelper.getLocalRotation(transform)
	return TransformHelper.GetLocalEulerAngles(transform, 0, 0, 0)
end

function transformhelper.setRotation(transform, x, y, z, w)
	TransformHelper.SetRotation(transform, x, y, z, w)
end

function transformhelper.setLocalRotation2(transform, x, y, z, w)
	TransformHelper.SetLocalRotation(transform, x, y, z, w)
end

function transformhelper.setLocalRotationLerp(transform, angleX, angleY, angleZ, lerp)
	TransformHelper.SetLocalRotationLerp(transform, angleX, angleY, angleZ, lerp)
end

function transformhelper.setRotationLerp(transform, angleX, angleY, angleZ, lerp)
	TransformHelper.SetRotationLerp(transform, angleX, angleY, angleZ, lerp)
end

function transformhelper.getForward(transform)
	return TransformHelper.GetForward(transform, 0, 0, 0)
end

function transformhelper.getRight(transform)
	return TransformHelper.GetRight(transform, 0, 0, 0)
end

function transformhelper.getUp(transform)
	return TransformHelper.GetUp(transform, 0, 0, 0)
end

function transformhelper.getEulerAngles(transform)
	return TransformHelper.GetEulerAngles(transform, 0, 0, 0)
end

function transformhelper.setEulerAngles(transform, x, y, z)
	TransformHelper.SetEulerAngles(transform, x, y, z)
end

function transformhelper.getLossyScale(transform)
	return TransformHelper.GetLossyScale(transform, 0, 0, 0)
end

return transformhelper
