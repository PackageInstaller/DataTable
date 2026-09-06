-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/global/view/AdaptationOverlayView.lua

module("logic.extensions.global.view.AdaptationOverlayView", package.seeall)

local AdaptationOverlayView = class("AdaptationOverlayView")

function AdaptationOverlayView.buildUI()
	getres("ui/views/adaptation/adaptationoverlayview.prefab", AdaptationOverlayView._onResLoaded, AdaptationOverlayView)
end

function AdaptationOverlayView:_onResLoaded(res)
	if not res or not res.IsSuccess then
		return
	end

	local mainAsset = res:GetMainAsset()

	if not mainAsset then
		return
	end

	res:Retain()

	AdaptationOverlayView._res = res
	AdaptationOverlayView._gameObject = UnityEngine.GameObject.Instantiate(mainAsset)
	AdaptationOverlayView._upGo = goutil.findChild(AdaptationOverlayView._gameObject, "up")
	AdaptationOverlayView._downGo = goutil.findChild(AdaptationOverlayView._gameObject, "down")

	self:_updatePos()
	GlobalDispatcher:addListener(GlobalNotify.HardwareQualityChanged, self._updatePos, self)
end

function AdaptationOverlayView:_updatePos()
	local realHeight = 0

	if Framework.OSDef.RunOS == Framework.OSDef.Android then
		local tempWidth, tempHeight = SceneResolution.Instance:GetCurrentResolution(0, 0)

		realHeight = tempHeight

		printInfo("test AdaptationOverlayView分辨率数值Android：", CameraRectSetter.HeightRatio, tempWidth, tempHeight)
	elseif Framework.OSDef.RunOS == Framework.OSDef.IOS then
		realHeight = UnityEngine.Screen.height

		printInfo("test AdaptationOverlayView分辨率数值IOS：", CameraRectSetter.HeightRatio, UnityEngine.Screen.height)
	else
		realHeight = UnityEngine.Screen.height

		printInfo("test AdaptationOverlayView分辨率数值 编辑器状态下：", CameraRectSetter.HeightRatio, UnityEngine.Screen.height)
	end

	local height = CameraRectSetter.HeightRatio * realHeight

	Framework.TransformUtil.SetLocalPos(AdaptationOverlayView._upGo.transform, 0, height * 0.5, 0)
	Framework.TransformUtil.SetLocalPos(AdaptationOverlayView._downGo.transform, 0, -height * 0.5, 0)
end

return AdaptationOverlayView
