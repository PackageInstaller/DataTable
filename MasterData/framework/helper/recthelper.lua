-- chunkname: @framework/helper/recthelper.lua

module("framework.helper.recthelper", package.seeall)

local recthelper = {}
local CSRectTrHelper = SLFramework.UGUI.RectTrHelper

function recthelper.setHeight(rectTransform, height)
	CSRectTrHelper.SetHeight(rectTransform, height)
end

function recthelper.getHeight(rectTransform)
	return CSRectTrHelper.GetHeight(rectTransform)
end

function recthelper.setWidth(rectTransform, width)
	CSRectTrHelper.SetWidth(rectTransform, width)
end

function recthelper.getWidth(rectTransform)
	return CSRectTrHelper.GetWidth(rectTransform)
end

function recthelper.setSize(rectTransform, width, height)
	CSRectTrHelper.SetSize(rectTransform, width, height)
end

function recthelper.getAnchorX(rectTransform)
	return CSRectTrHelper.GetAnchorX(rectTransform)
end

function recthelper.getAnchorY(rectTransform)
	return CSRectTrHelper.GetAnchorY(rectTransform)
end

function recthelper.getAnchor(rectTransform)
	return CSRectTrHelper.GetAnchor(rectTransform, 0, 0)
end

function recthelper.setAnchorX(rectTransform, anchorX)
	CSRectTrHelper.SetAnchorX(rectTransform, anchorX)
end

function recthelper.setAnchorY(rectTransform, anchorY)
	CSRectTrHelper.SetAnchorY(rectTransform, anchorY)
end

function recthelper.setAnchor(rectTransform, anchorX, anchorY)
	CSRectTrHelper.SetAnchor(rectTransform, anchorX, anchorY)
end

function recthelper.screenPosToAnchorPos(screenPos, rect)
	local uiCamera = CameraMgr.instance:getUICamera()

	return CSRectTrHelper.ScreenPosToAnchorPos(screenPos, rect, uiCamera)
end

function recthelper.screenPosToAnchorPos2(screenPos, rect)
	local uiCamera = CameraMgr.instance:getUICamera()

	return CSRectTrHelper.ScreenPosToAnchorPos2(screenPos, rect, uiCamera, nil, nil)
end

function recthelper.rectToRelativeAnchorPos(rectTrWorldPos, relativeRectTr)
	local uiCamera = CameraMgr.instance:getUICamera()
	local screenPos = uiCamera:WorldToScreenPoint(rectTrWorldPos)

	return CSRectTrHelper.ScreenPosToAnchorPos(screenPos, relativeRectTr, uiCamera)
end

function recthelper.rectToRelativeAnchorPos2(rectTrWorldPos, relativeRectTr)
	local uiCamera = CameraMgr.instance:getUICamera()
	local screenPos = uiCamera:WorldToScreenPoint(rectTrWorldPos)

	return CSRectTrHelper.ScreenPosToAnchorPos2(screenPos, relativeRectTr, uiCamera, nil, nil)
end

function recthelper.worldPosToAnchorPos(worldPos, planeRectTr, uiCamera, camera3d)
	uiCamera = uiCamera or CameraMgr.instance:getUICamera()
	camera3d = camera3d or CameraMgr.instance:getMainCamera()

	return CSRectTrHelper.WorldPosToAnchorPos(worldPos, planeRectTr, uiCamera, camera3d)
end

function recthelper.worldPosToAnchorPos2(worldPos, planeRectTr, uiCamera, camera3d)
	uiCamera = uiCamera or CameraMgr.instance:getUICamera()
	camera3d = camera3d or CameraMgr.instance:getMainCamera()

	return CSRectTrHelper.WorldPosToAnchorPos2(worldPos, planeRectTr, uiCamera, camera3d, nil, nil)
end

function recthelper.worldPosToAnchorPosXYZ(worldPosX, worldPosY, worldPosZ, planeRectTr, uiCamera, camera3d)
	uiCamera = uiCamera or CameraMgr.instance:getUICamera()
	camera3d = camera3d or CameraMgr.instance:getMainCamera()

	return CSRectTrHelper.WorldPosToAnchorPosXYZ(worldPosX, worldPosY, worldPosZ, planeRectTr, uiCamera, camera3d, nil, nil)
end

function recthelper.screenPosToWorldPos(screenPos, worldCamera, refGOWorldPos)
	worldCamera = worldCamera or CameraMgr.instance:getMainCamera()

	return CSRectTrHelper.ScreenPosToWorldPos(screenPos, worldCamera, refGOWorldPos)
end

function recthelper.screenPosToWorldPos3(screenPos, worldCamera, refGOWorldPos)
	worldCamera = worldCamera or CameraMgr.instance:getMainCamera()

	return CSRectTrHelper.ScreenPosToWorldPos3(screenPos, worldCamera, refGOWorldPos, nil, nil, nil)
end

function recthelper.uiPosToScreenPos(rectTransform, canvas)
	canvas = canvas or ViewMgr.instance:getUICanvas()

	return CSRectTrHelper.UIPosToScreenPos(rectTransform, canvas)
end

function recthelper.uiPosToScreenPos2(rectTransform, canvas)
	canvas = canvas or ViewMgr.instance:getUICanvas()

	return CSRectTrHelper.UIPosToScreenPos2(rectTransform, canvas, nil, nil)
end

function recthelper.screenPosInRect(rectTransform, uiCamera, screenPosX, screenPosY)
	uiCamera = uiCamera or CameraMgr.instance:getUICamera()

	return CSRectTrHelper.ScreenPosInRect(rectTransform, uiCamera, screenPosX, screenPosY, nil)
end

function recthelper.worldPosToScreenPoint(worldCamera, worldPosX, worldPosY, worldPosZ)
	worldCamera = worldCamera or CameraMgr.instance:getMainCamera()

	return CSRectTrHelper.WorldPosToScreenPoint(worldCamera, worldPosX, worldPosY, worldPosZ, nil, nil, nil)
end

return recthelper
